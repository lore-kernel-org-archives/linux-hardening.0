Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89430568D;
	Tue, 16 Jun 2026 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592552; cv=none; b=M92nuo6/rDek4aLo7E4ReOkI7sNEgLvRZnopSbuGganim5jmja/dnMULq+vh7jJTvrz7c5Z+8qKbVtHihmi2lTph/M849UsXPon+k+IBAQZt2m45eXXa6BasQCTb9xkGAClDNIQHMPnIs9APR52hLkiIggqqvzX0jdOWnU8dcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592552; c=relaxed/simple;
	bh=84yUDborR8UVPrTzjxJsOvlvq9re9fRDUelSa042F14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgNij2tZPYLgWceF/twDnf/FfPe18w+Ppz2s4GrhrkjlA2XSUAftBBJeJJFYJGJmFMKqNEITjjAmVNtdP2NdTmtPpTxgSxwky7T5zEHGWql+FdxFjQRUzhcvfjwz8tAClVqRxoteAyVt1latefTAgMXYWu9+UaG14RiDEUvvUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZEeM5ntj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZEeM5ntj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84A11F000E9;
	Tue, 16 Jun 2026 06:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781592550;
	bh=4bO6zclx3Nxa9oj+I+B+cbNi9su+lLrkuPTGIP5IHz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZEeM5ntjgQWDdxVNHdrByRTygcyNRwzMQKJl03QPjGdTt4UASS1GEcL13gFiXLo3I
	 lXqnhPNwe6FHKlOj4aqVwo8hbliDGdoQubBuyahysWtsTJZ3Zi1riptTicfzutBbJc
	 DfFlyE1WI52ylAI3dKuA0AQiWcf7GM+dYUZQUeJo=
Date: Tue, 16 Jun 2026 12:18:05 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: "enlin.mu" <enlin.mu@linux.dev>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] genirq: Add the entropy pool function to the PPI
 interrupt handler
Message-ID: <2026061658-unable-rarity-3253@gregkh>
References: <20260616055042.3923-1-enlin.mu@linux.dev>
 <2026061620-unselfish-barber-c467@gregkh>
 <476066de-b7e0-4400-a9e1-17b045defa80@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <476066de-b7e0-4400-a9e1-17b045defa80@linux.dev>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Jun 16, 2026 at 02:26:18PM +0800, enlin.mu wrote:
> Hi KH
> 
> hardware: raspberrypi 5
> 
> other patch(These two locations impact the entropy pool acceleration.
> comment them out temporarily):
> acer@raspberrypi:linux $ git diff drivers/of/fdt.c
> drivers/char/hw_random/iproc-rng200.c
> diff --git a/drivers/char/hw_random/iproc-rng200.c
> b/drivers/char/hw_random/iproc-rng200.c
> index 33bc28f429f6..af105faa88c6 100644
> --- a/drivers/char/hw_random/iproc-rng200.c
> +++ b/drivers/char/hw_random/iproc-rng200.c
> @@ -296,10 +296,10 @@ static const struct dev_pm_ops iproc_rng200_pm_ops = {
>  };
> 
>  static const struct of_device_id iproc_rng200_of_match[] = {
> -       { .compatible = "brcm,bcm2711-rng200", },
> -       { .compatible = "brcm,bcm7211-rng200", },
> -       { .compatible = "brcm,bcm7278-rng200", },
> -       { .compatible = "brcm,iproc-rng200", },
> +       { .compatible = "brcm,bcm2711-rng2000", },
> +       { .compatible = "brcm,bcm7211-rng2000", },
> +       { .compatible = "brcm,bcm7278-rng2000", },
> +       { .compatible = "brcm,iproc-rng2000", },

What is this change for?


>         {},
>  };
>  MODULE_DEVICE_TABLE(of, iproc_rng200_of_match);
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 331646d667b9..13308d58785d 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1100,7 +1100,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
> 
>         rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>         if (rng_seed && l > 0) {
> -               add_bootloader_randomness(rng_seed, l);
> +               //add_bootloader_randomness(rng_seed, l);

Why did you comment this out?


> 
>                 /* try to clear seed so it won't be found. */
>                 fdt_nop_property(initial_boot_params, node, "rng-seed");
> acer@raspberrypi:linux $
> 
> Before testing:
> acer@raspberrypi:linux $ dmesg | grep rng
> [    3.360898] random: crng init done
> 
> 
> After testing:
> acer@raspberrypi:~ $ dmesg | grep rng
> [    2.808880] random: crng init done

I think people have talked about irq "randomness" lots of time in the
past, you need to provide lots of real documentation about why this time
it is somehow "different".

thanks,

greg k-h
