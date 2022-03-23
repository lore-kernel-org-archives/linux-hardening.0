Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65765C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Mar 2022 22:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiCWWfD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbiCWWfC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Mar 2022 18:35:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D132F25595
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 15:33:31 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f3so1287108pfe.2
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FLvEj99W00mHv5B9slSilnvGkrPhQki6M9e6QFVKTLw=;
        b=c+I8yLbApFcdgUn8ce7KccpjXqMKYbFfWoXTnmRsnyTyPLPllx0fX54RZjMcU+2hax
         6g5G3cEOm5r3ZlMtA7kWxOLun+XwYqpPgVLElhqunddjM95buZ73WOrAkW7GhYeug88W
         vTT0PKJ1e5bSz1zqzS4QGFEmJq0qFDp+FbdoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FLvEj99W00mHv5B9slSilnvGkrPhQki6M9e6QFVKTLw=;
        b=nwlK/BVmxd8HMq7jtMpwKU8bKetB/g0b2cbJrkHlsMZRdXlOkzjQ+6lLg++4CBDDn3
         WY9NR97FN+M0UjysLb0mueYwhCe2jUzFCo/spM+W5cisaw5+Z0weuTTRHzmH6TDgeojq
         13EGuu9bintaUoy29urKKWc85agkXuzo2+3zI+iFdks9jKPzjZ/cyRU4DVk04ASRWeqI
         B8qq/xfaIqwNPdbpfLNgmIBBF+wHCqrr2PvYSChrKeBczAIeCPkhxT03jB/eawjUxSQr
         qeDHVHbPtwPvdZ9OpHjSl23aJEQk9w1NIyh//7MUzO+Pu+FurjCnf5WKX+zgd+BtgBBT
         IemA==
X-Gm-Message-State: AOAM532jp9drFJ+Yq9Gd9IJnDtTkh0NWuVJcbVX4rS5ZRpuMOnHEGB19
        eDmZmoxPjpIlbwZoy7NMceEgQMUFXvFLqw==
X-Google-Smtp-Source: ABdhPJyz4zUzV3AWTkSwEjVMOftfaD5LbJrk0gnGi1w1o8j0flvgW2Dv6sCuVA11x5HmY4oAo0VoQw==
X-Received: by 2002:a63:e243:0:b0:381:6a51:145f with SMTP id y3-20020a63e243000000b003816a51145fmr1615681pgj.625.1648074811398;
        Wed, 23 Mar 2022 15:33:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w24-20020a639358000000b00385fcbf8e55sm708627pgm.28.2022.03.23.15.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:33:31 -0700 (PDT)
Date:   Wed, 23 Mar 2022 15:33:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [scsi]  6aded12b10: kernel_BUG_at_mm/usercopy.c
Message-ID: <202203231531.02D8297F77@keescook>
References: <20220320143453.GD6208@xsang-OptiPlex-9020>
 <20220323071409.GA25480@lst.de>
 <202203230809.D63BF9511@keescook>
 <20220323154739.GA816@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323154739.GA816@lst.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 23, 2022 at 04:47:39PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 23, 2022 at 08:40:30AM -0700, Kees Cook wrote:
> > Regardless, I'm concerned that disabling PAGESPAN will just uncover
> > further checks, though. Where is allocation happening? The check is here:
> 
> blk_mq_alloc_rqs, using alloc_pages_node.  This hasn't actually changed
> with this comment.  Just the size of the allocation shrunk, probably
> leading to the span of pages.

Okay, the page allocator _should_ be fine for that. In the mean time,
lkp should probably just disable PAGESPAN.

> > I *think* the allocation is happening in scsi_ioctl_reset()? But that's
> > a plain kmalloc(), so I'm not sure why PAGESPAN would have tripped...
> > are there other allocation paths?
> 
> scsi_ioctl_reset is the odd one out and does also allocate a request,
> but that request is never used for user copies (and that whole hacky
> side path needs to go away, there is a huge series that needs to be
> finished to sort this out).

Gotcha!

-- 
Kees Cook
