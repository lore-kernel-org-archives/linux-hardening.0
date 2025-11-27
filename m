Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B132FA3E
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246494; cv=none; b=mPzHjg4suFKAFf7Fz1vvbJMaj1KpZ+XzbA920H/CFJwOX3+zBYBSFQ4iWLrtbN/ylwhOdxame2V3v2yKwfgdk4kK43KKRd9rkMib00zjTtGi+YaDjFmadM9PPt8jyY8OaLehrKCYVeQBTYln7KhfPqY35ppZsKSmoR5kofyFkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246494; c=relaxed/simple;
	bh=03x7nuNurMzXmkq+Cijj0uxU3ohs1Dneqg9mhCsCT4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXeXZO8blw9jqTZ0FrmgRuwAW3rw1r4k3jVBsLNXozxHl2hzY33j2PRF6p/QH7hM2c0QiCy5jl4CEoJez616vbeolSk27V5rN+kEzoa5lT3BMb9QSq/Gtn7ut1Iyuz62th+PS7HQrQPhhhah7238gumqHC8uYv7zyLDy6CDQBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIxB/TE6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIxB/TE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D556DC19422
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764246493;
	bh=03x7nuNurMzXmkq+Cijj0uxU3ohs1Dneqg9mhCsCT4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jIxB/TE6yV3ikaADzp8LmDFnG16uWYNvQh3C3KK4pgi0au5CXtQJhxqANcM44Dq3K
	 XH+N1szD9PZd82nBj//r1UlSCOgfPDr25X1c2Mep8muYbPdcP6+uEL+ToasuAsbxJd
	 eWZ7jNyP2s6SfkTZaY/oOavJvvCoD3G35D936oHoDboFZqaHCsmLKB6X2NS96gszY3
	 ecNBfxdqH5P7/1GZP9A2bLT9B5NsaMP6fR0jUb7R+5tcqEL+0khJ942oDHM2xX0tba
	 gnLka99Qpg4Jwtx/DFlujM4IejZElJbN9J6N46F64Zx4b88xqnYvkAIsiJ6LBgifWj
	 QfgrgKvRRICDg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37d056f5703so8204461fa.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 04:28:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzYZIc6k4MG1B0HjKnstLHBPPrdqerGaYRn7z0OpQb6+TNTK74cfUG28P9RCmMTMf9SRRpMECBbe1vUp0+Z4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmc+XJoSlfNBQOjTrhc7TMcMp9gNRVJWQLIlRK3fJx+TqjN36
	/H58CdANO7EymZn/4Mdb6m5rEXdOQDV2q3YJCPW46OIs9k2bYDJC1WcKc6wi+X0aPxshApJ7x/u
	aR6x4Y5Np0M0qAds2rAncQ/RpHUH6+q4=
X-Google-Smtp-Source: AGHT+IFA0+PVUE0F6GGRF9ajKJXJy+eXvu7hElIL5Rsb4T68yBbHrCsHP9TXWsdWPmFgB2o9+/fhUKUChfOh4FuHvio=
X-Received: by 2002:a2e:a305:0:b0:37a:3963:ce8f with SMTP id
 38308e7fff4ca-37cd9277728mr58817541fa.33.1764246492134; Thu, 27 Nov 2025
 04:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
In-Reply-To: <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Nov 2025 13:28:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE-Qm4DQNAcg8Tg7YM4EMdLBu_UJm7M8Cpk3t5g7XqP5w@mail.gmail.com>
X-Gm-Features: AWmQ_bkvQdGVqMLdFK4tLi9RnqueG0TpDGy18JbPzbYmag-P5jYjqDApAz03hgo
Message-ID: <CAMj1kXE-Qm4DQNAcg8Tg7YM4EMdLBu_UJm7M8Cpk3t5g7XqP5w@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize kstack
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 13:12, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 27/11/2025 09:22, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Ryan reports that get_random_u16() is dominant in the performance
> > profiling of syscall entry when kstack randomization is enabled [0].
> >
> > This is the reason many architectures rely on a counter instead, and
> > that, in turn, is the reason for the convoluted way the (pseudo-)entropy
> > is gathered and recorded in a per-CPU variable.
> >
> > Let's try to make the get_random_uXX() fast path faster, and switch to
> > get_random_u8() so that we'll hit the slow path 2x less often. Then,
> > wire it up in the syscall entry path, replacing the per-CPU variable,
> > making the logic at syscall exit redundant.
>
> I ran the same set of syscall benchmarks for this series as I've done for my
> series.
>

Thanks!


> The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
> performance cost of turning it on without any changes to the implementation,
> then the reduced performance cost of turning it on with my changes applied, and
> finally cost of turning it on with Ard's changes applied:
>
> arm64 (AWS Graviton3):
> +-----------------+--------------+-------------+---------------+-----------------+
> | Benchmark       | Result Class |   v6.18-rc5 | per-task-prng | fast-get-random |
> |                 |              | rndstack-on |               |                 |
> +=================+==============+=============+===============+=================+
> | syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |      (R) 11.93% |
> |                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |      (R) 11.00% |
> |                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |      (R) 11.39% |
> +-----------------+--------------+-------------+---------------+-----------------+
> | syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |      (R) 10.44% |
> |                 | p99 (ns)     | (R) 152.81% |         1.55% |       (R) 9.94% |
> |                 | p99.9 (ns)   | (R) 153.67% |         1.77% |       (R) 9.83% |
> +-----------------+--------------+-------------+---------------+-----------------+
> | syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |      (R) 10.39% |
> |                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |      (R) 10.72% |
> |                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |      (R) 11.03% |
> +-----------------+--------------+-------------+---------------+-----------------+
>

What does the (R) mean?

> So this fixes the tail problem. I guess get_random_u8() only takes the slow path
> every 768 calls, whereas get_random_u16() took it every 384 calls. I'm not sure
> that fully explains it though.
>
> But it's still a 10% cost on average.
>
> Personally I think 10% syscall cost is too much to pay for 6 bits of stack
> randomisation. 3% is better, but still higher than we would all prefer, I'm sure.
>

Interesting!

So the only thing that get_random_u8() does that could explain the
delta is calling into the scheduler on preempt_enable(), given that it
does very little beyond that.

Would you mind repeating this experiment after changing the
put_cpu_var() to preempt_enable_no_resched(), to test this theory?
