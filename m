Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A66C2BA4C
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 10:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiAZKfX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 05:35:23 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48993 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232441AbiAZKfW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 05:35:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V2vBzQX_1643193317;
Received: from 192.168.193.139(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V2vBzQX_1643193317)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jan 2022 18:35:18 +0800
Message-ID: <3f2027af-bbe0-f46f-2ceb-bffc4bbbf70e@linux.alibaba.com>
Date:   Wed, 26 Jan 2022 02:35:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PING^3][PATCH,v2,1/1,AARCH64][PR102768] aarch64: Add compiler
 support for Shadow Call Stack
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     gcc-patches@gcc.gnu.org,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        marcus.shawcroft@arm.com, Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        hp@gcc.gnu.org, Nick Desaulniers <ndesaulniers@google.com>,
        nsz@gcc.gnu.org, pageexec@gmail.com, qinzhao@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        linux-hardening@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <81d54b71-7c9c-47ef-ac8d-72aae46cd4ee@linux.alibaba.com>
 <mptk0euk42w.fsf@arm.com>
 <a9daf6bf-94f2-0c5f-b9aa-7fb69781c9d5@linux.alibaba.com>
 <mpto840kti9.fsf@arm.com>
 <3ae4a533-352b-f3e3-27b3-9386df5f56c3@linux.alibaba.com>
 <61acb6f4-9a86-ddad-e48c-c68e4bcb08f1@linux.alibaba.com>
 <CAMj1kXG5oSo0Z+bEjExaaG6Y942R7fiL0fDKH59RETS=G4jDoA@mail.gmail.com>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <CAMj1kXG5oSo0Z+bEjExaaG6Y942R7fiL0fDKH59RETS=G4jDoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Thanks, Ard,

On 1/26/22 00:10, Ard Biesheuvel wrote:
> On Wed, 26 Jan 2022 at 08:53, Dan Li <ashimida@linux.alibaba.com> wrote:
>>
>> Hi, all,
>>
>> Sorry for bothering.
>>
>> I'm trying to commit aarch64 scs code to the gcc and there is an issue
>> that I'm not sure about, could someone give me some suggestions?
>> (To avoid noise, I did't cc PING^3 [1] to the kernel mail list :) )
>>
>> When clang enables scs, the following instructions are usually generated:
>>
>> str     x30, [x18], 8
>> ldp     x29, x30, [sp], 16
>> ......
>> ldp     x29, x30, [sp], 16              ## x30 pop
>> ldr     x30, [x18, -8]!                 ## x30 pop again
>> ret
>>
>> The x30 register is popped twice here, Richard suggested that we can
>> omit the first x30 pop here.
>>
>> AFAICT, it seems fine and also safe for SCS. But I'm not sure if I'm
>> missing something with the kernel, could someone give some suggestions?
>>
>> The previous discussion can be found here [1].
>>
>> [1] https://gcc.gnu.org/pipermail/gcc-patches/2022-January/589257.html
>>
> 
> As was pointed out in the discussion, binary patching is in fact a
> concern for the Linux kernel. E.g., Android uses generic binary
> builds, but we would like to be able to switch between pointer
> authentication and shadow call stack at boot time, rather than always
> support both, and take the SCS performance hit on systems that
> implement PAC as well.
> 
> However, it seems more straight-forward to patch PACIASP and AUTIASP
> instructions into SCS push/pop instructions rather than the other way
> around, as we can force the use of these exact opcodes [in the NOP
> space]), as well as rely on existing unwind annotations to locate any
> such instruction in the binary.
> 

Well, then I think I don't need to submit a kernel patch to
enable SCS for gcc :)

BTW:
Do we have a plan to submit patches of dynamic patch PAC into
the kernel recently?

> So omitting the load of X30 from the ordinary stack seems fine to me.
> 
>> On 1/25/22 22:51, Dan Li wrote:
>>>
>>>
>>> On 1/25/22 02:19, Richard Sandiford wrote:
>>>
>>> Well, probably sticking to pop x30 twice is not a good idea.
>>> AFAICT, there doesn't seem to be an explicit requirement that
>
>>>>
>>>
>>> Ok, I'll cc some kernel folks to make sure I didn't miss something.
>>>
To Richard:

Sorry for my mistake.

Due to binary compatibility issues, SCS related code may not
be directly merged into libgcc/glibc, do we still need to
add this patch into GCC? (I'd like to finish it if that
makes sense).


Thanks all for your time!
Dan

>>>> If binary patching is supposed to be possible then scs_push and
>>>> scs_pop *do* need to be separate define_insns.  But they also need
>>>> to have some magic unspec that differentiates them from normal
>>>> pushes and pops, e.g.:
>>>>
>>>>     (set ...mem...
>>>>          (unspec:DI [...reg...] UNSPEC_SCS_PUSH))
>>>>
>>>> so that there is no chance that the pattern would be treated as
>>>> a normal move and optimised accordingly.
>>>>
>>>
>>> Yeah, this template looks more appropriate if it is to be treated
>>> as a special directive.
>>>
>>> Thanks for your suggestions,
>>> Dan
