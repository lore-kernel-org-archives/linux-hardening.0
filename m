Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E51EEB64DC
	for <linux-hardening@archiver.kernel.org>; Fri, 14 Jul 2023 18:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjGNSN4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbjGNSNy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 14 Jul 2023 14:13:54 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CD62690
        for <linux-hardening@vger.kernel.org>; Fri, 14 Jul 2023 11:13:33 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id KM9IqRRjoDKaKKNHfqrVjA; Fri, 14 Jul 2023 18:12:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id KNHdqQfWYYHQ7KNHeq2rYF; Fri, 14 Jul 2023 18:12:50 +0000
X-Authority-Analysis: v=2.4 cv=bN8FndyZ c=1 sm=1 tr=0 ts=64b19022
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=ws7JD89P4LkA:10 a=wYkD_t78qR0A:10 a=QX4gbG5DAAAA:8
 a=snExLxxF2foCdKK6ZiwA:9 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KCsVJp5qnfX7Jssk4LxDYEngrFE1DQACmhXzG+7FPBA=; b=M2IOJ51RbQeLWTH+hDTujo/BcT
        FNGZuK6zQ5WsYaZHqy6e15H9gS0lstlxNAYl6nkOh9BrObTSI01DAmMJe+kH1UJWGrbwfRjKj3wVZ
        w+XvmqONUISjI0gjmhcYyH0Shq8M7WpiSJLsFGokjDm3VPjHFrCKY2/l5PKU9/TZ7VaSJR3Kd7u1p
        uTY2pS3Eb6v6ATGGsMcFTfxWmCiptiGBISG4owzTHEMkGc7IF+IN/YI17JqIeJf2KLdhqg8DfDyiN
        J+jUs0Lu3d/IszVp55sQ2rf2wsCXnNhmQPTNBlgQqMxittAJ9wmHEw3lkzaCGock2N4feeHIM7DfP
        vXjo6oYg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:55814 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qKNHc-002I2a-1y;
        Fri, 14 Jul 2023 13:12:49 -0500
Message-ID: <442403e3-317e-8744-3348-dc9823c22074@embeddedor.com>
Date:   Fri, 14 Jul 2023 12:13:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: replace 1-element arrays with flexible arrays
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     alexander.deucher@amd.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-hardening@vger.kernel.org
References: <20230712083137.1080883-1-ricardo.canuelo@collabora.com>
 <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qKNHc-002I2a-1y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:55814
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN4EN746/oN2t7ED/atAGL5D5hBw/GeYvXLE6QJsTlyzpUtXmJahfsnrYlC4E0oJ6vBKaHw3zCu0YkPdGlaC+qz/IfWU9YV2P7iQ2F/gAzXPk1SM0/i7
 zBKz3XM+FPqgw0FpQi4rvPlLPBRU13WeFk3g6BBP5QradN689lJlhmc+2f5LarXRkonvVZyOucrvoFv6MgTkpogWCB+wMCL8DnmR69deLNd836vv8awKsUH3
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 7/12/23 08:12, Alex Deucher wrote:
> On Wed, Jul 12, 2023 at 8:04 AM Ricardo Cañuelo
> <ricardo.canuelo@collabora.com> wrote:
>>
>> UBSAN complains about out-of-bounds array indexes on all 1-element
>> arrays defined on this driver:
>>
>> UBSAN: array-index-out-of-bounds in /home/rcn/work/repos/kernelci/kernelci-core/linux_kernel_mainline/drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/processpptables.c:1249:61
>>
>> Substitute them with proper flexible arrays.
> 
> + Gustavo, Paulo
> 
> I haven't kept up with the flexible arrays stuff.  Is this equivalent
> to a zero sized array?  We've been bitten by these kind of changes in

In terms of size, yes: the size of each array declaration does not
contribute to the overall size of its containing structure.

However, in these cases, using the DECLARE_FLEX_ARRAY() helper is not
required. Simply removing the '1' from the array declaration will suffice.
This helper was created to declare flex-array members in unions, as well
as in structs that contain no other members aside from the array.

In any case, these changes are not complete, as they're only modifying
the struct declaration, hence the size of the struct is affected. Now
the rest of the code where these structs are involved should be audited
and adjusted to accommodate the change in the sizes of the structs.

> the past.  These structures define the layout of data in a rom image
> on the board.  If the struct size changes, that could lead to errors
> in the code that deals with these structures.
> 
> Alex
> 

Thanks
--
Gustavo
