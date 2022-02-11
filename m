Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40AEC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Feb 2022 09:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiBKJxK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:53:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiBKJxJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Feb 2022 04:53:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF9A1BBF
        for <linux-hardening@vger.kernel.org>; Fri, 11 Feb 2022 01:53:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95A4ED6E;
        Fri, 11 Feb 2022 01:53:07 -0800 (PST)
Received: from localhost (unknown [10.32.98.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB713F73B;
        Fri, 11 Feb 2022 01:53:06 -0800 (PST)
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
Date:   Fri, 11 Feb 2022 09:53:04 +0000
In-Reply-To: <74fb3167-f5d7-84dd-1348-c9ea18665b58@linux.alibaba.com> (Dan
        Li's message of "Fri, 11 Feb 2022 00:57:10 -0800")
Message-ID: <mptv8xl20hr.fsf@arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Dan Li <ashimida@linux.alibaba.com> writes:
> On 2/10/22 01:55, Richard Sandiford wrote:
>>>
>>> There might be a little difference:
>>>
>>> - Using push candidates means that a register to be ignored in pop
>>> candidates will not be emitted again during the "restore" (pop_candidates
>>> should always be a subset of push_candidates, since popping a register
>>> without a push might not make sense).
>> 
>> The push candidates are simply a subset of the saved registers though.
>> Similarly, the pop candidates are simply a subset of the restored registers.
>> So I think the requirement operates at that level: the restored registers
>> must be a subset of the saved registers.
>> 
>> In other circumstances it could have been the other way around:
>> there might have been a change that stopped us from saving two
>> registers during the allocation, but we wanted to carry on restoring
>> two registers during the deallocation.  I don't think there's a
>> reason that the push candidates *have* to be a superset of the
>> pop candidates (even though they are with the current change).
>> 
>
> Oh yeah, that sounds more reasonable.
>
>>> When we use "pop_candidate[12]", one more insn is emitted:
>>>
>>> 0000000000400604 <main>:
>>>      400604:       a9bf53f3        stp     x19, x20, [sp, #-16]!
>>>      400608:       52800000        mov     w0, #0x0
>>> +  40060c:       f94007f4        ldr     x20, [sp, #8]
>>>      400610:       f84107f3        ldr     x19, [sp], #16
>>>      400614:       d65f03c0        ret
>>>
>>> But in the case of ignoring a specific register (like scs ignores x30),
>>> there is no difference between the two (because we always need
>>> to explicitly specify which registers to ignore in the parameter of
>>> aarch64_restore_callee_saves).
>> 
>> I think this is the correct behaviour.  If we don't want to restore
>> a register at all then it should be excluded from the restore list
>> somehow.  In your case you're doing that be using a limit of
>> X29_REGNUM instead of X30_REGNUM.
>> 
>
> Got it, I'll use pop candidates in the next version.
>
>> FWIW, I did wonder whether aarch64_restore_callee_saves should be
>> doing the scs pop, rather than aarch64_expand_epilogue, and in an
>> earlier draft of the previous review I'd asked for that.  It does
>> seem conceptually cleaner, but in practice, it would probably have
>> been awkward to implement.  E.g. we'd need to explicitly stop an
>> LDP being formed with X30 as the second register.
>> 
>
> Well, then I think I should keep it the same here :).
>
>> But treating scs push and scs pop as part of the register save and
>> restore sequences would have one advantage: it would allow the
>> scs push and scs pop to be shrink-wrapped.
>> 
>
> Sorry for my limited knowledge of shrink warping, I don't think I get
> it here (I tried to find a case when compiling the kernel and some
> gcc test cases but I still don't have a clue.).
>
> I see that the bitmap of LR_REGNUM is cleared in
> aarch64_get_separate_components and scs push/pop are x18 based operations.
>
> If we handle them in aarch64_restore/save_callee_saves,
> could scs push/pop be shrink-wrapped in some cases?

Yeah, I think so.  E.g. for:

void f();
int g(int x) {
    if (x == 0)
        return 1;
    f();
    return 2;
}

shrink wrapping would allow the scs push and pop to move along with the
x30 save:

g:
        cbnz    w0, .L9
        mov     w0, 1
        ret
.L9:
        stp     x29, x30, [sp, -16]!
        mov     x29, sp
        bl      f
        mov     w0, 2
        ldp     x29, x30, [sp], 16
        ret

The idea is that aarch64_save_callee_saves would treat the scs push
as part of saving x30 (along with the normal store to the frame chain,
when used).  aarch64_restore_callee_saves would similarly treat the scs
pop as the way of restoring x30 (instead of loading from the frame chain).
This is in contrast to the current patch, where the scs push and pop are
treated as fixed parts of the prologue and epilogue instead, and where
aarch64_restore_callee_saves tries to avoid doing anything for x30.

If shrink-wrapping decides to treat x30 as a separate “component”, as it
does in the example above, then the scs push and pop would be emitted
by aarch64_process_components instead.

It would be more complex, but it would give better code.

Thanks,
Richard
