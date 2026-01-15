Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9D2236E0
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473652; cv=none; b=MleIOC53zpKROOR6o05r4oGAykPK+AZAiZhjNUzJrRL6FF0Qq124wcrXNTLKWOCLTg+QRn1Z+zm2eIOn8mFAAo4cGEUv4nq1Soy3Jxtsw+s5ZWfval4SSbWKFedUWNQOQsZpPIO8CkmfYLTRWvB/4xP4lswoQ/DboN4e0eQS0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473652; c=relaxed/simple;
	bh=PXtEUdbcBnOo1s1SfCXys1Wgja35tbW5tamgoalKGBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/MpgyUKEGIM2I1uIET+geNLKsrzgpmPcultqKFmmIWBxdcS60D/pr60MBAWQLdcVDK/xHSuW25QFluPeKUHmt+99wctV0zb+cjcoFyDXWwHWqArPgRF4cUAUF3oeVmr1K+6wX6RF5tE2lQV3r3lvr8vAtaHDn+4nTuJWGqQXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM1EN7sQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM1EN7sQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee0291921so5290585e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 02:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768473648; x=1769078448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syBTlDAByvMUAXYqpRa9En3uBDhRXXk2428oEoGHqyM=;
        b=TM1EN7sQ9jVH77JpvPXzykexuY3gZ1xYaXmtcBQM0F/6i6aS1bZNlVK0pitgmeQWOc
         4Umx1xetzpgZTRm6G6ksUBVPmPxmB9avG40c/zo4NW7XF8Al0xTWU+PI+uzxNC8klyKZ
         wjSCYGzTt8TzyGC3s4uE1XC5Fbatvz/dzd0691m11olop3SjltwJMwGeT8NCU23BCh8p
         7vB3c7nPs2C7fAQZihAu7mJwBMwTz8i3WHZM5IUsCIp9In4Vo0hZoMOdgUjvQ/xAVX3E
         VUFBMnux4phLsM0IGG6jj8l/9wV1nMWpFrFGeTYkpAlNaEV7XTJGAiNn1sT0tY3MWX/P
         ZQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768473648; x=1769078448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=syBTlDAByvMUAXYqpRa9En3uBDhRXXk2428oEoGHqyM=;
        b=ckURt+PqPgM7wy6bneoucLeulETKCemagGzo1WwrkttHuadpJBh41SsMHE7vYksied
         MweT6Cx1aHT069CJKeuqNdGEI6rrIkqlGMV9+RCebVloeY23CVKIIPHUXZzsllDK4MO7
         7nI/t+vvUO3rZ2qjm41fDwcBX+YC/oxJVAkP/4jfIJu75dXhgEs+GePh63SJBRqyt5Sm
         UX1YCA5GvtqvUzhab8QQ6ZchLLHOjp5lXblHKgKImOZ75gI9p3OLdFmtvA9qmgRi6CoQ
         +HJRVPX9RJIgZMju1SQT8lrq1dEpxTLHQtgOi7NxD/PdJ24GECjjfTtthb/PTUvte6at
         A7qA==
X-Forwarded-Encrypted: i=1; AJvYcCVbP0WVLT6q4m+U/zHH8bt9OTrIo6PpVrb6+Ljc40EH7uOEt8uJCpQUhUma3IzeVE1AFQHWP7njReDfcPiigIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0EzLRBhg0YKagdzolJsJM3X7uCU2nHDsP9PX6MCjYcKgIwP0
	MSvBfFbVUhmTOiEMXExFy2/vK/SGL3yxyERKNLuY6NwSHY691j+uz/YZ
X-Gm-Gg: AY/fxX6qAFCcH9AbPe33EoVzP+GfVNvYo03qncKTfHH0eelX3G4cn05Ajmr6xVAQzdJ
	RGs2T27vgvfOMsaTaStyQCiBJzke8+gknmlZl2fQZhmww31VtfmEWu4lI0nAY+e4hYNkWQ0Bp6X
	zXjxXVyCEbkMI92o4xMTwQS8gV5kBVCnCxAqHdM9M7y0clWlld/Wz+LUa3wvI4QCJMYC3oQ6RsG
	mLcdYwrbBPICTnpEJ/AA9nije1oz0zURw57zJ0qaiHODz4r8cHGKmhGpXfb3ERce1AEJoNav2c/
	fF+YVUz5ocKFNRTNI6mkL7UhjaKx72ChEsC04KYY+B7NjQwpyfArOtMyNC6IyKOpzzXH+J+K0x9
	9XJkyG7pCYPYRK+VzLSQizjkiNsjDMXkpBm3SpJOP200/2PjYlgq+VgU8sJ4c8NxD5o7FQuwJWY
	/hfgjelBn4EcL6Zj132ZhiDo4g5Nt1RlFL3Aod9dQw+zAOkSyHfybCGuBSHencJ30=
X-Received: by 2002:a05:600c:3555:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-47ee33a1b80mr70553835e9.27.1768473648254;
        Thu, 15 Jan 2026 02:40:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee117e607sm44513985e9.3.2026.01.15.02.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:40:47 -0800 (PST)
Date: Thu, 15 Jan 2026 10:40:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org,
 andy@kernel.org, akpm@linux-foundation.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, ardb@kernel.org, ajones@ventanamicro.com,
 conor.dooley@microchip.com, samuel.holland@sifive.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 08/14] lib/string_kunit: add performance benchmark
 for strlen()
Message-ID: <20260115104045.30d385b7@pumpkin>
In-Reply-To: <8bf4c689-fee5-4f6b-b79e-854249a897d0@kylinos.cn>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
	<20260113082748.250916-9-jiangfeng@kylinos.cn>
	<aWYGWLEekWh3jJVf@smile.fi.intel.com>
	<b06e4a63-85c2-4420-8077-f4c059ef33fb@kylinos.cn>
	<a58e97ad-a69e-498d-9382-2be4914569b0@kylinos.cn>
	<20260114102154.251082c6@pumpkin>
	<8bf4c689-fee5-4f6b-b79e-854249a897d0@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 14:24:16 +0800
Feng Jiang <jiangfeng@kylinos.cn> wrote:

> On 2026/1/14 18:21, David Laight wrote:
> > On Wed, 14 Jan 2026 15:04:58 +0800
> > Feng Jiang <jiangfeng@kylinos.cn> wrote:
> >   
> >> On 2026/1/14 14:14, Feng Jiang wrote:  
> >>> On 2026/1/13 16:46, Andy Shevchenko wrote:    
> >>>> On Tue, Jan 13, 2026 at 04:27:42PM +0800, Feng Jiang wrote:    
> >>>>> Introduce a benchmark to compare the architecture-optimized strlen()
> >>>>> implementation against the generic C version (__generic_strlen).
> >>>>>
> >>>>> The benchmark uses a table-driven approach to evaluate performance
> >>>>> across different string lengths (short, medium, and long). It employs
> >>>>> ktime_get() for timing and get_random_bytes() followed by null-byte
> >>>>> filtering to generate test data that prevents early termination.
> >>>>>
> >>>>> This helps in quantifying the performance gains of architecture-specific
> >>>>> optimizations on various platforms.    
> > ...  
> >> Preliminary results with this change look much more reasonable:
> >>
> >>     ok 4 string_test_strlen
> >>     # string_test_strlen_bench: strlen performance (short, len: 8, iters: 100000):
> >>     # string_test_strlen_bench:   arch-optimized: 4767500 ns
> >>     # string_test_strlen_bench:   generic C:      5815800 ns
> >>     # string_test_strlen_bench:   speedup:        1.21x
> >>     # string_test_strlen_bench: strlen performance (medium, len: 64, iters: 100000):
> >>     # string_test_strlen_bench:   arch-optimized: 6573600 ns
> >>     # string_test_strlen_bench:   generic C:      16342500 ns
> >>     # string_test_strlen_bench:   speedup:        2.48x
> >>     # string_test_strlen_bench: strlen performance (long, len: 2048, iters: 10000):
> >>     # string_test_strlen_bench:   arch-optimized: 7931000 ns
> >>     # string_test_strlen_bench:   generic C:      35347300 ns  
> >>     # string_test_strlen_bench:   speedup:        4.45x
> > 
> > That is far too long.
> > In 35ms you are including a lot of timer interrupts.
> > You are also just testing the 'hot cache' case.
> > The kernel runs 'cold cache' a lot of the time - especially for instructions.
> > 
> > To time short loops (or even single passes) you need a data dependency
> > between the 'start time' and the code being tested (easy enough, just add
> > (time & non_compile_time_zero) to a parameter), and between the result of
> > the code and the 'end time' - somewhat harder (doable in x86 if you use
> > the pmc cycle counter).  
> 
> Hi David,
> 
> I appreciate the feedback! You're absolutely right that 35ms is quite long; it
> was measured in a TCG environment, and on real hardware (ARM64 KVM), it's
> actually an order of magnitude faster. I'll definitely tighten the iterations
> in v3 to avoid potential noise.

Doing time-based measurements on anything but real hardware is pointless.
(It is even problematic on some real hardware because the cpu clock speed
changes dynamically - which is why I've started using the x86 pmc to count
actual clock cycles.)

You only really need enough iterations to get enough 'ticks' from the
timer for the answer to make sense.
Other effects mean you can't really quote values to even 1% - so 100 ticks
from the timer is more than enough.
I'm not sure what the resolution of ktime_get_ns() is (will be hardware
dependant) 
You are better off running the test a few times and using the best value.

Also you don't need to do a very long test to show a x4 improvement!

To see how good an algorithm really is you really need to work out the
'fixed cost' and 'cost per byte'  in 'clocks' and 'clocks per byte'
(or 'bytes per clock') although they can be 'noisy' for short lengths.
The latter tells you how near to 'optimal' the algorithm is and lets you
compare results between different cpus (eg Zen-5 v i7-12xxx).
For instance the x86-64 IP checksum code (nominally 16bit add with carry)
actually runs at more than 8 bytes/clock on most cpu (IIRC it manages 12
but not 16).

> 
> For the more advanced suggestions like cold cache and data dependency, I can
> see how they would make the benchmark much more rigorous. My plan is to follow
> the pattern in crc_benchmark() to refine the logic, as I feel this approach is
> simple, easy to maintain, and provides a good enough baseline for our needs.
> 
> While I understand that simulating a cold cache would be more precise, I'm
> concerned it might introduce significant complexity at this stage. I hope the
> current focus on hot-path throughput is a reasonable starting point for a
> general KUnit test.
> 

I've only done 'cold cache' testing in userspace - counting the actual
clocks for the each call (the first value is cold cache).

Gives a massive difference for large functions like blake2s where the
unrolled loop is somewhat faster, but for the cold-cache it is only
worth it for buffers over (about) 8k (and that might be worse if the
cpu is running at full speed which makes the memory effectively slower).

The other issue with running a test multiple times is that the branch
predictor will correctly predict all the branches.
So something like memcpy() which might have different code for different
lengths will always pick the correct one.
Branch mis-prediction seems to cost about 20 clocks on my zen-5.

Anyway, some measurements are better than none.

	David


