Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD117C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 11 May 2022 03:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiEKDPu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 10 May 2022 23:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiEKDPt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 10 May 2022 23:15:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74D312601
        for <linux-hardening@vger.kernel.org>; Tue, 10 May 2022 20:15:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so3664052pjv.4
        for <linux-hardening@vger.kernel.org>; Tue, 10 May 2022 20:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5NqBhJncEVUk2Pf1eI7/8nYp94z8rVRASEDNRY/5rLM=;
        b=EL8jSIB4rrhW5MGwrl6kRzt6+DCrDQMJQn3wbDoSslBIhLXLMTRdCiUE/wf6D6RKui
         q6ETmlR97XQQj8+PGMEsY5P7lD6Jdhmnw/PaJXcRrD3mYNJfGVhf6nCHegcj1GcgmQ9w
         ZofttmOGg9O/2Iifq7pxjnJ84G8UsoIDtSHJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NqBhJncEVUk2Pf1eI7/8nYp94z8rVRASEDNRY/5rLM=;
        b=DdiY2ADXCgGMO5X9krApa47Fmyjv2J4LejO/XxjRxyyApKmoqsJaqyjKUfeQJpU2Qd
         kG4o96cpTDmYy2BWQoj7DZcVXJndaGsTsbPnRb+bWd0fgsislAkeoJvSgRf7vFm/X/xv
         vqS1F/0JY5SQ3bJ+tV1v5FkcfbAm9A5TaTSaTgKkkUcQqssfIdZugYrunzco05XneccB
         zSudMDRLFZwY0FvIj9EtV/Bb6bckXfV64++fVNT+SxOwpqzo2nqBmssP+6QCcWLX9M6W
         wnSIau2ZQAEZHjGALzSJW+yV2pruTlZ+qiz2FyOM5sAqlrLuGl7EddpmL+jRSvyTIrqj
         Cizw==
X-Gm-Message-State: AOAM5331JCrLS5M3zHmqke2gkh7GpDs7i4qtSQPf2BglxMc/b5zFLB6L
        bVmYRALqWKUwyqD+5X/ZDGmQIA==
X-Google-Smtp-Source: ABdhPJyd1dEIvJa9UluCWVd8wprzlfzW7U7Y7P5K4Bg/8vGrg1CSsd9HHwgnpnEfcVwwjxYOlZuFbw==
X-Received: by 2002:a17:902:d2ce:b0:15e:c024:6635 with SMTP id n14-20020a170902d2ce00b0015ec0246635mr24185444plc.28.1652238946411;
        Tue, 10 May 2022 20:15:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x8-20020a17090a788800b001dbe11be891sm2567976pjk.44.2022.05.10.20.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 20:15:46 -0700 (PDT)
Date:   Tue, 10 May 2022 20:15:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH V10 14/44] mm/pkeys: Introduce pks_set_readwrite()
Message-ID: <202205102008.88C15972@keescook>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-15-ira.weiny@intel.com>
 <202205091304.434A9B45@keescook>
 <YnraD8URWxWtaltF@iweiny-desk3>
 <202205101504.5B5C693F7C@keescook>
 <76ee55622592d531c82cb42b96d4bb27deb26287.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ee55622592d531c82cb42b96d4bb27deb26287.camel@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 10, 2022 at 10:26:43PM +0000, Edgecombe, Rick P wrote:
> v2: 
> https://lore.kernel.org/lkml/20210830235927.6443-1-rick.p.edgecombe@intel.com/#r
> 
> Mostly it fit together pretty easily, but there was memory overhead
> required to protect the page tables that map the direct map fully
> (unless a better solution can be found).

Oh my, I totally missed this. Yay for Too Much Email Every Day. ;)

I'll give this a read; thanks for working on it!

Also, can you speak to the schedule of availability for PKS?

-- 
Kees Cook
