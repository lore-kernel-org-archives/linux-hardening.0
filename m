Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF94C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 22 Mar 2022 11:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiCVLah (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 22 Mar 2022 07:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiCVLae (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 22 Mar 2022 07:30:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D9882D26
        for <linux-hardening@vger.kernel.org>; Tue, 22 Mar 2022 04:29:06 -0700 (PDT)
Date:   Tue, 22 Mar 2022 12:29:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647948543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jg++uWXO77BLjUiU+vy6aPHvKcUgQAyITPgZ4TGnq6Y=;
        b=Ru6nsi/3M/MfyVd91gnlUVYWQ/zNANB59Gztzpa3jgZJjKsu5Y2+GvZ4e+2m7LITuuDWXz
        tMbPloeF11imf42iYXOAVNCIBJcl30C34RdoY84TJQM/tk0CjyTG31oqNCv/LQ8/FXk3Yv
        3GbKIERYrTf0IT2dk+YK4ZkdzhFTQjqrW0yYVfg+X+jLNGsTeZZ3U64lQuuf7tTSMLW/nv
        e3mLycUuF7gCOeEZahmsnyYOx9PTJHlLO5BmkryftBoBEN7jR/9GVA7N4qHQG+BSZvjviI
        TLpiRU0saFEfiXkMHSiIeZVgXRh52ZyP9aFC2zHQIn66SrXplWnpPKgBbJp0xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647948543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jg++uWXO77BLjUiU+vy6aPHvKcUgQAyITPgZ4TGnq6Y=;
        b=GtQA98lHGgYIlQcszoY6pNuZCLb0pW/0QoiRx2EVqHntn73HGky+YkIzrp0UzOjdpock3j
        YcJxqgvad03b7qDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
Message-ID: <Yjmy/nfXBlpNbjau@linutronix.de>
References: <20220124174744.1054712-1-ardb@kernel.org>
 <20220124174744.1054712-25-ardb@kernel.org>
 <YjmRB9BGftCBWBy+@linutronix.de>
 <CAMj1kXHJRo1U5Nmw0arB9HNuso=eWfEmsVN6bZagmx-UUYs=dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHJRo1U5Nmw0arB9HNuso=eWfEmsVN6bZagmx-UUYs=dQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2022-03-22 10:35:18 [+0100], Ard Biesheuvel wrote:
> It is also used for hard IRQs - please refer to the irq_handler macro
> in arch/arm/kernel/entry-armv.S

Thank you, this makes sense.

Sebastian
