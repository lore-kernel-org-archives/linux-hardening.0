Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D4EC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 09:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiBBJZn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 04:25:43 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:58694 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245500AbiBBJZl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 04:25:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V3RLRGY_1643793937;
Received: from 192.168.193.142(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V3RLRGY_1643793937)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Feb 2022 17:25:39 +0800
Message-ID: <7adf6644-55ce-d90e-2f62-66792364d337@linux.alibaba.com>
Date:   Wed, 2 Feb 2022 01:25:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PING^3][PATCH,v2,1/1,AARCH64][PR102768] aarch64: Add compiler
 support for Shadow Call Stack
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, gcc-patches@gcc.gnu.org,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        marcus.shawcroft@arm.com, Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        hp@gcc.gnu.org, Nick Desaulniers <ndesaulniers@google.com>,
        nsz@gcc.gnu.org, pageexec@gmail.com, qinzhao@gcc.gnu.org,
        linux-hardening@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>, richard.sandiford@arm.com
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <81d54b71-7c9c-47ef-ac8d-72aae46cd4ee@linux.alibaba.com>
 <mptk0euk42w.fsf@arm.com>
 <a9daf6bf-94f2-0c5f-b9aa-7fb69781c9d5@linux.alibaba.com>
 <mpto840kti9.fsf@arm.com>
 <3ae4a533-352b-f3e3-27b3-9386df5f56c3@linux.alibaba.com>
 <61acb6f4-9a86-ddad-e48c-c68e4bcb08f1@linux.alibaba.com>
 <CAMj1kXG5oSo0Z+bEjExaaG6Y942R7fiL0fDKH59RETS=G4jDoA@mail.gmail.com>
 <3f2027af-bbe0-f46f-2ceb-bffc4bbbf70e@linux.alibaba.com>
 <mptfsp3lvm5.fsf@arm.com>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <mptfsp3lvm5.fsf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 1/31/22 08:26, Richard Sandiford wrote:
> Thanks for the discussion and sorry for the slow reply, was out most of
> last week.
> 
> Dan Li <ashimida@linux.alibaba.com> writes:
>> Thanks, Ard,
>>
>> On 1/26/22 00:10, Ard Biesheuvel wrote:
>>> On Wed, 26 Jan 2022 at 08:53, Dan Li <ashimida@linux.alibaba.com> wrote:
>>>>
>>>> Hi, all,
>>>>
>>>> Sorry for bothering.
>>>>
>>>> I'm trying to commit aarch64 scs code to the gcc and there is an issue
>>>> that I'm not sure about, could someone give me some suggestions?
>>>> (To avoid noise, I did't cc PING^3 [1] to the kernel mail list :) )
>>>>
>>> So omitting the load of X30 from the ordinary stack seems fine to me.
> 
> OK, thanks.  Let's go with that for now then.  There would still be
> time to change our minds before GCC 12 is released, if anyone feels
> that patching SCS code would be useful.
>> Reading it back, I think my previous message came across as sounding
> like a complaint against binary patching, which wasn't the case at all.
> I think it would be fine to support patching, even if it was just for a
> single vendor rather than expected to be a common case.  It's just that,
> if we did want to support it, we'd need to document it as a requirement
> (at least within GCC) and change the implementation accordingly.
> 
Got it, then I'll implement this feature as discussed above and see
if we could add additional options for SCS later.

Thanks,
Dan
