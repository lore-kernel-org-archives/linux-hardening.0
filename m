Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161E1C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 18:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F5B61507
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 18:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbhI2TAV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:00:21 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34642 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244766AbhI2TAV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 29 Sep 2021 15:00:21 -0400
Received: by mail-wr1-f49.google.com with SMTP id t8so5965924wri.1;
        Wed, 29 Sep 2021 11:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NX7kzOlXhLlKh6a09QjwKCvbG9nCgyCouwpC4Jjr1c0=;
        b=J3Q503Q7diec1tu9EHnjkZ7g8rTLY9YleEXr17WU5YJArSDcRchO75irT+yYkIKPyG
         vxirKzyCwxPvIOY6P2DI7bA1rnd+jq6HoikWpOgjJb7870rtVwc5vm043ALcG9TcnR+V
         /a1y61VZlTN0qdBWYk68YG+Q+2XEPjMFRh/ksQyD+J3dqckwLfu+Qi/003XmV77FyTsQ
         NFmXxeJOlv7I0s1eBidXFPvQz604p4/o21ITVdmsqJQ0AicnkLA3f/s2WClvqLBHspAm
         edzQLuTAfjovieRJLNZci/qKBfm0d2Xkn6Iy+EzCkHelz/BMfYpSyMp0ZcIoTZJK9m00
         2XBg==
X-Gm-Message-State: AOAM533M8z53u2JDWlLwOdHictUf7mC7US/AtZ5GT+6Lutp7PwRCnSED
        yB8qTIEKtIGE7kQ2lVyI0GM=
X-Google-Smtp-Source: ABdhPJyyBlk2gE76cLFYDnNAs1zIskLuX0HW15xFYCDmMjXxjdTVQLDm8F/ZK9yNz7ieyQ+tLmq0QQ==
X-Received: by 2002:adf:f0d2:: with SMTP id x18mr1873652wro.25.1632941918820;
        Wed, 29 Sep 2021 11:58:38 -0700 (PDT)
Received: from localhost.localdomain ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id r19sm578288wmp.43.2021.09.29.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:58:38 -0700 (PDT)
From:   Alexander Popov <alex.popov@linux.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Garnier <thgarnie@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Alexander Popov <alex.popov@linux.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     notify@kernel.org
Subject: [PATCH] Introduce the pkill_on_warn boot parameter
Date:   Wed, 29 Sep 2021 21:58:23 +0300
Message-Id: <20210929185823.499268-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently, the Linux kernel provides two types of reaction to kernel
warnings:
 1. Do nothing (by default),
 2. Call panic() if panic_on_warn is set. That's a very strong reaction,
    so panic_on_warn is usually disabled on production systems.

From a safety point of view, the Linux kernel misses a middle way of
handling kernel warnings:
 - The kernel should stop the activity that provokes a warning,
 - But the kernel should avoid complete denial of service.

From a security point of view, kernel warning messages provide a lot of
useful information for attackers. Many GNU/Linux distributions allow
unprivileged users to read the kernel log, so attackers use kernel
warning infoleak in vulnerability exploits. See the examples:
  https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
  https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html

Let's introduce the pkill_on_warn boot parameter.
If this parameter is set, the kernel kills all threads in a process
that provoked a kernel warning. This behavior is reasonable from a safety
point of view described above. It is also useful for kernel security
hardening because the system kills an exploit process that hits a
kernel warning.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 kernel/panic.c                                  | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..86c748907666 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4112,6 +4112,10 @@
 	pirq=		[SMP,APIC] Manual mp-table setup
 			See Documentation/x86/i386/IO-APIC.rst.
 
+	pkill_on_warn=	Kill all threads in a process that provoked a
+			kernel warning.
+			Format: { "0" | "1" }
+
 	plip=		[PPT,NET] Parallel port network link
 			Format: { parport<nr> | timid | 0 }
 			See also Documentation/admin-guide/parport.rst.
diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..47b728bfb1d3 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -53,6 +53,7 @@ static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
 bool crash_kexec_post_notifiers;
 int panic_on_warn __read_mostly;
+int pkill_on_warn __read_mostly;
 unsigned long panic_on_taint;
 bool panic_on_taint_nousertaint = false;
 
@@ -610,6 +611,9 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	print_oops_end_marker();
 
+	if (pkill_on_warn && system_state >= SYSTEM_RUNNING)
+		do_group_exit(SIGKILL);
+
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
 }
@@ -694,6 +698,7 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
+core_param(pkill_on_warn, pkill_on_warn, int, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
 
 static int __init oops_setup(char *s)
-- 
2.31.1

