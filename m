Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866747;
	b=he8v1yxUSvzjKNMhX4iAigAroHYHMnYF5LBda2CIUfjU1HwtA+npxNvAj8Ii1EakjIHu
	 vRiw/u3Wp2rBBNT0Ezr29+Y5u0ePhY6PgoiA5jOq4AUE0kpNLr77PYw2YmHOrsC7u2Mri
	 oiKIB5g1J2yAOTU8eet5C6/daKSY4tCD4UleUGvGttFNIsLISH+QGen5CpAhWdhjutWZA
	 u89suLuXtJylubSQrZL1tgsr8+Ex8H3ShQOjMF/NIhJf41zyH0jIO1sKK2apwjWafTvG9
	 bBo8EFhS0zAlD9OWN7dp3y4IkPMbcxCiu1Ne9TtNj4aA7TiAVM3YzmbrLZC+kqufWmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866747;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=voXWE43TKZzjj6nJV8gFDultxRVrBwVOyi5RshFaUXQ=;
	b=Ebr4IuamH/W6V5CL016JKq+++ohfhgHGv3L1g2RNZhapd3F9I0+MsyzcRi6B9YCuP+/t
	 08Wr3l9VyVub/jFxg6Bmv7z/k+3RD3j0MnBylybdk+R8XKh/b0QJvsJisu6EnMvsbogni
	 qX276bVLmwAk+RgjUaLeie+C7lalLC927/OAHBT3svBjt3wj7mKiGCB9mTDzgChnA0pwt
	 WOv9N1QV9/mRPPefb77gxdDkr4N0VWj8o3PozsPYQoTranYWX4JcRzO7jjMnZJMGEXuVg
	 CHjZTWG9nlEBvSU/3canecqwGYsMaO6eg36Z9pBTbpI9BFRwgh7WfVgSilFyS6LD1RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YEc9uOwK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5152F606A336
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 08:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5152F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YEc9uOwK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63EAF15A1;
	Thu,  5 Nov 2026 00:19:01 -0800 (PST)
Received: from [10.57.17.66] (unknown [10.57.17.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D64D83F673;
	Thu,  5 Nov 2026 00:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793866744; bh=bTT01ldQJro64DbDN3GZnqw1GrxcI2GgeVkpWVQKF/w=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=YEc9uOwKpkG3VIo8BNC1Jc7JWkHGwFeOGrZAhgcSe9JSpicwMRNHh7/SpXxFugEKd
	 E/6WcZEpwSmKf6a6pwXYQ7KDsDvx2WH4QQu0QPTrI2+4h5in1ky6m7xvJKypoPzaYn
	 wAB7G83GeLBT0zBXUpBtBuY78ekPLBN/1DQrDT3s=
Message-ID: <d0e63c8c-ac81-4daa-b359-622f16e91d67@arm.com>
Date: Thu, 5 Nov 2026 09:18:38 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 08/25] arm64: Initialize POR_EL1 register on
 cpu_resume()
From: Kevin Brodsky <kevin.brodsky@arm.com>
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
 <139b273a-d868-4d82-92b6-cccfb0048c44@arm.com>
Content-Language: en-GB
In-Reply-To: <139b273a-d868-4d82-92b6-cccfb0048c44@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2026 18:45, Kevin Brodsky wrote:
> On 03/09/2026 07:56, Linu Cherian wrote:
>> Kevin,
>>
>> On Tue, Aug 18, 2026 at 03:08:50PM +0100, Kevin Brodsky wrote:
>>> From: Yeoreum Yun <yeoreum.yun@arm.com>
>>>
>>> The POR_EL1 register is reset to an unknown value after cpu_suspend().
>>> Since POR_EL1 always holds POR_EL1_INIT when entering cpu_suspend(),
>>> initialize POR_EL1 with POR_EL1_INIT before cpu_do_resume().
>>>
>>> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>> ---
>>>  arch/arm64/kernel/sleep.S | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
>>> index f093cdf71be1..e0a6ad85cd24 100644
>>> --- a/arch/arm64/kernel/sleep.S
>>> +++ b/arch/arm64/kernel/sleep.S
>>> @@ -3,6 +3,7 @@
>>>  #include <linux/linkage.h>
>>>  #include <asm/asm-offsets.h>
>>>  #include <asm/assembler.h>
>>> +#include <asm/kpkeys.h>
>>>  #include <asm/smp.h>
>>>  
>>>  	.text
>>> @@ -134,6 +135,17 @@ SYM_FUNC_START(_cpu_resume)
>>>  	/* load sp from context */
>>>  	ldr	x2, [x0, #CPU_CTX_SP]
>>>  	mov	sp, x2
>>> +
>>> +#ifdef CONFIG_ARM64_POE
>>> +alternative_if_not ARM64_HAS_S1POE
>>> +	b	.Lskip_por_set
>>> +alternative_else_nop_endif
>>> +	mov_q	x2, POR_EL1_INIT
>>> +	msr_s	SYS_POR_EL1, x2
>>> +	/* isb can be skipped since cpu_do_resume() will do it. */
>>> +.Lskip_por_set:
>>> +#endif /* CONFIG_ARM64_POE */
>> Would it be better to move this under__cpu_setup ?
> I didn't think about that, that's quite neat as it avoids having to take
> care of the resume path separately. It also feels fairly logical as
> POR_EL1 should be configured very early (since it impacts all accesses
> once enabled). Will do in the next version, thanks!

Turns out there's a complication here: __cpu_setup() always runs at EL1,
even when we will run with VHE at EL2. To make that case work, we would
also need to amend __finalise_el2 to transfer POR_EL1 into POR_EL2.

Overall it doesn't seem to be easier, and my impression is that we avoid
handling registers in __cpu_setup/__finalise_el2 if it can be done at a
later stage. I'll leave the approach unchanged in RFC v10.

- Kevin
