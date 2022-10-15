Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F2C433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 15 Oct 2022 04:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJOEQc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 15 Oct 2022 00:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJOEQb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 15 Oct 2022 00:16:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF92B6AA04
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 10so6480989pli.0
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zhd+IrU4jdtHIjl5cwKXHkAtq/ao6g5qBaiCZACrNE=;
        b=eKzl19ovq5OG+t8XnvGfWR1OvcArXyvG9mkw0CKMUwYYVjX691mO+wrpOo+zkwmmTR
         Jj8vKsc46HvtvWOQyzHPRc3V68Z6fjecVH0KshVGn3l8ArzRAovZJDBl4zHu8GY4jtQ8
         A4uLljfGvnTtw1ZJT1XKaP8JOvK7U8GggE9eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zhd+IrU4jdtHIjl5cwKXHkAtq/ao6g5qBaiCZACrNE=;
        b=8OJ1sNkhlyUB7fFuJbMI8GXCH7W7IvqNQzKRS/L4nMukEe2c7HBcv9wAto0I1maPgH
         bxBBwJzGjN4cn1TYL5tIPpMnhOnDEPfmR0IgkWyc6E5o4PJ08VU0L3Y4mNo6eTA2CC+A
         vCNnReEp7UyxM8lDXZgVvWIMYr4JGpndKVHeJL2hKdsKJ2sMZFsaJmMjqBo66p2i+3qJ
         hF7rBKvPf9hyse1cNPeVBeEOPIcw+4rGGQNOtbQWJFOJOacm99cFwLS1nrjsmlnISXMn
         Nz7BehfpdkIToSVhqj0fM5Gop5RN6vxsmTxoLOK5V8FN/doztelZ7mU3mCoZjAr0ArUz
         GtOA==
X-Gm-Message-State: ACrzQf3I6k93JrgqCc86NSmDeQgNhrnoGJWPIUeaB+FNp6s6rQfi0JZJ
        lUGiI2hgWKvXCQA29uwCEaQx4w==
X-Google-Smtp-Source: AMsMyM4RA0/+xXyzB7ntwgC1whlwlVKc36cked5j5EoDP9EUDD80ayXiBpWbUeD0aFFoU+5ZEnRwOg==
X-Received: by 2002:a17:902:8205:b0:185:33e:2a0e with SMTP id x5-20020a170902820500b00185033e2a0emr1146421pln.92.1665807389274;
        Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709027fce00b00176be23bbb3sm2421738plb.172.2022.10.14.21.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 21:16:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] tty: Move sysctl setup into "core" tty logic
Date:   Fri, 14 Oct 2022 21:16:23 -0700
Message-Id: <20221015041626.1467372-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221015041352.never.966-kees@kernel.org>
References: <20221015041352.never.966-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3538; h=from:subject; bh=UfHWy9+3SRLAJXHVd4eYVy04EbNnVYsHoiv7mjWvzd0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSjQY8BlG6QlYL+LP5sq2Ex0rIi4OkDlCnsJriKUh vYr86t6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0o0GAAKCRCJcvTf3G3AJnMZD/ 4ywyAmxaAppPe90zfX9UHpj/BtWNCK2vBmpwT5/+vq5qGOnOwB82XyKnY+IpBe76u6jrPBvs48s0mS jm1fuCT/vDpeOkN+HvLC/aNUGuEGf4YYr6AcbvZYi46q2pCajEQKGcOAlUtvXk7mVNjpdb7w9sb/R0 h9Yzxb4YKmMLFVeTA5oMq8BpMVyg/wXcpvCgnYudyz98y0NyMKSrS2JaMy62t4lY8VEBUFypHddd0L 4qqQfD9LSEx7fLR/o4K2zHkJFojDUriV8ZIlmTlNl4qIfU3DRbY1VBMa+Ng2sAzzn93SgPgDXgoFuH US9tSvBqxvUtscehs3TFIsmbuBtzEVA5PhET/4BkqUNfGSEzmc3AmX1bxCbYhukNoXbc/1zfnqjZzc Q+OGWNQg7ml4Zd+FvEupwNNUUISQyvi2roENwKQtf+Ipiu1Po7TE5ZLwbDK2stc98MyD+EHplAU2vk 5hvvx+WMGtlzLPA78hhfA8dmnTrKaOlnKbTQ2ONR5K86b+H52b2XJ3x05Qy2zAkHTVxyoZ6P/ZMj+x 8xtcqSOOz1BzZfXcUSWBlV0Es/LFzEe6w2fcM52x+F/6zNOrvbFL2z6pe+ZnvJ1Q/6vGnKBTI6BB47 3gPxAFKWcW/wnczv+KwY9VpIrrjlcHZPippJkcACFos8zwJUmRc/3iqzbGzw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for adding another sysctl to the tty subsystem, move the
tty setup code into the "core" tty code, which contains tty_init() itself.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/tty.h       |  2 +-
 drivers/tty/tty_io.c    | 34 ++++++++++++++++++++++++++++++++--
 drivers/tty/tty_ldisc.c | 38 +-------------------------------------
 3 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index f310a8274df1..4938ed3a44a5 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -93,7 +93,7 @@ void tty_ldisc_release(struct tty_struct *tty);
 int __must_check tty_ldisc_init(struct tty_struct *tty);
 void tty_ldisc_deinit(struct tty_struct *tty);
 
-void tty_sysctl_init(void);
+int tty_ldisc_autoload;
 
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 82a8855981f7..b397b223eada 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3581,13 +3581,44 @@ void console_sysfs_notify(void)
 		sysfs_notify(&consdev->kobj, NULL, "active");
 }
 
+static struct ctl_table tty_table[] = {
+	{
+		.procname	= "ldisc_autoload",
+		.data		= &tty_ldisc_autoload,
+		.maxlen		= sizeof(tty_ldisc_autoload),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static struct ctl_table tty_dir_table[] = {
+	{
+		.procname	= "tty",
+		.mode		= 0555,
+		.child		= tty_table,
+	},
+	{ }
+};
+
+static struct ctl_table tty_root_table[] = {
+	{
+		.procname	= "dev",
+		.mode		= 0555,
+		.child		= tty_dir_table,
+	},
+	{ }
+};
+
 /*
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
  */
 int __init tty_init(void)
 {
-	tty_sysctl_init();
+	register_sysctl_table(tty_root_table);
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
@@ -3609,4 +3640,3 @@ int __init tty_init(void)
 #endif
 	return 0;
 }
-
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 776d8a62f77c..e758f44729e7 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -117,7 +117,7 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 }
 
-static int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
+int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
 
 /**
  * tty_ldisc_get	-	take a reference to an ldisc
@@ -817,39 +817,3 @@ void tty_ldisc_deinit(struct tty_struct *tty)
 		tty_ldisc_put(tty->ldisc);
 	tty->ldisc = NULL;
 }
-
-static struct ctl_table tty_table[] = {
-	{
-		.procname	= "ldisc_autoload",
-		.data		= &tty_ldisc_autoload,
-		.maxlen		= sizeof(tty_ldisc_autoload),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{ }
-};
-
-static struct ctl_table tty_dir_table[] = {
-	{
-		.procname	= "tty",
-		.mode		= 0555,
-		.child		= tty_table,
-	},
-	{ }
-};
-
-static struct ctl_table tty_root_table[] = {
-	{
-		.procname	= "dev",
-		.mode		= 0555,
-		.child		= tty_dir_table,
-	},
-	{ }
-};
-
-void tty_sysctl_init(void)
-{
-	register_sysctl_table(tty_root_table);
-}
-- 
2.34.1

