Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67938737F
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386130; cv=none; b=POoXF9mR440J6hkblU9ig1rVT9nXFuXT/v921UwdcqTAMY982uevuzOMPe5CoVXklbPJSyiLPqT+5ZrWp8/xZi09BZC3nSJGOt2kwV5yIrKXoYRyUKhB4WaW/VtxnqYP/rrWoeq+kirAjlvo1DrxggGRUsHYa7/KR+Du2uwdYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386130; c=relaxed/simple;
	bh=y/Tx52YVSUIzWNI8DzLbQiG3rqi2DQ3nJ4pmqX4O5XI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnS0KwKVLOeCOX+lJZNgqsDyloyDnR9CtdEKNl83Yz1YMq9lbEk87iMsBzY7Kx+ObFFdzkkB1xA5BVXHBvMniC1i9S2s6VU4gKuUrnakFWezTrHeV2untFXG4F/QIB4BjPELfjznDVefRcFfrLEcZ1JHeZ8yuEfhqHU6fOfaNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INXHe+GX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INXHe+GX"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so7088591f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 02:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768386116; x=1768990916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aby9hG1Lpv1OF3fYnEo/Zyk0Fv/I6aSt+58OzVwNuFQ=;
        b=INXHe+GXjxIhAFebKhydD0fRRa9e/N8q/qvefQjDgi6WvdfNZyh+Ow4j6jFYzvcZEo
         83L+80NP768ACYYWD1mC0RogfAJ7tsHOwJVmgg346bjaNTkav/BH8pno/k6vDJJwWf8q
         QK6CHpzmoBfTkLgYue+xXK8bw2lf5zGfyEvcvSReD7Q8ks2RVUQq6tx50kwn39CTbQG/
         8+6IZ/O3uRc0qn9ZbjOXp0RnG7gZq2cpYpvY4hLY/Zmaz2ZbNM2fQFmTFIPGzQOB89J6
         ZVjpWAacWZr49S+pANnPUl/u210G42b7Fu1Mtxf6Hz1BU1QCbAo29+ZWdITojpDufhPC
         BdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768386116; x=1768990916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aby9hG1Lpv1OF3fYnEo/Zyk0Fv/I6aSt+58OzVwNuFQ=;
        b=satOvsDdeIB5DXAVCr1UDMIlIXk+HQceI+1+1mbxIys7gcmali4hsx/RmPoZR0b8Qf
         /zuHsKl0T6juhUmXsx9HfFngq1/fiK5V4zNrUKFDsGGumvTkrt5taBgDBbw8dKnFFqDI
         xldDvm8TxDc6VHC+Z/34SP5fFAUVKbkU8jyd30FQdKxqJT7KeHc/8JCxM1E7MqKb9l5U
         ANoECD4T/KVTZECx10Prd4Z71bqm9beuJ5j1mVxPwl7MBiV7CAN4vzCDDzduFzdue/YG
         w8S5x5RCoCbD2CWM6xVjSOqGWOotoFgdqMdB/MYjIshq33QBwu7VXc+n+gLuJ4vPKMuj
         Joew==
X-Forwarded-Encrypted: i=1; AJvYcCXVJri9oYikPZ0Qtnwt5mZpgSo1pUjUV2US5j2sJEb+NibhindZL6rx2dI39oRSO0FDgudJg41CwrJy5fqHduU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2RgGzVBfwNfOw/iJz0lHOP7vAvBa2ywc4mJOSprJKcq2wXzo
	yWKyfINlg6+rW0DcOZgzjx4MEsg6dvEu7vG1GCglhGoO4T8YFcGXvOfO
X-Gm-Gg: AY/fxX6vyGVgDYBBM20BsVulNWKlnwaB4AOGS36QRmA1frUKUbmO+RP/XgUwnuXO9wl
	mssnS8DyMK5sJAFW78TnksB2yoo3W3cGSAPtuSvfAMdMCosYbrv5mKkIG93nmVjwuaCHPQvM6pF
	ON5PvQ+beVB2+9hnlwmcnQNzeugXHkYMqEBThRs3jxbvjWzmt9ZjW83USop5Y8WfX6VR/0MRErQ
	lMQYHbIgKCxvwcmWdvuNrPaweANXvBkAy355x1p1dLXtexDXCkJxGCnxc9xYz2cIVwEMxo2lYMu
	PWRcDHL+3yvID/xI+rQuI1yJGWP5NNcC7MHsBosht4nyvdi7mUGZ5HA03zpL1ivcsRk/sWwdZBQ
	1AFP9IVMjuLQOR5bfIPFeS7D1xi5A2r0y/xhiqubafTKZ1mGYR3I74mSZj86XXvMxZiKZI4NTf8
	SsdLBIKOnkLJIFRQgqtGm7miIkWauzNOD2yhGJ/zVw9J8P34u5NzA7
X-Received: by 2002:a05:6000:1789:b0:433:42d1:f71f with SMTP id ffacd0b85a97d-4342c543bc2mr2513654f8f.38.1768386116121;
        Wed, 14 Jan 2026 02:21:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0860f5sm48694254f8f.0.2026.01.14.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:21:55 -0800 (PST)
Date: Wed, 14 Jan 2026 10:21:54 +0000
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
Message-ID: <20260114102154.251082c6@pumpkin>
In-Reply-To: <a58e97ad-a69e-498d-9382-2be4914569b0@kylinos.cn>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
	<20260113082748.250916-9-jiangfeng@kylinos.cn>
	<aWYGWLEekWh3jJVf@smile.fi.intel.com>
	<b06e4a63-85c2-4420-8077-f4c059ef33fb@kylinos.cn>
	<a58e97ad-a69e-498d-9382-2be4914569b0@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 15:04:58 +0800
Feng Jiang <jiangfeng@kylinos.cn> wrote:

> On 2026/1/14 14:14, Feng Jiang wrote:
> > On 2026/1/13 16:46, Andy Shevchenko wrote:  
> >> On Tue, Jan 13, 2026 at 04:27:42PM +0800, Feng Jiang wrote:  
> >>> Introduce a benchmark to compare the architecture-optimized strlen()
> >>> implementation against the generic C version (__generic_strlen).
> >>>
> >>> The benchmark uses a table-driven approach to evaluate performance
> >>> across different string lengths (short, medium, and long). It employs
> >>> ktime_get() for timing and get_random_bytes() followed by null-byte
> >>> filtering to generate test data that prevents early termination.
> >>>
> >>> This helps in quantifying the performance gains of architecture-specific
> >>> optimizations on various platforms.  
...
> Preliminary results with this change look much more reasonable:
> 
>     ok 4 string_test_strlen
>     # string_test_strlen_bench: strlen performance (short, len: 8, iters: 100000):
>     # string_test_strlen_bench:   arch-optimized: 4767500 ns
>     # string_test_strlen_bench:   generic C:      5815800 ns
>     # string_test_strlen_bench:   speedup:        1.21x
>     # string_test_strlen_bench: strlen performance (medium, len: 64, iters: 100000):
>     # string_test_strlen_bench:   arch-optimized: 6573600 ns
>     # string_test_strlen_bench:   generic C:      16342500 ns
>     # string_test_strlen_bench:   speedup:        2.48x
>     # string_test_strlen_bench: strlen performance (long, len: 2048, iters: 10000):
>     # string_test_strlen_bench:   arch-optimized: 7931000 ns
>     # string_test_strlen_bench:   generic C:      35347300 ns

That is far too long.
In 35ms you are including a lot of timer interrupts.
You are also just testing the 'hot cache' case.
The kernel runs 'cold cache' a lot of the time - especially for instructions.

To time short loops (or even single passes) you need a data dependency
between the 'start time' and the code being tested (easy enough, just add
(time & non_compile_time_zero) to a parameter), and between the result of
the code and the 'end time' - somewhat harder (doable in x86 if you use
the pmc cycle counter).

	David


>     # string_test_strlen_bench:   speedup:        4.45x
>     ok 5 string_test_strlen_bench
> 
> I will adopt this pattern in v3, along with cache warm-up and preempt_disable(),
> to stay consistent with existing kernel benchmarks and ensure robust measurements.
> 

