Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA87C433B4
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 08:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E6D61107
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 08:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhDSIko (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Apr 2021 04:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhDSIkn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Apr 2021 04:40:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB99C061760
        for <linux-hardening@vger.kernel.org>; Mon, 19 Apr 2021 01:40:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id bx20so38499430edb.12
        for <linux-hardening@vger.kernel.org>; Mon, 19 Apr 2021 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2y82BOAFsYacLRhgXdKaCVbYWGAg9sRe0z+BWidh9M8=;
        b=RuAKp33JwqA4uUuvSOxz5bzndUVRHVm28Evd6lhy4OS8gYEFa07ke/qKYY6oELuHDc
         Hu6aORWYDRm5ZPS6jKNYIFuWCwuno1B7q1obZwbGdLV846soI0Reid0v2uwvVfXtigTB
         StB8XGea3ax1CIhGwCYmKQcY3kOJwe0jKtfCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2y82BOAFsYacLRhgXdKaCVbYWGAg9sRe0z+BWidh9M8=;
        b=J++YL2at839T8HYsZ6X4oBxGW4Vj1RWMmt0JRNUE17Te9grgAHGa8SBNQcInXI0kJw
         ureYciTZiixg7p+yjccNcf/MTU2kJ/LvYXs0j8CJyXm9Drbbq6ZBkTDYzr58u2IpKOb1
         31u6V5r9J7mXOOC9sHiisGSk9FXFIxO/dCosjnZMdGyo8kiZnCl3/l8SA9MdghoUvvTa
         kp9g3z0F3Psm4qXbrw8k6RXFJesFyytadBkCt4g1Kr3KPrRSp3Morgjeog8VHiCIpNj5
         c4VtmPhyWlSjXrpKaQd9oUVeZI6NN838RwZ/YlUq8V5pqLGu06fVMPFkUi74h8PvB3XH
         o2NA==
X-Gm-Message-State: AOAM533JDlMnBal8qqFarVUPs3K+UV1cVK9oCaglcIKY7aQI6o0B1QNQ
        IDKh5EMu+/QpvLvDYmxqpnrCwA==
X-Google-Smtp-Source: ABdhPJxs44vPkGIH9EacQU3mJFMXHnnfTHgbSde2kzcZShH9lzWk8kMkx2nFwBpxfQbgb7z0G0ROUg==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr5493822edd.258.1618821611041;
        Mon, 19 Apr 2021 01:40:11 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id gz10sm5353737ejc.25.2021.04.19.01.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 01:40:10 -0700 (PDT)
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
 <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2812c98b-3b5a-7be5-9fd9-2a6260406a45@rasmusvillemoes.dk>
Date:   Mon, 19 Apr 2021 10:40:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <202104161519.1D37B6D26@keescook>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 17/04/2021 00.28, Kees Cook wrote:
> On Fri, Apr 16, 2021 at 03:06:17PM -0700, Andy Lutomirski wrote:

>> The
>> foo symbol would point to whatever magic is needed.
> 
> No, the symbol points to the jump table entry. Direct calls get minimal
> overhead and indirect calls can add the "is this function in the right
> table" checking.
> 
> 
> But note that this shouldn't turn into a discussion of "maybe Clang could
> do CFI differently"; this is what Clang has.

Why not? In particular, I'd really like somebody to answer the question
"why not just store a cookie before each address-taken or
external-linkage function?".

(1) direct calls get _no_ overhead, not just "minimal".
(2) address comparison, intra- or inter-module, Just Works, no need to
disable one sanity check to get others.
(3) The overhead and implementation of the signature check is the same
for inter- and intra- module calls.
(4) passing (unsigned long)sym into asm code or stashing it in a table
Just Works.

How much code would be needed on the clang side to provide a
--cfi-mode=inline ?

The only issue, AFAICT, which is also a problem being handled in the
current proposal, is indirect calls to asm code from C. They either have
to be instrumented to not do any checking (which requires callers to
know that the pointer they have might point to an asm-implementation),
or the asm code could be taught to emit those cookies as well - which
would provide even better coverage. Something like

CFI_COOKIE(foo)
foo:
  ...

with CFI_COOKIE expanding to nothing when !CONFIG_CFI, and otherwise to
(something like) ".quad cfi_cookie__foo" ; with some appropriate Kbuild
and compiler magic to generate a table of cfi_cookie__* defines from a
header file with the prototypes.

Rasmus
