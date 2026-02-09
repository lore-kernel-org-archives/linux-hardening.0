Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD43793BC;
	Mon,  9 Feb 2026 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644516; cv=none; b=krGbWWckrzbgaMc591HkxuBS4jxCJbf2LHs0Qm9FsX2vYXSksjr88cgRLr8dlOetiJkfghq+tmUVFQmMbCzUA73nBxLBvKcmTLXmFqBcDjweDfraT0vXNLHX5PVBeZR3Mn/h6bElvGhzURYUGoHD+NZ68XJUh41ZiI8uP9PZi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644516; c=relaxed/simple;
	bh=Ew7kN46rhGDM4dEiPsUsVqK/GgQOgN3YtDNu7vHLVtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkBY4q2bPEYNsmEUUkSJdFZWDlhjFr1PXgf2bQGAnIk1x9PHLYUu9yIP6n4YfCRGK+LHaIygpbIbwGEw9hIfz4Hz3JPVtqCO9M4+t9tr2IWbors+XwoFPsKvoZGvSPPY7KGng3vzOgy+k8WPl8pZgpHcgpAqT5pTpU3sIE/dXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbS3j8to; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbS3j8to"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA55C116C6;
	Mon,  9 Feb 2026 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770644516;
	bh=Ew7kN46rhGDM4dEiPsUsVqK/GgQOgN3YtDNu7vHLVtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QbS3j8toBchCyyOG4nENlUg2D4KmlTtxqT2G/uTWdMpPr6141acVfjkqkreoHBAFz
	 tZ3XpuiHA46IJzEPNsxDfIELspw/dngnfh3WvCNPL9OBeXIhPUEL68qFNJeMxO2RE2
	 nGY9lRw5pGAIdBHtfvAJATm0kYt93zY9vveYVKJed6Yh7MgjtCuPswtdzNPnPU3soi
	 yDWTIW5YEeFR2X/k5UGoyRCsgWfhMErov5XltYJmXTXD4gzzheqW1w8tXuDlCJX94e
	 le+kDh3zM8NsqQXfHdWTOlTfufJQfcU5wJVwFywPVnAyj3x1OJ7Jdf3h/nABIqdtL3
	 qi20Z4MC/uYPg==
Message-ID: <5cfae419-427a-471b-8bbe-645f56442e2c@kernel.org>
Date: Mon, 9 Feb 2026 14:41:51 +0100
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
References: <bca0abe3-5b8d-4493-a338-b41322e9e85d@kernel.org>
 <20260209132510.84205-1-xieyuanbin1@huawei.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260209132510.84205-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/02/2026 à 14:25, Xie Yuanbin a écrit :
> On Fri, 6 Feb 2026 20:53:55 +0100, Christophe Leroy (CS GROUP) wrote:
>> Le 06/02/2026 à 19:26, Kees Cook a écrit :
>>>
>>> Isn't it possible to do this and not need __compiletime_strlen at all?
>>>
>>> 	n_len = strnlen(name, min(__member_size(name), KSYM_NAME_LEN));
>>
>> ppc_kallsyms_lookup_name() only has two callers and they call it with a
>> built-in string. I think we can do something a lot simpler, something
>> like (untested):
>>
>> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
>> {
>> 	unsigned long addr = kallsyms_lookup_name(name);
>>
>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
>> 		addr = ppc_function_entry((void *)addr);
>>
>> 	return addr;
>> }
>>
>> #ifdef CONFIG_PPC64_ELF_ABI_V1
>> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." ## x);
>> #else
>> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
>> #endif
>>
>> Christophe
> 
> When CONFIG_PPC64_ELF_ABI_V1=y, it seems that the try of lookupinp
> the original non-dot symbol is missing.
> 
> What about this (Only the compilation test is performed):
> ```c
> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
> {
> 	unsigned long addr = kallsyms_lookup_name(name);
> 
> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
> 		addr = ppc_function_entry((void *)addr);
> 
> 	return addr;
> }
> 
> #define ppc_kallsyms_lookup_name(x) ({					\
> 		unsigned long addr = 0;					\
> 		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))		\
> 			addr = __ppc_kallsyms_lookup_name("." x);	\
> 		if (!addr)						\
> 			addr = __ppc_kallsyms_lookup_name(x);		\
> 		addr;							\
> 	})
> ```

Good point.

To avoid duplicating the string I'd suggest:

static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
{
	unsigned long addr = kallsyms_lookup_name(name);

	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1) && !addr)
		addr = kallsyms_lookup_name(name + 1);
	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
		addr = ppc_function_entry((void *)addr);

	return addr;
}

#ifdef CONFIG_PPC64_ELF_ABI_V1
#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." x);
#else
#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
#endif
