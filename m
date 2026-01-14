Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7836A021;
	Wed, 14 Jan 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377952; cv=none; b=gKACWe4kO5lvxFielt4VTQAQMz0fiC0Zqwk9oeCT5VYwb2jxlw6TiP9eD4qNxXV48GK/wyTuWyo7VzVlaFTAPqzCis0adz5Teik5GdK1hZ4eG4Jjv5QQerdQkqEuBQelqQSvooIfmr55VqQdadeNZAvWQMxNXfwD65ubEQHGggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377952; c=relaxed/simple;
	bh=e0cmzWOdlK9dtEJ+VZkhDuNx1+0oEWQzKp4sna/ECYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rk4BUWnXBzyKSxI6yjVfNK8SDmXnnIBVysFL+WDeZ2S5FX25EOAvp5zDTSvjBzN6KVnvkD2XYC2UKHdOhALlmrvu3rsTeSzR3yQ9sh/k+MxuIomwNka8ENEIAh/EVG4PCuvAFDVybbngs1rWARh6mIQ1OZlMswc28KKcuIOscWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d19a52caf11f11f0a38c85956e01ac42-20260114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6d623758-063c-4143-959d-771364ea6b9d,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:c83a20aa957d350a6689e0b3509b8876,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d19a52caf11f11f0a38c85956e01ac42-20260114
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 613788354; Wed, 14 Jan 2026 16:05:41 +0800
Message-ID: <6db87d0e-bfb2-4d8e-88a8-a727f96aa2d5@kylinos.cn>
Date: Wed, 14 Jan 2026 16:05:38 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] lib/string_kunit: add performance benchmark for
 strlen()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
 ebiggers@kernel.org, martin.petersen@oracle.com, ardb@kernel.org,
 ajones@ventanamicro.com, conor.dooley@microchip.com,
 samuel.holland@sifive.com, linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-9-jiangfeng@kylinos.cn>
 <aWYGWLEekWh3jJVf@smile.fi.intel.com>
 <b06e4a63-85c2-4420-8077-f4c059ef33fb@kylinos.cn>
 <a58e97ad-a69e-498d-9382-2be4914569b0@kylinos.cn>
 <aWdD3N_jwnt_ncc1@smile.fi.intel.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <aWdD3N_jwnt_ncc1@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/14 15:21, Andy Shevchenko wrote:
> On Wed, Jan 14, 2026 at 03:04:58PM +0800, Feng Jiang wrote:
>> On 2026/1/14 14:14, Feng Jiang wrote:
>>> On 2026/1/13 16:46, Andy Shevchenko wrote:
> 
> ...
> 
>>> Thank you for the catch. You are absolutely correct—the 2500x figure is heavily
>>> distorted and does not reflect real-world performance.
>>>
>>> I've found that by using a volatile function pointer to call the implementations
>>> (instead of direct calls), the results returned to a realistic range. It appears
>>> the previous benchmark logic allowed the compiler to over-optimize the test loop
>>> in ways that skewed the data.
>>>
>>> I will refactor the benchmark logic in v3, specifically referencing the crc32
>>> KUnit implementation (e.g., using warm-up loops and adding preempt_disable()
>>> to eliminate context-switch interference) to ensure the data is robust and accurate.
>>>
>>
>> Just a quick follow-up: I've also verified that using a volatile variable to store
>> the return value (as seen in crc_benchmark()) is equally effective at preventing
>> the optimization.
>>
>> The core change is as follows:
>>
>>     volatile size_t len;
>>     ...
>>     for (unsigned int j = 0; j < iters; j++) {
>>         OPTIMIZER_HIDE_VAR(buf);
>>         len = strlen(buf);
> 
> But please, check for sure this is Linux kernel generic implementation (before)
> and not __builtin_strlen() from GCC. (OTOH, it would be nice to benchmark that
> one as well, although I think that __builtin_strlen() in general maybe slightly
> better choice than Linux kernel generic implementation.) I.o.w. be sure *what*
> you test.
> 

Thanks for the reminder. I actually verified this with objdump and gdb before
submitting the patch—the calls are indeed hitting the intended arch-specific
strlen symbols, not the compiler's __builtin_strlen(). I missed mentioning this
detail in my previous email.

I also just performed an additional test by explicitly calling the exported
arch-specific __pi_strlen() symbol, and the results remained consistent.

Results with riscv __pi_strlen():

    ok 4 string_test_strlen
    # string_test_strlen_bench: strlen performance (short, len: 8, iters: 100000):
    # string_test_strlen_bench:   arch-optimized: 4650500 ns
    # string_test_strlen_bench:   generic C:      5776000 ns
    # string_test_strlen_bench:   speedup:        1.24x
    # string_test_strlen_bench: strlen performance (medium, len: 64, iters: 100000):
    # string_test_strlen_bench:   arch-optimized: 6895000 ns
    # string_test_strlen_bench:   generic C:      16343400 ns
    # string_test_strlen_bench:   speedup:        2.37x
    # string_test_strlen_bench: strlen performance (long, len: 2048, iters: 10000):
    # string_test_strlen_bench:   arch-optimized: 8052800 ns
    # string_test_strlen_bench:   generic C:      35290700 ns
    # string_test_strlen_bench:   speedup:        4.38x
    ok 5 string_test_strlen_bench

>>     }
> 
> Or using WRITE_ONCE() :-) But that one will probably be confusing as it usually
> should be paired with READ_ONCE() somewhere else in the code. So, I agree on
> crc_benchmark() approach taken.
> 

Thanks for the guidance. I'll stick with the crc_benchmark() pattern to avoid any
potential confusion regarding concurrency that WRITE_ONCE() might imply.

I'm still learning the most idiomatic practices in the kernel, so I appreciate the tip.

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
>>     # string_test_strlen_bench:   speedup:        4.45x
>>     ok 5 string_test_strlen_bench
>>
>> I will adopt this pattern in v3, along with cache warm-up and preempt_disable(),
>> to stay consistent with existing kernel benchmarks and ensure robust measurements.
> 

-- 
With Best Regards,
Feng Jiang

