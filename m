Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0A72701DA;
	Fri, 15 Aug 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248428; cv=none; b=TwU5RDEdxBBiheD3mXUDiFquO7tNcL4OMLO/bBAknlMD1Pfci2K8BW2hPiuB1a8CaqV7M0Yn8qa5RPUZ72IbItDR1Uq1SlKOJD54XrAPiNmCo9zFWo5IXMHhoodxsb2WA23gNKhQvUrtvh+oqa73noFWzoxteIq6hQmBKgIGPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248428; c=relaxed/simple;
	bh=3DqzR4RysG4uEXoDRVuAQmNC/sAC367RgTRLeXOmfCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6F73Z+yV4j7ryYIlBWRdfiUk7D8TeaN2pPDZDvPnRcAVDemyBmC+vY/iNuBwMzcoralqu412Js/MS1KiMl8c+HyfhjjOQ3sZcQZNHeLlRz34ggzpGAnGjmKTK+pXree6EtvSqnKmXSz89Val4Zn3dJOoUOm4dPiUDgpuXvpnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 614402C41;
	Fri, 15 Aug 2025 02:00:18 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 283233F63F;
	Fri, 15 Aug 2025 02:00:22 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/8] rcu: Allow processing kpkeys-protected data
Date: Fri, 15 Aug 2025 09:59:56 +0100
Message-ID: <20250815090000.2182450-5-kevin.brodsky@arm.com>
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
 kernel/rcu/rcu.h           |  7 +++++++
 kernel/rcu/rcu_segcblist.c | 13 +++++++++----
 kernel/rcu/tree.c          |  3 ++-
 mm/Kconfig                 |  2 ++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9cf01832a6c3..71e9a695f4eb 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_RCU_H
 #define __LINUX_RCU_H
 
+#include <linux/kpkeys.h>
 #include <linux/slab.h>
 #include <trace/events/rcu.h>
 
@@ -691,4 +692,10 @@ int rcu_stall_notifier_call_chain(unsigned long val, void *v);
 static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { return NOTIFY_DONE; }
 #endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
+#ifdef CONFIG_KPKEYS_UNRESTRICTED_RCU
+KPKEYS_GUARD(kpkeys_rcu, KPKEYS_LVL_UNRESTRICTED)
+#else
+KPKEYS_GUARD_NOOP(kpkeys_rcu)
+#endif
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 298a2c573f02..e7d6c8370b70 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
+#include "rcu.h"
 #include "rcu_segcblist.h"
 
 /* Initialize simple callback list. */
@@ -332,7 +333,8 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 	rcu_segcblist_inc_len(rsclp);
 	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	rhp->next = NULL;
-	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
+	scoped_guard(kpkeys_rcu)
+		WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
 }
 
@@ -360,7 +362,8 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 		if (!rcu_segcblist_segempty(rsclp, i))
 			break;
 	rcu_segcblist_inc_seglen(rsclp, i);
-	WRITE_ONCE(*rsclp->tails[i], rhp);
+	scoped_guard(kpkeys_rcu)
+		WRITE_ONCE(*rsclp->tails[i], rhp);
 	for (; i <= RCU_NEXT_TAIL; i++)
 		WRITE_ONCE(rsclp->tails[i], &rhp->next);
 	return true;
@@ -381,7 +384,8 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
-	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
+	scoped_guard(kpkeys_rcu)
+		WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
 	rclp->tail = rsclp->tails[RCU_DONE_TAIL];
 	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
@@ -436,7 +440,8 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
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
index 174ee243b349..2eada18c04d5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2601,7 +2601,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		f = rhp->func;
 		debug_rcu_head_callback(rhp);
-		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
+		scoped_guard(kpkeys_rcu)
+			WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
 		f(rhp);
 
 		rcu_lock_release(&rcu_callback_map);
diff --git a/mm/Kconfig b/mm/Kconfig
index e34edf5c41e7..c023f74a2201 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1178,6 +1178,8 @@ config ARCH_HAS_KPKEYS
 # ARCH_HAS_KPKEYS must be selected when selecting this option
 config ARCH_HAS_KPKEYS_HARDENED_PGTABLES
 	bool
+config KPKEYS_UNRESTRICTED_RCU
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool
-- 
2.47.0

