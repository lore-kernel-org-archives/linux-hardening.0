Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055E3CCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 19:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345279AbiFMTER (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349092AbiFMTD6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 15:03:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FBF61289
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:51:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s37so3561401pfg.11
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JAAlPpOYN6ADV2jnchSYebwoUpq3tYUIKXz39RbwrMU=;
        b=lfaq4tPccSJSYwyQ7SL2tFtWynotKsguO5PVWX2+yByLSNn+IKOotOEGSH7s6jJzyH
         NYFLLTLNdx5Ht/WcwtqOn29bDlc3UtgtZZyXOCYuGePXPV228EgBZW2FYjLVhXT+43Pp
         L+YIsshJkIY4ilkzXVJbJwLAcpVdk7lVIMPds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAAlPpOYN6ADV2jnchSYebwoUpq3tYUIKXz39RbwrMU=;
        b=LdxTzGHHScNaJiUtxjn3BY5ykk7SuUUsMd9yoAj9mdEoRevTfoh1nIDU42Mffu5H+G
         xgU3VtYRZwsECTvrRSu7bzrW9zL7CbgjoeFhFDML9IE886K/N9RkMrML+OGUX33PpCFy
         qz0p9JcxgLBxHQ0rdjkFw98O8h/AhfAzAhWR4MVSbj6dpdr0/ZerZF76hnLwCnGK+waR
         THXJVfPhwCo45e/reDDI0vHPbEo0OBTrD4zrggDaoYdTCzgO4czSvibz8HsoDaexRPju
         +rweaXeg6BwsK4FLBbQrP5orsgTO/pDtcwUrXug1u2WujQiAjU6hiSjO7E0NDvMMBzRJ
         xN5g==
X-Gm-Message-State: AOAM533LfLSWoGAW6HG6I6Z4nC8GPeQm4NhfzH+AYsAiPYjGMWFuNGjK
        wwnruY44bZObMnx4P7K7seydAw==
X-Google-Smtp-Source: ABdhPJzQVFjnCjeG5FkXFmz3xq03n2RKh2txh6lYjry6y7RDwNDnaWcRt0HCDw8qnuuIntIfP6EcUQ==
X-Received: by 2002:a63:2a16:0:b0:3fe:192a:2d3 with SMTP id q22-20020a632a16000000b003fe192a02d3mr441379pgq.39.1655139072383;
        Mon, 13 Jun 2022 09:51:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u67-20020a627946000000b0050dc76281f8sm5592543pfc.210.2022.06.13.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:51:11 -0700 (PDT)
Date:   Mon, 13 Jun 2022 09:51:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 25/26] arm64: mm: add support for WXN memory
 translation attribute
Message-ID: <202206130940.2CFAF97@keescook>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-26-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144550.3760857-26-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 13, 2022 at 04:45:49PM +0200, Ard Biesheuvel wrote:
> The AArch64 virtual memory system supports a global WXN control, which
> can be enabled to make all writable mappings implicitly no-exec. This is
> a useful hardening feature, as it prevents mistakes in managing page
> table permissions from being exploited to attack the system.
> 
> When enabled at EL1, the restrictions apply to both EL1 and EL0. EL1 is
> completely under our control, and has been cleaned up to allow WXN to be
> enabled from boot onwards. EL0 is not under our control, but given that
> widely deployed security features such as selinux or PaX already limit
> the ability of user space to create mappings that are writable and
> executable at the same time, the impact of enabling this for EL0 is
> expected to be limited. (For this reason, common user space libraries
> that have a legitimate need for manipulating executable code already
> carry fallbacks such as [0].)
> 
> If enabled at compile time, the feature can still be disabled at boot if
> needed, by passing arm64.nowxn on the kernel command line.
> 
> [0] https://github.com/libffi/libffi/blob/master/src/closures.c#L440
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/Kconfig                   | 11 ++++++
>  arch/arm64/include/asm/cpufeature.h  |  8 +++++
>  arch/arm64/include/asm/mman.h        | 36 ++++++++++++++++++++
>  arch/arm64/include/asm/mmu_context.h | 30 +++++++++++++++-
>  arch/arm64/kernel/head.S             | 28 ++++++++++++++-
>  arch/arm64/kernel/idreg-override.c   | 16 +++++++++
>  arch/arm64/mm/proc.S                 |  6 ++++
>  7 files changed, 133 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1652a9800ebe..d262d5ab4316 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1422,6 +1422,17 @@ config RODATA_FULL_DEFAULT_ENABLED
>  	  This requires the linear region to be mapped down to pages,
>  	  which may adversely affect performance in some cases.
>  
> +config ARM64_WXN
> +	bool "Enable WXN attribute so all writable mappings are non-exec"
> +	help
> +	  Set the WXN bit in the SCTLR system register so that all writable
> +	  mappings are treated as if the PXN/UXN bit is set as well.
> +	  If this is set to Y, it can still be disabled at runtime by
> +	  passing 'arm64.nowxn' on the kernel command line.
> +
> +	  This should only be set if no software needs to be supported that
> +	  relies on being able to execute from writable mappings.

Should this instead just be a "default value of arm64.xwn" config? It
seems like it should be possible to just drop all the #ifdefs below, as
XWN is arguably the default state we would want systems to move to.

> +
>  config ARM64_SW_TTBR0_PAN
>  	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
>  	help
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 14a8f3d93add..fc364c4d31e2 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -911,10 +911,18 @@ extern struct arm64_ftr_override id_aa64mmfr1_override;
>  extern struct arm64_ftr_override id_aa64pfr1_override;
>  extern struct arm64_ftr_override id_aa64isar1_override;
>  extern struct arm64_ftr_override id_aa64isar2_override;
> +extern struct arm64_ftr_override sctlr_override;
>  
>  u32 get_kvm_ipa_limit(void);
>  void dump_cpu_features(void);
>  
> +static inline bool arm64_wxn_enabled(void)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64_WXN))
> +		return false;
> +	return (sctlr_override.val & sctlr_override.mask & 0xf) == 0;
> +}
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 5966ee4a6154..6d4940342ba7 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -35,11 +35,40 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>  }
>  #define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
>  
> +static inline bool arm64_check_wx_prot(unsigned long prot,
> +				       struct task_struct *tsk)
> +{
> +	/*
> +	 * When we are running with SCTLR_ELx.WXN==1, writable mappings are
> +	 * implicitly non-executable. This means we should reject such mappings
> +	 * when user space attempts to create them using mmap() or mprotect().

If this series is respun, perhaps add to this comment a little to indicate
that this is basically a hint to userspace, and not an attempt to actually
provide a general W+X mapping protection:

	* Note that this is effectively just a hint (for things like
	* libffi noted below), as solving this for all mapping combinations
	* is a larger endeavor. (e.g. userspace setting an executable mapping
	* writable, changing it, and then making it read-only again.)

> +	 */
> +	if (arm64_wxn_enabled() &&
> +	    ((prot & (PROT_WRITE | PROT_EXEC)) == (PROT_WRITE | PROT_EXEC))) {
> +		/*
> +		 * User space libraries such as libffi carry elaborate
> +		 * heuristics to decide whether it is worth it to even attempt
> +		 * to create writable executable mappings, as PaX or selinux
> +		 * enabled systems will outright reject it. They will usually
> +		 * fall back to something else (e.g., two separate shared
> +		 * mmap()s of a temporary file) on failure.
> +		 */
> +		pr_info_ratelimited(
> +			"process %s (%d) attempted to create PROT_WRITE+PROT_EXEC mapping\n",
> +			tsk->comm, tsk->pid);
> +		return false;
> +	}
> +	return true;
> +}

But regardless, with or without the changes above:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
