Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B6C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 09:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiBJJz5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:55:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiBJJz5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Feb 2022 04:55:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40FB9B08
        for <linux-hardening@vger.kernel.org>; Thu, 10 Feb 2022 01:55:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09B0D11D4;
        Thu, 10 Feb 2022 01:55:58 -0800 (PST)
Received: from localhost (unknown [10.32.98.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 893693F718;
        Thu, 10 Feb 2022 01:55:56 -0800 (PST)
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
Date:   Thu, 10 Feb 2022 09:55:55 +0000
In-Reply-To: <93a72e23-3d67-3c46-308d-f69ec517e793@linux.alibaba.com> (Dan
        Li's message of "Wed, 9 Feb 2022 19:06:20 -0800")
Message-ID: <mptzgmz3v10.fsf@arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Dan Li <ashimida@linux.alibaba.com> writes:
> On 2/9/22 08:08, Richard Sandiford wrote:
>> Dan Li <ashimida@linux.alibaba.com> writes:
>>> +
>>> +  /* When shadow call stack is enabled, the scs_pop in the epilogue will
>>> +     restore x30, and we don't need to pop x30 again in the traditional
>>> +     way.  Pop candidates record the registers that need to be popped
>>> +     eventually.  */
>>> +  if (frame.is_scs_enabled)
>>> +    {
>>> +      if (frame.wb_push_candidate2 == R30_REGNUM)
>>> +	frame.wb_pop_candidate2 = INVALID_REGNUM;
>>> +      else if (frame.wb_push_candidate1 == R30_REGNUM)
>>> +	frame.wb_pop_candidate1 = INVALID_REGNUM;
>> 
>> Although it makes no difference to the behaviour, I think it would be
>> clearer to use pop rather than push in the checks here.
>> 
>
> Got it.
>>> @@ -7885,8 +7914,8 @@ aarch64_save_callee_saves (poly_int64 start_offset,
>>>         bool frame_related_p = aarch64_emit_cfi_for_reg_p (regno);
>>>   
>>>         if (skip_wb
>>> -	  && (regno == cfun->machine->frame.wb_candidate1
>>> -	      || regno == cfun->machine->frame.wb_candidate2))
>>> +	  && (regno == cfun->machine->frame.wb_push_candidate1
>>> +	      || regno == cfun->machine->frame.wb_push_candidate2))
>>>   	continue;
>>>   
>>>         if (cfun->machine->reg_is_wrapped_separately[regno])
>>> @@ -7996,8 +8025,8 @@ aarch64_restore_callee_saves (poly_int64 start_offset, unsigned start,
>>>         rtx reg, mem;
>>>   
>>>         if (skip_wb
>>> -	  && (regno == cfun->machine->frame.wb_candidate1
>>> -	      || regno == cfun->machine->frame.wb_candidate2))
>>> +	  && (regno == cfun->machine->frame.wb_push_candidate1
>>> +	      || regno == cfun->machine->frame.wb_push_candidate2))
>> 
>> Shouldn't this be using pop rather than push?
>> 
>
> There might be a little difference:
>
> - Using push candidates means that a register to be ignored in pop
> candidates will not be emitted again during the "restore" (pop_candidates
> should always be a subset of push_candidates, since popping a register
> without a push might not make sense).

The push candidates are simply a subset of the saved registers though.
Similarly, the pop candidates are simply a subset of the restored registers.
So I think the requirement operates at that level: the restored registers
must be a subset of the saved registers.

In other circumstances it could have been the other way around:
there might have been a change that stopped us from saving two
registers during the allocation, but we wanted to carry on restoring
two registers during the deallocation.  I don't think there's a
reason that the push candidates *have* to be a superset of the
pop candidates (even though they are with the current change).

> - Using pop candidates means that a registers to be ignored in pop
> candidates will be re-emitted during the "restore". For example,
> if we specify to ignore the x20 register in pop:
>
> --- a/gcc/config/aarch64/aarch64.c
> +++ b/gcc/config/aarch64/aarch64.c
> @@ -7502,6 +7502,8 @@ aarch64_layout_frame (void)
>          frame.wb_pop_candidate1 = INVALID_REGNUM;
>       }
>   
> +  if (frame.wb_pop_candidate2 == R20_REGNUM)
> +       frame.wb_pop_candidate2 = INVALID_REGNUM;
>     /* If candidate2 is INVALID_REGNUM, we need to adjust max_push_offset to
>        256 to ensure that the offset meets the requirements of emit_move_insn.
>        Similarly, if candidate1 is INVALID_REGNUM, we need to set
>
> With the test case:
>
> int main(void)
> {
>          __asm__ ("":::"x19", "x20");
>          return 0;
> }
>
> When we use "pop_candidate[12]", one more insn is emitted:
>
> 0000000000400604 <main>:
>     400604:       a9bf53f3        stp     x19, x20, [sp, #-16]!
>     400608:       52800000        mov     w0, #0x0
> +  40060c:       f94007f4        ldr     x20, [sp, #8]
>     400610:       f84107f3        ldr     x19, [sp], #16
>     400614:       d65f03c0        ret
>
> But in the case of ignoring a specific register (like scs ignores x30),
> there is no difference between the two (because we always need
> to explicitly specify which registers to ignore in the parameter of
> aarch64_restore_callee_saves).

I think this is the correct behaviour.  If we don't want to restore
a register at all then it should be excluded from the restore list
somehow.  In your case you're doing that be using a limit of
X29_REGNUM instead of X30_REGNUM.

FWIW, I did wonder whether aarch64_restore_callee_saves should be
doing the scs pop, rather than aarch64_expand_epilogue, and in an
earlier draft of the previous review I'd asked for that.  It does
seem conceptually cleaner, but in practice, it would probably have
been awkward to implement.  E.g. we'd need to explicitly stop an
LDP being formed with X30 as the second register.

But treating scs push and scs pop as part of the register save and
restore sequences would have one advantage: it would allow the
scs push and scs pop to be shrink-wrapped.

Thanks,
Richard

> If pop looks better here, I'd like to change it to pop in the
> next version :).
>
>>> +  /* When shadow call stack is enabled, the scs_pop in the epilogue will
>>> +     restore x30, we don't need to restore x30 again in the traditional
>>> +     way.  */
>>> +  if (cfun->machine->frame.is_scs_enabled)
>>> +    aarch64_restore_callee_saves (callee_offset - sve_callee_adjust,
>>> +				  R0_REGNUM, R29_REGNUM,
>>> +				  callee_adjust != 0, &cfi_ops);
>>> +  else
>>> +    aarch64_restore_callee_saves (callee_offset - sve_callee_adjust,
>>> +				  R0_REGNUM, R30_REGNUM,
>>> +				  callee_adjust != 0, &cfi_ops);
>>> +
>> 
>> Very minor, but I think it would be better to have:
>> 
>>    unsigned int last_gpr = (cfun->machine->frame.is_scs_enabled
>> 			   ? R29_REGNUM : R30_REGNUM);
>> 
>> so that we don't need to repeat the other arguments.  There's then
>> less risk of the two versions getting out of sync.
>> 
>
> Got it.
>
>>>   
>>>     if (need_barrier_p)
>>>       emit_insn (gen_stack_tie (stack_pointer_rtx, stack_pointer_rtx));
>>> @@ -9066,6 +9109,17 @@ aarch64_expand_epilogue (bool for_sibcall)
>>>         RTX_FRAME_RELATED_P (insn) = 1;
>>>       }
>>>   
>>> +  /* Pop return address from shadow call stack.  */
>>> +  if (cfun->machine->frame.is_scs_enabled)
>>> +    {
>>> +      machine_mode mode = aarch64_reg_save_mode (R30_REGNUM);
>>> +      rtx reg = gen_rtx_REG (mode, R30_REGNUM);
>>> +
>>> +      insn = emit_insn (gen_scs_pop ());
>>> +      add_reg_note (insn, REG_CFA_RESTORE, reg);
>>> +      RTX_FRAME_RELATED_P (insn) = 1;
>>> +    }
>>> +
>>>     /* We prefer to emit the combined return/authenticate instruction RETAA,
>>>        however there are three cases in which we must instead emit an explicit
>>>        authentication instruction.
>>> @@ -16492,6 +16546,10 @@ aarch64_override_options_internal (struct gcc_options *opts)
>>>         aarch64_stack_protector_guard_offset = offs;
>>>       }
>>>   
>>> +  if ((flag_sanitize & SANITIZE_SHADOW_CALL_STACK)
>>> +      && !fixed_regs[R18_REGNUM])
>>> +    error ("%<-fsanitize=shadow-call-stack%> requires %<-ffixed-x18%>");
>>> +
>>>     initialize_aarch64_code_model (opts);
>>>     initialize_aarch64_tls_size (opts);
>>>   
>>> @@ -26505,6 +26563,9 @@ aarch64_libgcc_floating_mode_supported_p
>>>   #undef TARGET_ASM_FUNCTION_EPILOGUE
>>>   #define TARGET_ASM_FUNCTION_EPILOGUE aarch64_sls_emit_blr_function_thunks
>>>   
>>> +#undef TARGET_HAVE_SHADOW_CALL_STACK
>>> +#define TARGET_HAVE_SHADOW_CALL_STACK true
>>> +
>>>   struct gcc_target targetm = TARGET_INITIALIZER;
>>>   
>>>   #include "gt-aarch64.h"
>>> diff --git a/gcc/config/aarch64/aarch64.h b/gcc/config/aarch64/aarch64.h
>>> index 2792bb29adb..b5efe083f30 100644
>>> --- a/gcc/config/aarch64/aarch64.h
>>> +++ b/gcc/config/aarch64/aarch64.h
>>> @@ -906,9 +906,21 @@ struct GTY (()) aarch64_frame
>>>   	 Indicated by CALLEE_ADJUST == 0 && EMIT_FRAME_CHAIN.
>>>   
>>>        These fields indicate which registers we've decided to handle using
>>> -     (1) or (2), or INVALID_REGNUM if none.  */
>>> -  unsigned wb_candidate1;
>>> -  unsigned wb_candidate2;
>>> +     (1) or (2), or INVALID_REGNUM if none.
>>> +
>>> +     In some cases we don't always need to pop all registers in the push
>>> +     candidates, pop candidates record which registers need to be popped
>>> +     eventually.  The initial value of a pop candidate is copied from its
>>> +     corresponding push candidate.
>>> +
>>> +     Currently, the pop candidates are only used for shadow call stack.
>> 
>> Maybe s/the/different/, since the variables themselves are used
>> regardless of -fsanitize.
>> 
>
> Got it.
>
> Thanks,
> Dan
