Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0E9C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 17:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFAA61205
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 17:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhJURxD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:53:03 -0400
Received: from foss.arm.com ([217.140.110.172]:45716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhJURxB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 13:53:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E3B2D6E;
        Thu, 21 Oct 2021 10:50:45 -0700 (PDT)
Received: from [10.57.27.231] (unknown [10.57.27.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F713F70D;
        Thu, 21 Oct 2021 10:50:44 -0700 (PDT)
Subject: Re: [PATCH][next] iommu/dma: Use kvcalloc() instead of kvzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210928222229.GA280355@embeddedor>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <15e7ed54-2a4d-3e96-7181-d15b65ff5138@arm.com>
Date:   Thu, 21 Oct 2021 18:50:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928222229.GA280355@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2021-09-28 23:22, Gustavo A. R. Silva wrote:
> Use 2-factor argument form kvcalloc() instead of kvzalloc().

If we have a thing for that now, then sure, why not. FWIW this can't 
ever overflow due to where "count" comes from, but it has no reason to 
be special.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/iommu/dma-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 896bea04c347..18c6edbe5fbf 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -616,7 +616,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   	if (!order_mask)
>   		return NULL;
>   
> -	pages = kvzalloc(count * sizeof(*pages), GFP_KERNEL);
> +	pages = kvcalloc(count, sizeof(*pages), GFP_KERNEL);
>   	if (!pages)
>   		return NULL;
>   
> 
