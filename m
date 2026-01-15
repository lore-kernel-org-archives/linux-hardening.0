Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEF381C4;
	Thu, 15 Jan 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458268; cv=none; b=ZbabgwEG5I/7e9XVPDLHG0knKIGlHbVW0tIu/UhzQzwAQCnO7mJEXWeh6tm9oKF0ZSNPMgpC6S4wXJz2J6e6dp+quNAzZhMdRXfsBKOTOCKFUhgL7Ky6dKyl47uZikZ8OogUzz9UKoVBepNgQHaBzF0bUPs90CTngcrKqsrywIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458268; c=relaxed/simple;
	bh=YVnvG98Nkt6xddRL7C3NlNpdtmPrTYrOQhP011Itijo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgVVylXWZ2Q4w12eCajT2TW6qjU2//HdM7Or5i5ePMCfIUjFEpcWaKtR+joIpXEIriDwkY+M/f+ANZj6AAkq7rdRrlfpjFuoQ+bUpUrvLwX8h9WP9f0E5qC0j3hH0m4MBS2/McZVFktCGSK+zY+ENAAqpuQW4w46P7VcognSrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d38f05cef1da11f0a38c85956e01ac42-20260115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:bd996bec-d0ac-4cce-8dea-6c4c2f17250a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:bd62760e38b3a72db32bb66bf6da7889,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d38f05cef1da11f0a38c85956e01ac42-20260115
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1957358825; Thu, 15 Jan 2026 14:24:20 +0800
Message-ID: <8bf4c689-fee5-4f6b-b79e-854249a897d0@kylinos.cn>
Date: Thu, 15 Jan 2026 14:24:16 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] lib/string_kunit: add performance benchmark for
 strlen()
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org,
 andy@kernel.org, akpm@linux-foundation.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, ardb@kernel.org, ajones@ventanamicro.com,
 conor.dooley@microchip.com, samuel.holland@sifive.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-9-jiangfeng@kylinos.cn>
 <aWYGWLEekWh3jJVf@smile.fi.intel.com>
 <b06e4a63-85c2-4420-8077-f4c059ef33fb@kylinos.cn>
 <a58e97ad-a69e-498d-9382-2be4914569b0@kylinos.cn>
 <20260114102154.251082c6@pumpkin>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <20260114102154.251082c6@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/14 18:21, David Laight wrote:
> On Wed, 14 Jan 2026 15:04:58 +0800
> Feng Jiang <jiangfeng@kylinos.cn> wrote:
> 
>> On 2026/1/14 14:14, Feng Jiang wrote:
>>> On 2026/1/13 16:46, Andy Shevchenko wrote:  
>>>> On Tue, Jan 13, 2026 at 04:27:42PM +0800, Feng Jiang wrote:  
>>>>> Introduce a benchmark to compare the architecture-optimized strlen()
>>>>> implementation against the generic C version (__generic_strlen).
>>>>>
>>>>> The benchmark uses a table-driven approach to evaluate performance
>>>>> across different string lengths (short, medium, and long). It employs
>>>>> ktime_get() for timing and get_random_bytes() followed by null-byte
>>>>> filtering to generate test data that prevents early termination.
>>>>>
>>>>> This helps in quantifying the performance gains of architecture-specific
>>>>> optimizations on various platforms.  
> ...
>> Preliminary results with this change look much more reasonable:
>>
>>     ok 4 string_test_strlen
>>     # string_test_strlen_bench: strlen performance (short, len: 8, iters: 100000):
>>     # string_test_strlen_bench:   arch-optimized: 4767500 ns
>>     # string_test_strlen_bench:   generic C:      5815800 ns
>>     # string_test_strlen_bench:   speedup:        1.21x
>>     # string_test_strlen_bench: strlen performance (medium, len: 64, iters: 100000):
>>     # string_test_strlen_bench:   arch-optimized: 6573600 ns
>>     # string_test_strlen_bench:   generic C:      16342500 ns
>>     # string_test_strlen_bench:   speedup:        2.48x
>>     # string_test_strlen_bench: strlen performance (long, len: 2048, iters: 10000):
>>     # string_test_strlen_bench:   arch-optimized: 7931000 ns
>>     # string_test_strlen_bench:   generic C:      35347300 ns
> 
> That is far too long.
> In 35ms you are including a lot of timer interrupts.
> You are also just testing the 'hot cache' case.
> The kernel runs 'cold cache' a lot of the time - especially for instructions.
> 
> To time short loops (or even single passes) you need a data dependency
> between the 'start time' and the code being tested (easy enough, just add
> (time & non_compile_time_zero) to a parameter), and between the result of
> the code and the 'end time' - somewhat harder (doable in x86 if you use
> the pmc cycle counter).

Hi David,

I appreciate the feedback! You're absolutely right that 35ms is quite long; it
was measured in a TCG environment, and on real hardware (ARM64 KVM), it's
actually an order of magnitude faster. I'll definitely tighten the iterations
in v3 to avoid potential noise.

For the more advanced suggestions like cold cache and data dependency, I can
see how they would make the benchmark much more rigorous. My plan is to follow
the pattern in crc_benchmark() to refine the logic, as I feel this approach is
simple, easy to maintain, and provides a good enough baseline for our needs.

While I understand that simulating a cold cache would be more precise, I'm
concerned it might introduce significant complexity at this stage. I hope the
current focus on hot-path throughput is a reasonable starting point for a
general KUnit test.

-- 
With Best Regards,
Feng Jiang

