Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF53D891B;
	Tue, 16 Jun 2026 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589932; cv=none; b=G5nKUvrOxpGwxbOPoYuwKC7yOpN8t0b5UqLrfOOuWj/PmZyrZPmLcyDrxwFL7f3UZi00jJAGQky10Z3nmRTNIiaXijwyAKwEXHSZ2qotWlHJ+WAQQq+soVblf2dTjaRSNYJmhvHI+0rGA81B1DD5woqyQ4LtpELd3npnSfS0CiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589932; c=relaxed/simple;
	bh=A4vjL0TeHa+alMq2WSeaQ2WHRDngyLIjjL4ywSsN8oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beakp0JdNboE2gYPljN7p4e8NmOlIyG2R9WVpk7NgxwPh73IcqVMbqK/Ev5hXhLvF6o8u+AXxhC0zJhicB+eL6nrb+Smovyc/MrJsbEFM/PTyLPKh4FdPEVqJaRYDlpDst+dYQNEfsNxLGCL43Dr3JnyNqbuNJCyXugFayVyYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lkvkBgG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkvkBgG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C0C1F000E9;
	Tue, 16 Jun 2026 06:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781589931;
	bh=0A+/UVjUub362s26e2jsEAjH5zV3cgGnPa4vXTaqxyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lkvkBgG6hL6XPbW0IlwUbEsnh5t8Tyjh1vVi6eIXgk0ocr7xhsS+Hv4IrMM4lD1TW
	 eEXAiIBGk5XXnRL4mXzR9csivCXjx3LswubCPYFug0M2on6zFO/H2ay4Sxd2Njf01E
	 y/XR0/e02BzDNqkHx3lrR7aUzgNtyrNxJMIc2UuY=
Date: Tue, 16 Jun 2026 11:29:45 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Enlin Mu <enlin.mu@linux.dev>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] genirq: Add the entropy pool function to the PPI
 interrupt handler
Message-ID: <2026061620-unselfish-barber-c467@gregkh>
References: <20260616055042.3923-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616055042.3923-1-enlin.mu@linux.dev>

On Tue, Jun 16, 2026 at 01:50:42PM +0800, Enlin Mu wrote:
> Accelerate the entropy pool initialization process

How?  Please explain.

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

Are you sure this does anything measurable?

thanks,

greg k-h
