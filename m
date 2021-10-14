Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45877C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 19:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A3661073
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 19:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhJNTxd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 15:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233704AbhJNTxb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 15:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634241086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogcFj+sByVK4/R93V4MHhdhBzoSVkZq8qT5UCE78dsc=;
        b=Vl3d0LZseJwGHtry9Mjip6lgmyejPC9VMJToJ2vteJk0E1YXOTxWqAJkC+N5eGK0doEs1X
        /kv2iZo+9feoRvOBmUdjAVw/5afzbr5tNEBJJl7AdhWL1uEKi8KjsiaoHtswE4VW37yIDW
        b6ylcZ1Ve0Oa6kPXB7UcrLi0go62qIM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-gcS89ALnN2Ksl96wqWSUuQ-1; Thu, 14 Oct 2021 15:51:25 -0400
X-MC-Unique: gcS89ALnN2Ksl96wqWSUuQ-1
Received: by mail-qk1-f199.google.com with SMTP id s20-20020a05620a0bd400b0045e893f2ed8so5244710qki.11
        for <linux-hardening@vger.kernel.org>; Thu, 14 Oct 2021 12:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ogcFj+sByVK4/R93V4MHhdhBzoSVkZq8qT5UCE78dsc=;
        b=KlkSkMQf/ARJKIlgeCBCJQcR2xe4wWmXlCjNaQz7WuwJ+2+G+FtHOfvl0AaSR6nraH
         Oy2/QioDNYb9ud1z1kc/DMH6UqKxf1qzu00BEMhpxoh9+niU3wXojp6d4dKwVThA6XGT
         epR3Ijr+M+s+xrdrHUoNmzaEHE3SgR0Yxt4f8S2QfosJ9Ac9lqxjo/TTAspI5DhqIdQY
         AdZFBWqrbIdcjNRxZBfTMKwaIvKoJXNh+IQfTe4xEN+9UTbU6m6JLTs/WVCCRFgXGemc
         +eDxrKbIHp2Y9hhzPwaqbudNIf9drH197tlGyfN0VdRv2GOQHMnirbfvQ5boFe8jZZ6V
         9rig==
X-Gm-Message-State: AOAM532rX9r6NlA+JpkNc9rlg+MEvxORlBTHl00njeL0j/uMl68XjZQN
        qTx4xOIgeWSMqtgv7XPNJlclszb883U3PsHNqzjx/GxmGGpQI2Ohx0bmmwP4RK3OpRMnq0mH3kK
        TeEwfrdBwd4HWULqmGsaJFTzU8Uo5
X-Received: by 2002:ac8:5fc5:: with SMTP id k5mr8754670qta.273.1634241084550;
        Thu, 14 Oct 2021 12:51:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEP6AM1EqcbwuULvFfiw8xfRaY0OsFKLxKOB3CaLItmwqnQm/m2rUl5ZM9/0F9nY5C1hze8w==
X-Received: by 2002:ac8:5fc5:: with SMTP id k5mr8754620qta.273.1634241084286;
        Thu, 14 Oct 2021 12:51:24 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id i11sm1697564qki.28.2021.10.14.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:51:23 -0700 (PDT)
Date:   Thu, 14 Oct 2021 12:51:18 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        jannh@google.com, linux-kernel@vger.kernel.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        mark.rutland@arm.com, axboe@kernel.dk, metze@samba.org,
        laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, vgupta@kernel.org, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: Re: [PATCH 0/7] wchan: Fix wchan support
Message-ID: <20211014195118.lcuik3jb6zcbm6vu@treble>
References: <20211008111527.438276127@infradead.org>
 <YWgcWnbsvI1rbvEj@shell.armlinux.org.uk>
 <YWgyy+KvNLQ7eMIV@shell.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <YWgyy+KvNLQ7eMIV@shell.armlinux.org.uk>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 14, 2021 at 02:38:19PM +0100, Russell King (Oracle) wrote:
> What is going on here is that the ARM stacktrace code refuses to trace
> non-current tasks in a SMP environment due to the racy nature of doing
> so if the non-current tasks are running.
> 
> When walking the stack with frame pointers, we:
> 
> - validate that the frame pointer is between the stack pointer and the
>   top of stack defined by that stack pointer.
> - we then load the next stack pointer and next frame pointer from the
>   stack.
> 
> The reason this is unsafe when the task is not blocked is the stack can
> change at any moment, which can cause the value read as a stack pointer
> to be wildly different. If the read frame pointer value is roughly in
> agreement, we can end up reading any part of memory, which would be an
> information leak.

It would be a good idea to add some guardrails to prevent that
regardless.  If there's stack corruption for any reason, the unwinder
shouldn't make things worse.

On x86 the unwinder relies on the caller to ensure the task is blocked
(or current).  If the caller doesn't do that, they might get garbage,
and they get to keep the pieces.

But an important part of that is that the unwinder has guardrails to
ensure it handles stack corruption gracefully by never accessing out of
bounds of the stack.

When multiple stacks are involved in a kernel execution path (task, irq,
exception, etc), the stacks link to each other (e.g., last word on the
irq stack might point to the task stack).  Also the irq/exception stack
addresses are stored in percpu variables, and the task stack is in the
task struct.  So the unwinder can easily make sure it's in-bounds.  See
get_stack_info() in arch/x86/kernel/dumpstack_64.c.

-- 
Josh

