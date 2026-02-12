Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104A11CAF;
	Thu, 12 Feb 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903725; cv=none; b=U3ts/xUIhiY98S50cd8qmjO3v5IMJDPE3WgEQ4CZb9rxJt3XRLckYZ16NhEUgPALE1+oNHrBJUXzspayZIo6xb1Aqqw4BgVmPEWw90Nlsn5g4P/fOjoNU4VH+X8bCj1ED19Qgi370AoUI102wdKqsBzZqnvWG5YsSJc/q6hH7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903725; c=relaxed/simple;
	bh=i+gthsIlXrjZlaf7zd5WghoRV8wFB0MDl4nHQiklEgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnV2GzPxE704xjONx5lkshYE+lsY4Ad3FYmpWkAyg9w6zi8Lr6Aaz3Uo8aCOMoo1Va0WF/PbuR7s+02iIulfvCrfrOf+Si7jaaVdb5SOb6PfdLmw9sjYLeVse6cYN/UgcE2gQx2aG36PAapEf+FCfLu+2eC5p/IcsbLc8rIUPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akl86D3r; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akl86D3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770903724; x=1802439724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+gthsIlXrjZlaf7zd5WghoRV8wFB0MDl4nHQiklEgg=;
  b=akl86D3ri/SXGpa/+FJ/lJ1nB2rZXju39+BQPDty4GWd5Xbs5m8JVcXq
   QcDVUrXJxllZB7dkUs0vyW0amDsTBB566+mUHcxw5N6SLmSXzBZeNXwB6
   c7D3kpM2acuiJFNRvzGsiVzmJ/TGiVzy/zXIaqso9LW6EL6jIuDmzsxHM
   U1PYHaUMrtLHPfG2xVxeR43gzdSNe0gqxTH/k5Ug6UVMnZO0Lfnd1YH57
   mNal0WJBuBzQM6Sme/aMWC1c/z3cLtqTZoPwz8isq3k6uE/ateqYnpKua
   gTR/ssaXIadZ+FUOzCUdRSiq/vTpLNqvD7uZTg1VP3O+9X9bc9ObzdoHR
   A==;
X-CSE-ConnectionGUID: IGfhuFG+RXK99ae7pa1fNg==
X-CSE-MsgGUID: tIW0x3rgTNaZEaRQRoo8Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75916937"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="75916937"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:42:03 -0800
X-CSE-ConnectionGUID: idgGjPzgRDqufBpZQlRm+g==
X-CSE-MsgGUID: HCo1KF3PSraEEnoI3Bj54A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="217560860"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:42:01 -0800
Date: Thu, 12 Feb 2026 15:41:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aY3Yp89R1cl-sacD@smile.fi.intel.com>
References: <20260212125628.739276-1-dmantipov@yandex.ru>
 <20260212125628.739276-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212125628.739276-2-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 03:56:24PM +0300, Dmitry Antipov wrote:
> In '_parse_integer_limit()', adjust native integer arithmetic
> with near-to-overflow branch where 'check_mul_overflow()' and
> 'check_add_overflow()' are used to check whether an intermediate
> result goes out of range, and denote such a case with ULLONG_MAX,
> thus making the function more similar to standard C library's
> 'strtoull()'. Adjust comment to kernel-doc style as well.

...

> +	for (rv = 0; max_chars--; rv++, s++) {

Hmm... is max_chars being used inside for-loop body? I would rather use regular
pattern here:

	for (rv = 0; rv < max_chars; rv++, s++) {

(just check that any integer / sign promotion doesn't change the logic).

-- 
With Best Regards,
Andy Shevchenko


