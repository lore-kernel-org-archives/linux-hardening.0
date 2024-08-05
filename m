Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2C155749;
	Mon,  5 Aug 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878667; cv=none; b=sVUK13uQPDimTM1V+5kxA4fzz+IqNMCNTsw5WwJrNIcWhIzovDepfgXB9RkGI9NFhoBtJbcfHhMu2ZvqbRXUGI6FpsjIzfLqfd9epVIOjSDPMFsPlhoGOsOzfzVKqzRLWMU4VyIWnh7TUbV+kDDEdd3qL+FmgEHHC7xBa19cF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878667; c=relaxed/simple;
	bh=BhwZCoKAbqABImXNwGTokOxmS8qDPN9fs2J0ke8rPho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDt2A2GzTzb43eremsyCLaCqd4qx5dkk1hnfwQde7hpk3n+D4SsRXN85hkez5KN2YsrBdSznQec0k+pt5PDbp0+tvOQ9Ud7bI8HqkpEns+A+AQBa4RRJZ/IEBr2U7r5hhgeZMRrsj4qbsY4vIu3zXTq7c5T9HRnvCnaolm2rN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOODQRKB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOODQRKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7D5C32782;
	Mon,  5 Aug 2024 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722878666;
	bh=BhwZCoKAbqABImXNwGTokOxmS8qDPN9fs2J0ke8rPho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lOODQRKBBSI0cDRun6Kwj33GtfxnB/tkxinhOS0UpiFvGC0bkaa2rC1k96YTEiKpV
	 PvulffuCcdBDXniPDgnqdxPyRt8knH7MAXH2WZQYWqXymhyFOMhJ5nWAetprcl72XR
	 4QTCdMGC04zSfZfo6DTxMCvlGqtFMydX7HA19Ppo0bIL8pg9+BhBhT9enAGjf6aaNR
	 qh25PbH3et2rOz/b0ZiDyif5xvomhis5iQ4S1dyIDYPj4QrCu5H+TFYwTnpqNPDtNT
	 mm/mZVe+aodcw6G0f/CaNq+vRkjxmjJpc0/qCuRSq4UutV1w9+26M1wGTx/UJ3CXDO
	 K5NThBWLunXgw==
Date: Mon, 5 Aug 2024 18:24:19 +0100
From: Will Deacon <will@kernel.org>
To: Doug Anderson <dianders@chromium.org>
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
Message-ID: <20240805172419.GD10196@willie-the-truck>
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240805165336.GA10196@willie-the-truck>
 <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 05, 2024 at 10:13:11AM -0700, Doug Anderson wrote:
> On Mon, Aug 5, 2024 at 9:53 AM Will Deacon <will@kernel.org> wrote:
> > On Tue, Jun 25, 2024 at 04:07:22PM -0700, Douglas Anderson wrote:
> > > @@ -1084,79 +1088,87 @@ static inline unsigned int num_other_online_cpus(void)
> > >
> > >  void smp_send_stop(void)
> > >  {
> > > +     static unsigned long stop_in_progress;
> > > +     cpumask_t mask;
> > >       unsigned long timeout;
> > >
> > > -     if (num_other_online_cpus()) {
> > > -             cpumask_t mask;
> > > +     /*
> > > +      * If this cpu is the only one alive at this point in time, online or
> > > +      * not, there are no stop messages to be sent around, so just back out.
> > > +      */
> > > +     if (num_other_online_cpus() == 0)
> > > +             goto skip_ipi;
> > >
> > > -             cpumask_copy(&mask, cpu_online_mask);
> > > -             cpumask_clear_cpu(smp_processor_id(), &mask);
> > > +     /* Only proceed if this is the first CPU to reach this code */
> > > +     if (test_and_set_bit(0, &stop_in_progress))
> > > +             return;
> > >
> > > -             if (system_state <= SYSTEM_RUNNING)
> > > -                     pr_crit("SMP: stopping secondary CPUs\n");
> > > -             smp_cross_call(&mask, IPI_CPU_STOP);
> > > -     }
> > > +     cpumask_copy(&mask, cpu_online_mask);
> > > +     cpumask_clear_cpu(smp_processor_id(), &mask);
> > >
> > > -     /* Wait up to one second for other CPUs to stop */
> > > +     if (system_state <= SYSTEM_RUNNING)
> > > +             pr_crit("SMP: stopping secondary CPUs\n");
> > > +
> > > +     /*
> > > +      * Start with a normal IPI and wait up to one second for other CPUs to
> > > +      * stop. We do this first because it gives other processors a chance
> > > +      * to exit critical sections / drop locks and makes the rest of the
> > > +      * stop process (especially console flush) more robust.
> > > +      */
> > > +     smp_cross_call(&mask, IPI_CPU_STOP);
> >
> > I realise you've moved this out of crash_smp_send_stop() and it looks
> > like we inherited the code from x86, but do you know how this serialise
> > against CPU hotplug operations? I've spent the last 20m looking at the
> > code and I can't see what prevents other CPUs from coming and going
> > while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.
> 
> I don't think there is anything. ...and it's not just this code
> either. It sure looks like nmi_trigger_cpumask_backtrace() has the
> same problem.
> 
> I guess maybe in the case of nmi_trigger_cpumask_backtrace() it's not
> such a big deal because:
> 1. If a CPU goes away then we'll just time out
> 2. If a CPU shows up then we'll skip backtracing it, but we were
> sending backtraces at an instant in time anyway.
> 
> In the case of smp_send_stop() it's probably fine if a CPU goes away
> because, again, we'll just timeout. ...but if a CPU shows up then
> that's not super ideal. Maybe it doesn't cause problems in practice
> but it does feel like it should be fixed.

On the other hand, I really don't fancy taking a CPU hotplug mutex on
the panic() path, so it's hard to know what's best.

I suppose one thing we could do is recompute the mask before sending the
NMI, which should make it a little more robust in that case. It still
feels fragile, but it's no worse than the existing code, I suppose.

Will
