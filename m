Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5422566E9;
	Mon, 26 Jan 2026 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408066; cv=none; b=iCxvtQGt9c4ROXeVfGst1LHLj7hToz14L0sWYs2zUsDSqSuIgdQJWyVC2NHS7+cBb3r9nmksR8vDPSYLrh0maOU0+mCrGJqG7CJM3Pavq8uEbEzfzYu/I6WQglfwxhr0UFLKjrG3tevJJXFlhForKv2j/mCa7b0XHpijyWfHzrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408066; c=relaxed/simple;
	bh=6xJe9WF3eviWzuNmox8j94NcRQKPqUbjmbof8DJWU98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/96Q5mak6o52GKUO4swxAjgyx4V6CP8KTRI7TuWNt09eh+WxJlE7TWyt8KPTs9EpX9vGjgVIfFjcwX9g2W7R4vUdFi4Pj0RCZbEEiKuhybi4JF3Hkawm0FrKM9Nmc9+qGDaUwqCPrMdQ7SytnH6OoSlIG5ah5D1DY7yb4uJgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f1cce4cfa7e11f0b0f03b4cfa9209d1-20260126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:967e08eb-15e0-4632-bf90-ea894c8c5d44,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:8e5d8eb21336d9844e695e1d29f0d6ca,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3f1cce4cfa7e11f0b0f03b4cfa9209d1-20260126
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 744551173; Mon, 26 Jan 2026 14:14:18 +0800
Message-ID: <b637ecfb-e852-4864-a80e-fdcd34d93cbd@kylinos.cn>
Date: Mon, 26 Jan 2026 14:14:14 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] lib/string_kunit: add performance benchmark for
 strlen()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, kees@kernel.org, andy@kernel.org,
 ebiggers@kernel.org, martin.petersen@oracle.com, mingo@kernel.org,
 charlie@rivosinc.com, conor.dooley@microchip.com, samuel.holland@sifive.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260123085841.212468-1-jiangfeng@kylinos.cn>
 <20260123085841.212468-5-jiangfeng@kylinos.cn>
 <aXNVL318XTTQ3tsU@smile.fi.intel.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <aXNVL318XTTQ3tsU@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/23 19:02, Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 04:58:37PM +0800, Feng Jiang wrote:
>> Introduce a benchmarking framework to the string_kunit test suite to
>> measure the execution efficiency of string functions.
>>
>> The implementation is inspired by crc_benchmark(), measuring throughput
>> (MB/s) and latency (ns/call) across a range of string lengths. It
>> includes a warm-up phase, disables preemption during measurement, and
>> uses a fixed seed for reproducible results.
>>
>> This framework allows for comparing different implementations (e.g.,
>> generic C vs. architecture-optimized assembly) within the KUnit
>> environment.
>>
>> Initially, provide a benchmark for strlen().
> 
> ...
> 
>> +static void *alloc_max_bench_buffer(struct kunit *test,
>> +		const size_t *lens, size_t count, size_t *buf_len)
>> +{
>> +	size_t i, max_len = 0;
>> +	void *buf;
> 
>> +	for (i = 0; i < count; i++) {
>> +		if (max_len < lens[i])
>> +			max_len = lens[i];
>> +	}
> 
> 	size_t max_len = 0;
> 	void *buf;
> 
> 	for (size_t i = 0; i < count; i++)
> 		max_len = max(lens[i], max_len);
> 

Agreed. I will simplify the loop and use max() as suggested.

>> +	/* Add space for NUL character */
>> +	max_len += 1;
>> +
>> +	buf = kunit_kzalloc(test, max_len, GFP_KERNEL);
>> +	if (!buf)
>> +		return NULL;
>> +
>> +	if (buf_len)
>> +		*buf_len = max_len;
>> +
>> +	return buf;
>> +}
> 
> ...
> 
>> +#define STRING_BENCH(iters, func, ...)					\
>> +({									\
>> +	/* Volatile function pointer prevents dead code elimination */	\
>> +	typeof(func) (* volatile __func) = (func);			\
>> +	size_t __bn_iters = (iters);					\
>> +	size_t __bn_warm_iters;						\
> 
>> +	size_t __bn_i;							\
> 
> Define it inside for-loop:s.
> 

Will do.

>> +	u64 __bn_t;							\
>> +									\
>> +	__bn_warm_iters = max(__bn_iters / 10, 50U);			\
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
> 
> ...
> 
>> +#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
>> +do {									\
>> +	size_t buf_size, _bn_i, _bn_iters, _bn_size = 0;		\
>> +	u64 _bn_t, _bn_mbps = 0, _bn_lat = 0;				\
>> +	char *buf_name, *_bn_buf;					\
> 
>> +	if (!IS_ENABLED(CONFIG_STRING_KUNIT_BENCH))			\
>> +		kunit_skip(test, "not enabled");			\
> 
> Hmm... Since it's a macro anyway, I think the old style is okay:
> > 
> #if IS_ENABLED(CONFIG_STRING_KUNIT_BENCH)
> #define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
> 	...
> #else
> #define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
> 	kunit_skip(test, "not enabled");				\
> #endif
> 
> But check it that it doesn't produce warnings in `make W=1` case.
> 

Thanks. Using #if IS_ENABLED(...) to define the macro differently is cleaner.
I will implement it this way and ensure it passes make W=1 without warnings

>> +	_bn_buf = alloc_max_bench_buffer(test, bench_lens,		\
>> +			ARRAY_SIZE(bench_lens), &_bn_size);		\
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, _bn_buf);			\
>> +									\
>> +	fill_random_string(_bn_buf, _bn_size);				\
>> +									\
>> +	for (_bn_i = 0; _bn_i < ARRAY_SIZE(bench_lens); _bn_i++) {	\
>> +		buf_size = bench_lens[_bn_i];				\
>> +		buf_name = _bn_buf + _bn_size - buf_size - 1;		\
>> +		_bn_iters = STRING_BENCH_WORKLOAD / max(buf_size, 1U);	\
>> +									\
>> +		_bn_t = STRING_BENCH(_bn_iters, func, ##__VA_ARGS__);	\
>> +									\
>> +		if (_bn_t > 0) {					\
>> +			_bn_mbps = (u64)(buf_size) * _bn_iters * 1000;	\
> 
> "KILO"? Or "(MEGA/KILO)"? I'm puzzled with this 1000 multiplier.
> 

The 1000 factor converts bytes/ns to MB/s：
  (bytes/ns) * (10^9 ns/s) / (10^6 bytes/MB)
In v5, I will replace it with (NSEC_PER_SEC / MEGA) to make the unit
conversion explicit and avoid confusion.

>> +			_bn_mbps = div64_u64(_bn_mbps, _bn_t);		\
>> +			_bn_lat = div64_u64(_bn_t, _bn_iters);		\
>> +		}							\
>> +		kunit_info(test, "len=%zu: %llu MB/s (%llu ns/call)\n",	\
>> +				buf_size, _bn_mbps, _bn_lat);		\
>> +	}								\
>> +} while (0)
> 

Thanks again for your time and for the detailed review!

-- 
With Best Regards,
Feng Jiang

