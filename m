Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8F35A384;
	Tue, 16 Jun 2026 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602802; cv=none; b=BG33iHaMpYAj3fnCWad8RvXyLu7+/FUw3tYOS8NPaB+NSLIx/+kRZekdIaWMpfSOrwfgmU9aY0jOzZ3ArkiuvZQ19IlGPUW7GuqZ63mjgVwKq8ClqzW9cTN80X10gqQRHlw3rwcfqX1Jjfh8wsmCrsrLHMvhVxlO9iEQ96IEjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602802; c=relaxed/simple;
	bh=9jhTj6tFzD8EGYUhAZ6WkJNSiBDdnjQ7jTcA3d6ut50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZMLKsfBNy+W6UaQ9PN+3zUuPT2ZEbXRlgbnUj21zt3a77hAjO0VHCkZ8dgUh7mX/CFJDmptnEQ8WJ8T47qFRWTod7A9Mes5qxk3bcvWXygJHXmBadE1NnnKn2tQ3h5yNHF4Rzh6NCXdY3o3/09IiClPChiAyjyiRGdZIO5UaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oyTJNc+o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uwu7cFSQ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oyTJNc+o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uwu7cFSQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E068BEC0166;
	Tue, 16 Jun 2026 05:39:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 16 Jun 2026 05:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781602799; x=1781689199; bh=deZHG6C7cD
	lUnSSZ206KUZWnoKKAAkKaAcQuz04M5Wo=; b=oyTJNc+oeqBaX8yAURFJWKd8Ti
	eLo+XJoUqi7MwXx8NlHiCISG4csTXoQLwBke4QavCnMgXfxGo65J8GfwQZ8lNGgc
	JMBR8jiPghrqraCyJah5YkXU+h/GIHP5QsrFq6lI0g1OoQnIoi9Ac79dYf8sSlWK
	7WDq9yqXW+tmXa3t/WeeRgz5MvfDy5FGCIYg4a/ic1Kv3hYr0EufDZ3iohvbsdWb
	8rBBqzyM6km7ovxxl+Y01IbeJa1so/C+8fvmpamUOqg04atkOA+vQ7FUsEmGbXGa
	FN1DRYayPu6b+rHoFvUmTPc4lPBmwcECo2Rh2RAXdscTWi9RpTESEmR0Gh+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781602799; x=1781689199; bh=deZHG6C7cDlUnSSZ206KUZWnoKKAAkKaAcQ
	uz04M5Wo=; b=Uwu7cFSQWgdQMzcM5Jnhb59yh6ECRQKgn2qs+cMlkIc3sci6wOT
	/x0PBi+xM2TYij66BsBATPC0M2axRyj4lZdS8m1iG6ab3dwF6qNotFshR/qEs4GK
	RXHjX0OEN8YP50iQdyZjdxqbOXO/QbOGYm/naPZKqBKOb5r/rvrknwQ4wNLu7txr
	sOMHD3D4QL2ChZdutS6GcI8Rdm6aJ1cPNfnsyk64S1HY3RklZzGo9SvPPn0nD6kX
	xk4gGb7Z7U8cLWsjMtxoNcUm36PQfErIfW1N4reeMQU55wjtAwruQVXnUvHZ2IVF
	ZQvdFPLThRTWwrtmzVc5MvyMjDEmzk4us0w==
X-ME-Sender: <xms:7xkxaguvZNemZxsnjbaQ_2lKCSizv1Y_igR2osVu38A3qHNPpIcW_Q>
    <xme:7xkxalp6uNWqSV7oXNZzwOmy1uk2FJQbiHqyNCGA0M8NdvLVUXFuOdih6l1Y2BDjW
    mRvqo_pS8YQMjvBhjg73UDKjjYEsGuraf80pAqnPmKvNFrC>
X-ME-Received: <xmr:7xkxanW26x0BWrJj3GzJA71R0c642UpRivgpEFVhLNQcYVwFHniOjXNm>
X-ME-Proxy-Cause: dmFkZTGJcXST+37Y5YSvjjCo4KOYRNk/D1h17spIXaiFAbHzBHNIbh7ltm74MWcBYtk/bP
    zYSXJoAOFHXMa72lB3eONzgwfNg67PDxd82Og39ZMXYL5cVH0y6g47vVdEa/YdXB3any9N
    mNj7HafJw3QcBl+zgKab/3yN9qh+ryUJ+NwVcbE95FTIoDcehpkcvSEI0wEjptTQY7cZg0
    IeLs9jnb7jhk/vfZtO5vcmwVVW9QfeROeJIoeXGKmQxyazVzc1RHaHcBXfCOAV+DcZSmMy
    oJqsK2Uh4Thaakh0UwXmJauCKp6uPcvtaNYIGqEdpTjs690pbKCd8eCIHq/R0ksBuNvIN3
    9nGHK17rF9E56cvXmf8bcLhnW3nXuG7x1vhDu18hD1ig/NZVKcYw3o/Ep7JwQw18Uh1Gwb
    gTYpZ4IUR8TBZHaresAORBlYMaE/c8XrJIJzelmVY2ND7P/vlTu7oaPLGeyMFDNH2VSN/g
    doV0+jn+X2NmzwukkbAhhRrXb2sqdJtFZlfk1Y749OvPx0nBgfzhw+gr4C5jBD/vA1zTSM
    9D119ovyUJA/ga5osodswH3uMl4QJYhaPxRaVKUyfy4dYgoXlIaEjSheru5Z0IQ5mk6Yff
    tmH1fEQmeKm/zgfYD8GY1DyE0pBJrOg/XRZzv/w8Zd+KqKIeDHrg8mnvZ5Vw
X-ME-Proxy: <xmx:7xkxat1Tno_BxQDv84xQEXHO3_hj4DTO-VdJFmkWkN_PUrBOzzW7pg>
    <xmx:7xkxasuGzFITkR-caunLDmyrLIb9El8Edb-IXZNHYxUL3J6TAFnXxQ>
    <xmx:7xkxalWZOEbrbHQz8ttdZQbUY23bOkSdo1sMcw19L21LgWSxTkAriQ>
    <xmx:7xkxakzCAqBN0f-c7FrrqMrzSJajnUtJlLSc9Eaz8liIfFtX2tG1Iw>
    <xmx:7xkxanhbwBIoLUPEN1AbeeP4EevlphYipC0iI3iFf66XrclMLal1z26J>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 05:39:58 -0400 (EDT)
Date: Tue, 16 Jun 2026 15:08:53 +0530
From: Greg KH <greg@kroah.com>
To: Enlin Mu <enlin.mu@linux.dev>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] genirq: Add the entropy pool function to the PPI
 interrupt handler
Message-ID: <2026061641-unblock-pursuant-7e82@gregkh>
References: <20260616081730.4035-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616081730.4035-1-enlin.mu@linux.dev>

On Tue, Jun 16, 2026 at 04:17:30PM +0800, Enlin Mu wrote:
> Accelerate the entropy pool initialization process.
> The function handle_irq_event_percpu adds entropy pool
> initialization, but this logic is missing in the PPI interrupt handler.
> I think this was simply an accidental omission.
> 
> Signed-off-by: Enlin Mu <enlin.mu@linux.dev>
> ---
>  kernel/irq/chip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index de754db414d1..cbbd7e7d1156 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -926,6 +926,7 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
>  		trace_irq_handler_entry(irq, action);
>  		res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
>  		trace_irq_handler_exit(irq, action, res);
> +		add_interrupt_randomness(irq);
>  	} else {
>  		bool enabled = cpumask_test_cpu(cpu, desc->percpu_enabled);
>  
> -- 
> 2.39.5
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
