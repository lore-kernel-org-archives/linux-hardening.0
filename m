Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B9C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 22:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiLBWXu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiLBWXt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Dec 2022 17:23:49 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D74EAB76
        for <linux-hardening@vger.kernel.org>; Fri,  2 Dec 2022 14:23:48 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 124so6211432pfy.0
        for <linux-hardening@vger.kernel.org>; Fri, 02 Dec 2022 14:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jTCIikbeptzJXD47+EMyi5YDiLQQfJyhpLRVU8dNm0=;
        b=ToGWGrmjiT0lMJNU69+4IxRqSU2UDAoa5JWa/ImgVTqrDAPvBqFY71W+U+knKfDsLp
         6Gp/nSFOHt5+m0Q8yU1d8m1dfHrWQXxgZNXt9VC72vFrlEPN84l0JJ90OquEZXSkYb2a
         KYELpNU7HZ5x23pyFU+/OVsWhbIWwGK6BLjjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jTCIikbeptzJXD47+EMyi5YDiLQQfJyhpLRVU8dNm0=;
        b=FLqfzbKplo8oWUiI5jQscFzS3tROFCehVvlQNxPNk+jvLez8+ficslHCCCUS15gt9f
         F99CftvMFwT1pELykb4YFtRew2KSDXK8nlsFpV4P4Z5B1gmZyIXAzirUWyrznehCpLgB
         W9lz+J1/9vm4Q7PU5rofdYexbqPTCvGW2LsJQPyjqbsIcN8GRNUmyxBO2aiFSoHn42w9
         wjR20PShGXjtuu0nmj7jfR6avF6EkRyVFcuDEqdXT7sCFFimbBqCaJu/fHJdoy2dXCTt
         QyDpzxMAnIs7K5h931YGXKemmcf8El+arPuJI/mwmyyUQU4wV+NKHaJlWO5mt0Arbb7Z
         4b0Q==
X-Gm-Message-State: ANoB5pkoR9Qpmd/HYBj0dVt5NTUfC6XM5HwhthGtEeyl5DBet/74u5zD
        aiBLmvS1ZnuVnPYel6A00Xpjsw==
X-Google-Smtp-Source: AA0mqf5GQF0f6fi1jAPdLnQFOWtH9RQ4f6566bGOi++EJw411Ux5M2z0l8uDW3zkf0KDGJveJ54bGQ==
X-Received: by 2002:a63:d117:0:b0:476:c781:d3ae with SMTP id k23-20020a63d117000000b00476c781d3aemr47136160pgg.183.1670019828150;
        Fri, 02 Dec 2022 14:23:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b00186a437f4d7sm5926117plh.147.2022.12.02.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:23:47 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 2 Dec 2022 14:23:47 -0800
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: mt76x0_phy_get_target_power(): Memory - illegal accesses
Message-ID: <202212021423.5D5F1FD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221202 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Thu Dec 1 17:29:12 2022 +0100
    b376d96362d8 ("wifi: mt76: move mt76_rate_power from core to mt76x02 driver code")

Coverity reported the following:

*** CID 1527804:  Memory - illegal accesses  (OVERRUN)
drivers/net/wireless/mediatek/mt76/mt76x0/phy.c:645 in mt76x0_phy_get_target_power()
639     	case 4:
640     		/* vht rates */
641     		tx_rate = info[1] & 0xf;
642     		if (tx_rate > 9)
643     			return -EINVAL;
644
vvv     CID 1527804:  Memory - illegal accesses  (OVERRUN)
vvv     Overrunning array "dev->rate_power.vht" of 2 bytes at byte offset 9 using index "tx_rate" (which evaluates to 9).
645     		*target_power = cur_power + dev->rate_power.vht[tx_rate];
646     		*target_pa_power = mt76x0_phy_get_rf_pa_mode(dev, 1, tx_rate);
647     		break;
648     	default:
649     		/* ht rates */
650     		tx_rate = info[1] & 0x7f;

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527804 ("Memory - illegal accesses")
Fixes: b376d96362d8 ("wifi: mt76: move mt76_rate_power from core to mt76x02 driver code")

Thanks for your attention!

-- 
Coverity-bot
