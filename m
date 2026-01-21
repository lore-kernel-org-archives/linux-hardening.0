Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193D363C4F;
	Wed, 21 Jan 2026 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974510; cv=none; b=W5WAtdc2o1kQuOOI6scfUrJF2NEuEu8JRI5AUAlArWYQOSPU5RZPgMmxcoANCpYavoJDLhx0+7BighP8dZGmI5phq+xqGM9V3sUryxVmFBRtDkKBxFSkrSoVMqCrByq9+QhlTkO/iMt9Ql8FCsm8RVyMQXxNXB3nP5nADwvsjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974510; c=relaxed/simple;
	bh=O2alSnPSOpvRy+ZBxScSsTqnf25fHPLBCE5S7M2E5fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcU0aco11o5c1yA/upRiG6xeXES2ct/l8JCCqU2QI6/OjHJEbBvsYq4/vxe6cyYPTgGbk2uNdB77zgMVDeTt9mEdXXYCcMB80Fdm0f0oh5I/DltXzBf3UfSsSyjyYKgvZD/H/THaLp0rQfF/Zn8DYdlgTX8Rx9QBoW6j6OM5YZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c8e39a52f68c11f0b0f03b4cfa9209d1-20260121
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9405c4e1-a16b-46b7-b895-8180871c3a73,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:3eb41b61307c773dbc892b4bd9cc4bb3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c8e39a52f68c11f0b0f03b4cfa9209d1-20260121
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2140298535; Wed, 21 Jan 2026 13:48:17 +0800
Message-ID: <fb396548-1a16-400d-bd88-91f54559fa4d@kylinos.cn>
Date: Wed, 21 Jan 2026 13:48:13 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] lib/string_kunit: extend benchmarks to strnlen and
 chr searches
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, kees@kernel.org, andy@kernel.org,
 ebiggers@kernel.org, martin.petersen@oracle.com, ardb@kernel.org,
 charlie@rivosinc.com, conor.dooley@microchip.com, ajones@ventanamicro.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Joel Stanley <joel@jms.id.au>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-6-jiangfeng@kylinos.cn>
 <aW8zWxjpVMSTFPYM@smile.fi.intel.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <aW8zWxjpVMSTFPYM@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/20 15:48, Andy Shevchenko wrote:
> On Tue, Jan 20, 2026 at 02:58:49PM +0800, Feng Jiang wrote:
>> Extend the string benchmarking suite to include strnlen(), strchr(),
>> and strrchr().
>>
>> For character search functions (strchr and strrchr), the benchmark
> 
> strchr() and strrchr()

Will fix.

>> targets the null terminator. This ensures the entire string is scanned,
> 
> NUL character
> 
> (Also check terminology everywhere: NULL — is for NULL pointers, NUL is for
>  '\0' characters.)
> 

Thanks for the correction, I'll fix this and check other places as well.

>> providing a consistent measure of full-length processing efficiency
>> comparable to strlen().
> 
> Acked-by: Andy Shevchenko <andy@kernel.org>
> 

-- 
With Best Regards,
Feng Jiang

