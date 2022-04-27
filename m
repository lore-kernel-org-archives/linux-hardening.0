Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D8EC43217
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Apr 2022 02:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357234AbiD0CtG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Apr 2022 22:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357242AbiD0Cs5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Apr 2022 22:48:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E61939A4;
        Tue, 26 Apr 2022 19:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5A5BB823FC;
        Wed, 27 Apr 2022 02:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F111C385AD;
        Wed, 27 Apr 2022 02:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651027545;
        bh=/8i2EjrVabnjrNzstULS7RbhxgjFnDrDmZdVsVHErZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qx4UPrkzSoQSLhfEBDU2aapQU0Kx9MCVkgN7+JAWok6cXC8FxPUCyl/bGEoms9Viy
         FzEoKfsdOsRT41EiheBv2sDiNpjs2/BWhPUoieb/B1Bs3sqtyNKlbhGzhAmznpFEi4
         8trfi1lB2PSqkvaDiDY8WMlRk5g6zwhfS2g6RQU+ixxDZNLvoPIWVDb6cwyaKraxSw
         k6Rpq52XSWvwSsLzCtHmbJzry/TrKO1gJFaxCvlwoj/pfqGKPUeAWgxo4TaNi0ZqYU
         aNXpaXTEBKJvAwmVimIgeE0Zt0oHfzVkWpxYf8CneOH+rAaiJOo4TiIRR/8kXsLuHv
         qCTH2spdOV04A==
Date:   Wed, 27 Apr 2022 08:15:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     olivier.dautricourt@orolia.com, sr@denx.de, keescook@chromium.org,
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
        patrice.chotard@foss.st.com, linus.walleij@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Message-ID: <YmiuUy+PAjKEq6uE@matsya>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419211658.11403-2-apais@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 19-04-22, 21:16, Allen Pais wrote:
> The tasklet is an old API which will be deprecated, workqueue API
> cab be used instead of them.

What is the reason for tasklet removal, I am not sure old is a reason to
remove an API...

> 
> This patch replaces the tasklet usage in drivers/dma/* with a
> simple work.

Dmaengines need very high throughput, one of the reasons in dmaengine
API design to use tasklet was higher priority given to them. Will the
workqueue allow that...?

-- 
~Vinod
