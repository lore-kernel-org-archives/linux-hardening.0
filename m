Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432862E62B3
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764326203; cv=none; b=ODIWnOic2+/M2gPBUvuTNNIQHD8aeZhadYrXzMiu3FSVGsdJRYkCYi0p+R3UOHtUhAuJRGB8HTRTOoto/VqRssoOHBx/4J5fhd20NCsmT3yFBaG97/c3K20Qtd3cbnV8GYykXum+DyCUbOqFWZ+nOrAhXOAKuitQw4Z8y6vSzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764326203; c=relaxed/simple;
	bh=EhHdmmI1N3N0X1uQJ02Rc3Q7qCv0EEOweTqO0/Q78iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLITByUVmkgKt2nKt0IGu6+hnuP9LYfvRrGOoY6YTNuELbwtgmRmKma+/UjHvOpzzVKUidMAL/Rmeq0hwqQ8XP1kfbm03FaSXHUN1tqIsKbuZcZYmo/56MqbJ310RoSCvoXZRized1BA/GM098F2vfwQi2OWc2jYycAMH0ck4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9aQvBQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9aQvBQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED39FC19423
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764326203;
	bh=EhHdmmI1N3N0X1uQJ02Rc3Q7qCv0EEOweTqO0/Q78iA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q9aQvBQL0NbWNSMG8VBdUVjiFwzGBW+dh5sLM97va+gJuo6JB4+j4xbPfjRgnOuZS
	 yJA6C4fbTE/wq3Rtl7QA2BnOtTaM2UiAmO8hSX4BgeWk9IEL2gdLjj1qC52i+wwv87
	 qzJKRotUGY5p5gU/qnXwOlivjagujqKUZtGP1h/8itzGM7Vs33NeQq4i6fHrxOFI4x
	 zG+9W6YNnZ7PrpnKg/IQoIPjwIAzE79cvxD9hIwxJPg068KjYFkdlO164xAtyJq4XR
	 G7OwrrqhTwotpZ3NpAp4wfj6bJGCDanAYrIZItO/B+S/os1Bk1P95GyvXXqFCN52Wr
	 nqEQvV5x7BzGg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37cf475a1fdso14049741fa.1
        for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 02:36:42 -0800 (PST)
X-Gm-Message-State: AOJu0YyNUkptau1QvyLXH6VO1dWCH84GfUPVa9iqrdV0HCImYn7Qaq5E
	u9J2BbPmVgjphXeLlbQ/tGRFVody2g01e2mVeewNzhube3BrCZ1lvQWafbRE64ZiiJ3YRPC7Pwn
	h1E5eaGrxmv4oxbY90eIZtlIEzVMmVwQ=
X-Google-Smtp-Source: AGHT+IEeFp+DvQfNR57BKZvOkkucP6Mp+pyisPC08iIxqkOqx44J9V+etHIbwFA6FaNj5J809+5cnmOCxmJixYVG8DY=
X-Received: by 2002:a05:651c:41c9:b0:37c:c84a:98f5 with SMTP id
 38308e7fff4ca-37d07394236mr44596401fa.0.1764326201189; Fri, 28 Nov 2025
 02:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
 <CAMj1kXE-Qm4DQNAcg8Tg7YM4EMdLBu_UJm7M8Cpk3t5g7XqP5w@mail.gmail.com>
 <e996fdd5-7113-4327-a884-336dd5f77c4d@arm.com> <CAMj1kXGyYMy2xhcdNicHkMfWBnEjyhc+xg8ciuR-6WXDxDpZxg@mail.gmail.com>
 <f95593ac-d4cf-4e06-9a94-cc5133897c59@arm.com> <CAMj1kXE8msLjM83iKLQjRSQ+4cqj4iFS_CLxwfjj6adZ_AUBVg@mail.gmail.com>
 <177c5c01-82d7-461c-93c3-2c9f7bcb3403@arm.com>
In-Reply-To: <177c5c01-82d7-461c-93c3-2c9f7bcb3403@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 28 Nov 2025 11:36:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGNMfx+uT8J4ZYppiV62-21heG1ZSoAs9Zd3yxnysMwpg@mail.gmail.com>
X-Gm-Features: AWmQ_bkbKxudMr9bR_NLbhtOY1NgXOwN1TRiRI12C4_mW-o6SD-FlSUGr1NrE70
Message-ID: <CAMj1kXGNMfx+uT8J4ZYppiV62-21heG1ZSoAs9Zd3yxnysMwpg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize kstack
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Nov 2025 at 11:32, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 28/11/2025 10:07, Ard Biesheuvel wrote:
> > On Thu, 27 Nov 2025 at 16:57, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> On 27/11/2025 15:03, Ard Biesheuvel wrote:
> >>> On Thu, 27 Nov 2025 at 15:18, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>>>
> >>>> On 27/11/2025 12:28, Ard Biesheuvel wrote:
> >>>>> On Thu, 27 Nov 2025 at 13:12, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>>>>>
> >>>>>> On 27/11/2025 09:22, Ard Biesheuvel wrote:
> >>>>>>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>>>>>
> >>>>>>> Ryan reports that get_random_u16() is dominant in the performance
> >>>>>>> profiling of syscall entry when kstack randomization is enabled [0].
> >>>>>>>
> >>>>>>> This is the reason many architectures rely on a counter instead, and
> >>>>>>> that, in turn, is the reason for the convoluted way the (pseudo-)entropy
> >>>>>>> is gathered and recorded in a per-CPU variable.
> >>>>>>>
> >>>>>>> Let's try to make the get_random_uXX() fast path faster, and switch to
> >>>>>>> get_random_u8() so that we'll hit the slow path 2x less often. Then,
> >>>>>>> wire it up in the syscall entry path, replacing the per-CPU variable,
> >>>>>>> making the logic at syscall exit redundant.
> >>>>>>
> >>>>>> I ran the same set of syscall benchmarks for this series as I've done for my
> >>>>>> series.
> >>>>>>
> >>>>>
> >>>>> Thanks!
> >>>>>
> >>>>>
> >>>>>> The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
> >>>>>> performance cost of turning it on without any changes to the implementation,
> >>>>>> then the reduced performance cost of turning it on with my changes applied, and
> >>>>>> finally cost of turning it on with Ard's changes applied:
> >>>>>>
> >>>>>> arm64 (AWS Graviton3):
> >>>>>> +-----------------+--------------+-------------+---------------+-----------------+
> >>>>>> | Benchmark       | Result Class |   v6.18-rc5 | per-task-prng | fast-get-random |
> >>>>>> |                 |              | rndstack-on |               |                 |
> >>>>>> +=================+==============+=============+===============+=================+
> >>>>>> | syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |      (R) 11.93% |
> >>>>>> |                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |      (R) 11.00% |
> >>>>>> |                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |      (R) 11.39% |
> >>>>>> +-----------------+--------------+-------------+---------------+-----------------+
> >>>>>> | syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |      (R) 10.44% |
> >>>>>> |                 | p99 (ns)     | (R) 152.81% |         1.55% |       (R) 9.94% |
> >>>>>> |                 | p99.9 (ns)   | (R) 153.67% |         1.77% |       (R) 9.83% |
> >>>>>> +-----------------+--------------+-------------+---------------+-----------------+
> >>>>>> | syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |      (R) 10.39% |
> >>>>>> |                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |      (R) 10.72% |
> >>>>>> |                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |      (R) 11.03% |
> >>>>>> +-----------------+--------------+-------------+---------------+-----------------+
> >>>>>>
> >>>>>
> >>>>> What does the (R) mean?
> >>>>>
> >>>>>> So this fixes the tail problem. I guess get_random_u8() only takes the slow path
> >>>>>> every 768 calls, whereas get_random_u16() took it every 384 calls. I'm not sure
> >>>>>> that fully explains it though.
> >>>>>>
> >>>>>> But it's still a 10% cost on average.
> >>>>>>
> >>>>>> Personally I think 10% syscall cost is too much to pay for 6 bits of stack
> >>>>>> randomisation. 3% is better, but still higher than we would all prefer, I'm sure.
> >>>>>>
> >>>>>
> >>>>> Interesting!
> >>>>>
> >>>>> So the only thing that get_random_u8() does that could explain the
> >>>>> delta is calling into the scheduler on preempt_enable(), given that it
> >>>>> does very little beyond that.
> >>>>>
> >>>>> Would you mind repeating this experiment after changing the
> >>>>> put_cpu_var() to preempt_enable_no_resched(), to test this theory?
> >>>>
> >>>> This has no impact on performance.
> >>>>
> >>>
> >>> Thanks. But this is really rather surprising: what else could be
> >>> taking up that time, given that on the fast path, there are only some
> >>> loads and stores to the buffer, and a cmpxchg64_local(). Could it be
> >>> the latter that is causing so much latency? I suppose the local
> >>> cmpxchg() semantics don't really exist on arm64, and this uses the
> >>> exact same LSE instruction that would be used for an ordinary
> >>> cmpxchg(), unlike on x86 where it appears to omit the LOCK prefix.
> >>>
> >>> In any case, there is no debate that your code is faster on arm64.
> >>
> >> The results I have for x86 show it's faster than the rdtsc too, although that's
> >> also somewhat surprising. I'll run your series on x86 to get the equivalent data.
> >>
> >
> > OK, brown paper bag time ...
> >
> > I swapped the order of the 'old' and 'new' cmpxchg64_local()
> > arguments, resulting in some very odd behavior. I think this explains
> > why the tail latency was eliminated entirely, which is bizarre.
> >
> > The speedup is also more modest now (~2x), which may still be
> > worthwhile, but likely insufficient for the kstack randomization case.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=lockless-random-v2
>
> Ahh, so we were never taking the slow path. That would definitely explain it.
>
> I had a go at running this on x86 but couldn't even get the kernel to boot on my
> AWS Sapphire Rapids instance. Unfortunately I don't have access to the serial
> console so can't tell why it failed. But I used the exact same procedure and
> baseline for other runs so the only difference is your change.
>
> I wonder if this issue somehow breaks the boot on that platform?
>

It does. That is how I noticed myself :-)

init_cea_offsets() fails to make progress because
get_random_u32_below() returns the same value every time.
Interestingly, it didn't trigger with KASLR disabled, which made the
debugging sessions all the more fun ...

> Anyway, I'll chuck this update at the benchmarks, but probably won't be until
> next week...
>

Sure. thanks.
