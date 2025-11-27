Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF632D0FC;
	Thu, 27 Nov 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245538; cv=none; b=tVwrIabGf/KA3ORW/upAxEMPvUu22DaPoNw04dvCiVWWKccXM+rD3Rz6ggDsxW0/HzscphBWUtVsrEag4UNA1b2UbJWqknJ5Pe5FW8vdI2xyET6/ROg4BWT1JY711IjT9vtARVrpX4fmu3gS3e52DSGQiwamgPA+vcNfyjsdhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245538; c=relaxed/simple;
	bh=WP5gw9Y7u98JvO28yq0+Af4KVuPB7uXNdaw/MdnqGsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfhsO9zXjgWqLGHFtjIL9NjjAehEYfHRHd0z1g1ZtF8AMePhnvgM+WQhcER6UFYukG4QeDmRo7UPZF3XL8pIN61isGqQO6wjbudsLw8hE83Z22hlxqwIW9engDeNXXC0hpk9eYkcMdhfQ+UQngGWTIxGBfPEgX/3GQUTmUKQAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 300161477;
	Thu, 27 Nov 2025 04:12:08 -0800 (PST)
Received: from [10.57.87.167] (unknown [10.57.87.167])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B11653F73B;
	Thu, 27 Nov 2025 04:12:13 -0800 (PST)
Message-ID: <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
Date: Thu, 27 Nov 2025 12:12:12 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize
 kstack
Content-Language: en-GB
To: Ard Biesheuvel <ardb+git@google.com>, linux-hardening@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>,
 Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20251127092226.1439196-8-ardb+git@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251127092226.1439196-8-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/11/2025 09:22, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Ryan reports that get_random_u16() is dominant in the performance
> profiling of syscall entry when kstack randomization is enabled [0].
> 
> This is the reason many architectures rely on a counter instead, and
> that, in turn, is the reason for the convoluted way the (pseudo-)entropy
> is gathered and recorded in a per-CPU variable.
> 
> Let's try to make the get_random_uXX() fast path faster, and switch to
> get_random_u8() so that we'll hit the slow path 2x less often. Then,
> wire it up in the syscall entry path, replacing the per-CPU variable,
> making the logic at syscall exit redundant.

I ran the same set of syscall benchmarks for this series as I've done for my 
series. 

The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
performance cost of turning it on without any changes to the implementation,
then the reduced performance cost of turning it on with my changes applied, and 
finally cost of turning it on with Ard's changes applied:

arm64 (AWS Graviton3):
+-----------------+--------------+-------------+---------------+-----------------+
| Benchmark       | Result Class |   v6.18-rc5 | per-task-prng | fast-get-random |
|                 |              | rndstack-on |               |                 |
+=================+==============+=============+===============+=================+
| syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |      (R) 11.93% |
|                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |      (R) 11.00% |
|                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |      (R) 11.39% |
+-----------------+--------------+-------------+---------------+-----------------+
| syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |      (R) 10.44% |
|                 | p99 (ns)     | (R) 152.81% |         1.55% |       (R) 9.94% |
|                 | p99.9 (ns)   | (R) 153.67% |         1.77% |       (R) 9.83% |
+-----------------+--------------+-------------+---------------+-----------------+
| syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |      (R) 10.39% |
|                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |      (R) 10.72% |
|                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |      (R) 11.03% |
+-----------------+--------------+-------------+---------------+-----------------+

So this fixes the tail problem. I guess get_random_u8() only takes the slow path 
every 768 calls, whereas get_random_u16() took it every 384 calls. I'm not sure 
that fully explains it though.

But it's still a 10% cost on average.

Personally I think 10% syscall cost is too much to pay for 6 bits of stack 
randomisation. 3% is better, but still higher than we would all prefer, I'm sure.

Thanks,
Ryan

> 
> [0] https://lore.kernel.org/all/dd8c37bc-795f-4c7a-9086-69e584d8ab24@arm.com/
> 
> Cc: Kees Cook <kees@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Catalin Marinas <Catalin.Marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Ard Biesheuvel (6):
>   hexagon: Wire up cmpxchg64_local() to generic implementation
>   arc: Wire up cmpxchg64_local() to generic implementation
>   random: Use u32 to keep track of batched entropy generation
>   random: Use a lockless fast path for get_random_uXX()
>   random: Plug race in preceding patch
>   randomize_kstack: Use get_random_u8() at entry for entropy
> 
>  arch/Kconfig                       |  9 ++--
>  arch/arc/include/asm/cmpxchg.h     |  3 ++
>  arch/hexagon/include/asm/cmpxchg.h |  4 ++
>  drivers/char/random.c              | 49 ++++++++++++++------
>  include/linux/randomize_kstack.h   | 36 ++------------
>  init/main.c                        |  1 -
>  6 files changed, 49 insertions(+), 53 deletions(-)
> 
> 
> base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d

