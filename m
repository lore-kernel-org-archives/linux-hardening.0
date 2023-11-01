Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314301C17
	for <linux-hardening@vger.kernel.org>; Wed,  1 Nov 2023 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjjLTuv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA7CC433C7;
	Wed,  1 Nov 2023 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698822305;
	bh=j9ykpsBlFRKe7DDjM3F4E4o0mNxil1zOXhS2aCHKGpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YjjLTuv/okiR0psaAHUqPoY3KJE0Gv/tCKYbFkgJeyb0/c+tpUKx31DNUnNenjA7w
	 6s/plmHRr6YIa6EK1qtNHfQ/Zzk/6z628H5q4SCaF1nNjBfaEekACsBKoWbTGxnkj6
	 s7fbZnl47gRFwAAgaXkIFGcOvegKVhGlPlQSiEelu40AL15FkE8pp9BWxhgb0/cw6d
	 M7fnP1rqhZyQE7NQPx20WxeguOaxMr7WqpRAEWRkAlqXL8FCgjYQI4wsNn/H2Dj5kl
	 Ov7/yxXdxQFd21AEobNmSkerlr9FQKjoq6Liz3/kzE1ljkqF9R4cXxwIjJVgoKEnsb
	 SJAKIeqWUglow==
Message-ID: <5d80e129-b3b3-4bad-b432-897728113bb7@kernel.org>
Date: Wed, 1 Nov 2023 16:05:01 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Support RANDOMIZE_KSTACK_OFFSET
To: Song Shuai <songshuaishuai@tinylab.org>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, keescook@chromium.org,
 guoren@kernel.org, bjorn@rivosinc.com, jszhang@kernel.org,
 conor.dooley@microchip.com, andy.chiu@sifive.com, samitolvanen@google.com,
 coelacanthushex@gmail.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231101064423.1906122-1-songshuaishuai@tinylab.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231101064423.1906122-1-songshuaishuai@tinylab.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/23 15:44, Song Shuai wrote:
> Inspired from arm64's implement -- commit 70918779aec9
> ("arm64: entry: Enable random_kstack_offset support")
> 
> Add support of kernel stack offset randomization while handling syscall,
> the offset is defaultly limited by KSTACK_OFFSET_MAX() (i.e. 10 bits).
> 
> In order to avoid trigger stack canaries (due to __builtin_alloca) and
> slowing down the entry path, use __no_stack_protector attribute to
> disable stack protector for do_trap_ecall_u() at the function level.
> 
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
> Testing with randomize_kstack_offset=y cmdline, lkdtm/stack-entropy.sh
> showed appropriate stack offset instead of zero.
> ---
>  arch/riscv/Kconfig        |  1 +
>  arch/riscv/kernel/traps.c | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6d..0e843de33f0c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -100,6 +100,7 @@ config RISCV
>  	select HAVE_ARCH_KGDB_QXFER_PKT
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> +	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 19807c4d3805..3f869b2d47c3 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -6,6 +6,7 @@
>  #include <linux/cpu.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/randomize_kstack.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/signal.h>
> @@ -296,9 +297,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  	}
>  }
>  
> -asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
> +asmlinkage __visible __trap_section  __no_stack_protector
> +void do_trap_ecall_u(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
> +

White line change.

>  		long syscall = regs->a7;
>  
>  		regs->epc += 4;
> @@ -308,10 +311,23 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>  
> +		add_random_kstack_offset();
> +
>  		if (syscall >= 0 && syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
>  		else if (syscall != -1)
>  			regs->a0 = -ENOSYS;
> +		/*
> +		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> +		 * so the maximum stack offset is 1k bytes (10 bits).
> +		 *
> +		 * The actual entropy will be further reduced by the compiler when
> +		 * applying stack alignment constraints: 16-byte (i.e. 4-bit) aligned
> +		 * for RV32I or RV64I.
> +		 *
> +		 * The resulting 6 bits of entropy is seen in SP[9:4].
> +		 */
> +		choose_random_kstack_offset(get_random_u16());
>  
>  		syscall_exit_to_user_mode(regs);
>  	} else {

-- 
Damien Le Moal
Western Digital Research

