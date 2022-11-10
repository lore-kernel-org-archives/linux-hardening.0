Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76F9C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKJQ2K (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiKJQ2I (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:28:08 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C71205F9
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:28:07 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y4so1809057plb.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYhq/mBEGTZpGCDyMim5fTg3vaVPNZnQvgxcn4u7bSI=;
        b=Prhwc6DCeW+0r6L7UoZ+ItiN/aHRF2e9MAvxqsVz4KA4QswyP7GwKrb6HYRa60cfp0
         +b0MxtYATc5xgmr9p37QbuXf1l1p32jRAdP2hwXG5wR3VotgwUNvgeLJODH08x8Nwtk9
         B/D1bmU0y/wRl84XUzPlfkZqAIIHJTyieTUA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYhq/mBEGTZpGCDyMim5fTg3vaVPNZnQvgxcn4u7bSI=;
        b=WOLC+4W04AXK6V7/WNFsBpR5SuK1KHwu++9aacXBxaRPPv5BjWuu8Wal33L5hoBM/w
         qWK6eKIY2xG3BRcNPdVDXn+2wqrnQgbSCyOthTuTIIKiJmo8w7+6yKUBoSm9zhK1WjdD
         Rb6ZjBwEy0d/vBvR2u17BsNEU8Od8NQXx+YgqixRpZ7muaGekuZ3Q6xl0IvZw9yhLYMJ
         jfB+gqR8ItVpmWDgdNcDZv+Mp2iUCrwKmHJvWLBD+HxMhX6A4P+C1XWQRCdrsd+JeBmL
         3S3HvvIkLnKgSpU+TexMCjzENex0yw51I+udbRxC0XXjfcU5B0/2icxfzREVqOMkc5sy
         bF/w==
X-Gm-Message-State: ANoB5plX44dUSxb3LrMYzDFbw4GFbtKssU2rsFy/tvNkBFxOUavARBUs
        a8eW5pMinCsqymFATAScZHV+Mw==
X-Google-Smtp-Source: AA0mqf7tUEF/WoEOICY6ADSUX7ZpJwwgEFjpqYiLgDAN5IOXY5cUTd9B85ka0aCFSHNlY4ParE5N5w==
X-Received: by 2002:a17:902:728b:b0:188:6baf:1fe7 with SMTP id d11-20020a170902728b00b001886baf1fe7mr29852161pll.123.1668097687326;
        Thu, 10 Nov 2022 08:28:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a0f0100b00200a85fa777sm3323273pjy.1.2022.11.10.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:28:07 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:28:06 -0800
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
Subject: Coverity: vgxy61_detect(): Control flow issues
Message-ID: <202211100828.FEDCDE7@keescook>
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

*** CID 1527257:  Control flow issues  (NO_EFFECT)
drivers/media/i2c/st-vgxy61.c:1679 in vgxy61_detect()
1673     	struct i2c_client *client = sensor->i2c_client;
1674     	u16 id = 0;
1675     	int ret;
1676     	u8 st;
1677
1678     	id = vgxy61_read_reg(sensor, VGXY61_REG_MODEL_ID);
vvv     CID 1527257:  Control flow issues  (NO_EFFECT)
vvv     This less-than-zero comparison of an unsigned value is never true. "id < 0".
1679     	if (id < 0)
1680     		return id;
1681     	if (id != VG5661_MODEL_ID && id != VG5761_MODEL_ID) {
1682     		dev_warn(&client->dev, "Unsupported sensor id %x\n", id);
1683     		return -ENODEV;
1684     	}

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527257 ("Control flow issues")
Fixes: 153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")

Thanks for your attention!

-- 
Coverity-bot
