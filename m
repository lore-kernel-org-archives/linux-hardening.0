Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FUZZY_SECURITY,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2915DC433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0292C610CD
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 21:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344446AbhDPVhu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhDPVhu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 17:37:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41813C061574;
        Fri, 16 Apr 2021 14:37:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618609037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nv03/zLxr2oHatYYOW2cTappG/aWUT1vHWklwSM1ZYI=;
        b=qPprLSkW0kIBFmfAx0B3I7XdAZ51tGDJMCeDxt27wl7oCpvuISeVCcWiT+71nO9L7QGUP+
        ULPQ9Sjd9alF4/zYbkTAR5xAq0utktI7JriDncQZYr3l1Oea9P7Rfcshh5SwL7bDJ2wcfS
        CzaeqCzPUOsOm+rgc/xowSdF9Kp3Oekv2yTMhl8r5yu+V9J+A5wr2d3uaw6fR0eZltwWK2
        iW4D7ZgcBVKfUcWlT3Rnv0GiwtycAyBK677+XpcC+ji3pvtzbygqMaBt2XN5FykbHOrlQa
        whp17GStBdRh+UJM/8OaP9TBho4OU0eFpyx5TV3IDwGWt0fq/5aXFDbgEw4M5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618609037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nv03/zLxr2oHatYYOW2cTappG/aWUT1vHWklwSM1ZYI=;
        b=KhvVLh+3hJEGNrNN2QXKpQOaJ2k3XuR4bgYj1oH/lMK6TlkrZ/Kx8y0SzhCP+BtMaD+2ZU
        BUNjVhasXJU2m9DQ==
To:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 04/15] static_call: Use global functions for the self-test
In-Reply-To: <20210416203844.3803177-5-samitolvanen@google.com>
References: <20210416203844.3803177-1-samitolvanen@google.com> <20210416203844.3803177-5-samitolvanen@google.com>
Date:   Fri, 16 Apr 2021 23:37:16 +0200
Message-ID: <87v98lud0z.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16 2021 at 13:38, Sami Tolvanen wrote:

> With CONFIG_CFI_CLANG, the compiler renames static functions. This
> breaks static_call users using static functions, because the current
> implementation assumes functions have stable names by hardcoding them
> in inline assembly. Make the self-test functions global to prevent the
> compiler from renaming them.

Sorry, no.

> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/static_call.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> index 723fcc9d20db..d09f500c2d2a 100644
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -503,12 +503,12 @@ long __static_call_return0(void)
>  
>  #ifdef CONFIG_STATIC_CALL_SELFTEST
>  
> -static int func_a(int x)
> +int func_a(int x)
>  {
>  	return x+1;
>  }
>  
> -static int func_b(int x)
> +int func_b(int x)
>  {
>  	return x+2;
>  }

Did you even compile that?

Global functions without a prototype are generating warnings, but we can
ignore them just because of sekurity, right?

Aside of that polluting the global namespace with func_a/b just to work
around a tool shortcoming is beyond hillarious.

Fix the tool not the perfectly correct code.

Thanks,

        tglx
