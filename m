Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037F2F261F;
	Sat, 20 Dec 2025 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766214461; cv=none; b=X5+OveFtcoIsDQs7R8md5LtQFYxKkbAWiak4+oMNPT1v4gHvYOsSx04WDv4XbEbtoUzvOnhNZ/fxtNeI+g9rVOQhlDwVQaYejdDRROIAmahEnduyG5LJoZP5XHJQhix/APOJxPmwZ2JpkyMKnSM5FEkHeVMquPX5hXkol6S1o6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766214461; c=relaxed/simple;
	bh=+PkVN5dAeIa6PcQRAR/h8NFlO87MJ14rZ0rEoov89XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXF7cv35icnNlv0wpiDnglLamby20yeeDxs2nzgfD4YN87vAA7MmDMrJkJReVSU3+K+qFa79FLx7wNqXZMwFgfSilLZCA37dANiDQ7g3rvEuHznbg4WGo2Wsn+0hp7EBbwIj7rumF3ixP5PV6wNjKLQQHXwgHE242sXt3Fa6KQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dw3mOkTD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dw3mOkTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766214459; x=1797750459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+PkVN5dAeIa6PcQRAR/h8NFlO87MJ14rZ0rEoov89XU=;
  b=Dw3mOkTDFCKMHaLiMRmjieeGizT1IFwiGcowVNPW+ZBiJwM1ghfeGkiL
   yZH0kaUEdMUaamoAiTgNn9H9+qav0onIU/yktU3hZ1ga2/BYwi99UpeIi
   NWGGTmGeYxKsktprLzga3udRpA9UvjfRsHfTzW8eJowDqyRMm1jPHFOEO
   7n1KzxIC6e5djE78aMDsQtlYnR69lhH8f8qo313hggjefG+M1wocNSSDy
   cnQi+lohoeNoAydJTnTPZFQltUK/QZcaEj78oHIZIHSc3SCnG/Hj0CfdT
   z9AYxYw1W5iLLnhMjyscIG0dOXvBrdxev9kqw1eDFw+PxUsZUH5ivbTXZ
   A==;
X-CSE-ConnectionGUID: YpUmJJh/RiqeHWKLSJVWRg==
X-CSE-MsgGUID: d/37ZJJ1QJ2Zm0m9iUdXcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71797666"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="71797666"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 23:07:38 -0800
X-CSE-ConnectionGUID: MLbRm28JTwyDYpid8YBTEA==
X-CSE-MsgGUID: Ybu/NrVQTYOD1I6qwTUdNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="199289986"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 23:07:36 -0800
Date: Sat, 20 Dec 2025 08:07:33 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tomas Winkler <tomasw@gmail.com>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mtd: intel-dg: fix array-index-out-of-bounds in
 intel_dg_mtd_probe()
Message-ID: <aUZLNTOMgvJ8WrIy@black.igk.intel.com>
References: <aUZFLezigzZQVt55@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUZFLezigzZQVt55@kspp>

On Sat, Dec 20, 2025 at 03:41:49PM +0900, Gustavo A. R. Silva wrote:
> Fix the UBSAN: array-index-out-of-bounds issue below by updating
> counter nvm->nregions before the first access to flexible-array
> member nvm->regions[].
> 
> from kernel bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=220823
> 
> Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15
> 
> Notice that this flexible array is annotated with the counted_by()
> attribute, hence the counter must always be updated before the
> first access to the array.

Already fixed[1], but not sure if it's landed yet.

[1] https://lore.kernel.org/linux-mtd/20251111-mtd-nregions-v1-1-61db61e78c63@intel.com/

Raag

> Cc: stable@vger.kernel.org
> Fixes: ceb5ab3cb646 ("mtd: add driver for intel graphics non-volatile memory device")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-hardening/90e419ad-4036-4669-a4cc-8ce5d29e464b@infradead.org/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/mtd/devices/mtd_intel_dg.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
> index 2bab30dcd35f..d3e89fe324b8 100644
> --- a/drivers/mtd/devices/mtd_intel_dg.c
> +++ b/drivers/mtd/devices/mtd_intel_dg.c
> @@ -768,6 +768,9 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
>  	if (!nvm)
>  		return -ENOMEM;
>  
> +	/* Update nvm->nregions before first access to nvm->regions[] below. */
> +	nvm->nregions = nregions;
> +
>  	kref_init(&nvm->refcnt);
>  	mutex_init(&nvm->lock);
>  
> -- 
> 2.43.0
> 
