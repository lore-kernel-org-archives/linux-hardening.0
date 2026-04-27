Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F390372EDA;
	Mon, 27 Apr 2026 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282962; cv=none; b=BI8QbCyXYo9phqqvoUBnNV5RjDKNLIzu7416xMuaNNoXIX04JQTqgdQoqASCpGZAUaJStsyhio+W8QwrE+kUhTUaisXyfRpuYG8pJ1wN17rRbBe+v8wE9zz6BPSnaqwEFbn5tSB/qDxiBS+HLJUai1HN+vsXdMgYVxbiG4GvrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282962; c=relaxed/simple;
	bh=ET/h6kAT63iSS0l+CUE6WN2z7gKjUlZ9AGWdRoYHSDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7OXSuGC7mBfNQNAlk3/oa+Pgmo4u0cXvsFfnHgAr1O1v6A2AlElqe+uvNJg7hxdinvV99EqLQf2gnZ283/uy96IGaZk8T48z+4CuPXU/AmetPFMK6Efttn57WtKlXaUMHT1nDZWh5gZW//5xmmuNJh9i0NemySHyxIM6hoUxSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jl13+mn4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jl13+mn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777282961; x=1808818961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ET/h6kAT63iSS0l+CUE6WN2z7gKjUlZ9AGWdRoYHSDY=;
  b=jl13+mn4KwdT2aVIpl5n3ue+FNzmrgGMVoTBm2T+C7Bk5rHzwcnnKEbE
   VnrWrzQS7dXqFLqvn6HVqq8Q0yHXS2Z7A8Gk3eqteMDdin+3vjg3GYI5x
   DQD6paaE6UII3N+F0LUnvClMQXEN090JxONXs1nuPx4bq+yW93sTk4P63
   y+3AwA7IF6ehEtw56CEPy+icX4N9vaxmaIhfe42LHtGSQyuUKqwbaarUt
   Uk5IcwEsY3VAbp328/B+GU2DhPUpc2CksJhuBio7EcTX+qcLxU0nCZvT5
   fQj/C4r8XUq+ds9woDZRPXJ7VVttER8yV1n7YOuzsMU42eb4BJX4B2RL4
   Q==;
X-CSE-ConnectionGUID: 3RFi6xtmSwCq6kYIxmAoZw==
X-CSE-MsgGUID: 7rIl0MVwRcyupi3NQ7txng==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78083522"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78083522"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:42:40 -0700
X-CSE-ConnectionGUID: KP7ONxGESTem19bK8OAwuA==
X-CSE-MsgGUID: dltsjjIXRN6jljQeWGjQsA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 27 Apr 2026 02:42:39 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 2092E95; Mon, 27 Apr 2026 11:42:38 +0200 (CEST)
Date: Mon, 27 Apr 2026 12:42:36 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: combine kzalloc + kcalloc
Message-ID: <ae8vjJXmtW8nN1q8@kuha>
References: <20260425014201.439251-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425014201.439251-1-rosenp@gmail.com>

On Fri, Apr 24, 2026 at 06:42:01PM -0700, Rosen Penev wrote:
> A flexible array member can be used to combine allocations and simplify
> handling slightly.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 1698428654ab..e22b070a140f 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -151,13 +151,14 @@ struct pmc_usb {
>  	u8 num_ports;
>  	struct device *dev;
>  	struct intel_scu_ipc_dev *ipc;
> -	struct pmc_usb_port *port;
>  	struct acpi_device *iom_adev;
>  	void __iomem *iom_base;
>  	u32 iom_port_status_offset;
>  	u8 iom_port_status_size;
>  
>  	struct dentry *dentry;
> +
> +	struct pmc_usb_port port[] __counted_by(num_ports);
>  };
>  
>  static struct dentry *pmc_mux_debugfs_root;
> @@ -731,27 +732,25 @@ static int pmc_usb_probe(struct platform_device *pdev)
>  {
>  	struct fwnode_handle *fwnode = NULL;
>  	struct pmc_usb *pmc;
> +	u8 num_ports;
>  	int i = 0;
>  	int ret;
>  
> -	pmc = devm_kzalloc(&pdev->dev, sizeof(*pmc), GFP_KERNEL);
> -	if (!pmc)
> -		return -ENOMEM;
> -
>  	device_for_each_child_node(&pdev->dev, fwnode)
> -		pmc->num_ports++;
> +		num_ports++;
>  
>  	/* The IOM microcontroller has a limitation of max 4 ports. */
> -	if (pmc->num_ports > 4) {
> +	if (num_ports > 4) {
>  		dev_err(&pdev->dev, "driver limited to 4 ports\n");
>  		return -ERANGE;
>  	}
>  
> -	pmc->port = devm_kcalloc(&pdev->dev, pmc->num_ports,
> -				 sizeof(struct pmc_usb_port), GFP_KERNEL);
> -	if (!pmc->port)
> +	pmc = devm_kzalloc(&pdev->dev, struct_size(pmc, port, num_ports), GFP_KERNEL);
> +	if (!pmc)
>  		return -ENOMEM;
>  
> +	pmc->num_ports = num_ports;
> +
>  	pmc->ipc = devm_intel_scu_ipc_dev_get(&pdev->dev);
>  	if (!pmc->ipc)
>  		return -EPROBE_DEFER;
> -- 
> 2.54.0

-- 
heikki
