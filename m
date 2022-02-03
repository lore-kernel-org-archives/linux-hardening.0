Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4306AC433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 19:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353832AbiBCTus (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243439AbiBCTus (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 14:50:48 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D4C06173B
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 11:50:48 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id t14so5434871ljh.8
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVBeKDKPYFp+Sm22VFGesckBrKnktcRnAdKBFblfodE=;
        b=AbjtmmjGWQpWdgmjPMsIc8GVNpR6kfz4i/s3EjeX9oSZeV1gQ+cJTDv9UvwEH5rH6C
         kMf5vi9O1DUi3v8wRd+r927wglgfPiddZu468FnuMFIuDLhtL3ChMK/MxHI7PBY8gzQ/
         zLOk6W9kMaJbsX0qZJ4X9jOZ6qInlhIMmfIyV/8XOmLBwQhOwmWniKtgiynBLd825bbA
         5uSzfQYGoAvd0YSJGL+WNkDpnmx4YYLhUd06MnlzN/B455n933bNLVnktWVuVW1HPvAL
         YcUfyDkoaKoXtKRPjTYXPkTK/x5PDS1HKlZYI/K/8Dlhe6U9B1tNuyAqaavcy5dWL9Sl
         K7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVBeKDKPYFp+Sm22VFGesckBrKnktcRnAdKBFblfodE=;
        b=j2T/OTjuA/QLIo0g++tYU2zrJVIIAfTsOI6C/KVkMNbo860bNd6OVy5azaMxcQjygD
         TRxQFFpP1YRb+nd24IaeUvxoUt04JZsBaMFN8rJT5K/NIIoUKZNLZccIK910dSoOBAjA
         y3RBk+0G4GXoAxc19T4HuWAJFOmTmmPtEZFGeaTn9IQwqdpWWnaNR0Zi5AQmbAZOgBAw
         zBXBLfgX3UYA9AaPwfmI+4bftF0INbXiKNk6U78fQapmKxxCSfuAWXourPzYXzHY+Pq2
         3jOXsPuf83scAfvjx8DjZCP9x7XOI0EuXAynah+ItXqzyY/2JRopVJeLjVzmEyrMW30w
         i1Yw==
X-Gm-Message-State: AOAM532PDtpLgLMBbnCAujf5Fnj056UDEktLRqNxUKAQ2pRyf4ysnlPe
        Eqe1bJnEYKBdaAicv7Fhas+P5rZ5fQ0NNmbeRdjr4A==
X-Google-Smtp-Source: ABdhPJxc3sO/oNI/Ujb2wt/q0D3RYB++ahedSpN+JSsytdZf3f4yykiSmktj8jSXmlhjNSYVKgmXGFiLyRxkOQ+A/4w=
X-Received: by 2002:a2e:954:: with SMTP id 81mr14783838ljj.198.1643917846193;
 Thu, 03 Feb 2022 11:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net> <202202021237.487D3DE73@keescook>
 <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net> <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
 <202202030911.4914709E@keescook> <CAMuHMdUBKofPP-6EofE3B7d6k0zv0nPJ7e4pjsznPF==ApJ6qg@mail.gmail.com>
In-Reply-To: <CAMuHMdUBKofPP-6EofE3B7d6k0zv0nPJ7e4pjsznPF==ApJ6qg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 11:50:34 -0800
Message-ID: <CAKwvOdnJ3w2Jb9tBZ+JnEfviquj2WktemCd833f=_P66a0qVag@mail.gmail.com>
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 10:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Kees,
>
> On Thu, Feb 3, 2022 at 6:15 PM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Feb 03, 2022 at 09:04:22AM +0100, Geert Uytterhoeven wrote:
> > > Not if -ffreestanding, which is what several architectures are
> > > using nowadays, to a.o. prevent gcc from replacing calls to stdlib
> > > functions to other stdlib functions (e.g. strncat() -> strlen() +
> > > store, strncmp() -> strcmp()), which breaks linking if the latter is
> > > only provided inline.
> >
> > Hah, for i386:
> >
> > arch/x86/Makefile
> >         # temporary until string.h is fixed
> >         KBUILD_CFLAGS += -ffreestanding
> >
> > This "temporary" is from 2006. ;)\

IIRC I sent a patch removing that. Yeah, Kees even signed off on it.
https://lore.kernel.org/lkml/20200817220212.338670-5-ndesaulniers@google.com/#t
I still think that's the right way to go, perhaps worth a resend to
rekick discussions.

>
> And before that, we had it in the main Makefile.
>
> > 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to builtin")
> >
> > Removing that appears to solve it, and appears to build correctly. I'll
> > continue testing.
> >
> > > It works after dropping -ffreestanding.
> >
> > I wonder if the other architectures were just copying x86?
>
> At least on m68k it was added because gcc added new optimizations
> that broke if an architecture provides some functions as inline.
> As the kernel is not supposed to be linked with the standard C
> library, -ffreestanding should be correct, isn't it?

The kernel does not link against a libc; but it does provide many
symbols that libc would provide, with the same or similar enough
semantics that I would strongly recommend we _don't_ use
-ffreestanding in order to get such libcall optimizations (there are a
lot; see https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Utils/SimplifyLibCalls.cpp
for some examples) and simply use -fno-builtin-* when necessary, or
fix the kernel implementations individually.

-- 
Thanks,
~Nick Desaulniers
