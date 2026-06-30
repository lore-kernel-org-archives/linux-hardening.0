Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620E313E34
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811002; cv=none; b=Y83zCFvL5PTZlKGAaGFM+SaeODa/GiV5H5vY3tWz9Rr2PHxJUT2aPtx7k0kZ4rIDnLV39XPiqaG09wYfpa49eMqnFTDnJugbSJBfeqRzamlPuwi/TZSZNCygA/lvRQEfbnXxXKdb0SNAZLpLDBmWoXZXNPjSRhADLNXNo9keeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811002; c=relaxed/simple;
	bh=pOGqr+6YjRRrGfqyTm37l0BuFHy9XPuCtkGh7B9Kr+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGE0tGyjnuhSiUpFUusfPUC0xxwq1m3fbDgl1bEvAi5bvfK4e2MZKo38LAB6WRnIcy0Tzx6fyCh6eTU91UClPxhqu09CN4tx96gBWE4bUIdPGPdH6Uvldm5rorZpHHWLItwv6OoQ8+q7zZcDKer/yC7EcOwx72TP5fvR0bHpkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OhlBURWG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OhlBURWG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68EE12C1C;
	Tue, 30 Jun 2026 02:16:36 -0700 (PDT)
Received: from [10.57.81.132] (unknown [10.57.81.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F30143FAFB;
	Tue, 30 Jun 2026 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782811000; bh=pOGqr+6YjRRrGfqyTm37l0BuFHy9XPuCtkGh7B9Kr+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OhlBURWGxQqcbV6J2ZjbPLWqe0+OO9mHDyY8RjjqBPKuIiYpX91UGBHlnRLA2voBR
	 ZGfe8UhEF+CVHnpiOUhkK+Si+HmROlqhNQzZWseJfpnlDEHoIShP9UCusiuqoiShd4
	 QVu9mycDBfqeZmeTAPiDcXgKfSZGryWFP031nXt4=
Message-ID: <e4f98e9d-9f02-46d3-90ff-22ec711ba85b@arm.com>
Date: Tue, 30 Jun 2026 11:16:27 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v8 05/24] arm64: Implement asm/kpkeys.h using POE
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 linux-hardening@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
 <20260526-kpkeys-v8-5-eaaacdacc67c@arm.com>
 <f8507ad6-761c-4073-85ae-bddb2a07d660@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <f8507ad6-761c-4073-85ae-bddb2a07d660@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/06/2026 15:35, David Hildenbrand (Arm) wrote:
> On 5/26/26 13:15, Kevin Brodsky wrote:
>> Implement the kpkeys interface if CONFIG_ARM64_POE is enabled.
>> The permissions for KPKEYS_PKEY_DEFAULT (pkey 0) are set to RWX as
>> this pkey is also used for code mappings.
>>
>> To allow <asm/kpkeys.h> to be included from assembly, also add
>> appropriate #ifdef's to <asm/por.h>.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  arch/arm64/include/asm/kpkeys.h | 59 +++++++++++++++++++++++++++++++++++++++++
>>  arch/arm64/include/asm/por.h    |  4 +++
>>  2 files changed, 63 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
>> new file mode 100644
>> index 000000000000..4dbfeb3dfcfe
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kpkeys.h
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef __ASM_KPKEYS_H
>> +#define __ASM_KPKEYS_H
>> +
>> +#include <asm/barrier.h>
>> +#include <asm/cpufeature.h>
>> +#include <asm/por.h>
>> +
>> +#include <asm-generic/kpkeys.h>
>> +
>> +/*
>> + * Equivalent to por_set_kpkeys_context(0, KPKEYS_CTX_DEFAULT), but can also be
>> + * used in assembly.
>> + */
>> +#define POR_EL1_INIT	POR_ELx_PERM_PREP(KPKEYS_PKEY_DEFAULT, POE_RWX)
> Okay, this matches
>
> #define POR_EL0_INIT		POR_ELx_PERM_PREP(0, POE_RWX)
>
> Is there a good reason we need KPKEYS_PKEY_DEFAULT at all (and not similarly
> just hardcode it to 0)?

I did wonder about that. As per the discussion on patch 1 I don't see
that value ever changing, so I'm fine with hardcoding 0 if that feels
more consistent/intuitive.

> Just wondering, because apparently we didn't care about adding an indicator for
> user space pkey 0.

It's never too late to add a constant for userspace as well, but of
course since it's been ABI for so long the value isn't going to change.

>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +static inline bool arch_supports_kpkeys(void)
>> +{
>> +	return system_supports_poe();
>> +}
>> +
>> +#ifdef CONFIG_ARM64_POE
>> +
>> +static inline u64 por_set_kpkeys_context(u64 por, int ctx)
>> +{
>> +	por = por_elx_set_pkey_perms(por, KPKEYS_PKEY_DEFAULT, POE_RWX);
>> +
>> +	return por;
> Why not
>
> return por_elx_set_pkey_perms(por, KPKEYS_PKEY_DEFAULT, POE_RWX);
>
> ?

Because of patch 17, I wanted to minimise the diff. Happy to change it
if that feels less surprising.

> In light of API discussions, it would be nicer if arch_kpkeys_set_context()
> would just return the old context. But that would mean that restoring the
> context would require another read_sysreg_s(SYS_POR_EL1);

Correct, that's what I wanted to avoid.

> So instead of returning magic register values, that should be wrapped in some
> arch state struct as mentioned as reply to a previous patch.

Agreed.

>> +}
>> +
>> +static __always_inline void __kpkeys_set_pkey_reg_nosync(u64 pkey_reg)
>> +{
>> +	write_sysreg_s(pkey_reg, SYS_POR_EL1);
>> +}
>> +
>> +static __always_inline u64 arch_kpkeys_set_context(int ctx)
>> +{
>> +	u64 prev_por = read_sysreg_s(SYS_POR_EL1);
>> +	u64 new_por = por_set_kpkeys_context(prev_por, ctx);
> Both can be const.

Sure.

> But maybe you just use a single "por" variable.

Not sure how? prev_por is returned and new_por is based on its value.

>> +
>> +	__kpkeys_set_pkey_reg_nosync(new_por);
>> +	isb();
>> +
>> +	return prev_por;
>> +}
>> +
>> +static __always_inline void arch_kpkeys_restore_pkey_reg(u64 pkey_reg)
>> +{
>> +	__kpkeys_set_pkey_reg_nosync(pkey_reg);
>> +	isb();
> Why is that isb() for both callers outside of the function? Do you expect
> another user that doesn't need the isb?

Outside of __kpkeys_set_pkey_reg_nosync() that is? That function is also
used by patch 22, which doesn't want the ISB because we already have an
ISB somewhere else. The naming follows that of __set_pte_nosync().

- Kevin
