Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05740C4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Nov 2022 09:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiKNJtc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiKNJtR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Nov 2022 04:49:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3958B14086
        for <linux-hardening@vger.kernel.org>; Mon, 14 Nov 2022 01:49:15 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id r3so12781926yba.5
        for <linux-hardening@vger.kernel.org>; Mon, 14 Nov 2022 01:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l4csSnMcWReSkj8cBG0QioRbqv/IdxWbBKHzfzblSQo=;
        b=NwOHpbDrWEnEW9pJrLdphC481gBPMGS0kP2Jp9tH/JRO3S9wBND44urP5I0nsc3klc
         9RKAY4Qe1Je8V7dVS1htYhg2F30Kwe5OdmWqUIZyD5y8cr1yCA6I1m/97Jr//Ykyarqe
         OkAFsG1J9nqnF/9tClbC5ImHaL7ypBxLjOiIGIgaZZjTvpzjPHz8nexep84JhjIGOLI6
         FTDpOeuTTODiDdGZSmIbmAY5IhOgB2YTXyzXBiiJYNIKZW/5abWK5Bcb2mOtdHxT9eMh
         Dc33WXtJANefaA+Uk8LzjnByMruggL+vFUUoabTMwFr/ffAiewQpOcsi6HE3MWZqtF+K
         Rwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4csSnMcWReSkj8cBG0QioRbqv/IdxWbBKHzfzblSQo=;
        b=HKS4Engn2Dmb9QOiOJ+qSjLX9iBEXE1qzRV2E7dOBzpS4xan6xlufp+ZgRW9+0sICi
         QS1n4rKHGo5/shKW9dEeduwtChVe1NJx0ihFzPe4Xu29P6w5doHZ2DXO30HjSCy8sQ9a
         RsJQf6ITqDZsmoLLnQgarhUyHAkSIwa9aa6Igt816yb0US8+nthDYfqLvjUD7K6lFkfp
         pXMwmOTI+3LsJwDzHwrY5+GgEuqCOb2gwtBe+AHX1lnCz2FUM++UQhLEloqfuKtTqqOq
         E0+GDdvTCWoT9lM7ohgOl2UzX4HLWaGOI7ZvHFooxs8bNkCMFMq2jDJWXd6WNB3kIiBy
         OTeQ==
X-Gm-Message-State: ANoB5pkbJcG+IR9iaUuoiGKxH2hVyOr3Crp5tvYJjT753YAIN3pICKpN
        fLt7khYoISzUlfvkyUzxVVRSp70oWgWfKciIwsnBSA==
X-Google-Smtp-Source: AA0mqf7C0UBdQtuF+qiDJo2+855Rd+SEleV7IgA+f8kAFNxQFKvASyu42I+ez1chBE6nKTzegl8HamO1RzeY9hoj6dc=
X-Received: by 2002:a5b:c4c:0:b0:6df:1528:d64c with SMTP id
 d12-20020a5b0c4c000000b006df1528d64cmr10081798ybr.143.1668419354248; Mon, 14
 Nov 2022 01:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20221109194404.gonna.558-kees@kernel.org> <20221109200050.3400857-5-keescook@chromium.org>
In-Reply-To: <20221109200050.3400857-5-keescook@chromium.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Nov 2022 10:48:38 +0100
Message-ID: <CANpmjNO_ujNwaFxpsAWWXhBajhV8LJMXQjCHiSLHKG2Dc+od4A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] panic: Introduce warn_limit
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
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
        linux-doc@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 9 Nov 2022 at 21:00, Kees Cook <keescook@chromium.org> wrote:
>
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
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst |  9 +++++++++
>  kernel/panic.c                              | 13 +++++++++++++
>  2 files changed, 22 insertions(+)
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
> index 3afd234767bc..b235fa4a6fc8 100644
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
>                 .extra2         = SYSCTL_ONE,
>         },
>  #endif
> +       {
> +               .procname       = "warn_limit",
> +               .data           = &warn_limit,
> +               .maxlen         = sizeof(warn_limit),
> +               .mode           = 0644,
> +               .proc_handler   = proc_douintvec,
> +       },
>         { }
>  };
>
> @@ -203,8 +211,13 @@ static void panic_print_sys_info(bool console_flush)
>
>  void check_panic_on_warn(const char *reason)
>  {
> +       static atomic_t warn_count = ATOMIC_INIT(0);
> +
>         if (panic_on_warn)
>                 panic("%s: panic_on_warn set ...\n", reason);
> +
> +       if (atomic_inc_return(&warn_count) >= READ_ONCE(warn_limit))
> +               panic("Warned too often (warn_limit is %d)", warn_limit);

Shouldn't this also include the "reason", like above? (Presumably a
warning had just been generated to console so the reason is easy
enough to infer from the log, although in that case "reason" also
seems redundant above.)
