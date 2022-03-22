Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B8FC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 22 Mar 2022 09:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiCVJhB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 22 Mar 2022 05:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiCVJhA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 22 Mar 2022 05:37:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0305F88
        for <linux-hardening@vger.kernel.org>; Tue, 22 Mar 2022 02:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14BF4B81C69
        for <linux-hardening@vger.kernel.org>; Tue, 22 Mar 2022 09:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA3EC340F6
        for <linux-hardening@vger.kernel.org>; Tue, 22 Mar 2022 09:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647941730;
        bh=Zts/gyl/tv/2FnJfL8+1xjKBan2CCFCPjLXX71f7auI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RQPUEiQK5WT5wKjLaG0fRKXWv2npSxHeIFCaJvvQtzh5guRdgLHnnOi4qzygJ+8bq
         xD394f7IkpvGNvSWATUGvND7jJUxTz3Qdf/+gZG92migja+AGkIrX1tqszJ+rviyK5
         7hcHSFXeBpUXxHbLCSxktFE9hEURlF777Nn7jARP0U1VrZtoGWgJGzkcrzhqXrhXXA
         iufi5o1EG5M2SrsTNfIHi2fM8xHlHctfBq3qFvh5VdyKytM/kBZ3OOb+xb1i//NvuY
         Cd/sK6d56/PIol67dC8cCEgQbQ7jlJQLtdK79fJ76f0R23kV4dTGDDOflqOX6nTZr+
         ujsHSw+2dTE9g==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2d07ae0b1c0so183692767b3.2
        for <linux-hardening@vger.kernel.org>; Tue, 22 Mar 2022 02:35:30 -0700 (PDT)
X-Gm-Message-State: AOAM532L6RpKcRLuPZT/YxLJ9xZ0H7wrp9wYgWZDAuNgU0gHBLB3ZA0E
        4vXnzXOv/Y3FuSulNR8txt4WIZDL61gnfcGBpjk=
X-Google-Smtp-Source: ABdhPJz/la3PKtOMHD6S288/kvu6qbT90/pI1k7Mc/hxLdCzLhVyqUiBEXsN39195aDZKWbqQglgHgLGWWdZ2AxlUMc=
X-Received: by 2002:a81:10c2:0:b0:2e5:c9dd:d5bf with SMTP id
 185-20020a8110c2000000b002e5c9ddd5bfmr24018648ywq.342.1647941729701; Tue, 22
 Mar 2022 02:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220124174744.1054712-1-ardb@kernel.org> <20220124174744.1054712-25-ardb@kernel.org>
 <YjmRB9BGftCBWBy+@linutronix.de>
In-Reply-To: <YjmRB9BGftCBWBy+@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Mar 2022 10:35:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHJRo1U5Nmw0arB9HNuso=eWfEmsVN6bZagmx-UUYs=dQ@mail.gmail.com>
Message-ID: <CAMj1kXHJRo1U5Nmw0arB9HNuso=eWfEmsVN6bZagmx-UUYs=dQ@mail.gmail.com>
Subject: Re: [PATCH v5 24/32] ARM: run softirqs on the per-CPU IRQ stack
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 22 Mar 2022 at 10:04, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-01-24 18:47:36 [+0100], Ard Biesheuvel wrote:
> > @@ -58,6 +61,17 @@ static void __init init_irq_stacks(void)
> >       }
> >  }
> >
> > +static void ____do_softirq(void *arg)
> > +{
> > +     __do_softirq();
> > +}
> > +
> > +void do_softirq_own_stack(void)
> > +{
> > +     call_with_stack(____do_softirq, NULL,
> > +                     __this_cpu_read(irq_stack_ptr));
> > +}
> > +
>
> Do I miss the obvious here or is the irq_stack_ptr only used for
> softirqs and not for hardirqs?
>
> >  int arch_show_interrupts(struct seq_file *p, int prec)
> >  {
> >  #ifdef CONFIG_FIQ
>

It is also used for hard IRQs - please refer to the irq_handler macro
in arch/arm/kernel/entry-armv.S
