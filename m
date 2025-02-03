Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF592201024;
	Mon,  3 Feb 2025 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578514; cv=none; b=YjzUiiOm5RnY/RGff5nhbAnXwW43eOtXdCCC7C8WuGVr1oFQYKffPWxuMOz4zewL/0h3wPRd5q+VG8SuGG+LK8skoETLgwixL07UcVX6xFwUVs04C64DuOPBYA/jDBHLztDzTLff1b4Y9BqoAOE2P8ck2nUk58amr/oxtglNbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578514; c=relaxed/simple;
	bh=4qOVW/KcFCaGXByrUL1WyX+YL0wrt///CtDCqoENtaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLVHu7SG32pI3hfMpJgB6i/M6k3/zMIASBTrwPqGMJRJRJbgyXuZqpgeLNGdMWBYtBAfoBMQdMZBqS7nXRUGA2BMaXRQTLDiz8hWj9zk1dE0y+A9i5dIItGWKIeZwU1T22PVD4+dyFVLuKZSoXb9d33UTps2tJbephAV3YMdnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA49E1476;
	Mon,  3 Feb 2025 02:28:55 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5A13F63F;
	Mon,  3 Feb 2025 02:28:27 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Howells <dhowells@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH 1/8] arm64: kpkeys: Avoid unnecessary writes to POR_EL1
Date: Mon,  3 Feb 2025 10:28:02 +0000
Message-ID: <20250203102809.1223255-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250203102809.1223255-1-kevin.brodsky@arm.com>
References: <20250203102809.1223255-1-kevin.brodsky@arm.com>
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
 arch/arm64/include/asm/kpkeys.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 4854e1f3babd..3f16584d495a 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -27,8 +27,12 @@ static inline u64 por_set_kpkeys_level(u64 por, int level)
 static inline int arch_kpkeys_set_level(int level)
 {
 	u64 prev_por = read_sysreg_s(SYS_POR_EL1);
+	u64 new_por = por_set_kpkeys_level(prev_por, level);
 
-	write_sysreg_s(por_set_kpkeys_level(prev_por, level), SYS_POR_EL1);
+	if (new_por == prev_por)
+		return KPKEYS_PKEY_REG_INVAL;
+
+	write_sysreg_s(new_por, SYS_POR_EL1);
 	isb();
 
 	return prev_por;
-- 
2.47.0

