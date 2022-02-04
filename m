Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A325C433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Feb 2022 00:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiBDA7O (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 19:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356349AbiBDA7M (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 19:59:12 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8A5C06173B
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 16:59:11 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z7so6397993ljj.4
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 16:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7KeA57I51/JIVqQa4MJpZeyTQ+nAZfh0KjGh2MyJYI=;
        b=GrHQdd3dcFl4hedxqDCjWQSUD5ym8BEtP1DqcvK0uzMyHkP96SP2KGwCr8EneebGlg
         3eXcdB0rMhcljYWYnWASrFjVyFqCBO93g5yZgWjzNofkS/p9ceHG93jObXLHSFwokE4q
         c9FO6CmbguQ4s7kDQIOMsbH/8ZJGQI3GdniBOzlQhozSVDvzImxWRvt4mfHqFnz3eSd+
         7HSl0iq1eldpuqkILsUH1ouIYSNtaceRaMTtWiA8ES5/BSfEGmp8T7cuvQsdYNoriRME
         BjNAO2q9BoNyXRHoYSmOC52bYu3WPRrcB2qvN7186YHXcOV0YmHjyTVTXAUOzdGUGS6T
         ymeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7KeA57I51/JIVqQa4MJpZeyTQ+nAZfh0KjGh2MyJYI=;
        b=tB5PctdAPTCbi7PQriq7KSsG/ZBoamtAjtuid4Ly6fMPJMxTlLPnVKPHE9qCkm9F8n
         Yz0vNmEpIN76L4b74UEpP2dqanPluRf10zpDFHOt5Y+LVJ3m8R8sCHG5ToG6pnqnJYps
         iobXDJEJC9pnk1KnqRORdfp2IYID55J9x56zNxbuIBj5omcR7ioIwJO7HhbNhSQAVukb
         ezNxgioFFlrVjfaY+D6E4AFzU7asRODY1jquO1b7g3ldXG500a+tgU9fT72Br7z95onG
         RcUtC0AAVoEVFxoRWJFX0f51ff+Hj7DrN9grIwgXj9GOGZUWX00G6eI5P36RyHjHYGec
         1tlg==
X-Gm-Message-State: AOAM532UwUO0nW5seBOOmd48QWwxL8khckExbKbyy+nr6QFGGuF3KNF4
        GXlMz6IdoKAj4brnMjUHwhZTPlqAbmciZlVZfKj92A==
X-Google-Smtp-Source: ABdhPJy0ozDt5HvXVEVqAROXrUgLZ+JesglIPHUMssfVg7v+JDCU6oq3ZSgJsV1Imap2fx9ReHcIOe7OihRU7xIB0wU=
X-Received: by 2002:a05:651c:1253:: with SMTP id h19mr363659ljh.338.1643936350075;
 Thu, 03 Feb 2022 16:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org>
 <20220203173307.1033257-3-keescook@chromium.org> <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
 <202202031301.437D8FD3@keescook> <CAKwvOdm-_uGYrm=2LTGSR7yhGK08NniGdkhLj_sM-QD-xdKVtA@mail.gmail.com>
 <202202031618.BC9EDA9D82@keescook>
In-Reply-To: <202202031618.BC9EDA9D82@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 16:58:58 -0800
Message-ID: <CAKwvOdnZJckq7svQfKTQUteDG9RozeCXAi8OtTnJsTifiLTnbQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 4:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Feb 03, 2022 at 02:11:48PM -0800, Nick Desaulniers wrote:
> > On Thu, Feb 3, 2022 at 1:04 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Feb 03, 2022 at 12:26:15PM -0800, Nick Desaulniers wrote:
> > > > On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > must be marked as being overloadable (i.e. different prototypes).
> > > > > This allows the __pass_object_size versions to take precedence.
> > > >
> > > > Is this because of the `const` additions to the function signatures?
> > >
> > > That might be an issue, but the *real* issue is the implicit mutation of
> > > the function into an inline with _additional_ arguments. i.e.
> > >
> > > char *strcpy(char * POS p, const char * POS q)
> > >
> > > is really
> > >
> > > char *strcpy(char * const p, const char * const q, size_t __size_of_p, size_t __size_of_q)
> > >
> > > (i.e. what I was doing with macros, but all internally and still an
> > > extern inline)
> >
> > What do you mean "is really"? 4/4 doesn't change the number of
> > parameters in strcpy explicitly in the definition AFAICT.
>
> It really does change the number of parameters. See the IR difference:
>
> $ cat example.c
> #ifdef USE_POS
> # define POS __attribute__((pass_object_size(1)))
> #else
> # define POS
> #endif
>
> int func(void * const POS);
>
> struct foo
> {
>         int a;
>         char *b;
> };
>
> void usage(struct foo *example)
> {
>         func(example);
> }
>
> $ IR="-O2 -Xclang -disable-llvm-passes -emit-llvm -S"
> $ clang           example.c $IR -o normal.ll
> $ clang -DUSE_POS example.c $IR -o pos.ll
> $ diff -u normal.ll pos.ll
> --- normal.ll   2022-02-03 16:23:39.734065036 -0800
> +++ pos.ll      2022-02-03 16:23:49.518083451 -0800
> @@ -11,14 +11,19 @@
>    store %struct.foo* %0, %struct.foo** %2, align 8, !tbaa !3
>    %3 = load %struct.foo*, %struct.foo** %2, align 8, !tbaa !3
>    %4 = bitcast %struct.foo* %3 to i8*
> -  %5 = call i32 @func(i8* noundef %4)
> +  %5 = call i64 @llvm.objectsize.i64.p0i8(i8* %4, i1 false, i1 true, i1 false)
> +  %6 = call i32 @func(i8* noundef %4, i64 noundef %5)
>    ret void
>  }
> ...

Woah, that's fancy.

>
> This is basically doing internally exactly what I was doing in v4 and
> earlier with macros (passing in the caller's view of __bos(arg, 1)).

Yeah. Ok now it all makes sense to me.

With the s/inline extern/extern inline/:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
