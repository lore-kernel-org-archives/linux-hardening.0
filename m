Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C8CC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 13:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiFXNRh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiFXNRg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 09:17:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852F52503
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A236FCE29C5
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3ABC3411C
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656076646;
        bh=BOgoPbK2petk8sm++DyS/UmCokh4wnJpMhpnJLnpsAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KakBtjQLMdbsL0rmJKh+dlwqFFcVNucGps1m03H1SJDBk7ULDMxMoQz7jAuACODuk
         okh9BZJ02TqBfTXNATmgBy1Mx1Laask70OgxrEhQIdIpo+yZG8iE+JYevl6oNvot/0
         HME7uDTWg5B5j/cuJTtVzZ+4easAQ4Q+C1CAgTWNyUsK94yxY5AXq5HP5MByxp6mpD
         3OFGAnBT3FsVUJoQJqymZuyn1atYk3XFWNDlpApk/gKJhlEB3QC/1ojdrQV7I37sj5
         BXdJY5Vv8pGfl0XwFH5GoGVpM2qf9bhX7XzgMCOvNhie2/u7aByiCX5UWi2fmNig6X
         aE/vM0t8JP4Sw==
Received: by mail-oi1-f175.google.com with SMTP id u9so3525435oiv.12
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:17:25 -0700 (PDT)
X-Gm-Message-State: AJIora+CIuTGYxjA8NtupHUs+fh2lvx7k67hqLXDBTrLpUd7PjpWvreZ
        rHf4FHe/cA+/J+ISt1jPQ6v4R8MzFUVFK7ec8MY=
X-Google-Smtp-Source: AGRyM1s7MnCvc2RYz0gY0HpRlBxm+mcUMOziFQ0lCbokw/po6+vu8fCgeE/FcvdT2vVpHweL2LYvBL1JltVajKBjs+Q=
X-Received: by 2002:a05:6808:13c6:b0:335:3e54:94bc with SMTP id
 d6-20020a05680813c600b003353e5494bcmr1895352oiw.228.1656076645112; Fri, 24
 Jun 2022 06:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-21-ardb@kernel.org>
 <20220624131617.GF18561@willie-the-truck>
In-Reply-To: <20220624131617.GF18561@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 15:17:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGDhrv2FAVj_giWrbw9P58inM4J8hW2c+-xB0YJ5AY1xg@mail.gmail.com>
Message-ID: <CAMj1kXGDhrv2FAVj_giWrbw9P58inM4J8hW2c+-xB0YJ5AY1xg@mail.gmail.com>
Subject: Re: [PATCH v4 20/26] arm64: head: avoid relocating the kernel twice
 for KASLR
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 24 Jun 2022 at 15:16, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 04:45:44PM +0200, Ard Biesheuvel wrote:
> > Currently, when KASLR is in effect, we set up the kernel virtual address
> > space twice: the first time, the KASLR seed is looked up in the device
> > tree, and the kernel virtual mapping is torn down and recreated again,
> > after which the relocations are applied a second time. The latter step
> > means that statically initialized global pointer variables will be reset
> > to their initial values, and to ensure that BSS variables are not set to
> > values based on the initial translation, they are cleared again as well.
> >
> > All of this is needed because we need the command line (taken from the
> > DT) to tell us whether or not to randomize the virtual address space
> > before entering the kernel proper. However, this code has expanded
> > little by little and now creates global state unrelated to the virtual
> > randomization of the kernel before the mapping is torn down and set up
> > again, and the BSS cleared for a second time. This has created some
> > issues in the past, and it would be better to avoid this little dance if
> > possible.
> >
> > So instead, let's use the temporary mapping of the device tree, and
> > execute the bare minimum of code to decide whether or not KASLR should
> > be enabled, and what the seed is. Only then, create the virtual kernel
> > mapping, clear BSS, etc and proceed as normal.  This avoids the issues
> > around inconsistent global state due to BSS being cleared twice, and is
> > generally more maintainable, as it permits us to defer all the remaining
> > DT parsing and KASLR initialization to a later time.
> >
> > This means the relocation fixup code runs only a single time as well,
> > allowing us to simplify the RELR handling code too, which is not
> > idempotent and was therefore required to keep track of the offset that
> > was applied the first time around.
> >
> > Note that this means we have to clone a pair of FDT library objects, so
> > that we can control how they are built - we need the stack protector
> > and other instrumentation disabled so that the code can tolerate being
> > called this early. Note that only the kernel page tables and the
> > temporary stack are mapped read-write at this point, which ensures that
> > the early code does not modify any global state inadvertently.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/Makefile         |   2 +-
> >  arch/arm64/kernel/head.S           |  73 ++++---------
> >  arch/arm64/kernel/image-vars.h     |   4 +
> >  arch/arm64/kernel/kaslr.c          |  87 ---------------
> >  arch/arm64/kernel/pi/Makefile      |  33 ++++++
> >  arch/arm64/kernel/pi/kaslr_early.c | 112 ++++++++++++++++++++
>
> Heh, how long before we get a decompressor in here too?
>

Right after BPF support :-)
