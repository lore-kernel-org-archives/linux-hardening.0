Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC2CC433ED
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 00:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C4361166
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 00:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbhERAm3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 May 2021 20:42:29 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.107]:41958 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235470AbhERAmZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 May 2021 20:42:25 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 41CF752D6
        for <linux-hardening@vger.kernel.org>; Mon, 17 May 2021 19:41:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id innIl1yfT8ElSinnIlW7SC; Mon, 17 May 2021 19:41:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pbpl9jwNpghY8UxBudIui3lu4/5noqBFoDwVGTFEH8g=; b=tFCTvJ4oaHLPJ8rKrWC+CExEbs
        cY2hOL3IRdYYJmQD1lgeLY1NYejqCqFzvMG8u9EzAREEMKwfId3ad/YNd8TlSW58gTE9BrgihqtQt
        1eWAoLjLev+wFFK3SuN8TZaCfzasIUiggJ902zEN3GCQTWbLNQHFZQUI5iVJxfsuiAm2hBrqJU4n9
        IL532QQ5uDpO3zBxDiAj1lF7IXqgQrUphq+SC2EAz/LQWKYwMx9GZ6j1kIG3bYqPWOwwxoztvFdcT
        3SzbpdNGB47sM/IUrV68Tz2iQR0hVzJAUNQitkaMDWzpLd6VpI0cOta44XPvw8DG2SyzYv8P8mCJW
        5afvSOKg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53494 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1linnF-002hwX-TQ; Mon, 17 May 2021 19:41:05 -0500
Subject: Re: [PATCH][next] firewire: core: Fix fall-through warnings for Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210305074223.GA123031@embeddedor>
 <69b103b8-1955-ce79-57ec-0e9eca48ba6c@embeddedor.com>
Message-ID: <2b6d1493-2dd7-7a4c-d158-00a853a5b9a3@embeddedor.com>
Date:   Mon, 17 May 2021 19:41:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <69b103b8-1955-ce79-57ec-0e9eca48ba6c@embeddedor.com>
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
X-Exim-ID: 1linnF-002hwX-TQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53494
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 63
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

If you don't mind, I'm taking this in my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

On 4/20/21 15:12, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 3/5/21 01:42, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a fallthrough pseudo-keyword.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/firewire/core-topology.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
>> index ec68ed27b0a5..b63d55f5ebd3 100644
>> --- a/drivers/firewire/core-topology.c
>> +++ b/drivers/firewire/core-topology.c
>> @@ -58,6 +58,7 @@ static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
>>  		case SELFID_PORT_PARENT:
>>  		case SELFID_PORT_NCONN:
>>  			(*total_port_count)++;
>> +			fallthrough;
>>  		case SELFID_PORT_NONE:
>>  			break;
>>  		}
>>
