Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733027;
	b=HQs/jGiZ9P7qFLusgxZDt37/Sx6bUnKPqg4A1/dNMlZ1qv1oYyxGeY7xHRDxSyuWyHkC
	 H31ahCnNbH4ez6y0t4Gh5ekDOKJHriwm1sn5M8/8NyPgNpOy/OU+D7xHaBx1jk4n4JVNs
	 vowRowWfDbG6M+Pz8AvjEHJlG0dYnLXzLxSo0G3tUfvKet1YArcAGP3lpouGjYvYWHyRT
	 e/+5nXFygUJSnFBS/2xJw/y+BNBfojUfIC61yDOQCpSk51VJGgw2pMXoE+1oqt02BxDG5
	 NZOe0xB45X2xrdlxDIfoqdZFgnD1SFMSi6W546I6AUlHW/pRMorRc6ied+7yYGxcibg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733027;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=S+JgSQ/46BrMxN0xU6bx4aEKO3EnlkiuodAuZeHqg8w=;
	b=YJnGXROEsOU0B2v2UBmLPl+S87BJkWm0AyOtuxi2FZiWxGIXJaMpEYFqf1e1bivMYwy4
	 VQm73VGCydaGDmHttalE8vOXGImxVfqcg6uVDi3AMoHThhzCjYJ7x4a5XW/dgN9lB/7+l
	 nhr7e2T7lJKqD8dXiL1ANo77DgZlCDPMvJAY5HWBdcU0ACE1d2XYbZfVKZ0E9LRHagy0n
	 q/zuPaKDyz8/BvYXk09Y9tidDOILbRI5y+OAoqGT07+dGoACta/iXjg6ZypCoPmNxMG9g
	 +8ybKa4xWBTF/Qp2tqwzQ8cpYN9dyzluCnxFr9jG4yP6UBY8hx6u8PU5Do2sM2mXbyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HnWsgtqN;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483F606A324
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 19:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2483F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HnWsgtqN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793733027; x=1825269027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7C4MEbieWQlWmsHN8tNbtrHdIql2U54x4uvsK0r4XxA=;
  b=HnWsgtqN8dlqz5hx7ejO6Fjyv6wTEQs1znbR3kBv9oJYXjS6cMkRi3Qo
   TOePj8MMiBntNTFhMxRi7QMOJvEPlJ8cUUdj/3RLNzisnbLlsuWtI9tql
   i6Op6NYqLELz7yv/Wfz0I8Ch8FjJdLS8uNYmdzxaCJx4lZf06v0Q/rKtS
   l7PYcMJmjodnTzU80N6XOd6HtaJgMotIB7jnh8ZWpEQO418eTZ0EG+nlZ
   QcVW1XdYL+RW0y6IL2CRdgSSnRmDHoi7CrNAzduz8/hIQCJ3gnfifqKzj
   QI1x9kPZg0QeSZc4LSuvTf1afiW07TpJ8PF6fPDsfmXpGGSxa+ruIKJlS
   A==;
X-CSE-ConnectionGUID: Vp/++kkxQAapsELV7jEsZQ==
X-CSE-MsgGUID: HRsQJK79TQ6MOttnWybzkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2350037"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2350037"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 11:10:26 -0800
X-CSE-ConnectionGUID: RtW/eNROR1Sfj29iN2ZJGQ==
X-CSE-MsgGUID: /PRdtGBJQ6uBrF1vy6J73w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8282770"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 11:10:25 -0800
Date: Tue, 3 Nov 2026 21:10:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 0/2] Simplify implementation of strscpy()
Message-ID: <auoxn2Pe10D4HPKm@ashevche-desk.local>
References: <cover.1793712214.git.alx@kernel.org>
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
In-Reply-To: <cover.1793712214.git.alx@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 02:27:08PM +0100, Alejandro Colomar wrote:
> 
> Here's a simpler implementation of the default arguments in strscpy(9).
> It avoids having to build concatenated names, the ignored '...' in
> __strscpy0, counting arguments, etc.  It's replaced by a quite simple
> macro that takes two arguments, and picks the last non-empty one.
> 
> It requires a C23 feature, but it's supported as a GNU extension in
> GNU C11 mode, and was implemented a long time ago, so it should be fine.

Yes and no.
See 551d44200152 ("default_gfp(): avoid using the "newfangled" __VA_OPT__ trick")
for the details.
So far NAK from me.

-- 
With Best Regards,
Andy Shevchenko


