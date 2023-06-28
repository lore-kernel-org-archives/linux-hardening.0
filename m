Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A586CEB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 16:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjF1QdD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjF1Qcb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 12:32:31 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544592D7F
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 09:32:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3354916b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687969943; x=1690561943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDGMYCjLis4jKxTwr/XdUXoNY3JVle8y3T0ovRza2gI=;
        b=So0cQmmYjKO65vw+/JsinQBhmojmi5xblarthQ+XwK6zfOrl6nidesbKTUolCr2pTj
         v6gEfN3NB9a8q4sxVqNolfWNnRp4XqLAHKowxUgtk9uf3sWNhisK6K8UMc+/sGQs7zl3
         7wNc+mBDuFAzumNdKdKkBJsTHBdBLtEE96zHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969943; x=1690561943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDGMYCjLis4jKxTwr/XdUXoNY3JVle8y3T0ovRza2gI=;
        b=gEfKH+vDL82MNcgpABfuDTS2Funeza3U+queQoVH/hVtMHU36jjb39YMx5dMcZ/BC5
         DwxHQhQNLT/aYTmmw+sLcx2VBf2hcbUWsOfMtudgtlo1GTLiKQ7S29iZk7sziSAz8O1Q
         0AMqeqL9Eg5H3XNpxo/kC4sGiSBucNX1jsmk87ewp3Snqwbsw3VnSpcLWxCBkM7cItJC
         rFoYpuJA071GZ3VyN63evUA0JOrrKKrRlUUeeE0s70i2WOwoEjMC1kNLWa95vWH6ch56
         RYOsMf8s0G8cOMcOd5U3ZOEJWBDK0DjmMadEAae6EhicKpZ6DK4eUU1t05130nSSRElG
         JFLQ==
X-Gm-Message-State: AC+VfDztH6TJnp9CUvRv1mPHvrcrCL64ZMTdsgw44jFgx8auTx8mT7ZD
        7YRSxMSw8BsHeGm3/QTHtW+pDQ==
X-Google-Smtp-Source: ACHHUZ4hwJdblgv/IjbPFH+BZPSdbdvvXEegZidz0b10Rp2sJOYq5ixdTjeKDAOTEUFq8KxIhGOHvQ==
X-Received: by 2002:a05:6a00:3994:b0:66a:3812:7eda with SMTP id fi20-20020a056a00399400b0066a38127edamr20180226pfb.9.1687969942751;
        Wed, 28 Jun 2023 09:32:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00681783cfc85sm1263377pfb.144.2023.06.28.09.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:32:21 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:32:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <202306280930.8CBBB9B@keescook>
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
 <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
 <20221228205726.rfevry7ud6gmttg5@begin>
 <20230625155625.s4kvy7m2vw74ow4i@begin>
 <202306271944.E80E1D0@keescook>
 <20230628060716.vvgtlgbushyjh6km@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628060716.vvgtlgbushyjh6km@begin>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 28, 2023 at 08:07:16AM +0200, Samuel Thibault wrote:
> Kees Cook, le mar. 27 juin 2023 19:48:45 -0700, a ecrit:
> > On Sun, Jun 25, 2023 at 05:56:25PM +0200, Samuel Thibault wrote:
> > > > Can we perhaps just introduce a CAP_TIOCSTI that the brltty daemon would
> > > > be able to use? We could even make it only allow TIOCSTI on the linux
> > > > console (tty->ops == con_ops).
> > 
> > Does brltty run with CAP_SYS_ADMIN?
> 
> ATM most often, yes, though we are trying to reduce the CAP_* privileges
> to what it actually needs.
> 
> > > *Please* comment on this so we can progress. ATM people are
> > > advising each other to set dev.tty.legacy_tiocsti=1, which is just
> > > counter-productive in terms of security...
> > 
> > So is there really no solution for brltty and TIOCSTI being disabled?
> 
> No, there is no way to simulate characters on the Linux console. The
> alternative would be to use uinput, but that simulates keycodes, not
> characters, thus requiring backtranslating first, which is very fragile.
> 
> > What is FreeBSD doing? I imagine it's the same situation there too,
> > though maybe there is just no support?
> 
> There is just no support in the kernel, only a patch against "screen".
> 
> > > Really, this a serious regression for the people affected by this.
> > 
> > Can you send a patch adding a CAP_SYS_ADMIN exception?
> 
> Sure!

Thanks! (And be sure to use file->f_cred for the check[1], not "current",
that way brltty can open the tty and drop caps and still do the ioctl.)

-Kees

https://docs.kernel.org/security/credentials.html?highlight=confused+deputy#open-file-credentials

-- 
Kees Cook
