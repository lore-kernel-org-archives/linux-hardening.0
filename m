Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31DCC433ED
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Apr 2021 05:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99064613CC
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Apr 2021 05:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbhDNFeN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Apr 2021 01:34:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:56790 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347332AbhDNFeH (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Apr 2021 01:34:07 -0400
IronPort-SDR: kqdyFWxeZ4VGCArN9AlJG7ttxG5FUKSOXt0MXK6pHcEJIl1/tUTSGpLJ/QUudM9HscEpPnJdB9
 nlRaH6Rw5G+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="174066244"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="174066244"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 22:33:46 -0700
IronPort-SDR: 0SQIb/JLxSHbcLOZLryhl6PMjIY4xMOaZNxAyQASAFxpnHCbd/ZGhae5wowrVK9lPvm53ZUXfK
 V+TOJYQxRwcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="443689817"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2021 22:33:43 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommu/vt-d: Fix out-bounds-warning in
 intel_svm_page_response()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20210413195409.GA322376@embeddedor>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <61b37f83-eb9e-cf81-c5e6-ca322f76f490@linux.intel.com>
Date:   Wed, 14 Apr 2021 13:24:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413195409.GA322376@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Gustavo,

On 4/14/21 3:54 AM, Gustavo A. R. Silva wrote:
> Replace call to memcpy() with just a couple of simple assignments in
> order to fix the following out-of-bounds warning:
> 
> drivers/iommu/intel/svm.c:1198:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]
> 
> The problem is that the original code is trying to copy data into a
> couple of struct members adjacent to each other in a single call to
> memcpy(). This causes a legitimate compiler warning because memcpy()
> overruns the length of &desc.qw2.
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/iommu/intel/svm.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 5165cea90421..65909f504c50 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1194,9 +1194,10 @@ int intel_svm_page_response(struct device *dev,
>   		desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
>   		desc.qw2 = 0;
>   		desc.qw3 = 0;
> -		if (private_present)
> -			memcpy(&desc.qw2, prm->private_data,
> -			       sizeof(prm->private_data));

The same memcpy() is used in multiple places in this file. Did they
compile the same warnings? Or there are multiple patches to fix them
one by one?

Best regards,
baolu

> +		if (private_present) {
> +			desc.qw2 = prm->private_data[0];
> +			desc.qw3 = prm->private_data[1];
> +		}
>   
>   		qi_submit_sync(iommu, &desc, 1, 0);
>   	}
> 
