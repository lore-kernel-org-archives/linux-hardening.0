Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEE6C433ED
	for <linux-hardening@archiver.kernel.org>; Mon, 17 May 2021 23:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D31611BE
	for <linux-hardening@archiver.kernel.org>; Mon, 17 May 2021 23:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbhEQXn4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 May 2021 19:43:56 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.210]:23159 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235483AbhEQXn4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 May 2021 19:43:56 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id A16D2400C63A9
        for <linux-hardening@vger.kernel.org>; Mon, 17 May 2021 18:42:37 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id imsfl11Ps8ElSimsflVArQ; Mon, 17 May 2021 18:42:37 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pUQl5MglCGKKS7IhGRWSIeUkYg/NgOYZ/nXO/y92gag=; b=RrPqD2ZYY56SbTGDFH01aj51vJ
        QSfuVWkmO+rHmncLU5WvA3EtRdSKi1s53ULlTofboaKrS/8dJ6BA9HK7zrXQsYabTz64IGUbhTxqN
        y/zsxWscIuIyQGlmR0f1Bbza8GV4JrFhxTOtEOLH68OkgcBDKWPFHbTXTmBRWX+IoomhtpK5ZxnZR
        87M+IC1GXj2PtpfozHyXUOg0rya67s2vh3PfB9bnfYTIAFvhK+oMAEYulUIhC6vdQYW6m+DXIXR94
        BoPVss3XRyOhLlRabIqnontFlIhjs+2AS50ODPFnIUBTQLVVHjHEYicrX9Ky4MSaI8VZx8R8TLwgW
        6FYUFD2w==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53278 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1limsd-001eYf-88; Mon, 17 May 2021 18:42:35 -0500
Subject: Re: [PATCH 061/141] tee: Fix fall-through warnings for Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <c505109fe0c02f648e16caa83d8a9773afd696b1.1605896059.git.gustavoars@kernel.org>
 <CAHUa44G1B8_CSahTJ1uOUMLcDfpVKHUaoN+u87BywkVwyhjnRw@mail.gmail.com>
 <20201123225507.GR21644@embeddedor>
 <e44a9011-f2ed-f1d2-cc1a-7dcba2f41956@embeddedor.com>
Message-ID: <aabd24b1-fe72-946d-c9f4-dea5e5db40db@embeddedor.com>
Date:   Mon, 17 May 2021 18:43:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e44a9011-f2ed-f1d2-cc1a-7dcba2f41956@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1limsd-001eYf-88
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53278
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On 4/20/21 15:20, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 11/23/20 16:55, Gustavo A. R. Silva wrote:
>> On Sun, Nov 22, 2020 at 10:26:09AM +0100, Jens Wiklander wrote:
>>> On Fri, Nov 20, 2020 at 7:33 PM Gustavo A. R. Silva
>>> <gustavoars@kernel.org> wrote:
>>>>
>>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>>>> by explicitly adding a break statement instead of letting the code fall
>>>> through to the next case.
>>>>
>>>> Link: https://github.com/KSPP/linux/issues/115
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>>  drivers/tee/tee_core.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>
>>> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

I've added this to my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp
