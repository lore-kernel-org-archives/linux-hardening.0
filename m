Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC4309F1C
	for <linux-hardening@vger.kernel.org>; Tue,  2 Dec 2025 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666936; cv=none; b=W8t+S4D33z9xzjT3w1qQ/IGocsQtQ68djqmOU7ZUVG5+Bx6rTbfFHuw5/WsiiD59W5fR6Ciq34PXFKKtfl4lFnMqfZr+ktD0SZP61e8xy6POmJYvfaQwL63mKPQnGbd7o/8DdBEpDXf0uR3EumVar6N34imJfpyMAafHvO1TP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666936; c=relaxed/simple;
	bh=b9JZ/9b867HgOxhfuCfHFuU5Zlq6dUjTHJIMq7OvdXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jr54j0rEtGhq4+GnTtjGzo3ylHAF6j6/YraMBlNhbCg0U/XmWEXc5pulxAvW/ntF1cIQS3naqpFgCBsXoncji1Upfd5uIJNC7qdmEJeKfCqcXpTODc4wTsyWyLaydR1yfonUmbDNn1zlQ/jhMZ68LWke7k2u7ih0HpXr/r9/h0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0DQOGW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0DQOGW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192DDC2BC9E
	for <linux-hardening@vger.kernel.org>; Tue,  2 Dec 2025 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764666936;
	bh=b9JZ/9b867HgOxhfuCfHFuU5Zlq6dUjTHJIMq7OvdXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l0DQOGW5Nvby5zv4HbcrFQNSkXfigXxt9yOxruzs7Z9Bc3b9oYkXS6Mnoopjb7TiW
	 bZIcDWTjtgihqsCRvSlrsHSQ8+Gqv7mWtsm8GIplKJJu8DfIPONp957BZRvT42a+I5
	 9ts4bhk4ACwmU09zGxS2286uOQ6s9A+ePriHFcC3cy6s8E2H2PbjgV1C01BTPAIG+r
	 zmVm1/SdANOOer1ennUviT2BSuuyYLQqn101ESAM8uEK4m29MlgIuekJxibUwEOJOD
	 4m2D12mZNcnaLjxm6B4eWuQPHRkCTOvQT5d7pGDH+P5MQLG7TrYrrsXR3u3Ktq3MNJ
	 uVC4vVq79AIiA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5957753e0efso5479423e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 02 Dec 2025 01:15:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3lx9sS6MHnfcZOYuabO/S7Qxf3kEvmheGLOvmg19+7z5StSleCd0VJs2v8//vrtUURpdtD0D37jz3iUCW/fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywbpFckTaDkbwmu6kQOKkmza0JTfEZ7wO7YPB6cZavkeOzR+4D
	7DA1io9PLElNoUs9ukA78WxtrOZ7i5sWdYhbtwN0OJnhSy+qUSR1jE4nndg4Hf33bUEWQnhexBe
	BCp9K1ea2/Fb+xZ7bJVHlKyeOFDZ71cI=
X-Google-Smtp-Source: AGHT+IF0C79JB38yU6KMu2bD0taBG1CYqGrCeqMTYdJgV/vjr4ympFA4D9VFbXEwegznrtURQTdg2BGWuvWNNniR1Fw=
X-Received: by 2002:a05:6512:3b93:b0:595:7cf5:f7cf with SMTP id
 2adb3069b0e04-596a3ede9dcmr14182023e87.38.1764666934245; Tue, 02 Dec 2025
 01:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127105958.2427758-1-ryan.roberts@arm.com>
 <20251127105958.2427758-3-ryan.roberts@arm.com> <CAMj1kXFY1RXk8T4f46bkm_sr0nJfBoO+ii68JK4+CsRiDwKdCg@mail.gmail.com>
 <9097505d-b18b-4f85-a02c-7f2865ad8bca@arm.com>
In-Reply-To: <9097505d-b18b-4f85-a02c-7f2865ad8bca@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Dec 2025 10:15:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHX1W2Kz5NJehtzDhOCKWEd6y1sp8+ViOMHGsq9e8=7Pw@mail.gmail.com>
X-Gm-Features: AWmQ_bkvk2Lylh9ZBNVWQbeJ2lY90jVEEA6b3x_hJfV43wB8DcjmAAS0L0aVmc0
Message-ID: <CAMj1kXHX1W2Kz5NJehtzDhOCKWEd6y1sp8+ViOMHGsq9e8=7Pw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] randomize_kstack: Unify random source across arches
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kees Cook <kees@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 19:20, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 28/11/2025 11:01, Ard Biesheuvel wrote:
> > On Thu, 27 Nov 2025 at 12:00, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> Previously different architectures were using random sources of
> >> differing strength and cost to decide the random kstack offset. A number
> >> of architectures (loongarch, powerpc, s390, x86) were using their
> >> timestamp counter, at whatever the frequency happened to be. Other
> >> arches (arm64, riscv) were using entropy from the crng via
> >> get_random_u16().
> >>
> >> There have been concerns that in some cases the timestamp counters may
> >> be too weak, because they can be easily guessed or influenced by user
> >> space. And get_random_u16() has been shown to be too costly for the
> >> level of protection kstack offset randomization provides.
> >>
> >> So let's use a common, architecture-agnostic source of entropy; a
> >> per-task prng, seeded at fork-time from the crng. This has a few
> >> benefits:
> >>
> >>   - We can remove choose_random_kstack_offset(); That was only there to
> >>     try to make the timestamp counter value a bit harder to influence
> >>     from user space.
> >>
> >>   - The architecture code is simplified. All it has to do now is call
> >>     add_random_kstack_offset() in the syscall path.
> >>
> >>   - The strength of the randomness can be reasoned about independently
> >>     of the architecture.
> >>
> >>   - Arches previously using get_random_u16() now have much faster
> >>     syscall paths, see below results.
> >>
> >> There have been some claims that a prng may be less strong than the
> >> timestamp counter if not regularly reseeded. But the prng has a period
> >> of about 2^113. So as long as the prng state remains secret, it should
> >> not be possible to guess. If the prng state can be accessed, we have
> >> bigger problems.
> >>
> >> Additionally, we are only consuming 6 bits to randomize the stack, so
> >> there are only 64 possible random offsets. I assert that it would be
> >> trivial for an attacker to brute force by repeating their attack and
> >> waiting for the random stack offset to be the desired one. The prng
> >> approach seems entirely proportional to this level of protection.
> >>
> >> Performance data are provided below. The baseline is v6.18-rc5 with
> >> rndstack on for each respective arch. (I)/(R) indicate statistically
> >> significant improvement/regression. arm64 platform is AWS Graviton3.
> >> x86_64 platform is AWS Sapphire Rapids:
> >>
> >> +-----------------+--------------+---------------+---------------+
> >> | Benchmark       | Result Class | per-task-prng | per-task-prng |
> >> |                 |              |         arm64 |        x86_64 |
> >> +=================+==============+===============+===============+
> >> | syscall/getpid  | mean (ns)    |   (I) -10.54% |    (I) -7.69% |
> >> |                 | p99 (ns)     |   (I) -59.53% |         4.14% |
> >> |                 | p99.9 (ns)   |   (I) -59.90% |         2.68% |
> >> +-----------------+--------------+---------------+---------------+
> >> | syscall/getppid | mean (ns)    |   (I) -10.49% |    (I) -5.98% |
> >> |                 | p99 (ns)     |   (I) -59.83% |        -3.11% |
> >> |                 | p99.9 (ns)   |   (I) -59.88% |     (R) 9.84% |
> >> +-----------------+--------------+---------------+---------------+
> >> | syscall/invalid | mean (ns)    |    (I) -9.28% |    (I) -6.94% |
> >> |                 | p99 (ns)     |   (I) -61.06% |    (I) -5.57% |
> >> |                 | p99.9 (ns)   |   (I) -61.40% |    (R) 10.53% |
> >> +-----------------+--------------+---------------+---------------+
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  arch/Kconfig                         |  5 ++--
> >>  arch/arm64/kernel/syscall.c          | 11 -------
> >>  arch/loongarch/kernel/syscall.c      | 11 -------
> >>  arch/powerpc/kernel/syscall.c        | 12 --------
> >>  arch/riscv/kernel/traps.c            | 12 --------
> >>  arch/s390/include/asm/entry-common.h |  8 ------
> >>  arch/x86/include/asm/entry-common.h  | 12 --------
> >>  include/linux/prandom.h              |  7 ++++-
> >>  include/linux/randomize_kstack.h     | 43 ++++++++--------------------
> >>  include/linux/sched.h                |  3 +-
> >>  10 files changed, 22 insertions(+), 102 deletions(-)
> >>
> >
> > I think this is a substantial improvement over the status quo,
> > especially with all the dodgy uses of monotonic counters with
> > unspecified granularity.
> >
> > So with two comments below:
> >
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks!
>
> I shall plan to re-post without the RFC tag against -rc1 then, and we will see
> if anyone pushes back.
>

Sounds good.

...
> >> diff --git a/include/linux/prandom.h b/include/linux/prandom.h
> >> index f2ed5b72b3d6..827edde11cb9 100644
> >> --- a/include/linux/prandom.h
> >> +++ b/include/linux/prandom.h
> >> @@ -10,13 +10,18 @@
> >>
> >>  #include <linux/types.h>
> >>  #include <linux/once.h>
> >> -#include <linux/percpu.h>
> >>  #include <linux/random.h>
> >>
> >>  struct rnd_state {
> >>         __u32 s1, s2, s3, s4;
> >>  };
> >>
> >> +/*
> >> + * percpu.h includes sched.h, which requires struct rnd_state. So defer until
> >> + * after struct rnd_state is defined.
> >> + */
> >> +#include <linux/percpu.h>
> >> +
> >
> > Yuck. Is this the best we can do to disentangle this?
>
> I think I might be able to remove some stuff out of sched.h into alloc_tag.h
> (looks to me like it should have been there all along). And that will allow
> removing the sched.h include from percpu.h. I think that will solve it.
>

OK.

> >> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> >> index 089b1432f7e6..83c7e6710f6d 100644
> >> --- a/include/linux/randomize_kstack.h
> >> +++ b/include/linux/randomize_kstack.h
> >> @@ -6,6 +6,7 @@
> >>  #include <linux/kernel.h>
> >>  #include <linux/jump_label.h>
> >>  #include <linux/percpu-defs.h>
> >> +#include <linux/prandom.h>
> >>
> >>  DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> >>                          randomize_kstack_offset);
> >> @@ -45,9 +46,13 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> >>  #define KSTACK_OFFSET_MAX(x)   ((x) & 0b1111111100)
> >>  #endif
> >>
> >> +static __always_inline u32 get_update_kstack_offset(void)
> >> +{
> >> +       return prandom_u32_state(&current->kstack_rnd_state);
>
> I've got bot warnings because this is being called from noinstr code. I guess
> the best option is to just move add_random_kstack_offset() to after
> instrumentation is enabled for the affected arches.
>

Just put instrumentation_begin()/instrumentation_end() around the call
to prandom_u32_state() - that seems to be the common approach for
punching holes into the 'noinstr' validation.


> >> +}
> >> +
> >>  /**
> >> - * add_random_kstack_offset - Increase stack utilization by previously
> >> - *                           chosen random offset
> >> + * add_random_kstack_offset - Increase stack utilization by a random offset.
> >>   *
> >>   * This should be used in the syscall entry path after user registers have been
> >>   * stored to the stack. Preemption may be enabled. For testing the resulting
> >> @@ -56,46 +61,22 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> >>  #define add_random_kstack_offset() do {                                        \
> >>         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
> >>                                 &randomize_kstack_offset)) {            \
> >> -               u32 offset = current->kstack_offset;                    \
> >> +               u32 offset = get_update_kstack_offset();                \
> >>                 u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));   \
> >>                 /* Keep allocation even after "ptr" loses scope. */     \
> >>                 asm volatile("" :: "r"(ptr) : "memory");                \
> >>         }                                                               \
> >>  } while (0)
> >>
> >> -/**
> >> - * choose_random_kstack_offset - Choose the random offset for the next
> >> - *                              add_random_kstack_offset()
> >> - *
> >> - * This should only be used during syscall exit. Preemption may be enabled. This
> >> - * position in the syscall flow is done to frustrate attacks from userspace
> >> - * attempting to learn the next offset:
> >> - * - Maximize the timing uncertainty visible from userspace: if the
> >> - *   offset is chosen at syscall entry, userspace has much more control
> >> - *   over the timing between choosing offsets. "How long will we be in
> >> - *   kernel mode?" tends to be more difficult to predict than "how long
> >> - *   will we be in user mode?"
> >> - * - Reduce the lifetime of the new offset sitting in memory during
> >> - *   kernel mode execution. Exposure of "thread-local" memory content
> >> - *   (e.g. current, percpu, etc) tends to be easier than arbitrary
> >> - *   location memory exposure.
> >> - */
> >> -#define choose_random_kstack_offset(rand) do {                         \
> >> -       if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
> >> -                               &randomize_kstack_offset)) {            \
> >> -               u32 offset = current->kstack_offset;                    \
> >> -               offset = ror32(offset, 5) ^ (rand);                     \
> >> -               current->kstack_offset = offset;                        \
> >> -       }                                                               \
> >> -} while (0)
> >> -
> >>  static inline void random_kstack_task_init(struct task_struct *tsk)
> >>  {
> >> -       current->kstack_offset = 0;
> >> +       if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> >> +                               &randomize_kstack_offset)) {
> >> +               prandom_seed_state(&tsk->kstack_rnd_state, get_random_u64());
> >
> > We should either fix prandom_seed_state() not to truncate the u64 to
> > u32, or even better, refactor prandom_seed_full_state() so we can
> > reuse it here, and use a 128-bit seed directly.
>
> How about something like this:
>

Looks good to me, but it does make we wonder why a full prandom state
(i.e., one per cpu) isn't sufficient here, and why we are putting one
in every task. Is it just to avoid the overhead of dis/enabling
preemption on every syscall entry?





>
> ---8<---
> diff --git a/include/linux/prandom.h b/include/linux/prandom.h
> index f2ed5b72b3d6..9b651c9b3448 100644
> --- a/include/linux/prandom.h
> +++ b/include/linux/prandom.h
> @@ -19,10 +19,11 @@ struct rnd_state {
>
>  u32 prandom_u32_state(struct rnd_state *state);
>  void prandom_bytes_state(struct rnd_state *state, void *buf, size_t nbytes);
> -void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
> +void prandom_seed_full_state_one(struct rnd_state *state);
> +void prandom_seed_full_state_all(struct rnd_state __percpu *pcpu_state);
>
>  #define prandom_init_once(pcpu_state)                  \
> -       DO_ONCE(prandom_seed_full_state, (pcpu_state))
> +       DO_ONCE(prandom_seed_full_state_all, (pcpu_state))
>
>  /*
>   * Handle minimum values for seeds
> diff --git a/lib/random32.c b/lib/random32.c
> index 24e7acd9343f..50d8f5f9fca7 100644
> --- a/lib/random32.c
> +++ b/lib/random32.c
> @@ -107,24 +107,28 @@ static void prandom_warmup(struct rnd_state *state)
>         prandom_u32_state(state);
>  }
>
> -void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
> +void prandom_seed_full_state_one(struct rnd_state *state)
>  {
> -       int i;
> +       u32 seeds[4];
>
> -       for_each_possible_cpu(i) {
> -               struct rnd_state *state = per_cpu_ptr(pcpu_state, i);
> -               u32 seeds[4];
> +       get_random_bytes(&seeds, sizeof(seeds));
> +       state->s1 = __seed(seeds[0],   2U);
> +       state->s2 = __seed(seeds[1],   8U);
> +       state->s3 = __seed(seeds[2],  16U);
> +       state->s4 = __seed(seeds[3], 128U);
>
> -               get_random_bytes(&seeds, sizeof(seeds));
> -               state->s1 = __seed(seeds[0],   2U);
> -               state->s2 = __seed(seeds[1],   8U);
> -               state->s3 = __seed(seeds[2],  16U);
> -               state->s4 = __seed(seeds[3], 128U);
> +       prandom_warmup(state);
> +}
> +EXPORT_SYMBOL(prandom_seed_full_state_one);
>
> -               prandom_warmup(state);
> -       }
> +void prandom_seed_full_state_all(struct rnd_state __percpu *pcpu_state)
> +{
> +       int i;
> +
> +       for_each_possible_cpu(i)
> +               prandom_seed_full_state_one(per_cpu_ptr(pcpu_state, i));
>  }
> -EXPORT_SYMBOL(prandom_seed_full_state);
> +EXPORT_SYMBOL(prandom_seed_full_state_all);
>
>  #ifdef CONFIG_RANDOM32_SELFTEST
>  static struct prandom_test1 {
> ---8<---
>
