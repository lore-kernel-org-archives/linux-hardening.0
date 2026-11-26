Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706427;
	b=1Uvb9MsKxLZSY+v03lbUt/lb6UPKJRKRGu9v0IGLXQA7K9UbagiTIJO/DEH90fdUQFN4
	 EmycXUmlp8TzkVRRGwyo5szgVcUaOS0y5OAnxrrxXbh2uXnIOfgdLeefyqUp+d6N5LWy7
	 cvufrZZpnrCAFyQ/fprY5Jq/lpawOu2kQYdYsELuwDtT8zQ/0npVgd8/C+rPmuga3SZb5
	 1vX+CdhERt04qX3iK/2pQ4Pw54TdsYF/taykBA+2sqfZ/mJeoV0Jh3IaecCQPznRpbSKF
	 DLtK3Sxyb1Xn7ptuqEtvMIk7/QBeKuwA3OC96Z3sRJzHMNy7Lsqq7DakZ2nWHAjsmCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706427;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=8VCDc85rZIzllfXW8iMaAuFOoYvrvzLTu2xqjGFWicM=;
	b=fWqwcjdz/VgywYZAgHQRvXjBrLHG2/ZrKhbSQhnLxc91r6vsWSDDk+QbyaGVGwwsEZaV
	 4xA6Cq5+0Y9u5L8Fhdf6tAyS96vC4ZuvEjmy8oReCWy2xTn8fvxyMXkYyGsEg86b7npHH
	 Ecu4HTzLZzcZk7Toun2DMtSdiXCxhklKqHeQbuRhn7dEVQIGoIVW4/JbPnZGl+iEfQMFC
	 64S3DHeFgNAYE58X7AGGIZj/1wgQvZN/n8V1xpxjTVRYEBc2WVcYZgjPl/hYaUqPVx3yz
	 oEoKwvdeIS6/v6c+VjmyxS0q7E0rJlh8dlvhUdw5Fb4EN3lLSE1htn6CnSmDHSc93nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="M/+YNiOd";
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3E606A31C
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 15:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CB3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M/+YNiOd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795706427; x=1827242427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8NVCkRju91RxvSv5X3NgnFQn/3ktmzfUGUqBIQF8pws=;
  b=M/+YNiOdKHx4Kqf/vPU1Tjt+6BNfW4julr9KAZFGRWugCKMivuty7mpc
   rl4U4jmua/itiaE9yuKYOG3L3RNL8vHDn9MXvDEPPg3T0Vf0pBk7WaMls
   K9/1vMCRK5Ci+PrZYSYCn25ki68N/i6Zzhj/1WVNgebe4iNc9DaJLwOUM
   DwbBvUcmIEyiFQkukFKmsQgLMHibDK53xfkArlIC3tUxB/6HRHnBU+avq
   BJUTNg3qQ0jN/aPx4WOMC45nybnu4q+lOxe6Zre5CL64nwxMU+w4VlIfB
   PIhYAmWRQh6F9opr8UsQAtIOEvp3LKr3aTiY0XZ3p7RYKH+akl9Tl56dO
   A==;
X-CSE-ConnectionGUID: Ag73FQlJQuCY8+rxGc99cA==
X-CSE-MsgGUID: GkPS4DWMT1uXsJN4yc4+Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4637706"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4637706"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:20:15 -0800
X-CSE-ConnectionGUID: lD0A5XM+Q06BSemRz+MyUg==
X-CSE-MsgGUID: AUl+BC0gST2N2a74MxLVRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12538406"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:20:13 -0800
Date: Thu, 26 Nov 2026 17:20:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] string: Add missing const
Message-ID: <awhOK6BFK6Rj0ytu@ashevche-desk.local>
References: <9331ce2afba1a44bb84f371581478a9ac5ee7380.1795631164.git.alx@kernel.org>
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
In-Reply-To: <9331ce2afba1a44bb84f371581478a9ac5ee7380.1795631164.git.alx@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 07:26:38PM +0100, Alejandro Colomar wrote:
> This pointer is derived from other const pointers.

Constification almost always is a good thing, if this builds and works as
expected,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


