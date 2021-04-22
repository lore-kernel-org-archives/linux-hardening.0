Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF9C433B4
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Apr 2021 03:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F6D61445
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Apr 2021 03:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhDVDV2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Apr 2021 23:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbhDVDV1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Apr 2021 23:21:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9F0C06138C
        for <linux-hardening@vger.kernel.org>; Wed, 21 Apr 2021 20:20:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u7so20982685plr.6
        for <linux-hardening@vger.kernel.org>; Wed, 21 Apr 2021 20:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YmmSdM90pO+sNar6XOrbSuxi/vNNsjBBP9QqUAGRLKs=;
        b=N4rfBPuNckMo+Fl/dEflNtB4rmTU6SHg0TMhaV0iuduYgSiQaUq6hI4moIv83mvcLK
         8i3XJyR/+rQgXenMfAXPOVN2FRqj+oybQNJHs5Vh8onyTvKFr4mUOhbagxlbJ/E/YnJJ
         3SlYXItdKqok6r2OWgFY1wRNX+EowDgvIQZEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YmmSdM90pO+sNar6XOrbSuxi/vNNsjBBP9QqUAGRLKs=;
        b=OzDjmHtNSVHacq28LjTx6tofkIlCVufkCzS2MxPxi4vEilRIrASDOR5+g7ltL50hlJ
         7h4LHYHylNQMh/hlNJsGV25DyyoM0QK5ocgK2B4K5u5U2ZSfnwfovajd+XuJtVS088zk
         MvG+Wnjdm5VjG10nl/K/pRcnUG+EXgaWi+yK8SOoAQKhrwpOU+SO2Y1b9O/o2RqfLAEc
         1zb/AerIvF1GuhhNbrLIFdiUqYGrFHtSFXSUkAqmUZKMw96WMKALtzSR2KpFipWwDpuu
         5tIiTbEI50WWk1dqSYzsnD7pXJAU5tD7AlR+3+qTuBaoVI9coIfEfpdPk7r4wdmLOLhR
         7YaQ==
X-Gm-Message-State: AOAM530chMUY9VFMwUIyiZgbNR8ltlLqPa9NQbss3IS6UsSPenJVgeha
        0FDPhkdyGhXjvWcNh+xgWvf0PQ==
X-Google-Smtp-Source: ABdhPJxXE21iqS93U9HQ1ku5cSKxhO6e51gwHM/EuN1XMjVT+yzg7TfUzLT6zz0CaK+8lBiRuj7KQA==
X-Received: by 2002:a17:902:7b8e:b029:ec:982d:7a7e with SMTP id w14-20020a1709027b8eb02900ec982d7a7emr1426937pll.55.1619061653273;
        Wed, 21 Apr 2021 20:20:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m7sm552380pfd.52.2021.04.21.20.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 20:20:52 -0700 (PDT)
Date:   Wed, 21 Apr 2021 20:20:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] scsi: aacraid: Replace one-element array with
 flexible-array member
Message-ID: <202104212019.4315F80C@keescook>
References: <20210421185611.GA105224@embeddedor>
 <yq18s5bt42e.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq18s5bt42e.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Apr 21, 2021 at 11:03:19PM -0400, Martin K. Petersen wrote:
> 
> Hi Gustavo!
> 
> > Changes in v3:
> >  - Use (nseg_new-1)*sizeof(struct sge_ieee1212) to calculate
> >    size in call to memcpy() in order to avoid any confusion.
> 
> The amended memcpy() hunk appears to be missing from the v3 patch.

It's unchanged from the perspective of the original code. (i.e. there's
no need to change it since that memcpy isn't involved in anything
changed by the swapping to the flexible array.)

-- 
Kees Cook
