Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F460C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 07:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9CB60EDF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 07:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhJMHbS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhJMHbR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 03:31:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696D1C061570
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 00:29:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so3746877pjb.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 00:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NEgyZUFN9mCAx7pDvgyq+kMKO3cwGQI6y+zorr5H7P8=;
        b=h2OqTMnGa1Kw3MRnVD9CW+oJPtCyFTTqmQeiBp7VN5vIPHfPzvppsZj/rPNZxoEnqi
         jaGdWPTORcrMnR1PwMMiKRnW2yi6GvgLnp3/SHY5wIyxPpPPICXEjkQQ2vEi+M1eLWxM
         SM5lnpcEh71IWJ9cqLpoIR3mcUezXOQLuccMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEgyZUFN9mCAx7pDvgyq+kMKO3cwGQI6y+zorr5H7P8=;
        b=xC7tCpAeTmAC2NBVBTysXjOdcGBJE+tR58w3L9ZRdPhQbXgs1IUSSbDOlkfNbuKE/G
         M9zcHSfA2VayDUyUHoxB9BZCMC3M5HIad3yCLlxgJTlZaOKySPvIo4olVeNOCYa1Fy+o
         /zYw/rvLAT/xiJfySft9oHBNciEukCq9EQyp8IEdTYfxlHXxdsNsRFr9wSALyQPuHP43
         V63f31vVX3istaTr5Xsr48haTI4aX6oei4l11OVg6s3cAih7/RBk1IxOzkcLlP44pas5
         h3+4jyK0rMOEsB9P+8JjMI1EsRhdxKkiL+TdGLunWYGqZplZyiJXhBE6Hnzia5hqBkAU
         KI+Q==
X-Gm-Message-State: AOAM530j3ddQ0xXDuJosomWwQffTr7PdrOz3F6kqcWijfNekFFv+nfrU
        edI3cZEdFS7D+3FVcfCRIOodUg==
X-Google-Smtp-Source: ABdhPJx4VMQG7CaUzn9rFX6A7iMsnK+l8hYS5LxW6ErwsttKq8vu3mrouYZDtaw6jRBUCn8ue23ZcA==
X-Received: by 2002:a17:90b:368a:: with SMTP id mj10mr2456037pjb.201.1634110154002;
        Wed, 13 Oct 2021 00:29:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h24sm13393199pfn.180.2021.10.13.00.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 00:29:13 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:29:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Li Fei1 <fei1.li@intel.com>, gustavoars@kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: Prefer array_syze and struct_size over open
 coded arithmetic
Message-ID: <202110130028.11D761B3@keescook>
References: <20211011103902.15638-1-len.baker@gmx.com>
 <20211012013429.GA28284@louislifei-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012013429.GA28284@louislifei-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 12, 2021 at 09:34:29AM +0800, Li Fei1 wrote:
> On Mon, Oct 11, 2021 at 12:39:02PM +0200, Len Baker wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or similar)
> > function arguments due to the risk of them overflowing. This could lead
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> > 
> > So, use the array_size() helper to do the arithmetic instead of the
> > argument "count * size" in the vzalloc() function.
> > 
> > Also, take the opportunity to add a flexible array member of struct
> > vm_memory_region_op to the vm_memory_region_batch structure. And then,
> > change the code accordingly and use the struct_size() helper to do the
> > arithmetic instead of the argument "size + size * count" in the kzalloc
> > function.
> > 
> > This code was detected with the help of Coccinelle and audited and fixed
> > manually.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> > 
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> 
> Hi Baker
> 
> Thanks for helping us to fix this issue. This patch looks good to me.
> Please add Signed-off-by: Fei Li <fei1.li@intel.com>.
> Only two minor comments.

For v2, please fix the Subject typo, too. :) "syze" -> "size".

-Kees

-- 
Kees Cook
