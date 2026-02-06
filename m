Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFA26ED59;
	Fri,  6 Feb 2026 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407642; cv=none; b=Jdv9rk+1K16YsBax3/n5eJVAZdPJfMEItpZMwfEOgMXmXg0xRSx0w07O/ReMMk+rAPdlmJOHvxmjBcQClc6VuG/8trJsv9B6J1zBhgv152nFU+HjQ4kTbXhJXKVKnIr6u2DSLWSWJ57OXPNZfgo3idm8Iw718/C1cbkfa2EDBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407642; c=relaxed/simple;
	bh=zuTx45IAXwCCZxQU6FBP5xFVJffmh2hCgzQapegT9vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qofmriyl8ru40ctHTYNpiTA8CubW84ooxNXRA/nJKIoLK02O26JfXSS3v8EjEmo4TwQ+WdVSlSWyEUPvXt0n/nkez+KP8W0LgrCFbRawH6fpqrQC1DXM9TWimb4e/+37qfPvh1kT6WNecPd984pfwRFPcOxtDbEkAeb/iAyt+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDAa4U/3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDAa4U/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1567C116C6;
	Fri,  6 Feb 2026 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407641;
	bh=zuTx45IAXwCCZxQU6FBP5xFVJffmh2hCgzQapegT9vw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDAa4U/3FllAHrt8tgmweRCEeXs78x4KO6JSUioK8jcWQVszKIa6U7gxfZvgEYm4h
	 B6/AHZMLBH6lvH1gSkfgLdfNR3y7acJGFCHc2qJKzo/O84tOuaYpq09pVyenUA/tAX
	 zdIHeVSiKlEePQDpV2CXOdWDbc1mK4xz5XPFRe061GFSeBSxlLEJncJPl9FPe1Rc8r
	 axac7GCT2qmxi1Pia/PKTkfZntTavmsr0apQrMS7ZlrL+SwlU69RK+mnWAOjcrHTu+
	 JB+7IPaxEGFziQFuLXjK3bPnIkxrsSEFaylMjKarxFURKBCTtQQ1jF3KVcFZKWN3it
	 Zsc202ZRu+bWg==
Message-ID: <bca0abe3-5b8d-4493-a338-b41322e9e85d@kernel.org>
Date: Fri, 6 Feb 2026 20:53:55 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread
 compilation error
To: Kees Cook <kees@kernel.org>, Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 andy@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 lilinjie8@huawei.com, liaohua4@huawei.com
References: <20260205100517.292858-1-xieyuanbin1@huawei.com>
 <20260205100517.292858-2-xieyuanbin1@huawei.com>
 <202602061024.111ED487@keescook>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <202602061024.111ED487@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/02/2026 à 19:26, Kees Cook a écrit :
> On Thu, Feb 05, 2026 at 06:05:17PM +0800, Xie Yuanbin wrote:
>> For strnlen(), if the compiler detects that the maxlen argument exceeds
>> the valid memory size of the input string object, a compilation error may
>> occur.
>>
>> For lastest linux-next source, changing ppc_kallsyms_lookup_name() to
>> __always_inline, using default ppc64_defconfig, and setting
>> CONFIG_EXPERT=y, CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2=n,
>> CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Then, when using gcc-15 for compilation,
>> the following error will be triggered:
>> ```log
>>    CC      arch/powerpc/kernel/optprobes.o
>> In file included from ./arch/powerpc/include/asm/kprobes.h:24,
>>                   from ./include/linux/kprobes.h:31,
>>                   from arch/powerpc/kernel/optprobes.c:8:
>> In function ‘ppc_kallsyms_lookup_name’,
>>      inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:209:21:
>> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
>>    232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> In function ‘ppc_kallsyms_lookup_name’,
>>      inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:210:22:
>> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
>>    232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> ```
>>
>> Refer to the implementation of fortify's strnlen(). If the string length
>> is a compile-time constant, do not call the strnlen() function.
>>
>> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
>> ---
>>   arch/powerpc/include/asm/text-patching.h | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/text-patching.h b/arch/powerpc/include/asm/text-patching.h
>> index e7f14720f630..ce1b2131980a 100644
>> --- a/arch/powerpc/include/asm/text-patching.h
>> +++ b/arch/powerpc/include/asm/text-patching.h
>> @@ -228,8 +228,13 @@ static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
>>   	/* check for dot variant */
>>   	char dot_name[1 + KSYM_NAME_LEN];
>>   	bool dot_appended = false;
>> +	size_t n_len = __compiletime_strlen(name);
>> +	const size_t n_size = __member_size(name);
>>   
>> -	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>> +	if (n_len == SIZE_MAX || KSYM_NAME_LEN < n_size)
>> +		n_len = strnlen(name, KSYM_NAME_LEN);
>> +	
>> +	if (n_len >= KSYM_NAME_LEN)
>>   		return 0;
> 
> Isn't it possible to do this and not need __compiletime_strlen at all?
> 
> 	n_len = strnlen(name, min(__member_size(name), KSYM_NAME_LEN));

ppc_kallsyms_lookup_name() only has two callers and they call it with a 
built-in string. I think we can do something a lot simpler, something 
like (untested):

static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
{
	unsigned long addr = kallsyms_lookup_name(name);

	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
		addr = ppc_function_entry((void *)addr);

	return addr;
}

#ifdef CONFIG_PPC64_ELF_ABI_V1
#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." ## x);
#else
#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
#endif

Christophe
