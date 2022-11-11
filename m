Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A3C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Nov 2022 00:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiKKA0s (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 19:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKKA0r (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 19:26:47 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B405C5F855
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 16:26:42 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o13so3106426pgu.7
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5NGc0Wtc/LAmeM4ZbbbL8b0+UEPmBPAYTp12Vkl1o0=;
        b=OYVMNqSYsFjm1l8Gb77rL89LoGY1zcp9Xm6VxVICPuHEclqOVJvgjkuoDATdF3jc9z
         WQ362RA9vIleTOkpT9IQ12tgbW8mtK8oT7L3E9avA34iV1hjk3pk/jNAVGr2HGyTnBTF
         IFnm+HQJ7g8P5sFjNIAVrYXFIK5sf1GV4jQYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5NGc0Wtc/LAmeM4ZbbbL8b0+UEPmBPAYTp12Vkl1o0=;
        b=EWb7JnDN6p4Aj3bNpooOPS1t6QUkg/nf6XuvtXknE37A1tJK5le49Zvz2hUJr3N18H
         dn/KQRQ0ic0GciWMBXlb+3R/Yr9/+Q55iP446VGN75F/EkGBh8rJDPHW2U7TQWL4DwNU
         tQX5ig7cLjgO+3u5nVvN+X/U9H29xixnEc2njG2EpYZADiJmpFJIMWTU+PrYH2NMqrEf
         YMsgcgymzZ3HHCuXfKYoOIAVukDDjyKvlalvvpFz+K7GTgn+II2C8Zk07KiIEtn3ARpg
         hHsQOaiocAa0G+SZQQBCMfmUQ/lgD32HHbp8fe5qhjIfsJue/XO91VMw4y5O57lj7kZS
         /4vw==
X-Gm-Message-State: ACrzQf2MJ8hZc4C+kJSAOz/HXXu4xv5/oUVJIWluqYPB8KIxSS2REliY
        QCrdjaBKDFrNFO+yfg+OGM25Dg==
X-Google-Smtp-Source: AMsMyM7Kh7CVcxqJugz4JnRLlCyj+VNc2Jl1ZCgSFYUBWm/peCV0U9rmVHoHIjznkrpRLbvkAA1Bdw==
X-Received: by 2002:a63:5543:0:b0:46f:ed3a:f38b with SMTP id f3-20020a635543000000b0046fed3af38bmr3803064pgm.387.1668126397981;
        Thu, 10 Nov 2022 16:26:37 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0018703bf3ec9sm288513plb.61.2022.11.10.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:26:37 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:26:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     coverity-bot <keescook@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: zram_recompress(): OVERRUN
Message-ID: <Y22WtxzDXM5PfFnb@google.com>
References: <202211100847.388C61B3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211100847.388C61B3@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On (22/11/10 08:47), coverity-bot wrote:
> *** CID 1527270:    (OVERRUN)
> drivers/block/zram/zram_drv.c:1727 in zram_recompress()
> 1721     		zstrm = zcomp_stream_get(zram->comps[prio]);
> 1722     		src = kmap_atomic(page);
> 1723     		ret = zcomp_compress(zstrm, src, &comp_len_new);
> 1724     		kunmap_atomic(src);
> 1725
> 1726     		if (ret) {
> vvv     CID 1527270:    (OVERRUN)
> vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).

Hmm... I don't really see how prio can evaluate to 4.
