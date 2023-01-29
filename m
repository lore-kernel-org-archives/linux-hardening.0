Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B9C05027
	for <linux-hardening@archiver.kernel.org>; Sun, 29 Jan 2023 21:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjA2VUn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 29 Jan 2023 16:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2VUm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 29 Jan 2023 16:20:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358522684;
        Sun, 29 Jan 2023 13:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B893F60DCC;
        Sun, 29 Jan 2023 21:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F1C433EF;
        Sun, 29 Jan 2023 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675027241;
        bh=kWLMQrFqShcluz07QO5vOBfP0AiHRWpr8FUknDuT51c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lm8rserOmXwPSHSxL4fL8MMBG+V5eoyPGufc4gf71ro9Az9HuC4pfK1+ibeT+jrjE
         9Hqfd64WU2tlRHOGsdSB6Z3zqdOUqD9h7MrysAr/ILwMqg5d8VHX4ZO3d5xwaWnf2i
         mVMf1aAy0QuaS9qbBOSczp2+Z7r1FMuc4X3nEIxGd6PuLfN7M6ImOMkrgwfHf/qkuY
         5si2JeTV905zYfBlaMW6EL1xYY+dt+E/JeU7GAVnsQQN4gcyQvXhLE2IIrDSfznYOS
         RluKNbC7OJvQgGtqzNLS8jImsygjunU4gHaJ3n5+AlSwNDQfne7PcFJXBP4c34gvdd
         zV85Sc24DpbUg==
Received: by mail-vs1-f51.google.com with SMTP id y8so10676539vsq.0;
        Sun, 29 Jan 2023 13:20:41 -0800 (PST)
X-Gm-Message-State: AFqh2kpj28W32Vxi9mVn3CoyrfPAL1vtG99Ox+W4g3TsP580ATKRyH3E
        DVyORpf0OR/ClGlrnfcNPMLs5WlPvgP0k3+R1w==
X-Google-Smtp-Source: AMrXdXsO0UKVf3d7SOMw8/7583PiRZiRlhNbFl++XIntdRN5ODCwGQ2dEyGP6VEOMUa6VrvVubh3sCXD7L+nkuUu38s=
X-Received: by 2002:a05:6102:5490:b0:3b5:1fe4:f1c2 with SMTP id
 bk16-20020a056102549000b003b51fe4f1c2mr6411996vsb.0.1675027240073; Sun, 29
 Jan 2023 13:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20230127224101.never.746-kees@kernel.org> <CAL_JsqKVp57NtR11JV-eXktMU9_dQ+8sF8YSPe7KyazrvJB-eQ@mail.gmail.com>
 <202301271609.15F0E5EB15@keescook> <202301271624.01B4A55D3C@keescook>
In-Reply-To: <202301271624.01B4A55D3C@keescook>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 29 Jan 2023 15:20:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+fJk29-wGp02eFFru2Pn+m6eGKnVT6XJJyf-WtkxWw4g@mail.gmail.com>
Message-ID: <CAL_Jsq+fJk29-wGp02eFFru2Pn+m6eGKnVT6XJJyf-WtkxWw4g@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: Replace 0-length arrays with flexible arrays
To:     Kees Cook <keescook@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 27, 2023 at 6:24 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 27, 2023 at 04:12:21PM -0800, Kees Cook wrote:
> > On Fri, Jan 27, 2023 at 05:44:13PM -0600, Rob Herring wrote:
> > > On Fri, Jan 27, 2023 at 4:41 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > Replace the 0-length array with a C99 flexible array. Seen with GCC 13
> > > > under -fstrict-flex-arrays:
> > > >
> > > > In file included from ../lib/fdt_ro.c:2:
> > > > ../lib/../scripts/dtc/libfdt/fdt_ro.c: In function 'fdt_get_name':
> > > > ../lib/../scripts/dtc/libfdt/fdt_ro.c:319:24: warning: 'strrchr' reading 1 or more bytes from a region of size 0 [-Wstringop-overread]
> > > >   319 |                 leaf = strrchr(nameptr, '/');
> > > >       |                        ^~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  scripts/dtc/libfdt/fdt.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Changes to dtc/libfdt go to upstream dtc first and then we sync them back.
> >
> > Ah-ha, I've found it: https://github.com/dgibson/dtc
>
> Sent upstream: https://github.com/dgibson/dtc/pull/76

Maybe David will take that PR, but upstream is here[1]. Patches go to
devicetree-compiler@vger.kernel.org.

Rob

[1] https://git.kernel.org/pub/scm/utils/dtc/dtc.git
