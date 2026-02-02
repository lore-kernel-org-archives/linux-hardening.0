Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91675D8F0;
	Mon,  2 Feb 2026 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770002662; cv=none; b=ch8zXNVSvh6h1o7f2YyqDGLSC0uQXKe+uPfmAkAUvOdPoPPn+VEPHQabzv4xvdxNyAZ0FWTLpRW316XRJwDVXJ/0kiHOnRGwHTEhrhNqWyEqTDspb4hZfp67JubcfXL4ump+wAtUGqo6o0ywZMJS2u4jtPPZPHBSl/lH7HAl2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770002662; c=relaxed/simple;
	bh=ChlL+VclYmFcSb2W7UV26tBAjbqBVqSmhWrPdWyP7Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzsFa3XIVdEQkwfE+fGnjkTVBGdzxPJeexfuMlam0NyDo+BK7pnMYE/arjczk9r9CKGyJ8AOQo5fBZ/8wWkEP8jF1XKbRsLCFnw4cnRvDTEDWnoUpX/oBRi/2jA7BgmfqACY6vK74uhLA9IDVOpiiwUZwbtx6vfpBu+IqkhQ4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a3ea2898ffe611f0b0f03b4cfa9209d1-20260202
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:650c2ba8-0de9-41d5-b1e4-a5d1a5c681a0,IP:0,UR
	L:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:2
X-CID-META: VersionHash:a9d874c,CLOUDID:ac3f64aecb564f5a94453d2e355e200f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:4|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a3ea2898ffe611f0b0f03b4cfa9209d1-20260202
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 707133680; Mon, 02 Feb 2026 11:24:10 +0800
Message-ID: <484c9672-75a6-450f-b677-548000031942@kylinos.cn>
Date: Mon, 2 Feb 2026 11:24:07 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] riscv: optimize string functions and add kunit
 tests
To: Kees Cook <kees@kernel.org>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, andy@kernel.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, herbert@gondor.apana.org.au,
 samuel.holland@sifive.com, ajones@ventanamicro.com,
 conor.dooley@microchip.com, charlie@rivosinc.com, nathan@kernel.org,
 linusw@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
 <202601300936.6EDA32E96@keescook>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <202601300936.6EDA32E96@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/31 01:37, Kees Cook wrote:
> On Fri, Jan 30, 2026 at 10:50:10AM +0800, Feng Jiang wrote:
>> This series provides optimized implementations of strnlen(), strchr(),
>> and strrchr() for the RISC-V architecture. The strnlen() implementation
>> is derived from the existing optimized strlen(). For strchr() and
>> strrchr(), the current versions use simple byte-by-byte assembly logic,
>> which will serve as a baseline for future Zbb-based optimizations.
> 
> I'm happy with the Kunit elements here, so unless Andy has other
> feedback, please feel free to take this via the riscv tree. (Or if riscv
> maintainers would prefer, I can take it via string.)
> 
> Thanks for working on this!

Thank you very much for your review and the previous suggestions for improvement.
I truly appreciate your patience and guidance throughout this process!

-- 
With Best Regards,
Feng Jiang

