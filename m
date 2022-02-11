Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8C2C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Feb 2022 08:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiBKI5R (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Feb 2022 03:57:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiBKI5R (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Feb 2022 03:57:17 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FDAF5D
        for <linux-hardening@vger.kernel.org>; Fri, 11 Feb 2022 00:57:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V48LzWx_1644569830;
Received: from 192.168.193.145(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V48LzWx_1644569830)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Feb 2022 16:57:11 +0800
Message-ID: <74fb3167-f5d7-84dd-1348-c9ea18665b58@linux.alibaba.com>
Date:   Fri, 11 Feb 2022 00:57:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] [PATCH,v4,1/1,AARCH64][PR102768] aarch64: Add compiler
 support for Shadow Call Stack
Content-Language: en-US
To:     gcc-patches@gcc.gnu.org, richard.earnshaw@arm.com,
        marcus.shawcroft@arm.com, kyrylo.tkachov@arm.com, hp@gcc.gnu.org,
        ndesaulniers@google.com, nsz@gcc.gnu.org, pageexec@gmail.com,
        qinzhao@gcc.gnu.org, linux-hardening@vger.kernel.org,
        richard.sandiford@arm.com
References: <20220205110500.47430-1-ashimida@linux.alibaba.com>
 <mpt7da481l6.fsf@arm.com>
 <93a72e23-3d67-3c46-308d-f69ec517e793@linux.alibaba.com>
 <mptzgmz3v10.fsf@arm.com>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <mptzgmz3v10.fsf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 2/10/22 01:55, Richard Sandiford wrote:
>>
>> There might be a little difference:
>>
>> - Using push candidates means that a register to be ignored in pop
>> candidates will not be emitted again during the "restore" (pop_candidates
>> should always be a subset of push_candidates, since popping a register
>> without a push might not make sense).
> 
> The push candidates are simply a subset of the saved registers though.
> Similarly, the pop candidates are simply a subset of the restored registers.
> So I think the requirement operates at that level: the restored registers
> must be a subset of the saved registers.
> 
> In other circumstances it could have been the other way around:
> there might have been a change that stopped us from saving two
> registers during the allocation, but we wanted to carry on restoring
> two registers during the deallocation.  I don't think there's a
> reason that the push candidates *have* to be a superset of the
> pop candidates (even though they are with the current change).
> 

Oh yeah, that sounds more reasonable.

>> When we use "pop_candidate[12]", one more insn is emitted:
>>
>> 0000000000400604 <main>:
>>      400604:       a9bf53f3        stp     x19, x20, [sp, #-16]!
>>      400608:       52800000        mov     w0, #0x0
>> +  40060c:       f94007f4        ldr     x20, [sp, #8]
>>      400610:       f84107f3        ldr     x19, [sp], #16
>>      400614:       d65f03c0        ret
>>
>> But in the case of ignoring a specific register (like scs ignores x30),
>> there is no difference between the two (because we always need
>> to explicitly specify which registers to ignore in the parameter of
>> aarch64_restore_callee_saves).
> 
> I think this is the correct behaviour.  If we don't want to restore
> a register at all then it should be excluded from the restore list
> somehow.  In your case you're doing that be using a limit of
> X29_REGNUM instead of X30_REGNUM.
> 

Got it, I'll use pop candidates in the next version.

> FWIW, I did wonder whether aarch64_restore_callee_saves should be
> doing the scs pop, rather than aarch64_expand_epilogue, and in an
> earlier draft of the previous review I'd asked for that.  It does
> seem conceptually cleaner, but in practice, it would probably have
> been awkward to implement.  E.g. we'd need to explicitly stop an
> LDP being formed with X30 as the second register.
> 

Well, then I think I should keep it the same here :).

> But treating scs push and scs pop as part of the register save and
> restore sequences would have one advantage: it would allow the
> scs push and scs pop to be shrink-wrapped.
> 

Sorry for my limited knowledge of shrink warping, I don't think I get
it here (I tried to find a case when compiling the kernel and some
gcc test cases but I still don't have a clue.).

I see that the bitmap of LR_REGNUM is cleared in
aarch64_get_separate_components and scs push/pop are x18 based operations.

If we handle them in aarch64_restore/save_callee_saves,
could scs push/pop be shrink-wrapped in some cases?

Thanks,
Dan
