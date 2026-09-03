Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD404F0528
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453894; cv=none; b=rvyYYywGNQ6vLb64rzQhn9SxNSyr22+cZpm5VKaD4O3PnuTW237BeFKnTGAFf0VeAr+wTSNNUAdfcVwgGWpeuGqdaY8gRP4uoClN2H/2M8BhDndTCGPsSmDTp9l0mO7fxaaV2KdewC/Vqs+a+o1EDZpbjZjVuyY1MGIr8jTxsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453894; c=relaxed/simple;
	bh=qA4rheoJ8iR3/4lpM2DeCPTFOTeS21vpg0tV0VvZcRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzsijS1SMwbbbSfv+mgGIuJ8kAKJ5wbdshdGyNwmxOITWRU7KHQAEd724lEu+YsimjKKXwRY2x+SR8J4CicC7PU4H//qIXQG/tsQ7jkdLSqXP9du32V4N14jUohkNda6aA1A4uryFAexWYPeg/PG21c6dhrXVIJ2jeMfWRXwpR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qIgl9ysH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qIgl9ysH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C4E21596;
	Thu,  3 Sep 2026 09:44:48 -0700 (PDT)
Received: from [10.57.6.2] (unknown [10.57.6.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 429933F673;
	Thu,  3 Sep 2026 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788453891; bh=qA4rheoJ8iR3/4lpM2DeCPTFOTeS21vpg0tV0VvZcRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qIgl9ysHs8hvncgspgnHk7Jv77nImxk2SGegbvNrK97CXnpxi9vobsmMSzL/LvImn
	 K0dm/YLZgvYpz9RvrbRvwnzj4fSHcOcs2jBEr6vGKJwcSylRaMzhQDk1QhduhRmQkA
	 Nszi3HADTMiq4LAhhn3xgLeLgNQbqjcLeP5t0UTg=
Message-ID: <1334b43b-249b-4b30-b31e-72a4ac30670e@arm.com>
Date: Thu, 3 Sep 2026 18:44:41 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 05/25] arm64: Implement asm/kpkeys.h using POE
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
 <20260818-kpkeys-v9-5-743ad31b2c8f@arm.com>
 <apblxUah9EcQox-Y@a079125.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <apblxUah9EcQox-Y@a079125.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2026 16:48, Linu Cherian wrote:
> Kevin,
>
> On Tue, Aug 18, 2026 at 03:08:47PM +0100, Kevin Brodsky wrote:
>> Implement the kpkeys interface if CONFIG_ARM64_POE is enabled.
>> The permissions for pkey 0 are set to RWX as this pkey is also used
>> for code mappings. POR_EL1 is left untouched if we have already
>> entered the requested context.
>>
>> To allow <asm/kpkeys.h> to be included from assembly, also add
>> appropriate #ifdef's to <asm/por.h>.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  arch/arm64/include/asm/kpkeys.h       | 67 +++++++++++++++++++++++++++++++++++
>>  arch/arm64/include/asm/kpkeys_types.h | 15 ++++++++
>>  arch/arm64/include/asm/por.h          |  4 +++
>>  3 files changed, 86 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
>> new file mode 100644
>> index 000000000000..09fd5a849cb0
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kpkeys.h
>> @@ -0,0 +1,67 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef __ASM_KPKEYS_H
>> +#define __ASM_KPKEYS_H
>> +
>> +#include <linux/kpkeys_types.h>
>> +
>> +#include <asm/barrier.h>
>> +#include <asm/cpufeature.h>
>> +#include <asm/por.h>
>> +
>> +/*
>> + * Equivalent to por_set_kpkeys_context(0, KPKEYS_CTX_DEFAULT), but can also be
>> + * used in assembly.
>> + */
>> +#define POR_EL1_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
> IMHO, moving this macro defintion to "arm64: Enable kpkeys" , would be better as
> this patch is about implementing arch helpers.

But this macro is used in patch 7, 8, 9 so it should be defined before
patch 7, right?
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
>> +static inline u64 por_set_kpkeys_context(u64 por, enum kpkeys_ctx ctx)
>> +{
>> +	por = por_elx_set_pkey_perms(por, 0, POE_RWX);
> Guess, we would want to set the pkey index 0 only when,
> ctx == KPKEYS_CTX_DEFAULT and it need to be set only once.
> IIUC, we wouldnt want to deal with that every time we set a new
> context. ie. update only what is relevant.

Conceptually a context is a set of permissions for all the pkeys. This
function must set permissions for all pkeys managed by kpkeys. In this
series it happens that the two contexts both use RWX for pkey 0, but it
does not have to be this way in general.

- Kevin
