Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1B9C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 23:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F0060F6F
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 23:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbhIWXcl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhIWXcl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Sep 2021 19:32:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC9C061574
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 16:31:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so7980068pgf.5
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 16:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4JmpLMfEZBQDMzNklJ8FfcrVNZ01v7mucqNK5/dyZM=;
        b=gkAVQneMwXP7Huc8zYfsd3+1f1zM7FLbbtgibwzhZyhgU55BgV5tzOdFE2ZrWDtWUf
         22jHQ23C2B5DLppVf2q47Bd9BXZqXZbQmnCrUcB8gFHbJLpluqB/XOUCpBrsHQKnL+dT
         s104HCmPGY6HjNHsGhc1d+aSlUPg7supgiI/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4JmpLMfEZBQDMzNklJ8FfcrVNZ01v7mucqNK5/dyZM=;
        b=waGNJMTTrk6/JuwnvYtccPVsGOzmNko712zvEluRxQK7JxCqktwCGQKPV58eJZXfdA
         FdfQzgQj6svwSqHIWMeVwFaV4d6nAS13+twS4FoAhdl0GEu9NQupKK8QSzDe1LSQ+o1d
         OD9oyxIKIkLTzid/VHV0p7VeGUJIu+LdvUqV9B1EKEWllevkiiWcCpSjwiCKwZVONXqw
         AGDV1b029FgEKRxHZD9WZV6oallbWDL0igXiFHmQKxqK0xSRxZ4axxR4tqctWvpadwq/
         BAW5cbXwmzA0ztnPDDm8f25rlVBp1CcK13A7f1xiQZIRe2A2aV3TA2z3oV3muUa8RBX6
         9wqA==
X-Gm-Message-State: AOAM530j9OHoplIkOBqiPZV/qzC0y27OBJzALN2/d4ywadJnfM4kzREv
        k6i7DXhdrRql6S5IOvFaw/MzBw==
X-Google-Smtp-Source: ABdhPJyUMS9+dkTAn8bulQI1PwKGSJAiEU2TFwDmmGMul0cs12yHNWHgE4jLhjMiCypNQPSZXhdB6w==
X-Received: by 2002:a63:595f:: with SMTP id j31mr1147183pgm.109.1632439868090;
        Thu, 23 Sep 2021 16:31:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g15sm6628254pfu.155.2021.09.23.16.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:31:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] proc: Disable /proc/$pid/wchan
Date:   Thu, 23 Sep 2021 16:31:05 -0700
Message-Id: <20210923233105.4045080-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3943; h=from:subject; bh=U7oablg1sEKMje5UnBxNq5+kJW+PeEznOm0x7d0aYaI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhTQ448wi0wTXGV8xEtY6E/CSU09UrdLNeiRXpCrh6 PoRw46mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYU0OOAAKCRCJcvTf3G3AJiL3D/ 431c8P+vVpq52hw+H+OcLEs36FHusT1bdXUKccVVKLCHKpzUoI+dv/3CNx8vVD0c91XAVZ5gS5LOw8 Gc6QB0slsnBq6QeOXcmDSbO804cI3t62G0hyfBR3nzzQcx5EIlHOaSprFC6bv5WsbciVfNyarKZszP 8h1XiwaIOpzAluyGupS82TzsPEIK4qK/kf84J3c5SnxBaYDBaF8VwlapazTz0ioYt19SvV+2LwQuMu ViEGXi0++E+6zGLibw0QFNByU5pUQ87QaXoNYkk3G9OqQWQomVtC7r9hecBqylypGB81zHpR71Kp4f 1rAFHLjhRBIHMccBpMaR6Ctvn9cXdHbpdoHOgxTrAvq6dstt9mAutFMmcm5DenSceLRih93BpxcEbJ g+lICZwWoM66jLpQrS4Z4fxl6zvr4JwcK7BFgs7uX8oVbHf2/1qfawJ03f0fjt0t5wjuGry3SlwXtj PvEW87KK3u4N8eN+bMCjTcgCebhYL+i/a0H8rMyYT7gnEdhBTBnQBxPoiu0mlZLhvs7HxeO6fK+By2 87ViZG2+v+LimtPlO43Vstw4A0UE50JNHwjPI+JiZqwyo+jLTGUpduK1sp8BXTeLLUi7A491jg+BSV lnU0IozaYhGmrkDOZQRN95E7I5mZR4u3SSbOx1SquO5EFCG8l9+agPOxonSw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The /proc/$pid/wchan file has been broken by default on x86_64 for 4
years now[1]. As this remains a potential leak of either kernel
addresses (when symbolization fails) or limited observation of kernel
function progress, just remove the contents for good.

Unconditionally set the contents to "0" and also mark the wchan
field in /proc/$pid/stat with 0.

This leaves kernel/sched/fair.c as the only user of get_wchan(). But
again, since this was broken for 4 years, was this profiling logic
actually doing anything useful?

[1] https://lore.kernel.org/lkml/20210922001537.4ktg3r2ky3b3r6yp@treble/

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Vito Caputo <vcaputo@pengaru.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/process.c |  2 +-
 fs/proc/array.c           | 16 +++++-----------
 fs/proc/base.c            | 16 +---------------
 3 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..84a4f9f3f0c2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -937,7 +937,7 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 }
 
 /*
- * Called from fs/proc with a reference on @p to find the function
+ * Called from scheduler with a reference on @p to find the function
  * which called into schedule(). This needs to be done carefully
  * because the task might wake up and we might look at a stack
  * changing under us.
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8ef555..8a4ecfd901b8 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -452,7 +452,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task, int whole)
 {
-	unsigned long vsize, eip, esp, wchan = 0;
+	unsigned long vsize, eip, esp;
 	int priority, nice;
 	int tty_pgrp = -1, tty_nr = 0;
 	sigset_t sigign, sigcatch;
@@ -540,8 +540,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		unlock_task_sighand(task, &flags);
 	}
 
-	if (permitted && (!whole || num_threads < 2))
-		wchan = get_wchan(task);
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
@@ -600,16 +598,12 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	seq_put_decimal_ull(m, " ", sigcatch.sig[0] & 0x7fffffffUL);
 
 	/*
-	 * We used to output the absolute kernel address, but that's an
-	 * information leak - so instead we show a 0/1 flag here, to signal
-	 * to user-space whether there's a wchan field in /proc/PID/wchan.
-	 *
+	 * We used to output the absolute kernel address, and then just
+	 * a symbol. But both are information leaks, so just report 0
+	 * to indicate there is no wchan field in /proc/$PID/wchan.
 	 * This works with older implementations of procps as well.
 	 */
-	if (wchan)
-		seq_puts(m, " 1");
-	else
-		seq_puts(m, " 0");
+	seq_puts(m, " 0");
 
 	seq_put_decimal_ull(m, " ", 0);
 	seq_put_decimal_ull(m, " ", 0);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..52484cd77f99 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -378,24 +378,10 @@ static const struct file_operations proc_pid_cmdline_ops = {
 };
 
 #ifdef CONFIG_KALLSYMS
-/*
- * Provides a wchan file via kallsyms in a proper one-value-per-file format.
- * Returns the resolved symbol.  If that fails, simply return the address.
- */
 static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
-	unsigned long wchan;
-
-	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		wchan = get_wchan(task);
-	else
-		wchan = 0;
-
-	if (wchan)
-		seq_printf(m, "%ps", (void *) wchan);
-	else
-		seq_putc(m, '0');
+	seq_putc(m, '0');
 
 	return 0;
 }
-- 
2.30.2

