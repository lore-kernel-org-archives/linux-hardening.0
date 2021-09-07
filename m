Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25CCC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  7 Sep 2021 18:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F54D60ED8
	for <linux-hardening@archiver.kernel.org>; Tue,  7 Sep 2021 18:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbhIGSMw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345595AbhIGSMw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 7 Sep 2021 14:12:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701DC061757
        for <linux-hardening@vger.kernel.org>; Tue,  7 Sep 2021 11:11:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r2so10866252pgl.10
        for <linux-hardening@vger.kernel.org>; Tue, 07 Sep 2021 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0/23xqaes2XTEieQoEC3hXOVOrS1/VG6sVUwEzA4poY=;
        b=I53v0vNVcXjLUAzgN6FABSj/CpajH90TchdbeflSijyCy/S5z85IqohRum5yaNlzq3
         6yyxJ7b2BJlYRuWxWGiRgrUPTmMviDqWUtIh+vm1yp44d5oq0Trnw1QkiRCoq4NpLTVA
         YBbHyOX3+1JOgv9WN/11gNZTK6Nwjf3Dtt/co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/23xqaes2XTEieQoEC3hXOVOrS1/VG6sVUwEzA4poY=;
        b=gDFf8A08PYenplGMVJGzFhpb/WFsEQdeHbgbGR1U+nVb6QP9wiY4hZYXDJugyL6NrW
         QpmYXn5ZOE+7MymGEhYp+EmZA4Gebnvjugr6htfoWdP2cWvjlDTYA99PsXRRXtkUlzG7
         WKrKGK+0wNjdq1yLvgh6/01hdy4d4I2xIJwOQkrexQWJpzZ2FcdP0OaSnuwAZRpQQhWr
         nyG8aoWl6gttGcx50WXW+2e2IFVQsNgByLhxHFhCpLvwPSYlEcDoaugGOiprLFv0o9vF
         HhlIggL0IZw4swmp+kDWHwloVk2wgnBspJciA01d93mAoIxNa72lljN8rY1t9oDBlxXl
         FceQ==
X-Gm-Message-State: AOAM531f8sGJ7ILfe9KzsT9RyfmT8yH0KIVIrCUNGRNZWMb86747BdyF
        eBwXbFlYmJVHe73MidFJXvTI5A==
X-Google-Smtp-Source: ABdhPJwvTjM+WRKARPvOY9pppfCCr5cnbhUPMqU4TuILvTxoMwyy8qFcltQrhIaNJAzdDsSAdOYp2w==
X-Received: by 2002:a63:5902:: with SMTP id n2mr18155671pgb.305.1631038305244;
        Tue, 07 Sep 2021 11:11:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c133sm11158629pfb.39.2021.09.07.11.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:11:44 -0700 (PDT)
Date:   Tue, 7 Sep 2021 11:11:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Chrisanthus, Anitha" <anitha.chrisanthus@intel.com>
Cc:     "Dea, Edmund J" <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm/kmb: Avoid warnings on impossible plane_id
Message-ID: <202109071107.1E6C9DA5@keescook>
References: <20210825181807.1138053-1-keescook@chromium.org>
 <BY5PR11MB4182ABD607EB99C1F68777928CC69@BY5PR11MB4182.namprd11.prod.outlook.com>
 <BY5PR11MB4182FEB7263045FC3855723B8CD39@BY5PR11MB4182.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB4182FEB7263045FC3855723B8CD39@BY5PR11MB4182.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 07, 2021 at 05:32:53PM +0000, Chrisanthus, Anitha wrote:
> Hi Kees,
> This patch https://patchwork.kernel.org/project/dri-devel/patch/20210728003126.1425028-13-anitha.chrisanthus@intel.com/ is pushed to drm-misc-fixes. This change should fix the below warnings.
> 
> I apologize for all the inconveniences. 

No worries; thanks for the heads-up!

(sfr, this change should fix the warning[1] uncovered by the KSPP tree now.)

-Kees

[1] https://lore.kernel.org/linux-next/20210830184429.1ee4b4d8@canb.auug.org.au/

-- 
Kees Cook
