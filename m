Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661A2D7817
	for <linux-hardening@vger.kernel.org>; Thu,  9 Apr 2026 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751423; cv=none; b=nlP8IJyjUkvIWAPHkq13CjNf4GrAD7p29Q6qDXxEfR2aTKZcm+MNmDaqhN6Lt/F6Ep7Gx1m4IGeXOu4yaZuLdRMPW1X/3Iiud3tQiAcYzokJGTzF4fwjWZoWyoaHynIXd6RhAgyuzi6kOOur5VbqsZDkOkhOsoM0cM+L+sjr+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751423; c=relaxed/simple;
	bh=xfTIKtj5PwV74myDp2OytDSJiXzkqlmmQuhRTaEsOu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvFcGLHIsnHWgXKCy9wIRbEIlyRI+7o8x7SyzXiMnfuZ7I0GbvPNblV+Vi+yyl0g3DRD1SRSlbDv51e2n99nmp2WjnlFw2V5/7XSUyMCtb0aKtu2Fga85VJCpgGg3KnQ0Xj0qkki1I1bdraBjVASMtIUBAGUARr4mspOc9kJaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvNaBqC0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvNaBqC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBF6C4CEF7;
	Thu,  9 Apr 2026 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751423;
	bh=xfTIKtj5PwV74myDp2OytDSJiXzkqlmmQuhRTaEsOu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvNaBqC0APcc0tKfH69RdqAkFZFZBmiGyUnWAHpoCcPV6gs8Kp/jQHBVBJ/aLRpqM
	 GizjPlN3OFjgFi4ZkIx6GSdj+XASzOKkMLGu4bI34Ya8jgD3aAd+xQIy4NqR4kF6I/
	 /H9A6QCRVFGcLprEj/bdA3BNNPx+7h1WkcboP0culFUskstkrtkSIP0oycNrGx8Cus
	 tHAqeMI5uiJIkCMGnOnhiwkX5VW+pxacU7d508qBhBUFKgKxC8hEDyngwyiIM2tD9p
	 FrFs4eef89n/l5xFK3rz4ziuIBdqM58hxqaqTraz8GXJtH9R48ro/4qLZ8imO3GUAQ
	 +7Chh8RPlyRzQ==
Date: Thu, 9 Apr 2026 09:17:02 -0700
From: Kees Cook <kees@kernel.org>
To: Xu Laiguang <xulaiguang@lixiang.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, gustavoars@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64: syscall: use cntvct_el0 for kstack offset
 randomization
Message-ID: <202604090914.10F22B6@keescook>
References: <20260409095322.1774250-1-xulaiguang@lixiang.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409095322.1774250-1-xulaiguang@lixiang.com>

On Thu, Apr 09, 2026 at 09:53:22AM +0000, Xu Laiguang wrote:
> On PREEMPT_RT kernels, get_random_u16() can suffer significant lock
> contention in the syscall hot path.  The batched entropy layer uses
> local_lock, which on RT maps to a real spinlock.  When a batch refill
> is in progress, other tasks on the same CPU block on the lock.  Under
> heavy syscall load on a 24-core RT system, worst-case latencies of
> 16.65ms have been observed.
> 
>  contended   total wait     max wait     caller
>        307     86.18 ms     16.65 ms     get_random_u16+0x64
> 
> The kstack offset randomization only needs 6 bits of entropy (the
> value is masked by KSTACK_OFFSET_MAX to bits [9:4] on 64-bit).  This
> does not require cryptographic-strength randomness -- the goal is to
> make the kernel stack offset unpredictable enough to frustrate stack
> layout attacks.
> 
> Other architectures already use lightweight hardware counters for this
> purpose:
>   - x86:       rdtsc()              (arch/x86/include/asm/entry-common.h)
>   - powerpc:   mftb()               (arch/powerpc/kernel/syscall.c)
>   - loongarch: drdtime()            (arch/loongarch/kernel/syscall.c)
>   - s390:      get_tod_clock_fast()  (arch/s390/include/asm/entry-common.h)
> 
> Replace get_random_u16() with a bare read of cntvct_el0 (the ARM
> generic timer virtual count register).  The read is performed without
> ISB or arch_counter_enforce_ordering because kstack randomization does
> not require timing accuracy -- only unpredictability.
> 
> Signed-off-by: Xu Laiguang <xulaiguang@lixiang.com>

Everything here has been replaced recently. Can you check again with the
-next tree?

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-next/hardening

See commits:
	randomize_kstack: Maintain kstack_offset per task
	randomize_kstack: Unify random source across arches

-Kees

> ---
>  arch/arm64/kernel/syscall.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index c062badd1a56..c0ee9fa529ca 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -35,6 +35,21 @@ static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
>  	return syscall_fn(regs);
>  }
>  
> +/*
> + * Read the virtual counter without ISB or other ordering barriers.
> + * This is intentional: kstack randomization only needs unpredictability,
> + * not timing accuracy.  Speculative execution of the read, if it occurs,
> + * actually helps by making the precise value less predictable to an
> + * attacker.
> + */
> +static inline u64 kstack_entropy_cntvct(void)
> +{
> +	u64 cnt;
> +
> +	asm volatile("mrs %0, cntvct_el0" : "=r"(cnt));
> +	return cnt;
> +}
> +
>  static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  			   unsigned int sc_nr,
>  			   const syscall_fn_t syscall_table[])
> @@ -62,7 +77,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	 *
>  	 * The resulting 6 bits of entropy is seen in SP[9:4].
>  	 */
> -	choose_random_kstack_offset(get_random_u16());
> +	choose_random_kstack_offset(kstack_entropy_cntvct());
>  }
>  
>  static inline bool has_syscall_work(unsigned long flags)
> -- 
> 2.43.0
> 
> 声明：这封邮件只允许文件接收者阅读，有很高的机密性要求。禁止其他人使用、打开、复制或转发里面的任何内容。如果本邮件错误地发给了你，请联系邮件发出者并删除这个文件。机密及法律的特权并不因为误发邮件而放弃或丧失。任何提出的观点或意见只属于作者的个人见解，并不一定代表本公司。
> Disclaimer: This email is intended to be read only by the designated recipient of the document and has high confidentiality requirements. Anyone else is prohibited from using, opening, copying or forwarding any of the contents inside. If this email was sent to you by mistake, please contact the sender of the email and delete this file immediately. Confidentiality and legal privileges are not waived or lost by misdirected emails. Any views or opinions expressed in the email are those of the author and do not necessarily represent those of the Company.
> 

-- 
Kees Cook
