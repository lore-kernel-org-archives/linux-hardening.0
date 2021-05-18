Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52030C433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 00:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F64A60FF0
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 00:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbhERAq1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 May 2021 20:46:27 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.66]:46942 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232332AbhERAq1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 May 2021 20:46:27 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 378C01B228
        for <linux-hardening@vger.kernel.org>; Mon, 17 May 2021 19:45:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id inrClAKxZ8uM0inrClRtjY; Mon, 17 May 2021 19:45:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5PelUmvPdhuqf+qQYs8s4qvJpvzN1G721JOueSDbgVA=; b=WA3cDtZkj06F3ZXfVXbY5xqfge
        p/pvOVdz/PL1MCUvzhssmeK16Dk2idzs8Mq+Jj+DT4vzqKOXNFGW1mdZGwqmj+XWmi4HBtYz5tR5q
        ConAtX3K/r4e17TfjqHYcbLmPW85Joy/6EbzDoFEjdNwWpIXfc+rYU2SIxQHUdYIEEWI/Cvq8f2jb
        s3fT8WMpyA+hTPZ+dd30/NfPhMObm8alvkRUelAyP0X5pSz+dtkpyGePgJUjsgLK67vP9DIa50Mys
        nYeP7oxK1shzmC6orpo9lvbrDOolb6+4xweIL8gCWTtylaquNkx7tztouf1/USixbrpMTsEbvPKq9
        nUFT72SA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53516 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1linr9-002lO2-Qz; Mon, 17 May 2021 19:45:07 -0500
Subject: Re: [PATCH RESEND][next] hwmon: (max6621) Fix fall-through warnings
 for Clang
To:     Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210305095258.GA141583@embeddedor>
 <20210306031847.GA192807@roeck-us.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <1bd99c46-730e-ee56-96e4-c87f69488f49@embeddedor.com>
Date:   Mon, 17 May 2021 19:45:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210306031847.GA192807@roeck-us.net>
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
X-Exim-ID: 1linr9-002lO2-Qz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53516
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 76
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Guenter,

On 3/5/21 21:18, Guenter Roeck wrote:
> On Fri, Mar 05, 2021 at 03:52:58AM -0600, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
> 
> I Acked those, thus assuming that they would be applied through some
> other tree. If that is not the case, you'll need to let me know. The
> resend only means to me that whatever tree was supposed to pick it up
> did not do it, but it doesn't result in any action from my side.

If you don't mind, I'm taking this in my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

> 
> Guenter
> 
>>  drivers/hwmon/max6621.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
>> index 367855d5edae..7821132e17fa 100644
>> --- a/drivers/hwmon/max6621.c
>> +++ b/drivers/hwmon/max6621.c
>> @@ -156,7 +156,7 @@ max6621_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
>>  		default:
>>  			break;
>>  		}
>> -
>> +		break;
>>  	default:
>>  		break;
>>  	}
>> -- 
>> 2.27.0
>>
