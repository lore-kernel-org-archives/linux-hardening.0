Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A33C433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 21:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiBCVNk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiBCVNj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 16:13:39 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47229C061714
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 13:13:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id d10so12647488eje.10
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 13:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2PAPpjwwsYTVETFhmrTMnXC1F2uM/xk1/d3fWifj9I=;
        b=cReHZFy+9l98g6+nI2GIt/CiMH21rgXiMb/H7zrgsrbYv+ZXCqLe7BvXZMuH0YCUY+
         WcCp8RwIsXtKVkvMCK7mnI3f9uJw4RBp+edl6iSIr5sxvVJVqHQcdIRh7xE6c5Gic2NN
         WKiIho3RY2zErUKIjbg6R7LTdC8FsB1GBJ3zI+qJHcwB3YAftHRWeVEQg5uXvPuS+3NE
         jpAcvDpjcBY06Jz3YdCTXjguPCT8Tg7AqU8jgOf2Q5Jj4QRRrgpm9b3V/q+nJZGERCgs
         YHdxVJwCpvLW4DVf5REgKWDlFCX41PKKgX9TiRk+t/ujfqGFbJ66Lp4tRqSNFtyrkplJ
         sVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2PAPpjwwsYTVETFhmrTMnXC1F2uM/xk1/d3fWifj9I=;
        b=ghHR0P4P+KCcqnQXGkcQ+n4LPZrWuhO2CSHXrs749DJ1xYQyalPZ/ZfDngB+Qhos5j
         s99gopBpJWQcrAFYqTHZRXgtS8Neh9/k5aLsjgN43rp2fCbM4SVkvN+CHzlrZaZxjZvw
         nped5rOMl/aTKJ/KdHU32SRRKj8OLS9WnQ7OFEaNLNH35nvvzthBBJsx4PnvOM4XOV+9
         I5a1kG6VlwI7dBybWq2awIAyfJozWcFSTnhHEp6g3q4MYgrQsDJzCPLeOexoj5TImwMs
         SXnqOyRyGC3/LvGwdr7zcnAFB9Rqwu8XHfysphxf2NktO9MqqDWyK5SVDiEfKz3IkH/m
         IF/A==
X-Gm-Message-State: AOAM53071vT6bH95ESmdZ/4tUQAoUXFw4UGA4AAr8TCn7utpKKvhntWy
        TGZBbymsxazVHqg6UVK4VFMtmT4Em8DIeWyRItc=
X-Google-Smtp-Source: ABdhPJyl9FUorGBfxP8rrCpFMfHKGF/Hqb2V8ZO+BZ2fX1S67C1oEwb7Y59YL/PBC3KJQEcJkLhXjN4E6OkjWSh2TnI=
X-Received: by 2002:a17:907:7b87:: with SMTP id ne7mr31213515ejc.556.1643922817756;
 Thu, 03 Feb 2022 13:13:37 -0800 (PST)
MIME-Version: 1.0
References: <202202021501.DA6594BFC@keescook>
In-Reply-To: <202202021501.DA6594BFC@keescook>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 3 Feb 2022 13:13:26 -0800
Message-ID: <CAMo8BfK46Va0qAtMHQzg+i053LUe_hGuqwg-WyL4_P0t2JnuRw@mail.gmail.com>
Subject: Re: How large is the xtensa pt_regs::areg array supposed to be?
To:     Kees Cook <keescook@chromium.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

On Wed, Feb 2, 2022 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
> When building with -Warray-bounds, I see this:
>
> In file included from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from arch/xtensa/kernel/process.c:21:
> arch/xtensa/kernel/process.c: In function 'copy_thread':
> arch/xtensa/kernel/process.c:262:52: warning: array subscript 53 is above array bounds of 'long unsigned int[16]' [-Warray-bounds]
>   262 |                                 put_user(regs->areg[caller_ars+1],
> ./arch/xtensa/include/asm/uaccess.h:171:18: note: in definition of macro '__put_user_asm'
>   171 |         :[x] "r"(x_), [efault] "i"(-EFAULT))
>       |                  ^~
> ./arch/xtensa/include/asm/uaccess.h:89:17: note: in expansion of macro '__put_user_size'
>    89 |                 __put_user_size((x), __pu_addr, (size), __pu_err);      \
>       |                 ^~~~~~~~~~~~~~~
> ./arch/xtensa/include/asm/uaccess.h:62:33: note: in expansion of macro '__put_user_check'
>    62 | #define put_user(x, ptr)        __put_user_check((x), (ptr), sizeof(*(ptr)))
>       |                                 ^~~~~~~~~~~~~~~~
> arch/xtensa/kernel/process.c:262:33: note: in expansion of macro 'put_user'
>   262 |                                 put_user(regs->areg[caller_ars+1],
>       |                                 ^~~~~~~~
> In file included from ./arch/xtensa/include/asm/processor.h:17,
>                  from ./arch/xtensa/include/asm/thread_info.h:20,
>                  from ./arch/xtensa/include/asm/current.h:14,
>                  from ./include/linux/sched.h:12,
>                  from arch/xtensa/kernel/process.c:19:
> ./arch/xtensa/include/asm/ptrace.h:80:23: note: while referencing 'areg'
>    80 |         unsigned long areg[16];
>       |                       ^~~~
>
>
> The code is:
>                                 int callinc = (regs->areg[0] >> 30) & 3;
>                                 int caller_ars = XCHAL_NUM_AREGS - callinc * 4;
>                                 put_user(regs->areg[caller_ars+1],
>                                          (unsigned __user*)(usp - 12));
>
> It looks like XCHAL_NUM_AREGS is larger than "16", though?
>
> struct pt_regs {
> ...
>         unsigned long areg[16];
>
> What should be happening here?

pt_regs::areg is the current register window, but when we enter
the kernel from the userspace additional valid registers up the call
stack are saved here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/xtensa/kernel/entry.S?h=v5.16#n204
This is done because when the kernel is built with windowed ABI
we cannot have a mix of user and kernel registers in the physical
register file.

The space for these registers is reserved here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/xtensa/kernel/entry.S?h=v5.16#n2102
by adding PT_REGS_OFFSET, which accounts for the
XCHAL_NUM_AREGS value, to the task stack address.

On the other hand, when the kernel is re-entered we don't need
to save registers up the kernel stack, so the pt_regs structure
exactly represents the kernel stack frame.

The xtensa architecture has configurable windowed registers option.
When it's enabled the machine has more than 16 general purpose
registers: typically 32 or 64, but only 16 of them are in the current
window and may be used by instructions.
The window rotates forward on entry to functions and backwards
on return. Additional special registers track current window
position and valid registers.

For some reason during xtensa port development it was chosen
to have pt_regs::areg only cover the current register window. I guess
this was done as a common denominator for the user and kernel
stack frames and to avoid an exposure of XCHAL_NUM_AREGS
constant in the user-visible headers. Chris may have additional details.

-- 
Thanks.
-- Max
