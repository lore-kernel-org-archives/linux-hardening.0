Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE5AC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 23:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13839610FD
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 23:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbhIWXkB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhIWXkA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Sep 2021 19:40:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E200CC061757
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 16:38:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so6016371pjb.5
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 16:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5/WAgNALfvsB4KP6m0qi12xIQRzUGya+l2VNZgSQQFs=;
        b=UUrHZBh8vYnktVCpv8EX35Ama1oym9Nh8GVSqcMGyZtB/zI51bp8GnrNlnumoMvDLP
         pL7TtKl+bSA9hnB6pHh067v8/9z4C6BV6aiHOfxHoDTsSJffSTxgttXCfcoVAH35RuHK
         vFuKm1/WezYhGxxQhvrW2Fc7WpGP4+ohknJ3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5/WAgNALfvsB4KP6m0qi12xIQRzUGya+l2VNZgSQQFs=;
        b=7v8nJZgpnTXDnbaDm/CBZHhA31Ksab9tZpZ5eAHWoAZUow4ldarmyMy9ywDEsXM0n6
         vEyca2s5mbHrDu3ZjtTaIg8mTgAnfkaGHzdA6r7x0yDnDYqmhbqAmob0XaOVouQl1sTI
         +/qo2cFWyBY/BPwVhDtOQ8RLueFnorQ/TTdFXt1YcNq1PSgiZv9heq+wnkOWTJQXpiGN
         S9sXk3XoHntwpvFZO5jebNyokz0OXdB32r2lPanF+AB1WOZmnLCOHYsOi+EU15VHjudJ
         D4kk3Sj9OWKz603+5QcN06Dzq1uE1eyYEkBgzTlbIjjC8O4aqtrKWV1DMcVZ4GAnlt5d
         qyNA==
X-Gm-Message-State: AOAM533OAuja6a5ROREyVCXlQnyFa9P33nj/q3x6i6xYYbFR0FKdyQ4n
        1VXrCYT9SzNOCmqlgwlHggvHjA==
X-Google-Smtp-Source: ABdhPJyyrM0zRw6DFdwMAtzDrtQKF3bniLC06zxmI/Y0shk9SiOdcyTKWxmv58K52tHT0wioCtI5pg==
X-Received: by 2002:a17:90a:aa14:: with SMTP id k20mr20461715pjq.88.1632440308367;
        Thu, 23 Sep 2021 16:38:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h16sm6423013pjt.30.2021.09.23.16.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:38:27 -0700 (PDT)
Date:   Thu, 23 Sep 2021 16:38:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
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
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109231636.C233D6D82@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923233105.4045080-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 23, 2021 at 04:31:05PM -0700, Kees Cook wrote:
> The /proc/$pid/wchan file has been broken by default on x86_64 for 4
> years now[1]. As this remains a potential leak of either kernel
> addresses (when symbolization fails) or limited observation of kernel
> function progress, just remove the contents for good.
> 
> Unconditionally set the contents to "0" and also mark the wchan
> field in /proc/$pid/stat with 0.

I forgot to CC Qi Zheng on this patch. Now corrected. :)

> This leaves kernel/sched/fair.c as the only user of get_wchan(). But
> again, since this was broken for 4 years, was this profiling logic
> actually doing anything useful?

If the fair scheduler would actually benefit from still using get_wchan,
I think this patch:
https://lore.kernel.org/all/20210831083625.59554-1-zhengqi.arch@bytedance.com/
should still be applied too.

If not, we can rip get_wchan() out completely (across all
architectures).

-Kees

> [1] https://lore.kernel.org/lkml/20210922001537.4ktg3r2ky3b3r6yp@treble/
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Vito Caputo <vcaputo@pengaru.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/process.c |  2 +-
>  fs/proc/array.c           | 16 +++++-----------
>  fs/proc/base.c            | 16 +---------------
>  3 files changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 1d9463e3096b..84a4f9f3f0c2 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -937,7 +937,7 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
>  }
>  
>  /*
> - * Called from fs/proc with a reference on @p to find the function
> + * Called from scheduler with a reference on @p to find the function
>   * which called into schedule(). This needs to be done carefully
>   * because the task might wake up and we might look at a stack
>   * changing under us.
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 49be8c8ef555..8a4ecfd901b8 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -452,7 +452,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>  static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  			struct pid *pid, struct task_struct *task, int whole)
>  {
> -	unsigned long vsize, eip, esp, wchan = 0;
> +	unsigned long vsize, eip, esp;
>  	int priority, nice;
>  	int tty_pgrp = -1, tty_nr = 0;
>  	sigset_t sigign, sigcatch;
> @@ -540,8 +540,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  		unlock_task_sighand(task, &flags);
>  	}
>  
> -	if (permitted && (!whole || num_threads < 2))
> -		wchan = get_wchan(task);
>  	if (!whole) {
>  		min_flt = task->min_flt;
>  		maj_flt = task->maj_flt;
> @@ -600,16 +598,12 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  	seq_put_decimal_ull(m, " ", sigcatch.sig[0] & 0x7fffffffUL);
>  
>  	/*
> -	 * We used to output the absolute kernel address, but that's an
> -	 * information leak - so instead we show a 0/1 flag here, to signal
> -	 * to user-space whether there's a wchan field in /proc/PID/wchan.
> -	 *
> +	 * We used to output the absolute kernel address, and then just
> +	 * a symbol. But both are information leaks, so just report 0
> +	 * to indicate there is no wchan field in /proc/$PID/wchan.
>  	 * This works with older implementations of procps as well.
>  	 */
> -	if (wchan)
> -		seq_puts(m, " 1");
> -	else
> -		seq_puts(m, " 0");
> +	seq_puts(m, " 0");
>  
>  	seq_put_decimal_ull(m, " ", 0);
>  	seq_put_decimal_ull(m, " ", 0);
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 533d5836eb9a..52484cd77f99 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -378,24 +378,10 @@ static const struct file_operations proc_pid_cmdline_ops = {
>  };
>  
>  #ifdef CONFIG_KALLSYMS
> -/*
> - * Provides a wchan file via kallsyms in a proper one-value-per-file format.
> - * Returns the resolved symbol.  If that fails, simply return the address.
> - */
>  static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
>  			  struct pid *pid, struct task_struct *task)
>  {
> -	unsigned long wchan;
> -
> -	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> -		wchan = get_wchan(task);
> -	else
> -		wchan = 0;
> -
> -	if (wchan)
> -		seq_printf(m, "%ps", (void *) wchan);
> -	else
> -		seq_putc(m, '0');
> +	seq_putc(m, '0');
>  
>  	return 0;
>  }
> -- 
> 2.30.2
> 

-- 
Kees Cook
