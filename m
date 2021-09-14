Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD77C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF5460F11
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhINTjA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhINTjA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:39:00 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7EC061574
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:37:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s11so193897pgr.11
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EaW35x72GNh4jI/yVERXrJlTV6ZAnW2fqMDnsImY8/4=;
        b=OSKuSjLocjuewfPQ4w7rEtlqeziC/WnWO53nguIxJqu1LMfY++zpt42N5kzEwqMQsS
         SUKxoGOw3JOksisigkLJsuZ/pijyDvLIsKmgx10nxH25CnimVOV5u2lfmCRzhYs+qUzP
         IzNKTn3cXL7JiH5O19KrS9VUnk4UQD65XsaEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EaW35x72GNh4jI/yVERXrJlTV6ZAnW2fqMDnsImY8/4=;
        b=MLjL4TeGXAwYEveGNk5x0uRfculQY0dy4DYpIQTyM1Mrv0eGMComL2KM2K2nF+BCxZ
         +NOIawX+czn3Ok10Dhj5UjuodUCvswo39319tZqJZL1kA6lIyyWjffikDOcYpYK71E6S
         Ilw9LAAbtEiwb9C2neF8fJB9pj5tJOqauPrTftQuV6cbf0TADORuSP1v48k05Ytmmp24
         kwQ7VGsPmCGgUiVTaQC3jC2s1vQUyaYNWV1/dRgCOhr2dk6lTq0urX7yXU1/4Dgel/Sq
         pjy9suxRff3TqLExynxFd1dtZRK4AeHUi//Oo/Y+5ygt1ucRdR+TK3x2899W6N3JZYD2
         4EAw==
X-Gm-Message-State: AOAM532PmWhiUfxgF/WqHqovUlPRmGA1WM9EcoCZ3Pt/A/yS2A8bQN3s
        CTXT1Uu43/YMOjd26tzD3ycaurDclJM25w==
X-Google-Smtp-Source: ABdhPJwOXJ3KD7uAr31NtTgsl8y72c8faND5klawk2gESRf4CBhKImOimYYVgdlcJKHbsaB7n5YnsA==
X-Received: by 2002:a62:4dc5:0:b0:438:8133:fcef with SMTP id a188-20020a624dc5000000b004388133fcefmr6457410pfb.44.1631648261915;
        Tue, 14 Sep 2021 12:37:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p30sm11328125pfh.116.2021.09.14.12.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:37:41 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:37:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 10/16] x86/extable: Mark handlers __cficanonical
Message-ID: <202109141235.BE65491A4@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-11-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:39PM -0700, Sami Tolvanen wrote:
> Exception tables are populated in assembly code, but the handlers are
> called in fixup_exception, which trips indirect call checking with
> CONFIG_CFI_CLANG. Mark the handlers __cficanonical to allow addresses
> taken in assembly to pass CFI checking.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/mm/extable.c | 64 ++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index e1664e9f969c..d16912dcbb4e 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -24,16 +24,18 @@ ex_fixup_handler(const struct exception_table_entry *x)
>  	return (ex_handler_t)((unsigned long)&x->handler + x->handler);
>  }
>  
> -__visible bool ex_handler_default(const struct exception_table_entry *fixup,
> -				  struct pt_regs *regs, int trapnr,
> -				  unsigned long error_code,
> -				  unsigned long fault_addr)
> +__visible __cficanonical
> +bool ex_handler_default(const struct exception_table_entry *fixup,
> +			struct pt_regs *regs, int trapnr,
> +			unsigned long error_code,
> +			unsigned long fault_addr)
>  {
>  	regs->ip = ex_fixup_addr(fixup);
>  	return true;
>  }
>  EXPORT_SYMBOL(ex_handler_default);
>  
> +__visible __cficanonical
>  __visible bool ex_handler_fault(const struct exception_table_entry *fixup,

Double __visible here, but with that fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

I would note that given Linus's recent comments on attribute locations,
it does seem that __cficanonical is more a function behavior attribute
than a storage class... I'm not really sure:
https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com

-Kees

>  				struct pt_regs *regs, int trapnr,
>  				unsigned long error_code,
> @@ -55,10 +57,11 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
>   * of vulnerability by restoring from the initial state (essentially, zeroing
>   * out all the FPU registers) if we can't restore from the task's FPU state.
>   */
> -__visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
> -				    struct pt_regs *regs, int trapnr,
> -				    unsigned long error_code,
> -				    unsigned long fault_addr)
> +__visible __cficanonical
> +bool ex_handler_fprestore(const struct exception_table_entry *fixup,
> +			  struct pt_regs *regs, int trapnr,
> +			  unsigned long error_code,
> +			  unsigned long fault_addr)
>  {
>  	regs->ip = ex_fixup_addr(fixup);
>  
> @@ -70,10 +73,11 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
>  }
>  EXPORT_SYMBOL_GPL(ex_handler_fprestore);
>  
> -__visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
> -				  struct pt_regs *regs, int trapnr,
> -				  unsigned long error_code,
> -				  unsigned long fault_addr)
> +__visible __cficanonical
> +bool ex_handler_uaccess(const struct exception_table_entry *fixup,
> +			struct pt_regs *regs, int trapnr,
> +			unsigned long error_code,
> +			unsigned long fault_addr)
>  {
>  	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
>  	regs->ip = ex_fixup_addr(fixup);
> @@ -81,10 +85,11 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
>  }
>  EXPORT_SYMBOL(ex_handler_uaccess);
>  
> -__visible bool ex_handler_copy(const struct exception_table_entry *fixup,
> -			       struct pt_regs *regs, int trapnr,
> -			       unsigned long error_code,
> -			       unsigned long fault_addr)
> +__visible __cficanonical
> +bool ex_handler_copy(const struct exception_table_entry *fixup,
> +		     struct pt_regs *regs, int trapnr,
> +		     unsigned long error_code,
> +		     unsigned long fault_addr)
>  {
>  	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
>  	regs->ip = ex_fixup_addr(fixup);
> @@ -93,10 +98,11 @@ __visible bool ex_handler_copy(const struct exception_table_entry *fixup,
>  }
>  EXPORT_SYMBOL(ex_handler_copy);
>  
> -__visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
> -				       struct pt_regs *regs, int trapnr,
> -				       unsigned long error_code,
> -				       unsigned long fault_addr)
> +__visible __cficanonical
> +bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
> +			     struct pt_regs *regs, int trapnr,
> +			     unsigned long error_code,
> +			     unsigned long fault_addr)
>  {
>  	if (pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
>  			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
> @@ -110,10 +116,11 @@ __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup
>  }
>  EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
>  
> -__visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
> -				       struct pt_regs *regs, int trapnr,
> -				       unsigned long error_code,
> -				       unsigned long fault_addr)
> +__visible __cficanonical
> +bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
> +			     struct pt_regs *regs, int trapnr,
> +			     unsigned long error_code,
> +			     unsigned long fault_addr)
>  {
>  	if (pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
>  			 (unsigned int)regs->cx, (unsigned int)regs->dx,
> @@ -126,10 +133,11 @@ __visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup
>  }
>  EXPORT_SYMBOL(ex_handler_wrmsr_unsafe);
>  
> -__visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
> -				   struct pt_regs *regs, int trapnr,
> -				   unsigned long error_code,
> -				   unsigned long fault_addr)
> +__visible __cficanonical
> +bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
> +			 struct pt_regs *regs, int trapnr,
> +			 unsigned long error_code,
> +			 unsigned long fault_addr)
>  {
>  	if (static_cpu_has(X86_BUG_NULL_SEG))
>  		asm volatile ("mov %0, %%fs" : : "rm" (__USER_DS));
> -- 
> 2.33.0.309.g3052b89438-goog
> 

-- 
Kees Cook
