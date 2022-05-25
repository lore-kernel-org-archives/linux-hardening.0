Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A06C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 25 May 2022 09:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiEYJxI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 May 2022 05:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiEYJxH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 May 2022 05:53:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0C532EC7
        for <linux-hardening@vger.kernel.org>; Wed, 25 May 2022 02:53:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p190so8442542ybg.4
        for <linux-hardening@vger.kernel.org>; Wed, 25 May 2022 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fy5kErNCSVjulngCO8wTqksqb3m3u5ixS1cOApDJqZ0=;
        b=XxATIGh+VW2QM99KhmsK6/XhLKdRC3xtVDJd2/U4Do3efc2OMQgo2cku/EQ7l6Nds/
         NN2fg8NVzGcgmcq0BJMswTcwUHlyLK3dt0g9aOeAIs9NaprmnaUUY9Ec+qgFs+shAfc3
         veGlHHYuPk4YJMnxzDEi6qzxZMQjZpeRdzOJRNN4Gca6RLpYbVmIccrB2c2tFHeZcotY
         pfLOIjdR8OKBX3XI7FZ+8CLt7ofgEveAZf6gbP0Ypogkm/4FPyiV7hPx888UVD4Z/4bZ
         bEsnE5yQokNA6NbtNYjaiq6FgGXcDB6bcWeG+F3WwrxwY2UH3pGrnv3bHL11PbZRH2ry
         HONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fy5kErNCSVjulngCO8wTqksqb3m3u5ixS1cOApDJqZ0=;
        b=5Z5yfqeom7faeWSI/Hv395Voc1+zoxaPom4Q2JS04+CU5Bidq6rX0X9grCPrLgm6iX
         iIcgz/73zefysNRYwtR39BvHA1BZXxU19cabGMCJe0kY1uS17WVC1gOxZdE8xYrFOalZ
         h2dQq0iHpTnuHHjkitt8jl3rZziccHbcuRkpj4lg8WiF9NFr/m8rzXKoRnSmI+YhWsbX
         fkGutpJ2f01fGNsZQATxp3CguTLjVyI5iVv/0MftgXn+P3kbV47d8rV8wrlgUPpWeypG
         YADXeWU0c9evB8BHDErC+C84SIHUyzNjVSAsqYy5PyVIvjaJdnaAcCU15//9+9mM/4Z+
         hCHQ==
X-Gm-Message-State: AOAM5307ojJzsZvgZ6+ZL0r53ZmFAAfzp/mHZR0sEbrzfPkH3+b9Mqb+
        vPVRYN3h/kk2IC1OOveKMshY6JNZzmL/x5/rw9AYWA==
X-Google-Smtp-Source: ABdhPJy+e9FeIuYyB4lfd+KLNRqOu/vowAh7xAaW/+BkIPDsS5jyAsTbb5zYudpqMleKdzCzKBrnMH4392Xuhj3qxh0=
X-Received: by 2002:a25:d48c:0:b0:64f:5ec6:13b6 with SMTP id
 m134-20020a25d48c000000b0064f5ec613b6mr23934986ybf.236.1653472384970; Wed, 25
 May 2022 02:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
In-Reply-To: <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 25 May 2022 11:52:53 +0200
Message-ID: <CAKfTPtDzsxnsfR8dkyDwcaJvtGF4Ouo0SFj_PKd7W=AUq3jHZA@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, olivier.dautricourt@orolia.com,
        sr@denx.de, vkoul@kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, ludovic.desroches@microchip.com,
        tudor.ambarus@microchip.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
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

On Wed, 25 May 2022 at 11:24, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Apr 19, 2022 at 11:17 PM Allen Pais <apais@linux.microsoft.com> wrote:
>
> > The tasklet is an old API which will be deprecated, workqueue API
> > cab be used instead of them.
> >
> > This patch replaces the tasklet usage in drivers/dma/* with a
> > simple work.
> >
> > Github: https://github.com/KSPP/linux/issues/94
> >
> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>
> Paging Vincent Guittot and Arnd Bergmann on the following question
> on this patch set:
>
> - Will replacing tasklets with workque like this negatively impact the
>   performance on DMA engine bottom halves?

workqueue uses cfs thread so they will be scheduled like any other
thread. Furthermore, schedule_work uses the default system workqueue
which is shared with a lot of other stuff and doesn't parallel work so
you can expect some performance impact.
If you really want to use workqueue, you should at least create your
own workqueue. But you should also have a look at irq_work; An example
of usage is kernel/sched/sched_cpufrequtil.c

>
> For reference:
> https://lore.kernel.org/dmaengine/YoI4J8taHehMpjFj@matsya/
>
> Yours,
> Linus Walleij
