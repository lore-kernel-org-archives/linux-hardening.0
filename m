Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3E9C433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 00:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAEF561166
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 00:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbhERAeL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 May 2021 20:34:11 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.187]:35541 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345118AbhERAeJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 May 2021 20:34:09 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 42CE76773
        for <linux-hardening@vger.kernel.org>; Mon, 17 May 2021 19:32:52 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id infIl3oenvAWvinfIlDn0Z; Mon, 17 May 2021 19:32:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J+ny7KcWHWHIUXMG+TJWF0K4cp8fIowxW6oz98D64vk=; b=bPygefkyDCsddqWESNal7ncvij
        Py7cIK8xzcH4srnyTyKrfDM7BAILvAr/HigRw/vBJXsrs6yBplxeri0Pb5zixbjmi+CV4tb9e7jgK
        ZJb5FetDXddNW9uFdtVbmBE0wTlgecjGSOXLEIQxZdeLwyn+cfubMdhfEm5uA63TfJWtQ5RLdI/D3
        j/rrmMiWVjZEavJbn2u72lcqtXFRXeMynaosFgwxxQE/EIxBOmMZN5wGH9a9JASq/sFMw9zOThsYe
        NZlRrtKnwQosyGrTLil640ttd2aTqQHhpcZKDtkHU5ZjdxnNm+dd0StfHulOhKJZH71UPGLxiLxCy
        5sM+l8Vw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53472 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1linfF-002a7c-T7; Mon, 17 May 2021 19:32:49 -0500
Subject: Re: [PATCH v2][next] afs: Fix fall-through warnings for Clang
To:     Jeffrey E Altman <jaltman@auristor.com>,
        "Gustavo A. R. Silva (gustavoars@kernel.org)" <gustavoars@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210420211615.GA51432@embeddedor>
 <45926d81-cfae-8465-84e6-af76d668c1ef@auristor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <c143cfde-c761-a19f-deef-2dc61a8b8947@embeddedor.com>
Date:   Mon, 17 May 2021 19:33:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <45926d81-cfae-8465-84e6-af76d668c1ef@auristor.com>
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
X-Exim-ID: 1linfF-002a7c-T7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53472
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 54
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 4/21/21 18:03, Jeffrey E Altman wrote:
> On 4/20/2021 5:16 PM, Gustavo A. R. Silva (gustavoars@kernel.org) wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
>> warnings by explicitly adding multiple fallthrough pseudo-keywords
>> in places where the code is intended to fall through to the next
>> case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> Changes in v2:
>>   - Place blank line after the fallthrough markings, not before.
>>     Link: https://lore.kernel.org/linux-hardening/748935.1606147853@warthog.procyon.org.uk/
> 
> This change looks good to me.
> 
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com>

Thanks, Jeffrey.

Could someone take this, please?

Thanks
--
Gustavo

