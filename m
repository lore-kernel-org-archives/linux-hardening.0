Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327ADC4321E
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Nov 2022 19:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiKBTzA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Nov 2022 15:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiKBTyp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Nov 2022 15:54:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE41764E7
        for <linux-hardening@vger.kernel.org>; Wed,  2 Nov 2022 12:54:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l6so17274919pjj.0
        for <linux-hardening@vger.kernel.org>; Wed, 02 Nov 2022 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpdOKSsP0rXLwj52fhVSz3M8ex3vIKbdfN/pmlLm1jQ=;
        b=KHbmzjpOK0HSahJ5Dpgbdu6E9Z9+/sQe90lSDsClsL3OV3bMnrwgKiOkw7iJPxA/O8
         /iW+Ew7FBZ+cvupV5ACcJskT6pXy4FtScwuxviLd2sHeLr/RUu+FMwENmRLnCHWx8P9b
         c5OfLkCWKjgwHnv/dlV3TC5z3yPM+244zEFyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpdOKSsP0rXLwj52fhVSz3M8ex3vIKbdfN/pmlLm1jQ=;
        b=nQur2HSR9bT2h44HqR66VyPW/BRAsMXfwMMgvRk13Unf36nTzjmNiIP+GCowERVnFa
         Mmz3Xt6WzgS1Z2fnEe1JjxtC+kSmli+IsqBHEfE2vyeIBVLGS5wFxv2NK3P+x/LAF8Hs
         JkaLA21BV4Z9tfrTvmPL536CuMITIMycJ1AiRSMV6yr/fkGVmRA8dLg887MvRTx+81JG
         j0WvpO1ZbHiGoEIhzAGhs5ISEREYG3JNG/74eZMFE+Ur93cQ+yKloV8/WWxja50XMqjJ
         Uaem4GSzlBb62oF3/ferRGhAAQGz1oP3aZmIvCnkZ2KGP/mIWHkcv8RKzeISfdVuM8cH
         Vwrg==
X-Gm-Message-State: ACrzQf2fwSWzkp39PU7XRNVF8BFrL/BNMtHCMd0gCbg07R0byuvqfFJm
        fujyUB0zL3XGEOm/DQMQ1HEkPg==
X-Google-Smtp-Source: AMsMyM5TFH8vASpLDelQf3tF6oH4QFOt4bTO1eNLdmm+lxx1jefvQ62ozQDT9pj71IUO4SIfp5L+og==
X-Received: by 2002:a17:90b:1948:b0:214:1ae7:a511 with SMTP id nk8-20020a17090b194800b002141ae7a511mr8582432pjb.89.1667418881391;
        Wed, 02 Nov 2022 12:54:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 6-20020a631446000000b0046f7e1ca434sm8059421pgu.0.2022.11.02.12.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:54:41 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Wed, 2 Nov 2022 12:54:40 -0700
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: iopt_map_user_pages(): Memory - illegal accesses
Message-ID: <202211021254.4B47DCD2@keescook>
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

*** CID 1527094:  Memory - illegal accesses  (UNINIT)
/drivers/iommu/iommufd/io_pagetable.c: 415 in iopt_map_user_pages()
409     	elm.start_byte = uptr - elm.pages->uptr;
410     	elm.length = length;
411     	list_add(&elm.next, &pages_list);
412
413     	rc = iopt_map_pages(iopt, &pages_list, length, iova, iommu_prot, flags);
414     	if (rc) {
vvv     CID 1527094:  Memory - illegal accesses  (UNINIT)
vvv     Using uninitialized value "elm.area".
415     		if (elm.area)
416     			iopt_abort_area(elm.area);
417     		if (elm.pages)
418     			iopt_put_pages(elm.pages);
419     		return rc;
420     	}

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527094 ("Memory - illegal accesses")
Fixes: 91b4be750274 ("iommufd: Data structure to provide IOVA to PFN mapping")

Thanks for your attention!

-- 
Coverity-bot
