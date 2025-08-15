Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9884026056D;
	Fri, 15 Aug 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248422; cv=none; b=T2E1CkIWW4NkHy/AczmOBksvTAmU4XJHMiQE9atgTW2KIMIFflDrfwRMsYShZ30oAsjnaTaeif7L/pl4UAbet61qPaw9S9sgCGxVMvf7p5ISBMy7pOKm8aIgYdx/Q2rWxvXisjN4NbeB5OVzqz1ISYasXU/7ahH0x3Dn3uNfxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248422; c=relaxed/simple;
	bh=oRYJGYT7GhTfO6Vb9BBb5JQJjgYK/sMCj3mh0C+ZpFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwfHrg+pv3HbSgKyShAR/Wbi0hG0frAFsan5HqbgVEIgNtsjzVd0xRR4fMF3HCsM1+r4BdAQYl3FTr9Vvv4xChhESgK5QNBvbTYS2YzOCaqNH6BYUF+Jx5CPsXIplWssKE/3T1Ed+yFHJLlI78VbMNx0FOqUCwzya+KdR+FiTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C51341E5E;
	Fri, 15 Aug 2025 02:00:08 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EE173F63F;
	Fri, 15 Aug 2025 02:00:12 -0700 (PDT)
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
Subject: [RFC PATCH v2 2/8] mm: kpkeys: Introduce unrestricted level
Date: Fri, 15 Aug 2025 09:59:54 +0100
Message-ID: <20250815090000.2182450-3-kevin.brodsky@arm.com>
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

Highly privileged components, such as allocators, may require write
access to arbitrary data. To that end, introduce a kpkeys level that
grants write access to all kpkeys.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 4 +++-
 include/linux/kpkeys.h          | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 70e21df84252..ded5d6e988dc 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -28,7 +28,9 @@ static inline u64 por_set_kpkeys_level(u64 por, int level)
 {
 	por = por_elx_set_pkey_perms(por, KPKEYS_PKEY_DEFAULT, POE_RWX);
 	por = por_elx_set_pkey_perms(por, KPKEYS_PKEY_PGTABLES,
-				     level == KPKEYS_LVL_PGTABLES ? POE_RW : POE_R);
+				     level == KPKEYS_LVL_PGTABLES ||
+				     level == KPKEYS_LVL_UNRESTRICTED
+				     ? POE_RW : POE_R);
 
 	return por;
 }
diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index 5f4b096374ba..48f240bea8e1 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -10,9 +10,10 @@ struct folio;
 
 #define KPKEYS_LVL_DEFAULT	0
 #define KPKEYS_LVL_PGTABLES	1
+#define KPKEYS_LVL_UNRESTRICTED	2
 
 #define KPKEYS_LVL_MIN		KPKEYS_LVL_DEFAULT
-#define KPKEYS_LVL_MAX		KPKEYS_LVL_PGTABLES
+#define KPKEYS_LVL_MAX		KPKEYS_LVL_UNRESTRICTED
 
 #define __KPKEYS_GUARD(name, set_level, restore_pkey_reg, set_arg, ...)	\
 	__DEFINE_CLASS_IS_CONDITIONAL(name, false);			\
-- 
2.47.0

