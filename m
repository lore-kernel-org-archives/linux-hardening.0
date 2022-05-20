Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011FAC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 20 May 2022 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbiETST3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 May 2022 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346991AbiETSTW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 May 2022 14:19:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD10363BE1
        for <linux-hardening@vger.kernel.org>; Fri, 20 May 2022 11:19:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso8501662pjb.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 May 2022 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wgrcw3AWnI5MJ/JhXJfsPIWwbLCvXeysZUnODXN4Ko4=;
        b=guBYQwxKDovD2VNhx5zMFKN7LQYg5JtyW6Y7ASt3KAzn1dpSAkq5tqlNDPGO5pKpM/
         cVEeZiHJOfMPHIE5gtS0Fh1czT/Q2fxIWf06Skm68gqzf3NqPGIkp0eqSO0igmbVtltz
         ggiokUQwWAKEDsTlQ1XDEYgg1ub5xkkVymSxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wgrcw3AWnI5MJ/JhXJfsPIWwbLCvXeysZUnODXN4Ko4=;
        b=5uM2cvDfzn2CoQwJK2KC0+QTJPx4qTkHqOBytWsp0C5lnMatNXp1GQvbRH5Lsa6KBt
         8tFhhHq07YKdRikO7H0iScAuV7iw+45NHv5gYnkvQu3wXwkFVZuJRIp4Qg3FqT39Ohp8
         wo0hWT6gJB/faiNs9Nkx8qwFbWaKuxjFRf9mStjjQXgGDDbuR7jjEFKrh3ezf/znyRRk
         OCZgzwaTj8ViKcvslK0pvxikJGd/b/FCBYFrat+6lmmIKZIiFVrDGORuRXVAQivjocN/
         uNUXRhJJT+klZu4IbJAMU+mQ8dLsuP3BOVhEhb+I1vyAtks8zD60TTfrkUhMyPq4oHIo
         iT5w==
X-Gm-Message-State: AOAM531q5RsD/qXsZb0X+VfKLihzKkAWTaqp3hhbxEd3OlcpjYB8stwx
        Ha8M9edOlKbe5B5idMm1+AJRiQ==
X-Google-Smtp-Source: ABdhPJzej/3St1PJgS9g4UCEKxkkv9Qgf+QM2ka3RrR3JIjvpUTa9IxTy16SHJm8NjocE+FYSdN8dw==
X-Received: by 2002:a17:90a:d713:b0:1df:d114:deef with SMTP id y19-20020a17090ad71300b001dfd114deefmr11291356pju.13.1653070760362;
        Fri, 20 May 2022 11:19:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v22-20020aa78096000000b0050dc76281d0sm2183516pff.170.2022.05.20.11.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:19:20 -0700 (PDT)
Date:   Fri, 20 May 2022 11:19:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/emulator: Bounds check reg nr against reg array
 size
Message-ID: <202205201115.5E830F0@keescook>
References: <20220520165705.2140042-1-keescook@chromium.org>
 <YofQlBrlx18J7h9Y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YofQlBrlx18J7h9Y@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 20, 2022 at 05:32:04PM +0000, Sean Christopherson wrote:
> On Fri, May 20, 2022, Kees Cook wrote:
> > GCC 12 sees that it might be possible for "nr" to be outside the _regs
> > array. Add explicit bounds checking.
> 
> I think GCC 12 is wrong.

I think it's more like GCC is extremely conservative about these things,
and assumes the worst when, for whatever reason, it can't track
something.

> There are four uses of reg_rmw() that don't use hardcoded registers:
> 
>    $ git grep reg_rmw | grep -v VCPU_REGS_
>    emulate.c:static ulong *reg_rmw(struct x86_emulate_ctxt *ctxt, unsigned nr)
> 1  emulate.c:	ulong *preg = reg_rmw(ctxt, reg);
> 2  emulate.c:		p = (unsigned char *)reg_rmw(ctxt, modrm_reg & 3) + 1;
> 3  emulate.c:		p = reg_rmw(ctxt, modrm_reg);
> 4  emulate.c:		assign_register(reg_rmw(ctxt, reg), val, ctxt->op_bytes);
> 
> #1 has three users, but two of those use hardcoded registers.
> 
>   $ git grep register_address_increment | grep -v VCPU_REGS_
>   emulate.c:register_address_increment(struct x86_emulate_ctxt *ctxt, int reg, int inc)
>   emulate.c:	register_address_increment(ctxt, reg, df * op->bytes);
>  
> and that last one is string_addr_inc(), which is only called with RDI or RSI.
> 
> #2 can't overflow as the register can only be 0-3 (yay AH/BH/CH/DH operands).
> 
> #3 is the !highbyte path of decode_register(), and is a bit messy, but modrm_reg
> is always sanitized.
> 
>    $ git grep -E "decode_register\("
>    emulate.c:static void *decode_register(struct x86_emulate_ctxt *ctxt, u8 modrm_reg,
> a  emulate.c:      op->addr.reg = decode_register(ctxt, reg, ctxt->d & ByteOp);
> b  emulate.c:              op->addr.reg = decode_register(ctxt, ctxt->modrm_rm,
> c  emulate.c:                      ctxt->memop.addr.reg = decode_register(ctxt,
>                                                                           ctxt->modrm_rm, true);
> 
> For (b) and (c), modrm_reg == ctxt->modrm_rm, which is computed in one place and
> is bounded to 0-15:
> 
> 	base_reg = (ctxt->rex_prefix << 3) & 8; /* REX.B */
> 	ctxt->modrm_rm = base_reg | (ctxt->modrm & 0x07);
> 
> For (a), "reg" is either modrm_reg or a register that is encoded in the opcode,
> both of which are again bounded to 0-15:
> 
> 	unsigned reg = ctxt->modrm_reg;
> 
> 	if (!(ctxt->d & ModRM))
> 		reg = (ctxt->b & 7) | ((ctxt->rex_prefix & 1) << 3);
> 
> and
> 
> 	ctxt->modrm_reg = ((ctxt->rex_prefix << 1) & 8); /* REX.R */
> 	ctxt->modrm_reg |= (ctxt->modrm & 0x38) >> 3;
> 
> #4 is em_popa() and is just funky hardcoding of popping RAX-RDI, minus RSP.
> 
> I did the same exercise for reg_reg() and write_reg(), and the handful of
> non-hardcoded use are all bounded in similar ways.

Thanks for digging into this. I tried to do the same and started to lose
track of things.

> 
> > In function 'reg_read',
> >     inlined from 'reg_rmw' at ../arch/x86/kvm/emulate.c:266:2:
> 
> Is there more of the "stack" available?  I don't mind the WARN too much, but if
> there is a bug lurking I would much rather fix the bug.

Agreed, but I haven't found a way to get more context here. I think I
found a separate place where GCC really does look to have a bug, as it
complains about array usage that is explicitly bounded. :P

-- 
Kees Cook
