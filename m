Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E29BC433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 00:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C2860E8C
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 00:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhKCAWo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 20:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhKCAWn (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 20:22:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88466603E7;
        Wed,  3 Nov 2021 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635898808;
        bh=GQPsQyPs6Mu5jryMUJKqTVsYjo/EX8JiP4ABFefK08M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fuhvprYZDZZQ6o791EkmHyiJT3uLXWMjc7tc4Mnu6Bj4fPQwB2NZs1zXDh4XGjTxr
         0O1uD7JGAkIQIYAvrkxYF0oj7Ju3k4jeyaGAIWb2ON7SogfhwFSRWLN5H1w/B38AbG
         dlVqKOSSMomU+SN9qKVd75BA4LRXKuHAl/KvUIntCc11kEb3Y/m4WdT5jSWI+lLY92
         gF7tiYHVDzn/Exdb3XYg0hSFZFz9ag1qIOEpfZZh0bGSpgELGdqud7jD4E5WtPsUmW
         3WA18EZrMi+SNULyPDVgs2i+MEh3ZvtvbKS0jfXIXmcimYB6fHyNs1LKOCDukuuaFw
         s/mhEv2gL6R/A==
Message-ID: <bbde172b-2dae-fdc0-fbb5-edec6752c740@kernel.org>
Date:   Tue, 2 Nov 2021 17:20:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
References: <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
 <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
 <202111021040.6570189A5@keescook>
 <90a14299-ce56-41d5-9df9-f625aae1ac70@www.fastmail.com>
 <202111021603.EDE5780FE@keescook>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <202111021603.EDE5780FE@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11/2/21 16:13, Kees Cook wrote:
> On Tue, Nov 02, 2021 at 02:02:38PM -0700, Andy Lutomirski wrote:
>>
>>
>> On Tue, Nov 2, 2021, at 11:10 AM, Kees Cook wrote:
>>> On Tue, Nov 02, 2021 at 01:57:44PM +0100, Peter Zijlstra wrote:
>>>> On Mon, Nov 01, 2021 at 03:14:41PM +0100, Ard Biesheuvel wrote:
>>>>> On Mon, 1 Nov 2021 at 10:05, Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>>>> How is that not true for the jump table approach? Like I showed earlier,
>>>>>> it is *trivial* to reconstruct the actual function pointer from a
>>>>>> jump-table entry pointer.
>>>>>>
>>>>>
>>>>> That is not the point. The point is that Clang instruments every
>>>>> indirect call that it emits, to check whether the type of the jump
>>>>> table entry it is about to call matches the type of the caller. IOW,
>>>>> the indirect calls can only branch into jump tables, and all jump
>>>>> table entries in a table each branch to the start of some function of
>>>>> the same type.
>>>>>
>>>>> So the only thing you could achieve by adding or subtracting a
>>>>> constant value from the indirect call address is either calling
>>>>> another function of the same type (if you are hitting another entry in
>>>>> the same table), or failing the CFI type check.
>>>>
>>>> Ah, I see, so the call-site needs to have a branch around the indirect
>>>> call instruction.
>>>>
>>>>> Instrumenting the callee only needs something like BTI, and a
>>>>> consistent use of the landing pads to ensure that you cannot trivially
>>>>> omit the check by landing right after it.
>>>>
>>>> That does bring up another point tho; how are we going to do a kernel
>>>> that's optimal for both software CFI and hardware aided CFI?
>>>>
>>>> All questions that need answering I think.
>>>
>>> I'm totally fine with designing a new CFI for a future option,
>>> but blocking the existing (working) one does not best serve our end
>>> users.
>>
>> I like security, but I also like building working systems, and I think
>> I disagree with you. There are a whole bunch of CFI schemes out there,
>> with varying hardware requirements, and they provide varying degrees
>> of fine grained protection and varying degrees of protection against
>> improper speculation.  We do not want to merge clang CFI just because
>> it’s “ready” and end up with a mess that makes it harder to support
>> other schemes in the kernel.
> 
> Right, and I see the difficulties here. And speaking to Peter's
> observation that CFI "accidentally" worked with static_calls, I don't
> see it that way: it worked because it was designed to be as "invisible"
> as possible. It's just that at a certain point of extreme binary output
> control, it becomes an issue and I think that's going to be true for
> *any* CFI system: they each will have different design characteristics.
> 
> One of the goals of the Clang CFI use in Linux was to make it as
> minimally invasive as possible (and you can see this guiding Sami's
> choices: e.g. he didn't go change all the opaque address uses to need a
> "&" prefix added, etc). I think we're always going to have some
> push/pull between the compiler's "general"ness and the kernel's
> "specific"ness.

The "&" thing was the wrong way around.  That part of CFI was Linux 
being sloppy, and the & part is a straight-up improvement.  Improvements 
can be invasive.  The problem with invasive code is when it invades 
places it doesn't belong.

> 
>> So, yes, a good CFI scheme needs caller-side protection, especially if
>> IBT isn’t in use.  But a good CFI scheme also needs to interoperate with
>> the rest of the kernel, and this whole “canonical” and symbol-based
>> lookup and static_call thing is nonsense.  I think we need a better
>> implementation, whether it uses intrinsics or little C helpers or
>> whatever.
> 
> I think we're very close already. Like I said, I think it's fine to nail
> down some of these interoperability requirements; we've been doing it
> all along. We got there with arm64, and it looks to me like we're almost
> there on x86. There is this particular case with static_calls now, but I
> don't think it's insurmountable.

So fundamentally, I think there's a sort of type system issue here, and 
it's more or less the same issue with IBT and with various fine-grained 
refinements to IBT.  Using syntax more or like what's been floating 
around this thread, the asm works like this:

[possible magic here depending on the precise scheme]
func.indirect:
  ENDBR (if it's an IBT build)
  [magic here?]

  [in a jump table scheme, there's a jmp here and possibly a large or 
negative gap.]

func:
  actual body

The point being that there's the actual function body (where one should 
*direct* jump to) and there's the address that goes in a C function 
pointer.  Indirect calls/jumps go to (or pretend to go to, depending on 
the scheme) func.indirect.

While one can plausibly kludge up the static call patching (and who 
knows what else -- eBPF, kprobes, mcount stuff, etc) using symbol-based 
hackery, I think we actually just want a way to convert from a function 
pointer to a function address.  It doesn't need to be fast, but it needs 
to work.  And I think this can probably be mostly done in plain C based 
on clang's implementation.  Ideally it would have a typecheck:

unsigned long __cfi_decode_funcpointer(funcptr type);

but that's not happening in plain C because I don't think there's a way 
to get the magic metadata.  But I bet we could do:

unsigned long __cfi_decode_funcpointer(funcptr val, funcptr ref)
{
   BUG_ON(ref and val aren't the same type);
   read insn bytes at val;
   return the jump target;
}

If this won't work with current clang, let's ask to get whatever basic 
functionality is needed to enable it.

<rambling>

Sadly, in clang, this is wrapped up in the incomprehensible "canonical" 
stuff.  I think that's a big mistake -- any sane ENDBR-using scheme 
would really prefer that ENDBR to be right next to the actual function 
body, and really any scheme would benefit due to better cache locality. 
But, more importantly, IMO any sane ENDBR-using scheme wants to generate 
the indirect stub as part of code gen for the actual function.  In an 
IBT build, this really doesn't deserve to work:

non-IBT C file generating:

func:
   ret

IBT-aware C file:

extern void func(void);
ptr = func;

clang has horrible magic to generate the indirect stub in the caller 
translation unit, and I think that's solving a problem that doesn't 
really need solving.  Sure, it's nifty, but it IMO should be opt-in, at 
least in a world where everyone agrees to recompile for CFI.  (Sure, 
using that hack for userspace IBT would be cute, and it would work.)

There's another tradeoff, though: errors like this are possible:

translation unit A:
void func(int)
{
   [body here]
}

translation unit B:
extern void func(char); /* wrong signature! */
ptr = func;
ptr();

The callee-generates-the-stub model will not catch this.  The 
caller-generates-the-stub model will.

> 
> Sure, and this is the kind of thing I mean: we had an awkward
> implementation of a meaningful defense, and we improved on it. I think
> it's important to be able to make these kinds of concessions to gain the
> defensive features they provide. And yes, we can continue to improve it,
> but in the meantime, we can stop entire classes of problems from
> happening to our user base.
> 

In retrospect, we should have put our feet down with stack protector, 
though.  The problem with it was gcc hardcoding things that shouldn't 
have been hardcoded, and the gcc fixes were trivial.
