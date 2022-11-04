Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFAAC43217
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Nov 2022 19:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiKDT0J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Nov 2022 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiKDT0I (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Nov 2022 15:26:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C96249
        for <linux-hardening@vger.kernel.org>; Fri,  4 Nov 2022 12:26:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 78so5161136pgb.13
        for <linux-hardening@vger.kernel.org>; Fri, 04 Nov 2022 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytLIhKZuYdmh84oUVdzM6+Xt1URUXrJYojk/wKNfrD8=;
        b=O+tMUcOtLUO27foXcasLA7fBSvjCJZGLiylgapTnNf+R617vScp8qdh672FH/pq5zD
         j0hL6YPGSsYuAZoaqzebFkEkndKOT1MhyYcL6iFHjuWmCGwP4w3vGyJlG9Q0+4H7M1rx
         lju2sCW+AdCH3dasrSOBNaahaBnnyHEisA/Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytLIhKZuYdmh84oUVdzM6+Xt1URUXrJYojk/wKNfrD8=;
        b=xeIIHPZCTkK9j2KsJC8F/O+CzkJVplbWZ329Qqei51USNaJ1pGM1Q2loGACtBGjQc9
         EWTL2vZYWKjMrbK02hGqSULiYzZVsI8zFZDDbzgw34elZH0/cU3FsbBhkMc77J2XLgxp
         eNVmEydrmBAKvxVyHCr2OyqCfiHK8zc3yc+eMj7LBmyL+37bIvt8/ML7nUh/HIINmqA/
         NBYhVZtw+PdbPcaOKfWdLnO3hwW/n4hdb7oGMjnixPZdlZNVf78vY/tUGVV1eK5EkJ4O
         1cTBCwJP1fbWmdnqw8R7mCkpA28jkn9Li0Mou886R8y1Sw6m1DDGwI6uGubm6xgEG0BD
         z+EQ==
X-Gm-Message-State: ACrzQf1WFEQNcVNqo7oqbZdWMlRhQ2+FHCGx2LbZxAFktfIevJwhlKYi
        /x0Snqagi1tmmfQfAQuN68pMAw==
X-Google-Smtp-Source: AMsMyM4puBHy4Rz/W6PItnEMR/7sY4Ht+hZTcYiZeHp4JNp/zgQEonPnvSrDu9FZgasYBNB+TeWwvw==
X-Received: by 2002:a63:3182:0:b0:46f:ed32:54a6 with SMTP id x124-20020a633182000000b0046fed3254a6mr17225891pgx.69.1667589941673;
        Fri, 04 Nov 2022 12:25:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w128-20020a626286000000b0056ca3569a66sm3045377pfb.129.2022.11.04.12.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:25:41 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 4 Nov 2022 12:25:40 -0700
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: txgbe_calc_eeprom_checksum(): Control flow issues
Message-ID: <202211041225.FF75B11482@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221104 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Nov 2 12:31:23 2022 +0000
    049fe5365324 ("net: txgbe: Add operations to interact with firmware")

Coverity reported the following:

*** CID 1527152:  Control flow issues  (NO_EFFECT)
drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c:200 in txgbe_calc_eeprom_checksum()
194
195     	for (i = 0; i < TXGBE_EEPROM_LAST_WORD; i++)
196     		if (i != wxhw->eeprom.sw_region_offset + TXGBE_EEPROM_CHECKSUM)
197     			*checksum += local_buffer[i];
198
199     	*checksum = TXGBE_EEPROM_SUM - *checksum;
vvv     CID 1527152:  Control flow issues  (NO_EFFECT)
vvv     This less-than-zero comparison of an unsigned value is never true. "*checksum < 0".
200     	if (*checksum < 0)
201     		return -EINVAL;
202
203     	if (eeprom_ptrs)
204     		kvfree(eeprom_ptrs);
205

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527152 ("Control flow issues")
Fixes: 049fe5365324 ("net: txgbe: Add operations to interact with firmware")

Thanks for your attention!

-- 
Coverity-bot
