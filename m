Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D55302742;
	Thu,  8 Jan 2026 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855251; cv=none; b=Ig4wuMxpiwRyoJF8cs4Ue4fEpcOzgvVTrgr1FuqWOcIVCsXr6VNDcDyW63qjdrHiUrGa103sw9VjgHj+fJUAuvKLAxzEZFiyy43WcSWFtJWPnoI8ciMunFJb3OK9HX5nH+1kpbAnA1VI29anbAjg/y09BuVJXRJvJdSwK/C2Oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855251; c=relaxed/simple;
	bh=8no0d3c4JHkHOUoUadjyCDrfuLepLclOp9XB5a7oQHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYuuJMtqVz+1aOC+sYRePYs6JJ4LAi0E+5QO1wkihTh5uYaIN+iqRl3CB2aPp8k1ACbwZeNkJhcxpbWeLPLiN87TIgq5dsbf7CiOySAI21m46xz3VFPrRlAQ1pjj055UiZej1N9SsODQvD8pseW3u5qJRTRI+9bKTxWAaeI4OuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d087ee76ec5e11f0a38c85956e01ac42-20260108
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:331afceb-032b-451e-8e83-fb7ac975119e,IP:0,UR
	L:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:3
X-CID-META: VersionHash:a9d874c,CLOUDID:0360f79b43531e3d0ae7c8a791c447d8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:4|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d087ee76ec5e11f0a38c85956e01ac42-20260108
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 622215496; Thu, 08 Jan 2026 14:54:01 +0800
Message-ID: <b419c6db-0f3f-4666-8f7c-156f7eda2b5b@kylinos.cn>
Date: Thu, 8 Jan 2026 14:53:58 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] lib/string_kunit: add test case for strnlen
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 kees@kernel.org, andy@kernel.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, Jason@zx2c4.com, conor.dooley@microchip.com,
 samuel.holland@sifive.com, charlie@rivosinc.com, ajones@ventanamicro.com,
 nathan@kernel.org, linus.walleij@linaro.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260107023517.46840-1-jiangfeng@kylinos.cn>
 <20260107023517.46840-3-jiangfeng@kylinos.cn>
 <CAHp75VfxT+K1QRc5ayZGc4joB9vFJrk7kjQ4gAgUHOT1boFbmA@mail.gmail.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <CAHp75VfxT+K1QRc5ayZGc4joB9vFJrk7kjQ4gAgUHOT1boFbmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/1/7 19:56, Andy Shevchenko wrote:
> On Wed, Jan 7, 2026 at 4:35 AM Feng Jiang <jiangfeng@kylinos.cn> wrote:
>>
>> Add a KUnit test for strnlen() to verify correctness across
>> different string lengths and memory alignments.
> 
> Same comment as per patch 1 (it would probably require to call for
> arch_strnlen() or something like this).

Thanks, makes sense.

I'll add the performance benchmarking (random filling + timing) in V2.

Since string functions are typically exported directly by each architecture
without an arch_ prefix, I'll introduce a generic_strnlen() (based on
lib/string.c) within the test for comparison.

> ...
> 
>> +       for (offset = 0; offset < 16; offset++) {
>> +               for (len = 0; len <= 128; len++) {
> 
> You want to define these two limits to avoid the possible issues in
> the future if the code gets changed.

Got it, will define these limits as macros in V2. Thanks!

-- 
With Best Regards,
Feng Jiang

