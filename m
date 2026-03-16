Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A43ED11E;
	Mon, 16 Mar 2026 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690178; cv=none; b=aEgKig2p1kXC9dgjbFX1OaaoY+yUIuHxq1Y7MJA+j0XmpToGCQu/5HNBPF57JWVhl98ApY9e8JE8ih5iRf1q8gAdyXMYeAaos1l/80hJM+5uzsUU5dZEajY0Jy5VCrmD+RUfj94EVJqQXxCww+r989sYej/SeqOJ0479YhrdCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690178; c=relaxed/simple;
	bh=U2KkEVVoR5XEO52nxBfzK+KP9ppHBKrzL0lErOkybc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxxICZuKbi5mtyAanfD3Kaf/DasKZbIMPNiz7XyzPg+mPaNn/ZUB4FPQMAgCxcp5dGZN+4gnSI3Xu63OZ636DMXDpvDybLT5yqUVwHffUmj/RtrDjG6683R/Od4h4uIUVUyqYnFnwQZCNK1o51EP6/vPhyi+16NUnxrbvbe57dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eC6gFrb1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC6gFrb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773690175; x=1805226175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U2KkEVVoR5XEO52nxBfzK+KP9ppHBKrzL0lErOkybc0=;
  b=eC6gFrb1UOCZVdsQJNurWODMca2pGNtLwOY9xdZsJLfGNqfqrsQNnxYf
   RlKW17X42lZLOjS3QNNj54v6fftLpgNKglicqPsFDeLcuIcJvqob/2nkU
   vDhJM/02YZ7pkM08xajnSrTBRBm/A588OloeW5/8n3K9JlgZbY8RLkAAp
   tAajVpGh5As3GzQ1oB3+BNqUNFWrqCLZRpkTdkJALcOEpgJeVV/UZoCZU
   0OwZVPVKOHUt4MQ+C3+DxF0LjS7rSbF1DuWQiRP7G6Ag50Mc/UlHBJ1Ve
   leaSEh6ioowggUuP+ZXGDWVyFIjkz0S//QrX5EQjk56msP5YQppXNXWZR
   w==;
X-CSE-ConnectionGUID: EiShLKYTRI6/+JiokuzVQw==
X-CSE-MsgGUID: kHLnwzBKRPKEqu9WEQhoyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="100173398"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="100173398"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:42:55 -0700
X-CSE-ConnectionGUID: 1G8N3fO3Q5Or1//k421l0g==
X-CSE-MsgGUID: tUaPr5ewTByJHtDubNiG9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222098474"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:42:52 -0700
Date: Mon, 16 Mar 2026 21:42:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Josh Law <objecting@objecting.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, kees@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <abhdOes2GSRZdWh3@ashevche-desk.local>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
 <4FC4DDD1-E170-46A9-888A-41D2CD6D97F3@objecting.org>
 <abhQURnuNUPwiy_6@ashevche-desk.local>
 <590CA4EE-3510-482D-B768-91B3CFC73164@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590CA4EE-3510-482D-B768-91B3CFC73164@objecting.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 06:49:23PM +0000, Josh Law wrote:
> On 16 March 2026 18:47:45 GMT, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >On Mon, Mar 16, 2026 at 06:43:58PM +0000, Josh Law wrote:
> >> On 16 March 2026 17:01:58 GMT, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> >strlcpy() and strlcat() are confusing APIs and the former one already gone
> >> >from the kernel. In preparation to kill strlcat() replace it with the better
> >> >alternative.
> >> 
> >> Is this patch in relation to my string.c patch?
> >
> >Yes.
> >
> >> You would have to do this for about 120~ files.
> >
> >Not me, just showing you what to do.
> >
> >Btw, what kind of assistance do you use for the patches?
> 
> None

Hmm... Many patches that are generated require quite a lot of time investment
and understanding the code. It's unbelievable that a person can do that without
an assistance.

> I use grep to find all the files calling the functions (took a while!)

No, that's not what I was asking about.

> And if I did those patches, I can't guarantee all of them will be ACKed.

Interesting way of saying the obvious. And if you didn't?..

-- 
With Best Regards,
Andy Shevchenko


