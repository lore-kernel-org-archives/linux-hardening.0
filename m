Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF2C43217
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 22:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiKQWR0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiKQWRR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 17:17:17 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB90786C3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:17:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id io19so2912364plb.8
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJFXSIQ783ozGJIEcq7M0/X5+WZmAwzKbqXzhdiC6Ac=;
        b=K0Bjuug0PMBmGyIJKJh38l6aGh9Uv5KTby8hRtEeGfVVQ1uk8H1iE3Jy3X9g3QumnZ
         m2UP0vy7n4K5mWAusXU9baE2QnR29kZ4q50wmoljG4b2D2eX+mVF6sHH4MHZ7t18A4bO
         LdNjNf/Fkk/7a/wD3qmB8jz3Qcgz8Rz2OAuHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJFXSIQ783ozGJIEcq7M0/X5+WZmAwzKbqXzhdiC6Ac=;
        b=5gPiU61w5LxRRI2VLOxUJtypAGysLBZTN+ZTZ42BQJ1OM//6YBVFfNhfdof98ayTOC
         RnXV/qGPh8I0StUyGVMRxtpYpWk1O8yv1JIc/QFYa7VYu2TBZ5PwRBWnoFXak5q7xSv2
         RmHFdq3z5jNTBTnPnB23qNh99qj6qRncd3LTf8N89UUQLo+SMyMmCNnwpzyx94VpFiPp
         CrAEklINaK2A3iVWipW33fQN4txJpOQfu3f1xa8/MVllfOB3roohcrViiG5SuP5eIqh8
         iPdUD28mOiCYyd4R4oo8T/AoDQcB0B3A74nIe998zsIkzA/tpcbP+xSckwO/Bpb3XzKB
         OLBg==
X-Gm-Message-State: ANoB5pkfVUYSOLOzSbkAvi3N5dI4X5oGk8jUpGcajI2Q816/OHx95b/7
        BxmazDcbYQn4oDFaF8inSGONpyY08pYW6A==
X-Google-Smtp-Source: AA0mqf41Wqejx3gjkqAto1lEjNVUWFDLIcHhPUNfGeI3XvM/RrkDVObROJw0YVQF/ox1gXuNsYVNtA==
X-Received: by 2002:a17:90b:3d7:b0:200:2538:1ca8 with SMTP id go23-20020a17090b03d700b0020025381ca8mr10837807pjb.79.1668723436518;
        Thu, 17 Nov 2022 14:17:16 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t3-20020a625f03000000b0056da2ad6503sm1684293pfb.39.2022.11.17.14.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:17:16 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 17 Nov 2022 14:17:15 -0800
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: efx_tc_rx(): Memory - illegal accesses
Message-ID: <202211171416.0BC0EDDA36@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221117 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Nov 16 09:07:02 2022 +0000
    25730d8be5d8 ("sfc: add extra RX channel to receive MAE counter updates on ef100")

Coverity reported the following:

*** CID 1527356:  Memory - illegal accesses  (OVERRUN)
drivers/net/ethernet/sfc/tc_counters.c:483 in efx_tc_rx()
477     	}
478
479     	/* Update seen_gen unconditionally, to avoid a missed wakeup if
480     	 * we race with efx_mae_stop_counters().
481     	 */
482     	efx->tc->seen_gen[type] = mark;
vvv     CID 1527356:  Memory - illegal accesses  (OVERRUN)
vvv     Overrunning array "efx->tc->flush_gen" of 3 4-byte elements at element index 3 (byte offset 15) using index "type" (which evaluates to 3).
483     	if (efx->tc->flush_counters &&
484     	    (s32)(efx->tc->flush_gen[type] - mark) <= 0)
485     		wake_up(&efx->tc->flush_wq);
486     out:
487     	efx_free_rx_buffers(rx_queue, rx_buf, 1);
488     	channel->rx_pkt_n_frags = 0;

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527356 ("Memory - illegal accesses")
Fixes: 25730d8be5d8 ("sfc: add extra RX channel to receive MAE counter updates on ef100")

AFAICT, efx_tc_rx_version_2() may return EFX_TC_COUNTER_TYPE_MAX.

Thanks for your attention!

-- 
Coverity-bot
