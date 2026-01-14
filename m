Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1D2EA731;
	Wed, 14 Jan 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354885; cv=none; b=i+Lh0Y3Uwt0R/0FZMNX3j7etRlqA/YaFSWAE7qWaUUdCE2bPSqO+T/EzhPPMAEUTu7Zu5VE3DzAR0fE63a50aZAVHrO/74DRkhD0ORaAzm8zSSoxdof3hQGHIK/AAtaHOhxcmQtWdVEcd92U43ajXdT/2x6ecmIGrPC2jdZFzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354885; c=relaxed/simple;
	bh=+wVd870v69N8nTMS3HKPV9LYIALc5m4XDy6qEigIMcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgrN34fT93Wf3MuVKucA3rrLJQ1J7q2e4MRqQ/wxfIIKW3ecyRIc4HN1PDEN3TbGfaMxLod5vJ/y45Y+zDfJVfr5ndlOjptf6OOEZF919SBu6W9i0GORFalu3JWCarHz6qBrZepqRG8mZ3Lw0KMjoSojeHaG5Oxp//zErJSmVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1a45c698f0ea11f0a38c85956e01ac42-20260114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d47cd477-592e-44c6-aa76-f9be07a91177,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:c2b2352c259325bd87ffd9242c7194a2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1a45c698f0ea11f0a38c85956e01ac42-20260114
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2023845300; Wed, 14 Jan 2026 09:41:10 +0800
Message-ID: <3cd30ebc-0f85-4a0d-88cd-76783b872053@kylinos.cn>
Date: Wed, 14 Jan 2026 09:41:07 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] lib/string: extract generic strlen() into
 __generic_strlen()
To: Eric Biggers <ebiggers@kernel.org>, andy@kernel.org
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
 martin.petersen@oracle.com, ardb@kernel.org, ajones@ventanamicro.com,
 conor.dooley@microchip.com, samuel.holland@sifive.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-2-jiangfeng@kylinos.cn> <20260114000151.GB2178@quark>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <20260114000151.GB2178@quark>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/14 08:01, Eric Biggers wrote:
> On Tue, Jan 13, 2026 at 04:27:35PM +0800, Feng Jiang wrote:
>> To support performance benchmarking in KUnit tests, extract the
>> generic C implementation of strlen() into a standalone function
>> __generic_strlen(). This allows tests to compare architecture-optimized
>> versions against the generic baseline without duplicating code.
>>
>> Suggested-by: Andy Shevchenko <andy@kernel.org>
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>> ---
>>  include/linux/string.h |  1 +
>>  lib/string.c           | 10 ++++++++--
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/string.h b/include/linux/string.h
>> index 1b564c36d721..961645633b4d 100644
>> --- a/include/linux/string.h
>> +++ b/include/linux/string.h
>> @@ -197,6 +197,7 @@ extern char * strstr(const char *, const char *);
>>  #ifndef __HAVE_ARCH_STRNSTR
>>  extern char * strnstr(const char *, const char *, size_t);
>>  #endif
>> +extern __kernel_size_t __generic_strlen(const char *);
>>  #ifndef __HAVE_ARCH_STRLEN
>>  extern __kernel_size_t strlen(const char *);
>>  #endif
>> diff --git a/lib/string.c b/lib/string.c
>> index b632c71df1a5..047ecb38e09b 100644
>> --- a/lib/string.c
>> +++ b/lib/string.c
>> @@ -412,8 +412,7 @@ char *strnchr(const char *s, size_t count, int c)
>>  EXPORT_SYMBOL(strnchr);
>>  #endif
>>  
>> -#ifndef __HAVE_ARCH_STRLEN
>> -size_t strlen(const char *s)
>> +size_t __generic_strlen(const char *s)
>>  {
>>  	const char *sc;
>>  
>> @@ -421,6 +420,13 @@ size_t strlen(const char *s)
>>  		/* nothing */;
>>  	return sc - s;
>>  }
>> +EXPORT_SYMBOL(__generic_strlen);
>> +
>> +#ifndef __HAVE_ARCH_STRLEN
>> +size_t strlen(const char *s)
>> +{
>> +	return __generic_strlen(s);
>> +}
>>  EXPORT_SYMBOL(strlen);
> 
> A similar problem exists with the architecture-optimized CRC and crypto
> functions.  Historically, these subsystems exported both generic and
> architecture-optimized functions.
> 
> We've actually been moving away from that design to simplify things.
> For example, for CRC-32C there's now just the crc32c() function which
> delegates to the "best" CRC-32C implementation, with no direct access to
> the generic implementation of CRC-32C.
> 
> crc_kunit then just tests and benchmarks crc32c().  To check how the
> performance of crc32c() changes when its implementation changes (whether
> the change is the addition of an arch-optimized implementation or a
> change in an existing arch-optimized implementation), the developer just
> needs to run crc_kunit with two kernels, before and after.
> 
> I suggest just doing that.  In that case there would be no need to
> export the generic implementations of these functions.
> 
> (Also note that *if* the generic functions are exported, they probably
> should be exported only when the KUnit test is enabled.  There's no need
> to include them in the kernel image when the test isn't enabled.)
> 
> - Eric

Hi Eric, Andy,

Thanks for the insights. I agree with Eric's point on keeping the internal
implementations encapsulated. It's a cleaner design for the long term.
In v3, I will drop the __generic_* exports and simplify the patchset
to benchmark only the standard functions.

To address Andy's concern regarding performance, I will provide a "Before
vs. After" comparison in the v3 cover letter. This should demonstrate
the speedup while keeping the core kernel code tidy. I'll also refine the
benchmark logic to ensure more realistic results as discussed.

This seems to be the most robust way to validate the optimizations without
adding unnecessary exports.

-- 
With Best Regards,
Feng Jiang

