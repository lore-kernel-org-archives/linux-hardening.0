Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A93DC43334
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Jun 2022 16:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiFPQcN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiFPQcM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Jun 2022 12:32:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A02F007
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4880CE25CB
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 16:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B81BC385A5
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655397128;
        bh=68KMwojzJCK4HDo+zzEQ97VG/cq8WpIs1az2/0a3ubY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mnY8bDgzjXaa03pmxgbWvN7q9sL5bOxsUP9H2FgKff5T4xzN6LH/pQN15mjkWRn6e
         nBPJeeei+k9jNiqxcKvXU57e8gwYi3apJIA6IMz72hHD2s/IJ/48lHeAHifQfI5i5D
         ILYLdW8hQwgB/AGJ79quRn+Acr9CkrXZ2YNcnO+BeG7/YDi4TNbzMUVvs5qKmrKR+r
         dAXLm27eGnBqaNDvhAtXl5IciMoVuSI8oEz486ltN7TYPWEnDu4kMM6KAeaBr3qRbD
         cwoSWCGjJ9xOT/DMFINiYGqEC65e5RDkVgqo0xjNYYQmcZ+iLwv8TPhJ7x0AtETh2l
         BzJ3TYlMv1how==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-fe15832ce5so2504413fac.8
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:32:08 -0700 (PDT)
X-Gm-Message-State: AJIora9NDcjBPokVHMwgnfXss16uHfl6bWMjkl0XEzJzF88IdmqFT1fz
        9H+yKjZgi/DU/KCG92ALZ5Ou7wojFBNQeHh0oHA=
X-Google-Smtp-Source: AGRyM1t3bNoadCfAsnWRGwsdKVMBCjqK+tSgOQPu8wIoskU/wOZ2NKMjk7XQzowUTuch1+Mc0jCjnvBqdmFhLq8Ct/M=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr3226437oan.126.1655397127282; Thu, 16
 Jun 2022 09:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-23-ardb@kernel.org>
 <202206130959.3C01F529@keescook> <CAMj1kXG8MsL5NHN61W+58Q2di1o9P3kaxUCNe4D5sXcdLhOkUQ@mail.gmail.com>
 <202206131630.B6AE6ECEA3@keescook> <CAMj1kXHP8+yErY8F3wzc8=sWfqUYxCJ_AtW0_Gugng-0cpEXPA@mail.gmail.com>
 <202206160917.D7DB8221@keescook>
In-Reply-To: <202206160917.D7DB8221@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Jun 2022 18:31:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG8mWVkrGtb-eSASrOBK4BiMF1b5XUui2cVt33xi23Mwg@mail.gmail.com>
Message-ID: <CAMj1kXG8mWVkrGtb-eSASrOBK4BiMF1b5XUui2cVt33xi23Mwg@mail.gmail.com>
Subject: Re: [PATCH v4 22/26] arm64: mm: move ro_after_init section into the
 data segment
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 16 Jun 2022 at 18:18, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 16, 2022 at 01:31:23PM +0200, Ard Biesheuvel wrote:
> > We used to have
> >
> > text
> > --
> > rodata
> > (ro_after_init)
> > --
> > inittext
> > --
> > initdata
> > --
> > data
> > bss
> >
> > where -- are the segment boundaries, which are always aligned to 64k on arm64
> >
> > After this patch, we get
> >
> > text
> > --
> > rodata
> > --
> > inittext
> > --
> > initdata
> > --
> > (ro_after_init)
> > data
> > bss
> >
> > so in terms of padding due to alignment, there is not a lot of difference.
>
> But how is ro_after_init read-only and data isn't, if there isn't a
> segment alignment to make that work out?
>

Actually, there is a segment alignment between ro_after_init and data
- my diagram is inaccurate. But we don't actually need that to remap
this slice of memory r/o
