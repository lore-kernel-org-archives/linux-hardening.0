Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD22D63EF
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764327726; cv=none; b=Ft9HI1uIWJZWgTOzu0ft7jDPJ3Ug8E/liZwp/gr/sFnPEcQQh3oOj+PhvFx+3WyrDmbFNIHhPXITEFcLf4YzOENYM/IvYyR4CtiGrV+VqZtkhlC/1wDQTe92QTeS1KtAsf6q1tbbt6ePZcwE246eVux34VB1l7VlIXVfNnspXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764327726; c=relaxed/simple;
	bh=wvxulKWyoW1pPR9VMIyKB43jax88fLgmoK2TCafecDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqhOBDMkbxgvVdWa5Ep7T9nOUzdxTFKXAA1A7HVmzx4b6Ojj8SZBcLNGOKFkmnVCJvMKIKeoEfJscEnc16Ml/9E+TIDxDgxizWgn4Kxdhs4JKC+TTVUNvH4DL5JEp9AMOvnSG2I3o20OL7tRST+Wc5D8eeZz3ciTR/5mKYChtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvdc+/En; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvdc+/En"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6621FC4CEF1
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764327725;
	bh=wvxulKWyoW1pPR9VMIyKB43jax88fLgmoK2TCafecDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qvdc+/EnzN21CTI3Dry7Lv6Tnb3H0qm07YCaQPSKCKAUYQq3T3JB9bAIRAVWfrYX7
	 0A63xKu3H0jrT7zZDVa6cgxVgjbcxG9WT6VYIlmqHXAExjS30w1O/Zg+RNp5bYRsoN
	 WKj9ESIrssDVijOJ+5DWyKnh3xedvcmAcOYULzTugLaq9PRgJ9+n/D9wAtrh/1gE2A
	 a43r0Swy1IYQZEA4LgtvJtnuQOTqiW8li6pbleOgW2GgUMWABruU2E16NiiYTkRIAb
	 I4pAKK2/jk3Eszs0H5QxkyfgXvIBLzkfgpaeCbBJWo65Ph0CiZ5cYBdlwVaPzK9xZK
	 NolCIL1GNNs8w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-596a055b1b8so1945722e87.0
        for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 03:02:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVo+2jw6o6cQPycX7/0LKmR1ywv0uiJI3/3yAibdqHZwHsKHVv/7GYIjObhaTqP8zzWvd544JW66GeloOrH93s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEK32+esedSgNczq0u6rqT/m5pTLbeE06d6y35KrWRIyP/Nw6
	whjwEYClQW80e57tl+nAP3gSd9s+ucIYrlPTyVMWvg33pwcqhvpAGNgg4qPFFHtFQjfyWAoBz2u
	pHwXtQeV21oD3WhOFsxidZ/30YdG2oeA=
X-Google-Smtp-Source: AGHT+IHiJ61HlH24mY79Q740mZtvkulqngniouun24w9AakN11+tXs343fMVFE34xHdVJDw/kqutxyTW9RCkWltnPXY=
X-Received: by 2002:a05:6512:2215:b0:579:ac00:1f20 with SMTP id
 2adb3069b0e04-596a3eb5dccmr9163196e87.2.1764327723632; Fri, 28 Nov 2025
 03:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127105958.2427758-1-ryan.roberts@arm.com> <20251127105958.2427758-3-ryan.roberts@arm.com>
In-Reply-To: <20251127105958.2427758-3-ryan.roberts@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 28 Nov 2025 12:01:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFY1RXk8T4f46bkm_sr0nJfBoO+ii68JK4+CsRiDwKdCg@mail.gmail.com>
X-Gm-Features: AWmQ_bnc_FGl57LGZe1Rf8p91qhS5bO0G60OfDXphdfUcaH6XBzC5rCC5UnLJIA
Message-ID: <CAMj1kXFY1RXk8T4f46bkm_sr0nJfBoO+ii68JK4+CsRiDwKdCg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] randomize_kstack: Unify random source across arches
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kees Cook <kees@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 12:00, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> Previously different architectures were using random sources of
> differing strength and cost to decide the random kstack offset. A number
> of architectures (loongarch, powerpc, s390, x86) were using their
> timestamp counter, at whatever the frequency happened to be. Other
> arches (arm64, riscv) were using entropy from the crng via
> get_random_u16().
>
> There have been concerns that in some cases the timestamp counters may
> be too weak, because they can be easily guessed or influenced by user
> space. And get_random_u16() has been shown to be too costly for the
> level of protection kstack offset randomization provides.
>
> So let's use a common, architecture-agnostic source of entropy; a
> per-task prng, seeded at fork-time from the crng. This has a few
> benefits:
>
>   - We can remove choose_random_kstack_offset(); That was only there to
>     try to make the timestamp counter value a bit harder to influence
>     from user space.
>
>   - The architecture code is simplified. All it has to do now is call
>     add_random_kstack_offset() in the syscall path.
>
>   - The strength of the randomness can be reasoned about independently
>     of the architecture.
>
>   - Arches previously using get_random_u16() now have much faster
>     syscall paths, see below results.
>
> There have been some claims that a prng may be less strong than the
> timestamp counter if not regularly reseeded. But the prng has a period
> of about 2^113. So as long as the prng state remains secret, it should
> not be possible to guess. If the prng state can be accessed, we have
> bigger problems.
>
> Additionally, we are only consuming 6 bits to randomize the stack, so
> there are only 64 possible random offsets. I assert that it would be
> trivial for an attacker to brute force by repeating their attack and
> waiting for the random stack offset to be the desired one. The prng
> approach seems entirely proportional to this level of protection.
>
> Performance data are provided below. The baseline is v6.18-rc5 with
> rndstack on for each respective arch. (I)/(R) indicate statistically
> significant improvement/regression. arm64 platform is AWS Graviton3.
> x86_64 platform is AWS Sapphire Rapids:
>
> +-----------------+--------------+---------------+---------------+
> | Benchmark       | Result Class | per-task-prng | per-task-prng |
> |                 |              |         arm64 |        x86_64 |
> +=================+==============+===============+===============+
> | syscall/getpid  | mean (ns)    |   (I) -10.54% |    (I) -7.69% |
> |                 | p99 (ns)     |   (I) -59.53% |         4.14% |
> |                 | p99.9 (ns)   |   (I) -59.90% |         2.68% |
> +-----------------+--------------+---------------+---------------+
> | syscall/getppid | mean (ns)    |   (I) -10.49% |    (I) -5.98% |
> |                 | p99 (ns)     |   (I) -59.83% |        -3.11% |
> |                 | p99.9 (ns)   |   (I) -59.88% |     (R) 9.84% |
> +-----------------+--------------+---------------+---------------+
> | syscall/invalid | mean (ns)    |    (I) -9.28% |    (I) -6.94% |
> |                 | p99 (ns)     |   (I) -61.06% |    (I) -5.57% |
> |                 | p99.9 (ns)   |   (I) -61.40% |    (R) 10.53% |
> +-----------------+--------------+---------------+---------------+
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/Kconfig                         |  5 ++--
>  arch/arm64/kernel/syscall.c          | 11 -------
>  arch/loongarch/kernel/syscall.c      | 11 -------
>  arch/powerpc/kernel/syscall.c        | 12 --------
>  arch/riscv/kernel/traps.c            | 12 --------
>  arch/s390/include/asm/entry-common.h |  8 ------
>  arch/x86/include/asm/entry-common.h  | 12 --------
>  include/linux/prandom.h              |  7 ++++-
>  include/linux/randomize_kstack.h     | 43 ++++++++--------------------
>  include/linux/sched.h                |  3 +-
>  10 files changed, 22 insertions(+), 102 deletions(-)
>

I think this is a substantial improvement over the status quo,
especially with all the dodgy uses of monotonic counters with
unspecified granularity.

So with two comments below:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/arch/Kconfig b/arch/Kconfig
> index 61130b88964b..b2c70c9dc098 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1519,9 +1519,8 @@ config HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>         def_bool n
>         help
>           An arch should select this symbol if it can support kernel stack
> -         offset randomization with calls to add_random_kstack_offset()
> -         during syscall entry and choose_random_kstack_offset() during
> -         syscall exit. Careful removal of -fstack-protector-strong and
> +         offset randomization with a call to add_random_kstack_offset()
> +         during syscall entry. Careful removal of -fstack-protector-strong and
>           -fstack-protector should also be applied to the entry code and
>           closely examined, as the artificial stack bump looks like an array
>           to the compiler, so it will attempt to add canary checks regardless
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index aba7ca6bca2d..957c4ccd5d14 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -52,17 +52,6 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>         }
>
>         syscall_set_return_value(current, regs, 0, ret);
> -
> -       /*
> -        * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
> -        * bits. The actual entropy will be further reduced by the compiler
> -        * when applying stack alignment constraints: the AAPCS mandates a
> -        * 16-byte aligned SP at function boundaries, which will remove the
> -        * 4 low bits from any entropy chosen here.
> -        *
> -        * The resulting 6 bits of entropy is seen in SP[9:4].
> -        */
> -       choose_random_kstack_offset(get_random_u16());
>  }
>
>  static inline bool has_syscall_work(unsigned long flags)
> diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
> index 168bd97540f8..80544a5ec6e1 100644
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -66,16 +66,5 @@ void noinstr __no_stack_protector do_syscall(struct pt_regs *regs)
>                                            regs->regs[7], regs->regs[8], regs->regs[9]);
>         }
>
> -       /*
> -        * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
> -        * bits. The actual entropy will be further reduced by the compiler
> -        * when applying stack alignment constraints: 16-bytes (i.e. 4-bits)
> -        * aligned, which will remove the 4 low bits from any entropy chosen
> -        * here.
> -        *
> -        * The resulting 6 bits of entropy is seen in SP[9:4].
> -        */
> -       choose_random_kstack_offset(drdtime());
> -
>         syscall_exit_to_user_mode(regs);
>  }
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index be159ad4b77b..b3d8b0f9823b 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -173,17 +173,5 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>         }
>  #endif
>
> -       /*
> -        * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> -        * so the maximum stack offset is 1k bytes (10 bits).
> -        *
> -        * The actual entropy will be further reduced by the compiler when
> -        * applying stack alignment constraints: the powerpc architecture
> -        * may have two kinds of stack alignment (16-bytes and 8-bytes).
> -        *
> -        * So the resulting 6 or 7 bits of entropy is seen in SP[9:4] or SP[9:3].
> -        */
> -       choose_random_kstack_offset(mftb());
> -
>         return ret;
>  }
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 80230de167de..79b285bdfd1a 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -342,18 +342,6 @@ void do_trap_ecall_u(struct pt_regs *regs)
>                 if (syscall >= 0 && syscall < NR_syscalls)
>                         syscall_handler(regs, syscall);
>
> -               /*
> -                * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> -                * so the maximum stack offset is 1k bytes (10 bits).
> -                *
> -                * The actual entropy will be further reduced by the compiler when
> -                * applying stack alignment constraints: 16-byte (i.e. 4-bit) aligned
> -                * for RV32I or RV64I.
> -                *
> -                * The resulting 6 bits of entropy is seen in SP[9:4].
> -                */
> -               choose_random_kstack_offset(get_random_u16());
> -
>                 syscall_exit_to_user_mode(regs);
>         } else {
>                 irqentry_state_t state = irqentry_nmi_enter(regs);
> diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
> index 979af986a8fe..35450a485323 100644
> --- a/arch/s390/include/asm/entry-common.h
> +++ b/arch/s390/include/asm/entry-common.h
> @@ -51,14 +51,6 @@ static __always_inline void arch_exit_to_user_mode(void)
>
>  #define arch_exit_to_user_mode arch_exit_to_user_mode
>
> -static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
> -                                                 unsigned long ti_work)
> -{
> -       choose_random_kstack_offset(get_tod_clock_fast());
> -}
> -
> -#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
> -
>  static __always_inline bool arch_in_rcu_eqs(void)
>  {
>         if (IS_ENABLED(CONFIG_KVM))
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
> index ce3eb6d5fdf9..7535131c711b 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -82,18 +82,6 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>         current_thread_info()->status &= ~(TS_COMPAT | TS_I386_REGS_POKED);
>  #endif
>
> -       /*
> -        * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
> -        * bits. The actual entropy will be further reduced by the compiler
> -        * when applying stack alignment constraints (see cc_stack_align4/8 in
> -        * arch/x86/Makefile), which will remove the 3 (x86_64) or 2 (ia32)
> -        * low bits from any entropy chosen here.
> -        *
> -        * Therefore, final stack offset entropy will be 7 (x86_64) or
> -        * 8 (ia32) bits.
> -        */
> -       choose_random_kstack_offset(rdtsc());
> -
>         /* Avoid unnecessary reads of 'x86_ibpb_exit_to_user' */
>         if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER) &&
>             this_cpu_read(x86_ibpb_exit_to_user)) {
> diff --git a/include/linux/prandom.h b/include/linux/prandom.h
> index f2ed5b72b3d6..827edde11cb9 100644
> --- a/include/linux/prandom.h
> +++ b/include/linux/prandom.h
> @@ -10,13 +10,18 @@
>
>  #include <linux/types.h>
>  #include <linux/once.h>
> -#include <linux/percpu.h>
>  #include <linux/random.h>
>
>  struct rnd_state {
>         __u32 s1, s2, s3, s4;
>  };
>
> +/*
> + * percpu.h includes sched.h, which requires struct rnd_state. So defer until
> + * after struct rnd_state is defined.
> + */
> +#include <linux/percpu.h>
> +

Yuck. Is this the best we can do to disentangle this?

>  u32 prandom_u32_state(struct rnd_state *state);
>  void prandom_bytes_state(struct rnd_state *state, void *buf, size_t nbytes);
>  void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> index 089b1432f7e6..83c7e6710f6d 100644
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -6,6 +6,7 @@
>  #include <linux/kernel.h>
>  #include <linux/jump_label.h>
>  #include <linux/percpu-defs.h>
> +#include <linux/prandom.h>
>
>  DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>                          randomize_kstack_offset);
> @@ -45,9 +46,13 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>  #define KSTACK_OFFSET_MAX(x)   ((x) & 0b1111111100)
>  #endif
>
> +static __always_inline u32 get_update_kstack_offset(void)
> +{
> +       return prandom_u32_state(&current->kstack_rnd_state);
> +}
> +
>  /**
> - * add_random_kstack_offset - Increase stack utilization by previously
> - *                           chosen random offset
> + * add_random_kstack_offset - Increase stack utilization by a random offset.
>   *
>   * This should be used in the syscall entry path after user registers have been
>   * stored to the stack. Preemption may be enabled. For testing the resulting
> @@ -56,46 +61,22 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>  #define add_random_kstack_offset() do {                                        \
>         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
>                                 &randomize_kstack_offset)) {            \
> -               u32 offset = current->kstack_offset;                    \
> +               u32 offset = get_update_kstack_offset();                \
>                 u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));   \
>                 /* Keep allocation even after "ptr" loses scope. */     \
>                 asm volatile("" :: "r"(ptr) : "memory");                \
>         }                                                               \
>  } while (0)
>
> -/**
> - * choose_random_kstack_offset - Choose the random offset for the next
> - *                              add_random_kstack_offset()
> - *
> - * This should only be used during syscall exit. Preemption may be enabled. This
> - * position in the syscall flow is done to frustrate attacks from userspace
> - * attempting to learn the next offset:
> - * - Maximize the timing uncertainty visible from userspace: if the
> - *   offset is chosen at syscall entry, userspace has much more control
> - *   over the timing between choosing offsets. "How long will we be in
> - *   kernel mode?" tends to be more difficult to predict than "how long
> - *   will we be in user mode?"
> - * - Reduce the lifetime of the new offset sitting in memory during
> - *   kernel mode execution. Exposure of "thread-local" memory content
> - *   (e.g. current, percpu, etc) tends to be easier than arbitrary
> - *   location memory exposure.
> - */
> -#define choose_random_kstack_offset(rand) do {                         \
> -       if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
> -                               &randomize_kstack_offset)) {            \
> -               u32 offset = current->kstack_offset;                    \
> -               offset = ror32(offset, 5) ^ (rand);                     \
> -               current->kstack_offset = offset;                        \
> -       }                                                               \
> -} while (0)
> -
>  static inline void random_kstack_task_init(struct task_struct *tsk)
>  {
> -       current->kstack_offset = 0;
> +       if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> +                               &randomize_kstack_offset)) {
> +               prandom_seed_state(&tsk->kstack_rnd_state, get_random_u64());

We should either fix prandom_seed_state() not to truncate the u64 to
u32, or even better, refactor prandom_seed_full_state() so we can
reuse it here, and use a 128-bit seed directly.

> +       }
>  }
>  #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  #define add_random_kstack_offset()             do { } while (0)
> -#define choose_random_kstack_offset(rand)      do { } while (0)
>  #define random_kstack_task_init(tsk)           do { } while (0)
>  #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index dae227d217ef..ac0402c2b988 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -34,6 +34,7 @@
>  #include <linux/sched/prio.h>
>  #include <linux/sched/types.h>
>  #include <linux/signal_types.h>
> +#include <linux/prandom.h>
>  #include <linux/spinlock.h>
>  #include <linux/syscall_user_dispatch_types.h>
>  #include <linux/mm_types_task.h>
> @@ -1614,7 +1615,7 @@ struct task_struct {
>  #endif
>
>  #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> -       u32                             kstack_offset;
> +       struct rnd_state                kstack_rnd_state;
>  #endif
>
>  #ifdef CONFIG_X86_MCE
> --
> 2.43.0
>
>
