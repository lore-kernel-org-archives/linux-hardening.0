Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B2817F4F2;
	Fri, 23 Aug 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420433; cv=none; b=b1dDkhkd78dc5W7dmUw98x9uyg6YmVnldVHVe8EqzZlEG8BS8mAgadeFoETWarXsnCf+sBNc69K1KfBCdf1rJtvEaPVACmWfZWcfpjap8jVxrtChqeO0jlfRN6sQuHQx5IE55aoa7MorX7flfxoHDECooimN6LpzQrcFMv05Qq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420433; c=relaxed/simple;
	bh=+szYI74W4Zki1Y29MlUjRsf+VYwWjiDCC0d45P7PO6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+O8eEBvfrSfo1rgNhFA0DN1rgxogmMaIEhlqo9jXLUS+sVRddQInRtcfe4CuDd2UySNS6lEiaqXqnWNatEnofWWnmbVHW50xPkZBVi3+SbM8AvoZJQhmCDwfYqNfs1PwPBRzcsGpef7sKtKY1JowO2tPRj7m5e5CAioAwPFMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+PP1qel; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+PP1qel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724420432; x=1755956432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+szYI74W4Zki1Y29MlUjRsf+VYwWjiDCC0d45P7PO6E=;
  b=g+PP1qelloPomPomEn/WfU5A7I93lj1ZlDWnxoYchszH6hYFs/vovsQz
   C+iK6P9wi94Z3h6QNyDa8jtcnPtebGhIIGtSv3TOLlOctAeXGuMx3lYI0
   RLv4fMTHfhD1fGEkHuN1cqZ0m8gLHxYClhvvlphZPMnKs3dwkFrevNipN
   IIqB4lNX0th2kBlHpl8Ah41KQAztxi6KsA2ul6Sn0XUQ/IGgItq/oe1AS
   +HfmqSWWZOb4TuTN7VBcCIrTAutv0JYHPjUF3Aj39jjtO/QL5YKZssUj/
   qrxNFZT23vxGPL///vu8PO9P8VIr9czMftTs4pbQr3fghunaU79pqVncw
   Q==;
X-CSE-ConnectionGUID: yZVe0La6T1eQMVb0pRl1Yg==
X-CSE-MsgGUID: L/9qA+jCRrCudl1YN1370Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33455732"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="33455732"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:40:31 -0700
X-CSE-ConnectionGUID: en08L4UhRsmKTTVSlY4xtg==
X-CSE-MsgGUID: GQq0JHIwTu2c3ysst6bTLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61774254"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:40:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shUWg-00000000o7p-3l9m;
	Fri, 23 Aug 2024 16:40:26 +0300
Date: Fri, 23 Aug 2024 16:40:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kees@kernel.org, gustavoars@kernel.org, mcgrof@kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] params: Annotate struct module_param_attrs with
 __counted_by()
Message-ID: <ZsiRSq_fgrnKcQPi@smile.fi.intel.com>
References: <20240823123300.37574-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823123300.37574-1-thorsten.blum@toblux.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 02:33:00PM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment num before adding a new param_attribute to the attrs array and
> adjust the array index accordingly. Increment num immediately after the
> first reallocation such that krealloc() for the NULL terminator only
> needs to add 1 (instead of 2) to mk->mp->num.
> 
> Use struct_size() instead of manually calculating the size for the
> reallocation.

...

>  	/* Extra pointer for NULL terminator */
>  	new_attrs = krealloc(mk->mp->grp.attrs,
> -			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 2),
> +			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 1),
>  			     GFP_KERNEL);

Convert this to use krealloc_array().

>  	if (!new_attrs)
>  		return -ENOMEM;


-- 
With Best Regards,
Andy Shevchenko


