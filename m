Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296125CC75;
	Fri, 15 Aug 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248413; cv=none; b=oaZl3XVaIsGEYhzc9azSqBUIkCq88VLGcmqFqICfUjROi2u7btW9vKXfI4mozPmLTGCvDiA0jdHgod88i0wk5MI2EsOYHBxfxCc5tXIm3rLOYghyq9q3iWXcNdnboGp7X4jwDBEFDnVGogtI4q/gMsDOhK+hPNw+w9ikYH8dbt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248413; c=relaxed/simple;
	bh=ko3+9khrfOwQzVozVPDS3ipvQJBFL4FHR8kAzAUR5ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtD+sI+YE//2ioDAoOzctZ14NU0I2EkabPM7AM+iDLxOZcc7UrCG2I0QJFxbPrKg73GIt7dh/CoWEXpybkf7xYqaspYBC79UzQGgIP9S1yGKyBzltVfKNeDIr07AcQ4QzvjDv4QodTHpEUaj+q3CMCzwE0099wazp4fHH1Lel6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18FDD1E32;
	Fri, 15 Aug 2025 02:00:04 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D38593F63F;
	Fri, 15 Aug 2025 02:00:07 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Howells <dhowells@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH v2 1/8] arm64: kpkeys: Avoid unnecessary writes to POR_EL1
Date: Fri, 15 Aug 2025 09:59:53 +0100
Message-ID: <20250815090000.2182450-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815090000.2182450-1-kevin.brodsky@arm.com>
References: <20250815090000.2182450-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nested uses of kpkeys guards are about to be introduced, which means
that kpkeys_set_level() may not actually need to change the value of
POR_EL1. Since updating POR_EL1 requires an expensive ISB, let's
skip the write if the value is unchanged, by returning
KPKEYS_PKEY_REG_INVAL. This will cause the matching
kpkeys_restore_pkey_reg() call to bail out without calling
arch_kpkeys_restore_pkey_reg().

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 64d6e22740ec..70e21df84252 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -43,6 +43,9 @@ static __always_inline int arch_kpkeys_set_level(int level)
 	u64 prev_por = read_sysreg_s(SYS_POR_EL1);
 	u64 new_por = por_set_kpkeys_level(prev_por, level);
 
+	if (new_por == prev_por)
+		return KPKEYS_PKEY_REG_INVAL;
+
 	__kpkeys_set_pkey_reg_nosync(new_por);
 	isb();
 
-- 
2.47.0

