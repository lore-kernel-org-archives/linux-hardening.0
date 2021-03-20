Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B3C433DB
	for <linux-hardening@archiver.kernel.org>; Sat, 20 Mar 2021 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6879E61978
	for <linux-hardening@archiver.kernel.org>; Sat, 20 Mar 2021 11:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCTL6p (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhCTL6Z (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 20 Mar 2021 07:58:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3FAC061762;
        Sat, 20 Mar 2021 04:58:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so13849782eds.7;
        Sat, 20 Mar 2021 04:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q1S6sOzSSmWv0cJIdKqH5aeKc+ejDOx1KDCFb2YbT3o=;
        b=qpR1PFuQAsHD9BxFuRDr2UgI0M5ZKr1wg73JNKyVGRXQp2STpCUHbOFNXVKc3pYUeU
         BxVh59NlVsKCuKzhWO++s1zTkKdomHSNUUlCTX2S6UNS+I4zg9FgCbRBjeDon1CzZMNK
         ur3VHRNpkiiDHnKnp+3igIpPWc+bJCJEMLRPquJjXjV/NVB5kRpDRjHyVgxKyBNVkxaM
         szDTmEKbH2A2igQ48viQewT3/nFUv2C46SmRvV+HtgcKhuQGm//YLfEhAZGzUWI7sXJu
         XA01inHcYSFdTpjw32pVWcVLYJ6/kHa+a5sLi2kWXCDv4RyMLF/88AOxAZK42GpMgrIp
         gOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Q1S6sOzSSmWv0cJIdKqH5aeKc+ejDOx1KDCFb2YbT3o=;
        b=VRGo9m9GoknL2eWj/t9g4Vy07+j9/P5u1au5WzFlpFt+afws81hwJJSwG4BPkYEEx1
         NWIm2lNP3cCSEl9CNm5FJhJtm45yhgfMp2MSwu2/Pmxp5ah6CFX1udJcgvALzMDw1UVR
         JmeRiOXVtE0JcD0PrDoiMLsiEvdzPhkt3r6B97cUoM7iwwBMftcxVm/wKvLeUIv/01xt
         Dbv5rDhE9j0hcZNrv2Oignf0miR+1wGAIvnWFvg0q/oqklCMmww3YXqQrNtml18trE8Q
         PRK2oyZidhnlJon/HEYEsi09fcSqV37IKYbtOwFL5LYkOmoFNderyKvOfzVmmUdL2RiI
         bJpA==
X-Gm-Message-State: AOAM531rjgiCGdQO2SvosMBMa62DkFH1YfmElhu5F2Ej7QGCGTspwltx
        D4oeivT1m+Znzlr3Z1qEt5c=
X-Google-Smtp-Source: ABdhPJz01rctCHm86yiIpmHhRp51yZPtxnmqPKRg7nHGuJhzGfxbKyzoIQQxZVmBUirAIENLH5CbDA==
X-Received: by 2002:a05:6402:d4:: with SMTP id i20mr15225084edu.147.1616241503810;
        Sat, 20 Mar 2021 04:58:23 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w18sm5273350ejn.23.2021.03.20.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 04:58:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 20 Mar 2021 12:58:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 4/6] x86/entry: Enable random_kstack_offset support
Message-ID: <20210320115820.GA4151166@gmail.com>
References: <20210319212835.3928492-1-keescook@chromium.org>
 <20210319212835.3928492-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319212835.3928492-5-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> Allow for a randomized stack offset on a per-syscall basis, with roughly
> 5-6 bits of entropy, depending on compiler and word size. Since the
> method of offsetting uses macros, this cannot live in the common entry
> code (the stack offset needs to be retained for the life of the syscall,
> which means it needs to happen at the actual entry point).

>  __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>  {
> +	add_random_kstack_offset();
>  	nr = syscall_enter_from_user_mode(regs, nr);

> @@ -83,6 +84,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
>  {
>  	unsigned int nr = syscall_32_enter(regs);
>  
> +	add_random_kstack_offset();

>  	unsigned int nr = syscall_32_enter(regs);
>  	int res;
>  
> +	add_random_kstack_offset();

> @@ -70,6 +71,13 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  	 */
>  	current_thread_info()->status &= ~(TS_COMPAT | TS_I386_REGS_POKED);
>  #endif
> +
> +	/*
> +	 * x86_64 stack alignment means 3 bits are ignored, so keep
> +	 * the top 5 bits. x86_32 needs only 2 bits of alignment, so
> +	 * the top 6 bits will be used.
> +	 */
> +	choose_random_kstack_offset(rdtsc() & 0xFF);
>  }

1)

Wondering why the calculation of the kstack offset (which happens in 
every syscall) is separated from the entry-time logic and happens 
during return to user-space?

The two methods:

+#define add_random_kstack_offset() do {                                        \
+       if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
+                               &randomize_kstack_offset)) {            \
+               u32 offset = this_cpu_read(kstack_offset);              \
+               u8 *ptr = __builtin_alloca(offset & 0x3FF);             \
+               asm volatile("" : "=m"(*ptr) :: "memory");              \
+       }                                                               \
+} while (0)
+
+#define choose_random_kstack_offset(rand) do {                         \
+       if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
+                               &randomize_kstack_offset)) {            \
+               u32 offset = this_cpu_read(kstack_offset);              \
+               offset ^= (rand);                                       \
+               this_cpu_write(kstack_offset, offset);                  \
+       }                                                               \
+} while (0)

choose_random_kstack_offset() basically calculates the offset and 
stores it in a percpu variable (mixing it with the previous offset 
value), add_random_kstack_offset() uses it in an alloca() dynamic 
stack allocation.

Wouldn't it be (slightly) lower combined overhead to just do it in a 
single step? There would be duplication along the 3 syscall entry 
points, but this should be marginal as this looks small, and the entry 
points would probably be cache-hot.

2)

Another detail I noticed: add_random_kstack_offset() limits the offset 
to 0x3ff, or 1k - 10 bits.

But the RDTSC mask is 0xff, 8 bits:

+       /*
+        * x86_64 stack alignment means 3 bits are ignored, so keep
+        * the top 5 bits. x86_32 needs only 2 bits of alignment, so
+        * the top 6 bits will be used.
+        */
+       choose_random_kstack_offset(rdtsc() & 0xFF);

alloca() itself works in byte units and will round the allocation to 8 
bytes on x86-64, to 4 bytes on x86-32, this is what the 'ignored bits' 
reference in the comment is to, right?

Why is there a 0x3ff mask for the alloca() call and a 0xff mask to the 
RDTSC randomizing value? Shouldn't the two be synced up? Or was the 
intention to shift the RDTSC value to the left by 3 bits?

3)

Finally, kstack_offset is a percpu variable:

  #ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
  ...
  DEFINE_PER_CPU(u32, kstack_offset);

This is inherited across tasks on scheduling, and new syscalls will 
mix in new RDTSC values to continue to randomize the offset.

Wouldn't it make sense to further mix values into this across context 
switching boundaries? A really inexpensive way would be to take the 
kernel stack value and mix it into the offset, and maybe even the 
randomized t->stack_canary value?

This would further isolate the syscall kernel stack offsets of 
separate execution contexts from each other, should an attacker find a 
way to estimate or influence likely RDTSC values.

Thanks,

	Ingo
