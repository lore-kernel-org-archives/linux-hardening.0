Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76D6C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbiAXR6J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:58:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54268 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244771AbiAXR6J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:58:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE46CB811BC
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B245EC340F1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643047086;
        bh=aTHOQdCXQUnB/wNqjw3iDec2/r7CAqEr74J/pMucOlg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E6NQDyA/r5A5iytHS4aGp380BC04xTVs8K3wwCE2e750+Unzo3uVK0I+eMXOuRmI/
         v66Ew1QCJJcVp6oB1JWqpU2AvSPzIdT92Ibo3fKxQ6GT7Qc3sT6JcgWUq97JCQ74SC
         imZGXCXza9MbnzRrG0gxKIcw6YGiyeZAnRngnFdQsQAPGP9Dh06yIbMB53+P4zi+fG
         cOK01AZpYosXkKSzRV/UnQwyGR6wGSMU6STRgkjdhO7riw8Zpep89njVNo74p5jeEZ
         yrUopDB/hInJ6z2wsrFNtfHUfFZF1xI6HukVIZ4ARSE1yyumCy3serjb9fPmJqri26
         IsOyqL2XwwyeQ==
Received: by mail-wr1-f44.google.com with SMTP id w11so2949976wra.4
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:58:06 -0800 (PST)
X-Gm-Message-State: AOAM533so0VwKwpIFHCyMn49g/vHkq+iMhChLpyYigULDRNsWk37RJMW
        1Lf4BmHxRDRwz5pK1FeMYzeTPpuXh9T9jI0Hi2s=
X-Google-Smtp-Source: ABdhPJz2nq8tcg3HcmidBFh6YwjBU/lHKcpKZB6g/GHOXP7zcPL95P9UB+vxVacLoBLMXH6DBy9XQEZBySWbHR9M074=
X-Received: by 2002:adf:fa91:: with SMTP id h17mr14774846wrr.189.1643047084859;
 Mon, 24 Jan 2022 09:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20220124174744.1054712-1-ardb@kernel.org> <Ye7oabF/ewS0pSKw@shell.armlinux.org.uk>
In-Reply-To: <Ye7oabF/ewS0pSKw@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 24 Jan 2022 18:57:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXErsMZr61+NxPrGRxGk0th7sAzCDRMwGcnf08GK7-7OOw@mail.gmail.com>
Message-ID: <CAMj1kXErsMZr61+NxPrGRxGk0th7sAzCDRMwGcnf08GK7-7OOw@mail.gmail.com>
Subject: Re: [PATCH v5 00/32] ARM vmap'ed and IRQ stacks roundup
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 24 Jan 2022 at 18:57, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 24, 2022 at 06:47:12PM +0100, Ard Biesheuvel wrote:
> > This v5 series is a combined followup to
> >
> > - IRQ stacks support for v7 SMP systems [0],
> > - vmap'ed stacks support for v7 SMP systems[1],
> > - extending support for both IRQ stacks and vmap'ed stacks for all
> >   remaining configurations, including v6/v7 SMP multiplatform kernels
> >   and uniprocessor configurations including v7-M [2]
> >
> > [0] https://lore.kernel.org/linux-arm-kernel/20211115084732.3704393-1-ardb@kernel.org/
> > [1] https://lore.kernel.org/linux-arm-kernel/20211122092816.2865873-1-ardb@kernel.org/
> > [2] https://lore.kernel.org/linux-arm-kernel/20211206164659.1495084-1-ardb@kernel.org/
> >
> > This work was queued up in the ARM tree for a while, but due to problems
> > with the vmap'ed stacks code, which was difficult to revert in
> > isolation, the whole stack was dropped again.
> >
> > In order to prevent similar problems from occurring this time around,
> > the series was reorganized so that the vmap'ed stacks changes appear at
> > the very end, which also results in a more natural progression of the
> > changes.
> >
> > Changes since v4:
> > - incorporate fixups to avoid build failures on Clang related to
> >   literals in subsections,
> > - switch from the ID map to swapper_pg_dir as early as possible when
> >   onlining a CPU on !LPAE, to ensure that the stack is mapped,
> > - use SMP_ON_UP patching to elide HWCAP_TLS tests on SMP+v6,
> > - clean up __switch_to() for Thumb2 a bit more,
> > - add patch to make the vmalloc_seq counter SMP safe,
> > - use enter_lazy_tlb() hook on !LPAE to ensure that the active_mm used
> >   by a kernel thread has a mapping for its vmap'ed stack,
>
> Hi Ard,
>
> I still have the original code in devel-stable, and being a guaranteed
> stable branch, it's not something I'll be dropping... Please can I have
> fixes on top of what is already there please?
>

Sure.
