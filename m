Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3837C43217
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Nov 2022 21:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKIVtF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiKIVtE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Nov 2022 16:49:04 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718AE2F39F
        for <linux-hardening@vger.kernel.org>; Wed,  9 Nov 2022 13:49:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f5so301266ejc.5
        for <linux-hardening@vger.kernel.org>; Wed, 09 Nov 2022 13:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cnCKimjPnszuIv7P7tspkRhy5Ca1GNkxCTByBpzQ+sI=;
        b=DO9FR6ZD8ZIFh+aT5h4gwblO1n9ghAWy3MsuSo3TmN7NhzBNojKqBDaAOyjojPXBpb
         2apvdXr1918BW/PGEEnPwlYhi00OUDvvaN6HBtkWxJvxACQMtWImcvQB9v/0iOJ8C+xl
         tJHnnlH4FWdcXpQT3kBvkMyMvMnwsS9vhSGxa8N8daChnXdybjvYQCSwDiawdsC1TMkj
         CHU04xFNEn7j8Q9B/F07yQKjkM1nCiGvBEAoBVYVWIrikEcdXLsyMzcCEMnYcKWCtYkO
         yV4FZUnABZSnS2NkNwyo2QEUHICiCYQmL+WUQAs8EHwZRUxSg4ZHHPOeyb/Ehtc/klrr
         JI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnCKimjPnszuIv7P7tspkRhy5Ca1GNkxCTByBpzQ+sI=;
        b=dRGoIs5bDxWLPZ8weK2yjsmF88v30/zqlbmd8RKNTQ1AE/1VVKlvnPbWalAS9BEmiq
         WmTt8RIsb5VcybQl/nm/SJSo2HxuXN7IM/0NqrGG6T+4cCzaz+njhIyS2mJbNnrG4V3B
         tIIy4Y7QLRzkL0KEVZ2/ThmXvnmeFVyfhCAwMVoW0JPu3WAHIFSAc5enJXJ6SohoUX1S
         fvgBEVcxjUsaP38zbSeAs8Gbu+jtAS245sFgNt4hfm1P1rNCltBfDw50FPfKEhEQiDSB
         ZfodPA6orLsEIaHa2nkaqfn9VCYowXVMMgMXqTXOX8Lu2oC6EE72+4xprthuEp2BHt7g
         +i+g==
X-Gm-Message-State: ACrzQf0Pnwsc1OdPzssCbcpxa+cqL3cgSbOF0yLX1h4KPQtdSnfUkr3u
        SylhdeXlAmXMBJzXQcEhq9jIzun0sd749C4z6jiB
X-Google-Smtp-Source: AMsMyM4GI/CT8J2vgpNPmtw7prru+BKDWcCBKJuFSaTiFl13pqM1mmfcmz/5X1/dsZC/odHmQ3nDLRca52uPdbt1N30=
X-Received: by 2002:a17:906:c839:b0:78a:d0a4:176 with SMTP id
 dd25-20020a170906c83900b0078ad0a40176mr1831678ejb.720.1668030541823; Wed, 09
 Nov 2022 13:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20221109194404.gonna.558-kees@kernel.org> <20221109200050.3400857-1-keescook@chromium.org>
In-Reply-To: <20221109200050.3400857-1-keescook@chromium.org>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 9 Nov 2022 13:48:45 -0800
Message-ID: <CAGG=3QXM3u_uz1fuW2LzvrZqqPhYL15m+LJgD39R=jkuyENmYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] panic: Separate sysctl logic from CONFIG_SMP
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 9, 2022 at 12:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> In preparation for adding more sysctls directly in kernel/panic.c, split
> CONFIG_SMP from the logic that adds sysctls.
>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: tangmeng <tangmeng@uniontech.com>
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/panic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index da323209f583..129936511380 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -75,8 +75,9 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
>
>  EXPORT_SYMBOL(panic_notifier_list);
>
> -#if defined(CONFIG_SMP) && defined(CONFIG_SYSCTL)
> +#if CONFIG_SYSCTL

Should this be "#ifdef CONFIG_SYSCTL"?

>  static struct ctl_table kern_panic_table[] = {
> +#if defined(CONFIG_SMP)

nit: This could be "#ifdef CONFIG_SMP"

>         {
>                 .procname       = "oops_all_cpu_backtrace",
>                 .data           = &sysctl_oops_all_cpu_backtrace,
> @@ -86,6 +87,7 @@ static struct ctl_table kern_panic_table[] = {
>                 .extra1         = SYSCTL_ZERO,
>                 .extra2         = SYSCTL_ONE,
>         },
> +#endif
>         { }
>  };
>
> --
> 2.34.1
>
