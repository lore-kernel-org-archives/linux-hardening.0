Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA432C433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Feb 2022 00:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356104AbiBDAF7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 19:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351538AbiBDAF6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 19:05:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1685C061714
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 16:05:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id h7so13843048ejf.1
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 16:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ISDGPFMmFCFRMv6XtajYWytElFJrKSoRG3VbxnD+cU=;
        b=a7C5HosVUzOfviPp7J5GFSuRy4H+UJf4c0y1E8FY6TLsicbJ1Nm6NocTdSdx9o/AI7
         3nEPLienLDhi4h8Kos2y62PPD60O5maKu2kYoOcesqsw77yS9TfDGtJh3VHmcM/TXPQ5
         DfTV6QkTPYpOXPYEbDTxSQLVZ7wBYad6Ty31JJleCIf4kfG7LJtdRBtje8WRFJ03b+Ms
         zalo1OG5Ef03sQ+eRvtEuO7oAL8ZGzgeeZqPo+/OroAzhTOHdu8t0YtoODIO2Ud4zL+t
         6Z2//LmTGysj7HdDXdqaLqP4lQjzFtySeyctv3gtY1rXzTn5RCKUQ7oAgi3/0RQkBi2q
         NykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ISDGPFMmFCFRMv6XtajYWytElFJrKSoRG3VbxnD+cU=;
        b=xo9KtC7Ee/6fAc6XXOXhJw/bAT3qSVQkYQhgk5tt3JFKYVODGV4VojVIVdcVuJvcN1
         sHMsIiM/8zeN/R/ogvx6679oy9HrQoj4ZwL2ouFP7tEbdwPuneC94NyBGhTaFny5zpp5
         187aWP5qH1mCEgxoSPBfBRwv84Si4B2eRATqG9el4w8IoeaAijxRq7P7padG0u0akbAL
         4XWUPiIs+wiJjmtNro4hlN8aHmK9/we0bEUSnmSe9HIW3P6RpR1VGBKB85jGWm8A2MBb
         qPMuUlrt6HKX6bsL/u5T7+ZzWQKBqsiPzq4H5YSMNsefUjxRpoBHHnjQvHbGxq4Nu/bW
         D4nw==
X-Gm-Message-State: AOAM531F9Zs7gOainUi+DT4o8hZiSNnULVGIreU54HkQ0MXa7F+tEikR
        qPsTzcUVjmp8PeDfgN0eWdesBtkD0H0St0NKBDQ=
X-Google-Smtp-Source: ABdhPJyUeczxenKJumAK0iGk5f0oSeSr3lH8CHCTWghL54zQiUoF6ALy0JPyE4Xt1geMe9z3T0fNk2+W3Nnk6NHlakk=
X-Received: by 2002:a17:907:6d02:: with SMTP id sa2mr295690ejc.198.1643933156463;
 Thu, 03 Feb 2022 16:05:56 -0800 (PST)
MIME-Version: 1.0
References: <202202021501.DA6594BFC@keescook> <CAMo8BfK46Va0qAtMHQzg+i053LUe_hGuqwg-WyL4_P0t2JnuRw@mail.gmail.com>
 <202202031328.21E25051@keescook>
In-Reply-To: <202202031328.21E25051@keescook>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 3 Feb 2022 16:05:45 -0800
Message-ID: <CAMo8BfKQuG4JarZEcB9eT3B3DOutyioq2h-VQuVZ05KrwD6Mnw@mail.gmail.com>
Subject: Re: How large is the xtensa pt_regs::areg array supposed to be?
To:     Kees Cook <keescook@chromium.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 1:56 PM Kees Cook <keescook@chromium.org> wrote:
> > > What should be happening here?
> >
> > pt_regs::areg is the current register window, but when we enter
> > the kernel from the userspace additional valid registers up the call
> > stack are saved here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/xtensa/kernel/entry.S?h=v5.16#n204
> > This is done because when the kernel is built with windowed ABI
> > we cannot have a mix of user and kernel registers in the physical
> > register file.
>
> This is a bit opaque for me to read, but it looks like it's a loop of
> 4-at-a-time of the "extra" registers?

Correct. That's because the register window may move 4, 8 or 12
registers at a time, so it's always a multiple of 4 registers.

> > The space for these registers is reserved here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/xtensa/kernel/entry.S?h=v5.16#n2102
> > by adding PT_REGS_OFFSET, which accounts for the
> > XCHAL_NUM_AREGS value, to the task stack address.
>
> Okay, so it seems like there are two "views" of the registers from an
> ABI perspective, the userspace view (struct pt_regs), and the kernel
> view which is struct pt_regs + more.

I'd say that's the different kinds of stack frames on the kernel stack.
I don't think we expose the structure itself to the userspace anymore.

> > For some reason during xtensa port development it was chosen
> > to have pt_regs::areg only cover the current register window. I guess
> > this was done as a common denominator for the user and kernel
> > stack frames and to avoid an exposure of XCHAL_NUM_AREGS
> > constant in the user-visible headers. Chris may have additional details.
>
> Right, that makes sense: pt_regs should be the shared user/kernel view.
>
> The compiler is mad about trying to access the extra registers from the
> pt_reg struct, so maybe a kernel-only struct could be used here?

I agree. Let me try to do this change.

-- 
Thanks.
-- Max
