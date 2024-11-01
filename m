Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C3C13C;
	Fri,  1 Nov 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730463972; cv=none; b=A/3ydSVuH464UOYam8zoEeV/8qHMfJYHPPyVuDGw03EDcFoCI1pbGO13NXMaagrHOpQYBqJWUiK8ZYpk8YjGdUkvhdrthA6jiUUGOWf0Q80CNFJbCNJ46uVtB5HA+SZVTfExzZAuHTJi6jrUnjf/K/G/w5xIRiX3k6DBK3BHOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730463972; c=relaxed/simple;
	bh=UL4eHOimmWnAYsGUUSDCeZILgUtG0yaHZDnu0hEaGwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAZszuM1K9HzjMChub22tdSbz1nMWnQpRQrBGrkvxPi3waSm9pBBOWfJKqsuex2u3Imx5KAJcfetrzF5683zS7fr6kPtnFdrA7Df55GstVJbyB4/mxoYiR2bG27IaGk559bpxlwdHWV3GT6MYhfaEYMnSpg4f8u96F273uOKi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDEmd7Jb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDEmd7Jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730463970; x=1761999970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UL4eHOimmWnAYsGUUSDCeZILgUtG0yaHZDnu0hEaGwo=;
  b=oDEmd7JbyVmKeYa0hI5YcwLEBfAc2OLd+j2qmlNuiIEAld6cSHjKgjTN
   sXZDkdvFmJNal51RtR8FmkRN3pXI8UuQtDwH8bztO32gsVKw2/PxmXyx5
   1b8lLPwVEfTALCX4myX41ZOXodFydOtu0ZiLZW2GQ916IpDVZCJd+6PMH
   /NtCC3js6Q8ropE/Ea080MahiODwpazVR6Ez8P5xBiaGi+X41oxuczH0h
   Jc3yrR/QGXVLfiWkSKZAuKEgD+mQl2Ob7gUpqG+/3J1W2eOlU/JdlKEQq
   LRzn04kl2ZHJmMdIYk8IJ6USZFJUm1jOThoyWeRnPKob5bRQ6BEKAr5cp
   g==;
X-CSE-ConnectionGUID: D1N3Q02ZTGC4gbZgXYaPig==
X-CSE-MsgGUID: pa6hdMqJSaqsRbMIc7S50w==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="29647279"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="29647279"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 05:26:09 -0700
X-CSE-ConnectionGUID: 9V7zUbt/QXqE0AHcuipPKw==
X-CSE-MsgGUID: +V+rz11/Q9Ok1JxbuvmJLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83285658"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 05:26:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6qj6-0000000A1hG-420b;
	Fri, 01 Nov 2024 14:26:04 +0200
Date: Fri, 1 Nov 2024 14:26:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kees@kernel.org, gustavoars@kernel.org, mcgrof@kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
Message-ID: <ZyTI3NoFY7uGfTWo@smile.fi.intel.com>
References: <20240823145931.107964-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823145931.107964-3-thorsten.blum@toblux.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 04:59:33PM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment num before adding a new param_attribute to the attrs array and
> adjust the array index accordingly. Increment num immediately after the
> first reallocation such that the reallocation for the NULL terminator
> only needs to add 1 (instead of 2) to mk->mp->num.
> 
> Use struct_size() instead of manually calculating the size for the
> reallocation.
> 
> Use krealloc_array() for the additional NULL terminator.

What is / was the resolution on this change? It seems it either fell in cracks
or being abandoned.

-- 
With Best Regards,
Andy Shevchenko


