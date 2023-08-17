Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FA5C3DA4D
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 16:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347318AbjHQQFS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353446AbjHQQE5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 12:04:57 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B030F1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 09:04:56 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id Wd7kqc6Z7EoVsWfUVq30wd; Thu, 17 Aug 2023 16:04:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WfUUqoAyG1rJFWfUUq2WmY; Thu, 17 Aug 2023 16:04:54 +0000
X-Authority-Analysis: v=2.4 cv=PYPsOwtd c=1 sm=1 tr=0 ts=64de4526
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=OcNJt-qWwfHZ17eyJIQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZA1JnYm2sizdw4HAoCpwZQIm3d+6duiDWNO2aTXtz+s=; b=tAIGDQtxZ2k7asM3pp0AyIqJFG
        ElYb3DfGINfI30f1NWoS43/Q2kA5LnL7npPiggmeAI9cjBcMqlHJKQF5y2/UlfN35IIXRyLXgq5zs
        L52QaFfnykiBoAi3ztaoC2jII8416FhRhiIzch9vPcQtXk1Wd+v6kq+ULedY3mut9sM3KWwSjV+Jx
        mVzWg9gcw26/2tK7lbw+cOg+Jk5pyL5xsAhEtjD4hfPL6EYjrHMyQnHxoeAq1n5T3OXck5M487rxO
        p/MEntWaNpBganNWLSFtpSzELFaOQ27b9rX/9WQ2q+VOp6yxpoepN1Znw/tSZRJrS+gLMjrnsrWjb
        a66BZ2MQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:57282 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWfUU-001S6c-0Q;
        Thu, 17 Aug 2023 11:04:54 -0500
Message-ID: <f12c6f14-66c4-6afb-e768-fa7abcfd1bbc@embeddedor.com>
Date:   Thu, 17 Aug 2023 10:05:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: struct_size() using sizeof() vs offsetof()
Content-Language: en-US
To:     Alejandro Colomar <alx@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
 <202308161913.91369D4A@keescook>
 <09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWfUU-001S6c-0Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:57282
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI/2qMzT4xK4kj0d1IrI7JEvhOmA6O+L8xWVrT7/IvAfLRzlbCadRKrF4OzVgFdykTOZSpbFb1UikjacrNJOyR6jmcXQHdgjSPODgizA9kjjbBSLsDSC
 vsYp0qqDUpu47LGqoqVSZhjyGs7ctBZQdCE6Xkka3pDjA9xmvGRQiO3MA2qSpjRJz8JcO3+S4IjOUbBYhjFOwaIX6sfS5Th9mYpYgj2qlIXM5YYBPKDTqIix
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


> -               tp_c = kzalloc(sizeof(*tp_c), GFP_KERNEL);
> +               tp_c = kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KERNEL);

I just sent a fix[1].

Thanks for reporting this! :)
--
Gustavo

[1] https://lore.kernel.org/linux-hardening/ZN5DvRyq6JNz20l1@work/
