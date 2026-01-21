Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6982C11CD;
	Wed, 21 Jan 2026 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974765; cv=none; b=t9DIhr1sL3b5ym8h6ZzJ+/z3RiGA3SW8BadwofLdSMW19MLpdky1ovZvahb6CsSQX7QURgtnDliv8ix2C8jePpLIgJzhScw6umfF2QPRale2HNuQCxLF+aDptE5G1cnBiLbcNT8kjYhsQeb5OFFAhX2rgUICswMfRa4tgmFZC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974765; c=relaxed/simple;
	bh=tzeRHwL7aFaCkYiS2Mrrjfk7yCExbRC165cwboBO2ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HC3UG7a5IeHYh4O+8ExzPMaj9JyeaCi5GZeHq0LvUeNc6zJBYuLs5Sxa6iLGgc+Fl5L+nvxyGIQGGyVeinDcjTS6c/n4js4av+OEEPgYlpezlb27eRzWcblPQlGqzq6mCy5Q3S9FLOuUlVsgtUmQuX6CMde8FR1vhcA5P2oj8zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 61b115fcf68d11f0b0f03b4cfa9209d1-20260121
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:bc083bb8-9c77-412a-b909-18ca58310964,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:63a34cbd99b4ddb04cc076fcc54cf188,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61b115fcf68d11f0b0f03b4cfa9209d1-20260121
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1532687992; Wed, 21 Jan 2026 13:52:33 +0800
Message-ID: <9fc6472c-b9c1-4535-b351-575604cf7ab1@kylinos.cn>
Date: Wed, 21 Jan 2026 13:52:31 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] riscv: lib: add strnlen implementation
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, kees@kernel.org, andy@kernel.org,
 ebiggers@kernel.org, martin.petersen@oracle.com, ardb@kernel.org,
 charlie@rivosinc.com, conor.dooley@microchip.com, ajones@ventanamicro.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Joel Stanley <joel@jms.id.au>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-7-jiangfeng@kylinos.cn>
 <aW8vTc4mieqmJKhE@smile.fi.intel.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <aW8vTc4mieqmJKhE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/20 15:31, Andy Shevchenko wrote:
> On Tue, Jan 20, 2026 at 02:58:50PM +0800, Feng Jiang wrote:
>> Add an optimized strnlen() implementation for RISC-V. This version
>> includes a generic word-at-a-time optimization and a Zbb-powered
>> optimization using the 'orc.b' instruction, derived from the strlen
>> implementation.
>>
>> Benchmark results (QEMU TCG, rv64):
>>   Length | Original (MB/s) | Optimized (MB/s) | Improvement
>>   -------|-----------------|------------------|------------
>>   16 B   | 189             | 310              | +64.0%
>>   512 B  | 344             | 1535             | +346.2%
>>   4096 B | 363             | 1854             | +410.7%
> 
>> Suggested-by: Andy Shevchenko <andy@kernel.org>
> 
> Wrong tag, I have zero knowledge about RISC V.
> 

Sorry for the confusion. I misunderstood the scope of the 'Suggested-by' tag.
I will remove it from the RISC-V specific implementation patches and only keep
relevant credits in the benchmarking/testing patches where your feedback was
applied. 

Thanks for clarifying!

-- 
With Best Regards,
Feng Jiang

