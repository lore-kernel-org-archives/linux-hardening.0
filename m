Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586393;
	b=KWjRdaVkOiBpbyH/6eIcLr8dK5vFL+lvNIi2p4si/PDQJJKTu+kGU2uCjn99MD38AoLf
	 rUWjXxDH6w6BhIf87jFBYKBIpZGumMM3HUhklatyafDlNDv6ArLmlPtaPUt5y+QCUJRmO
	 k+t44t1lhy3kjLT5u/A7da3eHEAUrxNibDl4bi9OwgiPCTzhLvS4rgDymW1DPCLsN8Krj
	 v/PmE4J+iBOLzWh3jWlq6zuLCMSr8B/yuTpNs7SWWG4Z3Dypb1R9u6ofOtLNt1a3LtHAJ
	 0crbYzswxb9qDadBKS2QyxcHBmzYzvZO6t8UfCs1eSVuIczIlZIv139d1Mgo+VxGhog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586393;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=k3sSdj/Fj8r+WusGOm78ZahxMk2w6/t6D9Bm31RNpcA=;
	b=kgrNTT6NIpsirBZI1M/UkcAaZC9F8i4KG4zoio03uSae5YrEqVBAvUlyrt5dhQ2KzdM9
	 fJzCodPG545qD9ebUQ0VShYVp8R8QQoYDDHEEcCiz0AD9N/kNvNx3hPenWKYuR8jCO/b2
	 nMcVlx5slbaF0J346uHa4nJYGWeK+zCXUdTJMXDWX3onr21I6MEF6JVNdkoxZpx07/ull
	 yaHCJsNOu/zYsmOKKcXscxJEL/sXuaqnqW6YeCA0N1+tl/85MakBCdLZuwAc5ulncHFLI
	 n09ZPAzWLZzpcXpH7qGYJmQMittjyBjmAPVCkruNrpSaD3brTmVYLp0jqcnW09YG48g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H+VulyAc;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA1606EBAD;
	Fri, 13 Nov 2026 16:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14CA1606EBAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H+VulyAc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794586393; x=1826122393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XJszu6++5eh8DMo5JkBUm4tqlvWrEhfU4XHnKfHIWx4=;
  b=H+VulyAc0fMTX4DiRCQKTHwcXNIwJsYbq9mf/+Uqaj6vgiDrmWLS/Qh1
   GMDtplCKeQbvs0hhsmIVAnOKHXbDCbgno3A/JhjJ0nGmDGEkFQhKhXhj9
   SJ801tgkkDLanthocTG8o2Fu/VEnzUAq/PGPtLOkMSGhqszp+0Je7ZaAy
   cgFj2aoZ0jKVlv3gSouPB8cAx1+uuhX582HPC5En5qakA3ua0dSbw6Xcc
   +w3NfrUIytlGm4+ZPm/B7DVNaeREG8eZKPPh0C0bxTBFIQ/hBEeID/F4Q
   QsU1nBfXM20PEPOWoAPloTWVvEH5xzJ8hXYKV0IWquIUw0dSaDjHqNuvr
   A==;
X-CSE-ConnectionGUID: OiqZNiBrSf+WBh8FdlO5Yg==
X-CSE-MsgGUID: RqJaFehTS4etkkFcEbis8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3408606"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3408606"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:13:12 -0800
X-CSE-ConnectionGUID: GpvPIBx2Sx6hhcdLnQjvzA==
X-CSE-MsgGUID: SRjzV1wDQFSY1lVU3VER3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9298571"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:13:07 -0800
Date: Fri, 13 Nov 2026 18:13:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 07/10] device property: provide
 fwnode_property_count_references()
Message-ID: <avc3EfUI7UlFcSB9@ashevche-desk.local>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-7-4edc23d5cf50@oss.qualcomm.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-fwnode-for-each-prop-v2-7-4edc23d5cf50@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:47:07PM +0100, Bartosz Golaszewski wrote:
> Provide fwnode_property_count_references() - a new fwnode function that
> allows callers to retrieve the number of references in given property.

I don't understand why we have this patch separated from previous one?

-- 
With Best Regards,
Andy Shevchenko


