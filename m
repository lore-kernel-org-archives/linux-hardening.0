Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580BBC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Nov 2021 08:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhKWIeE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:34:04 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39981 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230516AbhKWIeE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Nov 2021 03:34:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UxueIHN_1637656253;
Received: from ashimida.local(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0UxueIHN_1637656253)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Nov 2021 16:30:54 +0800
Subject: Re: [PATCH] [RFC][PR102768] aarch64: Add compiler support for Shadow
 Call Stack
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <20211102130413.GS1982710@arm.com>
 <fb3b7de8-7494-3190-1684-34fcbe9e1aa5@linux.alibaba.com>
 <20211103120047.GU1982710@arm.com>
From:   Dan Li <ashimida@linux.alibaba.com>
Message-ID: <7937172c-3b1a-ffca-59c5-d75b73e5e3a7@linux.alibaba.com>
Date:   Tue, 23 Nov 2021 16:32:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20211103120047.GU1982710@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Szabolcs,

First of all, apologies for my late reply (since I just had a new baby,
I'm quite busy recently and also because I'm not familiar with C++
exception handling, it takes me some time to learn this part).

On 11/3/21 8:00 PM, Szabolcs Nagy wrote:
> The 11/03/2021 00:24, Dan Li wrote:
>> On 11/2/21 9:04 PM, Szabolcs Nagy wrote:
>>> The 11/02/2021 00:06, Dan Li via Gcc-patches wrote:
>>>> Shadow Call Stack can be used to protect the return address of a
>>>> function at runtime, and clang already supports this feature[1].
>>>>
>>>> To enable SCS in user mode, in addition to compiler, other support
>>>> is also required (as described in [2]). This patch only adds basic
>>>> support for SCS from the compiler side, and provides convenience
>>>> for users to enable SCS.
>>>>
>>>> For linux kernel, only the support of the compiler is required.
>>>>
>>>> [1] https://clang.llvm.org/docs/ShadowCallStack.html
>>>> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768
>>>
>>> i'm not a gcc maintainer, but i prefer such feature
>>> to be in upstream gcc instead of in a plugin.
>>>
>>> it will require update to the documentation:
>>>
>>> which should mention that it depends on -ffixed-x18
>>> (probably that should be enforced too) which is an
>>> important abi issue: functions following the normal
>>> pcs can clobber x18 and break scs.
>>>
>> Thanks Szabolcs, I will update the documentation in next version.
>>
>> It sounds reasonable to enforced -ffixed-x18 with scs, but I see
>> that clang doesn’t do that. Maybe it is better to be consistent
>> with clang here?
> 
> i mean gcc can issue a diagnostic if -ffixed-x18 is not passed.
> (it seems clang rejects scs too without -ffixed-x18)
>
Oh, yes, you are right. Clang rejects scs without -ffixed-x18[1],
I should add a similar check in next version.
>>> and that there is no unwinder support.
>>>
>> Ok, let me try to add a support for this.
> 
> i assume exception handling info has to change for scs to
> work (to pop the shadow stack when transferring control),
> so either scs must require -fno-exceptions or the eh info
> changes must be implemented.
> 
> i think the kernel does not require exceptions and does
> not depend on the unwinder runtime in libgcc, so this
> is optional for the linux kernel use-case.
>
I recompiled a glibc and gcc runtime library with -ffixed-x18 enabled.
As you said, the scs stack needs to be popped at the same time during
exception handling.

I saw that Clang is processed by adding
".cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78"
directive (x18 -= 8;) after each emit of scs push[2].

But this directive has problems when executed in libgcc:
1)context->reg[x] in uw_init_context_1 are all based on cfa, most
   registers have no initial values by default.
2)Address of shadow call stack (x18) cannot(and should not) be calculated
   based on cfa, and I did not yet find a way to assign hardware register
   x18 to context->reg[18].
3)This causes libgcc to crash when parsing .cfi_escape exp because of 0
   address dereference (* x18)
   (execute_stack_op => case DW_OP_breg18: _Unwind_GetGR)
4)uw_install_context_1 does not restore all hardware registers by default
   before eh return, so context->reg[18] can't write directly to hw x18.
   (In clang, __unw_getcontext/__unw_resume will save/restore all hardware
   registers, so this directive works fine in my libunwind test.)

I tried to fix this problem through a patch[3], the exception handling
works fine in my test environment, but I'm not sure if this fix is
ppropriate for two reasons:
1)libgcc does not push/pop all registers by default during exception
   handling. Is this change appropriate?
2)The test case may not be able to test this patch, because the test
   environment requires at least on glibc/gcc runtime compiled with
   -ffixed-x18.

May be it's better to rely on -fno-exceptions for this patch first? and If
the glibc/gcc runtime also supports SCS later, the problem can be fixed
at the same time.

PS:
I'm still not familiar enough with exception handling in libgcc/libunwind,
please correct me if there are any mistakes :)

[1] https://github.com/llvm/llvm-project/commit/f11eb3ebe77729426e562d7d4d7ebb1d5ff2e7c8
[2] https://reviews.llvm.org/D54609
[3] https://gcc.gnu.org/bugzilla/attachment.cgi?id=51854&action=diff

