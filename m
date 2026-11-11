Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794417590;
	b=Rc7YJO/pkJdpmGzuB2pltY8fxfqAi+tFuW6DELLoPETOj/UxzxZShrrZI8SKSTMeJHVI
	 EeKPzYeGQONxSO0w+0PocXFpz/YlqZXj0IEAJU2ayjnCtVQiUvBT/9zJtgpInJM4/cM1J
	 XTwCHRIMayQv0k1Y6PQRi1QGSezEOOudAmfFCmxJjjkFELJVQxKv+xlBDDEiswYWEb6xq
	 YyGwZ6vpSWluoPss5oJyODUvUU2xBdJrF7R38McUj1dADQ32q4uPDrlmdGtJSL4XyPR92
	 eTwYRBokT+Xg/ohyNNMDixZk5LrZCnybjy6rLIUPgBkgDSuoJJdEsocCX+Woxq+1TxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iTol9OuOgGYXh26V9QvjAW3otBVqyc5sDP/r02tbP3M=;
	b=Y/zbSdsmRFKCjunPR93BV9eRI+6SOhe/Ywmhw5EWpBF82/kuYRbg7PrADDerjl8BfsmO
	 31r1aQtxROapZH1YD8bKLonmF/wfFbeQoweqfw8sLvacldK4xBoLA6romwBoVqBubC8td
	 tg630gb6AgP6EFBI7J9uDpOrUgGDHW5Ousk0NU3Z+Gb5n3emJOEwMMufazzd5Q1JUbDPE
	 Au5DLbRbmynVswSTcF//rkwlZJ8m1sjTZKFDCFXR5Xr0s1tYWcFg7bWmpfr7AHMHZ2qW+
	 4XsJAVkUYh6yvSAxFR9wEJolGqqrALgAb407plS7j/pKQ7o4RAUbH3is4KgspXok5fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=as1eS6by;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC5606A327
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 17:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4DC5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=as1eS6by
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b571979178so4554176a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 09:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417587; cv=none;
        d=google.com; s=arc-20260327;
        b=k/eVpjqsvzpYS9nMZ5jTWwrDRrKQdYjUzobpH7rnJhrkkumpxhMh/CAiOIQMDSyA1E
         8lnjv5IxZhwZoTP7w8lgehCTeouBeesF2y+555abQpMgX9/BX2aO6cNVO8LXFXAbR+RH
         MsnRNjGYnbKYo+D59sXAGFjpNEeA6n4mUGnsZQx1WPTWOz4KHVY8nUE1AtbvhpXqe1oN
         kiIBo6cv9WUoobGAfn9oGMutIXyCnOe1w2smgJsQAmgj+brh3Dk794Bgq/l1XB2GaN1o
         z0nIAxNr1K+D9Eof/3z07uxxLvTGF4a36B+TeEi+3+PsAlcpvyzIIbB/uQkbNTq/zQoD
         mT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iTol9OuOgGYXh26V9QvjAW3otBVqyc5sDP/r02tbP3M=;
        fh=2ax6zQhMzsWGyRUJIPNwqGOFYOWsJc0HGYCQG8hR2eM=;
        b=su3mnDXxdSU5xQG1h5sniiWHrYx6mkgrNW1nRMRb1GeG/MmXzFO3XLLe7ygao5KWPX
         asgiu8GUqIeoj+r90cj1VmRoQCI+oHDCMi0Ac2zSyPORhe8whFpzzx/gEhw7oA/fS9w9
         3GOuDjWPC9zgaFnNnjeASpu2MSm5cC+GEiWeFM41dgAZTxGYosCTdGi0h5FQJ2UzcSYM
         l3BzIN+DamcjVTfdhcF17PqXIC8AP+fB3wO42Vl8z6wO4geovnEdbtxnwWeszB9D6T5k
         89mqBZSj3uiCm7HHF81GNAfUIIVbJ3Xgb5FUGAdFArpK2gKmJKvit3bjKb2PNQ0HUH83
         EEug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794417587; x=1795022387; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTol9OuOgGYXh26V9QvjAW3otBVqyc5sDP/r02tbP3M=;
        b=as1eS6bypCTE5b+92bv/ROzRgy8V3klxe4VWAMyoyyL66NF5Fyy3Z1UiZKTUi/v74V
         VAXDX1IavrKKO3i32uvsuHLolnjzXugfNMQdUBMbrmJ+Ix7mIJKfQh5IpOFMMCC4HQTk
         jGlIPZakc/2kd8Rojea82axums1XYqtmqqvqbVT3itlwu/zrv0j3Bjz0SaHrF6fuxZjr
         76o0sZbhtz5JeCzVBgDViK3ponHzPGY6Igy//d7n4sZJWr3ErAQehFC0lhs38iUEPMtf
         qV6acbOlEYpwhGiTPHXBGTNXf7TwbKOgcYXcTRvbrbQb8RSc4PhIYtqtz8yBo5A3l10x
         tAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794417587; x=1795022387;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iTol9OuOgGYXh26V9QvjAW3otBVqyc5sDP/r02tbP3M=;
        b=PXXkBP6dJnuWvqFDXoSBw8riuMrLkJ8byTkp2cqM7EeXvhnTqyXbXB7mp9heSWmLS0
         2Ntxo4vgqD3GrqajXtGbuaZUhPeRZPBj9nPBCpYHqlr7yGD7zH/Utj/dHjo7VSCWJcx+
         GV59fCmt8KrMd1N02ZUHCZwyqPizPhZovlJwmOmsUxAk4u5hIsgKXeT+PKI4aMtJSIWU
         0ztNhCwu4kJkaEVV4AQNvr/Heeus6eb5YEBJhW5Jh3vhYeC3I5yDolLr9LaTuOBxaCgO
         E5MjbwfxmYTHf16hvJQdmmc3yDaGngcWkeWeLDZ4QVqaOJuoprh4SwG4f9DkScg9MJpR
         50vQ==
X-Forwarded-Encrypted: i=1; AL+hErH+OOfBjXPJWkyallSfT5zFN9CyelHL/nH2Q7fqhUyBcDsdhYgyPO1Xw1fj+mNKS/dwCcKY+tTHYACeKH3mXFI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nM0VGQ0DBjSIpP58azEhNDFCEJBKSZ5dndwAZW+1hYY4X/peS
	EMIg1arUZUV/yWLGfXe7ndXE3RGcAD1O7SMPLfzra69f6jlufWnfr0+GgxLMyzOlsEeIDojVqau
	xWCx7BPkv3K0vy4sJOQGnSogh74uk1W0=
X-Gm-Gg: AYBFou1udBogchb1Ul+O4PSrfQ9eYEmr6PKb34FGfQQ7FE2zdRLPX/uQlSIwfnTycqT
	eP0cUkhoDu0fxeqY9f6J0VPz/E+xked3EcMOhnT28Gimqei95Xu8Vl+6hqYWyJs1E1DKL4XeW82
	iwZhkVhAmu9HHZTtrhfQXpsIYsD0hF9hsi+4aQUWnxHgJHA5vMsXDI2m+Ck2Byska/ve+LfylyK
	N9+56MYgegDC3Vu829QEFXWCy7SZGqsnE19kvSW4X1/uqBiAkfOzOpFAgkn5iU5rBTtiDg6Fzdq
	dNfT4hF6TWOXwp02f9XhhmytJcFzZsHRJ3n03UQao2eJB68hfQjkwkfnKTlFAiHdGea0l1rPQF/
	E68KR/DYrTbOeTVRh2FfrJkTe6/716bPcbb/XzOM=
X-Received: by 2002:aa7:c4ed:0:b0:6b4:5d8c:95e2 with SMTP id
 4fb4d7f45d1cf-6b77733f5c6mr1625239a12.4.1794417586999; Wed, 11 Nov 2026
 09:19:46 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110021622.122490-1-technoboy85@gmail.com>
 <20261109193925.8a127f2d0afd5429f1f551f1@linux-foundation.org> <20261110100116.5c435722@pumpkin>
In-Reply-To: <20261110100116.5c435722@pumpkin>
From: Matteo Croce <technoboy85@gmail.com>
Date: Wed, 11 Nov 2026 18:19:10 +0100
X-Gm-Features: AclHuK8iwIUz_YGXZP5CajA0kq-b19YTFhGC7BAF4j9dRAM_y1FghCHa33mkCG4
Message-ID: <CAFnufp30PRLUaW-grdxuuM6vumgHBwWmf8FTm9WNfYU4BWYGNA@mail.gmail.com>
Subject: Re: [PATCH v7] kunit: memcpy: Add benchmark
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 10:01:16 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Mon, 9 Nov 2026 19:39:25 -0800
> Andrew Morton <akpm@linux-foundation.org> wrote:
>
> > hm, sorry, I must ask "why".  Nowadays optimizing memcpy() is a
> > super-specialized thing undertaken by the bravest architecture
> > specialists who are unlikely to rely upon a generic kunit test for the
> > purpose!
>
> But kernel benchmarks are really the wrong place.
> The 'bravest architecture specialists' are going to test the code
> in userspace where multiple algorithms can be tested and quickly
> tweaked/dismissed.

Hi Andrew, David,

Fair question. I'm not one of the bravest, but I used this test to
develop and measure a fix for a real problem: the RISC-V memcpy()
falls back to a byte-by-byte copy whenever source and destination
have different alignment, and on a Milk-V Megrez that made unaligned
copies run at about a third of the aligned speed. The fix[1] does a
shifted word copy for that case:

  Before:
      memcpy: aligned copy of 400 MBytes in 429 msecs (931 MB/s)
      memcpy: unaligned copy of 400 MBytes in 1202 msecs (332 MB/s)
  After:
      memcpy: aligned copy of 400 MBytes in 428 msecs (933 MB/s)
      memcpy: unaligned copy of 400 MBytes in 519 msecs (770 MB/s)

and it's visible outside the benchmark too: UDP RX on the board's
stmmac NIC went from 672 to 827 Mbps with 512 byte frames.

That slow path had been in the kernel for years, and I think that's
the point: the specialists tune the hot path on the hardware they
care about, while a slow path on some other SoC can go unseen.

I don't see this as an alternative to userspace testing, I do both.
I develop the assembly in a standalone harness[2], which checks every
length and alignment combination, and times ns per call over a range
of sizes against glibc's memcpy() and a few other implementations
(a vector one, C-SKY's, a glibc shifted-copy patch). That's where
the variants get tried and dismissed.

But the harness runs a hand-copied memcpy.S as userspace code, which
can use things the kernel can't, like the vector unit. The KUnit test
checks the real thing: the kernel's own memcpy(), as built for the
running kernel and, on architectures that do so, patched at boot for
the running CPU. It also lets anyone else check their hardware with
a modprobe, and can run unattended in CI.

There is precedent in lib/: CONFIG_CRC_BENCHMARK and
CONFIG_CRYPTO_LIB_BENCHMARK add opt-in benchmarks to the CRC and
crypto library KUnit suites in the same way.

[1] https://lore.kernel.org/linux-riscv/20260311173138.1820-1-teknoraver@meta.com/
[2] https://github.com/teknoraver/riscv-memcpy

> You also want a comparison against the 'obvious loops' (which it can
> take some effort to generate because the compiler tends to convert them
> to memcpy()). Otherwise the numbers are pretty meaningless.
>
> I also (sometimes being one of the 'bravest architecture specialists')
> try to work out how many bytes/clock the a copy (or ipcsum) is doing
> and what the fixed costs are.

Agreed, and the sample output shows the problem: timing every call
with ktime_get_ns() means the small sizes mostly measure the clock
read. For v8 I'd:

- time the whole batch of copies instead of each call, as the
  harness already does
- print the per-call cost in ns next to the throughput, so the fixed
  cost is visible (and say MiB/s, which is what it actually computes)
- add a byte-at-a-time baseline, with OPTIMIZER_HIDE_VAR() on the
  pointers inside the loop so it can't be turned back into memcpy()

The baseline would have made the RISC-V case obvious at a glance:
the unaligned memcpy() would have matched it, since it was itself a
byte loop.

For bytes/clock I'd rather not use get_cycles(), as on several
architectures it doesn't tick at the core clock; ns per call at a known
size should let you derive it on a given machine.

Would that address your concerns?

Regards,
-- 
per aspera ad upstream
