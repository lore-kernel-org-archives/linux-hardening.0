Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517B326D44;
	Fri,  6 Feb 2026 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363765; cv=none; b=iTHcRxERYu6zPJai/TqgzlgNhrqNGQVbWuV1w5gJbnhtW6HtEztLvTPvyiMZbv/xN1dcGj67uoBiIPZJf2qAp5Ts428BO8TOHAFPAe8lQljaIKhDDfRlGznvwipOpZdnmhzNSQn4zYAKAOQbJZOQ2YOhj8P08f6FMaYgkluy150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363765; c=relaxed/simple;
	bh=yQpLpr/pTmhYbgor2+C/QaDX9amVdrYJgPNR6BbeNdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlysaT3RN9s4BFw8HPY/1KGYmW0dTXcMyT3uGHaGaEHx4G9BYZ1CJyv9yp8zJBqiM95/oB0ubX4dYB2CCVnM3ZCyP383S+5aCeI4iqOA9PU9O8mg4bbiFWoiK6QFwJNUaY1eq1R4cueY5P4S8iznp5FdFnApZFIwbs0cWMUAjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9ivaJRf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9ivaJRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770363765; x=1801899765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yQpLpr/pTmhYbgor2+C/QaDX9amVdrYJgPNR6BbeNdQ=;
  b=X9ivaJRf51V41wI2sjyypSnP8MpHx8EcYcqXGtCQfvtUy4q5jOdOMCyc
   IWEaDUqivi28sI951Ty4vBiCbyXsaggv3JITLJiHuq8BchL8Gl4WHQHnU
   8MFVH5KzR0C8SudGc50ircNyc1tDdnICKxrZsj3m4HYuzdRt1UmftOMpR
   x/pyJeQyezpMhko4jRt4n63LDO89IlcknILhTNuKHI5YxaUuBer7ZsXdz
   1uVuf2X1hwYHIkTvp3vN03Gk2lSkMN8T8xl/Hw8a8U7m6P6v5Co3peOF0
   dAbeFXsI/8ODvNm6uXnYr1el3PmwK+8r7tNzrcij1dfsLQwr8+tAfydA4
   Q==;
X-CSE-ConnectionGUID: v6+Yf83tSeO/XHxSdn4hHA==
X-CSE-MsgGUID: OkcibGuXTgeDdU3/EoabYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71469377"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71469377"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 23:42:45 -0800
X-CSE-ConnectionGUID: rXaBUu6dSDOXI3Pfa0Yv2w==
X-CSE-MsgGUID: cFDMB+xaRD+Whvxehtpu+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210080717"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 23:42:43 -0800
Date: Fri, 6 Feb 2026 09:42:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aYWbcFb73qO16tEC@smile.fi.intel.com>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
 <20260204135717.941256-2-dmantipov@yandex.ru>
 <20260205221537.34778ff0@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205221537.34778ff0@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 10:15:37PM +0000, David Laight wrote:
> On Wed,  4 Feb 2026 16:57:13 +0300
> Dmitry Antipov <dmantipov@yandex.ru> wrote:

...

> Although I wonder whether strtoul() (etc) should stop 'eating' input
> when the value would overflow

Definitely no stop condition. The idea behind simple_strto*() in the kernel
is that they will help to parse combined strings (several fields in one
*constant* string), not eating the extra "valid" characters (digits) will
be a disaster in a couple of aspects.

> and return a pointer to the digit that caused the error.

No.

> Code looking at the terminating character wont be expecting a digit
> and will treat it as a syntax error - which is what you are trying to do.
> 
> That is a much easier API to use, and a 'drop-in' for existing code.

Maybe, but problematic from the usage point of view as I described above.

-- 
With Best Regards,
Andy Shevchenko


