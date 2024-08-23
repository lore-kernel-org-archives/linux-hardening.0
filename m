Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20A38389;
	Fri, 23 Aug 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409962; cv=none; b=K1dRB6lDHHt7CKwmNYu+a97BjBQ2m2Zb/iN57FvSh74T/ne5zugyRo0ylFVyMooSsXPU527J1mxr/7/Mhbvi31M63kbXBylQaMgYPH8fygEYBdegH13QHQZlWhg/Zn0MzqguHiPFTvrgLBGkOcIhvO7rwBZIggCIe1DXYSTSrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409962; c=relaxed/simple;
	bh=LsNwryL4D4cEnfjSJUgR2u1heISZxF4oMLMF+8a0FfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4C8hxcWNAZ25hP1wXMACXlxx+GTFF4HgDfeiFi85wr0cSSo/lCdQbY7KVsL7MHIaJPxv5rPLWGjS4RC/svdqTpUMAgoXePtrPrtOo6B9zQ0WTvPeXItyes94TNeLbavkeFRKbMgFq6ljolIDCey/yYIa24SNUF6hdJlhcCccoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK/5VEqE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK/5VEqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41A7C32786;
	Fri, 23 Aug 2024 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724409960;
	bh=LsNwryL4D4cEnfjSJUgR2u1heISZxF4oMLMF+8a0FfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK/5VEqEc/3Pj7QI5DRa0etTJxeZ2bj2pbbA9ODIq/pL7N80sxtTebnp2OPHw+4jb
	 bIJbKJdxxI7K/7dW6bROozJr0MC6xJtp0i54RQKOSEiHtQtmDIDS2GqqCQKRlJtVxx
	 XGZkWLMSquhyIR/xjJBFUrKeBjGkDFTItupPVMmEZQiHdT43QgAcLJfn4Cpn/fK982
	 s1fBrOiT3mvotVg5YFRrse9dQxbVGHgGptfYar0UXPdrSfm53egulnDRjymi9666eL
	 HBbTFQ+Ir3Rf6Tjst1TyH5370KNqLfDpfDhGiHQ2kU82TIhEJyKGZSO7yb73wQFxap
	 osOby9xsh9EVg==
Date: Fri, 23 Aug 2024 11:45:53 +0100
From: Will Deacon <will@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Yu Zhao <yuzhao@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Marc Zyngier <maz@kernel.org>, Sumit Garg <sumit.garg@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kees Cook <kees@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
Message-ID: <20240823104552.GB31866@willie-the-truck>
References: <20240821145353.v3.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821145353.v3.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Doug,

On Wed, Aug 21, 2024 at 02:53:57PM -0700, Douglas Anderson wrote:
> When testing hard lockup handling on my sc7180-trogdor-lazor device
> with pseudo-NMI enabled, with serial console enabled and with kgdb
> disabled, I found that the stack crawls printed to the serial console
> ended up as a jumbled mess. After rebooting, the pstore-based console
> looked fine though. Also, enabling kgdb to trap the panic made the
> console look fine and avoided the mess.

Just a small nit:

>  	while (num_other_online_cpus() && timeout--)
>  		udelay(1);
>  
> -	if (num_other_online_cpus())
> +	/*
> +	 * If CPUs are still online, try an NMI. There's no excuse for this to
> +	 * be slow, so we only give them an extra 10 ms to respond.
> +	 */
> +	if (num_other_online_cpus() && ipi_should_be_nmi(IPI_CPU_STOP_NMI)) {

We probably want an smp_rmb() here...

> +		cpumask_copy(&mask, cpu_online_mask);
> +		cpumask_clear_cpu(smp_processor_id(), &mask);
> +
> +		pr_info("SMP: retry stop with NMI for CPUs %*pbl\n",
> +			cpumask_pr_args(&mask));
> +
> +		smp_cross_call(&mask, IPI_CPU_STOP_NMI);
> +		timeout = USEC_PER_MSEC * 10;
> +		while (num_other_online_cpus() && timeout--)
> +			udelay(1);
> +	}
> +
> +	if (num_other_online_cpus()) {


... and again here, just to make sure that the re-read of cpu_online_mask
is ordered after the read of __num_online_cpus in num_other_online_cpus().

I can add those when applying.

Will
