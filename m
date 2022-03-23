Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C98C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Mar 2022 22:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345209AbiCWWcR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiCWWcQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Mar 2022 18:32:16 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8538F99B
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 15:30:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q19so2347110pgm.6
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kuegp+jO55Es2fDo8uYnNCcqkv5SBF2sv4c9HycY6CM=;
        b=HYy8RfEcJn0cdTzqwpS2rlZi7xnKmbeG+psgdpchzqU/5y+CTsFtVX4rVeEtsVb83D
         hAFNA1M1MtQL9GFDKHiGNlyncPlwKh5GVNrn8g9edkO55gj6nqwVPQ504xJOVnaEYKtq
         8AGKluaPKOdzHMuFDynqtxL9szrRkudj9R+Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kuegp+jO55Es2fDo8uYnNCcqkv5SBF2sv4c9HycY6CM=;
        b=xPZGPXzQj7j6lucCERNCimXgP6sQAIt/at8NS2Ge77FaCPYikbPrne1LSu4M0l5wSH
         mc71kgJvAdpvwur0dPkfavmob6AMYxjHZUL9hVNdxmGEtoWNh39EKBSxhbmz0WS52pTh
         jctsdEwQy6q5Drdm3tKrRJjZ9Dq54mr+De8IUmzZjiR9b3iHhgPn/4uMAOmKupCMzUTe
         bJmbhthXpPuYLC8y2zrRnuyOJ8p/c/naqfGEdmGu9n/MArirJtVS9hQFyAaYznAfX0Bs
         tJccpRRUfVZnBp1E9se+xJ5xzbOOyxfb9RNPtrfXbDnl+9LxR5Cf33x2dWfiv4DNnCW+
         waFw==
X-Gm-Message-State: AOAM530iX12GG+QUe9UTm67v3UvGS2S0/2gDiQabcMvllXRlom6xXwWT
        pe/rWH0dD/x5te1Z6doaWgCdyQ==
X-Google-Smtp-Source: ABdhPJz6ppDgUCCU1EEidVNx0pB3pB42Xh2BRv858RFx8oyIXI6p3k7PGxbYXLcQkfyt+HaBh0l3Ew==
X-Received: by 2002:a05:6a02:101:b0:386:865:44a0 with SMTP id bg1-20020a056a02010100b00386086544a0mr1585953pgb.475.1648074645645;
        Wed, 23 Mar 2022 15:30:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u15-20020a056a00098f00b004faa58d44eesm839224pfg.145.2022.03.23.15.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:30:45 -0700 (PDT)
Date:   Wed, 23 Mar 2022 15:30:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [scsi]  6aded12b10: kernel_BUG_at_mm/usercopy.c
Message-ID: <202203231529.0CB76344@keescook>
References: <20220320143453.GD6208@xsang-OptiPlex-9020>
 <20220323071409.GA25480@lst.de>
 <202203230809.D63BF9511@keescook>
 <Yjs/6pLB1uDKBRCG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjs/6pLB1uDKBRCG@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 23, 2022 at 03:42:34PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 23, 2022 at 08:40:30AM -0700, Kees Cook wrote:
> > On Wed, Mar 23, 2022 at 08:14:10AM +0100, Christoph Hellwig wrote:
> > > The actual warning is;
> > > 
> > > [   34.496096][  T331] usercopy: Kernel memory overwrite attempt detected to spans multiple pages (off set 0, size 6)!
> > > 
> > > This is for the cmnd field in struct scsi_cmnd, which is allocated by
> > > the block layer as part of the request allocator.  So with a specific
> > > packing it can legitimately span pages.
> > > 
> > > Kees: how can we annotate that this is ok?
> > 
> > The main problem is that CONFIG_HARDENED_USERCOPY_PAGESPAN=y is broken
> > (and nothing should be setting it).
> > 
> > This series removes it:
> > https://lore.kernel.org/linux-hardening/20220110231530.665970-1-willy@infradead.org/
> > 
> > Matthew, what's the status of that series? Will it make the current
> > merge window?
> 
> I thought you were going to merge it!  I haven't put it in any of my
> public trees.

LOL. Okay, you'd mentioned another check, so I wasn't sure. I can go
ahead and snag it, but I'll likely wait until the next window and let it
live in -next for a while, unless you think it should get YOLOed in. :)

-Kees

-- 
Kees Cook
