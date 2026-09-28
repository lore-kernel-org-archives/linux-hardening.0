Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F13C7DE8;
	Mon, 28 Sep 2026 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627866; cv=none; b=QuQI2/ruVAh4JNYT9993ehRUUDpcTlR+2/X71NYZUyORpCfCVbAyjSpJyczrIbWnNimnh80jx1R3rPUEe634gcQGJuS9k6/1p4ey/sX7k4TL7l/1RkHNAbfk1AiWHILl/YrDt+GRKCOUp5nIPUpIqDIffK9siQSSRllATe7ZZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627866; c=relaxed/simple;
	bh=L19v8Y5pFWFkj2JY75fcV0tyu/ZGyyA8c+XEsOlbFzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tk3DvB1ivR7FdfZ6O+erpftJ7OQ1pHFPljBLWodKcR0tIaUJ63auhYn1NOsNk5ZVovYqohoEaV9ZDPirCQxCjhOqVduBoYGzNUGjCsWVjFlV70tNcvGHDWPAdpAS5h6xDKBQuSDVSB12a0x0WsBQx1/rzBZ72zHzk/FTYlsW17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wgwhPxy8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wgwhPxy8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4tAW3SlP431F7bjWdI4ygJqmG7YuYjWhSnR8WVAPb5Q=; b=wgwhPxy8Tk1YMJ1hy/Ypbhb4r1
	xWswkSfytQMmBcdva/7O7JMfMNnKn4BMxHBGxKnDVBVaN6inyuo4O8W9t7K/emQ3H4FVgQvx47BeK
	45m1cOLuYsZgllZRJogqRAsj1o8/kgw4f3p/kD/EkenWTlvSFbsEszvw8116pQrZbPpQUSto3TKzW
	3DI53KR9Qznor5mfThIGGEwofi/PY1e5r2cuf9fb3mnv+mB3a4cXwisUnbN6DzLGbdGJZ2wsEFKiR
	22UxwFKn/640pqKtmcR4GNZBvePNE78jqGV67ciq2cm/YHQY+80D2ZarNCPc1Inv+GEayJEt1La9H
	FMfMCs2g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBI6U-00000001aN3-2nto;
	Mon, 28 Sep 2026 20:37:38 +0000
Message-ID: <5c6edcfe-8332-4db6-b0fa-ca5d137a2075@infradead.org>
Date: Mon, 28 Sep 2026 13:37:37 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/15] sched/task_stack: Introduce
 ARCH_HAS_VARIABLE_STACK_SIZE
To: Mostafa Saleh <smostafa@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
 will@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org,
 urezki@gmail.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, kees@kernel.org,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, gustavoars@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org
References: <20260928174122.3380703-1-smostafa@google.com>
 <20260928174122.3380703-13-smostafa@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260928174122.3380703-13-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 10:41 AM, Mostafa Saleh wrote:
> When CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE is enabled, the kernel stack
> may not be fully populated with the THREAD_SIZE virtual area.
> 
> Teach task_stack_size() to return the size of the vm area and not a
> fixed size.
> 
> This propagates to end_of_stack() which makes functions like
> stack_not_used() and set_task_stack_end_magic() to use the lowest
> valid stack address instead of THREAD_SIZE which would cause data
> aborts.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  arch/Kconfig                     | 10 ++++++++++
>  include/linux/sched/task_stack.h |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 45c657772362..d6fa2ccb0599 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -431,6 +431,16 @@ config HAVE_ASM_MODVERSIONS
>  	  <asm/asm-prototypes.h> to support the module versioning for symbols
>  	  exported from assembly code.
>  
> +config ARCH_HAS_VARIABLE_STACK_SIZE
> +	bool
> +	depends on VMAP_STACK
> +	depends on !STACK_GROWSUP
> +	depends on THREAD_INFO_IN_TASK
> +	help
> +	  An arch should select this if it supports dynamically configuring the
> +	  kernel stack size.
> +	  For example the kernel stack size can be from the command line.

	                                    can be set from the command line.
?

> +
>  config HAVE_REGS_AND_STACK_ACCESS_API
>  	bool
>  	help
> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> index 4a808f9c4631..07d73adaecd1 100644
> --- a/include/linux/sched/task_stack.h
> +++ b/include/linux/sched/task_stack.h
> @@ -10,6 +10,7 @@
>  #include <linux/magic.h>
>  #include <linux/refcount.h>
>  #include <linux/kasan.h>
> +#include <linux/vmalloc.h>
>  
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  
> @@ -96,6 +97,10 @@ static inline unsigned long *end_of_stack(const struct task_struct *p)
>   */
>  static __always_inline unsigned long task_stack_size(const struct task_struct *task)
>  {
> +#ifdef CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE
> +	if (task->stack_vm_area)
> +		return task->stack_vm_area->nr_pages * PAGE_SIZE;
> +#endif
>  	return THREAD_SIZE;
>  }
>  

-- 
~Randy

