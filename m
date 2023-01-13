Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EF8C677F1
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 23:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjAMXlx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjAMXlw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 18:41:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4778CBE1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:41:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so28465306pjk.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6MHYbwLCd4MXDktCkUEHbUjwJCPzByBEFcKICE41Wc=;
        b=oTZuy2QPWn8Ttcvpqg8Wf+v1IVfqF7e+evU+pjT9cDt2BTwDYJE0G5bkNpMF6ezT3g
         +SEvjpRmiSNsLRYN9qdquMxFrzldCiMPoVdF6prKORkPqeIap777PZoxpIHMOGBqf/A2
         umpAryvMGRtP/6LszPqvra+mLhvn9hhxyqa3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6MHYbwLCd4MXDktCkUEHbUjwJCPzByBEFcKICE41Wc=;
        b=awD7AbgUzSO/J/wwrjtYDVsKjhO5goh5XQVuVikEkLEJGFq4rstqZWq+WcNbXc98PJ
         UBitoMVg4lHblEEeb5VnpoqscJ8zxnmFQuWHH5Em37IF4AlIYhZMOrDZpJXjKT7PRcgP
         oB0aG8e8a0TUtU3xR9XK9YPCFY+HTS0aZpTFuKUlbIIVh0igGeUaL8A0qsx0JvNLtabv
         wNlCkhowqavL/LuOCzoSdeLB36Fy1DNawytsVdAYDHzmhgFeQtBLJRad7GFr9+6kxsdi
         H2vhCboJU4OGO9vJHwdWsP49OOQImwVi8akNx+ijNST9HGRKTmy411OXTWzlbl92uquL
         8Rrg==
X-Gm-Message-State: AFqh2kr7vw+oMg760CqtJbvKCsbm2Rw1/Yn4QcJo5Q+p9GQuHwBHXjRQ
        rJaM38XgdWsaZxJi9a5ucqDTDiIalI2W2nC4
X-Google-Smtp-Source: AMrXdXuZ+U95h1w+2Ck1r1tekdH9Z21e+CKOPUB5dzyfgK6c9cASSF6xg9nIODJAgNZMvedmhtP+eA==
X-Received: by 2002:a05:6a20:c906:b0:b4:f66a:99a9 with SMTP id gx6-20020a056a20c90600b000b4f66a99a9mr43708881pzb.60.1673653310583;
        Fri, 13 Jan 2023 15:41:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090a4ece00b002194319662asm14592813pjl.42.2023.01.13.15.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:41:50 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 13 Jan 2023 15:41:49 -0800
To:     Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: genphy_c45_plca_set_cfg(): UNINIT
Message-ID: <202301131541.741EBE0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20230113 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Jan 11 08:35:02 2023 +0000
    493323416fed ("drivers/net/phy: add helpers to get/set PLCA configuration")

Coverity reported the following:

*** CID 1530573:    (UNINIT)
drivers/net/phy/phy-c45.c:1036 in genphy_c45_plca_set_cfg()
1030     				return ret;
1031
1032     			val = ret;
1033     		}
1034
1035     		if (plca_cfg->node_cnt >= 0)
vvv     CID 1530573:    (UNINIT)
vvv     Using uninitialized value "val".
1036     			val = (val & ~MDIO_OATC14_PLCA_NCNT) |
1037     			      (plca_cfg->node_cnt << 8);
1038
1039     		if (plca_cfg->node_id >= 0)
1040     			val = (val & ~MDIO_OATC14_PLCA_ID) |
1041     			      (plca_cfg->node_id);
drivers/net/phy/phy-c45.c:1076 in genphy_c45_plca_set_cfg()
1070     				return ret;
1071
1072     			val = ret;
1073     		}
1074
1075     		if (plca_cfg->burst_cnt >= 0)
vvv     CID 1530573:    (UNINIT)
vvv     Using uninitialized value "val".
1076     			val = (val & ~MDIO_OATC14_PLCA_MAXBC) |
1077     			      (plca_cfg->burst_cnt << 8);
1078
1079     		if (plca_cfg->burst_tmr >= 0)
1080     			val = (val & ~MDIO_OATC14_PLCA_BTMR) |
1081     			      (plca_cfg->burst_tmr);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1530573 ("UNINIT")
Fixes: 493323416fed ("drivers/net/phy: add helpers to get/set PLCA configuration")

Thanks for your attention!

-- 
Coverity-bot
