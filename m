Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A315B984;
	Mon,  5 Aug 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876824; cv=none; b=k1eDC0/9E0rfI6xHmfq4ySD6D1T1M70EVLAGQx6zDTvyRmReE2MgAWmkHi3+1BuYFHxJq6hwpXZifFCCGQTw4HVUnmMBkOCnyclFoFeMfiQR0DgcgM1/argVoIvDnLuuvzynSmtLwq12C2o46FRnZ9+T7CAqcERNWj7ZhECJXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876824; c=relaxed/simple;
	bh=O/e1TO9XrHPCYZOvTdVyDlSsov3HzWpIAprXeJ2j0Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZfGyV5GXeX+xFdSceGeXIJvffKsvs+PwzjBtLSFqB5KOwJQjC9QF+hse0VRHzdixNQc073r1w4zG+Q1egnRsjaRi3mXoob9kIi99y/OubgDoQmxk9pwBf30qTUvnHxrf1Rm6hmMp0YAAE4lq5YPIi7cJqdh0ptSZsk7mOoMBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDe5k57m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDe5k57m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DEFC32782;
	Mon,  5 Aug 2024 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722876823;
	bh=O/e1TO9XrHPCYZOvTdVyDlSsov3HzWpIAprXeJ2j0Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDe5k57mYXwvivh98dsZqK0NQsuluhJHYf1GuXqNoI1DtpOQIsFWq/K2xiQtwun+s
	 TMpcB6NdrY6PSRbjutgMIttiQKOKbarh/d9Vp4PTJhZeZoFHBavELLTJBqDmmgQ34P
	 eq09Hev3WMU5/wOW2aUF5jvzJtTDUcme5ZngnSfI+GOcpnXtCicyHkMWugQba5H0xX
	 gUcIWNZx///3ZQ5HhdcpEjz6KEw/LKm5hRcIhJjxrdxafdF17E3Ulnz6ANQXo2BMlj
	 Wl2MDEKOZQKRZVc6/iDNY1urzbqhvAV/cTxSpzObrZIagKJFVGEy9quHGEfVWC4j6d
	 wxLC7yxbn41VQ==
Date: Mon, 5 Aug 2024 17:53:37 +0100
From: Will Deacon <will@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Sumit Garg <sumit.garg@linaro.org>, Yu Zhao <yuzhao@google.com>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Stephen Boyd <swboyd@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
	Marc Zyngier <maz@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	James Morse <james.morse@arm.com>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
Message-ID: <20240805165336.GA10196@willie-the-truck>
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Doug,

On Tue, Jun 25, 2024 at 04:07:22PM -0700, Douglas Anderson wrote:
> @@ -1084,79 +1088,87 @@ static inline unsigned int num_other_online_cpus(void)
>  
>  void smp_send_stop(void)
>  {
> +	static unsigned long stop_in_progress;
> +	cpumask_t mask;
>  	unsigned long timeout;
>  
> -	if (num_other_online_cpus()) {
> -		cpumask_t mask;
> +	/*
> +	 * If this cpu is the only one alive at this point in time, online or
> +	 * not, there are no stop messages to be sent around, so just back out.
> +	 */
> +	if (num_other_online_cpus() == 0)
> +		goto skip_ipi;
>  
> -		cpumask_copy(&mask, cpu_online_mask);
> -		cpumask_clear_cpu(smp_processor_id(), &mask);
> +	/* Only proceed if this is the first CPU to reach this code */
> +	if (test_and_set_bit(0, &stop_in_progress))
> +		return;
>  
> -		if (system_state <= SYSTEM_RUNNING)
> -			pr_crit("SMP: stopping secondary CPUs\n");
> -		smp_cross_call(&mask, IPI_CPU_STOP);
> -	}
> +	cpumask_copy(&mask, cpu_online_mask);
> +	cpumask_clear_cpu(smp_processor_id(), &mask);
>  
> -	/* Wait up to one second for other CPUs to stop */
> +	if (system_state <= SYSTEM_RUNNING)
> +		pr_crit("SMP: stopping secondary CPUs\n");
> +
> +	/*
> +	 * Start with a normal IPI and wait up to one second for other CPUs to
> +	 * stop. We do this first because it gives other processors a chance
> +	 * to exit critical sections / drop locks and makes the rest of the
> +	 * stop process (especially console flush) more robust.
> +	 */
> +	smp_cross_call(&mask, IPI_CPU_STOP);

I realise you've moved this out of crash_smp_send_stop() and it looks
like we inherited the code from x86, but do you know how this serialise
against CPU hotplug operations? I've spent the last 20m looking at the
code and I can't see what prevents other CPUs from coming and going
while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.

Will
