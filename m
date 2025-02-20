Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89732066C1
	for <linux-hardening@vger.kernel.org>; Thu, 20 Feb 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069061; cv=none; b=MKyY33duf4nrk73fOnDsAKSdpeid4U0dmTCL7VSP3FFrvAtybGs4H0PYMcUS734Xgj3QjU7PsjfK6BiFhJJOboj7jA+o7MZwp5JP2mnT0ocAMuOObpOhZ4edNI8Jc9A5sLwNEIRK5iP/Ocxm3dXEulKI7G/Ga4QvVOalu0x/96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069061; c=relaxed/simple;
	bh=42rqNDCaujYxpOveulSZOy3q1G2V7uMbO/rPRo+TUWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJhr+CehHUqradlc9r+m3M+qDWFS9i62XGZW+XV5oYgm8l/vpYLTmQeoTR+eFP9jB482ps7x4EPp0pTeOL9a4CSExgPPKwWg3fYtQpHV0EQ4S18GGGsjcCjcL7Jz3txcuKcw4ts2DTP4Slzbm0kVch1RTk85+ScNAkdWBUnfPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpDKQb5r; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpDKQb5r"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220ca204d04so17094325ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 20 Feb 2025 08:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740069059; x=1740673859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RunbDwqsCKiDMq6NQxy4XFRnim+xmAlewv0MU2PV7ik=;
        b=fpDKQb5rOspxpE1QRE4zK34Vp5J8rWmaTxq6wsQ7ADrvqxzqp7mTzjdDc5YIFdA1gk
         K0BKbF2KH3hDpl3SWzDPoEnKlgpqac+mEj0bebEWt1eNO3+MdWenaRCciQLH5omI3D0d
         nF48QDxhX86o7IOBhur2CrpsroKMSs/tqDWazxDzNFspk9rgm5vUGePSd7xEvBT73egg
         P9PuXKS9jUrpNaiyc/8NgJM/y8/Rm1mJqsZ38S4YZ2AHqP88/6KkkPmg+P5NU6+wS8zL
         oEd/dQaZ5fv78vG7d8pSnCCH+rKjNB6Y3hch8NWcxwa1aunkUYiGGaUVJWBFtzBK+KMk
         lAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069059; x=1740673859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RunbDwqsCKiDMq6NQxy4XFRnim+xmAlewv0MU2PV7ik=;
        b=wNPShRAGdVshMmSU/9OC1g2v8+Z+WEYtHZf+kZRgnaaBMDsDFuG647QVzTws++AQHQ
         6ZiO4R8JYlYLRbcGuXofyQrxHh2DOHcekwv28RWNLMCUy2U6ZME5qWbQtRdhiivqHynM
         SBWods8qWzfReRz/pzdJ4cLLB5HEeuuco4zL7m2uprYc5vihgxdD+0rEwUMj1iwLOCKj
         4FwrfaQdBhEZiOKxseNMivHqVRElVrcCcFiphVsM5GlnlyH0PrtUYgN48iRmtqV/aZj9
         f4rRqAYOaTh3fOIiUzcXZiX9jdrL2ocUK/qDdnojRC+E2z4bZnEF9HUu6TvSwQX0uCi0
         DgDg==
X-Forwarded-Encrypted: i=1; AJvYcCVs2SzZ5XuzSQkaO2d0FGsaNzfcWIClIXVyldg2bUD/bnn9Twqd6j5WHh089vCLwm1Vml+egd+oJ8fd0QVCcas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CbDIhUPJVMJPdhQJlk1skGqRVYuocYlUn2gUXr1RSnf4nz4p
	BTOjUI3KXUTYsV+7l7FFrzAJYaDf6hraSZiSuoaemeIkN+u/xcKVoYxe3hQHQob/i2utjApzMXb
	JTH7+VgVhBmS+/ZP2tDw80QnEQrZhrmEunKEL
X-Gm-Gg: ASbGncvNdlygQjhkXZvxjj9SE5yp/j6WW5v2SBogXFU1QYllZc0YDgroRjESLWVNd1+
	G/yvSU5N4j1LtLSHe8viAtyNCBSc7QM1hE3Tm058hwj50/BACfTcKM1iMtWCr8alIoZKKSNtCTz
	VABetWk6XbAItH54fN7xdaa0hMUjA=
X-Google-Smtp-Source: AGHT+IFdqO9ngHYhveH35oJHO22aeobAr6glftEnXejC12aebBifGJtpg6TkKA77hUr2iCeDWZSqoxHWRC4YUmQWiZk=
X-Received: by 2002:a17:90b:278b:b0:2fa:1a8a:cff8 with SMTP id
 98e67ed59e1d1-2fcb5aba7admr13293676a91.29.1740069058693; Thu, 20 Feb 2025
 08:30:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7bUC9QY815Cv6nb@xsang-OptiPlex-9020> <20250220155722.2Z2a-3z0@linutronix.de>
In-Reply-To: <20250220155722.2Z2a-3z0@linutronix.de>
From: Marco Elver <elver@google.com>
Date: Thu, 20 Feb 2025 17:30:22 +0100
X-Gm-Features: AWEUYZl9XyuxFIVLWSjhfqqO0OUA4wn0EYnMOUYAgeDjJV6JjoSIe-IH-I10jY8
Message-ID: <CANpmjNN9zpcPa4S+Zq+vJWJ3EcO0zCZJ=Z4FgNzDRXdi0YQA9g@mail.gmail.com>
Subject: Re: [linux-next:master] [x86] 66fbf67705: kernel-selftests.kvm.hardware_disable_test.fail
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Petr Pavlu <petr.pavlu@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Kees Cook <kees@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:57, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
[...]
> Now. Based on this:
> The RCU read section increased the runtime (on my hardware) for the test
> from 30 to 43 seconds which is roughly 43%.
> This is due to the lockdep annotation within rcu_read_lock() and
> unlock() which is not existing in preempt_disable(). After disabling
> UBSAN + KASAN  the lockdep annotation has no effect. My guess that
> UBSAN/ KASAN is in charge of countless backtraces while enabled. Those
> backtraces seem to be limited to the core kernel.
>
> How much do we care here? Is this something that makes UBSAN + KASAN
> folks uncomfortable? Or is lockdep slowing things down anyway?

Does this series from Waiman help?
https://lore.kernel.org/all/20250213200228.1993588-4-longman@redhat.com/

> If so, we could either move the RCU section down (as in #5) so it is not
> used that often or go the other direction and move it up. I got this:
> | ~# time ./hardware_disable_test
> | Random seed: 0x6b8b4567
> |
> | real    0m32.618s
> | user    0m0.537s
> | sys     0m13.942s
>
> which is almost the pre-level with the hunk below after figuring out
> that most callers are from arch_stack_walk().
>
> diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
> index 7cede4dc21f0..f20e3613942f 100644
> --- a/arch/x86/include/asm/unwind.h
> +++ b/arch/x86/include/asm/unwind.h
> @@ -42,6 +42,7 @@ struct unwind_state {
>  void __unwind_start(struct unwind_state *state, struct task_struct *task,
>                     struct pt_regs *regs, unsigned long *first_frame);
>  bool unwind_next_frame(struct unwind_state *state);
> +bool unwind_next_frame_unlocked(struct unwind_state *state);
>  unsigned long unwind_get_return_address(struct unwind_state *state);
>  unsigned long *unwind_get_return_address_ptr(struct unwind_state *state);
>
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index ee117fcf46ed..4df346b11f1e 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -21,8 +21,9 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>         if (regs && !consume_entry(cookie, regs->ip))
>                 return;
>
> +       guard(rcu)();
>         for (unwind_start(&state, task, regs, NULL); !unwind_done(&state);
> -            unwind_next_frame(&state)) {
> +            unwind_next_frame_unlocked(&state)) {
>                 addr = unwind_get_return_address(&state);
>                 if (!addr || !consume_entry(cookie, addr))
>                         break;
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 977ee75e047c..402779b3e90a 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -465,7 +465,7 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
>         return false;
>  }
>
> -bool unwind_next_frame(struct unwind_state *state)
> +bool unwind_next_frame_unlocked(struct unwind_state *state)
>  {
>         unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
>         enum stack_type prev_type = state->stack_info.type;
> @@ -475,9 +475,6 @@ bool unwind_next_frame(struct unwind_state *state)
>         if (unwind_done(state))
>                 return false;
>
> -       /* Don't let modules unload while we're reading their ORC data. */
> -       guard(rcu)();
> -
>         /* End-of-stack check for user tasks: */
>         if (state->regs && user_mode(state->regs))
>                 goto the_end;
> @@ -678,6 +675,13 @@ bool unwind_next_frame(struct unwind_state *state)
>         state->stack_info.type = STACK_TYPE_UNKNOWN;
>         return false;
>  }
> +
> +bool unwind_next_frame(struct unwind_state *state)
> +{
> +       /* Don't let modules unload while we're reading their ORC data. */
> +       guard(rcu)();
> +       return unwind_next_frame_unlocked(state);
> +}
>  EXPORT_SYMBOL_GPL(unwind_next_frame);
>
>  void __unwind_start(struct unwind_state *state, struct task_struct *task,
>
> Sebastian
