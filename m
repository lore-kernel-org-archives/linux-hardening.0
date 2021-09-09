Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07174C433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 20:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E006115A
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 20:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhIIU3D (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233423AbhIIU3D (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 9 Sep 2021 16:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F45F6054F;
        Thu,  9 Sep 2021 20:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631219273;
        bh=fnkQqJX1niYT9H/+a/DbaGfg4H9TSYi5/PmDtGfAYlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1v3wdMHmHXPx0mm0Iv+Ti+xSLjrlUVq54qI/K7/iCGbcF+7jzjIfxiT1dWPKnFZS2
         /Qw8w/OMqmCHdh90tTVnkg2cmFNO99csuW2dlqkXf6xmYx+JkHsU1YFlmb8Xmsb21Z
         6Cj4vdNRLdPmF8vHasQYu+FzkMJ7J7xW7DK9zl/c=
Date:   Thu, 9 Sep 2021 13:27:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rapidio: Avoid bogus __alloc_size warning
Message-Id: <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
In-Reply-To: <20210909161409.2250920-1-keescook@chromium.org>
References: <20210909161409.2250920-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu,  9 Sep 2021 09:14:09 -0700 Kees Cook <keescook@chromium.org> wrote:

> GCC 9.3 (but not later) incorrectly evaluates the arguments to
> check_copy_size(), getting seemingly confused by the size being returned
> from array_size(). Instead, perform the calculation once, which both
> makes the code more readable and avoids the bug in GCC.
> 
>    In file included from arch/x86/include/asm/preempt.h:7,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:55,
>                     from include/linux/mm_types.h:9,
>                     from include/linux/buildid.h:5,
>                     from include/linux/module.h:14,
>                     from drivers/rapidio/devices/rio_mport_cdev.c:13:
>    In function 'check_copy_size',
>        inlined from 'copy_from_user' at include/linux/uaccess.h:191:6,
>        inlined from 'rio_mport_transfer_ioctl' at drivers/rapidio/devices/rio_mport_cdev.c:983:6:
>    include/linux/thread_info.h:213:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
>      213 |    __bad_copy_to();
>          |    ^~~~~~~~~~~~~~~
> 
> But the allocation size and the copy size are identical:
> 
> 	transfer = vmalloc(array_size(sizeof(*transfer), transaction.count));
> 	if (!transfer)
> 		return -ENOMEM;
> 
> 	if (unlikely(copy_from_user(transfer,
> 				    (void __user *)(uintptr_t)transaction.block,
> 				    array_size(sizeof(*transfer), transaction.count)))) {

That's an "error", not a warning.  Or is this thanks to the new -Werror?

Either way, I'm inclined to cc:stable on this, because use of gcc-9 on
older kernels will be a common thing down the ages.

If it's really an "error" on non-Werror kernels then definitely cc:stable.

