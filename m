Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E4C433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 16:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A117A60D42
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 16:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhKBQjX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:39:23 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53762 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234610AbhKBQi7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 12:38:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UumORXH_1635870247;
Received: from ashimida.local(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0UumORXH_1635870247)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Nov 2021 00:24:08 +0800
Subject: Re: [PATCH] [RFC][PR102768] aarch64: Add compiler support for Shadow
 Call Stack
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <20211102130413.GS1982710@arm.com>
From:   Dan Li <ashimida@linux.alibaba.com>
Message-ID: <fb3b7de8-7494-3190-1684-34fcbe9e1aa5@linux.alibaba.com>
Date:   Wed, 3 Nov 2021 00:24:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20211102130413.GS1982710@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 11/2/21 9:04 PM, Szabolcs Nagy wrote:
> The 11/02/2021 00:06, Dan Li via Gcc-patches wrote:
>> Shadow Call Stack can be used to protect the return address of a
>> function at runtime, and clang already supports this feature[1].
>>
>> To enable SCS in user mode, in addition to compiler, other support
>> is also required (as described in [2]). This patch only adds basic
>> support for SCS from the compiler side, and provides convenience
>> for users to enable SCS.
>>
>> For linux kernel, only the support of the compiler is required.
>>
>> [1] https://clang.llvm.org/docs/ShadowCallStack.html
>> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768
> 
> i'm not a gcc maintainer, but i prefer such feature
> to be in upstream gcc instead of in a plugin.
> 
> it will require update to the documentation:
> 
> which should mention that it depends on -ffixed-x18
> (probably that should be enforced too) which is an
> important abi issue: functions following the normal
> pcs can clobber x18 and break scs.
> 
Thanks Szabolcs, I will update the documentation in next version.

It sounds reasonable to enforced -ffixed-x18 with scs, but I see
that clang doesn’t do that. Maybe it is better to be consistent
with clang here?

> and that there is no unwinder support.
> 
Ok, let me try to add a support for this.

> the abi issue means it is unlikely to be useful in
> linux user space (even if libc and unwinder support
> is implemented), but it can be still useful in
> freestanding code such as the linux kernel.
> 
> thanks.
> 
