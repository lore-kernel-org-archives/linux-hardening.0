Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA38C43381
	for <linux-hardening@archiver.kernel.org>; Thu, 11 Mar 2021 00:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB2964FC0
	for <linux-hardening@archiver.kernel.org>; Thu, 11 Mar 2021 00:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKAxz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:53:55 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.187]:22773 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhCKAxr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Mar 2021 19:53:47 -0500
X-Greylist: delayed 1419 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 19:53:47 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 74C27677B
        for <linux-hardening@vger.kernel.org>; Wed, 10 Mar 2021 18:30:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id K9DIlOcmV4HRaK9DIlLuJA; Wed, 10 Mar 2021 18:30:04 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IVp+D5ngPgJh67ftvyE6xrk8nW5+K74JaggZY6ytuHk=; b=xn5E9POAef9bJ+ptTGbDK0Zwwj
        ffMrR++GHjre1gaFyd5b5gc2FVbHGvnt++KhIf6vE+V6Ix3Wn27kvEUFfd3wL024v2XaUKRx+MBtV
        MhWn4CXLLkaMJYS2KuLwfZ9Sqt8hZLvaDMzrLU20Kl/Tm0ss4tBxaPBigQfcURPx/49wkXJDy4DhS
        /I4fmsOZ8scZg8w7ZmxqZElDdtEbxtnbwnjUp4BwfCbieuQX9afayJdy94pO3ufimgPFaZcbD8nLE
        jLtC4FyCLd0fF9HoMxM4MPTau2WWF/CA9dLuTHDIFWV/UPq4wfdG97BerjoQHGXvDGCLVnm4NOHol
        SW8qJMpw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:37248 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lK9DF-000C5R-8Q; Wed, 10 Mar 2021 18:30:01 -0600
Subject: Re: [PATCH RESEND][next] net: fddi: skfp: smt: Replace one-element
 array with flexible-array member
To:     patchwork-bot+netdevbpf@kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210310053020.GA285050@embeddedor>
 <161541001322.4631.9353418857570325428.git-patchwork-notify@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <64f31d62-7c2b-dccd-2461-ee07c79a55ab@embeddedor.com>
Date:   Wed, 10 Mar 2021 18:30:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161541001322.4631.9353418857570325428.git-patchwork-notify@kernel.org>
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
X-Exim-ID: 1lK9DF-000C5R-8Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:37248
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 3/10/21 15:00, patchwork-bot+netdevbpf@kernel.org wrote:

> This patch was applied to netdev/net-next.git (refs/heads/master):

Thanks for this and for the others!
--
Gustavo
