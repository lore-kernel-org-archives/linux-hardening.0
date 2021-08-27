Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02D0C432BE
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D999660F39
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhH0TVM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Aug 2021 15:21:12 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.93]:16827 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231360AbhH0TVK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Aug 2021 15:21:10 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 50A8C925E
        for <linux-hardening@vger.kernel.org>; Fri, 27 Aug 2021 14:19:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id JhOGm2R2AK61iJhOGm4Lch; Fri, 27 Aug 2021 14:19:48 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aQ+xyVdAGvAkJszGSEZ3M6/27HiFqk27YJnKR6c1e0U=; b=JSlpIlngwa/IPreF54AyFuR7UT
        Y1K3XLtG6XKI+ZFWnF7VbaNzHUPSij3zWFhxqMJjkjQx7clXPLG60TSnQs6r+VOFRychc67nIzlki
        srEq5y4gD4VtYuSV+Jb2MdsSZK7vglXpc8PYfM4mp1A7H8rDSSzr/aN+t/LOQDeEkTWchAHSOtmw6
        JOab9TqTJpayHvMFbJ9DeJt8CqlWa4VtTPMUbuurHvS9+Ts0VXFzMlH1XNqAzTIr3o8U+xHoehWQS
        jJYUGc6KJTHgrDMR43aNUhNzg5IV+tYKnaA4BMVeiNP3uX3idaFiw10vxvDD5J+b6qj7UnP3daNEL
        rp2nkDSg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:36872 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mJhOF-000Q4P-NP; Fri, 27 Aug 2021 14:19:47 -0500
Subject: Re: [PATCH] docs: deprecated.rst: Clarify open-coded arithmetic with
 literals
To:     Joe Perches <joe@perches.com>, Len Baker <len.baker@gmx.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210827171226.2938-1-len.baker@gmx.com>
 <bd7487c725e15b0c20612a44ecf301637a60c157.camel@perches.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <9a338127-0b17-fa9e-96b6-578193ce96f4@embeddedor.com>
Date:   Fri, 27 Aug 2021 14:22:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bd7487c725e15b0c20612a44ecf301637a60c157.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1mJhOF-000Q4P-NP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:36872
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 8/27/21 14:06, Joe Perches wrote:
> On Fri, 2021-08-27 at 19:12 +0200, Len Baker wrote:
>> Although using literals for size calculation in allocator arguments may
>> be harmless due to compiler warnings in case of overflows, it is better
>> to refactor the code to avoid the use of open-coded math idiom.
>>
>> So, clarify the preferred way in these cases.
> []
>> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> []
>> @@ -60,7 +60,8 @@ smaller allocation being made than the caller was expecting. Using those
>>  allocations could lead to linear overflows of heap memory and other
>>  misbehaviors. (One exception to this is literal values where the compiler
>>  can warn if they might overflow. Though using literals for arguments as
>> -suggested below is also harmless.)
>> +suggested below is also harmless. So, the preferred way in these cases is
>> +to refactor the code to keep the open-coded math idiom out.)
> 
> wordsmithing trivia:
> 
> 'keep <foo> out' is difficult to parse as 'keep' is generally a positive
> word but its meaning is later reversed with out.
> 
> 'avoid <foo>' maybe be better phrasing.

+1

--
Gustavo
