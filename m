Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9755C43219
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Nov 2022 20:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiKIUBA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Nov 2022 15:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKIUA4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Nov 2022 15:00:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152FF13F03
        for <linux-hardening@vger.kernel.org>; Wed,  9 Nov 2022 12:00:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k7so18098580pll.6
        for <linux-hardening@vger.kernel.org>; Wed, 09 Nov 2022 12:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UYGWVP+2kBbzi2iV4I0WWEoZudfeo1pQ1Ba/UKdZ3A=;
        b=Al9IUPioLVhF5aUYYmkVtzrhkkI5wmxiVaQ31mvEBzjeJfi8pW+OvoGceYUnEAui4l
         ZJLlkqQKqQWC2KF3997axm5+kzh3obM2aom1tQR9B2Ym9X8BhF9d9LpBxMDWeuw12+hg
         KPthUHOrt24jG8LjP6wtzdgAQ857NclAmm1L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UYGWVP+2kBbzi2iV4I0WWEoZudfeo1pQ1Ba/UKdZ3A=;
        b=02BNgvUBDt61oarKNZElU3ArA6M7S0ZV8NeWyhgfVUwxI3Tbt5nwoVnngVhW9HfpUe
         06COiPkfKuL03d5SF9+vQua5Ed5fu0fvBLs0qIlH1W88eSipJt2mKuHypNemIJU3Ezka
         AW/qtIsjsPGepFTDZllrdrzZ07pYQ7v6IKalkVr7bgbooYqwwTbGthydmkmhry8XroUM
         3PCqFqcZFzBJ3HkTKIA/EOInYVUsozKUol0tlHiOlrNmHwxdHL3jrE/8xBQWkAefBSUp
         r8BWXX+OaYKnRiXeWMFGly5A5C+RLBwqftfail59ROlAxuV6OzSn7gq0+E7MrwGLnVOQ
         HdkA==
X-Gm-Message-State: ACrzQf1mAGba6AL0Kd1HYOSGIpBPQHERBfuo/eJ7H9M1stZevz4BiywM
        JJV81BvXusMpGM5hC1uaonOdIg==
X-Google-Smtp-Source: AMsMyM7LaEdlGS+MabxmO85Gn0ysyq3v1L2PjhWfgRyvBliSgVbai4V+CzcTzJ2ZUHN27GIBAj6bPw==
X-Received: by 2002:a17:903:1211:b0:178:9353:9e42 with SMTP id l17-20020a170903121100b0017893539e42mr61056479plh.45.1668024053928;
        Wed, 09 Nov 2022 12:00:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jf9-20020a170903268900b001868bf6a7b8sm9480282plb.146.2022.11.09.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:00:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 3/6] exit: Expose "oops_count" to sysfs
Date:   Wed,  9 Nov 2022 12:00:46 -0800
Message-Id: <20221109200050.3400857-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109194404.gonna.558-kees@kernel.org>
References: <20221109194404.gonna.558-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2891; h=from:subject; bh=qMx/IsiWcmyqv4bprAvLa4Z+pu9RdmRiuPSjG1ZzTgs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjbAbwo1/8yglxqkQYwl/TzoU05jno2OXdm4rO0Khj SNJWKvmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2wG8AAKCRCJcvTf3G3AJn+dEA CRtODMqBP7kZcO5j9TwUU+pK8X2SSatj9G4jVKq5CV0wprk1khK5tQp/daoG01CBFuBi8pywh0MToC qWOJ91xSfQ/agiOTbGd07lX6ERIsGg7OnwthRfzrrgbStqJTaL9Ei56cH358dNkLxqP13ai260fQ6r pGCtPIHQ1HKjN+2ZUwXbMdVQSryY9wEfEV0qELbRCKol1wPOJqQI4EF7LMJjAQVqM/5YSDZVWAKoc1 PozfKT/HCo/8/vCKUyH29aaFklAEtl4yqgamCcr97ZuLklQn7lUhd4EMHF5P+iCsqaHKTxW4+2dRbK IZddqBIugKXp5xwXEUgHTjd9CD3spRwYJThUf4qTQjCMTceS+KunCfAMfDs4gvwgiJKXrmfViqcDvj Boo6O8+t+Dx84XTCh4iCcOUuSm/WrgINQCwCQn+kDHxUaVnwIVG7d1EfHIdb9f/3Ipt74/drWWYQLN eMz+nYK3J0JnqPAfoh/QdRk7t2ojlnwEAXhRsS7g2YLDfKIHCLyvaC0SEuynhHyX1umjMm3G5rEsp7 jjFeQESAFmjYAUoak8T6n6jnl0Q0e/0N0/Yi+jTgf5WnBJ27ID/Oqs2EFlBosDJ3WwuxdK4lZEp1q9 5pPeP4jLcdy3SOY/cdO3S74h5jopYa5+mufuWL4X4p7060Tps+iGxoxMR1IA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Since Oops count is now tracked and is a fairly interesting signal, add
the entry /sys/kernel/oops_count to expose it to userspace.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jann Horn <jannh@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../ABI/testing/sysfs-kernel-oops_count       |  6 +++++
 MAINTAINERS                                   |  1 +
 kernel/exit.c                                 | 22 +++++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-oops_count

diff --git a/Documentation/ABI/testing/sysfs-kernel-oops_count b/Documentation/ABI/testing/sysfs-kernel-oops_count
new file mode 100644
index 000000000000..156cca9dbc96
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-oops_count
@@ -0,0 +1,6 @@
+What:		/sys/kernel/oops_count
+Date:		November 2022
+KernelVersion:	6.2.0
+Contact:	Linux Kernel Hardening List <linux-hardening@vger.kernel.org>
+Description:
+		Shows how many times the system has Oopsed since last boot.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd80c113721..0a1e95a58e54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11106,6 +11106,7 @@ M:	Kees Cook <keescook@chromium.org>
 L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
+F:	Documentation/ABI/testing/sysfs-kernel-oops_count
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
 F:	mm/usercopy.c
diff --git a/kernel/exit.c b/kernel/exit.c
index 892f38aeb0a4..4bffef9f3f46 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -67,6 +67,7 @@
 #include <linux/io_uring.h>
 #include <linux/kprobes.h>
 #include <linux/rethook.h>
+#include <linux/sysfs.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -99,6 +100,25 @@ static __init int kernel_exit_sysctls_init(void)
 late_initcall(kernel_exit_sysctls_init);
 #endif
 
+static atomic_t oops_count = ATOMIC_INIT(0);
+
+#ifdef CONFIG_SYSFS
+static ssize_t oops_count_show(struct kobject *kobj, struct kobj_attribute *attr,
+			       char *page)
+{
+	return sysfs_emit(page, "%d\n", atomic_read(&oops_count));
+}
+
+static struct kobj_attribute oops_count_attr = __ATTR_RO(oops_count);
+
+static __init int kernel_exit_sysfs_init(void)
+{
+	sysfs_add_file_to_group(kernel_kobj, &oops_count_attr.attr, NULL);
+	return 0;
+}
+late_initcall(kernel_exit_sysfs_init);
+#endif
+
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
 	nr_threads--;
@@ -901,8 +921,6 @@ void __noreturn do_exit(long code)
 
 void __noreturn make_task_dead(int signr)
 {
-	static atomic_t oops_count = ATOMIC_INIT(0);
-
 	/*
 	 * Take the task off the cpu after something catastrophic has
 	 * happened.
-- 
2.34.1

