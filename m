Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279DF1A08B1
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748869828; cv=none; b=kmL/v1+9iOSXNuXz6QbZpQ1QtOPFeLKUTNEXgFeijeVfVF5bc2WofL4NOqZYSAVIcZAulonUjStEF6hRw+nFaDbsuRWLRoSYZk97+BpjknbsTxL4TEtYB3U0agRp2dT8l5xKZgkYM+XTA+xlr0HPmHGC42z5cag5mUUbv1RbxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748869828; c=relaxed/simple;
	bh=JTf+/sW1h9AZeu+i9OMWXb/oYWCvRJVBIij7i3b+iRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uh+NvfjvUVSfJDawMXuwqgV88f8LZFxzZ9exuSgbjfTVOXm3f98z85149KS8LJAZ8I3FdFml6W8RNeULwQDWuQnDGp5Pe9zHHXtG/U7Sw5ZAI48S5IuITKdmp+p4m6EjeQt9Ye4iZtWbX6BS2dvVDYJ2/+oqntRvJHQusuFUw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SC5Gahko; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SC5Gahko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748869827; x=1780405827;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=JTf+/sW1h9AZeu+i9OMWXb/oYWCvRJVBIij7i3b+iRk=;
  b=SC5GahkogeWTyE0exmgK9fPyCiepqYnlONQIV79C6CS6gH9apLZBDRwB
   n7dFYoYtEhS0DeAku1sG2yB8yIi01QodXawrQEGMiTh/l27OgYFwE3we2
   KZ/kks6aUD8OGZoOhAGWy+b+X33/SQY1/v6rwck9q3eJIoLRNcNgOakn9
   85RJD8/AIPwfY6kCyYaO176sKsjUPz6RhjcO1C9SsGXMmxmcWayqSl66B
   1j07Jjs5Nve/55Ii76VuLfHVyEFYANUlpiRcil6TT2WsI9XdI9a9BGAhf
   /9Tdg08YNXDXON6DVPPEoN4UptIRUWEt13LQVH7e2DOlY3JoACLMPEGrY
   A==;
X-CSE-ConnectionGUID: NF+REifBRxCqnpkUr68CjA==
X-CSE-MsgGUID: fnSaMVbjS+Sb6wJfq/QRlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="61926876"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="61926876"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 06:10:27 -0700
X-CSE-ConnectionGUID: 6pSu9W09TIymrqWLNrNwlw==
X-CSE-MsgGUID: fPmvRllDRmeDuC+dNpLUdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="145478266"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.193])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 06:10:25 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: i915 utils: range_overflows*()
In-Reply-To: <202505301026.126AB6FFC@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cd0ea72c6cab6c478336cd1bb5b517a9fe7a150d@intel.com>
 <202505301026.126AB6FFC@keescook>
Date: Mon, 02 Jun 2025 16:10:21 +0300
Message-ID: <d127e624d6a851f488c60631a9bf84f6316748eb@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 30 May 2025, Kees Cook <kees@kernel.org> wrote:
> On Fri, May 30, 2025 at 10:44:31AM +0300, Jani Nikula wrote:
>> 
>> Hi Kees -
>> 
>> drivers/gpu/drm/i915/i915_utils.h has a handful of helper macros for
>> checking range overflows: range_overflows(), range_overflows_t(),
>> range_overflows_end(), and range_overflows_end_t().
>> 
>> Looks like the first one has also been copy-pasted to
>> include/drm/drm_buddy.h.
>> 
>> Feels like include/linux/overflow.h would be the right place for (some
>> version of) them.
>> 
>> Thoughts?
>
> Sure, yes! They need some documentation too. :) And probably some
> renaming. It looks like range_overflows() is not end-inclusive, but
> range_overflows_end() is? And the _t variants are forcing explicit
> types (like max_t, but unlike struct_size_t).

Ah, naming.

As we all know, NP in NP-complete actually stands for "naming
problem". It's hard to come up with a good name, but presented with one,
it's quick to verify it is indeed good.

Ideas for the hard part?


BR,
Jani.


-- 
Jani Nikula, Intel
