Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D076C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 22 Mar 2022 09:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiCVJFi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 22 Mar 2022 05:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiCVJFh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 22 Mar 2022 05:05:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA041FB6
        for <linux-hardening@vger.kernel.org>; Tue, 22 Mar 2022 02:04:10 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:04:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647939848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EO6vUklIrcTLsgRyqLgfukUerZ1d7RWzBvSLxQ/M7Y4=;
        b=32EASTAS22tQY1CsFG7nTQzhrC3LAqM6etN8tEos708PRm8+Qv+8R9lv6JZ0UO4qInFVUY
        2KQFSB8nNe6/mKyf/1SISA3nXiYlcPBqlw1yyVNZBZkKX8hsMkxZibSfxTx8CMV0a4PsEZ
        LZAEn6QyvKqXEyv84EREEWcrgIOmtfgzVrneKGi3xWlakB7GkJ7kWA9zu6bWQdjdgs5iu6
        l6uFIQdIk+Y/Vg3Oo+NZfBi4Og/PYPrYredepXb583E+KsUvTYAWlQcciTCBWfJAz721Nk
        m3IfeJGxoSg38QUhfAjiSXnWohhtIb0rpqg0cZKDNYGczVXmwJxgLtMXoWtKcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647939848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EO6vUklIrcTLsgRyqLgfukUerZ1d7RWzBvSLxQ/M7Y4=;
        b=YJOUT3KIJM3FSMTtmwptu6UTG9uwWGGIW0TFgcI5s875/boUoNr6zpHeYM1F6J5wtCGdZA
        VrNcJ6RVgvuePHDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 24/32] ARM: run softirqs on the per-CPU IRQ stack
Message-ID: <YjmRB9BGftCBWBy+@linutronix.de>
References: <20220124174744.1054712-1-ardb@kernel.org>
 <20220124174744.1054712-25-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124174744.1054712-25-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2022-01-24 18:47:36 [+0100], Ard Biesheuvel wrote:
> @@ -58,6 +61,17 @@ static void __init init_irq_stacks(void)
>  	}
>  }
>  
> +static void ____do_softirq(void *arg)
> +{
> +	__do_softirq();
> +}
> +
> +void do_softirq_own_stack(void)
> +{
> +	call_with_stack(____do_softirq, NULL,
> +			__this_cpu_read(irq_stack_ptr));
> +}
> +

Do I miss the obvious here or is the irq_stack_ptr only used for
softirqs and not for hardirqs?

>  int arch_show_interrupts(struct seq_file *p, int prec)
>  {
>  #ifdef CONFIG_FIQ

Sebastian
