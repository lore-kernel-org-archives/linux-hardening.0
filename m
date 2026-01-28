Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91B32571D;
	Wed, 28 Jan 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590792; cv=none; b=u8IEodogUhlTaJLZgFzRd/f5MFSqjCKAKIiPrH17TeItCztkTL9hgquSuVs6lWgzRWR96DxhYDI88IbnC/Wf40HwJv7feERk2PaJlg+ClJ9gq8TUfAG6CiZ+FhEHw8uPSKH1kVT0xWksGFIpEUxXwUMaoe9qLUStejCgCoD1KCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590792; c=relaxed/simple;
	bh=aiOWRRjAx3Fe65K/nWnJxxRvs7BcjtXp2Asr0BTsf+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJg9R33haQTkckjDRMbzBrdoQ+zqIoAwS8Mm8ibRfuuMByINZILcR7y2FB3KR3EFsZNuWOnyP0Jv4UQUthOV7IwSB2WmHhArJVFJmlCAudSjXOMKmWuejKawSaGcpG1Bkibc2O+JZS6pAIU5uLj/eJgkkFqRXxO4iaQa/lnpzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uqi/Fz+k; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uqi/Fz+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769590790; x=1801126790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aiOWRRjAx3Fe65K/nWnJxxRvs7BcjtXp2Asr0BTsf+E=;
  b=Uqi/Fz+k6IXlbhe9/Ux6Yq67SvCDkJPfMQxlsQAJBP6j6Vq6D/8RIYIx
   /qmm51dNuCamWdFZygRNaiuy6HM3pZ0iWPSPlnRFHuzBr7v82z/ASPNQv
   Kv9rvBPYMxQnd9TiD6hVJnBhZ6sEG8Qotx67lvh3aBWxoCI/m1FTX1uP6
   BrZ52kBCPSkV8LGr7B6Nc7iTAmtSkhh9InOGgJAqPgzRP/Ln9I3crYCZZ
   togrZmTP6LzMOkJ7a5qu+KudE67C+L8BWrotE7qXS/X0q9hD0vPKjxf4Q
   yByfSOv7HuvZJA3PaWd5fgZkACVxqYUtcrnrm9o/mcAVP2JtScW43f0x9
   g==;
X-CSE-ConnectionGUID: abyjRQn2QxixZ7pALXy6bg==
X-CSE-MsgGUID: JWQooa8kTC+cHrFtBz+1Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="96259200"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="96259200"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 00:59:49 -0800
X-CSE-ConnectionGUID: mvNnzAdoRQWYNA+cb2eLzw==
X-CSE-MsgGUID: +dVQm/t5Sx2lyKn4ImKqGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208111010"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 00:59:45 -0800
Date: Wed, 28 Jan 2026 10:59:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, akpm@linux-foundation.org, kees@kernel.org,
	andy@kernel.org, ebiggers@kernel.org, martin.petersen@oracle.com,
	sohil.mehta@intel.com, charlie@rivosinc.com,
	conor.dooley@microchip.com, samuel.holland@sifive.com,
	linus.walleij@linaro.org, nathan@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 4/8] lib/string_kunit: add performance benchmark for
 strlen()
Message-ID: <aXnP_6wsyXcVGasN@smile.fi.intel.com>
References: <20260127012558.40025-1-jiangfeng@kylinos.cn>
 <20260127012558.40025-5-jiangfeng@kylinos.cn>
 <aXh93EVRSOrQQS6l@smile.fi.intel.com>
 <dcdb82e8-691a-4cc1-88d5-755039ed0313@kylinos.cn>
 <aXiKelsJF-SiqnVS@smile.fi.intel.com>
 <0d0f0528-738b-402c-a05c-53e21000dc67@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0f0528-738b-402c-a05c-53e21000dc67@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 09:44:40AM +0800, Feng Jiang wrote:
> On 2026/1/27 17:50, Andy Shevchenko wrote:
> > On Tue, Jan 27, 2026 at 05:33:10PM +0800, Feng Jiang wrote:
> >> On 2026/1/27 16:57, Andy Shevchenko wrote:
> >>> On Tue, Jan 27, 2026 at 09:25:54AM +0800, Feng Jiang wrote:

...

> >>>> +#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
> >>>> +do {									\
> >>>> +	size_t buf_size, _bn_i, _bn_iters, _bn_size = 0;		\
> >>>> +	u64 _bn_t, _bn_mbps = 0, _bn_lat = 0;				\
> >>>> +	char *buf_name, *_bn_buf;					\
> >>>> +									\
> >>>> +	_bn_buf = alloc_max_bench_buffer(test, bench_lens,		\
> >>>> +			ARRAY_SIZE(bench_lens), &_bn_size);		\
> >>>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, _bn_buf);			\
> >>>> +									\
> >>>> +	fill_random_string(_bn_buf, _bn_size);				\
> >>>> +									\
> >>>> +	for (_bn_i = 0; _bn_i < ARRAY_SIZE(bench_lens); _bn_i++) {	\
> >>>> +		buf_size = bench_lens[_bn_i];				\
> >>>> +		buf_name = _bn_buf + _bn_size - buf_size - 1;		\
> >>>> +		_bn_iters = STRING_BENCH_WORKLOAD / max(buf_size, 1U);	\
> >>>> +									\
> >>>> +		_bn_t = STRING_BENCH(_bn_iters, func, ##__VA_ARGS__);	\
> >>>
> >>>> +									\
> >>>
> >>> Remove unneeded blank line.
> >>
> >> Will fix.
> >>
> >>>> +		if (_bn_t > 0) {					\
> >>>> +			_bn_mbps = (u64)(buf_size) * _bn_iters		\
> >>>
> >>> Why buf_size in the parentheses here and not anywhere else (above)?
> >>
> >> It was a bit inconsistent. I'll remove the unneeded parentheses for buf_size.
> >>
> >>> I assume it's just an external temporary variable? But why do we need to have
> >>> it in the parameters to the macro?
> >>
> >> This is necessary because buf_size often needs to be passed as an argument
> >> to the function under test. For instance, when benchmarking strnlen, the
> >> caller must pass the current length as an argument:
> >> STRING_BENCH_BUF(test, buf, len, strnlen, buf, len);
> > 
> > Okay, and why is it needed in this macro? It get overridden immediately in
> > the loop. Assuming that the array size of bench lengths is not zero, this
> > has no visible use. Can you elaborate?
> 
> Thank you for the explanation. I see the source of the confusion now.
> 
> In v5, buf_name and buf_size were not intended to pass external variables into
> the macro. Instead, they were naming placeholders for local variables declared
> inside the macro's scope. This allows the caller to define the names used in
> the variadic arguments.
> 
> To resolve the logical inconsistency you pointed out, I'd like to propose two
> options for v6. Which one would you prefer?
> 
> Option 1: Internal Declaration (The "Self-Contained" approach)
> 
> We declare and initialize the variables directly inside the loop. This keeps
> the macro self-contained and the caller doesn't need to pre-declare anything.
> 
> for (_bn_i = 0; _bn_i < ARRAY_SIZE(bench_lens); _bn_i++) {
>     size_t buf_size = bench_lens[_bn_i];
>     char *buf_name = _bn_buf + _bn_size - buf_size - 1;
>     ...
> }
> 
> Usage:
>   STRING_BENCH_BUF(test, my_buf, my_len, strnlen, my_buf, my_len);

This option is better as long as the user doesn't need to know the (stale) data
out of these parameters. And I think this is the case, so #1 is the winner.

> Option 2: External Declaration (The list.h approach)
> 
> The macro expects the caller to provide pre-declared variables, similar to
> list_for_each_entry(). This removes all re-declarations inside the macro.
> 
> for (_bn_i = 0; _bn_i < ARRAY_SIZE(bench_lens); _bn_i++) {
>     buf_size = bench_lens[_bn_i];
>     buf_name = _bn_buf + _bn_size - buf_size - 1;
>     ...
> }
> 
> Usage:
>   size_t my_len;
>   char *my_buf;
>   STRING_BENCH_BUF(test, my_buf, my_len, strnlen, my_buf, my_len);
> 
> Please let me know which style fits the kernel's preference better, and
> I will implement it in v6 along with your other suggestions.
> 
> Thanks for the catch!
> 
> >>>> +					* (NSEC_PER_SEC / MEGA);	\
> >>>> Leave '*' on the previous line.
> >>
> >> Will fix.
> >>
> >>>> +			_bn_mbps = div64_u64(_bn_mbps, _bn_t);		\
> >>>> +			_bn_lat = div64_u64(_bn_t, _bn_iters);		\
> >>>> +		}							\
> >>>> +		kunit_info(test, "len=%zu: %llu MB/s (%llu ns/call)\n",	\
> >>>> +				buf_size, _bn_mbps, _bn_lat);		\
> >>>> +	}								\
> >>>> +} while (0)

-- 
With Best Regards,
Andy Shevchenko


