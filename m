Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1BDC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  3 May 2022 22:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiECWGa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 May 2022 18:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbiECWG3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 May 2022 18:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1BE7424BE
        for <linux-hardening@vger.kernel.org>; Tue,  3 May 2022 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651615374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQi/ZFhqTl+9HgfZab97oEqJSaMHvbvR0mYRqBC6N6U=;
        b=enUGKIF+ewjkVPeGlH+Ij6gS2FuJh2z+kWOCcw/LRfePl05wl4fPYKj5yqmEb0kOh+nOFE
        uuy64JM0P2x0JkzIAfHPXveyoD+GPcNrt5CqGB9UqxbXyZKU5GnzuWtwruM9tmc7E1YQq+
        N7roKamazc6RtY7aECWrVaqL2HtBOJc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-3c1BwfP1PGGjXrAbi_lZcQ-1; Tue, 03 May 2022 18:02:48 -0400
X-MC-Unique: 3c1BwfP1PGGjXrAbi_lZcQ-1
Received: by mail-qk1-f200.google.com with SMTP id 27-20020a05620a041b00b0069fd7a60a43so5451908qkp.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 May 2022 15:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQi/ZFhqTl+9HgfZab97oEqJSaMHvbvR0mYRqBC6N6U=;
        b=isGkxvGaDhfu60tSGmTWxVTvRNMU3O7059wuOk4KeMji0mVVEW4k5FPJewUkCAFilB
         2gPc4MIaNOn9jCpkmYxOXzAVPLrOCMMhoY8oonYdedMx5ILasmHLQlq7BA4X88Uo7Vyt
         iES6YHfATj+AUVq+XtoP8kVjEDHXshv3fo3FhR3IA98lp6dS33Bo6OxP7VrD8SqZBWVr
         1HRBXjc95alU7Yivyye0KSlEOy/D1ex4prPWo7Bnye00siqYKv/9MPSVYxRJxOdfztSf
         fjZuxdgmnraMMw56owf/SD+UpHMNfW7/KwY0Q14+ecs9oyHZOtkhVrIIfPtevU6vQknG
         yNdg==
X-Gm-Message-State: AOAM533gpOt3zXJpXA4yEb80GcsSk4KEqrmPSX7dwsOLVsacj5TjPTGw
        mlDYJdC9ebrMRBqas8uXMdvVL1D34tPccY6deG8FT2VLiVGiAyeThZHzYug7c2FxZAXDv4ufsEg
        Vf6EVN7Z6f3/XwJfIJz/65D/HmdL/
X-Received: by 2002:a05:622a:14c6:b0:2e2:3f:f938 with SMTP id u6-20020a05622a14c600b002e2003ff938mr17023689qtx.358.1651615368203;
        Tue, 03 May 2022 15:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNF2sJ5o4DN+JrRmRygt7UKrDDbMq9i8YT91xl2y+++ROlpmPF7tbsKPQmSRRLgCZKXv2wOQ==
X-Received: by 2002:a05:622a:14c6:b0:2e2:3f:f938 with SMTP id u6-20020a05622a14c600b002e2003ff938mr17023656qtx.358.1651615367925;
        Tue, 03 May 2022 15:02:47 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id 141-20020a370693000000b0069ff862c84esm2671595qkg.3.2022.05.03.15.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 15:02:47 -0700 (PDT)
Date:   Tue, 3 May 2022 15:02:44 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, andrew.cooper3@citrix.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
Message-ID: <20220503220244.vyz5flk3gg3y6rbw@treble>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
 <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
MIME-Version: 1.0
In-Reply-To: <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 02, 2022 at 10:17:42AM -0700, Joao Moreira wrote:
> > > +	asm("\t movq 0x90(%%rsp),%0" : "=r"(ret));
> > > +	asm("\t movq 0x98(%%rsp),%0" : "=r"(caller));
> > 
> > This is making some questionable assumptions about the stack layout.
> > 
> > I assume this function is still in the prototype stage ;-)
> 
> Yeah, this is just a messy instrumentation to get reports about mismatching
> prototypes (as the ones reported further down the series).
> 
> The issue with having the call is that it bloats the binary, so the ud2 is
> 3-bytes-per-function better. Yet, we may consider a FINEIBT_DEBUG config,
> which can then enable a handler. This would be useful together with a fuzzer
> or a stress tool to cover possible control-flow paths within the kernel and
> map mismatching prototypes more properly I guess.

It should be possible to have a non-fatal #UD2 handler.

See for example how WARN() is implemented with __WARN_FLAGS in
arch/x86/include/asm/bug.h .

So hopefully we can just get rid of the need for the "call handler"
thing altogether.

> > Not sure what would happen for "ibt=off"?  Maybe apply_ibt_endbr() could
> > NOP out all the FineIBT stuff.
> 
> Either that, or...
> 
> I'm thinking about a way to have FineIBT interchangeable with KCFI.
> Currently KCFI adds a 4 byte hash + 2 byte nops before function entry, to
> allow for proper prototype checking. After that, there should be an ENDBR of
> 4 bytes. This gives us 10 bytes in total. Then, my yet to be properly
> thought idea would be patch these 10 bytes with:
> 
> endbr
> call fineibt_handler_<$HASH>
> nop
> 
> and then, on the caller side, patch the "cmp <$HASH>, -0x6(%r11); je; ud2;
> call" sequence with a "sub 0x6, r11; mov $HASH, %r10; call %r11, add 0x6
> %r11". This would then allow the kernel to verify if the CPU is IBT capable
> on boot time and only then setting the proper scheme.
> 
> The downsides of having something like this would be that this sub r11/add
> r11 sequence is kinda meh. We can avoid that by having two padding nops
> after the original ENDBR, which will be skipped when the function is reached
> directly by the linker optimization I'm working on, and that we can convert
> into a JMP -offset that makes control flow reach the padding area before the
> prologue and from where we can call the fineibt_handler function. The
> resulting instrumentation would be something like:
> 
> 1:
> call fineibt_handler_<$HASH>
> jmp 2f
> <foo>
> endbr
> jmp 1b
> 2:
> 
> Also, it would prevent a paranoid user to have both schemes simultaneously
> (there are reasons why people could want that).
> 
> Any thoughts?

I'm not really qualified to comment on this too directly since I haven't
looked very much at the variations on FineIBT/CFI/KCFI, and what the
protections and drawbacks are for each approach, and when it might even
make sense to combine them for a "paranoid user".

Since we have multiple similar and possibly competing technologies being
discussed, one thing I do want to warn against is that we as kernel
developers tend to err on the side of giving people too many choices and
combinations which *never* get used.

All those unused options can confuse the user and significantly add to
complexity and maintenance overhead for us.  Especially for invasive
features like these.

(Just to be clear, I'm not saying that's happening here, but it's
something we need to be careful about.)

Here, documentation is going to be crucial, for both reviewers and
users.  Something that describes when/why I should use X or Y or X+Y.

If we truly want to add more options/combos for different use cases then
we'll also need clear and concise documentation about which
options/combos would be used under what circumstances.

-- 
Josh

