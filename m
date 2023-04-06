Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E703C7618D
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 18:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDFSSD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 14:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDFSSC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 14:18:02 -0400
Received: from omta35.uswest2.a.cloudfilter.net (omta35.uswest2.a.cloudfilter.net [35.89.44.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2DA3
        for <linux-hardening@vger.kernel.org>; Thu,  6 Apr 2023 11:17:57 -0700 (PDT)
Received: from eig-obgw-5019a.ext.cloudfilter.net ([10.0.29.142])
        by cmsmtp with ESMTP
        id kPDhpbeqXE9lPkUBIpxLr8; Thu, 06 Apr 2023 18:17:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id kUBHplH7T4T4FkUBIpdYzQ; Thu, 06 Apr 2023 18:17:56 +0000
X-Authority-Analysis: v=2.4 cv=DJucXgBb c=1 sm=1 tr=0 ts=642f0cd4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=r5y7L3YFV7pC399TSlF17w==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10
 a=wYkD_t78qR0A:10 a=_Wotqz80AAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=5PrvhKeIWMso7PqsVc4A:9 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lV0u8gCzN+IVJnUOSxifOKoxf9sWC9J5lL5XQpoJLvo=; b=GW5vBFG8RNacOKxrvZIq9qCZzf
        miMkjyb/m61EfNcnfNBlyT9HaIt8j5v1iQT7sb/qhYLUgG27dGGeVZ0YWpF2swgs67QssFrEJ1CI4
        jk56vZs7kU48nCC5hb7q2OFlHScCDlyTKSKVfb+acgN1kBeMaJ6iZg2Ggf9jwY+enI0shFYSiudDN
        ONMpOvMzbbygGQjCgZ6jV7g537ihKqQ5xOGADQgWHBXjK0GHD6fUmuLUq0KT3BSSdPthPN3qbIJ63
        yv0IuE+A5RXa/DnxQ4STpskWezTCgef30Fo+n/HfODTruPstLHQoZoGvJNsy13OqM8G9iv2D5XsDY
        NRaJiGtw==;
Received: from 187.184.158.238.cable.dyn.cableonline.com.mx ([187.184.158.238]:28874 helo=[192.168.0.24])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pkSS9-003zjR-7q;
        Thu, 06 Apr 2023 11:27:13 -0500
Message-ID: <e84ea7ad-e804-325a-a17b-5a939e0fc61d@embeddedor.com>
Date:   Thu, 6 Apr 2023 10:27:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH][next] drm/i915/uapi: Replace fake flex-array with
 flexible-array member
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZBSu2QsUJy31kjSE@work>
 <ef8d083a-a82b-669c-0b0a-959e0f120a26@embeddedor.com>
 <87ileh2yky.fsf@intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <87ileh2yky.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.158.238
X-Source-L: No
X-Exim-ID: 1pkSS9-003zjR-7q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.158.238.cable.dyn.cableonline.com.mx ([192.168.0.24]) [187.184.158.238]:28874
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOcTbaJ/hS7WYOR69Ic+YFUfv2JlVwcWNqpowKuxkGCSYG9ySt3fDaktQ8oC21AzTmrqq2KvUWh+H2uTKa/NSLMgW8XiTXHCnr+xcIrrmgWSIUAxqTW+
 CPsdfXmFD76L7GRCx+3fYfUMYOz07EIeQgn6fRceiNY9UBJA4gPfr42YQQpZiT/lSOZwah24I4KZrysxOcXyXHx810U6n7cR3hc11PUWw1Eit9IjJCKfNHXx
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 3/31/23 01:02, Jani Nikula wrote:
> On Thu, 30 Mar 2023, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>> Friendly ping: who can take this, please? 😄
> 
> It's in drm-intel-gt-next.

Awesome. :) Thank you!

--
Gustavo

> 
> commit 02abecdeebfcd3848b26b70778dd7f6eb0db65e1
> Author:     Gustavo A. R. Silva <gustavoars@kernel.org>
> AuthorDate: Fri Mar 17 12:18:01 2023 -0600
> Commit:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> CommitDate: Tue Mar 21 08:41:18 2023 +0000
> 
>      drm/i915/uapi: Replace fake flex-array with flexible-array member
> 
> 
