Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE924F0545
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453950; cv=none; b=nYUmldIBX9SdIZOHc4oBmN8lBhVyGDawkt6qjigDanho3TyhWTosOd8Z6vd/+5EP3YA9otqWUDHaxLcHEkoSrhA6HCcAPngJYq1mOQXf2PUafcXXVlfKURzTG5+WsfYMevT4YEDBLDyepCf1oy0LlvkWvh+fw24OmRsHMjzUfdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453950; c=relaxed/simple;
	bh=/CRbtrA+vjZ5tpi+PPVd9H6w5y8wPTba5LjyadUSSnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Km93FuXOin4XbbaFOBkOqlkxhE/KN8/1mnPgE1hWVU7B6K8YRPImVuYHQdulo0ayqLmEgq2FDCe6lCY2NZCmlLGKGjs7zHmpjZj8/w6lwex9YPl5L4nozgJ0+Y8HJQl05OvgQXQo5N9Z0jiCvTLl1YLcaiMnIRGEhn6qmeHuRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SR7TXHUz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SR7TXHUz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D931596;
	Thu,  3 Sep 2026 09:45:42 -0700 (PDT)
Received: from [10.57.6.2] (unknown [10.57.6.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FBA83F673;
	Thu,  3 Sep 2026 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788453946; bh=/CRbtrA+vjZ5tpi+PPVd9H6w5y8wPTba5LjyadUSSnA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SR7TXHUzQxDvckWQXIc+kCOdTYGWt1Gaj//NszCiurRY4Z6SAdqDJlunSvSprXTnD
	 G+ho6hqXrCwCQrp/yne6kVlqaExRdp+vclcF/zIL/zaHD1NzPhiw1MEKzTFaOYDgfu
	 46QXLVXyg1Xi5s2nfL5Qn/gtPRKd+Mye1S/UAGRw=
Message-ID: <139b273a-d868-4d82-92b6-cccfb0048c44@arm.com>
Date: Thu, 3 Sep 2026 18:45:36 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 08/25] arm64: Initialize POR_EL1 register on
 cpu_resume()
To: Linu Cherian <linu.cherian@arm.com>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-8-743ad31b2c8f@arm.com>
 <apkMDaRKqX3TTINV@a079125.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <apkMDaRKqX3TTINV@a079125.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2026 07:56, Linu Cherian wrote:
> Kevin,
>
> On Tue, Aug 18, 2026 at 03:08:50PM +0100, Kevin Brodsky wrote:
>> From: Yeoreum Yun <yeoreum.yun@arm.com>
>>
>> The POR_EL1 register is reset to an unknown value after cpu_suspend().
>> Since POR_EL1 always holds POR_EL1_INIT when entering cpu_suspend(),
>> initialize POR_EL1 with POR_EL1_INIT before cpu_do_resume().
>>
>> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  arch/arm64/kernel/sleep.S | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
>> index f093cdf71be1..e0a6ad85cd24 100644
>> --- a/arch/arm64/kernel/sleep.S
>> +++ b/arch/arm64/kernel/sleep.S
>> @@ -3,6 +3,7 @@
>>  #include <linux/linkage.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/assembler.h>
>> +#include <asm/kpkeys.h>
>>  #include <asm/smp.h>
>>  
>>  	.text
>> @@ -134,6 +135,17 @@ SYM_FUNC_START(_cpu_resume)
>>  	/* load sp from context */
>>  	ldr	x2, [x0, #CPU_CTX_SP]
>>  	mov	sp, x2
>> +
>> +#ifdef CONFIG_ARM64_POE
>> +alternative_if_not ARM64_HAS_S1POE
>> +	b	.Lskip_por_set
>> +alternative_else_nop_endif
>> +	mov_q	x2, POR_EL1_INIT
>> +	msr_s	SYS_POR_EL1, x2
>> +	/* isb can be skipped since cpu_do_resume() will do it. */
>> +.Lskip_por_set:
>> +#endif /* CONFIG_ARM64_POE */
> Would it be better to move this under__cpu_setup ?

I didn't think about that, that's quite neat as it avoids having to take
care of the resume path separately. It also feels fairly logical as
POR_EL1 should be configured very early (since it impacts all accesses
once enabled). Will do in the next version, thanks!

I was concerned about accesses to POR_EL1 being trapped, but in fact
there is no EL1 control to trap it so no concern there. I realised I
forgot to set HFGRT{R,W}_EL2.nPOR_EL1 though... I'll fix that up in the
next version. (This has no effect when running at EL2 with VHE so I
didn't notice that beforehand.)

- Kevin
