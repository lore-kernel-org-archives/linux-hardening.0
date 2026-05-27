Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739F3D668E
	for <linux-hardening@vger.kernel.org>; Wed, 27 May 2026 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870264; cv=none; b=t0uZfaCadNxR/YA9eR6uRysgBBPIehej6eGLxx4Xvuzx+JMVasWZBW9XdLVHav7GjOLGApal3XXV5hDafuc2QICApU8KBPv+YEJGrSkRhFVCuodHly/40JpLJkDxlUmaORREFChPB4qrrhkmbOhWDvUuN93/REDxW2WXsm+WXqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870264; c=relaxed/simple;
	bh=bL0SGvpJMA0jKAYtYfSGI2V/YyddodRJo0fhchnToSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qblg1CO6GsBktSJeNGqqRyBgfGb2/R4VKKZtyzXmT88y3s7b1lJ2sGYrCdGdhUPUOXMjulYcTjXaCEVf6HUkOkjne84mc7ZE7VfepYrhcekBTo+WV2XW373DkXNLZpdWas+HEZRfDgEcajvSr9j6iI8WxwfY5G8K15YvxuKOn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kfnU3J83; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kfnU3J83"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBA6B2880;
	Wed, 27 May 2026 01:24:16 -0700 (PDT)
Received: from [10.57.93.47] (unknown [10.57.93.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE113F7D8;
	Wed, 27 May 2026 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779870261; bh=bL0SGvpJMA0jKAYtYfSGI2V/YyddodRJo0fhchnToSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kfnU3J8365dlkSur+Ghyy3KcliIFgbIFf/gzBx99N+i08GclVyKtMVVzUswqs3S9H
	 BbFy3b02pCkmlZFcMYymisrIST9qibyRe//b/zxYjemYcHtRq1ZAzuRlvchaO3WnEr
	 CFON8PFlu+HITiEmjXFYRSAySy6bNgRNL0wPH9wg=
Message-ID: <b4eb4ea8-f4d6-4be2-81b1-4a8a46abe94e@arm.com>
Date: Wed, 27 May 2026 10:24:02 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v8 01/24] mm: Introduce kpkeys
To: Linus Walleij <linusw@kernel.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Ira Weiny
 <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
 <20260526-kpkeys-v8-1-eaaacdacc67c@arm.com>
 <CAD++jLnURXzgAgkWCcYX0dLOLqHQw+gn96V1dzDa_0Aoi3430Q@mail.gmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <CAD++jLnURXzgAgkWCcYX0dLOLqHQw+gn96V1dzDa_0Aoi3430Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/05/2026 15:17, Linus Walleij wrote:
> Hi Kevin,
>
> here is just a few drive-by review comments pertaining to the
> API which will be used for all architectures wanting to use
> pkeys.

Appreciated, thanks!

> [...]
>
>> Because each architecture implementing pkeys uses a different
>> representation for the pkey register, and may reserve certain pkeys
>> for specific uses, support for kpkeys must be explicitly indicated
>> by selecting ARCH_HAS_KPKEYS and defining the following functions in
>> <asm/kpkeys.h>, in addition to the macros provided in
>> <asm-generic/kpkeys.h>:
>>
>> - arch_kpkeys_set_context()
>> - arch_kpkeys_restore_pkey_reg()
>> - arch_supports_kpkeys()
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> I'm following so far.
>
> Is there no need for something like
>
> ctx = arch_kpkeys_request_context(KEY_TYPE) ?
>
> I'm just thinking of the scenario that e.g. two architectures want
> to request the same type of key for some generic resource, but
> the underlying implementation is vastly different for the two
> architectures, so relying on hard-coded arch-specific constants
> may not work. I'm also thinking about archs supporting different
> versions/types of kpkeys in a multi-platform executable kernel
> that may execute on several different silicon with the same ISA.

I'm not sure I understand what potential limitations this is trying to
address. The only thing that is imposed by the framework is the value of
KPKEYS_CTX_*, which is purely symbolic. Everything else is up to the
architecture, including the value of each key (which could be determined
at runtime if needed) and the permissions associated to each context.

Conceptually a context is a set of permission overlays for all existing
keys, it doesn't have to be tied to just one key.

> Maybe this is too much upfront design, I understand it needs to
> be kept simple.
>
>> +#ifndef KPKEYS_PKEY_DEFAULT
>> +#define KPKEYS_PKEY_DEFAULT    0
>> +#endif
> (...)
>> +#define KPKEYS_CTX_DEFAULT     0
>> +
>> +#define KPKEYS_CTX_MIN         KPKEYS_CTX_DEFAULT
>> +#define KPKEYS_CTX_MAX         KPKEYS_CTX_DEFAULT
> I was thinking an enum:
>
> enum kpkey_type {
>     KPKEY_DEFAULT = 0,
>     KPKEY_MMU_TABLE = 1,
>    ....
> };
>
> since this is what is used later.
>
>> +/**
>> + * kpkeys_set_context() - switch kpkeys context
>> + * @ctx: the context to switch to
>> + *
>> + * Switches to specified kpkeys context. @ctx must be a compile-time
>> + * constant. The arch-specific pkey register will be updated accordingly, and
>> + * the original value returned.
>> + *
>> + * Return: the original pkey register value if the register was written to, or
>> + *         KPKEYS_PKEY_REG_INVAL otherwise (no write to the register was
>> + *         required).
>> + */
>> +static __always_inline u64 kpkeys_set_context(int ctx)
> Should ctx be unsigned here? I'm nor sure what a negativ context
> would mean.
> kpkeys_set_context(unsigned int ctx)

That's a good point, now that we say "context" and not "level" an enum
would be a better representation. I would directly use:

    u64 kpkeys_set_context(enum kpkeys_ctx ctx);

... unless we really need another layer of abstraction.

- Kevin

> And then I was thinking:
>
> unsigned int kpkeys_request_context(enum kpkey_type type) {}...
>
> + arch_ -prefixed version of the same.
>
> unsigned int ctx;
> ctx = kpkeys_request_context(KPKEY_MMU_TABLE);
> (...)
>
> Constant sinking in the compiler will optimize the arch
> function to a constant in the object code so it will still
> be fast just a bit more talkative in source form.
>
> Yours,
> Linus Walleij
