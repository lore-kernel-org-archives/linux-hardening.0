Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E25AC433B4
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 11:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168CA61186
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 11:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbhDQLiB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Apr 2021 07:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhDQLiB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Apr 2021 07:38:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD15C061574;
        Sat, 17 Apr 2021 04:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=La4K9Hxv90PEzdP4s04b75vImRFep6ZDy8BSpr4Z3TU=; b=CqzfOhgP0hN9dlahV60EMckVBX
        XYB8SJZUJ+Jjjx7wvCIyJvU66An/eIJy+4L3gsg0bSh8H17LQ11f6zLxd8mISkOEhL7PBTTbJ4eMn
        SGLkvymcS9NLU9u3ysgR/0cCjN2XVFKnfoh7K6cAaorUM/6waIRURtzhzoA8heavyPnPswGVEJ6Er
        N+oqwCwnNxNYoRGiLAsGCw9lRu4JV8JWbT+fxm1vRs6TRKGUaLuHkGg/yvKRhev31UV5mnPOJ2b2O
        vlusG1fIQIIHG+AIuePpAl358FHVGgf1g16n+OhmpDQr+BBI3w7SiIcyPwzi0WdeC1xbNdZIGVROU
        9CVkyr8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXjGO-005BXG-D2; Sat, 17 Apr 2021 11:37:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA636300212;
        Sat, 17 Apr 2021 13:37:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A53742D2112CE; Sat, 17 Apr 2021 13:37:23 +0200 (CEST)
Date:   Sat, 17 Apr 2021 13:37:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 09/15] x86/alternatives: Use C int3 selftest but disable
 KASAN
Message-ID: <YHrIc0L5AQukw525@hirez.programming.kicks-ass.net>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416203844.3803177-10-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 01:38:38PM -0700, Sami Tolvanen wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> Instead of using inline asm for the int3 selftest (which confuses the
> Clang's ThinLTO pass), this restores the C function but disables KASAN
> (and tracing for good measure) to keep the things simple and avoid
> unexpected side-effects. This attempts to keep the fix from commit
> ecc606103837 ("x86/alternatives: Fix int3_emulate_call() selftest stack
> corruption") without using inline asm.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/kernel/alternative.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 6974b5174495..669a23454c09 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -496,23 +496,10 @@ extern struct paravirt_patch_site __start_parainstructions[],
>   *
>   * See entry_{32,64}.S for more details.
>   */
> -
> -/*
> - * We define the int3_magic() function in assembly to control the calling
> - * convention such that we can 'call' it from assembly.
> - */
> -
> -extern void int3_magic(unsigned int *ptr); /* defined in asm */
> -
> -asm (
> -"	.pushsection	.init.text, \"ax\", @progbits\n"
> -"	.type		int3_magic, @function\n"
> -"int3_magic:\n"
> -"	movl	$1, (%" _ASM_ARG1 ")\n"
> -"	ret\n"
> -"	.size		int3_magic, .-int3_magic\n"
> -"	.popsection\n"
> -);
> +static void __init __no_sanitize_address notrace int3_magic(unsigned int *ptr)
> +{
> +	*ptr = 1;
> +}

I really don't like this. the compiler is free to mess this up in all
sorts of ways.

The problem is that the call-site does not respect the regular calling
convention, so calling a regular C function is just asking for trouble,
which is why it ended up being asm, then we fully control the calling
convention.
