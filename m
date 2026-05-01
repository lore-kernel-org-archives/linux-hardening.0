Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D396359A94;
	Fri,  1 May 2026 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670656; cv=none; b=rWwHeAKc4QMti/kedvnCNENOjuoUc24txl6gSsj5E+dFdvK5wOVLOPaL+xDdc1JixJDCfj+kHmmXT2n7sVqUmm3ye4Kczk7iD3S43TkGkvZUUFG4nFGVxt4XZ43HIRv8eLUs5lEDCjPIdbz507CriLLaxRDDML9m9ZlW8Hqvimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670656; c=relaxed/simple;
	bh=SkdcsE7EjRLTtFgjUs6SYSwxlkTqmPmRyFhUGVS2CTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=untW+bbpafC3oUtqpxQnw1+eMYf6jYI6NoHOt+f8s5kp/a6GTlffqUXz2kZzMe8x0QkD6nlizTdHQEusTDpIJVbry+cAQt5otiABEyeC6eOVfkt30KdXuLk20ngGM3PbmEVyqCZ3mqlRWbCEFog/DUVD/jWYlbmdl04rmt1qS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6yXd77I; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6yXd77I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777670655; x=1809206655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SkdcsE7EjRLTtFgjUs6SYSwxlkTqmPmRyFhUGVS2CTo=;
  b=h6yXd77IjJIGABQaNqnBmVq9lZIWY5uXgeW6r9EeSfCUNuhb8DFf5ceS
   4WziuBl18bOofgs1CJZHiTZj0gowa+Fbew/yGfHC5SAXlMJBOiDDNUNe2
   dFGPOxD6fHZeRpRzesa6fgrlHkzcqdRJhTgSn2NOgNgZb64xdn3wbsY9i
   rPsX1fWE7cdk7V8TgCTPpWNrOlpSridnY47DnN/l7zCyIIjV/kac5HYHp
   +AE3cV5R6FL5GevzUYDc6Rr2ABENv8k9nceuqy+Ne4PXEAGUg+5TJ0UYp
   ugoA6hK3GXHlOfEvVeXb/4Da5JuAJTFQyuFzCJn71j/Id3gXE/+YzGikE
   w==;
X-CSE-ConnectionGUID: 2xnsrKwJSP6m6pCgE/R2Gw==
X-CSE-MsgGUID: yIb1jZUqTkC/fXMoBgi48g==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="78336659"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="78336659"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 14:24:14 -0700
X-CSE-ConnectionGUID: cuA302NCQx6UIkdwvA9iaQ==
X-CSE-MsgGUID: FTqA9a0NQFK949u8bG4wFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="233932326"
Received: from debox1-desk4.jf.intel.com (HELO localhost) ([10.88.27.138])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 14:24:14 -0700
Date: Fri, 1 May 2026 14:24:13 -0700
From: David Box <david.e.box@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/intel/vsec: allocate res with intel_vsec_dev
Message-ID: <fdmwbmlp44n5kspjau4w56ww3ynexep3xg47ixizmhdrdxwf7w@4pzll4a2epbl>
References: <20260430224307.109311-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430224307.109311-1-rosenp@gmail.com>

On Thu, Apr 30, 2026 at 03:43:07PM -0700, Rosen Penev wrote:
> Use a flexible array member to combine allocations. Avoids having to
> free separately.
> 
> Add __counted_by for extra runtime analysis.
> 
> Move counting variable assignment to after allocations as is already
> done by kzalloc_flex for GCC 15 and above.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Tested-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: David E. Box <david.e.box@linux.intel.com>

Thanks

> ---
>  drivers/platform/x86/intel/vsec.c      | 14 ++++----------
>  drivers/platform/x86/intel/vsec_tpmi.c | 13 ++++---------
>  include/linux/intel_vsec.h             |  6 +++---
>  3 files changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index 7d5dbc1c1d05..9ef0f043bbee 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -112,7 +112,6 @@ static void intel_vsec_dev_release(struct device *dev)
>  	ida_free(intel_vsec_dev->ida, intel_vsec_dev->auxdev.id);
>  
>  	kfree(intel_vsec_dev->acpi_disc);
> -	kfree(intel_vsec_dev->resource);
>  	kfree(intel_vsec_dev);
>  }
>  
> @@ -225,7 +224,6 @@ int intel_vsec_add_aux(struct device *parent,
>  	ret = xa_alloc(&auxdev_array, &intel_vsec_dev->id, intel_vsec_dev,
>  		       PMT_XA_LIMIT, GFP_KERNEL);
>  	if (ret < 0) {
> -		kfree(intel_vsec_dev->resource);
>  		kfree(intel_vsec_dev);
>  		return ret;
>  	}
> @@ -233,7 +231,6 @@ int intel_vsec_add_aux(struct device *parent,
>  	id = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
>  	if (id < 0) {
>  		xa_erase(&auxdev_array, intel_vsec_dev->id);
> -		kfree(intel_vsec_dev->resource);
>  		kfree(intel_vsec_dev);
>  		return id;
>  	}
> @@ -282,7 +279,7 @@ static int intel_vsec_add_dev(struct device *dev, struct intel_vsec_header *head
>  			      unsigned long cap_id, u64 base_addr)
>  {
>  	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
> -	struct resource __free(kfree) *res = NULL;
> +	struct resource *res;
>  	struct resource *tmp;
>  	struct device *parent;
>  	unsigned long quirks = info->quirks;
> @@ -306,13 +303,12 @@ static int intel_vsec_add_dev(struct device *dev, struct intel_vsec_header *head
>  		return -EINVAL;
>  	}
>  
> -	intel_vsec_dev = kzalloc_obj(*intel_vsec_dev);
> +	intel_vsec_dev = kzalloc_flex(*intel_vsec_dev, resource, header->num_entries);
>  	if (!intel_vsec_dev)
>  		return -ENOMEM;
>  
> -	res = kzalloc_objs(*res, header->num_entries);
> -	if (!res)
> -		return -ENOMEM;
> +	intel_vsec_dev->num_resources = header->num_entries;
> +	res = intel_vsec_dev->resource;
>  
>  	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
>  		header->offset >>= TABLE_OFFSET_SHIFT;
> @@ -342,8 +338,6 @@ static int intel_vsec_add_dev(struct device *dev, struct intel_vsec_header *head
>  	}
>  
>  	intel_vsec_dev->dev = dev;
> -	intel_vsec_dev->resource = no_free_ptr(res);
> -	intel_vsec_dev->num_resources = header->num_entries;
>  	intel_vsec_dev->quirks = info->quirks;
>  	intel_vsec_dev->base_addr = info->base_addr;
>  	intel_vsec_dev->priv_data = info->priv_data;
> diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
> index 79c0cbea2dee..908f3377b05a 100644
> --- a/drivers/platform/x86/intel/vsec_tpmi.c
> +++ b/drivers/platform/x86/intel/vsec_tpmi.c
> @@ -626,15 +626,12 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>  	if (!name)
>  		return -EOPNOTSUPP;
>  
> -	res = kzalloc_objs(*res, pfs->pfs_header.num_entries);
> -	if (!res)
> +	feature_vsec_dev = kzalloc_flex(*feature_vsec_dev, resource, pfs->pfs_header.num_entries);
> +	if (!feature_vsec_dev)
>  		return -ENOMEM;
>  
> -	feature_vsec_dev = kzalloc_obj(*feature_vsec_dev);
> -	if (!feature_vsec_dev) {
> -		kfree(res);
> -		return -ENOMEM;
> -	}
> +	feature_vsec_dev->num_resources = pfs->pfs_header.num_entries;
> +	res = feature_vsec_dev->resource;
>  
>  	snprintf(feature_id_name, sizeof(feature_id_name), "tpmi-%s", name);
>  
> @@ -647,8 +644,6 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>  	}
>  
>  	feature_vsec_dev->dev = vsec_dev->dev;
> -	feature_vsec_dev->resource = res;
> -	feature_vsec_dev->num_resources = pfs->pfs_header.num_entries;
>  	feature_vsec_dev->priv_data = &tpmi_info->plat_info;
>  	feature_vsec_dev->priv_data_size = sizeof(tpmi_info->plat_info);
>  	feature_vsec_dev->ida = &intel_vsec_tpmi_ida;
> diff --git a/include/linux/intel_vsec.h b/include/linux/intel_vsec.h
> index 1fe5665a9d02..07ea563f524e 100644
> --- a/include/linux/intel_vsec.h
> +++ b/include/linux/intel_vsec.h
> @@ -135,8 +135,6 @@ struct intel_vsec_platform_info {
>   * struct intel_vsec_device - Auxbus specific device information
>   * @auxdev:        auxbus device struct for auxbus access
>   * @dev:           struct device associated with the device
> - * @resource:      PCI discovery resources (BAR windows), one per discovery
> - *                 instance. Valid only when @src == INTEL_VSEC_DISC_PCI
>   * @acpi_disc:     ACPI discovery tables, each entry is two QWORDs
>   *                 in little-endian format as defined by the PMT ACPI spec.
>   *                 Valid only when @src == INTEL_VSEC_DISC_ACPI.
> @@ -149,11 +147,12 @@ struct intel_vsec_platform_info {
>   * @quirks:        specified quirks
>   * @base_addr:     base address of entries (if specified)
>   * @cap_id:        the enumerated id of the vsec feature
> + * @resource:      PCI discovery resources (BAR windows), one per discovery
> + *                 instance. Valid only when @src == INTEL_VSEC_DISC_PCI
>   */
>  struct intel_vsec_device {
>  	struct auxiliary_device auxdev;
>  	struct device *dev;
> -	struct resource *resource;
>  	u32 (*acpi_disc)[4];
>  	enum intel_vsec_disc_source src;
>  	struct ida *ida;
> @@ -164,6 +163,7 @@ struct intel_vsec_device {
>  	unsigned long quirks;
>  	u64 base_addr;
>  	unsigned long cap_id;
> +	struct resource resource[] __counted_by(num_resources);
>  };
>  
>  /**
> -- 
> 2.54.0
> 
