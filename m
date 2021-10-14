Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D6C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 00:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78BC60E97
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 00:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhJNAqp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229773AbhJNAqo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 20:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634172279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFv5OLM8EkJT7hF4OqXauqHE4zCaE1+d14pWIYx+RA0=;
        b=NhGvnlj7cHQWsKCkT66xm4vi1U9h7XRZRpebPc06DBwVlj8a5NROSPytkLFibV/juD3qHx
        4rUUQhn64xLRBwl28yfX5e757+GoaSkmhp9YOwtmsoAh59Cwh87p7RKqi98druDi1oChmt
        ZJQx2J08vBkUmuUJ9HZTEvpAMiphz2U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-mTE3b_7PPkeDJv-gu0nlBA-1; Wed, 13 Oct 2021 20:44:38 -0400
X-MC-Unique: mTE3b_7PPkeDJv-gu0nlBA-1
Received: by mail-qt1-f197.google.com with SMTP id t9-20020a05622a180900b002a71f83a1cdso3348102qtc.17
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 17:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jFv5OLM8EkJT7hF4OqXauqHE4zCaE1+d14pWIYx+RA0=;
        b=QihThX6fbDulibaqgpyhtXBGq6L1/g0J+igoIVlBVapFmxLy2/tbz0JKHH/bh5Y6oj
         UDVoMk6NcJGI6tSB/ehj2Zg34FJhf642xdLDlyj8Zt0Ef313yymCi0TDg1CR1AJzijld
         AyqsXPiMh+t1LAp+eRxVFddJNCztUqHizPFTsp64faGbViC4zBvStiVtmztZklf6xTsk
         tKKIszu/kZXaT9Iu2Zi76UySJLNEGCJTCKVJgvnyLSXwXXyQhAu0+iaiBBhgdvdCj4A+
         cvs/v4DrPweofIxok9ootLPXByUECWjHNSI1cMFBs59XeIzQXxhEkL7t8pHuvIdX2hgN
         7J6w==
X-Gm-Message-State: AOAM531N4cqBGL/zgia5tEwwvt3ekQJIMm1BroVcZs1UeAfBrN5E8RRk
        eTFZOzq6cYrGuWuFUcNkxE+txgyaosxJ3FTUFK3zbRqKXXTfsH1Bg+VCzdsojK0nTfJ7m77G50F
        gItmgTfgKEe6FJFNNb4ccC10LDTM1
X-Received: by 2002:a37:b742:: with SMTP id h63mr2191201qkf.204.1634172278088;
        Wed, 13 Oct 2021 17:44:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN7hRCKU/SKDN5he5DTJoX8aHISMFYBLbyiwc6It64vOfVpkP2EJr4BFnCIqPmfMZ5NSu/ig==
X-Received: by 2002:a37:b742:: with SMTP id h63mr2191187qkf.204.1634172277891;
        Wed, 13 Oct 2021 17:44:37 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id z19sm701005qts.96.2021.10.13.17.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:44:37 -0700 (PDT)
Date:   Wed, 13 Oct 2021 17:44:34 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 01/15] objtool: Add CONFIG_CFI_CLANG support
Message-ID: <20211014004434.vjbpkd4ykn7upvsw@treble>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-2-samitolvanen@google.com>
MIME-Version: 1.0
In-Reply-To: <20211013181658.1020262-2-samitolvanen@google.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:44AM -0700, Sami Tolvanen wrote:
> The upcoming CONFIG_CFI_CLANG support uses -fsanitize=cfi, the
> non-canonical version of which hijacks function entry by changing
> function relocation references to point to an intermediary jump table.
> 
> For example:
> 
>   Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x37e018 contains 6 entries:
>       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   0000000000000000  0002944700000002 R_X86_64_PC32          00000000000023f0 do_suspend_lowlevel + 0
>   0000000000000008  0003c11900000001 R_X86_64_64            0000000000000008 xen_cpuid$e69bc59f4fade3b6f2b579b3934137df.cfi_jt + 0
>   0000000000000010  0003980900000001 R_X86_64_64            0000000000000060 machine_real_restart.cfi_jt + 0
>   0000000000000018  0003962b00000001 R_X86_64_64            0000000000000e18 kretprobe_trampoline.cfi_jt + 0
>   0000000000000020  000028f300000001 R_X86_64_64            0000000000000000 .rodata + 12
>   0000000000000028  000349f400000001 R_X86_64_64            0000000000000018 __crash_kexec.cfi_jt + 0
> 
>   0000000000000060 <machine_real_restart.cfi_jt>:
>     60: e9 00 00 00 00          jmpq   65 <machine_real_restart.cfi_jt+0x5>
>                         61: R_X86_64_PLT32      machine_real_restart-0x4
>     65: cc                      int3
>     66: cc                      int3
>     67: cc                      int3
> 
> This breaks objtool vmlinux validation in many ways, including static
> call site detection and the STACK_FRAME_NON_STANDARD() macro.
> 
> Fix it by converting those relocations' symbol references back to their
> original non-jump-table versions.  Note this doesn't change the actual
> relocations in the object itself, it just changes objtool's view of
> them. This change is based on Josh's initial patch:
> 
> https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

