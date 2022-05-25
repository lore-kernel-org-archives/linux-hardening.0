Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A096C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 25 May 2022 09:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiEYJZG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 May 2022 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbiEYJZB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 May 2022 05:25:01 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C88A30C
        for <linux-hardening@vger.kernel.org>; Wed, 25 May 2022 02:24:59 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id o80so35282902ybg.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 May 2022 02:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8v8NJ0a8V56vtqLR+SMp9QvjOrvgB+9HAIgTvz0fNJo=;
        b=dYJhLfBDjkkwdtL7D9ZCvH/HwdunUkHDymiQT/6fOkGfUlgVU79wfDNeKi1FmvO01+
         sYziFA2LOGAfhRqoHeA2iY+WYLDKijMRBXtk7C9/myzGSV/1yBTPtk6tY5yr6aZknMvq
         iLgkfAtv9jdC0BFti5DSakNtV6dFv7VSLlkUS50I4bWqisejUClMiEswT8RJnSp4VZ+c
         2e9Ew7kGjVu2lxGwPu5u5kCugna04xaGgXoBapEPsQM2HR7+zNeTZgGbmlfgei/SwXVk
         N9y954AfWXnR9J/RQcoJWVcEZsWkqX5qXN+67MuuLLVyBMM5P2KSSCGz8fI/ZDbWqiAr
         CxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8v8NJ0a8V56vtqLR+SMp9QvjOrvgB+9HAIgTvz0fNJo=;
        b=A2uPKU2liA6lVM96EmYpFhXZZTZFCIoQanUhOK2x/tbI4qHPQ4txiMIuBnkDmSZ8BL
         JrZ2CMd5a2nzqaUkSBIWTOXdljitmVQTrGmvdO43G3dUvh081uWDrEGy6ApjnyUXkLjh
         3vrnyoaSHNVcBa3YAW8BXRUk5mZz13NQeOvfvcbS/LYC5j8qq6MVeppBz0mn6DRvErEH
         47cL+0ghFuDzGmebcdWQ9PYd2grQMNQUD3ZdkgbPNJeR5PSo2l0DOHU/BSj1KY5++/o/
         lBY7+2uXAcX3fHNTjx4udoRxiXUvwI32nN8VpZkI706fX1W5WNYwSa0pXPo/ajeXAjnh
         s6tQ==
X-Gm-Message-State: AOAM531MwUxgDlmz6OyCtkrvS0clgegEtGtWaQdfBAHwUSLGTokdXJLk
        qO/8xKQJDsZyQNrAMjlyLJfg2hGrMECZrOewSNFdUA==
X-Google-Smtp-Source: ABdhPJyTI8yw+M0YzU0THJ1vYh5OzrMdzgHpVAzvdG4RReWcEDTXHjPdRmztzhwlqmxghfm1UKDV/wUEiUYjP8kA62g=
X-Received: by 2002:a25:420e:0:b0:655:8817:e6ba with SMTP id
 p14-20020a25420e000000b006558817e6bamr3360166yba.369.1653470698888; Wed, 25
 May 2022 02:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com> <20220419211658.11403-2-apais@linux.microsoft.com>
In-Reply-To: <20220419211658.11403-2-apais@linux.microsoft.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 May 2022 11:24:46 +0200
Message-ID: <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Allen Pais <apais@linux.microsoft.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        andriy.shevchenko@linux.intel.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, afaerber@suse.de, mani@kernel.org,
        logang@deltatee.com, sanju.mehta@amd.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, green.wan@sifive.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Apr 19, 2022 at 11:17 PM Allen Pais <apais@linux.microsoft.com> wrote:

> The tasklet is an old API which will be deprecated, workqueue API
> cab be used instead of them.
>
> This patch replaces the tasklet usage in drivers/dma/* with a
> simple work.
>
> Github: https://github.com/KSPP/linux/issues/94
>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>

Paging Vincent Guittot and Arnd Bergmann on the following question
on this patch set:

- Will replacing tasklets with workque like this negatively impact the
  performance on DMA engine bottom halves?

For reference:
https://lore.kernel.org/dmaengine/YoI4J8taHehMpjFj@matsya/

Yours,
Linus Walleij
