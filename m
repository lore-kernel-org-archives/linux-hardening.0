Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D85C2B9F7
	for <linux-hardening@archiver.kernel.org>; Mon, 24 May 2021 20:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A426613CC
	for <linux-hardening@archiver.kernel.org>; Mon, 24 May 2021 20:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhEXUYG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 May 2021 16:24:06 -0400
Received: from gateway20.websitewelcome.com ([192.185.4.169]:15421 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232900AbhEXUYF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 May 2021 16:24:05 -0400
X-Greylist: delayed 1400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 May 2021 16:24:05 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 20536400CEA33
        for <linux-hardening@vger.kernel.org>; Mon, 24 May 2021 14:46:30 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lGjKlmD9OFRe9lGjKlhu2C; Mon, 24 May 2021 14:59:14 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CiA82PE7hVTPaKelOYSFnTkobrNKOhOAioZP6OhsoYo=; b=Af/e7v/Waf5X6+OHmRb88tNB8V
        Oq+uMhguLC3ocU21j3Q+TkVYY0Z4GwkGH5zFiF47qrW2J4z1o7Nk3KvXt4uyTUoias1gz6okCrSHD
        eHDL+McVLpNQ31+cZS+iW6UqFPeXl60FfsekYl2cI/WtxfFNZYhGRUyudZgdCVw9elSnwr88j0NN5
        uOZiSVfFjXL0u9eJy9E/T+FbwONvGC3lZx1DO9/FD4QmRS7eSV00e58yTjKiz4Bbg4Rhnvh0DP7rj
        O4alG/6IOwlICJfICrKZlodw8tynHKCGYoLwG+80yxech/z1BySyfd7EV21vTzSJSdW6ZmPGHks9E
        rrWyeNhw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:33224 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1llGjI-00135M-CO; Mon, 24 May 2021 14:59:12 -0500
Subject: Re: [PATCH][next] vfio/iommu_type1: Use struct_size() for kzalloc()
To:     Alex Williamson <alex.williamson@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210513230155.GA217517@embeddedor>
 <20210524134801.406bc4bf@x1.home.shazbot.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <cb4eac12-dfe3-09a0-8b55-17e62f47a47d@embeddedor.com>
Date:   Mon, 24 May 2021 14:59:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524134801.406bc4bf@x1.home.shazbot.org>
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
X-Exim-ID: 1llGjI-00135M-CO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:33224
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 5/24/21 14:48, Alex Williamson wrote:

> Looks good, applied to vfio for-linus branch for v5.13.  Thanks,

Thanks, Alex. :)

--
Gustavo
