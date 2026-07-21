Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA2433BC7
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662536; cv=none; b=ZKgY6l99tTLk3jpwbfLfQrXW4yFSamw0EzLDAYpXdzoUoNwbH1YFZGEgZXcdXMTk7TtnksdWf+Ea9PFMouN5v6IG+KmM8wlDpFoopenkrBqWMXYKQOB08FGvGoG7cLvmncFy2Fo+QXE47Jxtl/Yp1vVz6vYhh7foHttcx3W+ezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662536; c=relaxed/simple;
	bh=WMEee5Kf6Zjn0/j9b5Fxn9SWD3muAaE7wsPsTXxKWiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK9g2Uo+JBFckpuA4fGCsCv7G18zL2u/WNgqQY2js9NvEluyQ6HTeqNxWFFZhABl9HU0pmQMOuskTfjq1dMGBFTXqiIugLrHiwGl5PMFXYBKfKrSjwLJtWnc4dT2mVDRWbPSzVXW/EyrAiiKKMKrFSViaJFiYZRo8Z+ndjUC3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=gogAStas; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="gogAStas"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49557167508so33789215e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1784662532; x=1785267332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNcK/Q+kt2SyUoOUHMTkociJrLEelUN7WicdMiTHpQ0=;
        b=gogAStasLn/1aD2fbQrQjKEHZ3DrzgvK6+/P6RHdCJeb1moJCddZg7keRCSKzadvap
         yZllEC2xrp1LqdqPEJhrb/OsM1aygl7jXqJcfxlGMJwDg9MXpsyu8R6nyWoR7l8TkHlb
         XgpJ/yuZFFwNEWKPH+63ntfIyMy5Il7N5WtatGMPmJg3zfErjYG/kARzM67RttpgwPF8
         rMqr6vq6Sc7XMBl+J6W59NuY+zrym6Zy7ZbckTg1OOmb9qVf2lhjjGYvqj2RAAKkYugK
         iP0D3IDLD7sAHPFw4MDt6/9u45fK4Zig19jJQI4341LRlA1bHNZ2ghftUGIIPePE3FfS
         HOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662532; x=1785267332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xNcK/Q+kt2SyUoOUHMTkociJrLEelUN7WicdMiTHpQ0=;
        b=YCp+F+7UdNY4Dn478oIFL73Qwy4jj6xGwh0gW/2Nxgj87ixhQ6EAypSCyvdcd3zhJE
         qcrcjYgg9YSAclHxYbz2e7jP0Xt+CBHPjC4n2UaibAMCsEQHSu7gD9Cdq9F31Da367HH
         eIZz6XlJQEM6aZrfdpFXKmQRFqpRxhDVbLkbybSI9CoiWy26+UShMV4cJoPfPTi52Y7V
         gap2EtIi8w66z7B/JO43t5iCuaOOiot2pjFVV5hcLS8hN/nUV5YYsieKpQ6jNRh4Vkgc
         nvimmRDBn+q6fJmKhZz4H4+tfRgeFyK2LEjfZ0TQUEal/lkzCEBVhWpedpulOQtLgExd
         6OGg==
X-Gm-Message-State: AOJu0YzEA5Ry/a+3ZQFkbkbxiBNR6jOQ8i/eKZlYL9E7/b4LGxiBlbq1
	OMNWQ6jLLCoBFm11tqoAxSGxpzS36EZIQzYjRvktF6WGqSA2d8YpZAlqOvf1WuajTNoHDouCJiF
	PxrS5x8me
X-Gm-Gg: AfdE7ckOTUddQWKhZR9wCXeTr3ho5IYvzVQwWCnfOtFFAlIT6V1dGAlYA9FgcPovyeq
	ClTCGdqW7cvuSvVupaba69ZA5v0EZyhQZX8YxdIozi9Mdgco0rXtHlgpoNU+D1hU5kSFTo/4pzc
	+hBxHCIsM8mH888zRhjZQSxsqnHiJmqKqauWoQ03uHgev4G8lAgqbly7uCrXY5HC8BUK2HVYncS
	6FRCISupm304LsruZwzdFj0BO/pGeL3XRDH7Q6AiCR3HYjg6TulnN9YRG/DSw8a5sWrRGnmgJr5
	1O9DXTt86So32WBWeMhxHHYTaCPj91dvWKh6P7MsV6oY7RfnOrQr89fibejZ4aNlZbHi1jwjF4i
	p7UHItFx3e4FSkD/nR9+8GkYY0ZyQM1UKcqXEVGKlzSHKxiABysIwqqdaag8Zrzs/PEJNhyD8W0
	ZFjwoizZwucvCwktQz6JYVX82L0sx40yBosg0tN/3jgWfMOZEX4WN7zWQoIbaEQ0wDhg5o/YVoN
	VllDJn1JsiFRW3kXuU=
X-Received: by 2002:a05:600c:b85:b0:495:5365:c0d1 with SMTP id 5b1f17b1804b1-49553d85ea0mr177931935e9.14.1784662532270;
        Tue, 21 Jul 2026 12:35:32 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00a6ccab16241b6894.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:a6cc:ab16:241b:6894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c9d99sm91835425e9.12.2026.07.21.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:35:32 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org,
	gregkh@linuxfoundation.org
Subject: [RFC v3 5/5] Tasklist sample module
Date: Tue, 21 Jul 2026 21:35:31 +0200
Message-ID: <20260721193531.46699-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720191333.21652-1-yjn@yjn-systems.com>
References: <20260720191333.21652-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reposting this patch with a proper commit message following Greg's
comment. No functional changes.

This patch adds the Tasklist sample module for Bootpatch-SLR. Building
it requires setting CONFIG_SAMPLE_SPSLR_TASKLIST and CONFIG_SAMPLES and
CONFIG_SAMPLES_SPSLR.

The module provides a simple end-to-end demonstration of Bootpatch-SLR.
When loaded, it prints the apparent offsets of several task_struct
fields using ordinary offsetof() expressions. Pinpoint turns the
underlying constants into instruction pins, allowing Selfpatch to
rewrite them to the offsets in the randomized layout. The printed values
therefore reflect the randomized layout selected at boot. The module
then walks the task list using the randomized offsets, demonstrating
that both the kernel and the module have been patched consistently.

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

