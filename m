Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F622756A;
	Fri, 23 Jan 2026 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131765; cv=none; b=ZOMj5XdpGj8bmrqfBRYAufL9Tc8Ngkea8w0pAmx9N7aPOvUxt4Q7KdCvGjIUUv0Q/fCcG8dhw/NQ0KzJpMnKEzr9iEfLbEMea3vPj0cxLlWvrA2oEoe9tf/RLbW2xsq9OZAFkdgp6l/DRzMqTM914L5/Gcdd2ss43PYar/nqgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131765; c=relaxed/simple;
	bh=if5zSeS8dlNJsCP+jW+ZlDP6k5l+HHj35E4pM+7HrTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zom44vdrCcwwte/j7OptpQBxPspj8EXx5FnHBwNqzsARpYvhvjVE8qH/Edv5KATO81VEyqXsLp51D8dmpZsC/QG2B6ONABnqWQjOt3ERqGRUABG8tUDKAepNYyuNS0O5HuRl0J8GmcV3ysAte4dy6PZL8mcLdCrMiu5tlEesYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e2f2767ef7fa11f0b0f03b4cfa9209d1-20260123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:56ec9702-805d-480b-a07e-6bbbd80cbfdf,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:cf6a63922911615ee47dbc2d1c4d2939,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e2f2767ef7fa11f0b0f03b4cfa9209d1-20260123
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 567321408; Fri, 23 Jan 2026 09:28:56 +0800
Message-ID: <cb65c596-7950-4402-b5e7-fddea12bd7e1@kylinos.cn>
Date: Fri, 23 Jan 2026 09:28:54 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] riscv: lib: add strnlen implementation
To: Qingfang Deng <dqfext@gmail.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, kees@kernel.org, andy@kernel.org,
 ebiggers@kernel.org, martin.petersen@oracle.com, ardb@kernel.org,
 charlie@rivosinc.com, conor.dooley@microchip.com, ajones@ventanamicro.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Joel Stanley <joel@jms.id.au>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-7-jiangfeng@kylinos.cn>
 <20260121072438.6646-1-dqfext@gmail.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <20260121072438.6646-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/21 15:24, Qingfang Deng wrote:
> On Tue, 20 Jan 2026 14:58:50 +0800, Feng Jiang wrote:
>> diff --git a/arch/riscv/lib/strnlen.S b/arch/riscv/lib/strnlen.S
> 
> Branches that test maxlen can be replaced with Zbb minu instruction.
> (see below)
> 

...

>> +	/*
>> +	 * The first chunk is special: compare against the number
>> +	 * of valid bytes in this chunk.
>> +	 */
>> +	srli	a0, t1, 3
>> +
>> +	/* Limit the result by maxlen. */
>> +	bleu	a1, a0, 3f
> 
> minu	a0, a0, a1
> 
>> +
>> +	bgtu	t3, a0, 2f
>> +
>> +	/* Prepare for the word comparison loop. */
>> +	addi	t2, t0, SZREG
>> +	li	t3, -1
>> +
>> +	/*
>> +	 * Our critical loop is 4 instructions and processes data in
>> +	 * 4 byte or 8 byte chunks.
>> +	 */
>> +	.p2align 3
>> +1:
>> +	REG_L	t1, SZREG(t0)
>> +	addi	t0, t0, SZREG
>> +	orc.b	t1, t1
>> +	bgeu	t0, t4, 4f
>> +	beq	t1, t3, 1b
>> +4:
>> +	not	t1, t1
>> +	CZ	t1, t1
>> +	srli	t1, t1, 3
>> +
>> +	/* Get number of processed bytes. */
>> +	sub	t2, t0, t2
>> +
>> +	/* Add number of characters in the first word.  */
>> +	add	a0, a0, t2
>> +
>> +	/* Add number of characters in the last word.  */
>> +	add	a0, a0, t1
>> +
>> +	/* Ensure the final result does not exceed maxlen. */
>> +	bgeu	a0, a1, 3f
> 
> minu	a0, a0, a1
> 

Thanks for the great suggestion! I see your point now—using minu is indeed a much
more elegant and efficient way to handle the maxlen constraint. It nicely eliminates
unnecessary branches and simplifies the code while still allowing for early returns.

I'll incorporate this into a v4 patch and add a Suggested-by tag for you. Thanks
again for your insightful review!

-- 
With Best Regards,
Feng Jiang

