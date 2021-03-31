Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CAC433ED
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 22:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A459761008
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 22:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCaWis (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:38:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhCaWid (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Mar 2021 18:38:33 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617230311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTAca8jamyiv4OQC/0ehNmkUzrYgK82+B2gnABlfuE4=;
        b=wLJuSNRlSVF/PkDm3fuzha7lpECmwuVqtA03/nXyQDXDAWvBirH+/fYTNYqrnlItwtLK39
        ueabTGEjWfDwJRWajmljjDlBBRKb1e4iWShFRNEaFV/o2ysNaExtYxnlKlAmRe3XZMJnKG
        bNQvUoKtTg4fdrC48N52k6UMO9iR3DD92508uibjdl9Mmhw/WkzMQdF6Rjwqo7Q7jvmbj+
        WxukKQ1OuTjvMmPRlRVQVfC0Htd3LczE5FTUIDbv/T8HXjwy0JEUrOjh1ErBC+f7z6rUNc
        jP8Y+MbOuHb2pyR7nVtU21KL+1pc2hsRU+1ZQlaM5d6XOuJe6UKGsmHaYhzSQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617230311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTAca8jamyiv4OQC/0ehNmkUzrYgK82+B2gnABlfuE4=;
        b=yTpBUljzXJtrMhJ2lcQnuH9tBbKROS0ovJE/lzzYE7vrNqhZtLuA5E4XjbMAeCAsuBkJfi
        LNLwWc3mHTWDTwBw==
To:     Kees Cook <keescook@chromium.org>
Cc:     Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] stack: Optionally randomize kernel stack offset each syscall
In-Reply-To: <202103311453.A840B7FC5@keescook>
References: <20210330205750.428816-1-keescook@chromium.org> <20210330205750.428816-4-keescook@chromium.org> <87im5769op.ffs@nanos.tec.linutronix.de> <202103311453.A840B7FC5@keescook>
Date:   Thu, 01 Apr 2021 00:38:31 +0200
Message-ID: <87v9973q54.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 31 2021 at 14:54, Kees Cook wrote:
> On Wed, Mar 31, 2021 at 09:53:26AM +0200, Thomas Gleixner wrote:
>> On Tue, Mar 30 2021 at 13:57, Kees Cook wrote:
>> > +/*
>> > + * Do not use this anywhere else in the kernel. This is used here because
>> > + * it provides an arch-agnostic way to grow the stack with correct
>> > + * alignment. Also, since this use is being explicitly masked to a max of
>> > + * 10 bits, stack-clash style attacks are unlikely. For more details see
>> > + * "VLAs" in Documentation/process/deprecated.rst
>> > + * The asm statement is designed to convince the compiler to keep the
>> > + * allocation around even after "ptr" goes out of scope.
>> 
>> Nit. That explanation of "ptr" might be better placed right at the
>> add_random...() macro.
>
> Ah, yes! Fixed in v9.

Hmm, looking at V9 the "ptr" thing got lost ....

> +/*
> + * Do not use this anywhere else in the kernel. This is used here because
> + * it provides an arch-agnostic way to grow the stack with correct
> + * alignment. Also, since this use is being explicitly masked to a max of
> + * 10 bits, stack-clash style attacks are unlikely. For more details see
> + * "VLAs" in Documentation/process/deprecated.rst
> + */
> +void *__builtin_alloca(size_t size);
> +/*
> + * Use, at most, 10 bits of entropy. We explicitly cap this to keep the
> + * "VLA" from being unbounded (see above). 10 bits leaves enough room for
> + * per-arch offset masks to reduce entropy (by removing higher bits, since
> + * high entropy may overly constrain usable stack space), and for
> + * compiler/arch-specific stack alignment to remove the lower bits.
> + */
> +#define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
> +
> +/*
> + * These macros must be used during syscall entry when interrupts and
> + * preempt are disabled, and after user registers have been stored to
> + * the stack.
> + */
> +#define add_random_kstack_offset() do {					\

> Do you want to take this via -tip (and leave off the arm64 patch until
> it is acked), or would you rather it go via arm64? (I've sent v9 now...)

Either way is fine.

Thanks,

        tglx
