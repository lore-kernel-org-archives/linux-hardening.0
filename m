Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0747CCA482
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 19:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245610AbiFMTT4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350725AbiFMTTM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D593152B
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 10:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 711D460C24
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 17:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1895C3411B
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655140588;
        bh=a4a7RQFOWUWwE9jtPWwe8YKTM+ofPY+Fx/fym3wDfeY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a63LvOLPYKfkzKa+zxRU7QrfDfDzkCu0OM/KnHdP6NalG9DhdUbJ4Ab8QXb5pinc9
         tv2eVp+cQNsdjhZJ13EM/7F2cItGAVQfxBLy3MB9aa4Xv1Xu2yOQxWrcPXhHtQCjxt
         6IBYKvLICn7AVi0cvYIUkfFisa8lnhD0oDHKcBFA6IbgR1IvzrbAQPprWe5sBZ398g
         VgFR1w5DZQna2IS5ARE6Z8QyY/o89Gc2tEJj2ILMvptccYtjkhisM15f7zzLZUkafh
         cbV4pKbJKXpzc63xrG0poi94L62moAdT/WoV6IfozbMSu73u3QETaTOdBQHwiitm19
         Ff8SHjBwZI+3g==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-10113b4c2b5so7568801fac.6
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 10:16:28 -0700 (PDT)
X-Gm-Message-State: AOAM531LYkoS/998R4TAh4mCmypMlHluFEFXnytGSuS/Hl8pedbq0gpl
        x1YCht9kIIjumi4mA/0Q2hOwQKC+vWmK/mqMPjg=
X-Google-Smtp-Source: ABdhPJwVR4cY1qtLaBUUzCiRtELNxPsXKMXJCYniI9YYg66TksE4rlrefLWttoMhddMnaLdp4cvOnn7KQvHP30t2GNU=
X-Received: by 2002:a05:6870:e98b:b0:fe:219a:2449 with SMTP id
 r11-20020a056870e98b00b000fe219a2449mr8503163oao.228.1655140588010; Mon, 13
 Jun 2022 10:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-23-ardb@kernel.org>
 <202206130959.3C01F529@keescook>
In-Reply-To: <202206130959.3C01F529@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Jun 2022 19:16:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG8MsL5NHN61W+58Q2di1o9P3kaxUCNe4D5sXcdLhOkUQ@mail.gmail.com>
Message-ID: <CAMj1kXG8MsL5NHN61W+58Q2di1o9P3kaxUCNe4D5sXcdLhOkUQ@mail.gmail.com>
Subject: Re: [PATCH v4 22/26] arm64: mm: move ro_after_init section into the
 data segment
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
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

On Mon, 13 Jun 2022 at 19:00, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 13, 2022 at 04:45:46PM +0200, Ard Biesheuvel wrote:
> > Currently, the ro_after_init sections sits right in the middle of the
> > text/rodata/inittext segment, making it difficult to map any of those
> > non-writable during early boot. So instead, move it to the start of
> > .data, and update the init sequences so that the section is remapped
> > read-only once startup completes.
> >
> > Note that this moves the entire HYP data section into .data as well -
> > this likely needs to remain as a single block for now, but could perhaps
> > split into a .rodata and .data..ro_after_init section later.
>
> If I'm reading this correctly, this means that .data..ro_after_init now
> lives between .data and .rodata?
>

No, between .initdata and .data

> Do the various LKDTM tests still pass after this change?
>

Good question, I'll check.

> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
