Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A4CC433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 00:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbiKRA1v (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 19:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbiKRA1p (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 19:27:45 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB16E55C
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 16:27:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v28so3355046pfi.12
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 16:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ztxf/N067AkE8cSn/2kvfcuUb/GtHbfVkaEhVKHtSlA=;
        b=b785W2M08rZS9MNhG9zvqME3T9si9Soy8yfoPlzPjLroeHTttXjh3eFMee5T/1jdxP
         HNLG/6mUjy4Akrz8m+cs128Kbj79/ZeqIcPBtCTuuEMqOgNzoBcxVUX+xJxFDBpIovA/
         8OCbZsDG1CZDABpEgfmHrYY2qj/an4SbhnPH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ztxf/N067AkE8cSn/2kvfcuUb/GtHbfVkaEhVKHtSlA=;
        b=7v/t4qXr5ggF9SZ7mLQphYJbrhSsrGvggE7amKorDxZk53neJyTXjtQP9Z8q5DM+R0
         xzZIZRwgEhoRsVpkzD9DZjr/kZ6jxjE9XK6h5S1f9O0aRIgO3CmBqgX9GsD7n7xWCM7e
         4IuqmMV6aDGWbQhxfJkZnfcuj64Ga0I7lkQi+2GDP3XTaG5pJmybxCPfJsbW7Tns48rZ
         MZDLaxPD9ABSbdqt8LzOXaD7XH3aG/YKP6vaYIokyr8LGYjn80rEXtvSJpw04aKxSf8P
         JLuBSsK6ZdnoNGtOV9kWHohILzzOXVbGL9hMqmJ798Xfxavt5wP9GbqcCmyLYtVJ+fO2
         jSZw==
X-Gm-Message-State: ANoB5plYoEnxzZNR9Dyz29RvPFgIykEBliZzPqJPSD+BPC7pI3MhnR4m
        ubZ0wygI6AcEYZYVzkiGt5BzZg==
X-Google-Smtp-Source: AA0mqf4Ii+vqcOdx5O9zsxfXQEkm+1QA3JdQxul/mmEgeO6DecRmffZhBTe+/FxeO5//y1TcQSDXbg==
X-Received: by 2002:a63:fd08:0:b0:46f:ed91:6664 with SMTP id d8-20020a63fd08000000b0046fed916664mr4319364pgh.558.1668731263832;
        Thu, 17 Nov 2022 16:27:43 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u12-20020a170903124c00b00186fd3951f7sm2011902plh.211.2022.11.17.16.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:27:43 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:27:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-doc@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 5/6] panic: Introduce warn_limit
Message-ID: <202211171627.CFC188B@keescook>
References: <20221117233838.give.484-kees@kernel.org>
 <20221117234328.594699-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117234328.594699-5-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 17, 2022 at 03:43:25PM -0800, Kees Cook wrote:
> Like oops_limit, add warn_limit for limiting the number of warnings when
> panic_on_warn is not set.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: tangmeng <tangmeng@uniontech.com>
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst |  9 +++++++++
>  kernel/panic.c                              | 14 ++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 09f3fb2f8585..c385d5319cdf 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1508,6 +1508,15 @@ entry will default to 2 instead of 0.
>  2 Unprivileged calls to ``bpf()`` are disabled
>  = =============================================================
>  
> +
> +warn_limit
> +==========
> +
> +Number of kernel warnings after which the kernel should panic when
> +``panic_on_warn`` is not set. Setting this to 0 or 1 has the same effect
> +as setting ``panic_on_warn=1``.
> +
> +
>  watchdog
>  ========
>  
> diff --git a/kernel/panic.c b/kernel/panic.c
> index cfa354322d5f..e5aab27496d7 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -58,6 +58,7 @@ bool crash_kexec_post_notifiers;
>  int panic_on_warn __read_mostly;
>  unsigned long panic_on_taint;
>  bool panic_on_taint_nousertaint = false;
> +static unsigned int warn_limit __read_mostly = 10000;
>  
>  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>  EXPORT_SYMBOL_GPL(panic_timeout);
> @@ -88,6 +89,13 @@ static struct ctl_table kern_panic_table[] = {
>  		.extra2         = SYSCTL_ONE,
>  	},
>  #endif
> +	{
> +		.procname       = "warn_limit",
> +		.data           = &warn_limit,
> +		.maxlen         = sizeof(warn_limit),
> +		.mode           = 0644,
> +		.proc_handler   = proc_douintvec,
> +	},
>  	{ }
>  };
>  
> @@ -203,8 +211,14 @@ static void panic_print_sys_info(bool console_flush)
>  
>  void check_panic_on_warn(const char *origin)
>  {
> +	static atomic_t warn_count = ATOMIC_INIT(0);
> +
>  	if (panic_on_warn)
>  		panic("%s: panic_on_warn set ...\n", origin);
> +
> +	if (atomic_inc_return(&warn_count) >= READ_ONCE(warn_limit))
> +		panic("%s: system warned too often (kernel.warn_limit is %d)",
> +		      warn_limit);

Bah. This should be:  origin, warn_limit.

-- 
Kees Cook
