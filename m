Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40920FA81
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691121; cv=none; b=DY3YaiPRrjAAURgrql8KKA1xaInJLYfcT0Y61EzArcNQx88dst3sa2OxAfbo4SA0IUUaNIwnck2CWphhgLtuLNWuiqESJAqyOkWmgHDaLAE1Dm1rdE5LVHjoCDajyKhmWRBAy6DCk22yieMedPsSYUJLFRIBiQY3aJGlmjHcTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691121; c=relaxed/simple;
	bh=JxdQVfgRbVBpc2TrolOZ/6x881XD6maKM9xngqr0wEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz5gCZ5hj8cwnTv8pq3v+aSGwAEkoySEFdXjN0dSOFcCfJlYXSdAN5u6z+Tpwxmk0pr+9Eyo4II7gTWx3EYwqZel4J30ugkFM3i+lVxCkt6Rb7bEF4etXTHRNJCIa9C4AVZ6/pPnExaa88h+jNj8cYJ6+abDVkC1HIajuS6/a58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=PpC8ZWBn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="PpC8ZWBn"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so14047295e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1780691118; x=1781295918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svM67pzenm1QXgp8qKsSuUM+2ACaUaLa7AyCcrmRfUY=;
        b=PpC8ZWBnbsOeaMfxKhMAbsu9gdTWTN46GYcT/irfaBMjv/1XnWLGbJpQtaCqzsokVp
         TtMSflJ1lwF84DWRrAPYKbow/eCmUuKuf7uQZmvQ34Gi6hKVSyYLLayIg+Mervs7SVW6
         nS0t4sjXP/0YD3dznT3zJpN0Dv9Jk2iU4a8zGaoDoigzALpwpbv3TNoa74U18VPGfy6T
         GyxdtDZIfL5VEIhY1tAse987173shSAoJHy3w0W3EJfbv8Z06zQHm3QErTqs908G9m58
         p7dAzTLv4/QjUwErHu+nyJ2xRUpEyYSCJ60oBW2rV2NZ9fcrfVZfAD4TGvfreVwBOYkL
         1frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691118; x=1781295918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svM67pzenm1QXgp8qKsSuUM+2ACaUaLa7AyCcrmRfUY=;
        b=mZc+IjtGxAoLBfH7PKQ99qdVBqTkE2K8lkcvkyje+txoPQPtUbHRerjljcQ3JB7WYM
         G2o8JOh6Q3kkMtoziEb6AI0/oMdUvF+CDKYe06YSeFmV8ValfrqxMfhnEy3/CyYVi0E1
         +Uh1/c2WiTnqpLT+4aiGKHP0Eg06+s0TGVAfVehZ/wIE1/s9shP4SA4G3o3dLWD+iUg2
         BVEEtyI0bx9HpguJo5jnYW/FvsAx2irL/8GZQWQelIehBXmez+M5wRS5yuuuPb0odh8h
         u3IAjpD67eWqoHSqNvHWVRMw5lhj/OkUuPyReAdUGQczA8UgXpQW/eHqwPymBK1JcbaK
         g9IA==
X-Gm-Message-State: AOJu0Yyhvp5QwZyTZ0r+Biw7l5zYL8U1yzvQmW2W6gjCugO/t39C9fLd
	+7CgVxchxCGqRL1HrFpNaEnC6U0AcQBMCCflQSDtxU8I3DED/0JBVYh9ioxcF2uER7e1wV1KJrl
	jUWVJBnEy
X-Gm-Gg: Acq92OEjCqO4ZNZOIK0D0aOfajwEDJX+4zx+rno5TwUNf2ylv9ciUSdmHyaL3/E5yL9
	GT4Rmzgo/eLGpfJEvwqA66eD98UWCibpLSfEA3LURDfu9tiGyaWRDhBEqgBlVyo8kpowSOFQ7jV
	PLcT2GUHBW1m8kf36xA9q8Kk2xwkdhUsxgae5eGh94EB5dRFOv70wwNtvBkfPKl9WKdNiuiacSM
	uw4swkF24EMdcVXdaZ0eq+mHz8aZwfg6g7TuKBNrwskZh4+PnG0VJRMZ8fY/I216ovb8wZ32j4x
	rc8ZMbYKWnmFJnSKhB1O4g61aMB3a6E1aecPzQqFZhqz7BRjJd6SuhuShveXGBzioMZdWad0Ihc
	S8yveW9Dxwi32n6XKWM2QfvmXvs6sg5hdKaNi93lfmtjLLXPZPNjfyuH+IafW58NFKoVGzj2mXb
	BRMYBql9NVyZt3HBeKMDCNyYOMm/Mcp17PzWWClj6mwPCU3L5I9Jn4V2W/iEmXvQcONJJ+x89Y3
	5+IKIh8oX8t1gAP7VvWf7qQTX1Ck1JWCk1mtp4eC5OWRuBTbw==
X-Received: by 2002:a05:600c:6792:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-490c25ee920mr89300365e9.24.1780691118289;
        Fri, 05 Jun 2026 13:25:18 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf13e6006c589ea22c400ee8.dip0.t-ipconnect.de. [2003:dc:bf13:e600:6c58:9ea2:2c40:ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm168442995e9.7.2026.06.05.13.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:25:17 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de
Subject: [RFC 6/7] BPSLR tasklist sample module
Date: Fri,  5 Jun 2026 22:25:10 +0200
Message-ID: <20260605202511.79272-7-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605202511.79272-1-yjn@yjn-systems.com>
References: <20260605202511.79272-1-yjn@yjn-systems.com>
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
 samples/spslr/tasklist/tasklist.c | 68 +++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+)
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
index 000000000000..0b25cf62a190
--- /dev/null
+++ b/samples/spslr/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig SAMPLES_SPSLR
+	bool "SPSLR samples"
+	depends on SPSLR
+	help
+	  You can build sample Rust kernel code here.
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
index 000000000000..e42e3f182286
--- /dev/null
+++ b/samples/spslr/tasklist/tasklist.c
@@ -0,0 +1,68 @@
+#include <linux/module.h>
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
+    pr_info("    offsetof(task_struct, pid)=%lu\n", offsetof(struct task_struct, pid));
+    pr_info("    offsetof(task_struct, tgid)=%lu\n", offsetof(struct task_struct, tgid));
+    pr_info("    offsetof(task_struct, cred)=%lu\n", offsetof(struct task_struct, cred));
+    pr_info("    offsetof(task_struct, real_parent)=%lu\n", offsetof(struct task_struct, real_parent));
+    pr_info("    offsetof(task_struct, comm)=%lu\n", offsetof(struct task_struct, comm));
+    pr_info("    offsetof(task_struct, __state)=%lu\n", offsetof(struct task_struct, __state));
+    pr_info("    offsetof(task_struct, flags)=%lu\n", offsetof(struct task_struct, flags));
+    pr_info("    offsetof(task_struct, prio)=%lu\n", offsetof(struct task_struct, prio));
+    pr_info("    offsetof(task_struct, policy)=%lu\n", offsetof(struct task_struct, policy));
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

