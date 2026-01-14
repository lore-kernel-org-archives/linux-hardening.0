Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E822E7BB6;
	Wed, 14 Jan 2026 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768374322; cv=none; b=nrRXioFnL/UHKOO4Pt+INYRD/Us/nFG6PLDsYGzUb35YcDWC1laieYdM1HDuI5PpG+h4Myb6eA/+l8yGbbn2axuvyuQBrGi+NPBIY7ti4IXQ83sg8KTVIvcfeYQm7nZ4YXCRKYslTdm8m24vUMg/N1XgKasFV6thgyICy2tIxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768374322; c=relaxed/simple;
	bh=Ik+zBW5eOvq96twB7B3O2tfNChy196H2pyJgcRxMMco=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pGwX7VjQagZTvHafO4BfPGjIuxS/d49TgnwqzucUGn/OSq7eSYBwa4DRyaQB+NVjLxy2fFklVxi0AzdbAW5lrgtZekP1QX/zfFeUfeBaqmJDj1c6n3VA7cLh+fqx1xpmzdSt04HjtOvidaA20fwWNeDmjIElvov2fWiVhWph2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 585f38baf11711f0a38c85956e01ac42-20260114
X-CID-CACHE: Type:Local,Time:202601141414+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a1ebc0c9-de3e-4d6b-8b25-77524b028d51,IP:0,UR
	L:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:2
X-CID-META: VersionHash:a9d874c,CLOUDID:2e6b599c24fb5439d3edbe9de9908b30,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:4|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 585f38baf11711f0a38c85956e01ac42-20260114
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1457618925; Wed, 14 Jan 2026 15:05:01 +0800
Message-ID: <a58e97ad-a69e-498d-9382-2be4914569b0@kylinos.cn>
Date: Wed, 14 Jan 2026 15:04:58 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] lib/string_kunit: add performance benchmark for
 strlen()
From: Feng Jiang <jiangfeng@kylinos.cn>
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
Content-Language: en-US
In-Reply-To: <b06e4a63-85c2-4420-8077-f4c059ef33fb@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/14 14:14, Feng Jiang wrote:
> On 2026/1/13 16:46, Andy Shevchenko wrote:
>> On Tue, Jan 13, 2026 at 04:27:42PM +0800, Feng Jiang wrote:
>>> Introduce a benchmark to compare the architecture-optimized strlen()
>>> implementation against the generic C version (__generic_strlen).
>>>
>>> The benchmark uses a table-driven approach to evaluate performance
>>> across different string lengths (short, medium, and long). It employs
>>> ktime_get() for timing and get_random_bytes() followed by null-byte
>>> filtering to generate test data that prevents early termination.
>>>
>>> This helps in quantifying the performance gains of architecture-specific
>>> optimizations on various platforms.
>>
>> ...
>>
>>> +static void string_test_strlen_bench(struct kunit *test)
>>> +{
>>> +	char *buf;
>>> +	size_t buf_len, iters;
>>> +	ktime_t start, end;
>>> +	u64 time_arch, time_generic;
>>> +
>>> +	buf_len = get_max_bench_len(bench_cases, ARRAY_SIZE(bench_cases)) + 1;
>>> +
>>> +	buf = kunit_kzalloc(test, buf_len, GFP_KERNEL);
>>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>>> +
>>> +	for (size_t i = 0; i < ARRAY_SIZE(bench_cases); i++) {
>>> +		get_random_nonzero_bytes(buf, bench_cases[i].len);
>>> +		buf[bench_cases[i].len] = '\0';
>>> +
>>> +		iters = bench_cases[i].iterations;
>>> +
>>> +		/* 1. Benchmark the architecture-optimized version */
>>> +		start = ktime_get();
>>> +		for (unsigned int j = 0; j < iters; j++) {
>>> +			OPTIMIZER_HIDE_VAR(buf);
>>> +			(void)strlen(buf);
>>
>> First Q: Are you sure the compiler doesn't replace this with __builtin_strlen() ?
>>
>>> +		}
>>> +		end = ktime_get();
>>> +		time_arch = ktime_to_ns(ktime_sub(end, start));
>>> +
>>> +		/* 2. Benchmark the generic C version */
>>> +		start = ktime_get();
>>> +		for (unsigned int j = 0; j < iters; j++) {
>>> +			OPTIMIZER_HIDE_VAR(buf);
>>> +			(void)__generic_strlen(buf);
>>> +		}
>>
>> Are you sure the warmed up caches do not affect the benchmark? I think you need
>> to flush / make caches dirty or so on each iteration.
>>
>>> +		end = ktime_get();
>>> +		time_generic = ktime_to_ns(ktime_sub(end, start));
>>> +
>>> +		string_bench_report(test, "strlen", &bench_cases[i],
>>> +				time_arch, time_generic);
>>> +	}
>>> +}
>>
>>
> 
> Thank you for the catch. You are absolutely correct—the 2500x figure is heavily
> distorted and does not reflect real-world performance.
> 
> I've found that by using a volatile function pointer to call the implementations
> (instead of direct calls), the results returned to a realistic range. It appears
> the previous benchmark logic allowed the compiler to over-optimize the test loop
> in ways that skewed the data.
> 
> I will refactor the benchmark logic in v3, specifically referencing the crc32
> KUnit implementation (e.g., using warm-up loops and adding preempt_disable()
> to eliminate context-switch interference) to ensure the data is robust and accurate.
> 

Just a quick follow-up: I've also verified that using a volatile variable to store
the return value (as seen in crc_benchmark()) is equally effective at preventing
the optimization.

The core change is as follows:

    volatile size_t len;
    ...
    for (unsigned int j = 0; j < iters; j++) {
        OPTIMIZER_HIDE_VAR(buf);
        len = strlen(buf);
    }

Preliminary results with this change look much more reasonable:

    ok 4 string_test_strlen
    # string_test_strlen_bench: strlen performance (short, len: 8, iters: 100000):
    # string_test_strlen_bench:   arch-optimized: 4767500 ns
    # string_test_strlen_bench:   generic C:      5815800 ns
    # string_test_strlen_bench:   speedup:        1.21x
    # string_test_strlen_bench: strlen performance (medium, len: 64, iters: 100000):
    # string_test_strlen_bench:   arch-optimized: 6573600 ns
    # string_test_strlen_bench:   generic C:      16342500 ns
    # string_test_strlen_bench:   speedup:        2.48x
    # string_test_strlen_bench: strlen performance (long, len: 2048, iters: 10000):
    # string_test_strlen_bench:   arch-optimized: 7931000 ns
    # string_test_strlen_bench:   generic C:      35347300 ns
    # string_test_strlen_bench:   speedup:        4.45x
    ok 5 string_test_strlen_bench

I will adopt this pattern in v3, along with cache warm-up and preempt_disable(),
to stay consistent with existing kernel benchmarks and ensure robust measurements.

-- 
With Best Regards,
Feng Jiang

