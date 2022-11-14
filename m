Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F431C4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Nov 2022 10:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiKNKAK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiKNJ7p (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Nov 2022 04:59:45 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE978201B4
        for <linux-hardening@vger.kernel.org>; Mon, 14 Nov 2022 01:57:52 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3691e040abaso100873637b3.9
        for <linux-hardening@vger.kernel.org>; Mon, 14 Nov 2022 01:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RH2+m7K5zmlE9wCFpvve3I5Fi8RQASbgvvHyRX4D28g=;
        b=caH5zcwkog0cMjlAJPkHeBavqbL94j9ZBu9bzj995wPA1niQU1MOQevoIK8FYeq65X
         CZVxpcYpKgdxsSgPpoH7oBCrw8VRDMF5To+i0fPdipkBKC4HQzoH9KMb+KzzyV6NEJSb
         YSDm6+/fn5oQLCCvDUZSNfnP1DZP4ZRHufhJQBVLKVuKjGY5tSSoP5gsN6P5GRZIRKFO
         P401CdBic2g2TjELvkKLbrdkzGEfkAZWeiD9pkWBf6zRmyLN5sepbhiNOrnJwttRejKo
         w6qk4g+2euVxCE3fFovbK0wfejNOv+gS8uk51+E/DRCnwo9ajKDQ7piqJDvUhON8rUmF
         K0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RH2+m7K5zmlE9wCFpvve3I5Fi8RQASbgvvHyRX4D28g=;
        b=ou98HiroQJMUzxv4hAj2FSDFZfaRgqaE8qXzDWDx/VrjdAoukPE2K5uSkUYco5L/pO
         fvpo1O25eQjWc3gtZqKAhedHOx1pi5NhZjU34Y6sEkf/6bK5tKS6adC7/TeT3lEECF8k
         dmGKvZhUQHa+UYgJERkr3ISDq0WBrHTgb8n9AC5D5ffO0CXO7W95KMmZyLmg5yAE0Gfk
         pMgmtt/qLE+FvgdHjqzs+V1lKuHkDaDCYezFpfhJRw47n2Y+nx/6ZPj9ZU1vGxvDVYG7
         ub9jEGKtHOQqYxx84KqvICE2/RWel2beGRvSHMSTRgKCWt5buAcc9xKpgdV2JLUbAkRX
         C4Dg==
X-Gm-Message-State: ANoB5pntejqOTcuAjNfEDLgZcsmSEJjKSWnBkJ57XlDPsaU9vQk4Icm4
        AQ5MwADO6sA4MtGnBSVryagFJXteTKIYkyVq/aWw0w==
X-Google-Smtp-Source: AA0mqf70pl/z47fmpk4u4ZeWHoOSrV7lZsGiEEsaIoLkCXk5PZeeohOP4gcTGHGLHcH5obzGuI4SUFJO88mv9HjyoRg=
X-Received: by 2002:a81:4949:0:b0:36a:a52e:fe48 with SMTP id
 w70-20020a814949000000b0036aa52efe48mr12368442ywa.267.1668419871793; Mon, 14
 Nov 2022 01:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20221109194404.gonna.558-kees@kernel.org> <20221109200050.3400857-4-keescook@chromium.org>
In-Reply-To: <20221109200050.3400857-4-keescook@chromium.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Nov 2022 10:57:15 +0100
Message-ID: <CANpmjNNrYDNrRR8i+8xAFnmSjZ0Rdp-P14Sf9d+dadfsik18QA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] panic: Consolidate open-coded panic_on_warn checks
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Dmitry Vyukov <dvyukov@google.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Petr Mladek <pmladek@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 9 Nov 2022 at 21:00, Kees Cook <keescook@chromium.org> wrote:
>
> Several run-time checkers (KASAN, UBSAN, KFENCE, KCSAN, sched) roll
> their own warnings, and each check "panic_on_warn". Consolidate this
> into a single function so that future instrumentation can be added in
> a single location.
>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: David Gow <davidgow@google.com>
> Cc: tangmeng <tangmeng@uniontech.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/panic.h | 1 +
>  kernel/kcsan/report.c | 3 +--
>  kernel/panic.c        | 9 +++++++--
>  kernel/sched/core.c   | 3 +--
>  lib/ubsan.c           | 3 +--
>  mm/kasan/report.c     | 4 ++--
>  mm/kfence/report.c    | 3 +--
>  7 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index c7759b3f2045..1702aeb74927 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -11,6 +11,7 @@ extern long (*panic_blink)(int state);
>  __printf(1, 2)
>  void panic(const char *fmt, ...) __noreturn __cold;
>  void nmi_panic(struct pt_regs *regs, const char *msg);
> +void check_panic_on_warn(const char *reason);
>  extern void oops_enter(void);
>  extern void oops_exit(void);
>  extern bool oops_may_print(void);
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 67794404042a..e95ce7d7a76e 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -492,8 +492,7 @@ static void print_report(enum kcsan_value_change value_change,
>         dump_stack_print_info(KERN_DEFAULT);
>         pr_err("==================================================================\n");
>
> -       if (panic_on_warn)
> -               panic("panic_on_warn set ...\n");
> +       check_panic_on_warn("KCSAN");
>  }
>
>  static void release_report(unsigned long *flags, struct other_info *other_info)
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 129936511380..3afd234767bc 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -201,6 +201,12 @@ static void panic_print_sys_info(bool console_flush)
>                 ftrace_dump(DUMP_ALL);
>  }
>
> +void check_panic_on_warn(const char *reason)
> +{
> +       if (panic_on_warn)
> +               panic("%s: panic_on_warn set ...\n", reason);
> +}
> +
>  /**
>   *     panic - halt the system
>   *     @fmt: The text string to print
> @@ -619,8 +625,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>         if (regs)
>                 show_regs(regs);
>
> -       if (panic_on_warn)
> -               panic("panic_on_warn set ...\n");
> +       check_panic_on_warn("kernel");

What is the reason "kernel" in this context? The real reason is a WARN
- so would the reason "WARNING" be more intuitive?
