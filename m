Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94B7C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 16:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiBPQEV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:04:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbiBPQEV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 11:04:21 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609A2A8D0C
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 08:04:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V4e8LKq_1645027442;
Received: from 192.168.193.149(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V4e8LKq_1645027442)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 00:04:03 +0800
Message-ID: <94c7f7e0-055e-d235-4595-7e335b4ac273@linux.alibaba.com>
Date:   Wed, 16 Feb 2022 08:04:02 -0800
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
>> function at runtime, and clang already supports this feature[1].
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
> 

Ah, apologize for my mistake! I specified --disable-werror in
./configure from the beginning, I didn't see this problem before.

As you said, I use the following patch:

diff --git a/gcc/ubsan.cc b/gcc/ubsan.cc
index 5641d3cc3be..a858994c841 100644
--- a/gcc/ubsan.cc
+++ b/gcc/ubsan.cc
@@ -832,8 +832,8 @@ ubsan_expand_null_ifn (gimple_stmt_iterator *gsip)
    else
      {
        enum built_in_function bcode
-       = (flag_sanitize_recover & ((check_align ? SANITIZE_ALIGNMENT : 0)
-                                   | (check_null ? SANITIZE_NULL : 0)))
+       = (flag_sanitize_recover & ((check_align ? SANITIZE_ALIGNMENT + 0 : 0)
+                                   | (check_null ? SANITIZE_NULL + 0 : 0)))
           ? BUILT_IN_UBSAN_HANDLE_TYPE_MISMATCH_V1
           : BUILT_IN_UBSAN_HANDLE_TYPE_MISMATCH_V1_ABORT;
        tree fn = builtin_decl_implicit (bcode);


And tested fine in native compiling for x86_64 , I will change it in the
next version.

BTW:
The platform I'm using is x86-64, so I'm trying to find a way to
reproduce this issue when cross-compiling with aarch64, which I
haven't found so far, the issue only seems to happen with native
compilation.

But most of the code changes are for the aarch64 platform,
is it enough for me to do the following tests before submitting
the patch?
1) A full compile of gcc under x86_64 platform
(make; make install; make bootstrap;)
2) Test all testsuites in aarch64 cross-compile environment
(make -k check)


Thanks,
Dan
