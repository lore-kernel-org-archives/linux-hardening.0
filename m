Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDB4C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39527610EA
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbhJMTBn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhJMTBm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 15:01:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA21C061570
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:59:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso5129058pjb.4
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qj4yoXj84IRKk7/nf4e2eKvIgvpjVM9Pr9U6MnkUbTk=;
        b=ROMAFyAiaegRPNxvn6lw08bPhdK2CC2YyiL4itwXKf1zAqtQTgRl9xTD7VjhsWyTcs
         n7Ee+kFsNrVfz120Blb6FxF1EhXFHmr4bQBnPO3xpGEAx4KUtW1ziFZ0qb8dqlPcwBWf
         d7yu1MZtw707DrgY8W44E6sSjxm4Tn09kjoyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qj4yoXj84IRKk7/nf4e2eKvIgvpjVM9Pr9U6MnkUbTk=;
        b=RQwyrNKHq2PDqQYH14YezFE0Sobde2zzI9kHiOSd04hdTyrvAnJZUXiQzx1ApPVpih
         EBplVOcE/tQr3/FUYSiQjCv1bfoLHjB/Xfb+BKGTZvOazNTNL6yUo0klPEtwgk0BrDeb
         Hp2VhroIjMuLoCPP+F4S1wTN4PTh0OY9JcSOYfZa2cQk09oSl5N0sOBv904C9mBoEl+i
         P90xKLl7iBCzTKJbaKAlsbzCFdFTu7qBiOfW/a8KstAJsTk9HsAHgtFTZaaRbBg6tzc3
         XjQaG96NlBtCkMwzLDZrYQfoOikmABKVFRzYSfTq1v6VkGhswaRsIfELSOWieIF5mmKq
         +Qag==
X-Gm-Message-State: AOAM530poZUqapYtGmIz3NamwC3w8igBx+qP7tZBmx0apHp8uQfClM+/
        Ws0tR9ZWrzWKICpKRIw3LQZMTQ==
X-Google-Smtp-Source: ABdhPJwMISMHCF+f5bLo1J1PLUpV/7yge+pmOsAtKjj8YB2y/+4vkaBCcstms8mr6zXzfQeSOSjHLw==
X-Received: by 2002:a17:902:d485:b0:13f:2212:d631 with SMTP id c5-20020a170902d48500b0013f2212d631mr913262plg.44.1634151578699;
        Wed, 13 Oct 2021 11:59:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pi9sm252945pjb.31.2021.10.13.11.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:59:38 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:59:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 01/15] objtool: Add CONFIG_CFI_CLANG support
Message-ID: <202110131159.DA32533@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-2-samitolvanen@google.com>
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

This looks really clean. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
