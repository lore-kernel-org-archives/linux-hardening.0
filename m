Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A861C433F5
	for <linux-hardening@archiver.kernel.org>; Sat,  5 Feb 2022 11:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbiBELNu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 5 Feb 2022 06:13:50 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57319 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236239AbiBELNu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 5 Feb 2022 06:13:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V3d0KqT_1644059627;
Received: from 192.168.193.142(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V3d0KqT_1644059627)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Feb 2022 19:13:48 +0800
Message-ID: <0d3b7c57-5ad7-8870-a4b6-0207430f7433@linux.alibaba.com>
Date:   Sat, 5 Feb 2022 03:13:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] [PATCH,v3,1/1,AARCH64][PR102768] aarch64: Add compiler
 support for Shadow Call Stack
Content-Language: en-US
To:     gcc-patches@gcc.gnu.org, richard.earnshaw@arm.com,
        marcus.shawcroft@arm.com, kyrylo.tkachov@arm.com, hp@gcc.gnu.org,
        ndesaulniers@google.com, nsz@gcc.gnu.org, pageexec@gmail.com,
        qinzhao@gcc.gnu.org, linux-hardening@vger.kernel.org,
        richard.sandiford@arm.com
References: <20220129150035.114602-1-ashimida@linux.alibaba.com>
 <mptwnifkfhr.fsf@arm.com>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <mptwnifkfhr.fsf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi, Richard,
I have sent out my v4[1], please let me know if i got something wrong :).

[1] https://gcc.gnu.org/pipermail/gcc-patches/2022-February/589921.html

Thanks,
Dan.


On 1/31/22 09:00, Richard Sandiford wrote:
> Dan Li <ashimida@linux.alibaba.com> writes:
>> Shadow Call Stack can be used to protect the return address of a
>> function at runtime, and clang already supports this feature[1].
>>
>> To enable SCS in user mode, in addition to compiler, other support
>> is also required (as discussed in [2]). This patch only adds basic
>> support for SCS from the compiler side, and provides convenience
>> for users to enable SCS.
>>
>> For linux kernel, only the support of the compiler is required.
>>
>> [1] https://clang.llvm.org/docs/ShadowCallStack.html
>> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768
>>
>> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
>>
>> gcc/ChangeLog:
>>
>> 	* config/aarch64/aarch64.c (aarch64_layout_frame):
>> 	Change callee_adjust when scs is enabled.
>> 	(aarch64_restore_callee_saves): Avoid pop x30 twice
>> 	when scs is enabled.
>> 	(aarch64_expand_prologue): Push x30 onto SCS before it's
>> 	pushed onto stack.
>> 	(aarch64_expand_epilogue): Pop x30 frome SCS, while
>> 	preventing it from being popped from the regular stack again.
>> 	(aarch64_override_options_internal): Add SCS compile option check.
>> 	(TARGET_HAVE_SHADOW_CALL_STACK): New hook.
>> 	* config/aarch64/aarch64.h (struct GTY): Add is_scs_enabled.
>> 	* config/aarch64/aarch64.md (scs_push):  New template.
>> 	(scs_pop): Likewise.
>> 	* doc/invoke.texi: Document -fsanitize=shadow-call-stack.
>> 	* doc/tm.texi: Regenerate.
>> 	* doc/tm.texi.in: Add hook have_shadow_call_stack.
>> 	* flag-types.h (enum sanitize_code):
>> 	Add SANITIZE_SHADOW_CALL_STACK.
>> 	* opts.c: Add shadow-call-stack.
>> 	* target.def: New hook.
>> 	* toplev.c (process_options): Add SCS compile option check.
>>
>> gcc/testsuite/ChangeLog:
>>
>> 	* gcc.target/aarch64/shadow_call_stack_1.c: New test.
>> 	* gcc.target/aarch64/shadow_call_stack_2.c: New test.
>> 	* gcc.target/aarch64/shadow_call_stack_3.c: New test.
>> 	* gcc.target/aarch64/shadow_call_stack_4.c: New test.
>> 	* gcc.target/aarch64/shadow_call_stack_5.c: New test.
>> 	* gcc.target/aarch64/shadow_call_stack_6.c: New test.
>> 	* gcc.target/aarch64/shadow_call_stack_7.c: New test.
>> 	* gcc.target/aarch64/shadow_call_stack_8.c: New test.
>> ---
>> V3:
>> - Change scs_push/pop to standard move patterns.
>> - Optimize scs_pop to avoid pop x30 twice when shadow stack is enabled.
>>
>>   gcc/config/aarch64/aarch64.c                  | 66 +++++++++++++++++--
>>   gcc/config/aarch64/aarch64.h                  |  4 ++
>>   gcc/config/aarch64/aarch64.md                 | 10 +++
>>   gcc/doc/invoke.texi                           | 30 +++++++++
>>   gcc/doc/tm.texi                               |  5 ++
>>   gcc/doc/tm.texi.in                            |  2 +
>>   gcc/flag-types.h                              |  2 +
>>   gcc/opts.c                                    |  1 +
>>   gcc/target.def                                |  8 +++
>>   .../gcc.target/aarch64/shadow_call_stack_1.c  |  6 ++
>>   .../gcc.target/aarch64/shadow_call_stack_2.c  |  6 ++
>>   .../gcc.target/aarch64/shadow_call_stack_3.c  | 45 +++++++++++++
>>   .../gcc.target/aarch64/shadow_call_stack_4.c  | 20 ++++++
>>   .../gcc.target/aarch64/shadow_call_stack_5.c  | 18 +++++
>>   .../gcc.target/aarch64/shadow_call_stack_6.c  | 18 +++++
>>   .../gcc.target/aarch64/shadow_call_stack_7.c  | 18 +++++
>>   .../gcc.target/aarch64/shadow_call_stack_8.c  | 24 +++++++
>>   gcc/toplev.c                                  | 10 +++
>>   18 files changed, 289 insertions(+), 4 deletions(-)
>>   create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_1.c
>>   create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_2.c
>>   create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_3.c
>>   create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_4.c
>>   create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_5.c
>>   create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_6.c
>>   create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_7.c
>>   create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_8.c
>>
>> diff --git a/gcc/config/aarch64/aarch64.c b/gcc/config/aarch64/aarch64.c
>> index 699c105a42a..461c205010e 100644
>> --- a/gcc/config/aarch64/aarch64.c
>> +++ b/gcc/config/aarch64/aarch64.c
>> @@ -79,6 +79,7 @@
>>   #include "tree-ssa-loop-niter.h"
>>   #include "fractional-cost.h"
>>   #include "rtlanal.h"
>> +#include "asan.h"
>>   
>>   /* This file should be included last.  */
>>   #include "target-def.h"
>> @@ -7478,10 +7479,31 @@ aarch64_layout_frame (void)
>>     frame.sve_callee_adjust = 0;
>>     frame.callee_offset = 0;
>>   
>> +  /* Shadow call stack only deal with functions where the LR is pushed
> 
> Typo: s/deal/deals/
> 
>> +     onto the stack and without specifying the "no_sanitize" attribute
>> +     with the argument "shadow-call-stack".  */
>> +  frame.is_scs_enabled
>> +    = (!crtl->calls_eh_return
>> +       && (sanitize_flags_p (SANITIZE_SHADOW_CALL_STACK)
>> +	   && known_ge (cfun->machine->frame.reg_offset[LR_REGNUM], 0)));
> 
> Nit, but normal GCC style would be to use a single chain of &&s here:
> 
>    frame.is_scs_enabled
>      = (!crtl->calls_eh_return
>         && sanitize_flags_p (SANITIZE_SHADOW_CALL_STACK)
>         && known_ge (cfun->machine->frame.reg_offset[LR_REGNUM], 0));
> 
>> +
>> +  /* When shadow call stack is enabled, the scs_pop in the epilogue will
>> +     restore x30, and we don't need to pop x30 again in the traditional
>> +     way.  At this time, if candidate2 is x30, we need to adjust
>> +     max_push_offset to 256 to ensure that the offset meets the requirements
>> +     of emit_move_insn.  Similarly, if candidate1 is x30, we need to set
>> +     max_push_offset to 0, because x30 is not popped up at this time, so
>> +     callee_adjust cannot be adjusted.  */
>>     HOST_WIDE_INT max_push_offset = 0;
>>     if (frame.wb_candidate2 != INVALID_REGNUM)
>> -    max_push_offset = 512;
>> -  else if (frame.wb_candidate1 != INVALID_REGNUM)
>> +    {
>> +      if (frame.is_scs_enabled && frame.wb_candidate2 == R30_REGNUM)
>> +	max_push_offset = 256;
>> +      else
>> +	max_push_offset = 512;
>> +    }
>> +  else if ((frame.wb_candidate1 != INVALID_REGNUM)
>> +	   && !(frame.is_scs_enabled && frame.wb_candidate1 == R30_REGNUM))
>>       max_push_offset = 256;
>>     HOST_WIDE_INT const_size, const_outgoing_args_size, const_fp_offset;
> 
> Maybe we should instead add separate fields for wb_push_candidate[12] and
> wb_pop_candidate[12].  The pop candidates would start out the same as the
> push candidates, but R30_REGNUM would get replaced with INVALID_REGNUM
> for SCS.
> 
> Admittedly, suppressing the restore of x30 is turning out to be a bit
> more difficult than I'd realised :-/
> 
>> […]
>> diff --git a/gcc/config/aarch64/aarch64.h b/gcc/config/aarch64/aarch64.h
>> index 2792bb29adb..1610a4fd74c 100644
>> --- a/gcc/config/aarch64/aarch64.h
>> +++ b/gcc/config/aarch64/aarch64.h
>> @@ -916,6 +916,10 @@ struct GTY (()) aarch64_frame
>>     unsigned spare_pred_reg;
>>   
>>     bool laid_out;
>> +
>> +  /* Nonzero if shadow call stack should be enabled for the current
>> +     function, otherwise return FALSE.  */
> 
> “True” seems better than “Nonzero” given that this is a bool.
> (A lot of GCC bools were originally ints, which is why “nonzero”
> still appears in non-obvious places.)
> 
> I think we can just drop “otherwise return FALSE”: “return” doesn't
> seem appropriate here, given that it's a variable.
> 
> Looks great otherwise.  Thanks especially for testing the corner cases. :-)
> 
> One minor thing:
> 
>> +/* { dg-final { scan-assembler-times "str\tx30, \\\[x18\\\], \[#|$\]?8" 2 } } */
>> +/* { dg-final { scan-assembler-times "ldr\tx30, \\\[x18, \[#|$\]?-8\\\]!" 2 } } */
> 
> This sort of regexp can be easier to write if you quote them using {…}
> rather than "…", since it reduces the number of backslashes needed.  E.g.:
> 
> /* { dg-final { scan-assembler-times {str\tx30, \[x18\], [#|$]?8} 2 } } */
> 
> The current version is fine too though, and is widely used.  Just mentioning
> it in case it's useful in future.
> 
> Also, [#|$]? can be written #?.
> 
> Thanks,
> Richard
