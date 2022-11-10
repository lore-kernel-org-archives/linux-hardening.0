Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C86C4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiKJQ1o (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiKJQ1m (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:27:42 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D090C1DDE3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:27:41 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q1so2289693pgl.11
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QDbTV0hvgJIMwlYM/H+CYfboYjCEAWjnTGIDpVXMU0=;
        b=oEog2Gj7capmtsmcj2GyJWN4VajuPy7IRXg+obDX370R+osb3Ra84m8163VuhYeMTU
         Pg6eL03U8tM7cqPFxGl0vAB5diLNsciymBeJ/Ga3tLVoTW4r54dhaRVbu82PIV2ewySi
         iW14hUEyaPifcnrO8kYPLWCKzloA/fMCmmz7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QDbTV0hvgJIMwlYM/H+CYfboYjCEAWjnTGIDpVXMU0=;
        b=ceN214G7xBYoPwuTHD19G6cKtlYl4GbSrOadP9yijBNrcBp0gQhllaT0aIfPLlxtPA
         KBHK7PKNcXkUjr59AL3zZWBsm1kbEQTRB+V4J+8pKSff2STYVtZhbrvmIIRm1GbQT41F
         WlDoGddQvnlxCHo6sM9EII7sxJa5ksrwX4qny5sjtKFr4qZCQo8W/exYkhJrIYtSvDhq
         BEw5GWyjAbv1f+cQ12zniJ9oQ+kq9qjmSx7i/lv0fWn5IYew+wloqm8xnYbpJOwrHCZa
         ZXrHs2QGpO42khSVGd/LAp+L5KnBCZGrxnjhc9i/K/Sk7QeV4WnqOH/vgejN3FWMQzi7
         39kQ==
X-Gm-Message-State: ANoB5plO+ic2FJQvU9x+uKKnVJNrUrMJw2Meku8R3zeFS4QAUZcWq4H8
        59YzczxPQdgFPe+EKTdERdOJYg==
X-Google-Smtp-Source: AA0mqf5XT2btL5Z35ZGarHtKgubWVQk8whdcAKB4borfUWw4sSl2bcSGjVY7xUytCpVuQrW0LtMo3g==
X-Received: by 2002:a63:42c5:0:b0:470:70d7:5a43 with SMTP id p188-20020a6342c5000000b0047070d75a43mr2240176pga.44.1668097661290;
        Thu, 10 Nov 2022 08:27:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id rm12-20020a17090b3ecc00b00213a9e1f863sm30467pjb.4.2022.11.10.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:27:40 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:27:39 -0800
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
Subject: Coverity: vgxy61_tx_from_ep(): Memory - corruptions
Message-ID: <202211100827.8A08F58A@keescook>
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

*** CID 1527258:  Memory - corruptions  (OVERRUN)
drivers/media/i2c/st-vgxy61.c:1528 in vgxy61_tx_from_ep()
1522     	 * valid for hardware stuff.
1523     	 */
1524     	for (p = 0; p < VGXY61_NB_POLARITIES; p++) {
1525     		if (phy2log[p] != ~0)
1526     			continue;
1527     		phy2log[p] = l;
vvv     CID 1527258:  Memory - corruptions  (OVERRUN)
vvv     Overrunning array "log2phy" of 5 4-byte elements at element index 5 (byte offset 23) using index "l" (which evaluates to 5).
1528     		log2phy[l] = p;
1529     		l++;
1530     	}
1531     	for (l = 0; l < l_nb + 1; l++)
1532     		polarities[l] = ep.bus.mipi_csi2.lane_polarities[l];
1533

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527258 ("Memory - corruptions")
Fixes: 153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")

Note that l starts at 1, 2, or 4, so line 1529 could push it to 5, which
is out of bounds, etc...

Thanks for your attention!

-- 
Coverity-bot
