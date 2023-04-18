Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37CEC77B78
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Apr 2023 12:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjDRMNx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Apr 2023 08:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjDRMNi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Apr 2023 08:13:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFA0A5F8
        for <linux-hardening@vger.kernel.org>; Tue, 18 Apr 2023 05:13:16 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-760f29073b4so43146339f.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Apr 2023 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681819995; x=1684411995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3C41xG4p1BHPpadBDL6pJd1psfwz5yd3WchMAQj7wTI=;
        b=iK9lD1FZ7y5HJfDMDPFNomptkcBgNl6axnqn78SLgX4K2qOYsNBuDL+7R2yWQ3rMTU
         s5S1gJmLLBclLDdkNeWaJ5aqxevBkq27swt/1UY7C1yb/Ue/wnfbQJoxHOKQfZVorXth
         fsfwhmoMg1UWXgD09Rxnyb1s3m71WxbZzI+6ZQd+qlR+fn21cLSm9apNSG3WXxnauMYx
         Uo/d+qzMrzNrRxL26/NoDjhgSo/qvdfP1m+7SoVhCMdFY7F9rqPDrx2PITxbBaM76N9D
         a/Y26HlytOuPVd8gUnnIeXsBrbiI16SYU5yIFamRWkgmEaNjf3xW4WUGWGQybykWTmRv
         R3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819995; x=1684411995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3C41xG4p1BHPpadBDL6pJd1psfwz5yd3WchMAQj7wTI=;
        b=e7gaKj8B8rHg2oS8lqxSl8J1En/4x4RiQ73Z0zqa30gIk/kjueh6yhKTdEpLf+hMFt
         8bkhzBPrLIM52+mQEmOLBvUkCXNNj8KCzFtjb05LBJzVJyOYrXrPQrPiz2AF3fg2uxRN
         +2oAifmHiCMbcEbVE8GxtlOVpTl1eJFzlOqR/i0R0odDrAXJpbrpapRb6iZPXs1+sThI
         xYyYD02hify0vFqIN5QAKmznoGQYUmXomhIBZLegdAeHqMdu/eOQDgZM3RYhv8i4TDPU
         D2rWd8G54Y+30T8tf5EXHTNHEVeUncQHmb6YbYNJnI6kEROucXwqsyi8at3a2wU2OSb9
         b02Q==
X-Gm-Message-State: AAQBX9dfZ/rCfsw4zbLew+wwVu2qQ+c2IUZznmXKJ3nvzNfvZ9nDJRLl
        ln+/yTe6kLnOCS0e6sGuqxDQTiWv4QXcoPu9cMGZXQ==
X-Google-Smtp-Source: AKy350ZfZvWa02fGm9TNYBrnOE+KkUawW1Q+TjXvWWE0Le8UwLNHTJEKGZCr3PzZ4WA37tJhHE1QeuNMJWiiACAZIic=
X-Received: by 2002:a6b:6e06:0:b0:762:7e58:8d38 with SMTP id
 d6-20020a6b6e06000000b007627e588d38mr1759080ioh.10.1681819995595; Tue, 18 Apr
 2023 05:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230224085942.1791837-1-elver@google.com> <ZDgOSp30Ec00u8wP@arm.com>
In-Reply-To: <ZDgOSp30Ec00u8wP@arm.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 14:12:39 +0200
Message-ID: <CANpmjNMNNc8yizJE8T1+Xrg1rGm+EbBuqybF9j1YE9miqdtasA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] kasan: Emit different calls for instrumentable memintrinsics
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 13 Apr 2023 at 16:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Marco,
>
> On Fri, Feb 24, 2023 at 09:59:39AM +0100, Marco Elver wrote:
> > Clang 15 provides an option to prefix memcpy/memset/memmove calls with
> > __asan_/__hwasan_ in instrumented functions: https://reviews.llvm.org/D122724
> >
> > GCC will add support in future:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108777
> >
> > Use it to regain KASAN instrumentation of memcpy/memset/memmove on
> > architectures that require noinstr to be really free from instrumented
> > mem*() functions (all GENERIC_ENTRY architectures).
> >
> > Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> > Signed-off-by: Marco Elver <elver@google.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> [...]
> > diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> > index b9e94c5e7097..fa9f836f8039 100644
> > --- a/scripts/Makefile.kasan
> > +++ b/scripts/Makefile.kasan
> > @@ -38,6 +38,11 @@ endif
> >
> >  CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
> >
> > +# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
> > +# instead. With compilers that don't support this option, compiler-inserted
> > +# memintrinsics won't be checked by KASAN on GENERIC_ENTRY architectures.
> > +CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix=1)
> > +
> >  endif # CONFIG_KASAN_GENERIC
> >
> >  ifdef CONFIG_KASAN_SW_TAGS
> > @@ -54,6 +59,9 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
> >               $(call cc-param,hwasan-inline-all-checks=0) \
> >               $(instrumentation_flags)
> >
> > +# Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
> > +CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>
> This patch breaks the arm64 kernel builds with KASAN_SW_TAGS enabled and
> clang prior to version 15. Those prior clang versions don't like the
> '-mllvm -hwasan-kernel-mem-intrinsic-prefix=1' option, end up printing
> the help text instead of generating the object.
>
> Do we need some combination of cc-option and cc-param? Or at least
> disable this instrumentation if earlier clang versions are used.
>
> It's already in mainline as commit
> 51287dcb00cc715c27bf6a6b4dbd431621c5b65a.

Arnd posted a patch, but the reason why a workaround is needed is
quite unfortunate:
https://lore.kernel.org/all/CANpmjNMwYosrvqh4ogDO8rgn+SeDHM2b-shD21wTypm_6MMe=g@mail.gmail.com/

Clang apparently interprets unknown options that start with "-h..",
i.e. "-mllvm -h..." as a request to print help text, which has exit
code 0. So this is only a problem for hwasan options.
