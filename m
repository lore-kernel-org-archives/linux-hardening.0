Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A8239594;
	Thu, 15 Jan 2026 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459861; cv=none; b=taiXAlmPZRd2qW7MZ9STYqgUwCLp9LUfpYtRav8BbtCWY0UoxjAcmgIdbqLBl2iZAJtsyoUX7kjtcRtMbR9XtxRwE1AK20dTY8o4ZJdqNSErkbcXgLIPqKwKPiFG2gVzO1ndf2StbA4gQXgHvzdmknCPWa2TtYrQK39SYbA8SA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459861; c=relaxed/simple;
	bh=0rJZFvLtm00wFXhC96/NHuFRMdAH8gYxLorl6bViWJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbYjSumzadkhfXGE35EQ93DufQS5qUJuiikuqexQZA1NQRpZVI6NVERooKZydlfPR5zCu1mutBXQ+tRI6j8XjXRp9DfFgSJdwYtEbRHvBMzWOL4r+hL7Iq4vgKG0qtyBEBvjswL7C5oyqHsbHVycM9J4hZvvNeCBSeqBnnVcllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8317f14cf1de11f0a38c85956e01ac42-20260115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:486b875c-b8e9-4501-afd8-875aa0dacc1a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:c90fa56c603edfa88239f368fa568c00,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8317f14cf1de11f0a38c85956e01ac42-20260115
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 69164715; Thu, 15 Jan 2026 14:50:43 +0800
Message-ID: <19a5a6bd-2645-4be6-9e21-c78e820886c5@kylinos.cn>
Date: Thu, 15 Jan 2026 14:50:40 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] lib/string: extract generic strlen() into
 __generic_strlen()
To: David Laight <david.laight.linux@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
 martin.petersen@oracle.com, ardb@kernel.org, ajones@ventanamicro.com,
 conor.dooley@microchip.com, samuel.holland@sifive.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-2-jiangfeng@kylinos.cn> <20260114000151.GB2178@quark>
 <20260114101034.7961852a@pumpkin>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <20260114101034.7961852a@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/14 18:10, David Laight wrote:
> On Tue, 13 Jan 2026 16:01:51 -0800
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> ..
>> A similar problem exists with the architecture-optimized CRC and crypto
>> functions.  Historically, these subsystems exported both generic and
>> architecture-optimized functions.
>>
>> We've actually been moving away from that design to simplify things.
>> For example, for CRC-32C there's now just the crc32c() function which
>> delegates to the "best" CRC-32C implementation, with no direct access to
>> the generic implementation of CRC-32C.
>>
>> crc_kunit then just tests and benchmarks crc32c().  To check how the
>> performance of crc32c() changes when its implementation changes (whether
>> the change is the addition of an arch-optimized implementation or a
>> change in an existing arch-optimized implementation), the developer just
>> needs to run crc_kunit with two kernels, before and after.
> 
> For the mul_div tests I arranged that the test code could #include the
> source for the generic implementation so it could run that as well as
> the version compiled into the main kernel.
> 
> This involved wrapping the function in:
> #if !defined(function) || defined(test_function)
> type function(args)
> ...
> }
> #if !defined(function)
> EXPORT_SYMBOL(function)
> #endif
> #endif
> 
> So the test code can use:
> #define function generic_function
> #define test_function
> #include "function.c"
> 
> to get a private copy of the generic code.

Thank you for the suggestion! That technique is very clever and interesting—
I've definitely learned something new and will keep it in mind for the future.

However, since lib/string.c is such a foundational and low-level library, I'm
hesitant to add macro wrappers or conditional blocks for KUnit. Given its
importance, I feel that increasing its complexity for side-by-side testing
isn't quite worth it. I'd prefer to keep the core code clean and follow Eric's
minimalist approach of benchmarking across different kernel configurations.

I really appreciate the guidance!

-- 
With Best Regards,
Feng Jiang

