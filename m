Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204535503F;
	Wed, 14 Jan 2026 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371269; cv=none; b=VTH45UUtlzG8bxoK2nc0+LcTYbZfcSPhJ05Mz63IdfEh1euxE8rq5r5k9o+ZzXO3VEkr80SxCvkYVbXJ9lwLdZchkfSO9ukZqkDyPTltQzxmdjQmE3IhpCsUSsKmCq4/4XUkAXPg676cPOB1BX9lJH7hkXwdWTMMNE1ef3Y2C0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371269; c=relaxed/simple;
	bh=vGLbyT5ssO3VlUO2Yro4AyC2gfC+ZR9XdKKGexYkkBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkG/evWSZm7i4aUC6gGvKEiJQvZsCtPH2AHjD09kINQQEAtEwO93IpTG7CyFQ7fcv9EmpTuAUG2mYDg0pEckGNROkD7txDO97D3sLzuLsM04G9rwjPAFInFwoSIpjcyuKLYNzsxXYy4eXwGOM7IGG2cijfiDBfb6EW7klra3Hqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3cc0f4d8f11011f0a38c85956e01ac42-20260114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:727fcca2-2ac5-41a2-913f-7a0d34e91650,IP:0,UR
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
X-UUID: 3cc0f4d8f11011f0a38c85956e01ac42-20260114
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1733740910; Wed, 14 Jan 2026 14:14:08 +0800
Message-ID: <b06e4a63-85c2-4420-8077-f4c059ef33fb@kylinos.cn>
Date: Wed, 14 Jan 2026 14:14:06 +0800
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
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <aWYGWLEekWh3jJVf@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/13 16:46, Andy Shevchenko wrote:
> On Tue, Jan 13, 2026 at 04:27:42PM +0800, Feng Jiang wrote:
>> Introduce a benchmark to compare the architecture-optimized strlen()
>> implementation against the generic C version (__generic_strlen).
>>
>> The benchmark uses a table-driven approach to evaluate performance
>> across different string lengths (short, medium, and long). It employs
>> ktime_get() for timing and get_random_bytes() followed by null-byte
>> filtering to generate test data that prevents early termination.
>>
>> This helps in quantifying the performance gains of architecture-specific
>> optimizations on various platforms.
> 
> ...
> 
>> +static void string_test_strlen_bench(struct kunit *test)
>> +{
>> +	char *buf;
>> +	size_t buf_len, iters;
>> +	ktime_t start, end;
>> +	u64 time_arch, time_generic;
>> +
>> +	buf_len = get_max_bench_len(bench_cases, ARRAY_SIZE(bench_cases)) + 1;
>> +
>> +	buf = kunit_kzalloc(test, buf_len, GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>> +
>> +	for (size_t i = 0; i < ARRAY_SIZE(bench_cases); i++) {
>> +		get_random_nonzero_bytes(buf, bench_cases[i].len);
>> +		buf[bench_cases[i].len] = '\0';
>> +
>> +		iters = bench_cases[i].iterations;
>> +
>> +		/* 1. Benchmark the architecture-optimized version */
>> +		start = ktime_get();
>> +		for (unsigned int j = 0; j < iters; j++) {
>> +			OPTIMIZER_HIDE_VAR(buf);
>> +			(void)strlen(buf);
> 
> First Q: Are you sure the compiler doesn't replace this with __builtin_strlen() ?
> 
>> +		}
>> +		end = ktime_get();
>> +		time_arch = ktime_to_ns(ktime_sub(end, start));
>> +
>> +		/* 2. Benchmark the generic C version */
>> +		start = ktime_get();
>> +		for (unsigned int j = 0; j < iters; j++) {
>> +			OPTIMIZER_HIDE_VAR(buf);
>> +			(void)__generic_strlen(buf);
>> +		}
> 
> Are you sure the warmed up caches do not affect the benchmark? I think you need
> to flush / make caches dirty or so on each iteration.
> 
>> +		end = ktime_get();
>> +		time_generic = ktime_to_ns(ktime_sub(end, start));
>> +
>> +		string_bench_report(test, "strlen", &bench_cases[i],
>> +				time_arch, time_generic);
>> +	}
>> +}
> 
> 

Thank you for the catch. You are absolutely correct—the 2500x figure is heavily
distorted and does not reflect real-world performance.

I've found that by using a volatile function pointer to call the implementations
(instead of direct calls), the results returned to a realistic range. It appears
the previous benchmark logic allowed the compiler to over-optimize the test loop
in ways that skewed the data.

I will refactor the benchmark logic in v3, specifically referencing the crc32
KUnit implementation (e.g., using warm-up loops and adding preempt_disable()
to eliminate context-switch interference) to ensure the data is robust and accurate.

-- 
With Best Regards,
Feng Jiang

