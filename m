Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB1C43217
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiKJQbd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiKJQba (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:31:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD65C3C6C7
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:31:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso1989499pjc.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q//NfvfwbHlgG9kr+gM0PFB8sz8eUnyj+TzRNyjvOKw=;
        b=ZyS9R/MGUW1YGsyldhs8c3fxMyKBfTNmQJ1dEiwBVAZLzrhn3y+kyT1y4tJXACxZij
         nHexC39gvmUtCFWpVUKNQV011pe/GyYd9XPoAWYAzHv6qXMNgqU5ZFpCn7bwdhTeN3SA
         QJeNpFVjKoNY34iyr+5i6NiOJokMKja7B6Mm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q//NfvfwbHlgG9kr+gM0PFB8sz8eUnyj+TzRNyjvOKw=;
        b=WmcC9vCC57vscvUC7wqBoSeG3FqFTy4uI/WZI3BNYgrBPs8HIPr5gFdqSCnKb0Adod
         f2Ray8YfcA/cDdvX3G7inrCmRI8x+0gbP4Tx5201heBM17yuu16ddJrq1BtseOzujbN5
         mLChOaXhkhHB4ZWif8N84ExYFWzGgb3oisA/aBlkNL4qg6MjnxuSBUgh8CBQsZLg5eIt
         gXMx2ncZ3Bx8/Rw7GHWaYSOQbe69FYMrgr8TeVaixQMxaMxKwQb7FSFir09Fa9QZazUj
         lKkCrgD+m2dTfqmoKxHGsMMp7phReCKo6FwYtZ3+p7CGl/Dl7j2uGEtMkIbhvAAbYGHH
         AC6w==
X-Gm-Message-State: ACrzQf0fSush3G/SXkow2lPSbBzCu1l1nvR/NGk0HRLqg4sRJ6EICbzB
        E00b+EOKTkhw5J7gBkZnJlreag==
X-Google-Smtp-Source: AMsMyM7bIHCw2g7OgpW74otDtZWYJB94LTrxnCHjqC3yaKzr5RoqEceOvIFYIh4hvDYJgJPw1nezZg==
X-Received: by 2002:a17:90a:2acd:b0:213:e2a8:39be with SMTP id i13-20020a17090a2acd00b00213e2a839bemr55581665pjg.205.1668097889272;
        Thu, 10 Nov 2022 08:31:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f143-20020a623895000000b0056b6d31ac8asm10708209pfa.178.2022.11.10.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:31:28 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:31:28 -0800
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: vgxy61_apply_gpiox_strobe_mode(): Control flow issues
Message-ID: <202211100831.ABA2A931@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221110 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Thu Oct 27 14:37:38 2022 +0300
    153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")

Coverity reported the following:

*** CID 1527249:  Control flow issues  (NO_EFFECT)
drivers/media/i2c/st-vgxy61.c:891 in vgxy61_apply_gpiox_strobe_mode()
885     					  unsigned int idx)
886     {
887     	static const u8 index2val[] = {0x0, 0x1, 0x3};
888     	u16 reg;
889
890     	reg = vgxy61_read_reg(sensor, VGXY61_REG_SIGNALS_CTRL);
vvv     CID 1527249:  Control flow issues  (NO_EFFECT)
vvv     This less-than-zero comparison of an unsigned value is never true. "reg < 0".
891     	if (reg < 0)
892     		return reg;
893     	reg &= ~(0xf << (idx * VGXY61_SIGNALS_GPIO_ID_SHIFT));
894     	reg |= index2val[mode] << (idx * VGXY61_SIGNALS_GPIO_ID_SHIFT);
895
896     	return vgxy61_write_reg(sensor, VGXY61_REG_SIGNALS_CTRL, reg, NULL);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527249 ("Control flow issues")
Fixes: 153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")

Thanks for your attention!

-- 
Coverity-bot
