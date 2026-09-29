Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF038DC4C;
	Tue, 29 Sep 2026 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671013; cv=none; b=nbkm7Dzc02T/dNUlnQlk78nrhttIYOnIvl4V8XTPIBeEodYoxYRArKq1NOPPqUQ5NFxJNWiKtKS0xMs62eM6MyrXTnEQ8dgbZVOfGSvcNDKwYYNr9+zxr2tH/YnYNXVkk9CcxzrEBISExzwawdm1Tsf5aQ5pBKLtgEmRgm9cYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671013; c=relaxed/simple;
	bh=HVhNFOUDFzx6KORBrOqHtSbqOl75R/ekFiH3auXgFs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OujgCdmT764dL9gtnCTRh3n/cjuBLcFyAB1Ik74iSgMFo1DHg/nqeJ0Svmev95Pt380QxcV5ZpwZLfd6ZwEAKTmPl9RBbSOZvAvebm1tTiGRxyGczr74TYERJobnieNGMDkagXgXIwikhrBZYmchJ5nVnL119srOBMxhLnA1vQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CW6SrSa9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CW6SrSa9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790671011; x=1822207011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HVhNFOUDFzx6KORBrOqHtSbqOl75R/ekFiH3auXgFs8=;
  b=CW6SrSa9sEdIV2pUmsCBb5e+hK8yqRIGNpglFAUEuViZV5S4Sa5MMwfF
   Bg1KTg0qL5RIQKdy5tU7O08ObNGnyHOzxztcTY7BycvfJPpVUg6+q/S4t
   Pi7w5xcltPh93FH1zzxnypeHLHrQ/M4VbYxHzjLY6SXUwnaoAoxLLayx9
   3O5x2pq6KJNpAkK0OlebnBUwj/U7WYOjUhFlSkGzbRjs3UspqOxaAmSpf
   Gnx7iUN3tUOe3JzuxQcW/5nZcVusjKfhO6UeBHSq8yFDpQjIx6mtWMqBO
   r9ltuOSO1IxW+iMZ9g1DO3oDzd9p99+tsYUzELi2uC1fDSb2wJtihUQ6H
   A==;
X-CSE-ConnectionGUID: VBDHf/YOQAuipElyi2cnkA==
X-CSE-MsgGUID: GSJUojgwQhew2jwd7xxk4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90335275"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90335275"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 01:36:51 -0700
X-CSE-ConnectionGUID: +a09hawJT+icnamkAb0PDg==
X-CSE-MsgGUID: btG2jMWQRJW4i44DMIDwUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274413857"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO [10.245.244.252]) ([10.245.244.252])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 01:36:49 -0700
Message-ID: <8093ecff-842a-4063-bb29-4eb4903f7f73@intel.com>
Date: Tue, 29 Sep 2026 09:36:47 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu/buddy: add __counted_by_ptr attribute to roots
To: Bill Wendling <morbo@google.com>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
References: <20260925204423.80661-1-morbo@google.com>
 <605221ed-a1b5-4179-be8d-b206c79487d7@intel.com>
 <CAGG=3QWoa0sK1P2VEAW+76EkFsjzXEZ9ucJg4iiOv29i8Sgzxw@mail.gmail.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <CAGG=3QWoa0sK1P2VEAW+76EkFsjzXEZ9ucJg4iiOv29i8Sgzxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/09/2026 19:44, Bill Wendling wrote:
> On Mon, Sep 28, 2026 at 5:20 AM Matthew Auld <matthew.auld@intel.com> wrote:
>>
>> On 25/09/2026 21:44, Bill Wendling wrote:
>>> In 'struct gpu_buddy', the 'roots' field points to an array of pointers
>>> to 'struct gpu_buddy_block'. The number of allocated roots is tracked
>>> by the 'n_roots' field.
>>>
>>> Annotate the 'roots' pointer with the '__counted_by_ptr' attribute
>>> referencing 'n_roots' to enable compile-time and runtime bounds-checking
>>> via KASAN and '__builtin_dynamic_object_size'.
>>>
>>> In 'gpu_buddy_init', 'mm->n_roots' is initialized first, and 'mm->roots' is
>>> subsequently allocated with 'kmalloc_objs(struct gpu_buddy_block *,
>>> mm->n_roots)'.
>>>
>>> Since the bounds associated with 'roots' ('n_roots') are fully set prior
>>> to any array allocation or access and remain invariant, this annotation
>>> will not cause runtime panics or false-positive bounds checks.
>>>
>>> Cc: codemender-patching+linux@google.com
>>> Assisted-by: LLM
>>> Signed-off-by: Bill Wendling <morbo@google.com>
>>
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>
>> Would it make sense to also do this for *_scoreboard and free_tree, if
>> we add a new field n_orders?
>>
> Sure! There's already a 'max_order'. I assume that 'n_orders' would be
> more dynamic?

Yeah, I think just mm.n_orders = max_order + 1. I assume the 
__counted_by_ptr() only works with a field?

> 
> -bw
> 
>>> ---
>>>    include/linux/gpu_buddy.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>>> index 2c36124bb696..d7249e500ab6 100644
>>> --- a/include/linux/gpu_buddy.h
>>> +++ b/include/linux/gpu_buddy.h
>>> @@ -172,7 +172,7 @@ struct gpu_buddy {
>>>         * a power of two, with each root being the largest power-of-two
>>>         * that fits in the remaining space.
>>>         */
>>> -     struct gpu_buddy_block **roots;
>>> +     struct gpu_buddy_block **roots __counted_by_ptr(n_roots);
>>>        /*
>>>         * Per-order free block scoreboard: free_scoreboard[order] holds the
>>>         * number of blocks of that order currently in the free state.
>>

