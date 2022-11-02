Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0947C433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Nov 2022 19:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKBTwV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Nov 2022 15:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKBTwU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Nov 2022 15:52:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA6313D41
        for <linux-hardening@vger.kernel.org>; Wed,  2 Nov 2022 12:52:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso2851905pjc.5
        for <linux-hardening@vger.kernel.org>; Wed, 02 Nov 2022 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVnODRiO/ElefdrU89ZGh8bQT9IYvN698hHdwky/m6k=;
        b=Y7zWeBd1AWnqQX5Uhw1zRV3alPQ3Z+TMa50rGRcLBiBMzep+Hvl1XTtlrZxrxeEqEF
         fu6xj0bGJSpWv9QIRuwP8oMcI3C1afhEJXN3GQxrGPPGSLA+N0gcHTTAOcgyx9f6ILiJ
         MDxJoqZx0haCKG3w9r4dweSy1toF84uStOGHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVnODRiO/ElefdrU89ZGh8bQT9IYvN698hHdwky/m6k=;
        b=olsuEtyR4D0WEf1mzXa3VTz9gyJYJJmw6ivZdUEh8loOkq92fAmvw+HbQofuE8cYZE
         ZMNDMqrMfr6QcgQYpaoGUSLaSSWytXXU9tpPrJywMYSMkh2Rx5njj7+0q7DV57wQS2Og
         qjEUtOA/KIuAJNIqK5NnAsihRzDc6Uiy8w2qL3InkdW/7SEqgONwzV6CuVlfb09uMFTc
         5cY9YTbq23kb6hAhrc3sDy619oF+pSA4XuOMWXTgwiWn9TY+XldVxdwrLI7+VaILcgGy
         amnfvfTcNUsr4Cxvd0Bq0mHu2KcJvmvzyV+xaqSxDhGU3g1TN0DBqHDEHQHbvrxvHrcl
         QK7A==
X-Gm-Message-State: ACrzQf1ja6ojTF5dVohZ+x9RCZGI9pjJEb94ENDmWjsVlKp7gxvwPXZj
        rfd3j1jS7pOa2pZ0dz0O4mCgmw==
X-Google-Smtp-Source: AMsMyM70pm8CSuoI/Tb3EW/06SKY9bsUT2cbUhwwe8nhH+9ZQHFRJ13ovN8LOv406Vnv+Xh4yk8ZnA==
X-Received: by 2002:a17:902:d54a:b0:186:a43b:8e with SMTP id z10-20020a170902d54a00b00186a43b008emr27412982plf.36.1667418738127;
        Wed, 02 Nov 2022 12:52:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090a3fc700b002130ad34d24sm1867464pjm.4.2022.11.02.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:52:17 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Wed, 2 Nov 2022 12:52:16 -0700
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: page_zone(): Memory - corruptions
Message-ID: <202211021251.632286C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221102 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Tue Nov 1 17:26:18 2022 -0700
    5cb2ae82a4c4 ("mm: simplify page_zone() and get_deferred_split_queue() with page_pgdat()")

Coverity reported the following:

*** CID 1527097:  Memory - corruptions  (OVERRUN)
/include/linux/mm.h: 1458 in page_zone()
1452     {
1453     	return NODE_DATA(page_to_nid(page));
1454     }
1455
1456     static inline struct zone *page_zone(const struct page *page)
1457     {
vvv     CID 1527097:  Memory - corruptions  (OVERRUN)
vvv     "&page_pgdat(page)->node_zones[page_zonenum(page)]" evaluates to an address that is at byte offset 114688 of an array of 81920 bytes.
1458     	return &page_pgdat(page)->node_zones[page_zonenum(page)];
1459     }
1460
1461     static inline struct zone *folio_zone(const struct folio *folio)
1462     {
1463     	return page_zone(&folio->page);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527097 ("Memory - corruptions")
Fixes: 5cb2ae82a4c4 ("mm: simplify page_zone() and get_deferred_split_queue() with page_pgdat()")

The problem appears to be the difference between page_zonenum()
returning up to ZONES_MASK-many, and node_zones[] being sized
precisely...

Thanks for your attention!

-- 
Coverity-bot
