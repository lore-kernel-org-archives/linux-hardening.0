Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF9337692;
	Fri,  6 Feb 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770402408; cv=none; b=lqM4Q1NUmn0C8xhLY9ua2Jt3Dyhd8gKR8z9FUtuCnog1L9+q17lKK/dadmBs8y7qOwkWfQN+OOFMleYRYBQMIGXMOc1zFIrKkOHFGtT3/U6XREi8cwdtbQTxALidVS6lQi4ZBy3bE3io4clpCUUR+ZHRiOP9hKHmWEYjz/w+hTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770402408; c=relaxed/simple;
	bh=Q+y/6ZarY1Moq1E+Yvp9Oap15mVq6+C3qIQbLI2ly+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB0OMk8xt2ZkUps7VH51m4CteCSOLjJALwFBedRcIBefONdf+d7RXKhyicqg/aCq9KNdpGD/uQ2G7pzO0r1ZVe5HP4m/dQue5pr1dgZfKSwcBbuTfaaaQKpuDlZI5DhAQOApftSn1tVBN5xU4eTPCXoVY7wTf2Jn6U0zEXXM6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W65k6HRJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W65k6HRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB5DC116C6;
	Fri,  6 Feb 2026 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770402407;
	bh=Q+y/6ZarY1Moq1E+Yvp9Oap15mVq6+C3qIQbLI2ly+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W65k6HRJ5Hi1rr+kg5RtfkerZQBkRCJ8TcvstECu7FPkajAYwhwi325wNSexLzmQw
	 XciX/I2jujNbUiK91fHjF//z3BzRmzIRJMUP+Ca/3w5h2j63QA+94PMsYnGzLH+PfC
	 3NVQ8l/2v25rETLwSeB3lC6ge2tL84XYdxzbscwcA/4xmfCtbJEeNbMC5UQQrHm1ww
	 zdS8KXyHH0GwYKqwHFdwssGJFbmskaIKUIVOp4a2PCKldqBIS5Okyy0vejD72O41sV
	 YdgfOlDT689kXg9l6R9a7UzyrdJIz0QTZIvty9v2EyGNHupaUs20pumzX4gm1yfiLk
	 RXVdkqgSQLEOg==
Date: Fri, 6 Feb 2026 10:26:47 -0800
From: Kees Cook <kees@kernel.org>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, andy@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	lilinjie8@huawei.com, liaohua4@huawei.com
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible
 stringop-overread compilation error
Message-ID: <202602061024.111ED487@keescook>
References: <20260205100517.292858-1-xieyuanbin1@huawei.com>
 <20260205100517.292858-2-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205100517.292858-2-xieyuanbin1@huawei.com>

On Thu, Feb 05, 2026 at 06:05:17PM +0800, Xie Yuanbin wrote:
> For strnlen(), if the compiler detects that the maxlen argument exceeds
> the valid memory size of the input string object, a compilation error may
> occur.
> 
> For lastest linux-next source, changing ppc_kallsyms_lookup_name() to
> __always_inline, using default ppc64_defconfig, and setting
> CONFIG_EXPERT=y, CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2=n,
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Then, when using gcc-15 for compilation,
> the following error will be triggered:
> ```log
>   CC      arch/powerpc/kernel/optprobes.o
> In file included from ./arch/powerpc/include/asm/kprobes.h:24,
>                  from ./include/linux/kprobes.h:31,
>                  from arch/powerpc/kernel/optprobes.c:8:
> In function ‘ppc_kallsyms_lookup_name’,
>     inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:209:21:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
>   232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘ppc_kallsyms_lookup_name’,
>     inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:210:22:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
>   232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> ```
> 
> Refer to the implementation of fortify's strnlen(). If the string length
> is a compile-time constant, do not call the strnlen() function.
> 
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> ---
>  arch/powerpc/include/asm/text-patching.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/text-patching.h b/arch/powerpc/include/asm/text-patching.h
> index e7f14720f630..ce1b2131980a 100644
> --- a/arch/powerpc/include/asm/text-patching.h
> +++ b/arch/powerpc/include/asm/text-patching.h
> @@ -228,8 +228,13 @@ static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
>  	/* check for dot variant */
>  	char dot_name[1 + KSYM_NAME_LEN];
>  	bool dot_appended = false;
> +	size_t n_len = __compiletime_strlen(name);
> +	const size_t n_size = __member_size(name);
>  
> -	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
> +	if (n_len == SIZE_MAX || KSYM_NAME_LEN < n_size)
> +		n_len = strnlen(name, KSYM_NAME_LEN);
> +	
> +	if (n_len >= KSYM_NAME_LEN)
>  		return 0;

Isn't it possible to do this and not need __compiletime_strlen at all?

	n_len = strnlen(name, min(__member_size(name), KSYM_NAME_LEN));

?

>  
>  	if (name[0] != '.') {
> -- 
> 2.51.0
> 

-- 
Kees Cook
