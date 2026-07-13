Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33C3F4DE6;
	Mon, 13 Jul 2026 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943874; cv=none; b=EePFtT1XRbf+3ZwCkQ6gdS1C25sHprwfHBlYNXNvKa6+AqQXHAcOAe9Fc8/5iv1J/loBlZ1GMFwSgh/0LHsQk+YizLlIdLqs3qaKtluzVvC9QpzrvI/B4Zn5geY/ZLiG0xaxaUyMZGtUdkZr3wm/YsHmo9V0T4wt/QDqDrgZ7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943874; c=relaxed/simple;
	bh=Wqd6HavdHQ+in7uXENoZuKxyeiiQo7FKc0X1BuwKYSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT0LDytxhxJauzH7jsrB0gu8NwaAuV+1CiU8saXOlNLVNHbla66I34JCD8u453PIwTLYnHNRa3Ef/go4dbyV+Z76uJhleRIk58Ckd+4SA+asMC7w2oClmIlLG/Cnb8yJsd2uimVwGRqERvBeQi2Qm8quOCpz0gW93+F3BK8rI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbEuor9K; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbEuor9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783943873; x=1815479873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wqd6HavdHQ+in7uXENoZuKxyeiiQo7FKc0X1BuwKYSs=;
  b=bbEuor9K2D9vZK9nsZXvQ7++7fallZLRuCh6jz9OKWZflSkkhrd398To
   mwbzDRpOJwHggvJih7lifgv2PgG+Qr1LcYwx9dkGGuTyoEUARVsH925fM
   ndlrL6VJFjrBwxwniMiBQynktLRQCmtvupsR9x6dJMyjOD/z1odVSfIW2
   gxd7Ds9HXp2fUMmH8vakXC4KpkfiyVivqcedoAt7xX/MhNdXHqe5Sgw/p
   16KidSXcWWqf3bVnH2Dj5+dkDEcJ/A83wGbmMQi3oMOubQfqjcxj4O9oi
   EPBYUW1KowH0GZoKxN5JUN1xcoyBirtGzhGUB9i5gczN8qcwGxNbqbuSM
   w==;
X-CSE-ConnectionGUID: 1yjnX9+0QPCyFlyeYm/2nA==
X-CSE-MsgGUID: sO/NW4fgQqaOyv19M3hFCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84744668"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84744668"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:57:53 -0700
X-CSE-ConnectionGUID: SYH1GyzMQTOFLIarah9ATg==
X-CSE-MsgGUID: Roim73TjSnub0UC6iKmOHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="257493426"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:57:50 -0700
Date: Mon, 13 Jul 2026 14:57:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2 1/2] dmaengine: idma64: use kzalloc_flex
Message-ID: <alTSvDtnJawWuMn5@ashevche-desk.local>
References: <20260712220039.924958-1-rosenp@gmail.com>
 <20260712220039.924958-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712220039.924958-2-rosenp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 12, 2026 at 03:00:38PM -0700, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
> 
> Remove idma64_alloc_desc. It now offers no readability advantages in
> this single usage.
> 
> Add __counted_by to get extra runtime analysis.
> 
> Apply the exact same treatment to struct idma64_dma and devm_kzalloc.


...

> static struct dma_async_tx_descriptor *idma64_prep_slave_sg(

>  	struct scatterlist *sg;
>  	unsigned int i;
>  
> -	desc = idma64_alloc_desc(sg_len);
> +	desc = kzalloc_flex(*desc, hw, sg_len, GFP_NOWAIT);
>  	if (!desc)
>  		return NULL;
>  
> +	desc->ndesc = sg_len;

There are two places where this is updated. Are you sure the code become
correct after this change? Perhaps idma64_desc_free() needs additional care?

>  	for_each_sg(sgl, sg, sg_len, i) {
>  		struct idma64_hw_desc *hw = &desc->hw[i];

>  		hw->len = sg_dma_len(sg);
>  	}
>  
> -	desc->ndesc = sg_len;
>  	desc->direction = direction;
>  	desc->status = DMA_IN_PROGRESS;

In case the above is okay to do, move all three up to keep this block of
assignments together.

-- 
With Best Regards,
Andy Shevchenko


