Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD6C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 12 Feb 2022 08:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiBLIn2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 12 Feb 2022 03:43:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBLIn1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 12 Feb 2022 03:43:27 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87A52613A
        for <linux-hardening@vger.kernel.org>; Sat, 12 Feb 2022 00:43:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V4DDubE_1644655399;
Received: from 192.168.193.145(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V4DDubE_1644655399)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 12 Feb 2022 16:43:20 +0800
Message-ID: <f1f25e97-07d1-1b60-bdfa-0e77597add8e@linux.alibaba.com>
Date:   Sat, 12 Feb 2022 00:43:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
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
 <74fb3167-f5d7-84dd-1348-c9ea18665b58@linux.alibaba.com>
 <mptv8xl20hr.fsf@arm.com>
 <81b35033-489e-d0c0-8677-55923f6abbe0@linux.alibaba.com>
 <mpto83dzaai.fsf@arm.com>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <mpto83dzaai.fsf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 2/11/22 07:35, Richard Sandiford wrote:
> Dan Li <ashimida@linux.alibaba.com> writes:
>> On 2/11/22 01:53, Richard Sandiford wrote:
>>> Dan Li <ashimida@linux.alibaba.com> writes:
>>>> On 2/10/22 01:55, Richard Sandiford wrote:
>>>>>>
>> And I think maybe we could handle this through three patches:
>> 1.Keep current patch (a V5) unchanged for scs.
>> 2.Add shrink-warpping for X30:
>> logically this might be a separate topic, and I think more testing
>> might be needed here (Well, I'm a little worried about if there might
>> be other effects, since I just read this part of the code roughly
>> yesterday).
>> 3.Add scs push/pop to shrink-wrapping (and maybe we can do the same for
>> the PAC code in pro/epilogue, since it's also the operation of the X30).
> 
> Yeah, that's fair.
> 
> (Like I said earlier, I wasn't asking for the shrink-wrapping change.
> It was just a note in passing.  But as you point out, the individual
> shrink-wrapping support would be even more work than I'd imagined.)

Hi, Richard,
I have sent out the v5[1] and rebased it to mainline at the same time,
please let me know if there is anything else I need to do :)

[1].https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590311.html

Thanks,
Dan
