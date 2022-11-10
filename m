Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3669C4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiKJQaq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiKJQai (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:30:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3D3C6D2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:30:37 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1954611pjc.5
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkaCawdyh08WkrauD8ZffwaibgAf2YaVEV/UkOO9ThM=;
        b=b9fVsn/o+EOVocD3Uk3T/6+Egpep17b2sHPHBYYf8mmj4zXEus3ZyLWi+H5Oe0fTF4
         H5/hnFyx8Iu9FOzKvO4KPvQmBXxoT/g9/RE/ZI8NWyRJHt33JiyPxdELIpu0SC8m2Sxr
         clzDY2KgOtiwGV43m0lljTqNkWm7DRqM2unIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkaCawdyh08WkrauD8ZffwaibgAf2YaVEV/UkOO9ThM=;
        b=DGTvQDLmF7V+CwGSM5Ig+OGix+aTKa0U6JW015xbrLWMZ0EdAgo+BYp38J4p1+UtHr
         9qqgEFZpdqPQo3LInGJ/ttMp7tlGl47Zw4yIpACZlvmG/koNedST3vnmvtUw20JI1tVo
         wq8Ee6jJt9uBi27iZlIKOWbzo3j4yPPgduAP5Xj4Wuy0CRac9/OV8Dn8yaPjZ3iwTa+O
         onLMbSoyln9FofX8k3VmuPhgdVTCVKd4yQOCU3JES9CQLyHnbq8mrmr3PWawDaJ9nY3/
         okHFzfe5mPlcw35TMuvToRy90ExpBejM1v5uf9f2u2930LlbEaEzlnWMAZHUFAa4bkTz
         qh8Q==
X-Gm-Message-State: ACrzQf3RZB+zbK1GSGzVzPpoqX0Gmv4jYaAi8a7/qcZIyyhThnNO66p0
        6Fr39F3Q3sQJJSYOo9o+VOJByw==
X-Google-Smtp-Source: AMsMyM7yWmOrmcdHdEJ1q1Xd7kAoXGvcFQoV13t8RSx7BBM2CgbxhLhelQ4tNE3SMAQe3Wm0pAReYg==
X-Received: by 2002:a17:902:82c2:b0:188:5581:c8de with SMTP id u2-20020a17090282c200b001885581c8demr1274837plz.140.1668097836751;
        Thu, 10 Nov 2022 08:30:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a430700b001fd6066284dsm35926pjg.6.2022.11.10.08.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:30:36 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:30:35 -0800
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: tc358746_apply_pll_config(): Control flow issues
Message-ID: <202211100830.5E3EE2678@keescook>
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

  Thu Oct 27 14:48:40 2022 +0300
    80a21da36051 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")

Coverity reported the following:

*** CID 1527252:  Control flow issues  (DEADCODE)
drivers/media/i2c/tc358746.c:411 in tc358746_apply_pll_config()
405     		return err;
406
407     	val = PLL_FRS(ilog2(post)) | RESETB | PLL_EN;
408     	mask = PLL_FRS_MASK | RESETB | PLL_EN;
409     	tc358746_update_bits(tc358746, PLLCTL1_REG, mask, val);
410     	if (err)
vvv     CID 1527252:  Control flow issues  (DEADCODE)
vvv     Execution cannot reach this statement: "return err;".
411     		return err;
412
413     	fsleep(1000);
414
415     	return tc358746_set_bits(tc358746, PLLCTL1_REG, CKEN);
416     }

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527252 ("Control flow issues")
Fixes: 80a21da36051 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")

Thanks for your attention!

-- 
Coverity-bot
