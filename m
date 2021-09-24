Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2344C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 13:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07BB600D3
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 13:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbhIXNEV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:04:21 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.59]:41145 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345774AbhIXNCP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 09:02:15 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 73D9918BA3
        for <linux-hardening@vger.kernel.org>; Fri, 24 Sep 2021 08:00:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TkoNmHtIIOnCITkoNmq3l6; Fri, 24 Sep 2021 08:00:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=86HTcRv/fRLZQUnGdGHlAvLz99wbnAkzAM/lvuSrZRA=; b=sndPoOwSyUZPjfstyebyGBCeqd
        BhRmSwm/n5kavwP22mwmgrsXCZu6yvk0lxH1O9z9qmg32sEcig18asGM0652ziGb59uk2GEe3ouNU
        HN9sZEmgFB/ACP99Xa0Q3afjEPY2gfVPw7n3pb5PLMczznuQek2mHyYdKfawjdwlCD5VBIFt/lANq
        WgSMzg1G3u3lYb7vrANEhTvaslj6FN/qf4Jscg5uStQ9M4uNAT04ulSYAP0vAPYGiWiKZ7sZFFqcd
        KXNg1mCNNbLjmRfudISXfVMawFwkI8DijIf9MUOiwwwFSdHIlkuA0a6KBFpi4KkyFigHftKu2aZWI
        q2nqXT5g==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:43780 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mTkoN-003pdC-1u; Fri, 24 Sep 2021 08:00:19 -0500
Subject: Re: [PATCH][next] firewire: cdev: Fix function cast error
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210924105733.GA78013@embeddedor>
 <5BB921B7-9D3C-460F-98D1-F277D31DC849@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b0d1d4e2-d8ee-77ed-c9ba-2a61d146b86c@embeddedor.com>
Date:   Fri, 24 Sep 2021 08:04:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5BB921B7-9D3C-460F-98D1-F277D31DC849@chromium.org>
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
X-Exim-ID: 1mTkoN-003pdC-1u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:43780
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 9/24/21 07:47, Kees Cook wrote:

> I thought this looked familiar...
> 
> https://lore.kernel.org/lkml/20200530090839.7895-1-oscar.carter@gmx.com/

Oh, cool. :)

> I think someone just needs to pick this up since it got past review, etc.

Yeah. I can take it in my -next tree if nobody cares.

Thanks
--
Gustavo
