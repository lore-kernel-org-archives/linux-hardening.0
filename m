Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97A392822
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574818; cv=none; b=WOLPGgT/cDTWg/xrDUlV7tPcXlp0YqTX1LdWLLZSX4Zpllwe/guAyqlZ393L7TTRiPFKWpoI2mT8cEHZTSNH2q5jsB1EV25rhJRWQGWclBdOw+uBtFFwjKqB2S8KMUj2k17GKEJBM+BL+sC1OYz8/5rKzPV2RmL2c/RZwf2bRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574818; c=relaxed/simple;
	bh=VfOO6+7jMgNXfdsgzDu2gHlwmZ6txpGn5eOFifRinEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLVgJ8TODePnf2mLrB9PvmXmvrvcbkIhXn0YV7sIbrIEOUfMaFr+pdqgwpb+etx7b81bOQlYuirJM2uyW1WCq+6L4f8PoAH1RU+q961+zFNCujXG75T+Eyjyogojz5ESRITgV4Q0plD2rBnC5j8J2fJJR5zWVHWRe0hD9inzM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=K4LGom7J; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="K4LGom7J"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f71156e1aso917297f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1784574814; x=1785179614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HKAwADsjpeI6vXR3CdbOrXgFYwbzM256tbPggd8eZ0=;
        b=K4LGom7JW7Yrlmhsksg0IHpw8G1Qvrd82rIq8mU3UoqlkBj6SelZjnRKjVwZyWoxhP
         H9hVzhCfRcffORXyGc7I7zSWevV4uw9cXjC8Y3+7MeH7uTZIqsmYg23qZV429Ov9CYR9
         a5me4lO89Wpu8zU5AVvCFpkmG31pAkZI9dnpLrjhauPd/qgUcL9GyoiUOQxRguMq4biZ
         ExBFV0tV/SqwurzfuxGzU8ZYHhIwTdOoCKGxVtN2AX2+2e7khdhsviRndWQIUgYgKCOn
         NztzP2zbnY0+YwSrBoxLXGrBztckWLDbcm/wg3UclZZ1ZZ1BTqqP4eOfrbriYu/GnMWk
         MF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574814; x=1785179614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HKAwADsjpeI6vXR3CdbOrXgFYwbzM256tbPggd8eZ0=;
        b=k/GigpMhOqesOCGp2jKRWy1OK4aN44RuHCu40rov+mprm1W/u0N6HyqrEcPjZTRRvP
         pmVsg9CKBwsbH/9WR4KCNkm5nMwNRNskrUk/J0G1RXaL1oYYS6UFwJmfWX+gNMowpy7w
         o5gazeh71XzgYeIfs5GpNL1PspAzfMbUOEGUBcLGboHaCV62csgcMkX0fNHL3PWXCUcc
         n7V/lMazwXqM8MvbiNqcM9ChrcJ2KNj2md8nQfZj1ZVhF4MivACGiO7D+ZpzfuQUXhFY
         MkFoBGu3oe3u28Ppj1yleZEp25eAw6hkRnEaH5JkQ6Tr+yC43V+oIee9y0u/bGl9iRPj
         sVRg==
X-Gm-Message-State: AOJu0YyisDs5HkpoJGeUPukBctRtUi/8hGJuAYXVTg8M+XyAj0K49ZhR
	+LTY24D0tIabyu4+CSsk1zEJZmUuLS1BZNn+iCW4Fc3LPL75dBQNezA5D0YwT8XVFx48s2zzOYz
	E2Ycb3Q==
X-Gm-Gg: AR+sD138LkEntGjOr7Tm2oHkLTe/SVBpIfNFllGcPO8ecMXpgv0agI9EotuIS9UXJLz
	isayZ49xGENEP8/eAWX0Vfj7XI9LmkCXKvrb9We3kGdtXrkK5yX/tNsWN+05MAvRneRJL9WUJhG
	4Uqe5/xNbFNXdGZwcjH0eGgB+Yqccmye62KQi39499KVT1zg+RR1o+3Ww4i9w1bj+hTnZwPKeoN
	G7AfJQELJzwX8ztHMhUgZwz03zECcvP7xmDFC6J6ngmT1G3+dfQCzceFz2N3VSa0gT4t8CeRvoi
	2V4mftmIJcjETBDpZ3W2qc2DF7p5GhO1poUgJv2Ul8WlekDITnD74AijZsA+svpYd6+BLOI7kEt
	vXvqxyQtGpJ4TXi89fXYjZgRW9uXCfbb8k12BDstSvT9eUs6bwsLVqieqZ7Il1b8lnFJhwdx1xX
	/JII/lb45WGSLuFRTVdDpgdIwujV8uR+RziJMXJiwSw2QUb3yekMEiimZqSgit63lsWdwsIXHuQ
	6fhmBPBbliuAweo5Tg=
X-Received: by 2002:a05:6000:1ac9:b0:47f:4ac9:98bc with SMTP id ffacd0b85a97d-47f6230dc51mr19072366f8f.24.1784574814520;
        Mon, 20 Jul 2026 12:13:34 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00c9c364f8ed993120.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:c9c3:64f8:ed99:3120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7ea1sm33396206f8f.24.2026.07.20.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:13:34 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v3 5/5] Tasklist sample module
Date: Mon, 20 Jul 2026 21:13:33 +0200
Message-ID: <20260720191333.21652-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720191146.21473-1-yjn@yjn-systems.com>
References: <20260720191146.21473-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 samples/Kconfig                   |  3 ++
 samples/Makefile                  |  1 +
 samples/spslr/Kconfig             | 17 ++++++++
 samples/spslr/Makefile            |  1 +
 samples/spslr/tasklist/Makefile   |  1 +
 samples/spslr/tasklist/tasklist.c | 67 +++++++++++++++++++++++++++++++
 6 files changed, 90 insertions(+)
 create mode 100644 samples/spslr/Kconfig
 create mode 100644 samples/spslr/Makefile
 create mode 100644 samples/spslr/tasklist/Makefile
 create mode 100644 samples/spslr/tasklist/tasklist.c

diff --git a/samples/Kconfig b/samples/Kconfig
index a75e8e78330d..8925820617c9 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -326,6 +326,8 @@ source "samples/rust/Kconfig"
 
 source "samples/damon/Kconfig"
 
+source "samples/spslr/Kconfig"
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
@@ -333,3 +335,4 @@ config HAVE_SAMPLE_FTRACE_DIRECT
 
 config HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	bool
+
diff --git a/samples/Makefile b/samples/Makefile
index 07641e177bd8..1b727ceb2efa 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_MTIER)	+= damon/
 obj-$(CONFIG_SAMPLE_HUNG_TASK)		+= hung_task/
 obj-$(CONFIG_SAMPLE_TSM_MR)		+= tsm-mr/
+obj-$(CONFIG_SAMPLES_SPSLR)		+= spslr/
diff --git a/samples/spslr/Kconfig b/samples/spslr/Kconfig
new file mode 100644
index 000000000000..ba163ea15006
--- /dev/null
+++ b/samples/spslr/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig SAMPLES_SPSLR
+	bool "SPSLR samples"
+	depends on SPSLR
+	help
+	  You can build sample SPSLR kernel code here.
+
+	  If unsure, say N.
+
+if SAMPLES_SPSLR
+
+config SAMPLE_SPSLR_TASKLIST
+	tristate "SPSLR tasklist module example"
+	depends on m
+
+endif # SAMPLES_SPSLR
diff --git a/samples/spslr/Makefile b/samples/spslr/Makefile
new file mode 100644
index 000000000000..2d330b105c95
--- /dev/null
+++ b/samples/spslr/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SAMPLE_SPSLR_TASKLIST) += tasklist/
diff --git a/samples/spslr/tasklist/Makefile b/samples/spslr/tasklist/Makefile
new file mode 100644
index 000000000000..6a5bc5b29b34
--- /dev/null
+++ b/samples/spslr/tasklist/Makefile
@@ -0,0 +1 @@
+obj-m += tasklist.o
diff --git a/samples/spslr/tasklist/tasklist.c b/samples/spslr/tasklist/tasklist.c
new file mode 100644
index 000000000000..ea021742c8e9
--- /dev/null
+++ b/samples/spslr/tasklist/tasklist.c
@@ -0,0 +1,67 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
+#include <linux/cred.h>
+#include <linux/uidgid.h>
+#include <linux/module.h>
+#include <linux/list.h>
+
+static const struct task_struct module_target_data = { .flags = 42 };
+
+static int __init taskinfo_init(void)
+{
+    struct task_struct *p;
+
+    pr_info("taskinfo: loaded\n");
+    pr_info("    offsetof(task_struct, pid)=%zu\n", offsetof(struct task_struct, pid));
+    pr_info("    offsetof(task_struct, tgid)=%zu\n", offsetof(struct task_struct, tgid));
+    pr_info("    offsetof(task_struct, cred)=%zu\n", offsetof(struct task_struct, cred));
+    pr_info("    offsetof(task_struct, real_parent)=%zu\n", offsetof(struct task_struct, real_parent));
+    pr_info("    offsetof(task_struct, comm)=%zu\n", offsetof(struct task_struct, comm));
+    pr_info("    offsetof(task_struct, __state)=%zu\n", offsetof(struct task_struct, __state));
+    pr_info("    offsetof(task_struct, flags)=%zu\n", offsetof(struct task_struct, flags));
+    pr_info("    offsetof(task_struct, prio)=%zu\n", offsetof(struct task_struct, prio));
+    pr_info("    offsetof(task_struct, policy)=%zu\n", offsetof(struct task_struct, policy));
+
+    pr_info("datapin flags value is %u (should be 42)\n", module_target_data.flags);
+
+    pr_info("=== Task List ===\n");
+
+    rcu_read_lock();
+
+    for_each_process(p) {
+        const struct cred *cred;
+        struct task_struct *parent;
+
+        cred = rcu_dereference(p->cred);
+        parent = rcu_dereference(p->real_parent);
+
+        pr_info("task: pid=%d tgid=%d ppid=%d uid=%u gid=%u comm=%s state=%u flags=0x%x prio=%d policy=%u\n",
+                p->pid,
+                p->tgid,
+                parent ? parent->tgid : -1,
+                __kuid_val(cred->uid),
+                __kgid_val(cred->gid),
+                p->comm,
+                READ_ONCE(p->__state),
+                p->flags,
+                p->prio,
+                p->policy);
+    }
+
+    rcu_read_unlock();
+
+    return 0;
+}
+
+static void __exit taskinfo_exit(void)
+{
+    pr_info("taskinfo: unloaded\n");
+}
+
+module_init(taskinfo_init);
+module_exit(taskinfo_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("List modules and tasks (task_struct stress)");
-- 
2.43.0

