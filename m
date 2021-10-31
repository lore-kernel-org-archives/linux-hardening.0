Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4601C433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924B560EE3
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 16:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhJaQ06 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 31 Oct 2021 12:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhJaQ06 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 31 Oct 2021 12:26:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F07C60FC1;
        Sun, 31 Oct 2021 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635697466;
        bh=jpYWVVXaXaqn2deTdXgq4vDHJddb9QdR0vfJzy/9xX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NoB5v3ayLk1+zKhjY4jXxLc9RwN9Xm4D7CsoFLntTApdwIv3LPAQ2MCpsi/fMBlme
         3+WyFfSsZ7UCo7OiBW5fmecnIk04VfjS+h98w3F37r3GaQWMIkcWUMTAn9lc6QbtJJ
         LWxhI+Nlo7Sz8Gt6mvI0wGMcoC8VNzw8EpnQFSjVEeMf9T9DeqIhzaqz0X2DSPpJlD
         +jr7qOGKK4tLozHT+yDvnalAnrloxbFqoei6Y5AHPGtvS1zl8Vk/6sehh+haEg2pAE
         QB7zr0afomR0pPW/KSTNxLQl5RJ+p9WygIciPfJUlwpFbCSnQ6DT7XGivHfP21zfJT
         ceq73t+gEMRdg==
Received: by mail-oo1-f53.google.com with SMTP id t7-20020a4aadc7000000b002b8733ab498so5422914oon.3;
        Sun, 31 Oct 2021 09:24:26 -0700 (PDT)
X-Gm-Message-State: AOAM531NEmlVaoY/SJe18mzplICptYeyv0jXWdcDEjTPt/M8Pp39sO1Z
        xiaZ6ehf4YhCWqwHgjBE3EQv/1uxPiKVF3IuGnc=
X-Google-Smtp-Source: ABdhPJzEWcHVPu4UaWRx6YJt3C/BPIQIBQE6UW6SFL+z3NSkhA576P5O8eRYUm3qt8BTe6xt4bCqowZMhXwZi+oLuNI=
X-Received: by 2002:a4a:e1a3:: with SMTP id 3mr10141000ooy.32.1635697465245;
 Sun, 31 Oct 2021 09:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net> <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net> <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
 <20211029200324.GR174703@worktop.programming.kicks-ass.net>
 <20211030074758.GT174703@worktop.programming.kicks-ass.net>
 <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com>
 <20211030180249.GU174703@worktop.programming.kicks-ass.net> <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 31 Oct 2021 17:24:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
Message-ID: <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 30 Oct 2021 at 20:55, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 30 Oct 2021 at 20:03, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Oct 30, 2021 at 07:19:53PM +0200, Ard Biesheuvel wrote:
> > > I just realized that arm64 has the exact same problem, which is not
> > > being addressed by my v5 of the static call support patch.
> >
> > Yeah, it would.
> >
> > > As it turns out, the v11 Clang that I have been testing with is broken
> > > wrt BTI landing pads, and omits them from the jump table entries.
> > > Clang 12+ adds them properly, which means that both the jump table
> > > entry and the static call trampoline may start with BTI C + direct
> > > branch, and we also need additional checks to disambiguate.
> >
> > I'm not sure, why would the static_call trampoline need a BTI C ? The
> > whole point of static_call() is to be a direct call, we should never
> > have an indirect call to the trampoline, that would defeat the whole
> > purpose.
>
> This might happen when the distance between the caller and the
> trampoline is more than 128 MB, in which case we emit a veneer that
> uses an indirect call as well. So we definitely need the landing pad
> in the trampoline.

Something like the below seems to work to prevent getting the wrong
trampoline address into arch_static_call_transform:

diff --git a/arch/x86/include/asm/static_call.h
b/arch/x86/include/asm/static_call.h
index cbb67b6030f9..c3704ea21bee 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -25,7 +25,9 @@
        asm(".pushsection .static_call.text, \"ax\"             \n"     \
            ".align 4                                           \n"     \
            ".globl " STATIC_CALL_TRAMP_STR(name) "             \n"     \
+           ".globl " STATIC_CALL_TRAMP_P_STR(name) "           \n"     \
            STATIC_CALL_TRAMP_STR(name) ":                      \n"     \
+           STATIC_CALL_TRAMP_P_STR(name) ":                    \n"     \
            insns "                                             \n"     \
            ".type " STATIC_CALL_TRAMP_STR(name) ", @function   \n"     \
            ".size " STATIC_CALL_TRAMP_STR(name) ", . - "
STATIC_CALL_TRAMP_STR(name) " \n" \
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 19dc210214c0..46777a3395d3 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -143,7 +143,7 @@
  */
 extern void arch_static_call_transform(void *site, void *tramp, void
*func, bool tail);

-#define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
+#define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP_P(name)

 #else
 #define STATIC_CALL_TRAMP_ADDR(name) NULL
diff --git a/include/linux/static_call_types.h
b/include/linux/static_call_types.h
index 5a00b8b2cf9f..98a448f5ae45 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -18,6 +18,8 @@
 #define STATIC_CALL_TRAMP(name)
__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)    __stringify(STATIC_CALL_TRAMP(name))

+#define STATIC_CALL_TRAMP_P(name)      __PASTE(STATIC_CALL_TRAMP(name), _p)
+#define STATIC_CALL_TRAMP_P_STR(name)  __stringify(STATIC_CALL_TRAMP_P(name))
 /*
  * Flags in the low bits of static_call_site::key.
  */
@@ -36,7 +38,8 @@ struct static_call_site {

 #define DECLARE_STATIC_CALL(name, func)
         \
        extern struct static_call_key STATIC_CALL_KEY(name);            \
-       extern typeof(func) STATIC_CALL_TRAMP(name);
+       extern typeof(func) STATIC_CALL_TRAMP(name);                    \
+       extern u8 STATIC_CALL_TRAMP_P(name);

 #ifdef CONFIG_HAVE_STATIC_CALL

That leaves the 'func' argument, which ideally should not go through
the jump table either, but at least it is not terminally broken there.
