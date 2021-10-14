Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C817EC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 11:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13F0610EA
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 11:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhJNLXt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhJNLXr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 07:23:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0AFC061570;
        Thu, 14 Oct 2021 04:21:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c7200b0e4a365e78c79f0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:b0e4:a365:e78c:79f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC2DE1EC0295;
        Thu, 14 Oct 2021 13:21:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634210499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZMyXicVPK+418sO0IkpvfxexKs54FvpkvATrHGg61HU=;
        b=I+4uzH8dHQ5I3LryUUwdKW1lHdViRHIUPN909vfyqKjQHPR8IWALQE/nvwze85e9bp45MS
        cqSN8H4Qi8pXIB6uOVzlOasS3dTeWcbDtOZ14sYZzhqMFsGfbnkOpP6/jJeruV5CGG4as3
        pa8y8z6IbPSQ/msLy5vAbtnRVoU2OHw=
Date:   Thu, 14 Oct 2021 13:21:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 09/15] x86: Use an opaque type for functions not
 callable from C
Message-ID: <YWgSwmzPFrRbMC1P@zn.tnic>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-10-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:52AM -0700, Sami Tolvanen wrote:
> The kernel has several assembly functions that are not directly callable
> from C. Use an opaque type for these function prototypes to make misuse
> harder, and to avoid the need to annotate references to these functions
> for Clang's Control-Flow Integrity (CFI).
> 
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Suggested-by: Alexander Lobakin <alobakin@pm.me>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  arch/x86/include/asm/ftrace.h         |  2 +-
>  arch/x86/include/asm/idtentry.h       | 10 +++++-----
>  arch/x86/include/asm/page_64.h        |  7 ++++---
>  arch/x86/include/asm/paravirt_types.h |  3 ++-
>  arch/x86/include/asm/processor.h      |  2 +-
>  arch/x86/include/asm/proto.h          | 25 +++++++++++++------------
>  arch/x86/include/asm/uaccess_64.h     |  9 +++------
>  arch/x86/kernel/alternative.c         |  2 +-
>  arch/x86/kernel/ftrace.c              |  2 +-
>  arch/x86/kernel/paravirt.c            |  4 ++--
>  arch/x86/kvm/emulate.c                |  4 ++--
>  arch/x86/kvm/kvm_emulate.h            |  9 ++-------
>  arch/x86/xen/enlighten_pv.c           |  6 +++---
>  arch/x86/xen/xen-ops.h                | 10 +++++-----
>  14 files changed, 45 insertions(+), 50 deletions(-)

No matter from which direction I look at it, wrapping some functions
which a crazy macro doesn't look good.

So what's the plan here?

Everytime someone adds an asm function which is not callable from C but
forgets to use that magic macro, someone from team CFI will send a patch
fixing that?

I.e., a whack-a-mole game?

If we're going to do that keep-CFI-working game, we might just as well
not do the macro but use the C code it evaluates to, so that at least it
looks ok-ish:

DECLARE_NOT_CALLED_FROM_C(int3_magic);

vs

extern const u8 int3_magic[];

(Just picked one at random).

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
