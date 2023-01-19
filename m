Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0205BC004D4
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Jan 2023 20:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjASUTh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Jan 2023 15:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjASUTg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Jan 2023 15:19:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D959B12E
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jan 2023 12:19:34 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y11so4266459edd.6
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jan 2023 12:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwALFcrEiKMJKQDtzjjSGBC+/S37AZnAdeZoHTjv71c=;
        b=Njq65P8qY5m18g3GH2t0w3dsUdB8sQH/p0VvLnd1DZqbHJBKfxVxoVI5v1paDuzb/G
         KPqS2O0x9KOHyCCYmGES4RgQONH23PeN4N3vTs4kZeT0sTKmNfouCv58lm8NTI0dhUnO
         7oMO9lXt/jgJQH1QYvtMUAbvFu3FxNRZrkJSUI9JRS5cRCoMin+wqnXYMkEGV0o2egn9
         7iw92WXeIX8e8jFT6Ap+GGe+6kDuTDN2eUMWHX6YqslL6cQ0QBGCSw7Dwca6JlG+4+eP
         FMpa2cP0EFWSr4vkrIgbwJgaeLENpsCrblmfhBcJNzq51ZZc6hbw2fPuF2yIgcCgx+6f
         DB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwALFcrEiKMJKQDtzjjSGBC+/S37AZnAdeZoHTjv71c=;
        b=7WuOLZTR4tWQBl1YOgyrPKs7tOBZQElD1rhWOrM2reYZuEKw75mxOHfqQgGud/Wcqv
         ZXc/ZbwwkoX2+389STw2hHRIURq/AwP3akS08qMAp6DIzKU2h6A4UGVMwNRvRN8kI2Z8
         J1JUXqzJT/zBbKKBsHXiZalp7yf7E0mvtfE6Vy2lrOuYwxVElO3jywjzJdFfpvupgKgG
         knt7+CypLD1fHwJw8KTQPswa0N1nbEj72rYD7KAlhDo4h1/45GD2l2UewYu3zFpyPZFY
         SyfpWyI5tba6mFx61cSzb7i8Ufe2VMovodtpUm4/L7RhdmUqFXftHQIPEWK/FvhTJJ9v
         eCHA==
X-Gm-Message-State: AFqh2ko6iHuVdBaH3XWIY4iIwyzPwjTa/q7VMEMMlwRlKi0cAwFP0WCz
        TWeB7qVV7Xiyd/T51U+hk+SG5Ou8nTmQhhGeHfBF5w==
X-Google-Smtp-Source: AMrXdXvmH0GRGbwaV7u5oSOSaoK0g9rea6G6setaQjtfKdKGn4KEEffOqbcap4UQW7bxQuTToTvUKrVZdkyR5Uxyv3s=
X-Received: by 2002:a05:6402:221a:b0:49d:836e:21f9 with SMTP id
 cq26-20020a056402221a00b0049d836e21f9mr1588134edb.36.1674159572334; Thu, 19
 Jan 2023 12:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20221117234328.594699-2-keescook@chromium.org> <20230119201023.4003-1-sj@kernel.org>
In-Reply-To: <20230119201023.4003-1-sj@kernel.org>
From:   Seth Jenkins <sethjenkins@google.com>
Date:   Thu, 19 Jan 2023 15:19:21 -0500
Message-ID: <CALxfFW76Ey=QNu--Vp59u2wukr6dzvOE25PkOHVw0b13YoCSiA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] exit: Put an upper limit on how often we can oops
To:     SeongJae Park <sj@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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

> Do you have a plan to backport this into upstream LTS kernels?

As I understand, the answer is "hopefully yes" with the big
presumption that all stakeholders are on board for the change. There
is *definitely* a plan to *submit* backports to the stable trees, but
ofc it will require some approvals.


On Thu, Jan 19, 2023 at 3:10 PM SeongJae Park <sj@kernel.org> wrote:
>
> Hello,
>
> On Thu, 17 Nov 2022 15:43:22 -0800 Kees Cook <keescook@chromium.org> wrote:
>
> > From: Jann Horn <jannh@google.com>
> >
> > Many Linux systems are configured to not panic on oops; but allowing an
> > attacker to oops the system **really** often can make even bugs that look
> > completely unexploitable exploitable (like NULL dereferences and such) if
> > each crash elevates a refcount by one or a lock is taken in read mode, and
> > this causes a counter to eventually overflow.
> >
> > The most interesting counters for this are 32 bits wide (like open-coded
> > refcounts that don't use refcount_t). (The ldsem reader count on 32-bit
> > platforms is just 16 bits, but probably nobody cares about 32-bit platforms
> > that much nowadays.)
> >
> > So let's panic the system if the kernel is constantly oopsing.
> >
> > The speed of oopsing 2^32 times probably depends on several factors, like
> > how long the stack trace is and which unwinder you're using; an empirically
> > important one is whether your console is showing a graphical environment or
> > a text console that oopses will be printed to.
> > In a quick single-threaded benchmark, it looks like oopsing in a vfork()
> > child with a very short stack trace only takes ~510 microseconds per run
> > when a graphical console is active; but switching to a text console that
> > oopses are printed to slows it down around 87x, to ~45 milliseconds per
> > run.
> > (Adding more threads makes this faster, but the actual oops printing
> > happens under &die_lock on x86, so you can maybe speed this up by a factor
> > of around 2 and then any further improvement gets eaten up by lock
> > contention.)
> >
> > It looks like it would take around 8-12 days to overflow a 32-bit counter
> > with repeated oopsing on a multi-core X86 system running a graphical
> > environment; both me (in an X86 VM) and Seth (with a distro kernel on
> > normal hardware in a standard configuration) got numbers in that ballpark.
> >
> > 12 days aren't *that* short on a desktop system, and you'd likely need much
> > longer on a typical server system (assuming that people don't run graphical
> > desktop environments on their servers), and this is a *very* noisy and
> > violent approach to exploiting the kernel; and it also seems to take orders
> > of magnitude longer on some machines, probably because stuff like EFI
> > pstore will slow it down a ton if that's active.
>
> I found a blog article[1] recommending LTS kernels to backport this as below.
>
>     While this patch is already upstream, it is important that distributed
>     kernels also inherit this oops limit and backport it to LTS releases if we
>     want to avoid treating such null-dereference bugs as full-fledged security
>     issues in the future.
>
> Do you have a plan to backport this into upstream LTS kernels?
>
> [1] https://googleprojectzero.blogspot.com/2023/01/exploiting-null-dereferences-in-linux.html
>
>
> Thanks,
> SJ
>
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Link: https://lore.kernel.org/r/20221107201317.324457-1-jannh@google.com
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
