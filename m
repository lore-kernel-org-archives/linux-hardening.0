Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC23329C69;
	Fri, 23 Jan 2026 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137947; cv=none; b=XSaXfgdRB1rw3NPrV4znXBYbmdziBN6589x8eycZ2htZmRET+hTThrGLFp0bUZWq8w+TxPKN3Gf8h4RnhNWUnzRNqUZjrC7fHzWfgyFKX8Jwq0Vg84Rp/s9FW7viVDPUcmkDgn0/PTgDjjiilaYeLotKgttQBSxT686jHPjm5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137947; c=relaxed/simple;
	bh=0xT1epDWb1FQ+J3N0zKCsi8H2EJTlZq0omhKZzCId4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXP0+QGxXIUrQOih9SdyKBMNT61bu23KMcAWtfOiZNI4UlXeXgvKRxYo4J2Q2dkdFRh9ZTIEU9G2gQS6GwHvpAMEArHozWUKokXDJbnWVPh0g29JBoIigW6KgR6LGZ91qUP7nxDO9BPNf6zIcvIR3kDdUZ1FGJ37qyIEIGv58EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4a2c610cf80911f0b0f03b4cfa9209d1-20260123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:90487520-6dca-4b2c-b653-8149c8121841,IP:0,UR
	L:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:3
X-CID-META: VersionHash:a9d874c,CLOUDID:832d07ec24574474af5f067b81ba0031,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:4|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a2c610cf80911f0b0f03b4cfa9209d1-20260123
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1599856752; Fri, 23 Jan 2026 11:12:03 +0800
Message-ID: <26d08954-2826-4c48-a540-6e0857faf5ec@kylinos.cn>
Date: Fri, 23 Jan 2026 11:12:00 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] riscv: optimize string functions and add kunit
 tests
To: David Laight <david.laight.linux@gmail.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, kees@kernel.org, andy@kernel.org,
 ebiggers@kernel.org, martin.petersen@oracle.com, ardb@kernel.org,
 charlie@rivosinc.com, conor.dooley@microchip.com, ajones@ventanamicro.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <aW8whGcAR0x6FSRJ@smile.fi.intel.com>
 <691a0183-6f41-4956-82da-abb69a449919@kylinos.cn>
 <CAHp75Ve_pyVm430FL=aEAw1Cnf-92T3Y23qh7pEOaMYMp9iyvw@mail.gmail.com>
 <20260121105717.04853c5d@pumpkin>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <20260121105717.04853c5d@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/21 18:57, David Laight wrote:
> On Wed, 21 Jan 2026 09:01:29 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> ...
>> I understand that. My point is if we move the generic implementation
>> to use word-at-a-time technique the difference should not go 4x,
>> right? Perhaps 1.5x or so. I believe this will be a very useful
>> exercise.
> 
> I posted a version earlier.
> 
> After the initial setup (aligning the base address and loading
> some constants the loop on x86-64 is 7 instructions (should be similar
> for other architectures).
> I think it will execute in 4 clocks.
> You then need to find the byte in the word, easy enough on LE with
> a fast ffs() - but harder otherwise.
> The real problem is the cost for short strings.
> Like memcpy() you need a hint from the source of the 'expected' length
> (as a compile-time constant) to compile-time select the algorithm.
> 
> OTOH:
> 	for (;;) {
> 		if (!ptr[0]) return ptr - start;
> 		ptr += 2;
> 	while (ptr[-1]);
> 	return ptr - start - 1;
> has two 'load+compare+branch' and one add per loop.
> On x86 that might all overlap and give you a two-clock loop
> that checks one byte every clock - faster than 'rep scasb'.
> (You can get a two clock loop, but not a 1 clock loop.)
> I think unrolling further will make little/no difference.
> 
> The break-even for the word-at-a-time version is probably at least 64
> characters.
> 

Thanks for the profound analysis and the detailed suggestions.

I am still exploring some of the finer points of these low-level performance
trade-offs, so your input is very helpful. I will definitely spend some time
studying this further and experiment with the approaches you mentioned.

Thanks again for your help!

-- 
With Best Regards,
Feng Jiang

