Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B718C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E454860720
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhKBSot (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhKBSor (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 14:44:47 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67817C061714
        for <linux-hardening@vger.kernel.org>; Tue,  2 Nov 2021 11:42:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 17so33322399ljq.0
        for <linux-hardening@vger.kernel.org>; Tue, 02 Nov 2021 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU3IvN447Oa6v5SNMQuatsfSqvi8zqVqEBJCQz6Y79c=;
        b=gWkxjg0fvMNOhRMLGeDwvOaGHpVXqjiA+pezg7rnoJkLSIuZBpMIrPRbF8VK3yPMEi
         YYsJl29gKNejq4JXqRnnmUP8zuXl4kvDiLCka3etP4jMcL6VoJ2C7XPnYDJNvzRJD/cb
         yU6jaOdXdM6xR9RTwHFn/JjATv4A7g2IajvHYM6U5EMHogI1BnSTSShQbdJhwjY1m5qG
         sFPeA2wluRvPbnxcuvmcUvYZ+gdZZVde/uGCOVP/o3bM/WSYv/El4l4LIBD4FwZdXavi
         ttUelSB3bKqp92i8UfN7oTfaq4wiwKG2vUXykD7ZLyad/u6Uw5982q1jFWunOXZDZyQt
         qksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU3IvN447Oa6v5SNMQuatsfSqvi8zqVqEBJCQz6Y79c=;
        b=Ek6dahVCB7feSNFcXfX1sd8e5hj/5JMwjiXaEFuZnkmP4uv2ymlAkNZpzv0DAV5zUr
         wVfnN8MMkU6MbvEoTIaw8LPwquevvPtoXi0KQUcmei0QGSukHd4qeWZ3xlG+QHSWirub
         HB9OfslTcYLqkj3Z946nXRtHBz4WdPs1g5J01hhfiSe20xeYeG40naMBQY9TGZr7a/6O
         HayrP9vVBmkFkwi53dGfHm+fxu8YHjAI/HhTDBK3m+91+TdKYspGlamHaD8vv3uEfe21
         3rCUoF0URicNS0lS+bARCzYZeznJKmsOx87U1RpolJxfcW8hXxNT08iAWjIdAcvqCSNB
         V8Vw==
X-Gm-Message-State: AOAM533jjwGR3+CN08lhUQurhYqXNcfe4520BoSLi30NKl0yXq80U24N
        o46Cku63+Naw+uB8wkyfPk/3rA9cDq0fm30HKU4jfg==
X-Google-Smtp-Source: ABdhPJyth7OBnD3MT86OZMx0g95k9WZ5Co7iL1GSxnJLlaed3WKLJYSW7PCdXUdm/Y8qssU/BeYv4Itr17n2YTUuJZw=
X-Received: by 2002:a2e:8183:: with SMTP id e3mr6909932ljg.526.1635878530498;
 Tue, 02 Nov 2021 11:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211102075812.122715-1-ashimida@linux.alibaba.com> <CANiq72meBX1g6z2-vfNpMw2C8S-BavuA4CTyPLpD4zUcX193Sw@mail.gmail.com>
In-Reply-To: <CANiq72meBX1g6z2-vfNpMw2C8S-BavuA4CTyPLpD4zUcX193Sw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Nov 2021 11:41:58 -0700
Message-ID: <CAKwvOd=0GpX59U1ndzahJ8mh26C-Gb54pjwUk4eYigb0ZoCiwg@mail.gmail.com>
Subject: Re: [PATCH] [RFC/RFT] AARCH64: Add gcc Shadow Call Stack support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Dan Li <ashimida@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, frederic@kernel.org,
        yifeifz2@illinois.edu, Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, andreyknvl@gmail.com,
        Colin King <colin.king@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Marco Elver <elver@google.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 2, 2021 at 2:52 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Nov 2, 2021 at 8:58 AM Dan Li <ashimida@linux.alibaba.com> wrote:
> >
> > I tried to submit a patch[1] to add compiler's SCS support on gcc-11.1.0.
>
> This would go into GCC 12, right?
>
> > [1] https://gcc.gnu.org/pipermail/gcc-patches/2021-November/583062.html
>
> Nit: you can use the `Link: ` tag for this.
>
> >  # Supported by clang >= 7.0
>
> We should add a comment here saying the minimum version too, e.g. GCC
> >= 12 (assuming it will be merged)
>
> >  config CC_HAVE_SHADOW_CALL_STACK
> > -       def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
> > +       def_bool CC_IS_CLANG || $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
>
> This is changing the default for Clang (which looks fine due to our
> minimum Clang version), but if the test for GCC works the same way,
> why not just keep the line as it was since it covers both?

Yeah, let's just have the cc-option check used for both toolchains.

> > +#if __has_attribute(__no_sanitize_shadow_call_stack__)
> > +#define __noscs __attribute__((no_sanitize_shadow_call_stack))
> > +#else
> > +#define __noscs
> > +#endif
>
> No need for the `else` branch here, it is done in `compiler_types.h`
> (to be consistent with Clang).

Do we want to move this to include/linux/compiler_attributes.h?
Respecifying these repeatedly in each include/linux/compiler-*.h feels
excessively redundant.

> Also, I hope one day GCC and Clang doing the same for these
> sanitize-related bits...

...
-- 
Thanks,
~Nick Desaulniers
