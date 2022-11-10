Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A29FC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiKJQcC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiKJQbv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:31:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489543C6CF
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:31:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so5123254pjc.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUAtzipMT9CJ97I7UTXEAkc3gMdCNHKnDSpE96C8MlU=;
        b=YfqB/W01G2YQNOotID47LmhV1fKHXkE5sJOkdpceIk5w8DTGaCfLdIe+sVpZqVL1cA
         M4EFLu+jZ06e7jSLfFhdHZgsktyXvjdL9RbPFogaB7GFcyJkEmItBpaKq1pbyMwYlb5S
         cFW98REZBmTm9YV/QlVS4plNATGqg22LyLP/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUAtzipMT9CJ97I7UTXEAkc3gMdCNHKnDSpE96C8MlU=;
        b=w0zVGalWC94qcyiG1xo+7Zfc34IdEcf+wL8ngrsI9es0CdppMKfpCUVR4ZWx8t3wwJ
         ya4ewDxlBYeY8Q3qdbKVrEEE6hMnpNF6IFsXgDoXopHr7zMd1JHWNnUndpuHUMoTnXoD
         2Ix2otxhFhs51IHKU/2ZRhsJXHetomBF1AtHqtLzeo7g3WZHNO/DUhUzcDSE8UcNp2Cm
         SmwJqgBku5nLtnIRydmlN4Z4H08ZeMDEy7PQbMqIg7r7Y+JISMg90T5DvH3io25454h4
         byiVTUmu+N1Ox7rd+xMkdDLKKGuMU+9v989F7ako8JvIEiPPHSJk+MZ83UQyM2JfDUjv
         H5Gg==
X-Gm-Message-State: ACrzQf37m9ZuT0ro4xYb6lFVoeyBrmYkuHAmtBE2Xy6x/wDP/2r2ujqI
        PFB0ZnOPuXdv3if/YFRJYt7ygA==
X-Google-Smtp-Source: AMsMyM4q0lr5QW4uT01XojI274hIU6SM8QThuo4QtFfn8vxazLsgnMat++r81ABFMvwTlGb4RIUNsg==
X-Received: by 2002:a17:90b:378a:b0:213:803d:3389 with SMTP id mz10-20020a17090b378a00b00213803d3389mr75822533pjb.115.1668097898630;
        Thu, 10 Nov 2022 08:31:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b00180daa59314sm11492261plg.125.2022.11.10.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:31:38 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:31:37 -0800
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
Subject: Coverity: vgxy61_detect_cut_version(): Control flow issues
Message-ID: <202211100831.9C578C6@keescook>
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

*** CID 1527248:  Control flow issues  (NO_EFFECT)
drivers/media/i2c/st-vgxy61.c:1651 in vgxy61_detect_cut_version()
1645     static int vgxy61_detect_cut_version(struct vgxy61_dev *sensor)
1646     {
1647     	struct i2c_client *client = sensor->i2c_client;
1648     	u16 device_rev;
1649
1650     	device_rev = vgxy61_read_reg(sensor, VGXY61_REG_REVISION);
vvv     CID 1527248:  Control flow issues  (NO_EFFECT)
vvv     This less-than-zero comparison of an unsigned value is never true. "device_rev < 0".
1651     	if (device_rev < 0)
1652     		return device_rev;
1653
1654     	switch (device_rev >> 8) {
1655     	case 0xA:
1656     		dev_dbg(&client->dev, "Cut1 detected\n");

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527248 ("Control flow issues")
Fixes: 153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")

Thanks for your attention!

-- 
Coverity-bot
