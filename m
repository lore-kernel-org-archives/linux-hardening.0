Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD3C433B4
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 16:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6C661090
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 16:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhDSQpQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Apr 2021 12:45:16 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42083 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhDSQpQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Apr 2021 12:45:16 -0400
X-Originating-IP: 73.37.121.169
Received: from Joaos-MacBook-Pro.local (c-73-37-121-169.hsd1.or.comcast.net [73.37.121.169])
        (Authenticated sender: joao@overdrivepizza.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D6517E000A;
        Mon, 19 Apr 2021 16:44:39 +0000 (UTC)
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
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
 <2812c98b-3b5a-7be5-9fd9-2a6260406a45@rasmusvillemoes.dk>
From:   Joao Moreira <joao@overdrivepizza.com>
Message-ID: <b9686477-4673-f977-bfb6-3ec4cc9e63fa@overdrivepizza.com>
Date:   Mon, 19 Apr 2021 09:45:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <2812c98b-3b5a-7be5-9fd9-2a6260406a45@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


> Why not? In particular, I'd really like somebody to answer the question
> "why not just store a cookie before each address-taken or
> external-linkage function?".
>
FWIIW, this was done before (at least twice): First with grsecurity/PaX 
RAP (https://grsecurity.net/rap_faq) then with kCFI 
(https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel-wp.pdf, 
https://github.com/kcfi/kcfi - which is no longer maintained).

At the time I worked on kCFI someone raised a concern regarding this 
cookie-based design being mutually exclusive to execute-only memories 
(XOM), what, if XOM is really relevant to someone, should be a valid 
concern.

Since design is being questioned, an x86/CET-specific third design for 
CFI was recently discussed here: 
https://www.openwall.com/lists/kernel-hardening/2021/02/11/1 -- I assume 
that, arch-dependency considered, this should be easier to integrate 
when compared to clang-cfi. Also, given that it is based on CET, this 
also has the benefit of constraining mispeculations (which is a nice 
side-effect).

Tks, Joao

