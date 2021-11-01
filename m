Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55145C433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Nov 2021 04:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258D260F58
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Nov 2021 04:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhKAEPq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 1 Nov 2021 00:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhKAEPp (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 1 Nov 2021 00:15:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 874AD60F42;
        Mon,  1 Nov 2021 04:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635739993;
        bh=0BMauydun07VUHBfppEAm9liWhcn35fYhHewEBEWgyM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lLr74RHwTFtswjyT9L6rLQbGs+iYLRvETT8Afe71d57bPxFm7BLiywyiPW9l3DmOF
         GtkdfN0Okv0F27y2fQI2gAqDwAHivjMq9wSSwRjpKrd0XqKkrZxBbMFcA2YoprG67m
         tPCG3AdDjavKn/xFt7QaABhWFgwTU2AH+SjqEIQSdp6/ISqZQl/pkNw5hFjfSANs6L
         JDXb858cc+KtqDNReGLOFrkdYlqPNUNb+7a/1+qMy4yLIX7JMgMpKee+ZmNXU50xSj
         G5gnx3yYb2x5vISJIyD7+JCpeeOcNQBOGBI3Epgo9pp/tINHbgSM9evcUvFAOqsGLj
         MsVaRQUJJenvw==
Message-ID: <336d1626-19dc-6ac9-b422-9517f65892df@kernel.org>
Date:   Sun, 31 Oct 2021 21:13:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <202110270939.F5C79CC@keescook>
 <YXnC1jqwR2ZKfMdk@hirez.programming.kicks-ass.net>
 <202110271430.2A3980217@keescook>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <202110271430.2A3980217@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 10/27/21 15:27, Kees Cook wrote:
> On Wed, Oct 27, 2021 at 11:21:26PM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 27, 2021 at 10:11:28AM -0700, Kees Cook wrote:
>>> On Wed, Oct 27, 2021 at 03:04:55PM +0200, Peter Zijlstra wrote:
>>>> [...]
>>>> cold_function()
>>>> {
>>>> 	...
>>>> 	global_foo->func1(args1);
>>>> 	...
>>>> }
>>>
>>> If global_foo is non-const, then the static call stuff is just an
>>> obfuscated indirect call.
>>
>> It is not. The target is determined once, at boot time, depending on the
>> hardware, it then never changes. The static_call() results in a direct
>> call to that function.
> 
> Right, I mean it is _effectively_ an indirect call in the sense that the
> call destination is under the control of a writable memory location.
> Yes, static_call_update() must be called to make the change, hence why I
> didn't wave my arms around when static_call was originally added. It's a
> net benefit for the kernel: actual indirect calls now become updatable
> direct calls. This means reachability becomes much harder for attackers;
> I'm totally a fan. :)

I think this means that function_nocfi() is the wrong abstraction.  To 
solve this properly, we want (sorry for fake C++ concept-ish syntax, but 
this would be a builtin):

template<function_pointer T> uintptr_t cfi_check_get_raw_address(T ptr);

You pass in a function pointer and you get out the address of the actual 
function body.  And this *also* emits the same type checking code that 
an actual call would emit.  So:

void (*ptr)(void);

ptr();

and:

void (*ptr)(void);

asm volatile ("call *%0" :: "rmi" (cfi_check_get_raw_address(ptr)));

would emit comparably safe code, except that the latter would actually 
read the code bytes and the latter is missing clobbers and such.  And 
yes, this means that, without special support, the jump table can't live 
in XO memory.

void foo(void);
int (*ptr)(void) = (void *)foo;
cfi_check_get_raw_address(ptr);

would crash due to a CFI violation.

For what it's worth, I feel fairly strongly that we should not merge 
half-baked CFI support.  Years ago, we merged half-baked stack protector 
support in which we shoehorned in a totally inappropriate x86_32 gcc 
implementation into the kernel, and the result was a mess.  It's 
*finally* cleaned up, and that only happened because we got gcc to add 
the actual required support, then we waited a while, and then we dropped 
stack protector support for old gcc versions.  Yuck.

