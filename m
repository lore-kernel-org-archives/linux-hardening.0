Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0187C433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 21:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiBCV4c (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiBCV4b (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 16:56:31 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5EBC061714
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 13:56:31 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h12so3659049pjq.3
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eliSfvb+BO2qlY+XFflmS5vnX6MFnOe/r4Oy2WMuO5k=;
        b=ivMcu32/m5GYTqc+dsK2UeWBIeL5PYd0bwRYflrgjqSITn2e/8A3V2iofgSJ9H+lZN
         ghWdAx0MzhJPEM7Ci+Ww7FQobXQ+NfRds2ynJB5Ez1Dzp6edgFCwNHOptyxvhHxTZHQb
         JUPnDYs3hKfuzWyK5dlGq5sXlONZLPLW3yqEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eliSfvb+BO2qlY+XFflmS5vnX6MFnOe/r4Oy2WMuO5k=;
        b=uMNzp2g1fETmkCEocPC5wBngeOAUZMmGg9US+iyMR4v1uvedy8A8VBs1ubUSmGhrwj
         zRb12/kSdzE1SrtyD/Lmo6yrxD6FnRwJkXA+lBa+GYJtvZ1XWXsjSLCtXUrtv+gr7rWU
         V1rJGK9RiBngv2IVKimKM8qjGHfBM1BmzGuseU2DIfC9ANtd3ifvHUibu/Gt4XQsEW/4
         Bwocu6rPKTz2Avnp21VXsgCdQsPjpyQTsgyAaWmq+hbKBqoLyVbAjzDU5+D2CjoQgaUK
         EVnXfX8wu2NjKVUlC0xggeARpZ9eh8pR1rSB5w3w5tt3n1wX9xr/3mjlRaXOZ2gR9gbU
         hBtw==
X-Gm-Message-State: AOAM531sviZbnIX3/QyFc+PkgTeaNPLg4gQ2oCEkip3wVLjHDlj/atIb
        Edwfc4P/pSReF4VAgEpO92l/CPoA+bTXWw==
X-Google-Smtp-Source: ABdhPJxuYA5KkMWxd+bsUZZF9YxUWRyYJLaa7nrOryJ15impEh6f04rTHbdDDF6Wvsnr9d+EIj6JKg==
X-Received: by 2002:a17:903:1212:: with SMTP id l18mr86614plh.45.1643925390943;
        Thu, 03 Feb 2022 13:56:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k8sm4970pgc.89.2022.02.03.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:56:30 -0800 (PST)
Date:   Thu, 3 Feb 2022 13:56:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-hardening@vger.kernel.org
Subject: Re: How large is the xtensa pt_regs::areg array supposed to be?
Message-ID: <202202031328.21E25051@keescook>
References: <202202021501.DA6594BFC@keescook>
 <CAMo8BfK46Va0qAtMHQzg+i053LUe_hGuqwg-WyL4_P0t2JnuRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfK46Va0qAtMHQzg+i053LUe_hGuqwg-WyL4_P0t2JnuRw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 03, 2022 at 01:13:26PM -0800, Max Filippov wrote:
> Hi Kees,
> 
> On Wed, Feb 2, 2022 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
> > When building with -Warray-bounds, I see this:
> >
> > In file included from ./include/linux/uaccess.h:11,
> >                  from ./include/linux/sched/task.h:11,
> >                  from arch/xtensa/kernel/process.c:21:
> > arch/xtensa/kernel/process.c: In function 'copy_thread':
> > arch/xtensa/kernel/process.c:262:52: warning: array subscript 53 is above array bounds of 'long unsigned int[16]' [-Warray-bounds]
> >   262 |                                 put_user(regs->areg[caller_ars+1],
> > ./arch/xtensa/include/asm/uaccess.h:171:18: note: in definition of macro '__put_user_asm'
> >   171 |         :[x] "r"(x_), [efault] "i"(-EFAULT))
> >       |                  ^~
> > ./arch/xtensa/include/asm/uaccess.h:89:17: note: in expansion of macro '__put_user_size'
> >    89 |                 __put_user_size((x), __pu_addr, (size), __pu_err);      \
> >       |                 ^~~~~~~~~~~~~~~
> > ./arch/xtensa/include/asm/uaccess.h:62:33: note: in expansion of macro '__put_user_check'
> >    62 | #define put_user(x, ptr)        __put_user_check((x), (ptr), sizeof(*(ptr)))
> >       |                                 ^~~~~~~~~~~~~~~~
> > arch/xtensa/kernel/process.c:262:33: note: in expansion of macro 'put_user'
> >   262 |                                 put_user(regs->areg[caller_ars+1],
> >       |                                 ^~~~~~~~
> > In file included from ./arch/xtensa/include/asm/processor.h:17,
> >                  from ./arch/xtensa/include/asm/thread_info.h:20,
> >                  from ./arch/xtensa/include/asm/current.h:14,
> >                  from ./include/linux/sched.h:12,
> >                  from arch/xtensa/kernel/process.c:19:
> > ./arch/xtensa/include/asm/ptrace.h:80:23: note: while referencing 'areg'
> >    80 |         unsigned long areg[16];
> >       |                       ^~~~
> >
> >
> > The code is:
> >                                 int callinc = (regs->areg[0] >> 30) & 3;
> >                                 int caller_ars = XCHAL_NUM_AREGS - callinc * 4;
> >                                 put_user(regs->areg[caller_ars+1],
> >                                          (unsigned __user*)(usp - 12));
> >
> > It looks like XCHAL_NUM_AREGS is larger than "16", though?
> >
> > struct pt_regs {
> > ...
> >         unsigned long areg[16];
> >
> > What should be happening here?
> 
> pt_regs::areg is the current register window, but when we enter
> the kernel from the userspace additional valid registers up the call
> stack are saved here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/xtensa/kernel/entry.S?h=v5.16#n204
> This is done because when the kernel is built with windowed ABI
> we cannot have a mix of user and kernel registers in the physical
> register file.

This is a bit opaque for me to read, but it looks like it's a loop of
4-at-a-time of the "extra" registers?

> The space for these registers is reserved here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/xtensa/kernel/entry.S?h=v5.16#n2102
> by adding PT_REGS_OFFSET, which accounts for the
> XCHAL_NUM_AREGS value, to the task stack address.

Okay, so it seems like there are two "views" of the registers from an
ABI perspective, the userspace view (struct pt_regs), and the kernel
view which is struct pt_regs + more.

> On the other hand, when the kernel is re-entered we don't need
> to save registers up the kernel stack, so the pt_regs structure
> exactly represents the kernel stack frame.
> 
> The xtensa architecture has configurable windowed registers option.
> When it's enabled the machine has more than 16 general purpose
> registers: typically 32 or 64, but only 16 of them are in the current
> window and may be used by instructions.
> The window rotates forward on entry to functions and backwards
> on return. Additional special registers track current window
> position and valid registers.
> 
> For some reason during xtensa port development it was chosen
> to have pt_regs::areg only cover the current register window. I guess
> this was done as a common denominator for the user and kernel
> stack frames and to avoid an exposure of XCHAL_NUM_AREGS
> constant in the user-visible headers. Chris may have additional details.

Right, that makes sense: pt_regs should be the shared user/kernel view.

The compiler is mad about trying to access the extra registers from the
pt_reg struct, so maybe a kernel-only struct could be used here?

-- 
Kees Cook
