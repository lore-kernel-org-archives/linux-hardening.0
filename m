Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D9C4332F
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 09:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiBBJdH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 04:33:07 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36531 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239992AbiBBJdH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 04:33:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V3RFN.I_1643794383;
Received: from 192.168.193.142(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V3RFN.I_1643794383)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Feb 2022 17:33:04 +0800
Message-ID: <7c9fb924-bfef-4edd-a3f1-6c5d2c6c1c42@linux.alibaba.com>
Date:   Wed, 2 Feb 2022 01:33:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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


On 1/31/22 09:00, Richard Sandiford wrote:
> Dan Li <ashimida@linux.alibaba.com> writes:
>> Shadow Call Stack can be used to protect the return address of a
>> function at runtime, and clang already supports this feature[1].
>>
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

Sorry for my non-standard English expression :)
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

Got it.
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

This looks more reasonable, I'll change it in the next version.
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

Got it, thanks for the explanation.
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

Oh, thanks Richard, I didn't notice it before.
> Also, [#|$]? can be written #?.
> 

Ok.
> Thanks,
> Richard
