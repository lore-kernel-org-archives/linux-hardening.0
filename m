Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E71BD9D0;
	Mon, 19 Jan 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814704; cv=none; b=DX+4E3LOWYZP01XOZW6GBp+xTNrKDWAmu19KT8m7s6KrOtX4XrUWcG6DlOTztDCEhhemu+68gX2sPBIJL3aDFoQJ+7C3YS0C+oFG7/IC4elWOUzYYILYbmGj8l0RYTfAxSMgGTlEVVwywZBaJgjQ/RGkfxuWeGAOf8D7W1zw608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814704; c=relaxed/simple;
	bh=JRgQDAI4uJurC4XlS5JiC/ehn0cdewA28qsAWvQO1Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKrVKypMi4RAlgPbfCGLEhPLfdwx0QTxo6U+v9pd4AH8ClZXS5y2jV90RMzAfM1iG90rP0xKKECl3U9XfDa8vBauDGya6K8QNn7ltRiiofU7hcc70fvI7rkJUPHY2BCLDyDTw1SNgi6xD3mixwp4MrHTRWHwzz7TRxU1f4G7TIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b6c1495cf51811f0b0f03b4cfa9209d1-20260119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:856d4e8e-050a-41bd-a991-c28f59ac7069,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:27605276af80639d37ed3d12c814a6b5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b6c1495cf51811f0b0f03b4cfa9209d1-20260119
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1072398959; Mon, 19 Jan 2026 17:24:54 +0800
Message-ID: <298c3f7c-42d3-4514-864a-104d64363cd8@kylinos.cn>
Date: Mon, 19 Jan 2026 17:24:50 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] riscv: optimize string functions and add kunit
 tests
To: Joel Stanley <joel@jms.id.au>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
 ebiggers@kernel.org, martin.petersen@oracle.com, ardb@kernel.org,
 ajones@ventanamicro.com, conor.dooley@microchip.com,
 samuel.holland@sifive.com, linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 "dfustini@oss.tenstorrent.com" <dfustini@oss.tenstorrent.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <CACPK8Xc2inE8=mbPFt+iTtgOqF_1U9m+76014aDaQxVyTYy2UQ@mail.gmail.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <CACPK8Xc2inE8=mbPFt+iTtgOqF_1U9m+76014aDaQxVyTYy2UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/15 12:43, Joel Stanley wrote:
> On Tue, 13 Jan 2026 at 18:58, Feng Jiang <jiangfeng@kylinos.cn> wrote:
>>
>> This series introduces optimized assembly implementations for strnlen,
>> strchr, and strrchr on the RISC-V architecture. To support a rigorous
>> verification process, the series also significantly expands the
>> string_kunit test suite with both functional correctness tests and
>> performance benchmarks.
> 
> I ran the kunit tests on Ascalon, a RVA23 CPU, in emulation. The arch
> optimised version showed significant improvements over the plain
> version.
> 
> I didn't have time to investigate if the numbers made sense. As Andy
> noted, the 'long' benchmark had a much higher ratio improvement than
> the short and medium.
> 
> Tested-by: Joel Stanley <joel@jms.id.au>
> 

Thank you very much for your time and the test results.

You were absolutely right to question the numbers. I've realized there were
some flaws in the previous benchmark logic that led to those inconsistent
ratios. I am sincerely sorry for the confusion this may have caused.

I am currently refining the implementation for v3 to ensure much more
accurate and reliable measurements. I'll send out the updated series
once it's ready.

Thanks again for helping me catch this!

-- 
With Best Regards,
Feng Jiang

