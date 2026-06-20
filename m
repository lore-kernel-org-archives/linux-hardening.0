Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEDE2BB17
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962685; cv=none; b=BG0ySO5YQiGz5JGs0IHCiOJOc8xeIbTAF6hi6jDMQNZeqmJPGZF/9VQPHMHz/8dUnU5c0TU6qBjJ8CMY2yNkWPGzV2kV+uy1WLBPowjFjuvpJelf2f7j93JbxBlFMltENgRp7YZ7TuHTVQHEmYpcKIpAUJ3PCkn5JDLogj7PmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962685; c=relaxed/simple;
	bh=BsWkxYsMjFdJrphcdXp3LPZeb796/rhzcLRmAvILGaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxmSfGIxz5nqLky73MWQdYDBPdmJV0mnfYe7RgdWMVnmRxfg81NpdAd6KY1GlEFcGYSDASCHY1Z0lO5nu6TYNAhkoE8Mw6wJz3/o3yI/0luNi8AgNA+/CeIohZLd4ZFDy7+mDXyO1cUJ7tMPowoEaISa6mw2oQCd0Lw/2VsUOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=TXBqod5p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="TXBqod5p"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49249072f03so3187815e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1781962682; x=1782567482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bROCg0PtaSsVbsAngXNWwKwnD4CIDDBJ/nMxI8sRfUo=;
        b=TXBqod5pOtzf9BOdt62yotXHpqvx+pmM4Bqi3BL05jqL/s86gHdJOGx8d6+qDstSbU
         kDox5SXufYi96TeVoU09ALgaJpJXP5HGbnSDixqBFlNyyvbBWdVn4TpjjkQpct2PVTRD
         yNpXCzjWSCpUpY62n4q9xm23boFCXGKfh0g3mq/5dwiJjiQh+v+4YBsKQqzLFXDJ73tc
         geyCsWi7IhBC4DcV16QmQ8soBwtb4BK5/QF4c7Fh1cfkS/+Z+Gz2i8EB6MrEv2nZ48vy
         R11i6EnarbsRsW9x/K9NtoEJsANTp/UmKupWwWuIGE+saw1weNh3OHiN8x2KWOSxZO+x
         rkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962682; x=1782567482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bROCg0PtaSsVbsAngXNWwKwnD4CIDDBJ/nMxI8sRfUo=;
        b=V83hozol321fbY2tGOlgcyPyQfdfz4Byc/QyJyUsPYHGhzgIUvDfD2ENI3uk6yngIA
         uAu6hbDzfvwEGRFsqBM9hYFaW0UnxdRsZN1EOqw68LC/QvGFaWZgrl/cbrR5HOJfPs8t
         Jp1E3n9rCSNZ2BlgimH5ct/blUJ/AD6SLA/oix4uj7846Fg8k3cqwifdM70my6JvMnjk
         CCrkUdqjwwBU4XWH3t/wRGtUO5GFhgpX6Gavi4bkuJTlrUqTFSzj8Q83XNlh9MEHfNfh
         BngnFrrzLurTKn5O1TQf6Y3sK/nBJOpwQZtbs6BYsCZWvOOPdiuzMkRV78U+TzjbbWB4
         76Gw==
X-Gm-Message-State: AOJu0YzHseln/tjEOWSTI6/77yq172kmymQtuBj9WsPCB6uURsa0FMfV
	csI5FZSiu3Dw6tracjloY/PIQQXpxHMdJA2z+eIPaGz6Fv+6Ysk3xlh6/FJQjMuU0UPjqV+tOzF
	Pq9ONbA==
X-Gm-Gg: AfdE7cnSOSjim212Tn5F+Q5pU3D+HM8qN5V92t4X3FG8jI6C+9Xp4V64ETUVi/VHzGg
	79kNvCvvCVOOQjuBgET3RMVKNuZfjmbDH4CaIikrNSMDEFmasW6A6NzLS8PbhRWQfZUeuoZecpp
	MsWRpKk7pziv5PRVPKsr5CbW9J1oMnuLEoCcsn79FDi6+jOzn6AIgykcML2n1CMHVw8O5gzLx/D
	vCyMbn8t0ftf7f4AHVD3e61QYvXSwsrxm5PtK0ucBJ2LGIy16RkAK4rCPsgEORzFaxi5Ja1daUT
	UBMezMrPyEil74DkqS3A7/rJJiaQI3OPd33NOYXe/5VkQAzaq867iAwLG52RaNM+PJsMLsT5NI/
	s7PUXYESg6EUyVX5tgqW85LkLLiiJNOtKrCRmTLF43rTfNAR7KfhAwdPm8LROjolxlh3Na56Cw7
	zrnFggourHBKWoDe3zqxF8u1hFyfY6u7VLq1WE1U5DEKqIw3U3jnw8/765sjEhAUo/+U7bdrgpw
	RPwNfVXHDdEAyQHOvktgqIHZWbK1Jd8cZvOgvs=
X-Received: by 2002:a05:600c:154a:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-4923f594ca9mr128287825e9.34.1781962681800;
        Sat, 20 Jun 2026 06:38:01 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00ab2024b6c6d10e76.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:ab20:24b6:c6d1:e76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b359sm138023345e9.9.2026.06.20.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:38:01 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v2 5/5] SPSLR tasklist sample module
Date: Sat, 20 Jun 2026 15:38:00 +0200
Message-ID: <20260620133800.95284-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620133222.94647-1-yjn@yjn-systems.com>
References: <20260620133222.94647-1-yjn@yjn-systems.com>
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
index b288d9991d27..0619cc57870e 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -293,6 +293,8 @@ config SAMPLE_CGROUP
 
 source "samples/rust/Kconfig"
 
+source "samples/spslr/Kconfig"
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
@@ -300,3 +302,4 @@ config HAVE_SAMPLE_FTRACE_DIRECT
 
 config HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	bool
+
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..193a5e9f9c1e 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
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

