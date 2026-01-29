Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80F35292D;
	Thu, 29 Jan 2026 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653164; cv=none; b=mDtSquRXcSxKM1lxiA8KSIP1PlfWT3CuI6Anbd+sRDuxBOjz3W+dMHn0oEnDT7c2eUC6k1FumOoK+JoeFS71eu/UrKjSgSIvVTWKknbwuSrNO7zQmIzrEbtQPtHbrXrSY9H0pJmvjOPtuZ6xjLstanHFu/cTV3mLoQvpI8qGpUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653164; c=relaxed/simple;
	bh=JyzWH6jFBTdjbwzVd96gr6R67EfTycWkvMtwpyMIqAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGWTKkweDmgEKCwrUD6+9XS6MpcgdpEAfCAYrqWkAkXXtX5eLDdeRDYjTyzBCLjNoLWmmcAu9flLs6hTyNFGkCwdeIapPvSBbZq+RNn7qvVlbeKXv4SrtaFLO1jk6/dtY9nWArOw9DJLyq/taruW5TUVGuRY9BoXV1pJePtQL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e7990fc2fcb811f0b0f03b4cfa9209d1-20260129
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f891207d-7053-44ab-a336-3feadf09848e,IP:0,UR
	L:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:2
X-CID-META: VersionHash:a9d874c,CLOUDID:93b2c925ebfb35e9375b0a36792dc51a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:4|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e7990fc2fcb811f0b0f03b4cfa9209d1-20260129
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1471132287; Thu, 29 Jan 2026 10:19:13 +0800
Message-ID: <1792d41f-fa5b-4507-98d4-cb8f671cde96@kylinos.cn>
Date: Thu, 29 Jan 2026 10:19:10 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] lib/string_kunit: add correctness test for
 strlen()
To: Kees Cook <kees@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, andy@kernel.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, sohil.mehta@intel.com, charlie@rivosinc.com,
 conor.dooley@microchip.com, samuel.holland@sifive.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Joel Stanley <joel@jms.id.au>
References: <20260127012558.40025-1-jiangfeng@kylinos.cn>
 <20260127012558.40025-2-jiangfeng@kylinos.cn>
 <202601281437.F327FC61@keescook>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <202601281437.F327FC61@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/29 06:39, Kees Cook wrote:
> On Tue, Jan 27, 2026 at 09:25:51AM +0800, Feng Jiang wrote:
>> Add a KUnit test for strlen() to verify correctness across
>> different string lengths and memory alignments.
>>
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>> Acked-by: Andy Shevchenko <andy@kernel.org>
>> Tested-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  lib/tests/string_kunit.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
>> index f9a8e557ba77..bc5130c6e5e9 100644
>> --- a/lib/tests/string_kunit.c
>> +++ b/lib/tests/string_kunit.c
>> @@ -17,6 +17,9 @@
>>  #define STRCMP_TEST_EXPECT_LOWER(test, fn, ...) KUNIT_EXPECT_LT(test, fn(__VA_ARGS__), 0)
>>  #define STRCMP_TEST_EXPECT_GREATER(test, fn, ...) KUNIT_EXPECT_GT(test, fn(__VA_ARGS__), 0)
>>  
>> +#define STRING_TEST_MAX_LEN	128
>> +#define STRING_TEST_MAX_OFFSET	16
>> +
>>  static void string_test_memset16(struct kunit *test)
>>  {
>>  	unsigned i, j, k;
>> @@ -104,6 +107,28 @@ static void string_test_memset64(struct kunit *test)
>>  	}
>>  }
>>  
>> +static void string_test_strlen(struct kunit *test)
>> +{
>> +	const size_t buf_size = STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1;
>> +	size_t len, offset;
>> +	char *s;
>> +
>> +	s = kunit_kzalloc(test, buf_size, GFP_KERNEL);
> 
> One aspect of "correctness" that we might want to include here is making
> sure we don't have any implementations that over-read. To that end,
> perhaps this test can put the string at the end of a vmalloc allocation
> (so that the end of the string is right up against an unallocated memory
> space).
> 
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s);
>> +
>> +	memset(s, 'A', buf_size);
>> +	s[buf_size - 1] = '\0';
>> +
>> +	for (offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
>> +		for (len = 0; len <= STRING_TEST_MAX_LEN; len++) {
>> +			s[offset + len] = '\0';
>> +			KUNIT_EXPECT_EQ_MSG(test, strlen(s + offset), len,
>> +				"offset:%zu len:%zu", offset, len);
>> +			s[offset + len] = 'A';
>> +		}
>> +	}
>> +}
> 
> It would require building the string backwards here. Or maybe we just
> need a separate test for the over-read concerns?
> 
> Thoughts?

Thanks for the suggestion! That is a very effective way to catch potential
over-reads in optimized implementations.

I will refactor the correctness tests in v6 to use a vmalloc-allocated page
and ensure the NUL character is positioned at the very end of the allocation
boundary.

I'll send out the v6 patch set shortly with these changes.

-- 
With Best Regards,
Feng Jiang

