Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3882E3E5A22;
	Mon, 19 Oct 2026 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409041; cv=none; b=beTEwYt8hfJzDNrlFXkJuOY/lDdbqCoH6m6giVAAPRVMFu4Sq0i7gVbaw9KHQh/dUR2b95kUc2sJFl5TL24JkLpcpZUHTdc8foEfiurX41WvQO1dIUJFsiW5OyIAZddrgNiwnsO0vhrOtKH+29E+tZ68ggW4GisT12veHFH3bGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409041; c=relaxed/simple;
	bh=oGGNRYMcY2DU6vzIxqF7oDJexAV17frJVeekFT1y57g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC8znAFUDjPsF+GzgSOyYxDyGzH685Luk+XThIRIlzmqcZTOpSoQw6mc91lvphWNllEvIERZVPG721jI56edeo1rDTqkjcynNQejnul+xB+yI3u8hcX01JNewClC1R1EHxtIKY/boNylvmY1d2KSPV+SQ61uOdjRtNy2mCgTUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nL8oTOtb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nL8oTOtb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792409040; x=1823945040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oGGNRYMcY2DU6vzIxqF7oDJexAV17frJVeekFT1y57g=;
  b=nL8oTOtb2i6D0EqqCfEdCXPRPhTbWcTtJyggdY5vnmv4wkpR8WOpgESw
   ROafViLTWeG5yQPLKRlSHMCYogUoLsOJwOKO2HmjUopTdlYicdgW+iOfU
   D0/SfazJKBK2mlgmlX3L/0SXDgcRid8vHhn/RLCEgZ5X3YB2I3uKkj8Qi
   67btlxyzX8lq08cRrcmQvqIjQ/L1467urm+6qIbqgmfJyinzO5SYv56ir
   Uq7fK/0qr7wPyYMt0VG6B/d8nE37E41KSgS3iHRZmDaHtw15CzmFBCi8u
   BHY8AJvZKq9a1H0IaPofUlwg/4TKjkRQZpaozBinhXVueUqfgbLiUzHhn
   w==;
X-CSE-ConnectionGUID: mCvt9qCcQSWHXMmgxuZnrw==
X-CSE-MsgGUID: K2IySpwDTQa/jUdFy1AavA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="970544"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="970544"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:23:59 -0700
X-CSE-ConnectionGUID: 0zn0HK7LQU2r280pllELIQ==
X-CSE-MsgGUID: 7pyJheCsTBusY3a1AWLe/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2982430"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:23:55 -0700
Date: Mon, 19 Oct 2026 14:23:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Collingbourne <peter@pcc.me.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v2] string: copy byte by byte in sized_strscpy() under
 KASAN
Message-ID: <atX9yfR7XwaIo457@ashevche-desk.local>
References: <20261019-bug-string-strscpy-kasan-first-byte-v2-1-c93073250e6b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-bug-string-strscpy-kasan-first-byte-v2-1-c93073250e6b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 09:59:01AM +0800, Qiliang Yuan wrote:
> sized_strscpy() copies a word at a time. The loads go through
> read_word_at_a_time(), which checks the first byte of each word with
> KASAN, or through load_unaligned_zeropad() on architectures with
> CONFIG_DCACHE_WORD_ACCESS. Under KMSAN it copies byte by byte instead.
> 
> load_unaligned_zeropad() is inline assembly that the compiler does not
> instrument. Since sized_strscpy() switched to it, generic and software
> tag-based KASAN no longer report strscpy() reading from a freed or
> out-of-bounds source on x86_64, arm64 and the other architectures that
> select CONFIG_DCACHE_WORD_ACCESS. On x86_64 the kasan_strings KUnit
> case, which expects a report when the first source byte is out of
> bounds, fails as a result:
> 
>   KASAN and string KUnit suites      failures
>   on x86_64, generic KASAN        before    after
>   CONFIG_FORTIFY_SOURCE=n              1        0
>   CONFIG_FORTIFY_SOURCE=y              1        0
> 
> Copy byte by byte under generic and software tag-based KASAN too, as
> under KMSAN, so that every byte strscpy() reads is checked. Hardware
> tag-based KASAN keeps the word loop that load_unaligned_zeropad() was
> brought in for.

...

> -	if (IS_ENABLED(CONFIG_KMSAN))
> +	if (IS_ENABLED(CONFIG_KMSAN) || IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> +	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>  		max = 0;

Logically better to have them grouped by SANitizer:

	if (IS_ENABLED(CONFIG_KASAN_GENERIC) || IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
	    IS_ENABLED(CONFIG_KMSAN)) 

-- 
With Best Regards,
Andy Shevchenko


