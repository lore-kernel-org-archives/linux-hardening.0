Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2361C48BCF
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Jun 2021 07:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949DC61361
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Jun 2021 07:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhFIHoS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:44:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:47161 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbhFIHoR (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Jun 2021 03:44:17 -0400
IronPort-SDR: Os6QBjD0gsTGlMzm7O+tsB49MVyIDCAOxIaKMkpVZHrcDJ2WWjHYkkWBWcVpECtcU0NEgpvsj0
 u3goiw0Vt/Ew==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204987427"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="204987427"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 00:42:23 -0700
IronPort-SDR: VCtr/1WZwBgJ3yMY+bSneUud0u19//M8V/8lcOnj18fKBnugu+vjpZ+XmGOt+Ez8j+PMrEV7qd
 FeIVpV/xmbbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="552589693"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105]) ([10.239.159.105])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2021 00:42:21 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] iommu/vt-d: Fix out-bounds-warning in
 intel_svm_page_response()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20210414201403.GA392764@embeddedor>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <928b163d-b754-4135-f3f3-5f08492f93eb@linux.intel.com>
Date:   Wed, 9 Jun 2021 15:41:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210414201403.GA392764@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 4/15/21 4:14 AM, Gustavo A. R. Silva wrote:
> Replace a couple of calls to memcpy() with simple assignments in order
> to fix the following out-of-bounds warning:
> 
> drivers/iommu/intel/svm.c:1198:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]
> 
> The problem is that the original code is trying to copy data into a
> couple of struct members adjacent to each other in a single call to
> memcpy(). This causes a legitimate compiler warning because memcpy()
> overruns the length of &desc.qw2 and &resp.qw2, respectively.
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link:https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva<gustavoars@kernel.org>

Queued for v5.14. Thanks!

Best regards,
baolu
