Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129BEC4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 20:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiAYUtA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 15:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiAYUso (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 15:48:44 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0FEC06173B
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 12:48:43 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z14so17063381ljc.13
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 12:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/K3eCHzr8SuLwQ7uwDyAB0IWI1YqeJ8BNzbE7dJqfE=;
        b=KITFhU7y80IhN0k9QSPxgc3sIYSnLfoNVY1hTsyrZGrqFewnwQjqScSitcb29FEbXo
         bpEtYxKyc4OFdT07OtlJ7uxpyQJzdbMOEiET9L3iXkawE/VKcGn9iCJzwW9rB+hDVsJY
         UgGIEk2sWT0W2xCTT7wXGYbREsMxmPdTbkPDGAc3l10UjhSJX1H8Axnf6eUgkUC7KyBX
         o8zIp0q3liZcTCNiXli+bd39UWHSKymbsQdtQItLvPFYJ85DmLPulWmKqiL3oLsmqzq7
         6zQCtcM4P0dfldAvIhqgpELWnT/pssF/NGJo2hi7mLJ4YDKaHTZJzeCJyJHIBwditz7L
         dHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/K3eCHzr8SuLwQ7uwDyAB0IWI1YqeJ8BNzbE7dJqfE=;
        b=RjsL10hZuZe90Rz5v/aH193oqVv/eWJZ3EtFcwqZDOtFaMuVt7pBMjb4IZJ2PQsEQm
         fE6DAsSbM/nZ5MuZIDzG7UgKmYUwcrt4kgsdrnuWcXFOLS4gwHlrFowupW5G1fsO2S58
         uc031ZZjimgdGYZeTVWQysNLLPYkAxWWn1AzXdUdfK4A0hHbV0S/caknxRhYvGqSUxSa
         52s2G8WPTLVjDBk1tudWQ7XH/qsbRFOXleortwqmpUXFkaE3On05RTvQNOHs0jP/m490
         Dag4Gc9tFDNKxl0OdWY3sXWhcavXnyR+2e3d502EsCy3DRfcl7ObCIU0MBarZWtOtGTD
         ONbA==
X-Gm-Message-State: AOAM530f05ITVULkiKqWG2A/8vHFR6YpVF0oHQt37Bvw2x/AsptzRTun
        XtaIixPZPU+pykbZV11LEQCG4X2aYQlswSqAvk+pQw==
X-Google-Smtp-Source: ABdhPJxJCK62//r1golVsux80RcF0IEtSInJOvm5qfONTIid/D+H6p74ze0yoiDuX0EuKqep/kOYfnv1cBMoDOaclxw=
X-Received: by 2002:a2e:a5c9:: with SMTP id n9mr16114020ljp.220.1643143721891;
 Tue, 25 Jan 2022 12:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20220125091453.1475246-1-ardb@kernel.org> <20220125091453.1475246-9-ardb@kernel.org>
In-Reply-To: <20220125091453.1475246-9-ardb@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jan 2022 12:48:29 -0800
Message-ID: <CAKwvOdnV6ndTYjNN5CzYx_4LQpB4A6Qhfe21Vos192pUj=Hwmg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] ARM: make get_current() and __my_cpu_offset() __always_inline
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 25, 2022 at 1:15 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The get_current() and __my_cpu_offset() accessors evaluate to only a
> single instruction emitted inline, but due to the size of the asm string
> that is created for SMP+v6 configurations, the compiler assumes
> otherwise, and may emit the functions out of line instead.
>
> So use __always_inline to avoid this.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Alternatively, you could use the inline qualifier on the asm stmt.
i.e. `asm inline ("my asm string")`. Only supported since gcc-8.3+ and
all kernel-supported versions of clang though. See `asm_inline` in
include/linux/compiler_types.h.
Either way,
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/include/asm/current.h | 2 +-
>  arch/arm/include/asm/percpu.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
> index 131a89bbec6b..1e1178bf176d 100644
> --- a/arch/arm/include/asm/current.h
> +++ b/arch/arm/include/asm/current.h
> @@ -14,7 +14,7 @@ struct task_struct;
>
>  extern struct task_struct *__current;
>
> -static inline __attribute_const__ struct task_struct *get_current(void)
> +static __always_inline __attribute_const__ struct task_struct *get_current(void)
>  {
>         struct task_struct *cur;
>
> diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
> index a09034ae45a1..7545c87c251f 100644
> --- a/arch/arm/include/asm/percpu.h
> +++ b/arch/arm/include/asm/percpu.h
> @@ -25,7 +25,7 @@ static inline void set_my_cpu_offset(unsigned long off)
>         asm volatile("mcr p15, 0, %0, c13, c0, 4" : : "r" (off) : "memory");
>  }
>
> -static inline unsigned long __my_cpu_offset(void)
> +static __always_inline unsigned long __my_cpu_offset(void)
>  {
>         unsigned long off;
>
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
