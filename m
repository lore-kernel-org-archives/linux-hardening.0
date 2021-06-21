Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D463DC48BDF
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Jun 2021 03:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A745261164
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Jun 2021 03:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFUDQC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 20 Jun 2021 23:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhFUDQB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 20 Jun 2021 23:16:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32628C061574
        for <linux-hardening@vger.kernel.org>; Sun, 20 Jun 2021 20:13:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a127so2000175pfa.10
        for <linux-hardening@vger.kernel.org>; Sun, 20 Jun 2021 20:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Wze939aefA5PRCWTTx2ECjNbC/4jKslYlazXWOmibac=;
        b=Ly8+LdS+crvfc9rYevIpqHS7L6S3lp2Onsjz7GI/PWw+JW709QxZQR4VKy4qkiOfdG
         DFXh7DZhR3z0DFb/VgTQZnILlEgD/Dg5mO0VAPmBxoRU88VSlTqcoBvKh0r22P1K6IcT
         gaga6B1V6Dx5pi5IHaQBheF4NxX1K7JGkfluU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Wze939aefA5PRCWTTx2ECjNbC/4jKslYlazXWOmibac=;
        b=at7shyQdTU6Q14MZFaVkPKwUfDIXkC1xxd/wOwB3sCJG80RCR1cq1ZvlSpn5CwRSCA
         FzkPJANDP4jBadx8qzZax2y3I+YVaXlZmPGVqjc3EfH1MaBcIFADPMEDV+VXT82c9Kx7
         hzb3z7KemGhhGMn7ZJSahk1w3Akp+Go/qVLvkv9bJKPIyKkN0+xSf2J3wXQ7YC2SF8ge
         WEWSOtpEKbsKScNLlcEvw2Ov6P3j4M9pa3gvrqQM3gj5cyKNvwFdqEuMSihfqNFsLhVh
         Yy7EqrEQLQflQgybZJhe+yxQxbKjjxAUTAHEpVr7xTkDkd5a91n9AJ4i8qfAZ7ycVKqh
         5dMA==
X-Gm-Message-State: AOAM530M7x7m6z9jZkhyu0SyvZD/bnBUmiOWNMrG9dsmxVkX4eO1dvU6
        zDO337rlLF9alqqm9LiDU0OadQ==
X-Google-Smtp-Source: ABdhPJyBafYE/Wt6CLuVq2VJ2d4ASgZF4B3KRbYeIRoyXptAUPSOukQDYWkbWRN2jHyauLWMdL2+Hw==
X-Received: by 2002:a62:53c1:0:b029:2ef:25e8:d9e5 with SMTP id h184-20020a6253c10000b02902ef25e8d9e5mr17338587pfb.74.1624245226719;
        Sun, 20 Jun 2021 20:13:46 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id g8sm14651950pja.14.2021.06.20.20.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 20:13:46 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     "Christopher M. Riedl" <cmr@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
Subject: Re: [RESEND PATCH v4 05/11] powerpc/64s: Add ability to skip SLB
 preload
In-Reply-To: <20210506043452.9674-6-cmr@linux.ibm.com>
References: <20210506043452.9674-1-cmr@linux.ibm.com>
 <20210506043452.9674-6-cmr@linux.ibm.com>
Date:   Mon, 21 Jun 2021 13:13:42 +1000
Message-ID: <87sg1bj4ex.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

"Christopher M. Riedl" <cmr@linux.ibm.com> writes:

> Switching to a different mm with Hash translation causes SLB entries to
> be preloaded from the current thread_info. This reduces SLB faults, for
> example when threads share a common mm but operate on different address
> ranges.
>
> Preloading entries from the thread_info struct may not always be
> appropriate - such as when switching to a temporary mm. Introduce a new
> boolean in mm_context_t to skip the SLB preload entirely. Also move the
> SLB preload code into a separate function since switch_slb() is already
> quite long. The default behavior (preloading SLB entries from the
> current thread_info struct) remains unchanged.
>
> Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>
>
> ---
>
> v4:  * New to series.
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h |  3 ++
>  arch/powerpc/include/asm/mmu_context.h   | 13 ++++++
>  arch/powerpc/mm/book3s64/mmu_context.c   |  2 +
>  arch/powerpc/mm/book3s64/slb.c           | 56 ++++++++++++++----------
>  4 files changed, 50 insertions(+), 24 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index eace8c3f7b0a1..b23a9dcdee5af 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -130,6 +130,9 @@ typedef struct {
>  	u32 pkey_allocation_map;
>  	s16 execute_only_pkey; /* key holding execute-only protection */
>  #endif
> +
> +	/* Do not preload SLB entries from thread_info during switch_slb() */
> +	bool skip_slb_preload;
>  } mm_context_t;
>  
>  static inline u16 mm_ctx_user_psize(mm_context_t *ctx)
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 4bc45d3ed8b0e..264787e90b1a1 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -298,6 +298,19 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PPC_BOOK3S_64
> +
> +static inline void skip_slb_preload_mm(struct mm_struct *mm)
> +{
> +	mm->context.skip_slb_preload = true;
> +}
> +
> +#else
> +
> +static inline void skip_slb_preload_mm(struct mm_struct *mm) {}
> +
> +#endif /* CONFIG_PPC_BOOK3S_64 */
> +
>  #include <asm-generic/mmu_context.h>
>  
>  #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
> index c10fc8a72fb37..3479910264c59 100644
> --- a/arch/powerpc/mm/book3s64/mmu_context.c
> +++ b/arch/powerpc/mm/book3s64/mmu_context.c
> @@ -202,6 +202,8 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  	atomic_set(&mm->context.active_cpus, 0);
>  	atomic_set(&mm->context.copros, 0);
>  
> +	mm->context.skip_slb_preload = false;
> +
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
> index c91bd85eb90e3..da0836cb855af 100644
> --- a/arch/powerpc/mm/book3s64/slb.c
> +++ b/arch/powerpc/mm/book3s64/slb.c
> @@ -441,10 +441,39 @@ static void slb_cache_slbie_user(unsigned int index)
>  	asm volatile("slbie %0" : : "r" (slbie_data));
>  }
>  
> +static void preload_slb_entries(struct task_struct *tsk, struct mm_struct *mm)
Should this be explicitly inline or even __always_inline? I'm thinking
switch_slb is probably a fairly hot path on hash?

> +{
> +	struct thread_info *ti = task_thread_info(tsk);
> +	unsigned char i;
> +
> +	/*
> +	 * We gradually age out SLBs after a number of context switches to
> +	 * reduce reload overhead of unused entries (like we do with FP/VEC
> +	 * reload). Each time we wrap 256 switches, take an entry out of the
> +	 * SLB preload cache.
> +	 */
> +	tsk->thread.load_slb++;
> +	if (!tsk->thread.load_slb) {
> +		unsigned long pc = KSTK_EIP(tsk);
> +
> +		preload_age(ti);
> +		preload_add(ti, pc);
> +	}
> +
> +	for (i = 0; i < ti->slb_preload_nr; i++) {
> +		unsigned char idx;
> +		unsigned long ea;
> +
> +		idx = (ti->slb_preload_tail + i) % SLB_PRELOAD_NR;
> +		ea = (unsigned long)ti->slb_preload_esid[idx] << SID_SHIFT;
> +
> +		slb_allocate_user(mm, ea);
> +	}
> +}
> +
>  /* Flush all user entries from the segment table of the current processor. */
>  void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  {
> -	struct thread_info *ti = task_thread_info(tsk);
>  	unsigned char i;
>  
>  	/*
> @@ -502,29 +531,8 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  
>  	copy_mm_to_paca(mm);
>  
> -	/*
> -	 * We gradually age out SLBs after a number of context switches to
> -	 * reduce reload overhead of unused entries (like we do with FP/VEC
> -	 * reload). Each time we wrap 256 switches, take an entry out of the
> -	 * SLB preload cache.
> -	 */
> -	tsk->thread.load_slb++;
> -	if (!tsk->thread.load_slb) {
> -		unsigned long pc = KSTK_EIP(tsk);
> -
> -		preload_age(ti);
> -		preload_add(ti, pc);
> -	}
> -
> -	for (i = 0; i < ti->slb_preload_nr; i++) {
> -		unsigned char idx;
> -		unsigned long ea;
> -
> -		idx = (ti->slb_preload_tail + i) % SLB_PRELOAD_NR;
> -		ea = (unsigned long)ti->slb_preload_esid[idx] << SID_SHIFT;
> -
> -		slb_allocate_user(mm, ea);
> -	}
> +	if (!mm->context.skip_slb_preload)
> +		preload_slb_entries(tsk, mm);

Should this be wrapped in likely()?

>  
>  	/*
>  	 * Synchronize slbmte preloads with possible subsequent user memory

Right below this comment is the isync. It seems to be specifically
concerned with synchronising preloaded slbs. Do you need it if you are
skipping SLB preloads?

It's probably not a big deal to have an extra isync in the fairly rare
path when we're skipping preloads, but I thought I'd check.

Kind regards,
Daniel

> -- 
> 2.26.1
