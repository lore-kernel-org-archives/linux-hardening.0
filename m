Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CEC33D6C7;
	Tue, 16 Jun 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594726; cv=none; b=aw4/PHTnmG/yKUVW4y9cIg+gid7nEL9AMEQkTTROPx+BMmzcw4ORmlo1ppasWWu4lp/l98G7N1hT8BlNFZSYIyCjVZJbG5jX4g4niUMw4Toggo2D7gvDySaUiuG+g0dxpMUjI+m5KLblQwLVBkgKEtb/oCtK7viKCG1oe0usPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594726; c=relaxed/simple;
	bh=gI88HOhzZ1oaEsvfBR4jBWymRbUdJ52xl0pXFvF4DZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQK3CpqYCY/FqY+s+kqMIB4DkPK0Pw0nqjqLdIO+Wjbhe92t794r16vGR7VVuMN9JSiR2Bhq+r/nYk4jqTnI1C9bvQDLpiVPwLanlLJPh1Vakw+7FQ4ej9hgZH4VCQejVkekcker8jipWrAO0XoT+KY5Fe73pdmYR5nM2FT/f6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vs1T7SRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vs1T7SRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDCB1F000E9;
	Tue, 16 Jun 2026 07:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781594725;
	bh=sMgFomzFTjIJus5jAth5zccoRgpLx+7XHGqAU3R8/1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vs1T7SRH0jK67YmjNmA6Ko98Y86UKDUd5OmA38l6gh2+RS/kUnpIEzDD5tIex33W6
	 yK2lc+ZOz1535svIxD8hTxG/XGDuVVVNeKAdSgxHSItTwz/pb8nHW4bR3pca2EJGoP
	 8HUGNQcM37I4/sfCGLme0qOf3xxzet0mvmvEzXXI=
Date: Tue, 16 Jun 2026 12:54:20 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: "enlin.mu" <enlin.mu@linux.dev>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] genirq: Add the entropy pool function to the PPI
 interrupt handler
Message-ID: <2026061633-preseason-framing-7acc@gregkh>
References: <20260616055042.3923-1-enlin.mu@linux.dev>
 <2026061620-unselfish-barber-c467@gregkh>
 <476066de-b7e0-4400-a9e1-17b045defa80@linux.dev>
 <2026061658-unable-rarity-3253@gregkh>
 <1ec9d261-1f42-4553-8a09-0ba40c93f786@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec9d261-1f42-4553-8a09-0ba40c93f786@linux.dev>

On Tue, Jun 16, 2026 at 03:17:00PM +0800, enlin.mu wrote:
> 
> 
> On 2026/6/16 14:48, Greg KH wrote:
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> > 
> > A: No.
> > Q: Should I include quotations after my reply?
> > 
> > http://daringfireball.net/2007/07/on_top
> > 
> > On Tue, Jun 16, 2026 at 02:26:18PM +0800, enlin.mu wrote:
> > > Hi KH
> > > 
> > > hardware: raspberrypi 5
> > > 
> > > other patch(These two locations impact the entropy pool acceleration.
> > > comment them out temporarily):
> > > acer@raspberrypi:linux $ git diff drivers/of/fdt.c
> > > drivers/char/hw_random/iproc-rng200.c
> > > diff --git a/drivers/char/hw_random/iproc-rng200.c
> > > b/drivers/char/hw_random/iproc-rng200.c
> > > index 33bc28f429f6..af105faa88c6 100644
> > > --- a/drivers/char/hw_random/iproc-rng200.c
> > > +++ b/drivers/char/hw_random/iproc-rng200.c
> > > @@ -296,10 +296,10 @@ static const struct dev_pm_ops iproc_rng200_pm_ops = {
> > >   };
> > > 
> > >   static const struct of_device_id iproc_rng200_of_match[] = {
> > > -       { .compatible = "brcm,bcm2711-rng200", },
> > > -       { .compatible = "brcm,bcm7211-rng200", },
> > > -       { .compatible = "brcm,bcm7278-rng200", },
> > > -       { .compatible = "brcm,iproc-rng200", },
> > > +       { .compatible = "brcm,bcm2711-rng2000", },
> > > +       { .compatible = "brcm,bcm7211-rng2000", },
> > > +       { .compatible = "brcm,bcm7278-rng2000", },
> > > +       { .compatible = "brcm,iproc-rng2000", },
> > 
> > What is this change for?
> This driver accelerates the initialization of the entropy pool. If this
> dirver is added, the optimization effect of my patch will no longer be
> clearly observable.

Great, obviously your patch is not needed!

> 
> > 
> > 
> > >          {},
> > >   };
> > >   MODULE_DEVICE_TABLE(of, iproc_rng200_of_match);
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 331646d667b9..13308d58785d 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -1100,7 +1100,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
> > > 
> > >          rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
> > >          if (rng_seed && l > 0) {
> > > -               add_bootloader_randomness(rng_seed, l);
> > > +               //add_bootloader_randomness(rng_seed, l);
> > 
> > Why did you comment this out?
> Before the kernel boots, the Raspberry Pi bootloader injects the rng-seed
> property into the kernel's Device Tree to accelerate entropy pool
> initialization. Therefore, I need to temporarily comment this out
> to avoid interfering with the testing of my current patch.

Again, that seems like the correct fix, don't change the common code
path of all systems just because you don't want to accept the changes
that have already been made for your platform to resolve this very
issue!

thanks,

greg k-h
