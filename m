Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EECC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 01:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiD2Bk3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Apr 2022 21:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353976AbiD2Bk2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Apr 2022 21:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 149A13DDD9
        for <linux-hardening@vger.kernel.org>; Thu, 28 Apr 2022 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651196230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hW9cFab8Ik/mglyLVYP+gASmTZotsBUclSU51ABUpQ0=;
        b=PT1/6tBaT/o32VIi1g8iaVkaKucAm3rCeTlqkC5GkXez/sO5SDvdhQ/Qs2oOziaAj2gihY
        foYoBePPXh/ve29MePd3gmLLJ7wdrH5OYX68ahYBGQwadnExTWXC3dw8s1d+7sfl5SJOXK
        J6JOy/zRYuvqsTbUrre49Vr9c65t/4U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-M4ETIcobNHG_ngI1C9wtNg-1; Thu, 28 Apr 2022 21:37:08 -0400
X-MC-Unique: M4ETIcobNHG_ngI1C9wtNg-1
Received: by mail-qk1-f197.google.com with SMTP id c8-20020a05620a268800b0069c0f1b3206so4383964qkp.18
        for <linux-hardening@vger.kernel.org>; Thu, 28 Apr 2022 18:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hW9cFab8Ik/mglyLVYP+gASmTZotsBUclSU51ABUpQ0=;
        b=qqfsUbcJy6zQByG094kTeGR2q3UEgFnAm/sAGu6BRWU0UYu/R3D1B08gYiA4HB+8U3
         NWa192NxxLOgC3qF7+Na/UnPh7Nl5FR4O/V/3wG4AN7zijI6rpPhf0BjLr8iJyKufJ14
         lMZng/hcDHjBaWgvmEjbeiUJndobwfaCbId80csBAf1kkn6mFpoaQ6qZ49MSU7ayoG93
         zRieJ7VZ6V3fRAHByqrm9vREUybDJVKYHi4dfzpOWcfpL9Bn6RZzJSf21+q508HCuDva
         xr6LBoc23lQ9kimUBrxALAkZ7ocME9BNJskPgktDtQcQNWQs4SRM0STLeM0rHVKi6rcY
         sYfw==
X-Gm-Message-State: AOAM5329D8E0eKYU6OgJqVKxzKspEAxqc9XKa+HRLqwBzcld9+XIkSzF
        p9e2ir5ck976mQNURacZqn4LAuutRDV9ZalRvru7dJxdI1UH81N1LOdbBH5cjezIbJV+LHxZ6qp
        dCQkDGRKr3QR1/JXgjuGdjYGuXvT6
X-Received: by 2002:a05:6214:624:b0:441:42c0:7d41 with SMTP id a4-20020a056214062400b0044142c07d41mr26191362qvx.34.1651196228513;
        Thu, 28 Apr 2022 18:37:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7Yse6CBMrZfO14BHLXIwt9qxnIOlpImmfux0DWolt48lQgK4qbFnBjFh9ckK3IYFw+duTYg==
X-Received: by 2002:a05:6214:624:b0:441:42c0:7d41 with SMTP id a4-20020a056214062400b0044142c07d41mr26191349qvx.34.1651196228306;
        Thu, 28 Apr 2022 18:37:08 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002f1fc230725sm921519qta.31.2022.04.28.18.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 18:37:07 -0700 (PDT)
Date:   Thu, 28 Apr 2022 18:37:04 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     joao@overdrivepizza.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, andrew.cooper3@citrix.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
Message-ID: <20220429013704.4n4lmadpstdioe7a@treble>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
MIME-Version: 1.0
In-Reply-To: <20220420004241.2093-2-joao@overdrivepizza.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Apr 19, 2022 at 05:42:31PM -0700, joao@overdrivepizza.com wrote:
> +void __noendbr __fineibt_handler(void){
> +	unsigned i;
> +	unsigned long flags;
> +	bool skip;
> +	void * ret;
> +	void * caller;
> +
> +	DO_ALL_PUSHS;

So this function isn't C ABI compliant, right? e.g. the compiler just
calls the handler without regard for preserving registers?

If this function is going to be implemented in C, it should probably
have an asm thunk wrapper which can properly save/restore the registers
before calling into the C version.

Even better, if the compiler did an invalid op (UD2?), which I think you
mentioned elsewhere, instead of calling the handler directly, and there
were a way for the trap code to properly detect it as a FineIBT
violation, we could get rid of the pushes/pops, plus the uaccess objtool
warning from patch 7, plus I'm guessing a bunch of noinstr validation
warnings.

> +
> +	spin_lock_irqsave(&fineibt_lock, flags);
> +	skip = false;
> +
> +	asm("\t movq 0x90(%%rsp),%0" : "=r"(ret));
> +	asm("\t movq 0x98(%%rsp),%0" : "=r"(caller));

This is making some questionable assumptions about the stack layout.

I assume this function is still in the prototype stage ;-)

> +	if(!skip) {
> +		printk("FineIBT violation: %px:%px:%u\n", ret, caller,
> +				vlts_next);
> +	}
> +	DO_ALL_POPS;
> +}

Right now this handler just does a printk if it hasn't already for this
caller/callee combo, and then resumes control.  Which is fine for
debugging, but it really needs to behave similarly to an IBT violation,
by panicking unless "ibt=warn" on the cmdline.

Not sure what would happen for "ibt=off"?  Maybe apply_ibt_endbr() could
NOP out all the FineIBT stuff.

-- 
Josh

