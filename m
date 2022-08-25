Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82369ECAA24
	for <linux-hardening@archiver.kernel.org>; Thu, 25 Aug 2022 17:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbiHYRiZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 25 Aug 2022 13:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiHYRiY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 25 Aug 2022 13:38:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E793B72B8;
        Thu, 25 Aug 2022 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661449104; x=1692985104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g6KsGrStsJVpSFj8M7Ynb9ZS9B+NvB357U1duZgQ3Yk=;
  b=Bpup1uJ+VV3ULUuT4BGAEZX3rwIdoN/yBQOECQSh5jdGPyZBLddxC2f3
   ZxvK4yOR9cwmigBaTDCraHdag775cVHLHldKbBrhRXMJ0n4hg6j9Y0Veh
   IArtjgEUCXKC74lBxeKh+959JDigg6KzRHwj4esyvAp5xj8gHuLgbhFhB
   b1A6GiUorH6vOn6femfkYYbVdJzXmw6aaER5WU/2W5ehM1FDDbJ4lhvcX
   M62MaJKzTogVmcif/hNXS4ByFu6vlknHuCUgNna4ZkrH2968UVRkHPH5H
   5Bg+V2XnoiphhGVmiZuw2SzBgc34vAT6WII9T3umU/K0xI6+tn3r4ALbj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="291890593"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="291890593"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 10:38:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="752575124"
Received: from manjeets-mobl.amr.corp.intel.com (HELO [10.212.220.1]) ([10.212.220.1])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 10:38:23 -0700
Message-ID: <2f862d0f-e851-0de3-a789-991448ed8b68@intel.com>
Date:   Thu, 25 Aug 2022 10:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/mm: Refuse W^X violations
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
References: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
 <Yweu1dvkJ8aV+C+T@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yweu1dvkJ8aV+C+T@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 8/25/22 10:18, Sean Christopherson wrote:
>> +/*
>> + * Validate and enforce strict W^X semantics.
>> + */
>> +static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
>> +				  unsigned long pfn, unsigned long npg)
>> +{
>> +	unsigned long end;
>> +
> I think this needs
> 
> 	if (!(__supported_pte_mask & _PAGE_NX))
> 		return new;
> 
> to play nice with non-PAE 32-bit kernels.

Good catch.  Nit: I'd probably write this up as:
	
	if (!cpu_feature_enabled(X86_FEATURE_NX))
		return new;

That gets us our fancy static branches and is a bit easier on the eyes.
 I checked and don't see a way for __supported_pte_mask to have _PAGE_NX
clear when X86_FEATURE_NX==1.
