Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A406CC433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 22:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56885613FD
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 22:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhDTWRM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:17:12 -0400
Received: from gateway30.websitewelcome.com ([192.185.148.2]:32479 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233961AbhDTWRL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 18:17:11 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 422268986
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 17:16:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Yyfelo2SSPkftYyfel1oXf; Tue, 20 Apr 2021 17:16:38 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0JXMoyKqnypcp3tv+OUhmcTnA/JRDheSNH3fXOVDZ2k=; b=y/d59vj69GYm6cGv3hSddsiv3+
        muzYePvidICiN4IACqwisBvELhnRXyeq0Knx4C9CoPm7pDnGhGBAla0GtQv2DHzd+H74x1XFehGhS
        pfHk53NScq3qFl1cpogKO7f8P+wm5eitjb2A6LvZDZjSJkyZiOcUU69KHK2L75FRK6xcHwBWJxorj
        vJLttibske92kuScDm4mZbj4PpDMY/rTtJtIXgs+mkgTuuUkNM5S+w2BxGI1A5boGEiVSbo+oxriq
        9hw9cK0Gvqz3LoJP8NFIjPo+bUifnvRjQRgnzgOHr+4ZJVkpC51Nf/6i9IOWkUFfqr6rnKX45ShTy
        dneDqf7g==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:50532 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYyfb-001ji5-RM; Tue, 20 Apr 2021 17:16:35 -0500
Subject: Re: [PATCH 077/141] dm raid: Fix fall-through warnings for Clang
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <d17978db8a2bae019d2c858a51e9f6abf8ea8947.1605896059.git.gustavoars@kernel.org>
 <02133499-e619-77e6-7ec0-79a238258f81@embeddedor.com>
 <20210420221322.GA16676@redhat.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <1b8d7b06-7573-b1cb-e8fd-89462264f705@embeddedor.com>
Date:   Tue, 20 Apr 2021 17:16:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420221322.GA16676@redhat.com>
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
X-Exim-ID: 1lYyfb-001ji5-RM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:50532
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 4/20/21 17:13, Mike Snitzer wrote:

> I've picked it up for 5.13, thanks.

Thanks, Mike.

--
Gustavo

