Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF686265CB2;
	Fri, 15 Aug 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248433; cv=none; b=EaKITHAAtI1DOhDS7cxhFH+sploK15ig301QFVR58pCEZ8EWD7/MXxt5u87i5qPaotNHtpX2hghBJjv+pgxEoj0hjS8KqpJiSAnFNRGmP5ZjUtlVZw0eIlP4MqbUTccN0VU362MhS4mN90VvEE8T+iHqFhciv0xq43KAABkhMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248433; c=relaxed/simple;
	bh=m/5CGff6IdcBeFe4D1gj4vmKsG9NpC3ew0deQKHJII0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyssWOl6k+ZMhB80oVBa7uycS3OiRGbL1Jmy3p41aAq7sst2F7EMbVd3mNzV5ZsAB4s1vrxRJw1Sfvu8JkBH3naybCCwA/yL6hD1k5lpFPRPmK38iSgXFVLDjAsgKYxaTF48RrDLP0DQIJvhkffySZ+Bw1lLD0YoO0IqIzlgYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A53D2C42;
	Fri, 15 Aug 2025 02:00:23 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78FF3F63F;
	Fri, 15 Aug 2025 02:00:26 -0700 (PDT)
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
Subject: [RFC PATCH v2 5/8] mm: kpkeys: Introduce cred pkey/level
Date: Fri, 15 Aug 2025 09:59:57 +0100
Message-ID: <20250815090000.2182450-6-kevin.brodsky@arm.com>
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

We will need a separate pkey to protect struct cred. Allocate one as
well as a new kpkeys level that grants write access to that pkey.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 7 ++++++-
 include/asm-generic/kpkeys.h    | 4 ++++
 include/linux/kpkeys.h          | 3 ++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index ded5d6e988dc..ffb7622391c3 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -13,7 +13,8 @@
  * used in assembly.
  */
 #define POR_EL1_INIT	(POR_ELx_PERM_PREP(KPKEYS_PKEY_DEFAULT, POE_RWX) | \
-			 POR_ELx_PERM_PREP(KPKEYS_PKEY_PGTABLES, POE_R))
+			 POR_ELx_PERM_PREP(KPKEYS_PKEY_PGTABLES, POE_R) | \
+			 POR_ELx_PERM_PREP(KPKEYS_PKEY_CRED, POE_R))
 
 #ifndef __ASSEMBLY__
 
@@ -31,6 +32,10 @@ static inline u64 por_set_kpkeys_level(u64 por, int level)
 				     level == KPKEYS_LVL_PGTABLES ||
 				     level == KPKEYS_LVL_UNRESTRICTED
 				     ? POE_RW : POE_R);
+	por = por_elx_set_pkey_perms(por, KPKEYS_PKEY_CRED,
+				     level == KPKEYS_LVL_CRED ||
+				     level == KPKEYS_LVL_UNRESTRICTED
+				     ? POE_RW : POE_R);
 
 	return por;
 }
diff --git a/include/asm-generic/kpkeys.h b/include/asm-generic/kpkeys.h
index cec92334a9f3..56a2fc9fe4a6 100644
--- a/include/asm-generic/kpkeys.h
+++ b/include/asm-generic/kpkeys.h
@@ -2,6 +2,10 @@
 #ifndef __ASM_GENERIC_KPKEYS_H
 #define __ASM_GENERIC_KPKEYS_H
 
+#ifndef KPKEYS_PKEY_CRED
+#define KPKEYS_PKEY_CRED	2
+#endif
+
 #ifndef KPKEYS_PKEY_PGTABLES
 #define KPKEYS_PKEY_PGTABLES	1
 #endif
diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index 48f240bea8e1..0e555b505b33 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -10,7 +10,8 @@ struct folio;
 
 #define KPKEYS_LVL_DEFAULT	0
 #define KPKEYS_LVL_PGTABLES	1
-#define KPKEYS_LVL_UNRESTRICTED	2
+#define KPKEYS_LVL_CRED		2
+#define KPKEYS_LVL_UNRESTRICTED	3
 
 #define KPKEYS_LVL_MIN		KPKEYS_LVL_DEFAULT
 #define KPKEYS_LVL_MAX		KPKEYS_LVL_UNRESTRICTED
-- 
2.47.0

