Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D45663
	for <linux-hardening@vger.kernel.org>; Thu,  9 Nov 2023 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="1D962nzY"
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F322B26A8
	for <linux-hardening@vger.kernel.org>; Wed,  8 Nov 2023 19:47:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso376203b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 08 Nov 2023 19:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1699501671; x=1700106471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3uuAi3G0X6OpIHwR9Kx+exCB4k+x+TH2JOVCfjs18U=;
        b=1D962nzYGMuHiqs25mGlXUaF58zn/C3Q69VXEXjSoPFmV+qQk8RVVWSoqpz2/6Zsa7
         a3ipbMbEzQY1IVhEtyNxJrwHNkk6FsmOCRnDW4BJeR89A2+OBIbYFIlloVyJZdgK295x
         gdyfCbnhq+dcdtRZH0hRYm9i7oNPneM7AUx5Ilg5j+p2bVK4U3xGCj5Ndlt0XP5sZ283
         I68O5SJ5HdaDQm9cajxn6rme+yfGxmjRat/9xAOpsLhOjiVD9U7d7/jhkr23BbjA/oZJ
         gieGyv+5fBRVFDpLQAe7w4ILfwN4qD9RbSsSiXH477t93my2yztV/MpLSQIn/r+a8h7V
         DIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699501671; x=1700106471;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3uuAi3G0X6OpIHwR9Kx+exCB4k+x+TH2JOVCfjs18U=;
        b=Li798z7toyVED4ruRn4yeZBt+k++2YRoGysvQdH75e/WQYXBcYRaz4B0lOCBwZPsZo
         JotRNKOvKkqTGtjrqwTEcQQQ6EUYr6uyNPIKyRQ2GxB9+MhWhjc08q7k27gle6+BoVDA
         k+MOxeLsGRWxgBRhdQOYvEgEGLbZU+ae2Oz86RKBztBc4XCXW7P4IAfCR43Kn2EDygHG
         +2eO7L1vX231W+3uMygMnvv1uND45g3d4sZ5YZqF3D/kVGaCrWlL6OJePBvFU/xCQ8Xi
         l/oh6hLtdzOqYbZ0C1pv9b3O5BDHh3mzu5eyMo2te3A4pyEUK+p4MWbCimZNq5CT/GT3
         /pCA==
X-Gm-Message-State: AOJu0Yxw1bj8eeJZX2kEHOG05jvk+jrqco3SSYr1OTnr2jGtg2/GoVHn
	UqY7GRxJ2tLcjSeBwo0umLqSHQ==
X-Google-Smtp-Source: AGHT+IGd95v1zf1mFgt3p+A2cD4Le4/ZKMGHeN96e3WanzcnJLKSR08bIEh6isDGiR4jdH35vgs7Bw==
X-Received: by 2002:a05:6a20:9f90:b0:174:63a9:2aa with SMTP id mm16-20020a056a209f9000b0017463a902aamr4999017pzb.18.1699501671292;
        Wed, 08 Nov 2023 19:47:51 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001b03a1a3151sm2426300plg.70.2023.11.08.19.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 19:47:49 -0800 (PST)
Date: Wed, 08 Nov 2023 19:47:49 -0800 (PST)
X-Google-Original-Date: Wed, 08 Nov 2023 19:47:45 PST (-0800)
Subject:     Re: [PATCH] riscv: Support RANDOMIZE_KSTACK_OFFSET
In-Reply-To: <202311081552.062D21EB@keescook>
CC: songshuaishuai@tinylab.org, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, guoren@kernel.org, Bjorn Topel <bjorn@rivosinc.com>, jszhang@kernel.org,
  Conor Dooley <conor.dooley@microchip.com>, andy.chiu@sifive.com, samitolvanen@google.com, coelacanthushex@gmail.com,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: keescook@chromium.org
Message-ID: <mhng-32bb45f6-c7eb-4afb-a42a-a167a83ca760@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 08 Nov 2023 15:52:34 PST (-0800), keescook@chromium.org wrote:
> On Wed, Nov 01, 2023 at 02:44:23PM +0800, Song Shuai wrote:
>> Inspired from arm64's implement -- commit 70918779aec9
>> ("arm64: entry: Enable random_kstack_offset support")
>>
>> Add support of kernel stack offset randomization while handling syscall,
>> the offset is defaultly limited by KSTACK_OFFSET_MAX() (i.e. 10 bits).
>>
>> In order to avoid trigger stack canaries (due to __builtin_alloca) and
>> slowing down the entry path, use __no_stack_protector attribute to
>> disable stack protector for do_trap_ecall_u() at the function level.
>>
>> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>
> I can't speak to the correctness of the entropy level, but the usage of
> the helpers looks correct to me.

As far as I can tell the comment matches how the system behaves.  I'm 
not sure if that much entropy is useful.  I was poking around for a bit 
to try and figure that out, but after reading that comment at the top of 
include/linux/randomize_kstack.h I decided to stop ;)

So aside from those whitespace errors Damien pointed out,

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

It's too late for the merge window for me, but

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case someone else wants to take it still.  Otherwise I'll try and 
remember to pick it up right after the merge window, but with Plumbers 
things might be a bit clunky.

> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
>> ---
>> Testing with randomize_kstack_offset=y cmdline, lkdtm/stack-entropy.sh
>> showed appropriate stack offset instead of zero.
>> ---
>>  arch/riscv/Kconfig        |  1 +
>>  arch/riscv/kernel/traps.c | 18 +++++++++++++++++-
>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index d607ab0f7c6d..0e843de33f0c 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -100,6 +100,7 @@ config RISCV
>>  	select HAVE_ARCH_KGDB_QXFER_PKT
>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>> +	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>>  	select HAVE_ARCH_SECCOMP_FILTER
>>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>>  	select HAVE_ARCH_TRACEHOOK
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index 19807c4d3805..3f869b2d47c3 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/cpu.h>
>>  #include <linux/kernel.h>
>>  #include <linux/init.h>
>> +#include <linux/randomize_kstack.h>
>>  #include <linux/sched.h>
>>  #include <linux/sched/debug.h>
>>  #include <linux/sched/signal.h>
>> @@ -296,9 +297,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>>  	}
>>  }
>>
>> -asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>> +asmlinkage __visible __trap_section  __no_stack_protector
>> +void do_trap_ecall_u(struct pt_regs *regs)
>>  {
>>  	if (user_mode(regs)) {
>> +
>>  		long syscall = regs->a7;
>>
>>  		regs->epc += 4;
>> @@ -308,10 +311,23 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>
>>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>>
>> +		add_random_kstack_offset();
>> +
>>  		if (syscall >= 0 && syscall < NR_syscalls)
>>  			syscall_handler(regs, syscall);
>>  		else if (syscall != -1)
>>  			regs->a0 = -ENOSYS;
>> +		/*
>> +		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
>> +		 * so the maximum stack offset is 1k bytes (10 bits).
>> +		 *
>> +		 * The actual entropy will be further reduced by the compiler when
>> +		 * applying stack alignment constraints: 16-byte (i.e. 4-bit) aligned
>> +		 * for RV32I or RV64I.
>> +		 *
>> +		 * The resulting 6 bits of entropy is seen in SP[9:4].
>> +		 */
>> +		choose_random_kstack_offset(get_random_u16());
>>
>>  		syscall_exit_to_user_mode(regs);
>>  	} else {
>> --
>> 2.20.1
>>
