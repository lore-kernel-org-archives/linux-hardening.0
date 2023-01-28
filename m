Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79BBC38142
	for <linux-hardening@archiver.kernel.org>; Sat, 28 Jan 2023 00:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjA1Arj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjA1Ari (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 19:47:38 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E27D2AC
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 16:47:37 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id m26so5558500qtp.9
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hC8vO32YUuQQBDUUZtcngmVtbpaT0Jq1aBzvbrp9Yp4=;
        b=NfU4J/gQoigubTQ+wI8tbZjlh1VQ6Sh8pVgcNDND8azysAP3ohXu76hvEuMeua8cPT
         +5skO7lpbqKQoPaNgf/d/koiIk3yzRO/sIHL4Oux6vJw/LSpiPvA9+9Fmmo9bDF7gU/S
         Z6nFB+d7YfMbDtSu1UiBnLFdNeF9eV74VK7luz8sM7s6kFR3bjucW2hwUwPNSrlKGcAY
         GbnGO2rSp7JioimHkLZIry/2g8E+uNcAYE9iX3ZBpbpF+0ZxV2NVDtUC/LTMC2/3NtEX
         06gi8pyEUdFS7xqGuqBovSwxQDdnHpZ/M2WPAktJdsE/b+7PUpI2JrMZvznL8SIgdwyM
         vvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC8vO32YUuQQBDUUZtcngmVtbpaT0Jq1aBzvbrp9Yp4=;
        b=61wjRO59CZvshMkOIxybZkaE9WDxMTPVoVXC/sLznZKBDKv+MtCE9+kvDMKw0doyzH
         /UI67bNvDxFZB2Ejjvqz+61LXrVIDXL909zHnpS2+VeuxVLitpHTX7mvswHyQu7i6laj
         Ik0m9kuxbcDk3yV3YzUmLyw/g0+LtZjJ90pCsmuKaBy40hrqog1JsNvPlOjE8NvvcKEc
         fXrrd1ZS4vZE/RroWJ3RwiQ/J5gG25k0ir5iKXr/00ifYLvhWAzQaDw1ns3RjsIVDAUP
         INcHpn/clFtd8gj5CNRkJJczLGQLQbsbV1GVZNp5nBU2QZ7OGr/41/dkswZuECmEF5PI
         Pqkg==
X-Gm-Message-State: AFqh2koF+fcgasLRCOerZGglMvJDZOAIGSEwbxhdO1BSt4OB7eJ07l7P
        ko+V+xAAN+xEZUyI9ep8TayCwg==
X-Google-Smtp-Source: AMrXdXsUvUmJhsOS2hBs3r3WYshjPAj7VpqIhNt/slphm3NSivGdXET/Mduy+M/QnEHVnaDE6g/nsw==
X-Received: by 2002:a05:622a:1e1b:b0:3b5:87db:f950 with SMTP id br27-20020a05622a1e1b00b003b587dbf950mr57889488qtb.27.1674866856248;
        Fri, 27 Jan 2023 16:47:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id d10-20020ac800ca000000b003b0b903720esm3677194qtg.13.2023.01.27.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:47:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pLZNW-000SMV-II;
        Fri, 27 Jan 2023 20:47:34 -0400
Date:   Fri, 27 Jan 2023 20:47:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd: Add top-level bounds check on kernel buffer size
Message-ID: <Y9RwpuVyEi2SBmdQ@ziepe.ca>
References: <20230127223816.never.413-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127223816.never.413-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 27, 2023 at 02:38:17PM -0800, Kees Cook wrote:
> While the op->size assignments are already bounds-checked at static
> initializer time, these limits aren't aggregated and tracked when doing
> later variable range checking under -Warray-bounds. Help the compiler
> see that we know what we're talking about, and we'll never ask to
> write more that sizeof(ucmd.cmd) bytes during the memset() inside
> copy_struct_from_user(). Seen under GCC 13:
> 
> In function 'copy_struct_from_user',
>     inlined from 'iommufd_fops_ioctl' at ../drivers/iommu/iommufd/main.c:333:8:
> ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
>    59 | #define __underlying_memset     __builtin_memset

This seems strange to me

I thought the way gcc handled this was if it knew the value must be in
a certain range then it would check it

If it couldn't figure out any ranges it would not make a warning.

So why did it decide "rest" was in that really weird range?

Is this just a compiler bug?

Jason
