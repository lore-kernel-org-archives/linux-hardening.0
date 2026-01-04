Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA2251791
	for <linux-hardening@vger.kernel.org>; Sun,  4 Jan 2026 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767567703; cv=none; b=OP6MwLlstj0sLWhFUOaI2G1eALOAOn9EiOjcRUlRYwF4xK2gqFSf/C+Rzaim3Eq7ZbcosY5+BpFMIC9o3b2+qBNQUjiT2XYYrGz+aLMBoTox7Np9Rq8g+fKahE9ob4YKCtKgsi7Ije3OVWERcXECn5cm6IZZr+gzqqwzQnIJCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767567703; c=relaxed/simple;
	bh=Dx1KQa5I1r3Fu8oJQBMaJqVN516QSYERTBkF+neq+3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k94CZr1fchKADmTqiFLGlK05JfNR8qN0ahBszeRQAgWjtkV0CKWhts6qTgsnsHuCACNYVD5OqOhv7Izjfsbn0BIN4SQCTXsyojiUp9j0ZJEHtoVcxdUpZxrRO062aKAfXEwmPmsL4YSVOaHUoYD5Zsq1H+UI8+N3vEy1FQoq3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QORpXtpr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QORpXtpr"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43246af170aso692451f8f.0
        for <linux-hardening@vger.kernel.org>; Sun, 04 Jan 2026 15:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767567700; x=1768172500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjmKR/eiCoAVpyGnbyfS9wTkl7aiV0GxbUH0ODK6l+U=;
        b=QORpXtprTzxVFjNzttfe1J+F6M5o6J8fPl5YT8zBI8gs9NXvWvLCBa5gSr/bCmUzqU
         BlZwZRymUeoa1fO13vvU3wCphRwO9YVqgLM+qzBru6MznL/uur57vJOMFceYch/jR5Mw
         jERuoW90IDdJfHJRfF3iyvlrlG2Ps352DqVpotuuLeZjLuJMTVj2hfXrj3+5yUDyejD3
         xi7H4b2kRFk+CogFRcr7uocYFL6o6sT4QhfB6ahZQpkpntdbywC2vPXgDp8cYtcG5SQ1
         nzeYZeZWz15Iyx21qT90bLvsOaI3mcCVLPPzSSkQdzZkUVuUsS8kavhHyWVQLr4zq18H
         0Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767567700; x=1768172500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qjmKR/eiCoAVpyGnbyfS9wTkl7aiV0GxbUH0ODK6l+U=;
        b=JrNErG7O008ah0hNaox4enbZX/wBDDU4QDzgmd+bMKXG0845BBkGFs4lJmxEOp5YoZ
         bmneLEdi+GPB8hNYmcSDSWbi0SRPyrLpGgo///LYsEvKIo02CYlphuEnQX7XnckpXkAi
         zFj/zskGlGNdUwwdk9nFegJdbxHRDyPcKoFmFN4otWWMlIaQKAezdhdCumMwbcxMnYZJ
         DHeplMRhpRQ1Rwd0G/plRaUExe958xmpfNvmHCtjXuEY8PIFWWQz7UlQ+dk/GGmE2ncY
         NK/y9YaeinYjAt8aw/loJYNeazdqKpL5WGI24XZttdKv82n2IRzHxiOexd/IePnzLvIP
         Mwzg==
X-Forwarded-Encrypted: i=1; AJvYcCVIO1ZQ4tKXBNjuZk3kjeSiD8wIJuPSIv4xmDsv6IT+pgk2exU128x2D+nwfU/fcLnUhASxCEahU2CA51lRJbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMRb1/CeFojcOuEO7ni+reZivCQSy7iUSPiesfHp10bklAF5O
	PmHrP5zy0NXPlPLrJvzI50GpSSzubSBVRKMLZhW3+8NL7myOKVc74F//
X-Gm-Gg: AY/fxX7d6n8OJOR0Eh2JkrUFOwA1PyIliEgjcyRrRzLlckqcAyMqQsWg4LK4yCaA4Qa
	x3GCweB4+01HpfJFsP6sUfdg9ULkPz/Gzaug3oSFoHEYFjOxWRK49Ere2+XuyKh9wyYFc0Amp0f
	tg8sJS4XnbzBR9EJHgY79V/Y/uBrwCaTH2RpPcUuzHv26n4CTa39WVOFEoXddEmWiGKkIIBoYCi
	NoIYrJFxSZQjzatfFGrrbcqYl7pg2plBm8WQA1kcBlCiRyOhbXGsNEbIssgIgbu7ofIiBxMQFWj
	o+0Y33ID5os0rc8v8/yl+aTUOu8ZpgNqsb8fQqnn+QcxSSW6ftenLHn28SFQDLRipglpsAUETlB
	Ck+0RvcMBJYnYTS0/oCmVJ3PTO5uW1aPgnHLgL7mQcs2TUF1s3mz68xkNfp5tGHVzlzC4s6Nb9m
	SR5eVz7Y6FgWLDzOVWQ0HXWGg0ytyJBV7FSzQxkAOKyB40rGCv4gC/
X-Google-Smtp-Source: AGHT+IEPxlgtmoJsOcbnrDXHkchjsFc7moeHiVQTpzEoBA2t+H1hGAq+A791EuxHgrzC5U6Ox/NHuQ==
X-Received: by 2002:a05:6000:3111:b0:430:fe6c:b1aa with SMTP id ffacd0b85a97d-432aa434e77mr7977363f8f.26.1767567699992;
        Sun, 04 Jan 2026 15:01:39 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm99650545f8f.17.2026.01.04.15.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 15:01:38 -0800 (PST)
Date: Sun, 4 Jan 2026 23:01:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>, Jeremy
 Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 3/3] randomize_kstack: Unify random source across
 arches
Message-ID: <20260104230136.7aaf8886@pumpkin>
In-Reply-To: <20260102131156.3265118-4-ryan.roberts@arm.com>
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
	<20260102131156.3265118-4-ryan.roberts@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Jan 2026 13:11:54 +0000
Ryan Roberts <ryan.roberts@arm.com> wrote:

> Previously different architectures were using random sources of
> differing strength and cost to decide the random kstack offset. A number
> of architectures (loongarch, powerpc, s390, x86) were using their
> timestamp counter, at whatever the frequency happened to be. Other
> arches (arm64, riscv) were using entropy from the crng via
> get_random_u16().
> 
> There have been concerns that in some cases the timestamp counters may
> be too weak, because they can be easily guessed or influenced by user
> space. And get_random_u16() has been shown to be too costly for the
> level of protection kstack offset randomization provides.
> 
> So let's use a common, architecture-agnostic source of entropy; a
> per-cpu prng, seeded at boot-time from the crng. This has a few
> benefits:
> 
>   - We can remove choose_random_kstack_offset(); That was only there to
>     try to make the timestamp counter value a bit harder to influence
>     from user space.
> 
>   - The architecture code is simplified. All it has to do now is call
>     add_random_kstack_offset() in the syscall path.
> 
>   - The strength of the randomness can be reasoned about independently
>     of the architecture.
> 
>   - Arches previously using get_random_u16() now have much faster
>     syscall paths, see below results.
> 
> There have been some claims that a prng may be less strong than the
> timestamp counter if not regularly reseeded. But the prng has a period
> of about 2^113. So as long as the prng state remains secret, it should
> not be possible to guess. If the prng state can be accessed, we have
> bigger problems.

If you have 128 bits of output from consecutive outputs I think you
can trivially determine the full state using (almost) 'school boy' maths
that could be done on pencil and paper.
(Most of the work only has to be done once.)

The underlying problem is that the TAUSWORTHE() transformation is 'linear'
So that TAUSWORTHE(x ^ y) == TAUSWORTHE(x) ^ TAUSWORTHE(y).
(This is true of a LFSR/CRC and TOUSWORTH() is doing some subset of CRCs.)
This means that each output bit is the 'xor' of some of the input bits.
The four new 'state' values are just xor of the the bits of the old ones.
The final xor of the four states gives a 32bit value with each bit just
an xor of some of the 128 state bits.
Get four consecutive 32 bit values and you can solve the 128 simultaneous
equations (by trivial substitution) and get the initial state.
The solution gives you the 128 128bit constants for:
	u128 state = 0;
	u128 val = 'value returned from 4 calls';
	for (int i = 0; i < 128; i++)
		state |= parity(const128[i] ^ val) << i;
You done need all 32bits, just accumulate 128 bits.  
So if you can get the 5bit stack offset from 26 system calls you know the
value that will be used for all the subsequent calls.

Simply changing the final line to use + not ^ makes the output non-linear
and solving the equations a lot harder.

I might sit down tomorrow and see if I can actually code it...

	David

 
