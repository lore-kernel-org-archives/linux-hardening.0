Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F6C6379F
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 23:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAMXzl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjAMXzk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 18:55:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DE75763
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:55:39 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so25922036pjj.4
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LF3WsXigIPtoM91xDdGg1MKwYTSeuEO0M3pVuLY/JbQ=;
        b=UooW/gPdlyiA1OGaapbkni44sryCSNVmMvtT9Ul9RLHWTvKLioT8nJxXKUFZqlBUC2
         fVRlwYCZe2oHJ/vbuFEOs/HGaZgm2cDjSh/ntaE0nzKPdbPqZTP/JRCDDWEyuLIALOYC
         KECbXHdpPj+Ai1NKz/0SixoNMulCOF6hUTPX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LF3WsXigIPtoM91xDdGg1MKwYTSeuEO0M3pVuLY/JbQ=;
        b=HhTILehEEnV+1+Hj5R3gHj6uTLuvy66u9JQfKgGVn8eytbnUXlu1RMlHIvUyXoJph0
         jZLdoLE9dwvoN3sGrE+O0CbOpt97WC+7/j07Yb70wQJvixRZI8CS33crRQWZmJv0WiMI
         MYcPSDNU7U89mjaLdsCfmCaucsNeQj2T+jS4JrKozU/0lCo7pVkRDq40VLhQ2i9ORm6m
         Sxj9AcAzSB2lvej/EUAzcH8DwaoFlzfVgJhrWF2EacFWC9Bdjh7IUPIhDt3PjL1I4TcM
         Yg6Y55kuSYMleyuvpaepNBfT+Q8+BgGXPd9vqPMyP6IE9r8QvhcC2MK9+FBdu4aBdxv4
         DsGg==
X-Gm-Message-State: AFqh2kqNijEoiT14LGHvwzZawdUJ1zX+AYGXTdcQnXOkHdw2Cw/jk6AM
        nwaeTix63s7RKHibNfpUhv12iA==
X-Google-Smtp-Source: AMrXdXsOAdCKdSgYkiZ/E0ZO8oA/rxRKPzE25xlurZuhM3GKj0+vty25gaw2s5FBdvVB2khEsKzUew==
X-Received: by 2002:a17:902:d50e:b0:194:3e44:26a5 with SMTP id b14-20020a170902d50e00b001943e4426a5mr22623176plg.66.1673654138780;
        Fri, 13 Jan 2023 15:55:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm12379469pgr.32.2023.01.13.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:55:38 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 13 Jan 2023 15:46:49 -0800
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Holger Hoffsttte <holger@applied-asynchrony.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, linux-mm@kvack.org, amanieu@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: check_empty_area_window(): Error handling issues
Message-ID: <202301131546.73FBCC7B6@keescook>
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

  Wed Jan 11 16:15:43 2023 -0800
    ebc4c1bcc2a5 ("maple_tree: fix mas_empty_area_rev() lower bound validation")

Coverity reported the following:

*** CID 1530569:  Error handling issues  (CHECKED_RETURN)
lib/test_maple_tree.c:2598 in check_empty_area_window()
2592     	MT_BUG_ON(mt, mas_empty_area(&mas, 5, 100, 6) != -EBUSY);
2593
2594     	mas_reset(&mas);
2595     	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EBUSY);
2596
2597     	mas_reset(&mas);
vvv     CID 1530569:  Error handling issues  (CHECKED_RETURN)
vvv     Calling "mas_empty_area" without checking return value (as is done elsewhere 8 out of 10 times).
2598     	mas_empty_area(&mas, 100, 165, 3);
2599
2600     	mas_reset(&mas);
2601     	MT_BUG_ON(mt, mas_empty_area(&mas, 100, 163, 6) != -EBUSY);
2602     	rcu_read_unlock();
2603     }

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1530569 ("Error handling issues")
Fixes: ebc4c1bcc2a5 ("maple_tree: fix mas_empty_area_rev() lower bound validation")

Thanks for your attention!

-- 
Coverity-bot
