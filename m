Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C43AC433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 22:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4706B610F8
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 22:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDAWmM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 18:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDAWmL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 18:42:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21D8C061788
        for <linux-hardening@vger.kernel.org>; Thu,  1 Apr 2021 15:42:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p12so172826pgj.10
        for <linux-hardening@vger.kernel.org>; Thu, 01 Apr 2021 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHU/CSlbR0tXIQ7skc+D9M4sQ8Nf+DFxpytkWh85RTc=;
        b=Cdeb4TJryjuUvq0PZ22+p9aZ80XrqpLOQqZBbyxQf2b3KNvemF9hZdYHkWk2rvgvr9
         +SpPIdq+JMo2g9UMPmRHYMNVYDXvm5KREo94cbMizN1C/uol3pIjbIlmE2pjHUirEook
         l3tfPMZVPC0JP0fRuhcSZ92o1n77ukI4HC3SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHU/CSlbR0tXIQ7skc+D9M4sQ8Nf+DFxpytkWh85RTc=;
        b=mB96nhkPbONgoJSG7sQ+0Zglea4HUjQaLi+9B8vqL5IPR5rcCqpQKdxMMRnoPtpA1X
         i7KwIOft5CE6XEj7ZNiQuV6V/UFHoWWFefRYPyxMoO7GL1rCa+a8j8TxUG3Frwv6Kc6H
         3C+8pj8NNM0alse264ET/lGmbfOVMxnxB6MJqPzp7R6gWlPh3OBenXk9xIXko9YAZa+n
         dBBZ41CmKTQtBUr0aKwel2127vIrnwHLw8aZ1kzovrZY4z8sqW/1ashc0CL5THyGv5Lw
         4Y0uSr5c5xHYjja/m+PhbxPRpc4B5v8V3JiS6uFH0Fsq9Jxwli9bJMUT9T8qb9zouywE
         E+5w==
X-Gm-Message-State: AOAM533tFGV60ui02938bZdeoJZgV+gXYd8mWRBHA7bHVUY5vLHWUBcZ
        2Z8q/OwBCDodU8TfRMs1Xutx9w==
X-Google-Smtp-Source: ABdhPJy5OYaYtgibg+iSJ6TbNgMEMp0Li4wFRje6LCbJMZHyUSADLtOfsJcpWv8pBVkoh3+T2eGIQA==
X-Received: by 2002:a65:56cc:: with SMTP id w12mr9470880pgs.354.1617316931239;
        Thu, 01 Apr 2021 15:42:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7sm6246426pfo.105.2021.04.01.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:42:10 -0700 (PDT)
Date:   Thu, 1 Apr 2021 15:42:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Will Deacon' <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/6] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <202104011447.2E7F543@keescook>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210330205750.428816-4-keescook@chromium.org>
 <20210401083034.GA8554@willie-the-truck>
 <61ae9398a03d4fe7868b68c9026d5998@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ae9398a03d4fe7868b68c9026d5998@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 01, 2021 at 11:15:43AM +0000, David Laight wrote:
> From: Will Deacon
> > Sent: 01 April 2021 09:31
> ...
> > > +/*
> > > + * These macros must be used during syscall entry when interrupts and
> > > + * preempt are disabled, and after user registers have been stored to
> > > + * the stack.
> > > + */
> > > +#define add_random_kstack_offset() do {					\
> > > +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> > > +				&randomize_kstack_offset)) {		\
> > > +		u32 offset = __this_cpu_read(kstack_offset);		\
> > > +		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
> > > +		asm volatile("" : "=m"(*ptr) :: "memory");		\
> > 
> > Using the "m" constraint here is dangerous if you don't actually evaluate it
> > inside the asm. For example, if the compiler decides to generate an
> > addressing mode relative to the stack but with writeback (autodecrement), then
> > the stack pointer will be off by 8 bytes. Can you use "o" instead?

I see other examples of empty asm, but it's true, none are using "=m" read
constraints. But, yes, using "o" appears to work happily.

> Is it allowed to use such a mode?
> It would have to know that the "m" was substituted exactly once.
> I think there are quite a few examples with 'strange' uses of memory
> asm arguments.
> 
> However, in this case, isn't it enough to ensure the address is 'saved'?
> So:
> 	asm volatile("" : "=r"(ptr) );
> should be enough.

It isn't, it seems.

Here's a comparison:

https://godbolt.org/z/xYGn9GfGY

So, I'll resend with "o", and with raw_cpu_*().

Thanks!

-- 
Kees Cook
