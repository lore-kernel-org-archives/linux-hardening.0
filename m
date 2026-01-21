Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53E477990;
	Wed, 21 Jan 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983171; cv=none; b=aCrz9U+cbNARpcKTI5qM9eeUrb3jYSAjgx4RRmC63fpt721Uw9TVyylU90909tNiJbJFBCJG/UC3crygL3bOcAMJgrnIC/QtS4OadO7fxb5Uo9WNyFbWR8e0NnJV7AVhS/MGG51dRoxb1OL3j7Qs/nd04FvBVC8N+bBJ7RIsEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983171; c=relaxed/simple;
	bh=4J7EWAymz9IabsaJAQNZtrgK18i9Rew9CCDiQfwC2L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJPNwUMyLhhlI0lLmRuZ8atViSADUteSRMvf/CSN4kRT+IRuwvQ0evLkbS+fshqBmFM70n1B6TcSuR8P28pOunIJtGN5rglcQzftsNACPtviTXnIjnSFRqMaw9TP97mXg35OUXFHdeHjj00PGPObSlB7m6Az72+Tn2E+NKIrYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f00c6b04f6a011f0b0f03b4cfa9209d1-20260121
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:74250277-37fa-4705-b49d-a8c4cbdd6a8c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:5c81ccfe12d22ec145f41d8a9028c491,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f00c6b04f6a011f0b0f03b4cfa9209d1-20260121
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 161648402; Wed, 21 Jan 2026 16:12:33 +0800
Message-ID: <16313365-b51e-47d2-aae8-633dbfc8a3fa@kylinos.cn>
Date: Wed, 21 Jan 2026 16:12:30 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] riscv: optimize string functions and add kunit
 tests
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <CAHp75Ve_pyVm430FL=aEAw1Cnf-92T3Y23qh7pEOaMYMp9iyvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/21 15:01, Andy Shevchenko wrote:
> On Wed, Jan 21, 2026 at 8:44 AM Feng Jiang <jiangfeng@kylinos.cn> wrote:
>> On 2026/1/20 15:36, Andy Shevchenko wrote:
>>> On Tue, Jan 20, 2026 at 02:58:44PM +0800, Feng Jiang wrote:
> 
> ...
>>>> word-at-a-time logic, showing significant gains as the string length
>>>> increases.
>>>
>>> Hmm... Have you tried to optimise the generic implementation to use
>>> word-at-a-time logic and compare?
>>
>> Regarding the generic implementation, even if we were to optimize the C code
>> to use word-at-a-time logic (the has_zero() style bit-manipulation), it still
>> wouldn't match the Zbb version's efficiency.
>>
>> The traditional C-based word-level detection requires a sequence of arithmetic
>> operations to identify NUL bytes. In contrast, the RISC-V orc.b instruction
>> collapses this entire check into a single hardware cycle. I've focused on this
>> architectural approach to fully leverage these specific Zbb features, which
>> provides a level of instruction density that generic C math cannot achieve.
> 
> I understand that. My point is if we move the generic implementation
> to use word-at-a-time technique the difference should not go 4x,
> right? Perhaps 1.5x or so. I believe this will be a very useful
> exercise.
> 

That is a very insightful point, thanks for the suggestion. I'll look into
optimizing the generic string library as a follow-up task to see if we can
bring some improvements there as well. 

Thanks again for the guidance.

-- 
With Best Regards,
Feng Jiang

