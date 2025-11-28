Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C92ECE97
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764324434; cv=none; b=poEj7oOTFduz7gWGaJ+KWMDzoCgXa5eC+v2RQUZea2ruuAUs+hiCZqXJM9CgbUBHbM3CNI4tgzx7vpUwwTHlWyt00vv6gyU0IfoX/Lm8Jrcn1DvugsFQFgAVgGY8DtYEyFtnI5zfrznhQA3Ksd3MLbsXEg7LGFA5ZUR02zD4CIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764324434; c=relaxed/simple;
	bh=DcI3SqYd60/jLU6X61RjF6uGbetJVnz0CM4nTUTStm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzcpMg4UkmE/ho2fnfFvbhekwdkHJG3YIUhwph53aLDqq+Wo0uZMdGYdYy7QRaQ99WTTA37LA9eaccNQCW15DOhO7miTIZ9iDShF2LNCqbclIpIg0gbbZvphYHAAEuFnS9S+95/3dfUWB0c++kCBV3d+meCIMrTwX3gzLEVULHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUE2ZSj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUE2ZSj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3B5C4AF09
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764324433;
	bh=DcI3SqYd60/jLU6X61RjF6uGbetJVnz0CM4nTUTStm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RUE2ZSj9bBkQcMwhtOk56eQ8oAEEvDKU7+ybwKKR9GQ5wm+Tl1aVZrcInBlC+m/NX
	 WCkdDSRLolth+UEmNEnhnSrjTsTulRLDTSyputPd4H3uMK4tS3uCUN9hDq0LQ3izqG
	 tfjT5mwQzGnkPCE993/7olTApfXHIlTH/4qNkSpBAFEnaHmXOlVs0Tgo/s2P1fAdun
	 RGRuezKZv0CLTdDJF1KZP+yWO2LMC+5j+x2zEW//QWWHDhgr2HUEgLoxrnS52+l3rd
	 xsF6BOcOQiNBqzZ3UApzT1798kvXO3tunvjeBYnRS9N0vV8ic3pbfpgF45MHNSjiOi
	 iNyT8rZBqHwiA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5957e017378so1927740e87.3
        for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 02:07:13 -0800 (PST)
X-Gm-Message-State: AOJu0YyNRuIf22CPmVIN8421Z+3hndBLwahw/zJfPJs9VZqbwJqbXemC
	TnQ18vX+YkFSWtgYyKDD9+t7Ed5sbjaw86L628EB3YLwK4RjiYzgrTqPFoQXRXLTUgZ13vs4evY
	i/cwpUfik/SFf+tGqjCHa+CVKVP/Ri24=
X-Google-Smtp-Source: AGHT+IGZBMJ2mGE6v7bB0x5twczN9e3Um2hxW0AgYCKawZoApNZZh6zfoAi5b33de18LPEabr1Ll62ey1P5tZLGjnQ4=
X-Received: by 2002:a05:6512:2398:b0:594:2654:5e65 with SMTP id
 2adb3069b0e04-596a3edac23mr9083046e87.26.1764324432079; Fri, 28 Nov 2025
 02:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
 <CAMj1kXE-Qm4DQNAcg8Tg7YM4EMdLBu_UJm7M8Cpk3t5g7XqP5w@mail.gmail.com>
 <e996fdd5-7113-4327-a884-336dd5f77c4d@arm.com> <CAMj1kXGyYMy2xhcdNicHkMfWBnEjyhc+xg8ciuR-6WXDxDpZxg@mail.gmail.com>
 <f95593ac-d4cf-4e06-9a94-cc5133897c59@arm.com>
In-Reply-To: <f95593ac-d4cf-4e06-9a94-cc5133897c59@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 28 Nov 2025 11:07:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE8msLjM83iKLQjRSQ+4cqj4iFS_CLxwfjj6adZ_AUBVg@mail.gmail.com>
X-Gm-Features: AWmQ_bnzkSjqH55aYCETk5GnAT95A5Up3auoNkGs2YlbYjrebvcPZ3Gi6rtSDTg
Message-ID: <CAMj1kXE8msLjM83iKLQjRSQ+4cqj4iFS_CLxwfjj6adZ_AUBVg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize kstack
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 16:57, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 27/11/2025 15:03, Ard Biesheuvel wrote:
> > On Thu, 27 Nov 2025 at 15:18, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> On 27/11/2025 12:28, Ard Biesheuvel wrote:
> >>> On Thu, 27 Nov 2025 at 13:12, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>>>
> >>>> On 27/11/2025 09:22, Ard Biesheuvel wrote:
> >>>>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>>>
> >>>>> Ryan reports that get_random_u16() is dominant in the performance
> >>>>> profiling of syscall entry when kstack randomization is enabled [0].
> >>>>>
> >>>>> This is the reason many architectures rely on a counter instead, and
> >>>>> that, in turn, is the reason for the convoluted way the (pseudo-)entropy
> >>>>> is gathered and recorded in a per-CPU variable.
> >>>>>
> >>>>> Let's try to make the get_random_uXX() fast path faster, and switch to
> >>>>> get_random_u8() so that we'll hit the slow path 2x less often. Then,
> >>>>> wire it up in the syscall entry path, replacing the per-CPU variable,
> >>>>> making the logic at syscall exit redundant.
> >>>>
> >>>> I ran the same set of syscall benchmarks for this series as I've done for my
> >>>> series.
> >>>>
> >>>
> >>> Thanks!
> >>>
> >>>
> >>>> The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
> >>>> performance cost of turning it on without any changes to the implementation,
> >>>> then the reduced performance cost of turning it on with my changes applied, and
> >>>> finally cost of turning it on with Ard's changes applied:
> >>>>
> >>>> arm64 (AWS Graviton3):
> >>>> +-----------------+--------------+-------------+---------------+-----------------+
> >>>> | Benchmark       | Result Class |   v6.18-rc5 | per-task-prng | fast-get-random |
> >>>> |                 |              | rndstack-on |               |                 |
> >>>> +=================+==============+=============+===============+=================+
> >>>> | syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |      (R) 11.93% |
> >>>> |                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |      (R) 11.00% |
> >>>> |                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |      (R) 11.39% |
> >>>> +-----------------+--------------+-------------+---------------+-----------------+
> >>>> | syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |      (R) 10.44% |
> >>>> |                 | p99 (ns)     | (R) 152.81% |         1.55% |       (R) 9.94% |
> >>>> |                 | p99.9 (ns)   | (R) 153.67% |         1.77% |       (R) 9.83% |
> >>>> +-----------------+--------------+-------------+---------------+-----------------+
> >>>> | syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |      (R) 10.39% |
> >>>> |                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |      (R) 10.72% |
> >>>> |                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |      (R) 11.03% |
> >>>> +-----------------+--------------+-------------+---------------+-----------------+
> >>>>
> >>>
> >>> What does the (R) mean?
> >>>
> >>>> So this fixes the tail problem. I guess get_random_u8() only takes the slow path
> >>>> every 768 calls, whereas get_random_u16() took it every 384 calls. I'm not sure
> >>>> that fully explains it though.
> >>>>
> >>>> But it's still a 10% cost on average.
> >>>>
> >>>> Personally I think 10% syscall cost is too much to pay for 6 bits of stack
> >>>> randomisation. 3% is better, but still higher than we would all prefer, I'm sure.
> >>>>
> >>>
> >>> Interesting!
> >>>
> >>> So the only thing that get_random_u8() does that could explain the
> >>> delta is calling into the scheduler on preempt_enable(), given that it
> >>> does very little beyond that.
> >>>
> >>> Would you mind repeating this experiment after changing the
> >>> put_cpu_var() to preempt_enable_no_resched(), to test this theory?
> >>
> >> This has no impact on performance.
> >>
> >
> > Thanks. But this is really rather surprising: what else could be
> > taking up that time, given that on the fast path, there are only some
> > loads and stores to the buffer, and a cmpxchg64_local(). Could it be
> > the latter that is causing so much latency? I suppose the local
> > cmpxchg() semantics don't really exist on arm64, and this uses the
> > exact same LSE instruction that would be used for an ordinary
> > cmpxchg(), unlike on x86 where it appears to omit the LOCK prefix.
> >
> > In any case, there is no debate that your code is faster on arm64.
>
> The results I have for x86 show it's faster than the rdtsc too, although that's
> also somewhat surprising. I'll run your series on x86 to get the equivalent data.
>

OK, brown paper bag time ...

I swapped the order of the 'old' and 'new' cmpxchg64_local()
arguments, resulting in some very odd behavior. I think this explains
why the tail latency was eliminated entirely, which is bizarre.

The speedup is also more modest now (~2x), which may still be
worthwhile, but likely insufficient for the kstack randomization case.

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=lockless-random-v2
