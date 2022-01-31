Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B2C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Jan 2022 16:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380322AbiAaQ0e (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 11:26:34 -0500
Received: from foss.arm.com ([217.140.110.172]:34560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380326AbiAaQ0a (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 11:26:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC580ED1;
        Mon, 31 Jan 2022 08:26:29 -0800 (PST)
Received: from localhost (unknown [10.32.98.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B05143F73B;
        Mon, 31 Jan 2022 08:26:27 -0800 (PST)
From:   Richard Sandiford <richard.sandiford@arm.com>
To:     Dan Li <ashimida@linux.alibaba.com>
Mail-Followup-To: Dan Li <ashimida@linux.alibaba.com>,Ard Biesheuvel <ardb@kernel.org>,  gcc-patches@gcc.gnu.org,  Richard Earnshaw <richard.earnshaw@arm.com>,  marcus.shawcroft@arm.com,  Kyrylo Tkachov <kyrylo.tkachov@arm.com>,  hp@gcc.gnu.org,  Nick Desaulniers <ndesaulniers@google.com>,  nsz@gcc.gnu.org,  pageexec@gmail.com,  qinzhao@gcc.gnu.org,  linux-hardening@vger.kernel.org,  Peter Collingbourne <pcc@google.com>,  Sami Tolvanen <samitolvanen@google.com>,  Kees Cook <keescook@chromium.org>, richard.sandiford@arm.com
Cc:     Ard Biesheuvel <ardb@kernel.org>, gcc-patches@gcc.gnu.org,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        marcus.shawcroft@arm.com, Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        hp@gcc.gnu.org, Nick Desaulniers <ndesaulniers@google.com>,
        nsz@gcc.gnu.org, pageexec@gmail.com, qinzhao@gcc.gnu.org,
        linux-hardening@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PING^3][PATCH,v2,1/1,AARCH64][PR102768] aarch64: Add compiler support for Shadow Call Stack
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
        <81d54b71-7c9c-47ef-ac8d-72aae46cd4ee@linux.alibaba.com>
        <mptk0euk42w.fsf@arm.com>
        <a9daf6bf-94f2-0c5f-b9aa-7fb69781c9d5@linux.alibaba.com>
        <mpto840kti9.fsf@arm.com>
        <3ae4a533-352b-f3e3-27b3-9386df5f56c3@linux.alibaba.com>
        <61acb6f4-9a86-ddad-e48c-c68e4bcb08f1@linux.alibaba.com>
        <CAMj1kXG5oSo0Z+bEjExaaG6Y942R7fiL0fDKH59RETS=G4jDoA@mail.gmail.com>
        <3f2027af-bbe0-f46f-2ceb-bffc4bbbf70e@linux.alibaba.com>
Date:   Mon, 31 Jan 2022 16:26:26 +0000
In-Reply-To: <3f2027af-bbe0-f46f-2ceb-bffc4bbbf70e@linux.alibaba.com> (Dan
        Li's message of "Wed, 26 Jan 2022 02:35:17 -0800")
Message-ID: <mptfsp3lvm5.fsf@arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Thanks for the discussion and sorry for the slow reply, was out most of
last week.

Dan Li <ashimida@linux.alibaba.com> writes:
> Thanks, Ard,
>
> On 1/26/22 00:10, Ard Biesheuvel wrote:
>> On Wed, 26 Jan 2022 at 08:53, Dan Li <ashimida@linux.alibaba.com> wrote:
>>>
>>> Hi, all,
>>>
>>> Sorry for bothering.
>>>
>>> I'm trying to commit aarch64 scs code to the gcc and there is an issue
>>> that I'm not sure about, could someone give me some suggestions?
>>> (To avoid noise, I did't cc PING^3 [1] to the kernel mail list :) )
>>>
>>> When clang enables scs, the following instructions are usually generated:
>>>
>>> str     x30, [x18], 8
>>> ldp     x29, x30, [sp], 16
>>> ......
>>> ldp     x29, x30, [sp], 16              ## x30 pop
>>> ldr     x30, [x18, -8]!                 ## x30 pop again
>>> ret
>>>
>>> The x30 register is popped twice here, Richard suggested that we can
>>> omit the first x30 pop here.
>>>
>>> AFAICT, it seems fine and also safe for SCS. But I'm not sure if I'm
>>> missing something with the kernel, could someone give some suggestions?
>>>
>>> The previous discussion can be found here [1].
>>>
>>> [1] https://gcc.gnu.org/pipermail/gcc-patches/2022-January/589257.html
>>>
>> 
>> As was pointed out in the discussion, binary patching is in fact a
>> concern for the Linux kernel. E.g., Android uses generic binary
>> builds, but we would like to be able to switch between pointer
>> authentication and shadow call stack at boot time, rather than always
>> support both, and take the SCS performance hit on systems that
>> implement PAC as well.
>> 
>> However, it seems more straight-forward to patch PACIASP and AUTIASP
>> instructions into SCS push/pop instructions rather than the other way
>> around, as we can force the use of these exact opcodes [in the NOP
>> space]), as well as rely on existing unwind annotations to locate any
>> such instruction in the binary.
>> 
>
> Well, then I think I don't need to submit a kernel patch to
> enable SCS for gcc :)
>
> BTW:
> Do we have a plan to submit patches of dynamic patch PAC into
> the kernel recently?
>
>> So omitting the load of X30 from the ordinary stack seems fine to me.

OK, thanks.  Let's go with that for now then.  There would still be
time to change our minds before GCC 12 is released, if anyone feels
that patching SCS code would be useful.

Reading it back, I think my previous message came across as sounding
like a complaint against binary patching, which wasn't the case at all.
I think it would be fine to support patching, even if it was just for a
single vendor rather than expected to be a common case.  It's just that,
if we did want to support it, we'd need to document it as a requirement
(at least within GCC) and change the implementation accordingly.

Thanks,
Richard
