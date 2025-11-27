Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43833437A
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255825; cv=none; b=WEbRZ3P6Y0uQZN/E0PybifV7AO66K1lvNYgbsIkZOqAsJcgIBlJFO5B1NuS/Mu4N5dJue4aVhPeD3wXAoye0O6NZNiI2a3wov7nZ+0QDp7Vmah9EOP/hrRTlq5x+Z3nG/pLxHlpd3fUnvoNCCpVjWLRmQDMcHgPJDntirKO4eaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255825; c=relaxed/simple;
	bh=kCEm4GR/zwNR9rHeJSjydPKPfpVvfouHJVBR53dTjws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0KIZNs3VX1LXun0pzVb1OYYK18q+emgif0iQ2CgHO5SFfNvz2jL0GRU+u9TCv+drTQfSDDoYk290RpaTLvegdSiB9bP68qUAzES7EgmhJeP8VZtyPTzZq72gPE8JfrZarXITgAYfjx/6MN4bZZbVBWSWvTCeQba52S+WQHbNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i52T/awu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i52T/awu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09084C19421
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764255825;
	bh=kCEm4GR/zwNR9rHeJSjydPKPfpVvfouHJVBR53dTjws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i52T/awuVZcFUUDHDpoSYshqmL2+RrjqYQ8heVH43ejg6qNeYk27U4sn6rKlOKRMm
	 ZEPPLyaO5ZcGv9feGe2Tsr0m17Pwox02Ch03acKBDRNPkIwJJClSvdsqFSXsPR1DHQ
	 lQyr38MOr8RuWIbtHI+v9lX3hfTjkb+TyOp6oNaV3apMjBdr7TSfHDBipgfiR4pV2G
	 wWVsdYqpzhsR6Kb8N9BKDulORuOZ7/KpETAFbsg9QRPnyrjGWFY9PdqgMUjFMbXy5f
	 KzQTxYcPINxqHYmA4CIxGvbk13gt7tbfBjX4KxmNigX6HmccrziLhsfsCftGomaQ2w
	 /hip6mQ1y4+HA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37d275cb96cso5339561fa.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 07:03:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqXcy7Tziz9VI6Oib8XSgnxOaLlHK86rTXp0GxRLOiWh9WR40h/V/QifsCqLmmjECyAR5/LUFOJ/jiU5plX+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9Rd282WwbUEqtLjb4rbKGtubl2C/HZuBUpcEwzUnq63b8g1x
	cSc/BK7neI7s8/WkmjEhr7c2886CA8owNJzR8xy3kKX7oO38cItF6wXoaeq4jj4ztsByf1Vvy/y
	s+yc+PNO8HC3jogQ8twt1Ze0uBohT2hw=
X-Google-Smtp-Source: AGHT+IE0CqLKalayP2qWN2oTCyIrY03jlnudZUHDl/nVVAo1gdGKw7f/yVfNzS4qoJo/JRyFnfd9dI/ZjLOS6526PFE=
X-Received: by 2002:a05:651c:889:b0:37c:297:8979 with SMTP id
 38308e7fff4ca-37cd928a140mr65163681fa.41.1764255823252; Thu, 27 Nov 2025
 07:03:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
 <CAMj1kXE-Qm4DQNAcg8Tg7YM4EMdLBu_UJm7M8Cpk3t5g7XqP5w@mail.gmail.com> <e996fdd5-7113-4327-a884-336dd5f77c4d@arm.com>
In-Reply-To: <e996fdd5-7113-4327-a884-336dd5f77c4d@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Nov 2025 16:03:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGyYMy2xhcdNicHkMfWBnEjyhc+xg8ciuR-6WXDxDpZxg@mail.gmail.com>
X-Gm-Features: AWmQ_bn-NrKf-eBxo6WjCr91AEF65Wk-h-Ip08zz4jH6J3ynDD4eNE08GDI4DSs
Message-ID: <CAMj1kXGyYMy2xhcdNicHkMfWBnEjyhc+xg8ciuR-6WXDxDpZxg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize kstack
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 15:18, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 27/11/2025 12:28, Ard Biesheuvel wrote:
> > On Thu, 27 Nov 2025 at 13:12, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> On 27/11/2025 09:22, Ard Biesheuvel wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> Ryan reports that get_random_u16() is dominant in the performance
> >>> profiling of syscall entry when kstack randomization is enabled [0].
> >>>
> >>> This is the reason many architectures rely on a counter instead, and
> >>> that, in turn, is the reason for the convoluted way the (pseudo-)entropy
> >>> is gathered and recorded in a per-CPU variable.
> >>>
> >>> Let's try to make the get_random_uXX() fast path faster, and switch to
> >>> get_random_u8() so that we'll hit the slow path 2x less often. Then,
> >>> wire it up in the syscall entry path, replacing the per-CPU variable,
> >>> making the logic at syscall exit redundant.
> >>
> >> I ran the same set of syscall benchmarks for this series as I've done for my
> >> series.
> >>
> >
> > Thanks!
> >
> >
> >> The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
> >> performance cost of turning it on without any changes to the implementation,
> >> then the reduced performance cost of turning it on with my changes applied, and
> >> finally cost of turning it on with Ard's changes applied:
> >>
> >> arm64 (AWS Graviton3):
> >> +-----------------+--------------+-------------+---------------+-----------------+
> >> | Benchmark       | Result Class |   v6.18-rc5 | per-task-prng | fast-get-random |
> >> |                 |              | rndstack-on |               |                 |
> >> +=================+==============+=============+===============+=================+
> >> | syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |      (R) 11.93% |
> >> |                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |      (R) 11.00% |
> >> |                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |      (R) 11.39% |
> >> +-----------------+--------------+-------------+---------------+-----------------+
> >> | syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |      (R) 10.44% |
> >> |                 | p99 (ns)     | (R) 152.81% |         1.55% |       (R) 9.94% |
> >> |                 | p99.9 (ns)   | (R) 153.67% |         1.77% |       (R) 9.83% |
> >> +-----------------+--------------+-------------+---------------+-----------------+
> >> | syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |      (R) 10.39% |
> >> |                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |      (R) 10.72% |
> >> |                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |      (R) 11.03% |
> >> +-----------------+--------------+-------------+---------------+-----------------+
> >>
> >
> > What does the (R) mean?
> >
> >> So this fixes the tail problem. I guess get_random_u8() only takes the slow path
> >> every 768 calls, whereas get_random_u16() took it every 384 calls. I'm not sure
> >> that fully explains it though.
> >>
> >> But it's still a 10% cost on average.
> >>
> >> Personally I think 10% syscall cost is too much to pay for 6 bits of stack
> >> randomisation. 3% is better, but still higher than we would all prefer, I'm sure.
> >>
> >
> > Interesting!
> >
> > So the only thing that get_random_u8() does that could explain the
> > delta is calling into the scheduler on preempt_enable(), given that it
> > does very little beyond that.
> >
> > Would you mind repeating this experiment after changing the
> > put_cpu_var() to preempt_enable_no_resched(), to test this theory?
>
> This has no impact on performance.
>

Thanks. But this is really rather surprising: what else could be
taking up that time, given that on the fast path, there are only some
loads and stores to the buffer, and a cmpxchg64_local(). Could it be
the latter that is causing so much latency? I suppose the local
cmpxchg() semantics don't really exist on arm64, and this uses the
exact same LSE instruction that would be used for an ordinary
cmpxchg(), unlike on x86 where it appears to omit the LOCK prefix.

In any case, there is no debate that your code is faster on arm64. I
also think that using prandom for this purpose is perfectly fine, even
without reseeding: with a 2^113 period and only 6 observable bits per
32 bit sample, predicting the next value reliably is maybe not
impossible, but hardly worth the extensive effort, given that we're
not generating cryptographic keys here.

So the question is really whether we want to dedicate 16 bytes per
task for this. I wouldn't mind personally, but it is something our
internal QA engineers tend to obsess over.
