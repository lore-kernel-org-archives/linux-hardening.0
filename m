Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76750C4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 02:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358938AbiDTCd7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 19 Apr 2022 22:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358940AbiDTCd6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 19 Apr 2022 22:33:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5B2B19E
        for <linux-hardening@vger.kernel.org>; Tue, 19 Apr 2022 19:31:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 2so595793pjw.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 Apr 2022 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YNSgtDutgXBKFRUzsOLQYL/Y2ayJ1UKMXk1V0nRM3dI=;
        b=DQs/mb56MKVnT+JWASoC/4hBPp1+3eGdQy+CDXoiqsVITkb7mU1pePfify1OL9PWa9
         Q/7dGTJsn80TGm0THysvzwU5AzjqqaR7skn1FqhBi7u2tm+fqwlQ2RUNqicsePzp2Yj/
         Uhdbn0RLchkkWdIvSwAV2QYP8dMRFFaILOxd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YNSgtDutgXBKFRUzsOLQYL/Y2ayJ1UKMXk1V0nRM3dI=;
        b=S7TKwdXV0jP+oiVBwQlMwoHbZ+TxaPA4vCMuKDPjhKOMeGG6AEtQDPyxId6JPputCu
         nNy1Yt34wumr8YpfwnKnBzObv+B55XWDjmfZ28j0smv4khrxaQd1HEk+ZpHRIBwy8qe+
         w942QyYyqSP1blVssSsctAt3pPxA8PhwNAqaLRfdSXpwKnOaavYF7ApaxGE8CvT0Begm
         yRrEuRbSu5Gq3tE9RdecuC56Xu7oalbfyxu3M/s+Vv/fxXrXrDoj1uzZuRtwFKUDa88a
         pmrNwq07yUy5nbc8HG/EIeh0Wj7LF7sZT/vQUd690SwnINJ9/yibneOahUwuo83pKwqO
         GJag==
X-Gm-Message-State: AOAM533Q+uxSHA5JtcxKgDbC10X97oIviuS9sJCK4bWFDaBXx34LsAeo
        g/mHRaqxJ+FbXkAfJr7mgII+cQ==
X-Google-Smtp-Source: ABdhPJxD2MfHzupL3ykU1Eg6xehmtnzuJEVeaeSjUuI6tlVuWazxT+JMxZqIJHqhrE7w2+bvF0jbWg==
X-Received: by 2002:a17:902:7205:b0:156:1a0a:2c39 with SMTP id ba5-20020a170902720500b001561a0a2c39mr18791861plb.88.1650421872674;
        Tue, 19 Apr 2022 19:31:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0050a3bbd36d6sm16576294pfn.204.2022.04.19.19.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:31:12 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:31:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org,
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
Message-ID: <202204191929.B475B3426@keescook>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419211658.11403-2-apais@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Apr 19, 2022 at 09:16:58PM +0000, Allen Pais wrote:
> The tasklet is an old API which will be deprecated, workqueue API
> cab be used instead of them.
> 
> This patch replaces the tasklet usage in drivers/dma/* with a
> simple work.

Thanks for working on this! Can you describe the process for the
replacement? For example, was it a 1:1 replacement from one set of
functions to another, or something more nuanced? Did you do this by hand,
or with the help of something like Coccinelle?

Including these details will help maintainers with review, and will help
others do other conversions in the future.

Thanks!

-Kees

-- 
Kees Cook
