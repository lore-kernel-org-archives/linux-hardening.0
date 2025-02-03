Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC412036EC;
	Mon,  3 Feb 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578525; cv=none; b=VJniR0HnCcmWpdVQHRBa/k40Vo5YNHaxdxAMfaNR3Jdb8XvRe9GoyFaCLFTV9eDhAROH/vvit1fCfpyi/FGE0Rk8LctZ4Snaf1vOsRrIy/hoB699rD/J5QE38JkiwCygp8ttD4OnZEg2GVcBGowZIOq0axD3iBp+63noApt4Zc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578525; c=relaxed/simple;
	bh=S9yJyN9N7H7JzCwI0gHoJY1ttsJaz7v8XofW/66lR0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoXBqCMAinaHTpeG8yc3VhooQf0zMTRBesERuV9HOvHRKoUoYYDYtl/q7/qvNwId1RfVHAG+Qs3V7jBo9z8shZ2wBqZ1ioBOHI6s3PAkkYyZWbvnBZVQRJs1IAbH47nqCaD4vsSK/TUU/JNMHDDv1y7pzoEEl5dat+4wh+uV/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 128781BA8;
	Mon,  3 Feb 2025 02:29:08 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8CF83F63F;
	Mon,  3 Feb 2025 02:28:39 -0800 (PST)
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
Subject: [RFC PATCH 4/8] rcu: Allow processing kpkeys-protected data
Date: Mon,  3 Feb 2025 10:28:05 +0000
Message-ID: <20250203102809.1223255-5-kevin.brodsky@arm.com>
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

Data assigned a non-default pkey is not writable at the default
kpkeys level. If such data is managed via RCU, some mechanism is
required to temporarily grant write access to the data's struct
rcu_head, for instance when zeroing the callback pointer.

There is unfortunately no straightforward way for RCU to know
whether the managed data is mapped with a non-default pkey. This
patch takes the easy route and switches to the unrestricted kpkeys
level whenever struct rcu_head is written; this should work reliably
but it is clearly suboptimal. That behaviour is enabled by
selecting CONFIG_KPKEYS_UNRESTRICTED_RCU.

This patch isn't comprehensive, in particular it does not take care
of Tiny RCU.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/kpkeys.h     |  6 ++++++
 kernel/rcu/rcu_segcblist.c | 10 +++++++---
 kernel/rcu/tree.c          |  4 +++-
 mm/Kconfig                 |  2 ++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index 9d9feec83ccf..c5d804c1ab7b 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -154,4 +154,10 @@ static inline void kpkeys_hardened_pgtables_enable(void) {}
 
 #endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
 
+#ifdef CONFIG_KPKEYS_UNRESTRICTED_RCU
+KPKEYS_GUARD(kpkeys_rcu, KPKEYS_LVL_UNRESTRICTED)
+#else
+KPKEYS_GUARD_NOOP(kpkeys_rcu)
+#endif
+
 #endif /* _LINUX_KPKEYS_H */
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 298a2c573f02..a9b5552b53a5 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/kpkeys.h>
 
 #include "rcu_segcblist.h"
 
@@ -332,7 +333,8 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 	rcu_segcblist_inc_len(rsclp);
 	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	rhp->next = NULL;
-	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
+	scoped_guard(kpkeys_rcu)
+		WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
 }
 
@@ -381,7 +383,8 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
-	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
+	scoped_guard(kpkeys_rcu)
+		WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
 	rclp->tail = rsclp->tails[RCU_DONE_TAIL];
 	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
@@ -436,7 +439,8 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 	if (!rclp->head)
 		return; /* No callbacks to move. */
 	rcu_segcblist_add_seglen(rsclp, RCU_DONE_TAIL, rclp->len);
-	*rclp->tail = rsclp->head;
+	scoped_guard(kpkeys_rcu)
+		*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, rclp->head);
 	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
 		if (&rsclp->head == rsclp->tails[i])
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 475f31deed14..48d9d14a2af6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -64,6 +64,7 @@
 #include <linux/mm.h>
 #include <linux/kasan.h>
 #include <linux/context_tracking.h>
+#include <linux/kpkeys.h>
 #include "../time/tick-internal.h"
 
 #include "tree.h"
@@ -2542,7 +2543,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		f = rhp->func;
 		debug_rcu_head_callback(rhp);
-		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
+		scoped_guard(kpkeys_rcu)
+			WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
 		f(rhp);
 
 		rcu_lock_release(&rcu_callback_map);
diff --git a/mm/Kconfig b/mm/Kconfig
index 2a8ebe780e64..e2671c57e047 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1152,6 +1152,8 @@ config ARCH_HAS_KPKEYS
 # ARCH_HAS_KPKEYS must be selected when selecting this option
 config ARCH_HAS_KPKEYS_HARDENED_PGTABLES
 	bool
+config KPKEYS_UNRESTRICTED_RCU
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool
-- 
2.47.0

