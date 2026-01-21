Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B83425CED;
	Wed, 21 Jan 2026 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974330; cv=none; b=lkbwSaUfHS3/jbwDpkyQ0g1lYf6QEB6vNTaDA7C3jXqJbyAuyPRO5nEKlDuSW1hj3yVWa/AfDNjJCW93eGG8wZW3gNWpwkVYI8grJc2P+J/BdyxiWGUcAxVX24Z3FsYOn7qD94oj7SaPqzePcHtn7mlK06XNLCKnLsjr4x4p4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974330; c=relaxed/simple;
	bh=FWDZkK+L4yICsmbedzmLgldR7qOeTM2GM+es8N4iNZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B23qvTwg9pb27oMEZDAcBXGiCUUGcU/WmjRtBPIGjzoIV/zJ9jLLKT24hJvlhBKqPZaHcqIjivphiQBoiUVtONY8b0pQy16jvbGQijiYHYC7eKGvUAh4KJQHbHpTrHqGN6VEd2eQ3UJcW7Jlpr3zf4FX7zZjWJ5iAFYrDIInP2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5ab3987af68c11f0b0f03b4cfa9209d1-20260121
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:508bdded-23e2-47af-bd06-24a8046211d7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:0fab305e8081ca41f69ad0fa902d795b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ab3987af68c11f0b0f03b4cfa9209d1-20260121
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1510422865; Wed, 21 Jan 2026 13:45:12 +0800
Message-ID: <e596e070-b3c1-4aae-8f7c-35f172f1fbbf@kylinos.cn>
Date: Wed, 21 Jan 2026 13:45:09 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] lib/string_kunit: add performance benchmarks for
 strlen
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, kees@kernel.org, andy@kernel.org,
 ebiggers@kernel.org, martin.petersen@oracle.com, ardb@kernel.org,
 charlie@rivosinc.com, conor.dooley@microchip.com, ajones@ventanamicro.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Joel Stanley <joel@jms.id.au>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-5-jiangfeng@kylinos.cn>
 <aW8y6eC7ZGRYIWkn@smile.fi.intel.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <aW8y6eC7ZGRYIWkn@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/20 15:46, Andy Shevchenko wrote:
> On Tue, Jan 20, 2026 at 02:58:48PM +0800, Feng Jiang wrote:
>> Introduce a benchmarking framework to the string_kunit test suite to
>> measure the execution efficiency of string functions.
>>
>> The implementation is inspired by crc_benchmark(), measuring throughput
>> (MB/s) and latency (ns/call) across a range of string lengths. It
>> includes a warm-up phase, disables preemption during measurement, and
>> uses a fixed seed for reproducible results.
>>
>> This allows for comparing different implementations (e.g., generic C vs.
>> architecture-optimized assembly) within the KUnit environment.
>>
>> Initially, provide benchmarks for strlen().
> 
> ...
> 
>> +#define STRING_BENCH_SEED	888
>> +#define STRING_BENCH_WORKLOAD	1000000UL
> 
> Can also be (1 * MEGA) from units.h.

Fixed.

> ...
> 
>> +static const size_t bench_lens[] = {
>> +	0, 1, 7, 8, 16, 31, 64, 127, 512, 1024, 3173, 4096
> 
> Leave trailing comma.

Fixed.

> ...
> 
>> +static void *alloc_max_bench_buffer(struct kunit *test,
>> +		const size_t *lens, size_t count, size_t *buf_len)
>> +{
>> +	void *buf;
>> +	size_t i, max_len = 0;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		if (max_len < lens[i])
>> +			max_len = lens[i];
>> +	}
>> +
>> +	/* Add space for NUL terminator */
>> +	max_len += 1;
> 
>> +	buf = kunit_kzalloc(test, max_len, GFP_KERNEL);
>> +	if (buf && buf_len)
>> +		*buf_len = max_len;
>> +
>> +	return buf;
> 
> 	if (!buf)
> 		return NULL;
> 
> 	*buf_len ...
> 	return buf;
> 

Fixed.

> ...
> 
>> +static void fill_random_string(char *buf, size_t len)
>> +{
>> +	size_t i;
>> +	struct rnd_state state;
> 
> Reversed xmas tree ordering?

Fixed.

>> +	if (!buf || !len)
>> +		return;
>> +
>> +	/* Use a fixed seed to ensure deterministic benchmark results */
>> +	prandom_seed_state(&state, 888);
>> +	prandom_bytes_state(&state, buf, len);
>> +
>> +	/* Replace null bytes to avoid early string termination */
>> +	for (i = 0; i < len; i++) {
>> +		if (buf[i] == '\0')
>> +			buf[i] = 0x01;
>> +	}
>> +
>> +	buf[len - 1] = '\0';
>> +}
> 
> ...
> 
>> +#define STRING_BENCH(iters, func, ...)					\
> 
> Is this same / similar code to crc_benchmark()? Perhaps we need to have KUnit
> provided macro / environment to perform such tests... Have you talked to KUnit
> people about all this?
> 

I haven't reached out to the KUnit maintainers yet. This implementation is currently
a lightweight adaptation specifically for string benchmarks. However, I agree that
a generic KUnit benchmarking harness would be beneficial for the kernel. For now,
I'll refine this version based on your feedback.

>> +({									\
>> +	u64 __bn_t;							\
>> +	size_t __bn_i;							\
>> +	size_t __bn_iters = (iters);					\
>> +	size_t __bn_warm_iters = max_t(size_t, __bn_iters / 10, 50U);	\
> 
> Try to avoid max_t() as much as possible. Wouldn't max() suffice?
> 

Will do.

>> +	/* Volatile function pointer prevents dead code elimination */	\
>> +	typeof(func) (* volatile __func) = (func);			\
>> +									\
>> +	for (__bn_i = 0; __bn_i < __bn_warm_iters; __bn_i++)		\
>> +		(void)__func(__VA_ARGS__);				\
>> +									\
>> +	preempt_disable();						\
>> +	__bn_t = ktime_get_ns();					\
>> +	for (__bn_i = 0; __bn_i < __bn_iters; __bn_i++)			\
>> +		(void)__func(__VA_ARGS__);				\
>> +	__bn_t = ktime_get_ns() - __bn_t;				\
>> +	preempt_enable();						\
>> +	__bn_t;								\
>> +})
>> +
>> +/**
>> + * STRING_BENCH_BUF() - Benchmark harness for single-buffer functions.
>> + * @test: KUnit context.
>> + * @buf_name: Local char * variable name to be defined.
>> + * @buf_size: Local size_t variable name to be defined.
>> + * @func: Function to benchmark.
>> + * @...: Extra arguments for @func.
>> + *
>> + * Prepares a randomized, null-terminated buffer and iterates through lengths
>> + * in bench_lens, defining @buf_name and @buf_size in each loop.
>> + */
>> +#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
>> +do {									\
>> +	char *buf_name, *_bn_buf;					\
>> +	size_t buf_size, _bn_i, _bn_iters, _bn_size = 0;		\
>> +	u64 _bn_t, _bn_mbps = 0, _bn_lat = 0;				\
>> +									\
>> +	if (!IS_ENABLED(CONFIG_STRING_KUNIT_BENCH))			\
>> +		kunit_skip(test, "not enabled");			\
>> +									\
>> +	_bn_buf = alloc_max_bench_buffer(test, bench_lens,		\
>> +			ARRAY_SIZE(bench_lens), &_bn_size);		\
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, _bn_buf);			\
>> +									\
>> +	fill_random_string(_bn_buf, _bn_size);				\
> 
>> +	_bn_buf[_bn_size - 1] = '\0';					\
> 
> You have already this there in the function, no?
> 

Indeed, that's redundant. I'll remove it.

>> +	for (_bn_i = 0; _bn_i < ARRAY_SIZE(bench_lens); _bn_i++) {	\
>> +		buf_size = bench_lens[_bn_i];				\
>> +		buf_name = _bn_buf + _bn_size - buf_size - 1;		\
>> +		_bn_iters = STRING_BENCH_WORKLOAD /			\
>> +				max_t(size_t, buf_size, 1U);		\
> 
> max()

Fixed.

>> +		_bn_t = STRING_BENCH(_bn_iters, func, ##__VA_ARGS__);	\
>> +									\
>> +		if (_bn_t > 0) {					\
>> +			_bn_mbps = (u64)(buf_size) * _bn_iters * 1000;	\
>> +			_bn_mbps = div64_u64(_bn_mbps, _bn_t);		\
>> +			_bn_lat = div64_u64(_bn_t, _bn_iters);		\
>> +		}							\
>> +		kunit_info(test, "len=%zu: %llu MB/s (%llu ns/call)\n",	\
>> +				buf_size, _bn_mbps, _bn_lat);		\
>> +	}								\
>> +} while (0)
> 

Thanks for the catch. I will incorporate all your suggestions into v4.

-- 
With Best Regards,
Feng Jiang

