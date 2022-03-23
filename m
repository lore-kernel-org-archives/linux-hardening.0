Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A940C4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Mar 2022 15:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiCWPmC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Mar 2022 11:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiCWPmC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Mar 2022 11:42:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F083B575
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 08:40:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id o23so1403740pgk.13
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZzHA745yMNG0CGi0w7nKGLCvOOf60jkvqsbdnRb89M=;
        b=iNLTx1MkU692XhbU/pjEg6oXIWD15fomaPRZ4oW3JJzH3KzlvOHBxqYr3RP16I8BsM
         PQB/aJJCoSn3Bf5C0iUtZUgR/DiaO2QauRmpfS9c/26CRq2dWzEV6G+MzRR7m7sDBrA9
         9I1dVEv+ES/8kqvSV10MRviLD3mH5S69ZCr5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZzHA745yMNG0CGi0w7nKGLCvOOf60jkvqsbdnRb89M=;
        b=K6gvffU5W4oEw6lpijIYf9tEYRyGsl7dlAma/ePGqxvkca02iqmFJudON0r/p7H//7
         CUqlnIp+JelZ6LpWwPd+MA8WZcf/PUb4M4iRj7qmEsLArw4gJM20NVSz3Blt0wa0PbnN
         HH4TX/ZElqa3F7KT1uHsm44MqArfBdcfN2vDL/VW0xKpAFpD8fKeJuLNZMK8EP1cgGtd
         3Vcm8evPHrqvRcfjHWPADjmp8ev4XDESJnwED9sx7ogQIXu4b9Tn/Z82JKgvZtP1+Kia
         vfbyiR0OarICkBnID2fsxEK9Mouvj9JVdhWV7BzvEfXmB0oVZy6pLuSH7I7H5HBON+Iq
         tZrw==
X-Gm-Message-State: AOAM530D60oLYFB0ssljjdsULo/GlJ7rvfjy1Tk58LI9OwV/Ux3z14TE
        qjLNkjMOLGQ0aTJZTaOLM8hYuQ==
X-Google-Smtp-Source: ABdhPJw3iGwMMA64SlcWNC/iNJPMHMmKHCz1X+Poh60YG/Rm403iC+8KBQtxt/XL7udZyTinHEg8vw==
X-Received: by 2002:aa7:91d5:0:b0:4fa:6d3c:55d9 with SMTP id z21-20020aa791d5000000b004fa6d3c55d9mr544396pfa.41.1648050031778;
        Wed, 23 Mar 2022 08:40:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2-20020a620502000000b004f6d2975cbesm304447pff.116.2022.03.23.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:40:31 -0700 (PDT)
Date:   Wed, 23 Mar 2022 08:40:30 -0700
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
Message-ID: <202203230809.D63BF9511@keescook>
References: <20220320143453.GD6208@xsang-OptiPlex-9020>
 <20220323071409.GA25480@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323071409.GA25480@lst.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 23, 2022 at 08:14:10AM +0100, Christoph Hellwig wrote:
> The actual warning is;
> 
> [   34.496096][  T331] usercopy: Kernel memory overwrite attempt detected to spans multiple pages (off set 0, size 6)!
> 
> This is for the cmnd field in struct scsi_cmnd, which is allocated by
> the block layer as part of the request allocator.  So with a specific
> packing it can legitimately span pages.
> 
> Kees: how can we annotate that this is ok?

The main problem is that CONFIG_HARDENED_USERCOPY_PAGESPAN=y is broken
(and nothing should be setting it).

This series removes it:
https://lore.kernel.org/linux-hardening/20220110231530.665970-1-willy@infradead.org/

Matthew, what's the status of that series? Will it make the current
merge window?

As for the SCSI changes, I'm a bit worried about type confusion, as I
don't see anything actually validating types/sizes when converting:

static inline void *blk_mq_rq_to_pdu(struct request *rq)
{
        return rq + 1;
}

But I guess that ship has sailed. :P

Regardless, I'm concerned that disabling PAGESPAN will just uncover
further checks, though. Where is allocation happening? The check is here:

static int scsi_fill_sghdr_rq(struct scsi_device *sdev, struct request *rq,
                struct sg_io_hdr *hdr, fmode_t mode)
{
        struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);

        if (hdr->cmd_len < 6)
                return -EMSGSIZE;
        if (copy_from_user(scmd->cmnd, hdr->cmdp, hdr->cmd_len))
                return -EFAULT;
	...
}

I don't see any earlier marking for this copy_from_user(), so I assume
the old allocation was a plain kmalloc().

For comparision, a related marking can be seen for a copy_to_user() case
in commit 0afe76e88c57 ("scsi: Define usercopy region in scsi_sense_cache
slab cache")

I *think* the allocation is happening in scsi_ioctl_reset()? But that's
a plain kmalloc(), so I'm not sure why PAGESPAN would have tripped...
are there other allocation paths?

-- 
Kees Cook
