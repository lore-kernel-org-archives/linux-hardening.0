Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DFEC433ED
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 00:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E2B61184
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 00:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhERADo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 May 2021 20:03:44 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.82]:44017 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239063AbhERADo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 May 2021 20:03:44 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id E2E828284
        for <linux-hardening@vger.kernel.org>; Mon, 17 May 2021 19:02:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id inBqlwxsqMGeEinBqlzPFN; Mon, 17 May 2021 19:02:26 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rGr6+qMMJocwMXuMLsw5MiXm4TZdt9GYUPCcl+Bo3Sg=; b=YZr3b7rSqOBpWX0yMK9DXiPpGQ
        3E+JvH/qrCKrT8hJGrxJhIfU96peRVHG3ZK8avDiXVXy0XnhBS4QoYS0xy4dZDKDa23PMy8uVBijP
        XqdcS8FgAGh38r7xsD/aRym4Jehq0pDqi7efLTxWXM/AJNdNjZvV75xo5syxaxiXp8tZ22zkW5zdh
        qrtad2cw2EODRM1kse5M3wpCMm1A2wk8hB2y/yzFPdeHnNIP+MwUPsBh94Oi/dYI24zHm1z3vKrX0
        gnxE2lrYkuU7wACMbkfESxItjHeXGdIzYt3ITV8lT4xgnlNh3zYUu2HXeW05NA1fKjbPn9Ux9IAqx
        BmXJP0Ng==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53362 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1linBo-0022dd-Jd; Mon, 17 May 2021 19:02:24 -0500
Subject: Re: [PATCH 051/141] reiserfs: Fix fall-through warnings for Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <6859fecccd96f79612f9650fdba7a66bbff70560.1605896059.git.gustavoars@kernel.org>
 <7229aa6e-9943-9568-faf2-7c8cd81e6890@embeddedor.com>
Message-ID: <cb6bd498-9864-c884-f844-838796443531@embeddedor.com>
Date:   Mon, 17 May 2021 19:03:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7229aa6e-9943-9568-faf2-7c8cd81e6890@embeddedor.com>
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
X-Exim-ID: 1linBo-0022dd-Jd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53362
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

I'm taking this in my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

On 4/20/21 15:23, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 11/20/20 12:32, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  fs/reiserfs/namei.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
>> index 1594687582f0..90bb49bfdba0 100644
>> --- a/fs/reiserfs/namei.c
>> +++ b/fs/reiserfs/namei.c
>> @@ -132,6 +132,7 @@ int search_by_entry_key(struct super_block *sb, const struct cpu_key *key,
>>  			return IO_ERROR;
>>  		}
>>  		PATH_LAST_POSITION(path)--;
>> +		break;
>>  
>>  	case ITEM_FOUND:
>>  		break;
>>
