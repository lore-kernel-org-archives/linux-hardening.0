Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C491203707;
	Mon,  3 Feb 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578529; cv=none; b=TaRtkiCqXe+SNXrV7UwMMTsSZgwqALKkIyqwinNnOHoW6fVEk7cIKT+bbEE1DHtEogaleaAs/sPs7aGcRPIUG3zibp4aM4KOJ71RN+lbBkbwoKDaVxN5kJqFlLgyMASWDsg1fyFCC+6kscT97J3tV75VdhNXNSFn+ooPKB9e2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578529; c=relaxed/simple;
	bh=sQHQVt43LDDA9y+CvFHUAOYQF1zwDuRnYWVCJ9qVOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb6KSjCcJP1SDNXKy6NZcjN92rWHu3WiO7F71B8qta0af2x1cwq9Tf/JqxlWh3XPbbotgeo+OWBuRxEWMxEViHslwPOym5g9u+8LC8iS6/UKyDljeUXiDffwBcA115XWPIMbCf3eowCBeHe2AnxKLUwyVSg/ugzn++R1OFoTzyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23BF31BB0;
	Mon,  3 Feb 2025 02:29:12 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99793F63F;
	Mon,  3 Feb 2025 02:28:43 -0800 (PST)
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
Subject: [RFC PATCH 5/8] mm: kpkeys: Introduce cred pkey/level
Date: Mon,  3 Feb 2025 10:28:06 +0000
Message-ID: <20250203102809.1223255-6-kevin.brodsky@arm.com>
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

We will need a separate pkey to protect struct cred. Allocate one as
well as a new kpkeys level that grants write access to that pkey,
and add a guard that switches to that level.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 4 ++++
 include/asm-generic/kpkeys.h    | 4 ++++
 include/linux/kpkeys.h          | 9 ++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index ab2305ca24b7..f5797e579fb9 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -22,6 +22,10 @@ static inline u64 por_set_kpkeys_level(u64 por, int level)
 				 level == KPKEYS_LVL_PGTABLES ||
 				 level == KPKEYS_LVL_UNRESTRICTED
 				 ? POE_RW : POE_R);
+	por = por_set_pkey_perms(por, KPKEYS_PKEY_CRED,
+				 level == KPKEYS_LVL_CRED ||
+				 level == KPKEYS_LVL_UNRESTRICTED
+				 ? POE_RW : POE_R);
 
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
index c5d804c1ab7b..a478eaf2e14f 100644
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
@@ -160,4 +161,10 @@ KPKEYS_GUARD(kpkeys_rcu, KPKEYS_LVL_UNRESTRICTED)
 KPKEYS_GUARD_NOOP(kpkeys_rcu)
 #endif
 
+#ifdef CONFIG_KPKEYS_HARDENED_CRED
+KPKEYS_GUARD(kpkeys_hardened_cred, KPKEYS_LVL_CRED)
+#else
+KPKEYS_GUARD_NOOP(kpkeys_hardened_cred)
+#endif
+
 #endif /* _LINUX_KPKEYS_H */
-- 
2.47.0

