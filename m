Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA24AEE2;
	Mon,  2 Feb 2026 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769995705; cv=none; b=LgNjG7aUIuMHVGBqVHbAvDlIsh2A36oINabtLPaj9VplnBVrqUKZV5ajZKeDbwuALN5W8QVk9b6tOy+63utaYL+ycdjareypTFIBFjDxYYJ6bxxSRT0x2OR4YhW6ZMi4MK/N0L+lojeQpEOBn1BIBNas7JU82+//gXlVQfVrMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769995705; c=relaxed/simple;
	bh=hamJgkqoZbreGoC6mGOUZ25VnQWwle5ZuJQ9Aw7hzQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzKiZPWyCsnHBdyHdc+8I/+uD+DArR5H8PlxVw5tkANocSBfQVP8yED/Kr4gE8cTTEVXu1fhjwJQqdXDyFis4B6Ljt06NyHfSRzHbrimNIPtNUJimpnFUGLsqpMyNKNMa551rDwEwKKA/Jl4a93fuXa+GR0lj2EzZ3LHn2K3a0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6ea9a1faffd611f0b0f03b4cfa9209d1-20260202
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ca328545-2630-42e0-a62c-96e9863b6705,IP:0,UR
	L:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:2
X-CID-META: VersionHash:a9d874c,CLOUDID:5b59c78184618424a391219ec9acb505,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:4|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6ea9a1faffd611f0b0f03b4cfa9209d1-20260202
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 419090633; Mon, 02 Feb 2026 09:28:09 +0800
Message-ID: <47264a53-aa5c-4814-ba3c-270e544cab88@kylinos.cn>
Date: Mon, 2 Feb 2026 09:28:06 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] riscv: optimize string functions and add kunit
 tests
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Kees Cook <kees@kernel.org>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, andy@kernel.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, herbert@gondor.apana.org.au,
 samuel.holland@sifive.com, ajones@ventanamicro.com,
 conor.dooley@microchip.com, charlie@rivosinc.com, nathan@kernel.org,
 linusw@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
 <202601300936.6EDA32E96@keescook> <aX3Q3O8qEasNeso8@smile.fi.intel.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <aX3Q3O8qEasNeso8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/31 17:52, Andy Shevchenko wrote:
> On Fri, Jan 30, 2026 at 09:37:36AM -0800, Kees Cook wrote:
>> On Fri, Jan 30, 2026 at 10:50:10AM +0800, Feng Jiang wrote:
>>> This series provides optimized implementations of strnlen(), strchr(),
>>> and strrchr() for the RISC-V architecture. The strnlen() implementation
>>> is derived from the existing optimized strlen(). For strchr() and
>>> strrchr(), the current versions use simple byte-by-byte assembly logic,
>>> which will serve as a baseline for future Zbb-based optimizations.
>>
>> I'm happy with the Kunit elements here, so unless Andy has other
>> feedback, please feel free to take this via the riscv tree. (Or if riscv
>> maintainers would prefer, I can take it via string.)
> 
> I have an impression that I already gave some tag. Why aren't not here?
> 

I apologize for the confusion.

In v6, following Kees Cook's suggestion, I introduced a significant change to
the correctness test logic—using vmalloc() and page-boundary alignment to
detect over-reads. Since this part of the code was substantially rewritten,
I felt it was more responsible to drop the previous Acked-by and Tested-by
tags for the affected patches.

I would be very grateful if you could take a quick look at the new test
implementation in v7. If you are satisfied with the changes, I would be
honored to add your tags back.

-- 
With Best Regards,
Feng Jiang

