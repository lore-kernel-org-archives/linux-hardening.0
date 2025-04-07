Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65052218AC0;
	Mon,  7 Apr 2025 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053337; cv=none; b=hfsfb56f33Qg+G0c3ILdXV0/HBhs6cUH6s4TWywNMAe5bN/7rzQ8WQNOLXmBvgvpNMItIEwSkkVDc6CJzdhfs/oYvCUBA5yFRVVm5nedJBGHEZT1/A37L4pVacGGosaM7YRT/HaSuzdQShOc3q73ZUB9roP7/nz+66v0wGGESbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053337; c=relaxed/simple;
	bh=hxg2O97nhJEMTUifQxQe0JJOBUMNYX7A6anLVkt8mH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhdpN5yvRN8LziPnvTjqAtCzkEJ1EoyjdunbFfaotSdj5M3iwHCctVnwvSLuL02gHDsJSYDo3KhfjcQqbvNAgTTWJussi3AGJIgw4vW6RokVHujhYo1qwBDOYuvMvH5PzVKuU+8FsZUsLgJ9wkzJb/rWu2g80b11ZMY86ODKgwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWWMZqiX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWWMZqiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC695C4CEDD;
	Mon,  7 Apr 2025 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744053336;
	bh=hxg2O97nhJEMTUifQxQe0JJOBUMNYX7A6anLVkt8mH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWWMZqiXjrEcG3bN+DFn3FBBHEaK/Soq+leOdAhafI52W7F+sxZpL1mvgP7wdupHy
	 Pp7P49/m1ntny5pFWwLP9LKVNkgI41AVLEV7ouqGaaSFrKa9qTZ1z165Ns7z/eJOtD
	 vHsZLSz2f+yElA56l4B/7xPqIGHjXb7IFimvY4b2TNx9P/V7gHUfZm0B5PS2NI588c
	 JRSNCzDoq3lb90RJdA60SU5mIay6gugvI4a7LAv3/6JmvhTz83Bmxn9D0Y5oxJ7N5j
	 5CeO+5yIwOTg0w4kKon4G1nhzXuo2mQYYTUXfACvScGBpMK4G+KAQqLnrjJhifLCtC
	 4V+MzeLYADJew==
Date: Mon, 7 Apr 2025 12:15:33 -0700
From: Kees Cook <kees@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: ehci-fsl: Fix use of private data to avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <202504071215.DED5FA3535@keescook>
References: <Z-R9BcnSzrRv5FX_@kspp>
 <1e82761e-8554-4168-8feb-561abbe49f7e@rowland.harvard.edu>
 <8139e4cc-4e5c-40e2-9c4b-717ad3215868@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8139e4cc-4e5c-40e2-9c4b-717ad3215868@rowland.harvard.edu>

On Thu, Mar 27, 2025 at 03:31:15PM -0400, Alan Stern wrote:
> In the course of fixing up the usages of flexible arrays, Gustavo
> submitted a patch updating the ehci-fsl driver.  However, the patch
> was wrong because the driver was using the .priv member of the
> ehci_hcd structure incorrectly.  The private data is not supposed to
> be a wrapper containing the ehci_hcd structure; it is supposed to be a
> sub-structure stored in the .priv member.
> 
> Fix the problem by replacing the ehci_fsl structure with
> ehci_fsl_priv, containing only the private data, along with a suitable
> conversion macro for accessing it.  This removes the problem of having
> data follow a flexible array member.

Thanks for figuring out the right solution! :)

> 
> Reported-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Link: https://lore.kernel.org/linux-usb/Z-R9BcnSzrRv5FX_@kspp/

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> 
> ---
> 
>  drivers/usb/host/ehci-fsl.c |   25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> Index: usb-devel/drivers/usb/host/ehci-fsl.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/host/ehci-fsl.c
> +++ usb-devel/drivers/usb/host/ehci-fsl.c
> @@ -410,15 +410,13 @@ static int ehci_fsl_setup(struct usb_hcd
>  	return retval;
>  }
>  
> -struct ehci_fsl {
> -	struct ehci_hcd	ehci;
> -
> -#ifdef CONFIG_PM
> +struct ehci_fsl_priv {
>  	/* Saved USB PHY settings, need to restore after deep sleep. */
>  	u32 usb_ctrl;
> -#endif
>  };
>  
> +#define hcd_to_ehci_fsl_priv(h) ((struct ehci_fsl_priv *) hcd_to_ehci(h)->priv)
> +
>  #ifdef CONFIG_PM
>  
>  #ifdef CONFIG_PPC_MPC512x
> @@ -566,17 +564,10 @@ static inline int ehci_fsl_mpc512x_drv_r
>  }
>  #endif /* CONFIG_PPC_MPC512x */
>  
> -static struct ehci_fsl *hcd_to_ehci_fsl(struct usb_hcd *hcd)
> -{
> -	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> -
> -	return container_of(ehci, struct ehci_fsl, ehci);
> -}
> -
>  static int ehci_fsl_drv_suspend(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
> -	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
> +	struct ehci_fsl_priv *priv = hcd_to_ehci_fsl_priv(hcd);
>  	void __iomem *non_ehci = hcd->regs;
>  
>  	if (of_device_is_compatible(dev->parent->of_node,
> @@ -589,14 +580,14 @@ static int ehci_fsl_drv_suspend(struct d
>  	if (!fsl_deep_sleep())
>  		return 0;
>  
> -	ehci_fsl->usb_ctrl = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> +	priv->usb_ctrl = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
>  	return 0;
>  }
>  
>  static int ehci_fsl_drv_resume(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
> -	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
> +	struct ehci_fsl_priv *priv = hcd_to_ehci_fsl_priv(hcd);
>  	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
>  	void __iomem *non_ehci = hcd->regs;
>  
> @@ -612,7 +603,7 @@ static int ehci_fsl_drv_resume(struct de
>  	usb_root_hub_lost_power(hcd->self.root_hub);
>  
>  	/* Restore USB PHY settings and enable the controller. */
> -	iowrite32be(ehci_fsl->usb_ctrl, non_ehci + FSL_SOC_USB_CTRL);
> +	iowrite32be(priv->usb_ctrl, non_ehci + FSL_SOC_USB_CTRL);
>  
>  	ehci_reset(ehci);
>  	ehci_fsl_reinit(ehci);
> @@ -671,7 +662,7 @@ static int ehci_start_port_reset(struct
>  #endif /* CONFIG_USB_OTG */
>  
>  static const struct ehci_driver_overrides ehci_fsl_overrides __initconst = {
> -	.extra_priv_size = sizeof(struct ehci_fsl),
> +	.extra_priv_size = sizeof(struct ehci_fsl_priv),
>  	.reset = ehci_fsl_setup,
>  };
>  

-- 
Kees Cook
