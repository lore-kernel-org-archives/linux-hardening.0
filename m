Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DE5C47082
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 02:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE4F61406
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 02:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFDCmo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Jun 2021 22:42:44 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.89]:40533 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFDCmn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Jun 2021 22:42:43 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 4ADDB400C5AB4
        for <linux-hardening@vger.kernel.org>; Thu,  3 Jun 2021 21:40:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ozlal9iOT1iQOozlalU3dk; Thu, 03 Jun 2021 21:40:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qMM0cCD/sS3bgXzvDEFA6YM7lCN465P/MHPHDxJbKus=; b=ARZ4xLXo1tOVFZDeo4AzSMeP52
        0mLTPCiJym4n3xXY/KH8vvfvunSUUXtQ2tHBBgBzNMJ4q2frjjKa4CJK/KfJky1Q4iIVkt+u+Np5j
        RvvL30zTgNE8weSa1cVfNzKS5WOOGxCEpKEW+dhLA+dnhDbuQq9PwZPi3qac2+5NyO5lbF+xUAbIC
        NesBQBo16pf0btS89UItxKzDgSvxxu3717peKLLiDZNYkygt4+NW3YAekCxweATgVLbxZLsso8Qlu
        WQpNNJDjqX3fv7Go02a9IojZB81qDOzQV2ycC2Kd5g0JsFoxLyJ2AGHP01B+RZUg7xxPWwwPQJ6n+
        Yx+d6cCg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:33686 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lozlX-003UeG-RN; Thu, 03 Jun 2021 21:40:55 -0500
Subject: Re: [PATCH v2][next] floppy: Fix fall-through warning for Clang
To:     Denis Efremov <efremov@linux.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210528200335.GA39252@embeddedor>
 <07887f9c-c33d-9398-4939-2f23ebb1d094@linux.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <6d120554-3c51-59f1-80d9-e4be0a0ace3e@embeddedor.com>
Date:   Thu, 3 Jun 2021 21:42:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <07887f9c-c33d-9398-4939-2f23ebb1d094@linux.com>
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
X-Exim-ID: 1lozlX-003UeG-RN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:33686
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 5/29/21 01:37, Denis Efremov wrote:
> Hi,
> 
> On 5/28/21 11:03 PM, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Link: https://lore.kernel.org/linux-hardening/47bcd36a-6524-348b-e802-0691d1b3c429@kernel.dk/
>> Suggested-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied, thanks!
> https://github.com/evdenis/linux-floppy/commit/6eaddb2a2aa3acd0660537f9f6a12785be0ae830
> 
> I will send it to Jens with other floppy patches.
> It will be in 5.14

Awesome. :)

Thanks, Denis.
--
Gustavo
