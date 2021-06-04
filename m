Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD3DC4743C
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 22:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E7B611AD
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 22:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFDWg0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Jun 2021 18:36:26 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.196]:27460 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhFDWgZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Jun 2021 18:36:25 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 54A844EC24
        for <linux-hardening@vger.kernel.org>; Fri,  4 Jun 2021 17:34:37 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pIOjlaaQLnrr4pIOjlOB98; Fri, 04 Jun 2021 17:34:37 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XA12cp7ynhMAEH54lOEwZBVx4LD7D6e8YZBsV4bbWMo=; b=qXRBkbDnYeATLgkZpF9A25MMmf
        A8+XRPxmINJveeMuWgqaVvB1EViKtJNX7bO8ciZVUPugpz23Bf2cXuV2GPAdykMKKY07N5iMCZr5H
        pJkmUUAZW0i+pJDQeMry9P2Bj0SJlJ0Dnw2Hv7V9rs1zU2ifzLxv52PLW6aT8qOcs4tN3sHCiFZoI
        EuQ/bo0rdnSrHC4Y5nIh+BabdChM0KxJU0wRt6614I+TKclAJFhe1oyQMMe3MWBOpWvUnxNjL07OG
        saZwXR4V76ksyGZyfYmh+VI6M8VCxYc4Kc6jjqfHx4Vn5ZB/i72u49sPdTidKEwa3l4EaYPilB5c2
        TsER2kaA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:39202 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lpIOf-002h86-R6; Fri, 04 Jun 2021 17:34:33 -0500
Subject: Re: [PATCH RESEND][next] rxrpc: Fix fall-through warnings for Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210305091900.GA139713@embeddedor>
 <7137db63-20ea-29b2-7b8e-e2edd0c42bdd@embeddedor.com>
Message-ID: <e34e5b36-fc3d-3abf-34a5-0963cce25059@embeddedor.com>
Date:   Fri, 4 Jun 2021 17:35:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7137db63-20ea-29b2-7b8e-e2edd0c42bdd@embeddedor.com>
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
X-Exim-ID: 1lpIOf-002h86-R6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:39202
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

If you don't mind, I'm taking this in my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

On 4/20/21 15:09, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 3/5/21 03:19, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  net/rxrpc/af_rxrpc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
>> index 41671af6b33f..2b5f89713e36 100644
>> --- a/net/rxrpc/af_rxrpc.c
>> +++ b/net/rxrpc/af_rxrpc.c
>> @@ -471,6 +471,7 @@ static int rxrpc_connect(struct socket *sock, struct sockaddr *addr,
>>  	switch (rx->sk.sk_state) {
>>  	case RXRPC_UNBOUND:
>>  		rx->sk.sk_state = RXRPC_CLIENT_UNBOUND;
>> +		break;
>>  	case RXRPC_CLIENT_UNBOUND:
>>  	case RXRPC_CLIENT_BOUND:
>>  		break;
>>
