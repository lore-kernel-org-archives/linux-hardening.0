Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82299443035;
	Thu,  8 Jan 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866439; cv=none; b=qwAzIVTSvm7iWcRSV0UF5Chq0qVFKgZzkWyJdU7GIW7TAMWHYvrohmeO6Z7Mbnc0ahUCWIInNv2kdr7q7Sjv5pahyTjSke6eyNkBnSxwWek2Jl1Oz436aGxOjQqICna3RGTJRncALs69sFPCXOCp1f2Mu+3C6bfSLwyZB3OtFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866439; c=relaxed/simple;
	bh=h2tBfMZ9a3jUBDKYBsVoZXdDvUxBJkWrbiilRaVF76I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ze5QTQ00OpyczbXut9BzK81OGOj3Zy53aLMghTEfbrws7iXV2gBS6Ks4oU496dOTksfNZC4S7MJYfDa4vDQGqXdZypEZiwO0shTH/KfVxJ9Egua5CkLQjJ92MfStNX8fpb3TRBff+ziOwnqH4e34XsBDQp8bQgG3pkg9eA4TfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d9ba585cec7811f0a38c85956e01ac42-20260108
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:92d9c349-e32f-4ee6-b4bd-7d53920b3c09,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:cd288c550dff6a7cd085b327586eb50b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d9ba585cec7811f0a38c85956e01ac42-20260108
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 12501923; Thu, 08 Jan 2026 18:00:24 +0800
Message-ID: <e02320c8-eff2-44af-a66c-a3c7ca9ca0ea@kylinos.cn>
Date: Thu, 8 Jan 2026 18:00:21 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] lib/string_kunit: add test case for strnlen
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org,
 andy@kernel.org, ebiggers@kernel.org, martin.petersen@oracle.com,
 Jason@zx2c4.com, conor.dooley@microchip.com, samuel.holland@sifive.com,
 charlie@rivosinc.com, ajones@ventanamicro.com, nathan@kernel.org,
 linus.walleij@linaro.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260107023517.46840-1-jiangfeng@kylinos.cn>
 <20260107023517.46840-3-jiangfeng@kylinos.cn>
 <CAHp75VfxT+K1QRc5ayZGc4joB9vFJrk7kjQ4gAgUHOT1boFbmA@mail.gmail.com>
 <b419c6db-0f3f-4666-8f7c-156f7eda2b5b@kylinos.cn>
 <aV9cQ2QMA-jwFNUO@smile.fi.intel.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <aV9cQ2QMA-jwFNUO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/8 15:26, Andy Shevchenko wrote:
> On Thu, Jan 08, 2026 at 02:53:58PM +0800, Feng Jiang wrote:
>> On 2026/1/7 19:56, Andy Shevchenko wrote:
>>> On Wed, Jan 7, 2026 at 4:35 AM Feng Jiang <jiangfeng@kylinos.cn> wrote:
> 
> ...
> 
>>>> Add a KUnit test for strnlen() to verify correctness across
>>>> different string lengths and memory alignments.
>>>
>>> Same comment as per patch 1 (it would probably require to call for
>>> arch_strnlen() or something like this).
>>
>> Thanks, makes sense.
>>
>> I'll add the performance benchmarking (random filling + timing) in V2.
>>
>> Since string functions are typically exported directly by each architecture
>> without an arch_ prefix, I'll introduce a generic_strnlen() (based on
>> lib/string.c) within the test for comparison.
> 
> Probably you want to make the existing one to have that name and use it inside
> the test and in the fallback wrapper. We don't want to have duplicate code, it
> is bad from maintenance perspective.
> 

Thanks for the suggestions!

To avoid code duplication, I'll rename the generic implementation in lib/string.c
to __generic_strnlen() and keep the original strnlen() as a wrapper. Then I'll use
the generic one in the KUnit test for comparison.

Does this approach look good to you?

-- 
With Best Regards,
Feng Jiang

