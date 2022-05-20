Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572CDC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 20 May 2022 17:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352215AbiETRcL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 May 2022 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiETRcK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 May 2022 13:32:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE4B7A836
        for <linux-hardening@vger.kernel.org>; Fri, 20 May 2022 10:32:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h9so109829pgl.4
        for <linux-hardening@vger.kernel.org>; Fri, 20 May 2022 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZBKb0fjscPpUrzXEuZ8CHp+jRIIn9EphQZhgAcnYOMI=;
        b=hPLF5ByV6OKZuxe0zweoZ6AmxwzQpA4YFOwx9e14kGQJ8frtXM7sTOs3yFC3P6sdeg
         KUscqjAPu1SJ+eUV66whGKEF8HstKqxdQLSgGc4ePoYEZQLxMF0dQ9raKg0tG407moTy
         pqdzq7XWNunDRkjvBKPxsjljdfQHzxRL/H9ZgdMEf5wh1u78qkuQMg6m5h80XofwNRKB
         dZqNo3SchhJVu9KCFZGvBwEbaBqLo2wTv0LJ7HdT69wf7yyuRNLG8C8tXmWFqpDrhrHj
         v9lr0CbcvrQ4DEF8qznBh+J+GgzAAGDhbgTsM+hoO4zDyN6a/ggd9MAI2J+KiaB4bnLu
         FU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZBKb0fjscPpUrzXEuZ8CHp+jRIIn9EphQZhgAcnYOMI=;
        b=mq+pDF5Tq9OuIRpbu3/JBWlXMrNVn9sFbBh2a/01Bu4McpG+pFL0IW75Dd/cu5NYax
         JnKz0X8e4AxAtmSSFiOD6cZWXhTmpB+95vUTZ1bgfDwtjXTXdtsKYPTULkTHdmZwCTln
         1b3lYW36YNeDZXHvieOeZW4hsj4ldoy/rghZ9QAxUUnbHpaDXOG20VcMi/FGM4bmCr57
         f0jIpnoMOGgeAuE51ed5jbaeu0HVq744iK2S9ypVrSB/btDrtb8lpUw4RtlMBOpvbd6E
         kqqgnshUsAkC6leOC4W6VyYaCDMJqP4AT5GhVlHIQaBf2XJ539mQDeYIZI24z+PtPZNd
         VDiw==
X-Gm-Message-State: AOAM532fUGFfMpytXljllNkl5SOevw+9aZ0odAnqsoFW/PZObmIS9rTw
        JhVtHFQD/lIZfa0tfengmM9sVw==
X-Google-Smtp-Source: ABdhPJy/ZpW9fR0g5/rnyZmK5ygUqSdFNk+ECOXEaQsYVb5idh6wFSqoVoMNRGPaChhO5h//d6M/mg==
X-Received: by 2002:a65:44c1:0:b0:3f6:26e8:77a9 with SMTP id g1-20020a6544c1000000b003f626e877a9mr9350381pgs.204.1653067928701;
        Fri, 20 May 2022 10:32:08 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b0015e8d4eb1d2sm36893plg.28.2022.05.20.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:32:08 -0700 (PDT)
Date:   Fri, 20 May 2022 17:32:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/emulator: Bounds check reg nr against reg array
 size
Message-ID: <YofQlBrlx18J7h9Y@google.com>
References: <20220520165705.2140042-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520165705.2140042-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 20, 2022, Kees Cook wrote:
> GCC 12 sees that it might be possible for "nr" to be outside the _regs
> array. Add explicit bounds checking.

I think GCC 12 is wrong.

There are four uses of reg_rmw() that don't use hardcoded registers:

   $ git grep reg_rmw | grep -v VCPU_REGS_
   emulate.c:static ulong *reg_rmw(struct x86_emulate_ctxt *ctxt, unsigned nr)
1  emulate.c:	ulong *preg = reg_rmw(ctxt, reg);
2  emulate.c:		p = (unsigned char *)reg_rmw(ctxt, modrm_reg & 3) + 1;
3  emulate.c:		p = reg_rmw(ctxt, modrm_reg);
4  emulate.c:		assign_register(reg_rmw(ctxt, reg), val, ctxt->op_bytes);

#1 has three users, but two of those use hardcoded registers.

  $ git grep register_address_increment | grep -v VCPU_REGS_
  emulate.c:register_address_increment(struct x86_emulate_ctxt *ctxt, int reg, int inc)
  emulate.c:	register_address_increment(ctxt, reg, df * op->bytes);
 
and that last one is string_addr_inc(), which is only called with RDI or RSI.

#2 can't overflow as the register can only be 0-3 (yay AH/BH/CH/DH operands).

#3 is the !highbyte path of decode_register(), and is a bit messy, but modrm_reg
is always sanitized.

   $ git grep -E "decode_register\("
   emulate.c:static void *decode_register(struct x86_emulate_ctxt *ctxt, u8 modrm_reg,
a  emulate.c:      op->addr.reg = decode_register(ctxt, reg, ctxt->d & ByteOp);
b  emulate.c:              op->addr.reg = decode_register(ctxt, ctxt->modrm_rm,
c  emulate.c:                      ctxt->memop.addr.reg = decode_register(ctxt,
                                                                          ctxt->modrm_rm, true);

For (b) and (c), modrm_reg == ctxt->modrm_rm, which is computed in one place and
is bounded to 0-15:

	base_reg = (ctxt->rex_prefix << 3) & 8; /* REX.B */
	ctxt->modrm_rm = base_reg | (ctxt->modrm & 0x07);

For (a), "reg" is either modrm_reg or a register that is encoded in the opcode,
both of which are again bounded to 0-15:

	unsigned reg = ctxt->modrm_reg;

	if (!(ctxt->d & ModRM))
		reg = (ctxt->b & 7) | ((ctxt->rex_prefix & 1) << 3);

and

	ctxt->modrm_reg = ((ctxt->rex_prefix << 1) & 8); /* REX.R */
	ctxt->modrm_reg |= (ctxt->modrm & 0x38) >> 3;

#4 is em_popa() and is just funky hardcoding of popping RAX-RDI, minus RSP.

I did the same exercise for reg_reg() and write_reg(), and the handful of
non-hardcoded use are all bounded in similar ways.

> In function 'reg_read',
>     inlined from 'reg_rmw' at ../arch/x86/kvm/emulate.c:266:2:

Is there more of the "stack" available?  I don't mind the WARN too much, but if
there is a bug lurking I would much rather fix the bug.

> ../arch/x86/kvm/emulate.c:254:27: warning: array subscript 32 is above array bounds of 'long unsigned int[17]' [-Warray-bounds]
>   254 |         return ctxt->_regs[nr];
>       |                ~~~~~~~~~~~^~~~
> In file included from ../arch/x86/kvm/emulate.c:23:
> ../arch/x86/kvm/kvm_emulate.h: In function 'reg_rmw':
> ../arch/x86/kvm/kvm_emulate.h:366:23: note: while referencing '_regs'
>   366 |         unsigned long _regs[NR_VCPU_REGS];
>       |                       ^~~~~
