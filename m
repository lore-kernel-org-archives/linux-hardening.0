Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F31A6810;
	Thu, 30 Apr 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542116; cv=none; b=psT/T+eWrH0GbMblr9pvp66/w7IEJ3L8yHrHNBkQl+uF6Wj7AJ93AD2elxkjMXW7arzp+lGjX6pcZHm2ct14AfpIjhvpjW+e427PLBDMQP9yxqio8Y4Fas4/hKseaUXRKmfOBti7OoSARlKqpIHDJZnhQa7dB7vgbpmraOSx9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542116; c=relaxed/simple;
	bh=OyBu5tnNP4uLFUjReaE5JPX/B70f++bdmkd1kLWqPn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PArih+gQwn+1xChSJnXf2C4WulcnwsOZ66QAQNEtzFFomd0bJWasyWdlOJgqMIw+WkFUU4/X2P9R3hBFwCG6jx8bDE9Rm9+tX/+ePCa/g+NvqzLTdEdyPsTd7wDl1mLO2Hjc2XMxuUxV/RUCNy5qesDyvRM4/k1DbJ2UMsAYa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3s0sJkM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3s0sJkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276A1C2BCC6;
	Thu, 30 Apr 2026 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777542116;
	bh=OyBu5tnNP4uLFUjReaE5JPX/B70f++bdmkd1kLWqPn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s3s0sJkMQ3cRJ+QpbRVXFug+mQS/53IZbKzYG0wtujLyLzKgivKx7lNQr+JCfLowP
	 M8kf15e8SHdyd37DIaUvFjIFQtIItxVyKwPgFVWh61wdqUuYtxhi1BUuucAEGKnOG/
	 byikVw2YmDvx363PzwgBLRr+nVtb4R94JATBE5//says1RdvpUObW9zHOItJK5nVnc
	 RbSkw16ySQalxLs/jjcwKXNbzhfi0GmZ8JUHJ4F4KxtWMm5GvtCKhrAlIkDEfUYJuP
	 62eJo9jzX2sFYJL6BJ9H1jz2WrL3MjmY41CaUpQ2JN2d+qLiu6OdGTwBk+ZFl4PvW6
	 9HT/1hE/3C7Ew==
Message-ID: <c755a2d3-6447-4531-aea7-f279eea8f2f8@kernel.org>
Date: Thu, 30 Apr 2026 11:41:49 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread
 compilation error
To: Xie Yuanbin <xieyuanbin1@huawei.com>, andriy.shevchenko@intel.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, kees@kernel.org,
 andy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, lilinjie8@huawei.com, liaohua4@huawei.com
References: <5cfae419-427a-471b-8bbe-645f56442e2c@kernel.org>
 <20260430072913.62348-1-xieyuanbin1@huawei.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260430072913.62348-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/04/2026 à 09:28, Xie Yuanbin a écrit :
> Hi, Christophe Leroy!
> 
> On Mon, 9 Feb 2026 14:41:51 +0100, Christophe Leroy (CS GROUP) wrote:
>> On 09/02/2026 14:25, Xie Yuanbin wrote:
>>> When CONFIG_PPC64_ELF_ABI_V1=y, it seems that the try of lookupinp
>>> the original non-dot symbol is missing.
>>>
>>> What about this (Only the compilation test is performed):
>>> ```c
>>> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
>>> {
>>> 	unsigned long addr = kallsyms_lookup_name(name);
>>>
>>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
>>> 		addr = ppc_function_entry((void *)addr);
>>>
>>> 	return addr;
>>> }
>>>
>>> #define ppc_kallsyms_lookup_name(x) ({					\
>>> 		unsigned long addr = 0;					\
>>> 		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))		\
>>> 			addr = __ppc_kallsyms_lookup_name("." x);	\
>>> 		if (!addr)						\
>>> 			addr = __ppc_kallsyms_lookup_name(x);		\
>>> 		addr;							\
>>> 	})
>>> ```
>>
>> Good point.
>>
>> To avoid duplicating the string I'd suggest:
>>
>> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
>> {
>> 	unsigned long addr = kallsyms_lookup_name(name);
>>
>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1) && !addr)
>> 		addr = kallsyms_lookup_name(name + 1);
>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
>> 		addr = ppc_function_entry((void *)addr);
>>
>> 	return addr;
>> }
>>
>> #ifdef CONFIG_PPC64_ELF_ABI_V1
>> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." x);
>> #else
>> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
>> #endif
> 
> I would like to submit the modification as a new patch, and include you
> as Co-developer. Do you agree?

Add me as Suggested-by: instead.

Thanks
Christophe

> 
> Full of the patch:
> ```patch
>  From fbf07e5c1a97da7c8572435537f2b92213ede39d Mon Sep 17 00:00:00 2001
> From: Xie Yuanbin <xieyuanbin1@huawei.com>
> Date: Thu, 30 Apr 2026 14:15:26 +0800
> Subject: [PATCH V2] powerpc/text-patching: simplify the implementation of ppc_kallsyms_lookup_name()
> 
> ppc_kallsyms_lookup_name() is called only twice in the kernel code, and
> the parameters are all constant strings. strnlen(name, KSYM_NAME_LEN) is
> called inside ppc_kallsyms_lookup_name(), when the compiler detects that
> KSYM_NAME_LEN is larger then the constant strings,
> the following error will be triggered:
> ```log
>    CC      arch/powerpc/kernel/optprobes.o
> In file included from ./arch/powerpc/include/asm/kprobes.h:24,
>                   from ./include/linux/kprobes.h:31,
>                   from arch/powerpc/kernel/optprobes.c:8:
> In function ‘ppc_kallsyms_lookup_name’,
>      inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:209:21:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
>    232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘ppc_kallsyms_lookup_name’,
>      inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:210:22:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
>    232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> ```
> 
> The error can be reproduced in the following ways:
> Use lastest linux-next source, change ppc_kallsyms_lookup_name() to
> __always_inline, use default ppc64_defconfig, set CONFIG_EXPERT=y,
> CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2=n, CONFIG_CC_OPTIMIZE_FOR_SIZE=y,
> and use gcc-14 or a later version for compilation.
> 
> Since ppc_kallsyms_lookup_name() is called only twice in the kernel,
> and the parameters are all constant strins, simplify the implementation
> of ppc_kallsyms_lookup_name() and avoid calling strnlen().
> 
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Kees Cook <kees@kernel.org>
> Co-developed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> ---
> v1->v2: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2F20260205100517.292858-2-xieyuanbin1%40huawei.com&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C525ecaba66ea4e3b15f208dea68a3fa1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639131309913493421%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=aaK9PO2mGdxM3vuJBVP0lcl6VKfqs3VKih5VPcG0IxI%3D&reserved=0
>    - Not use strlen()
> 
>   arch/powerpc/include/asm/text-patching.h | 42 ++++++++----------------
>   1 file changed, 17 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/text-patching.h b/arch/powerpc/include/asm/text-patching.h
> index e7f14720f630..2d3f698cb4f1 100644
> --- a/arch/powerpc/include/asm/text-patching.h
> +++ b/arch/powerpc/include/asm/text-patching.h
> @@ -221,39 +221,23 @@ static inline unsigned long ppc_global_function_entry(void *func)
>    * - For ABIv1, we lookup the dot variant.
>    * - For ABIv2, we return the local entry point.
>    */
> -static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
> -{
> -	unsigned long addr;
> -#ifdef CONFIG_PPC64_ELF_ABI_V1
> -	/* check for dot variant */
> -	char dot_name[1 + KSYM_NAME_LEN];
> -	bool dot_appended = false;
> -
> -	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
> -		return 0;
> -
> -	if (name[0] != '.') {
> -		dot_name[0] = '.';
> -		dot_name[1] = '\0';
> -		strlcat(dot_name, name, sizeof(dot_name));
> -		dot_appended = true;
> -	} else {
> -		dot_name[0] = '\0';
> -		strlcat(dot_name, name, sizeof(dot_name));
> -	}
> -	addr = kallsyms_lookup_name(dot_name);
> -	if (!addr && dot_appended)
> -		/* Let's try the original non-dot symbol lookup	*/
> -		addr = kallsyms_lookup_name(name);
> -#elif defined(CONFIG_PPC64_ELF_ABI_V2)
> -	addr = kallsyms_lookup_name(name);
> -	if (addr)
> -		addr = ppc_function_entry((void *)addr);
> -#else
> -	addr = kallsyms_lookup_name(name);
> -#endif
> -	return addr;
> -}
> +static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
> +{
> +	unsigned long addr = kallsyms_lookup_name(name);
> +
> +	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1) && !addr)
> +		addr = kallsyms_lookup_name(name + 1);
> +	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
> +		addr = ppc_function_entry((void *)addr);
> +
> +	return addr;
> +}
> +
> +#ifdef CONFIG_PPC64_ELF_ABI_V1
> +#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." x)
> +#else
> +#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
> +#endif
>   
>   /*
>    * Some instruction encodings commonly used in dynamic ftracing

