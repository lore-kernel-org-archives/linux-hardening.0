Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E583AD51A
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135342; cv=none; b=SwPPVGaA3p9qs16/RHZd81V4ynyBss9Pxt1t04aPVf3J5xjU1kT6FhXh+YdcoxOObx4OQtjDKvoivOPcmOqwh4BAOI81+h2GOcHzXPgB12QwHFSMLTulogiR5Cr1TUGzakQaffeNKPkYhywoDqGKfqnUF60LtKkSBMoRobID5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135342; c=relaxed/simple;
	bh=HdIQaBeASUC+3PFLFxGv4B8WmaWQ+wKaXj311z4LKwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qS2dFEDv9Vbzs6ZNZFFt1EDS3jmsXRFe51BC/nqTXmHAZN0076xTt5wM5cPjs8i0REVz7M2Kkb8ToXwPS/FEdrdier6DhcSP18ZN90bPnAkdYBjKcCP53ZkWF212T8HGWB81buGesoNhuLypmD6/0PqURX7h3wdna/U+Mujzenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0oiP/9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0oiP/9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702861F000E9;
	Mon, 22 Jun 2026 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782135340;
	bh=2Jl7C8hZl3Y2Ue1UxUAZLEwyJZ1SEzSpD9zwcG7PeIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A0oiP/9dax3cnrR85YE3GH/p08vAcaj1t4upYnIR21AleNPRWY59kwpSnFpgDXQVj
	 ArhXTZ0UJf3iLFCCQFNEOhKGiy+pAsVfZuy7EPViqOENy3GdkgGbUz/C7fIbITvzst
	 4iuQDWl5CxtBG55dPuLJEtZ0p9gvGbIEOCwPkUAnQhIFdMQtR0M1rJYVvd/HA78bgV
	 lLkeXZ8nbkn5b+fdGJFiuGNVaBD2u18EY2JLL3YW0nNEW4TtITzhnpiKD0HDStzx97
	 UTevCAlqSzSBGCn5VF1blTB/cOSOSvCIOLxB/tqSQ3bs7OaLBEQpdHk8fnA/Tf/Qpz
	 VazxRbhZNRmbA==
Message-ID: <f8507ad6-761c-4073-85ae-bddb2a07d660@kernel.org>
Date: Mon, 22 Jun 2026 15:35:31 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v8 05/24] arm64: Implement asm/kpkeys.h using POE
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260526-kpkeys-v8-5-eaaacdacc67c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 13:15, Kevin Brodsky wrote:
> Implement the kpkeys interface if CONFIG_ARM64_POE is enabled.
> The permissions for KPKEYS_PKEY_DEFAULT (pkey 0) are set to RWX as
> this pkey is also used for code mappings.
> 
> To allow <asm/kpkeys.h> to be included from assembly, also add
> appropriate #ifdef's to <asm/por.h>.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/include/asm/kpkeys.h | 59 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/por.h    |  4 +++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
> new file mode 100644
> index 000000000000..4dbfeb3dfcfe
> --- /dev/null
> +++ b/arch/arm64/include/asm/kpkeys.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_KPKEYS_H
> +#define __ASM_KPKEYS_H
> +
> +#include <asm/barrier.h>
> +#include <asm/cpufeature.h>
> +#include <asm/por.h>
> +
> +#include <asm-generic/kpkeys.h>
> +
> +/*
> + * Equivalent to por_set_kpkeys_context(0, KPKEYS_CTX_DEFAULT), but can also be
> + * used in assembly.
> + */
> +#define POR_EL1_INIT	POR_ELx_PERM_PREP(KPKEYS_PKEY_DEFAULT, POE_RWX)

Okay, this matches

#define POR_EL0_INIT		POR_ELx_PERM_PREP(0, POE_RWX)

Is there a good reason we need KPKEYS_PKEY_DEFAULT at all (and not similarly
just hardcode it to 0)?

Just wondering, because apparently we didn't care about adding an indicator for
user space pkey 0.

> +
> +#ifndef __ASSEMBLY__
> +
> +static inline bool arch_supports_kpkeys(void)
> +{
> +	return system_supports_poe();
> +}
> +
> +#ifdef CONFIG_ARM64_POE
> +
> +static inline u64 por_set_kpkeys_context(u64 por, int ctx)
> +{
> +	por = por_elx_set_pkey_perms(por, KPKEYS_PKEY_DEFAULT, POE_RWX);
> +
> +	return por;

Why not

return por_elx_set_pkey_perms(por, KPKEYS_PKEY_DEFAULT, POE_RWX);

?

In light of API discussions, it would be nicer if arch_kpkeys_set_context()
would just return the old context. But that would mean that restoring the
context would require another read_sysreg_s(SYS_POR_EL1);

So instead of returning magic register values, that should be wrapped in some
arch state struct as mentioned as reply to a previous patch.

> +}
> +
> +static __always_inline void __kpkeys_set_pkey_reg_nosync(u64 pkey_reg)
> +{
> +	write_sysreg_s(pkey_reg, SYS_POR_EL1);
> +}
> +
> +static __always_inline u64 arch_kpkeys_set_context(int ctx)
> +{
> +	u64 prev_por = read_sysreg_s(SYS_POR_EL1);
> +	u64 new_por = por_set_kpkeys_context(prev_por, ctx);

Both can be const.

But maybe you just use a single "por" variable.

> +
> +	__kpkeys_set_pkey_reg_nosync(new_por);
> +	isb();
> +
> +	return prev_por;
> +}
> +
> +static __always_inline void arch_kpkeys_restore_pkey_reg(u64 pkey_reg)
> +{
> +	__kpkeys_set_pkey_reg_nosync(pkey_reg);
> +	isb();
Why is that isb() for both callers outside of the function? Do you expect
another user that doesn't need the isb?

-- 
Cheers,

David
