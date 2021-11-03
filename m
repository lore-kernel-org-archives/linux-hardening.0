Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD2C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C985760FC2
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 19:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhKCTe7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Nov 2021 15:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhKCTe7 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Nov 2021 15:34:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0119D60E98;
        Wed,  3 Nov 2021 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635967942;
        bh=4qyxgIZ8GahpT4Sx5VxjvY6yAitch4aqfKANRfXfzMI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EKzUbtoGqYXQueNAw9ZofMWdyM20C6hoDsDrIihAbSiPwPBiAixcBRRgEW+61eaVs
         eDLg9Bnxx08k5drs1IIe6VTgd16lttUteHvP1KTcQz6AevIViqmgpqsd1VAkOhZVvh
         XMMPP1gjStSmb3Gn2GL9nnEIVNUMDF/qH4q9kYm+eq43WmaNB4fVS0yNtVyz2VmHud
         aPI1adU/N6rIUQhNP6WQUt9cZpbyX156mJDG7vlBM8qbQa0movjufKGwSLuNpz8oqk
         S7aoSwSj3Lf70aPD7Rd62uIqhDZuZ8ldy468agzN0Ree8DVkZy0rMxj3xsZJ9vv44x
         96etEcHyZSo3w==
Message-ID: <b996958f-eb69-c96c-b978-944ac5151e9a@kernel.org>
Date:   Wed, 3 Nov 2021 12:32:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
References: <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
 <202111021040.6570189A5@keescook>
 <90a14299-ce56-41d5-9df9-f625aae1ac70@www.fastmail.com>
 <202111021603.EDE5780FE@keescook>
 <bbde172b-2dae-fdc0-fbb5-edec6752c740@kernel.org>
 <20211103083559.GB174703@worktop.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20211103083559.GB174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11/3/21 01:35, Peter Zijlstra wrote:
> On Tue, Nov 02, 2021 at 05:20:05PM -0700, Andy Lutomirski wrote:
>> I think that's a big mistake -- any sane ENDBR-using scheme would
>> really prefer that ENDBR to be right next to the actual function body,
>> and really any scheme would benefit due to better cache locality.
> 
> Agreed, IBT/BTI want the landing pad in front of the actual function.
> 
>> But, more importantly, IMO any sane ENDBR-using scheme wants to
>> generate the indirect stub as part of code gen for the actual
>> function.
> 
> Sorta, I really want to be able to not have a landing pad for functions
> whose address is never taken. At that point it doesn't matter if it gets
> generated along with the function and then stripped/poisoned later, or
> generated later.

Stripping is conceptually straightforward even without LTO.

foo.indirect:
  ENDBR
foo:
  ...

and the linker learns (using magic function sections?) that, if 
foo.indirect is not referenced, then it should not be generated.  Or a 
very straightforward walk over all the relocations in an object to 
poison the unused .indirect entries could be done.  Making this work 
with DSOs, EXPORT_SYMBOL, etc will be somewhat nontrivial, but not 
impossible.

--Andy
