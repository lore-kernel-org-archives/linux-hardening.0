Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415937AA8A;
	Fri, 10 Jul 2026 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709902; cv=none; b=Aq5VE2aNvj39AzpyNo9qRlrqsp6vi+x4IkpnzQ0z31n0TNus2NBRf12q7G9Pm3IQRNbSwZbhaQFwy+8jnTSjpA+TtOEIy+HWvmsBN5TIhoiu8ATHHuhEKUEH9FNeBp/6xafITC0bnhIoyq6wl/bxQv/cDg81wnAU+AroLv2CTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709902; c=relaxed/simple;
	bh=DrPaq6heWDDdouFqQIykoOFCC9AQr7k0ptjRkxAthqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hB9swNf7Nn1TAZyyL2pjbVWw29/06RkeGt70bnlHgTEuOVNawPTA/qxlYqfY+Donih16e1zhmlmJCtKRKyeu7Gu1FrVsILElHkrT4yc2GNM9f2oc9lTZCosqIDhfOIJw2XdMNpQu1+TSpcKFOIy29jrjZy6OE9mb01SEir5PAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkZNOBfY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkZNOBfY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783709901; x=1815245901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DrPaq6heWDDdouFqQIykoOFCC9AQr7k0ptjRkxAthqQ=;
  b=GkZNOBfYuOHdvPd/WHXm/skwi6FXiZPVs8/05Ofim8U2hAQQiIqnU+LL
   ojp+NrexmnOYSBNJqjiH25jqV6eCF0/OsOfoz7UAquYHgMG9Jzljplkk7
   YcgdLhcyRCS5zQ+EGY50vQsIsklBIhRjXUr6x2mKMYe11VvBlW8+f+/C1
   rCnOiOmBANTHPSSWz9VHfJB5eCMHCZafNZZxQcPILhzPS0h4PVgQpCKRt
   CDvekY8a4qPOfhb3Ln7E5aFhGZa1ktYriBmDYAliFId/WIdRFIAp1BjGG
   DWYtMrH70zeOz0PP80F/oERkx5A5V9zDEEqdTSifoK1B5NwcYyc6AizzJ
   g==;
X-CSE-ConnectionGUID: uCn9SV6XT2yVuxJ6ZbweTQ==
X-CSE-MsgGUID: vsIpeAJURxGC7EVNjMLELg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84266993"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84266993"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 11:58:20 -0700
X-CSE-ConnectionGUID: VeQ15drLQUOMPQogtYS6tQ==
X-CSE-MsgGUID: YLvfyccNTkO1wszNS4m6OA==
X-ExtLoop1: 1
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.199]) ([10.125.111.199])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 11:58:19 -0700
Message-ID: <bfa239d3-2582-4669-8614-0a299491a744@intel.com>
Date: Fri, 10 Jul 2026 11:58:18 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Xiang Mei <xmei5@asu.edu>, Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-hardening@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
 Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
 Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
 Yan Shoshitaishvili <yans@asu.edu>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <20260701072747.GN48970@noisy.programming.kicks-ass.net>
 <20260701074834.GI49529@noisy.programming.kicks-ass.net>
 <8730D74D-6395-4FF4-B9F9-06AFABBF8CDE@zytor.com>
 <20260701083108.GD751831@noisy.programming.kicks-ass.net>
 <CAPpSM+SzqLSPt2q0KhkzB-WvphXGmby99QBJL7v_nq4kJGAYFA@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAPpSM+SzqLSPt2q0KhkzB-WvphXGmby99QBJL7v_nq4kJGAYFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/26 14:04, Xiang Mei wrote:
> Peter's explanation is correct: this technique makes CFH->ACE easier.
> 
> I think both ways can mitigate it, but I would like to hear your
> (maintainers') idea of which one we should proceed:
> 
> 1. supervisor-ENTER-#UD + Peter's objtool check. Cleanest for ENTER,
> but it needs a new bit from Intel/AMD, so future CPUs only.
> 2. Kill the landing zone with a 0x11-page guard area.

Or:

3. Do nothing. Normal kernel IBT is good enough.

The hardest part of #1 IMNHO is convincing people that we need "a new
bit" *PLUS* the two CET technologies (indirect branch tracking and
shadow stacks). If I were a hardware guy, I'd be complaining that those
silly kernel developers aren't even doing supervisor shadow stacks, so
maybe they should use what they have before we starting building new things.

Also, I kinda gave you a route forward. I think someone can both make
the vmalloc gaps more flexible, less hacky, simpler and cleaner. Then,
once that has been done, it's dirt simple for any individual vmalloc
user to have a custom-sized gap. Or, to have a universal, larger,
tunable vmalloc gap.

Get that series put together and I'm open to an 0x11-page gap that x86
pokes in to place in some way.
