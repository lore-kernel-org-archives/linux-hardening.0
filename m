Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F5EC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Feb 2022 15:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbiBKPfG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Feb 2022 10:35:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiBKPfG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Feb 2022 10:35:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52FE221D
        for <linux-hardening@vger.kernel.org>; Fri, 11 Feb 2022 07:35:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17AA4106F;
        Fri, 11 Feb 2022 07:35:04 -0800 (PST)
Received: from localhost (unknown [10.32.98.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A54F3F718;
        Fri, 11 Feb 2022 07:35:02 -0800 (PST)
From:   Richard Sandiford <richard.sandiford@arm.com>
To:     Dan Li <ashimida@linux.alibaba.com>
Mail-Followup-To: Dan Li <ashimida@linux.alibaba.com>,gcc-patches@gcc.gnu.org,  richard.earnshaw@arm.com,  marcus.shawcroft@arm.com,  kyrylo.tkachov@arm.com,  hp@gcc.gnu.org,  ndesaulniers@google.com,  nsz@gcc.gnu.org,  pageexec@gmail.com,  qinzhao@gcc.gnu.org,  linux-hardening@vger.kernel.org, richard.sandiford@arm.com
Cc:     gcc-patches@gcc.gnu.org, richard.earnshaw@arm.com,
        marcus.shawcroft@arm.com, kyrylo.tkachov@arm.com, hp@gcc.gnu.org,
        ndesaulniers@google.com, nsz@gcc.gnu.org, pageexec@gmail.com,
        qinzhao@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [PATCH,v4,1/1,AARCH64][PR102768] aarch64: Add compiler support for Shadow Call Stack
References: <20220205110500.47430-1-ashimida@linux.alibaba.com>
        <mpt7da481l6.fsf@arm.com>
        <93a72e23-3d67-3c46-308d-f69ec517e793@linux.alibaba.com>
        <mptzgmz3v10.fsf@arm.com>
        <74fb3167-f5d7-84dd-1348-c9ea18665b58@linux.alibaba.com>
        <mptv8xl20hr.fsf@arm.com>
        <81b35033-489e-d0c0-8677-55923f6abbe0@linux.alibaba.com>
Date:   Fri, 11 Feb 2022 15:35:01 +0000
In-Reply-To: <81b35033-489e-d0c0-8677-55923f6abbe0@linux.alibaba.com> (Dan
        Li's message of "Fri, 11 Feb 2022 05:43:07 -0800")
Message-ID: <mpto83dzaai.fsf@arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Dan Li <ashimida@linux.alibaba.com> writes:
> On 2/11/22 01:53, Richard Sandiford wrote:
>> Dan Li <ashimida@linux.alibaba.com> writes:
>>> On 2/10/22 01:55, Richard Sandiford wrote:
>>>>>
>>>> But treating scs push and scs pop as part of the register save and
>>>> restore sequences would have one advantage: it would allow the
>>>> scs push and scs pop to be shrink-wrapped.
>>>>
>>>
>>> Sorry for my limited knowledge of shrink warping, I don't think I get
>>> it here (I tried to find a case when compiling the kernel and some
>>> gcc test cases but I still don't have a clue.).
>>>
>>> I see that the bitmap of LR_REGNUM is cleared in
>>> aarch64_get_separate_components and scs push/pop are x18 based operations.
>>>
>>> If we handle them in aarch64_restore/save_callee_saves,
>>> could scs push/pop be shrink-wrapped in some cases?
>> 
>> Yeah, I think so.  E.g. for:
>> 
>> void f();
>> int g(int x) {
>>      if (x == 0)
>>          return 1;
>>      f();
>>      return 2;
>> }
>> 
>> shrink wrapping would allow the scs push and pop to move along with the
>> x30 save:
>> 
>> g:
>>          cbnz    w0, .L9
>>          mov     w0, 1
>>          ret
>> .L9:
>>          stp     x29, x30, [sp, -16]!
>>          mov     x29, sp
>>          bl      f
>>          mov     w0, 2
>>          ldp     x29, x30, [sp], 16
>>          ret
>> 
>
> Thanks Richard, (to make sure I understand correctly :)) I think
> it means that the current patch could do a "shrink-wapping", but
> the X30 could not be treat as a "component", now it could gen code
> like:
>
> g:
>          cbnz    w0, .L9
>          mov     w0, 1
>          ret
> .L9:
>          str     x30, [x18], 8
>          stp     x29, x30, [sp, -16]!
>          mov     x29, sp
>          bl      f
>          ldr     x30, [x18, -8]!
>          mov     w0, 2
>          ldr     x29, [sp], 16
>          ret

Ah, right, sorry.  I'd forgotten that this happened independently
of the components stuff (and has to, since like you say, we don't
treat LR_REGNUM as a separable component).

>> The idea is that aarch64_save_callee_saves would treat the scs push
>> as part of saving x30 (along with the normal store to the frame chain,
>> when used).  aarch64_restore_callee_saves would similarly treat the scs
>> pop as the way of restoring x30 (instead of loading from the frame chain).
>> This is in contrast to the current patch, where the scs push and pop are
>> treated as fixed parts of the prologue and epilogue instead, and where
>> aarch64_restore_callee_saves tries to avoid doing anything for x30.
>> 
>> If shrink-wrapping decides to treat x30 as a separate “component”, as it
>> does in the example above, then the scs push and pop would be emitted
>> by aarch64_process_components instead.
>> 
>> It would be more complex, but it would give better code.
>> 
>
> Following your idea, I made a poc to add x30 in component bitmap:
>
> diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.cc
> index 35f6f64f5b2..fc9b5e7af54 100644
> --- a/gcc/config/aarch64/aarch64.cc
> +++ b/gcc/config/aarch64/aarch64.cc
> @@ -8359,7 +8359,7 @@ aarch64_get_separate_components (void)
>     if (reg1 != INVALID_REGNUM)
>       bitmap_clear_bit (components, reg1);
>   
> -  bitmap_clear_bit (components, LR_REGNUM);
>     bitmap_clear_bit (components, SP_REGNUM);
>   
>     return components;
> @@ -8396,7 +8396,7 @@ aarch64_components_for_bb (basic_block bb)
>     /* GPRs are used in a bb if they are in the IN, GEN, or KILL sets.  */
>     for (unsigned regno = 0; regno <= LAST_SAVED_REGNUM; regno++)
>       if (!fixed_regs[regno]
> -       && !crtl->abi->clobbers_full_reg_p (regno)
> +       && (!crtl->abi->clobbers_full_reg_p (regno) || regno == R30_REGNUM)
>          && (TEST_HARD_REG_BIT (extra_caller_saves, regno)
>              || bitmap_bit_p (in, regno)
>              || bitmap_bit_p (gen, regno)
>
> And with a test code compiled with -fno-omit-frame-pointer:
>
> void f();
> int g(int x) {
>      if (x == 0) {
>          __asm__ ("":::"x19", "x20");
>          return 1;
>      }
>      f();
>      return 2;
> }
>
> Then it seems X30 is treat as a "component" (the test
> result of aarch64.exp also seems fine).
>
> g:
>          stp     x19, x20, [sp, -32]!
>          cbnz    w0, .L2
>          mov     w0, 1
>          ldp     x19, x20, [sp], 32
>          ret
> .L2:
>          str     x30, [sp, 16]
>          bl      f
>          ldr     x30, [sp, 16]
>          mov     w0, 2
>          ldp     x19, x20, [sp], 32
>          ret
>
> And I think maybe we could handle this through three patches:
> 1.Keep current patch (a V5) unchanged for scs.
> 2.Add shrink-warpping for X30:
> logically this might be a separate topic, and I think more testing
> might be needed here (Well, I'm a little worried about if there might
> be other effects, since I just read this part of the code roughly
> yesterday).
> 3.Add scs push/pop to shrink-wrapping (and maybe we can do the same for
> the PAC code in pro/epilogue, since it's also the operation of the X30).

Yeah, that's fair.

(Like I said earlier, I wasn't asking for the shrink-wrapping change.
It was just a note in passing.  But as you point out, the individual
shrink-wrapping support would be even more work than I'd imagined.)

Thanks,
Richard
