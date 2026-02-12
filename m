Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26142EBB8C;
	Thu, 12 Feb 2026 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903378; cv=none; b=unwFeEdJp7wUXgwFRjkLRCZ30aiVzWRCTPp9J9LrQAVsclWoDKyQ/G5d6t/vSWWAKKjN4ZjrKojBI4O0komq+c1DHgTQpX5Vxtn1wpbqb0+M/OC7meBgMdlEH+mt40KgD4FA1GIB+qcVjTWqt0vtP3DJYLw64PLa19Tk/WhKVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903378; c=relaxed/simple;
	bh=Fx8eujbnCm44iTvql3NV6KTiJ01ONya3LRx8F4T+W50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzLOMZXwfXhXuJ7w2m0z7FvjctcCXcjWZWs3Y8l/dEs9ay2xNwxM/RlHKXioqfGcny5tWF5j876W3zzN45FQ4NdsuMfFn4dKhHntdK+7l0OWYyldmilLYW61H40C7IGzjIaJEPJLzXQqooIrZJo9MebKB0qi+QeBuEpu7JefTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRAePc6p; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRAePc6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770903377; x=1802439377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fx8eujbnCm44iTvql3NV6KTiJ01ONya3LRx8F4T+W50=;
  b=YRAePc6prZIfoJEDfjlYjksAnmFx5+yBH6r5s1xi8pcTD1NAIWvDS15Q
   iXg1HOnQRLFrAX2g7z16cMq6ryfPbsRKHWc9Asi//q2PBSOWu5SqooUop
   e56DLgL+7DzDZl/qmCIFentNEVsKQvM3uUFhaGAZ1qQEaPjaC7OIqs2UD
   L9cQ+fVc8DDn5nqCCgJUSEes5xSXUjUOv4Vop92Axt5gyrZbULxB/DWVg
   cqJ9w7IQW5FEZ+FCWnC0rMsfi2MBtJnuof1JN3PhOk9EdFvYeq0Wbsj/3
   4X8OH3UsWFAeEfABJ4ZXI8UKtTrdbKidYg36aEkJ13swnYtypJp2TjzXm
   g==;
X-CSE-ConnectionGUID: vTt7mdRoSJWKmjLt55pYHw==
X-CSE-MsgGUID: clUPQM1FS6GNcxLLG8kIeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75697461"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="75697461"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:36:17 -0800
X-CSE-ConnectionGUID: jmCwaf9qQsiJQ5HisUU/8Q==
X-CSE-MsgGUID: LeDm+JbmR92cLxrxyETXYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211869767"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:36:15 -0800
Date: Thu, 12 Feb 2026 15:36:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] lib: fix memparse() to handle overflow
Message-ID: <aY3XTDhPmUQB2V4P@smile.fi.intel.com>
References: <20260212125628.739276-1-dmantipov@yandex.ru>
 <20260212125628.739276-3-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212125628.739276-3-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 03:56:25PM +0300, Dmitry Antipov wrote:
> Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
> capable to handle overflow, adjust 'memparse()' to handle overflow
> (denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
> use 'check_shl_overflow()' to catch an overflow possibly caused
> by processing size suffix and denote it with ULLONG_MAX as well.

Assuming this is a desired check and you undertake any required
action in case of user breakage, the code wise this version LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +	if (shl && likely(ptr != endptr)) {

IIUC the second check is not needed, but harmless as it's basically a shortcut
for a single allowed unit letter.

> +		/* Have valid suffix with preceding number. */
> +		unsigned long long val;
> +
> +		if (unlikely(check_shl_overflow(ret, shl, &val)))
> +			ret = ULLONG_MAX;
> +		else

Id est if we came here with ret == 0, shl == 0, we would get val == 0.

> +			ret = val;
> +		endptr++;
> +	}

-- 
With Best Regards,
Andy Shevchenko


