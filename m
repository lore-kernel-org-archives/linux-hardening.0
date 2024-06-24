Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EBF13DB83;
	Mon, 24 Jun 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236990; cv=none; b=o7YlL5Fkxw+t23c6y2gcbU4exUDNEz7VkVaojBYKz245rl6cuyWKaLrq03nfV18Dh9ktJqc2rOj0EwMuxGCk2+xAallLfTNdipoqFDF2zCq4aPaTcn4/mZMEZfnya85M/D8QptCUEBGZTQjw+8VFhnWGKSW2osxu/qfqbRbJw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236990; c=relaxed/simple;
	bh=qv+sO9rJyT7X3Ase6Ba23MJ7weXgMrp7Y7LUf212Ays=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTA2ReG4qNy7Zn3zDfhahahl9+o/onNB2LoUXOx2GkuJxajlSUl3vZlAr1NLHectR+AjAODJfpKW07DmKNDzKn7tWdJ0EDVvVgfo5QPy8gXtz97S0n/UbRrDGJPGDREdQpAE6cejL7+2yLKM1AWFFGhoHSTEPKYTribXa/FyhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQtKrsQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQtKrsQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CC7C2BBFC;
	Mon, 24 Jun 2024 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719236990;
	bh=qv+sO9rJyT7X3Ase6Ba23MJ7weXgMrp7Y7LUf212Ays=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQtKrsQn0cIf4YQe2+tMuMLT1Tls8mxN2Qo8KKRP+Gka3GOel5cwisGE+rtg9bivq
	 hn+gDCjHWC7M2icRhUxjn2dKHV69PDyk40IPW4c6HNQBrBZs9RJrEU4BpLq1gSkHb9
	 Xlcshg96ii2VmiwcR+iUNOuhMA+9BV9++jIb9+Vf47fKCr7EN5yiaiSywXxRa/nisC
	 hzsFALqBqlwp/StRRSdwfTt0AqFuOpMC85npfWh15KrutP4RUGFn6llN4AeCBK7xdA
	 1gSFoQX8DJet6Py5z4+1flwJuMOWGZn22iQ/c1+8L7GDOEfiwIo4sOCR46DCI0gYlz
	 AJZ3jrrkYkZPQ==
Date: Mon, 24 Jun 2024 14:49:43 +0100
From: Will Deacon <will@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
Message-ID: <20240624134943.GA8616@willie-the-truck>
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240412135513.GA28004@willie-the-truck>
 <CAD=FV=X8-E-9Qhzdp1L_3g_P_fGmYVUh6zDoFMb7=pzN+cHg=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X8-E-9Qhzdp1L_3g_P_fGmYVUh6zDoFMb7=pzN+cHg=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, May 17, 2024 at 01:01:51PM -0700, Doug Anderson wrote:
> On Fri, Apr 12, 2024 at 6:55 AM Will Deacon <will@kernel.org> wrote:
> > On Thu, Dec 07, 2023 at 05:02:56PM -0800, Douglas Anderson wrote:
> > > In order to do this we also need a slight change in the way we keep
> > > track of which CPUs still need to be stopped. We need to know
> > > specifically which CPUs haven't stopped yet when we fall back to NMI
> > > but in the "crash stop" case the "cpu_online_mask" isn't updated as
> > > CPUs go down. This is why that code path had an atomic of the number
> > > of CPUs left. We'll solve this by making the cpumask into a
> > > global. This has a potential memory implication--with NR_CPUs = 4096
> > > this is 4096/8 = 512 bytes of globals. On the upside in that same case
> > > we take 512 bytes off the stack which could potentially have made the
> > > stop code less reliable. It can be noted that the NMI backtrace code
> > > (lib/nmi_backtrace.c) uses the same approach and that use also
> > > confirms that updating the mask is safe from NMI.
> >
> > Updating the global masks without any synchronisation feels broken though:
> >
> > > @@ -1085,77 +1080,75 @@ void smp_send_stop(void)
> > >  {
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
> > > +     cpumask_copy(to_cpumask(stop_mask), cpu_online_mask);
> > > +     cpumask_clear_cpu(smp_processor_id(), to_cpumask(stop_mask));
> >
> > I don't see what prevents multiple CPUs getting in here concurrently and
> > tripping over the masks. x86 seems to avoid that with an atomic
> > 'stopping_cpu' variable in native_stop_other_cpus(). Do we need something
> > similar?
> 
> Good point. nmi_trigger_cpumask_backtrace(), which my code was based
> on, has a test_and_set() for this and that seems simpler than the
> atomic_try_cmpxchg() from the x86 code.
> 
> If we run into that case, what do you think we should do? I guess x86
> just does a "return", though it feels like at least a warning should
> be printed since we're not doing what the function asked us to do.
> When we return there will be other CPUs running.
> 
> In theory, we could try to help the other processor along? I don't
> know how much complexity to handle here and I could imagine that
> testing some of the corner cases would be extremely hard. I could
> imagine that this might work but maybe it's too complex?
> 
> --
> 
> void smp_send_stop(void)
> {
>     unsigned long timeout;
>     static unsigned long stop_in_progress;
> 
>     /*
>      * If this cpu is the only one alive at this point in time, online or
>      * not, there are no stop messages to be sent around, so just back out.
>      */
>     if (num_other_online_cpus() == 0)
>         goto skip_ipi;
> 
>     /*
>      * If another is already trying to stop and we're here then either the
>      * other CPU hasn't sent us the IPI yet or we have interrupts disabled.
>      * Let's help the other CPU by stopping ourselves.
>      */
>     if (test_and_set_bit(0, &stop_in_progress)) {
>         /* Wait until the other inits stop_mask */
>         while (!test_bit(1, &stop_in_progress)) {
>             cpu_relax();
>             smp_rmb();
>         }
>         do_handle_IPI(IPI_CPU_STOP);
>     }
> 
>     cpumask_copy(to_cpumask(stop_mask), cpu_online_mask);
>     cpumask_clear_cpu(smp_processor_id(), to_cpumask(stop_mask));
> 
>     /* Indicate that we've initted stop_mask */
>     set_bit(1, &stop_in_progress);
>     smp_wmb();
>     ...
>     ...
> 
> --
> 
> Opinions?

I think following the x86 behaviour is probably the best place to start:
the CPU that ends up doing the IPI will spin anyway, so I don't think
there's much to gain by being pro-active on the recipient.

> > Apart from that, I'm fine with the gist of the patch.
> 
> Great. Ironically as I reviewed this patch with fresh eyes and looking
> at the things you brought up, I also found a few issues, I'll respond
> to my post myself so I have context to respond to.

Ok.

> One other question: what did you think about Daniel's suggestion to go
> straight to NMI for crash_stop? I don't feel like I have enough
> experience with crash_stop to have intuition here, but it feels like
> trying IRQ first is still better in that case, but I'm happy to go
> either way.

I don't have a strong preference, but I think I'd prefer a non-NMI first
as it feels like things ought to be more robust in that case and it
should work most of the time.

Will
