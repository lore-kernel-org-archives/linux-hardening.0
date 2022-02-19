Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B76C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 19 Feb 2022 09:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiBSJNj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 19 Feb 2022 04:13:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBSJNi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 19 Feb 2022 04:13:38 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B9E56231
        for <linux-hardening@vger.kernel.org>; Sat, 19 Feb 2022 01:13:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V4t6FMH_1645261995;
Received: from 192.168.193.149(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V4t6FMH_1645261995)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Feb 2022 17:13:16 +0800
Message-ID: <2313ee27-45e2-ea5e-140b-11be42e52809@linux.alibaba.com>
Date:   Sat, 19 Feb 2022 01:13:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] [PATCH,v5,1/1,AARCH64][PR102768] aarch64: Add compiler
 support for Shadow Call Stack
Content-Language: en-US
To:     gcc-patches@gcc.gnu.org, richard.earnshaw@arm.com,
        marcus.shawcroft@arm.com, kyrylo.tkachov@arm.com, hp@gcc.gnu.org,
        ndesaulniers@google.com, nsz@gcc.gnu.org, pageexec@gmail.com,
        qinzhao@gcc.gnu.org, linux-hardening@vger.kernel.org,
        richard.sandiford@arm.com
References: <20220212082751.4524-1-ashimida@linux.alibaba.com>
 <mpt1r04t3dz.fsf@arm.com>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <mpt1r04t3dz.fsf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 2/15/22 10:02, Richard Sandiford wrote:
> Dan Li <ashimida@linux.alibaba.com> writes:
>> Shadow Call Stack can be used to protect the return address of a
> 
> Looks good, thanks.  However, when I bootstrap it on
> aarch64-linux-gnu I get:
> 
> .../gcc/ubsan.cc: In function ‘bool ubsan_expand_null_ifn(gimple_stmt_iterator*)’:
> .../gcc/ubsan.cc:835:50: error: enumerated and non-enumerated type in conditional expression [-Werror=extra]
>    835 |         = (flag_sanitize_recover & ((check_align ? SANITIZE_ALIGNMENT : 0)
>        |                                      ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
> .../gcc/ubsan.cc:836:51: error: enumerated and non-enumerated type in conditional expression [-Werror=extra]
>    836 |                                     | (check_null ? SANITIZE_NULL : 0)))
>        |                                        ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> 
> I think this is because you're taking the last available bit
> of the enum :-)
> 
> A hacky fix is to add "+ 0" to SANITIZE_ALIGNMENT and SANITIZE_NULL
> in the code quoted above (i.e. the code in the error messages).
> That seems slightly more robust than a cast to unsigned int (say),
> since "+ 0" will work even if the values become 64-bit quantities
> in future.
> 
> Richard

Hi, Richard,
I have sent out the v6[1]. I re-tested native/cross-compile, and tested
all test cases in both cases (make -k check).

The test results of this patch are consistent with the current mainline
(but in my test environment there are some test cases that fail in both).

The current version seems fine to me, please let me know if I'm missing
something :)

[1]https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590602.html

Thanks,
Dan
