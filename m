Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99004C433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Dec 2021 03:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhLFDW4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 5 Dec 2021 22:22:56 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:38083 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230110AbhLFDW4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 5 Dec 2021 22:22:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UzUwfIa_1638760763;
Received: from ashimida.local(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0UzUwfIa_1638760763)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 11:19:25 +0800
Subject: Re: [PATCH] [PATCH,v2,1/1,AARCH64][PR102768] aarch64: Add compiler
 support for Shadow Call Stack
To:     gcc-patches@gcc.gnu.org
Cc:     linux-hardening@vger.kernel.org, hp@gcc.gnu.org,
        Nick Desaulniers <ndesaulniers@google.com>, nsz@gcc.gnu.org,
        pageexec@gmail.com, qinzhao@gcc.gnu.org
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <20211206024125.14562-1-ashimida@linux.alibaba.com>
From:   Dan Li <ashimida@linux.alibaba.com>
Message-ID: <dc686f90-d3c0-13e8-7728-c2bea7061930@linux.alibaba.com>
Date:   Mon, 6 Dec 2021 11:22:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20211206024125.14562-1-ashimida@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 12/6/21 10:41 AM, Dan Li wrote:
> Shadow Call Stack can be used to protect the return address of a
> function at runtime, and clang already supports this feature[1].
> 
> To enable SCS in user mode, in addition to compiler, other support
> is also required (as discussed in [2]). This patch only adds basic
> support for SCS from the compiler side, and provides convenience
> for users to enable SCS.
> 
> For linux kernel, only the support of the compiler is required.
> 
> [1] https://clang.llvm.org/docs/ShadowCallStack.html
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768
> 
> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
>
Add more reviewers :)
