Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598CCC07E9D
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Sep 2022 16:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIWQ5u (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiIWQ5Y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Sep 2022 12:57:24 -0400
Received: from omta37.uswest2.a.cloudfilter.net (omta37.uswest2.a.cloudfilter.net [35.89.44.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F0149784
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 09:57:22 -0700 (PDT)
Received: from eig-obgw-6016a.ext.cloudfilter.net ([10.0.30.207])
        by cmsmtp with ESMTP
        id bdXEoveBAqEICblzNoVNsw; Fri, 23 Sep 2022 16:57:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id blzMoZAHzWtOfblzMo5aOc; Fri, 23 Sep 2022 16:57:21 +0000
X-Authority-Analysis: v=2.4 cv=TdKFCDch c=1 sm=1 tr=0 ts=632de571
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=FqOIB2A0pCpItkPd+H5VLg==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=xOM3xZuef0cA:10
 a=wYkD_t78qR0A:10 a=1Vq8JeZ7YxIarabX38cA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FLY2ZY7ymRr6++gvseBT22t1fbdbp4dMhqB4jOqPPM8=; b=JfrxsHO/L0pRqzR5yIPhwxR8tC
        PSS37c4n08S2ZiudUSufuraw+SgKPf8+MkA1dUQmo8Gm8OtQ7K2B+HM0EdWMSNFDu+Pm9L+Rn2bFb
        OS9JoS29kihy6g/Z4Y/kABajSDd+o92IszuhMmcytgmETEy70wrbu6VcILf6k+IXagWtZSJHieFi/
        bKzd3XbNaOo3LrqAHGwbttQChLl/dAgrHWEsaeC+bMcQaCsIATwgJMx6vZnLSTZk9mv2IWLWMmYxd
        fItcyeKzD1loGySu8CLY+EmFzvxWJTx+NYrEMSNUg+Nmm3nD7/q0+5+5dFzEQpFXRjZycD3K+81rV
        eD6acjLA==;
Received: from 187.184.158.46.cable.dyn.cableonline.com.mx ([187.184.158.46]:65034 helo=[192.168.0.24])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1oblzL-0014A3-2i;
        Fri, 23 Sep 2022 11:57:19 -0500
Message-ID: <80657fb9-97cf-0677-bc2d-0dbbac2b610a@embeddedor.com>
Date:   Fri, 23 Sep 2022 11:57:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH][next] powerpc: Fix fall-through warning for Clang
Content-Language: en-US
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Scott Wood <oss@buserror.net>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hardening@vger.kernel.org
References: <Yxe8XTY5C9qJLd0Z@work>
 <166393161454.498456.8335142306216879652.b4-ty@ellerman.id.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <166393161454.498456.8335142306216879652.b4-ty@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.158.46
X-Source-L: No
X-Exim-ID: 1oblzL-0014A3-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.158.46.cable.dyn.cableonline.com.mx ([192.168.0.24]) [187.184.158.46]:65034
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMwjsHcWT1wJF2FMfNuU9Ywyn2Y1FQGyYdbrJvfMkIu2lxkM9wLJJQAB3Nz3y0cB1yYjRok8LF7XbLoEBHvDkvFrhc06t9ZFDZwSmwYDnDJRsErlwtlK
 lJ/721cDKNwsWmSrIAWclvrKrHEUoMi0HeiUY0JbuBX7E2cA2VFFa0qPzOTmw57SRN8w5Hyy0V3EID4gADBrz05Yuq4y9bv5sKkonhyIE7MnZ/f6NoqSkide
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


> Applied to powerpc/next.

Great. :)

Thanks, Michael.
--
Gustavo
