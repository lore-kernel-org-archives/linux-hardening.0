Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0863254A3;
	Wed, 15 Apr 2026 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257876; cv=none; b=ISMlRGL9muCKRnXgmWPER7WEZiyKRk6ELyyQSqQBbQ7ZMtdg35fv1rbE8/0GbnSGpA7O2JXTeVci4P7TR8gjg9g4e6dP9EhN+DmfzqvrOD3j5uNljCHQoI1RrFpBj6PAekqFV67f5xFwEU3DBTv2ADs0yw9RryWy0+DwUoKbo3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257876; c=relaxed/simple;
	bh=2BKXwGlQdAGj6DmioexaKwuxqrJSh3vgNJu/czIJiXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsnV1HbOhfRht/v44JCT7OUCAb4TFyQz8ADaSSSlW4p7qbINSZzEE8JsrETfLlEvmQ99h1ilCRZfx8/Xmr3da0MTRK/ZC26UD3ugC7xf2ugKNO71F8lK+A2hSguwkm5x+myz3/Cs358HpZglWSsxXSFpQ7rDpxxWU67WFaH1qmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+vJCZb7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+vJCZb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776257875; x=1807793875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2BKXwGlQdAGj6DmioexaKwuxqrJSh3vgNJu/czIJiXk=;
  b=D+vJCZb7LfzxR8p3o/GTyk9DPVk2m1pneGtYhX5jYKo+fYCE7e8IUVui
   mij+grm8BHQ5jLQa4U3701QmyjOSW/WwJdHv2iyAvI0UMsgmBJcfND64R
   3rCp7eh7fUGaeMHgRpmBLBpTeMlL5HCpBelg2Fm0YsUIFWlC17x4+ob0k
   Wswj04VPSjQzSfMZWYnNJTJ9GlD80GkOzv5iS7S/vQ7xwSecB7+yBs9pP
   GnALdIYEL7c/msRQVnyB+lASVWm9i6SYrtnekJW8zOisg7PD/vutmvFu3
   UObBI74N7Ow9F00nMqKIJtyOKeORCW7H8Q6IFXHmYO4PviYJd3ZcJjQgp
   Q==;
X-CSE-ConnectionGUID: k053F4enTHGis9BqhXk4cQ==
X-CSE-MsgGUID: 4fuZ9PdOR5uolAGLFYKqMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77413503"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77413503"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 05:57:54 -0700
X-CSE-ConnectionGUID: CeRzRc6oQ8K/pSCRXJnIHA==
X-CSE-MsgGUID: tg/GxUOLT3CPACJw8F54gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230266875"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 15 Apr 2026 05:57:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 0F68D95; Wed, 15 Apr 2026 14:57:51 +0200 (CEST)
Date: Wed, 15 Apr 2026 15:56:59 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: combine kzalloc + kcalloc
Message-ID: <ad-LG9g4GI3uuhrE@kuha>
References: <20260411023642.146890-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411023642.146890-1-rosenp@gmail.com>

Hi Rosen,

On Fri, Apr 10, 2026 at 07:36:42PM -0700, Rosen Penev wrote:
> A flexible array member can be used to combine allocations and simplify
> handling slightly.
> 
> Add __counted_by for extra runtime analysis.

One nitpick below.
Otherwise this looks okay to me.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 1698428654ab..8b0a3dd3f940 100644
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
> @@ -731,27 +732,26 @@ static int pmc_usb_probe(struct platform_device *pdev)
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
> +	pmc = devm_kzalloc(&pdev->dev, struct_size(pmc, port, num_ports),
> +			GFP_KERNEL);

One line is enough for that.

> +	if (!pmc)
>  		return -ENOMEM;
>  
> +	pmc->num_ports = num_ports;
> +
>  	pmc->ipc = devm_intel_scu_ipc_dev_get(&pdev->dev);
>  	if (!pmc->ipc)
>  		return -EPROBE_DEFER;
> -- 
> 2.53.0

thanks,

-- 
heikki
