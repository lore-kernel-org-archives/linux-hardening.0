Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DA184
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184403; cv=none; b=XF2+c2bdtVApR0tW2zgsCgB/et+NcEN2BRNy1/FrdU+c687sMOGVHIIxglwGpdJunHMinMlbC9Hs0wg9Q9x47C+wMgq105LSUhWyarNcJ3bYo+ZkirTF8Lcw4HB0liFB+aZxqK3QCBLP0TRQDi8nStSxMJGVWc56vfuCJM5NTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184403; c=relaxed/simple;
	bh=LafYIgr3Pd95plA5/uU91vQoRZk5zYssPPMKLkHFrwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rfa+ty0p3XBTuDyS9Zg61eNcPD7xlh1qs0HUtNrKBNaJYg5hSumsGqOMkVmFwfPfuf5dxuj4VrGFdSLfW24k+T/8yMK0lJfAr4/U7LE29Qe+DlctcYQjV/BZfz+JEiaT4Mdd+cIvpjWoVA4jrRbcJmu/Vzs31IOzEhOA+PVXsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1y+xGbS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1y+xGbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769184402; x=1800720402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LafYIgr3Pd95plA5/uU91vQoRZk5zYssPPMKLkHFrwU=;
  b=J1y+xGbSeEVmmj1DalgW+UVdcBqKWAxhF90VTGNb2TZ10UNU+3OPXafK
   gu8BpingVzfFJefIgGZPNJ1CSA2/zKiLtOx5b3yIArMUQR0KYGHA1Ku5+
   Ojdw+81UfR0kmBtY6zRruSpnnhG51UwK4Y9BTsPmQ0+AigA/gp73SnWzb
   g/PBuC4t71V5Vo6DkxM//lKCXqirZguHs+vRU6BgRK4bcuLClDhynTf0k
   kXlsDmS449gtQ5vZR75hY0nrB3pQfefzqWBlz/1QQsraolTdpTvuvsdtM
   5FofJqBq4K0MsO+hJcwRQCsQaZMjg+duHw931K4WVPWYxvMNqfQr0vNIc
   Q==;
X-CSE-ConnectionGUID: TfUVFon4Q2uHndJAUDHUxg==
X-CSE-MsgGUID: lu5pJrYrQHWQviPIP00gPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="58012174"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="58012174"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 08:06:41 -0800
X-CSE-ConnectionGUID: Q4TMB2/9SB6aIt52PGnx8Q==
X-CSE-MsgGUID: hTgbQPo+T8WdLAhv+6iy9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206964900"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 08:06:40 -0800
Date: Fri, 23 Jan 2026 18:06:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/3] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aXOcjQqvE3TNUlel@smile.fi.intel.com>
References: <20260123114647.1606335-1-dmantipov@yandex.ru>
 <20260123114647.1606335-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123114647.1606335-2-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 02:46:45PM +0300, Dmitry Antipov wrote:
> In '_parse_integer_limit()', replace native integer arithmetic with
> 'check_mul_overflow()' and 'check_add_overflow()' to check whether
> an intermediate result goes out of range, and denote such a case
> with ULLONG_MAX. Adjust comment to kernel-doc style as well.

Probably you also wanted to say that this is to be aligned with libc behaviour
of strto*()?

...

>  		/*
> +		 * Accumulate result if no overflow detected.
> +		 * Otherwise just consume valid characters.
>  		 */
> +		if (res != ULLONG_MAX) {

Here I would put another comment explaining that the order operations matters
(has a side effect), id est the result of the first one is used in the second
one.

			/*
			 * Keep an eye on the order.
			 *
			 * @tmp is being used in the second operation,
			 * if the first one succeeds.
			 */

> +			if (check_mul_overflow(res, base, &tmp) ||
> +			    check_add_overflow(tmp, val, &res)) {
> +				res = ULLONG_MAX;
>  				rv |= KSTRTOX_OVERFLOW;
> +			}
>  		}

-- 
With Best Regards,
Andy Shevchenko


