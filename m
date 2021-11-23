Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44573C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Nov 2021 13:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhKWNk0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:40:26 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47513 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229939AbhKWNk0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Nov 2021 08:40:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Uxykn-g_1637674636;
Received: from 192.168.2.142(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0Uxykn-g_1637674636)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Nov 2021 21:37:16 +0800
Subject: Re: [PATCH] [RFC][PR102768] aarch64: Add compiler support for Shadow
 Call Stack
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <20211102130413.GS1982710@arm.com>
 <fb3b7de8-7494-3190-1684-34fcbe9e1aa5@linux.alibaba.com>
 <20211103120047.GU1982710@arm.com>
 <7937172c-3b1a-ffca-59c5-d75b73e5e3a7@linux.alibaba.com>
 <20211123105149.GM1982710@arm.com>
From:   Dan Li <ashimida@linux.alibaba.com>
Message-ID: <fe92fe8f-b7d8-001a-22c4-32cc1e8270ef@linux.alibaba.com>
Date:   Tue, 23 Nov 2021 21:39:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20211123105149.GM1982710@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 11/23/21 6:51 PM, Szabolcs Nagy wrote:
> The 11/23/2021 16:32, Dan Li wrote:
>> On 11/3/21 8:00 PM, Szabolcs Nagy wrote:
>>> i assume exception handling info has to change for scs to
>>> work (to pop the shadow stack when transferring control),
>>> so either scs must require -fno-exceptions or the eh info
>>> changes must be implemented.
>>>
>>> i think the kernel does not require exceptions and does
>>> not depend on the unwinder runtime in libgcc, so this
>>> is optional for the linux kernel use-case.
>>>
>> I recompiled a glibc and gcc runtime library with -ffixed-x18 enabled.
>> As you said, the scs stack needs to be popped at the same time during
>> exception handling.
>>
>> I saw that Clang is processed by adding
>> ".cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78"
>> directive (x18 -= 8;) after each emit of scs push[2].
>>
>> But this directive has problems when executed in libgcc:
>> 1)context->reg[x] in uw_init_context_1 are all based on cfa, most
>>    registers have no initial values by default.
>> 2)Address of shadow call stack (x18) cannot(and should not) be calculated
>>    based on cfa, and I did not yet find a way to assign hardware register
>>    x18 to context->reg[18].
>> 3)This causes libgcc to crash when parsing .cfi_escape exp because of 0
>>    address dereference (* x18)
>>    (execute_stack_op => case DW_OP_breg18: _Unwind_GetGR)
>> 4)uw_install_context_1 does not restore all hardware registers by default
>>    before eh return, so context->reg[18] can't write directly to hw x18.
>>    (In clang, __unw_getcontext/__unw_resume will save/restore all hardware
>>    registers, so this directive works fine in my libunwind test.)
>>
>> I tried to fix this problem through a patch[3], the exception handling
>> works fine in my test environment, but I'm not sure if this fix is
>> ppropriate for two reasons:
>> 1)libgcc does not push/pop all registers by default during exception
>>    handling. Is this change appropriate?
>> 2)The test case may not be able to test this patch, because the test
>>    environment requires at least on glibc/gcc runtime compiled with
>>    -ffixed-x18.
>>
>> May be it's better to rely on -fno-exceptions for this patch first? and If
>> the glibc/gcc runtime also supports SCS later, the problem can be fixed
>> at the same time.
> 
> i did not look at the exception handling in detail (that's
> difficult to understand for me too).
> 
> to use scs, non-default abi is required anyway, so not
> supporting exceptions sounds fine to me. however it should
> be documented and ideally enforced (-fexceptions should
> be rejected, just like -fno-fixed-x18).
Thanks Szabolcs,

This sounds reasonable to me, and I'll fix it in the next version.
> 
> i assume the linux kernel does not require -fexceptions.
> 
AFAIK, -fexceptions are not used in the linux kernel.
>>
>> PS:
>> I'm still not familiar enough with exception handling in libgcc/libunwind,
>> please correct me if there are any mistakes :)
>>
>> [1] https://github.com/llvm/llvm-project/commit/f11eb3ebe77729426e562d7d4d7ebb1d5ff2e7c8
>> [2] https://reviews.llvm.org/D54609
>> [3] https://gcc.gnu.org/bugzilla/attachment.cgi?id=51854&action=diff
>>
