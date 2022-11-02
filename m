Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B440FC433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Nov 2022 19:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKBT5K (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Nov 2022 15:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiKBT5J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Nov 2022 15:57:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259C2304
        for <linux-hardening@vger.kernel.org>; Wed,  2 Nov 2022 12:57:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k22so17380009pfd.3
        for <linux-hardening@vger.kernel.org>; Wed, 02 Nov 2022 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhfCRvSTXBtz/vDK//XVIJ5L6CYMoQLlwnTJQfWHDTc=;
        b=J2j04uzYjFvAkEAJcxtHlzouxTzwQP1GU8xQDInhMtd6I+L6h8KZvR8IZqNO5p58B/
         BCjJawNQBM40sLvBemw8GDnnDOOEiCH6ZL9er1KD03xF7Tj/x7xu1rtjVCWMoBeJzpcv
         S5RxwPL7+wfld9PsBprJgmhuh6f1XQrcc14Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhfCRvSTXBtz/vDK//XVIJ5L6CYMoQLlwnTJQfWHDTc=;
        b=cfmi9U3EK6+q28qfveK4zLrC2Iig5f9lktoX97YWRnAQLDyC24OvlTO6IGhGJkCJLn
         GepC+JJJIHNjFSUDG+c153cMz4ehsabsTxbYyYISzuz88jI7k4/tW6crsuVA9rQoE9q0
         W1PPVLj9fp8JMTd2kr9Y7FWz3UHZL2hcOL0baWO4DfHDO7osDbuCw+JfBiDD0qY9CMIL
         CUyIctdG1U70lVMnAesqmiWOEiM74BXZZeDaxvesfIVElnF05dlxI9CJ6n/lOHFn10aV
         ZprRBU6ynXYqQ2470X1npBNkX299QrkQWBQ8sKp/W0DX5V+QxoWnscUMzcvNLbAqCeQg
         9wFw==
X-Gm-Message-State: ACrzQf0z571k2lq3Nhqr6HED+kSzwcVilFJV9Euf05P05g2clBoEC6C5
        ONaCsbNHonWVt/e51IsLhZELKA==
X-Google-Smtp-Source: AMsMyM70YUcgfPHoQ6myIfUrDbXicCoezde8NvNejsH2fodFQYEAC5bbuvSQhE7lKJUPbmHf8T9xNQ==
X-Received: by 2002:a63:5761:0:b0:43c:5940:9176 with SMTP id h33-20020a635761000000b0043c59409176mr22661724pgm.65.1667419026584;
        Wed, 02 Nov 2022 12:57:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b0018685257c0dsm8772235pla.58.2022.11.02.12.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:57:06 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Wed, 2 Nov 2022 12:57:05 -0700
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: iopt_map_user_pages(): Null pointer dereferences
Message-ID: <202211021256.2F571DFD@keescook>
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

  Mon Oct 31 13:37:57 2022 -0300
    91b4be750274 ("iommufd: Data structure to provide IOVA to PFN mapping")

Coverity reported the following:

*** CID 1527090:  Null pointer dereferences  (REVERSE_INULL)
/drivers/iommu/iommufd/io_pagetable.c: 417 in iopt_map_user_pages()
411     	list_add(&elm.next, &pages_list);
412
413     	rc = iopt_map_pages(iopt, &pages_list, length, iova, iommu_prot, flags);
414     	if (rc) {
415     		if (elm.area)
416     			iopt_abort_area(elm.area);
vvv     CID 1527090:  Null pointer dereferences  (REVERSE_INULL)
vvv     Null-checking "elm.pages" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
417     		if (elm.pages)
418     			iopt_put_pages(elm.pages);
419     		return rc;
420     	}
421     	return 0;
422     }

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527090 ("Null pointer dereferences")
Fixes: 91b4be750274 ("iommufd: Data structure to provide IOVA to PFN mapping")

This looks like the earlier "if (IS_ERR(elm.pages))" should use
IS_ERR_OR_NULL() ?

Thanks for your attention!

-- 
Coverity-bot
