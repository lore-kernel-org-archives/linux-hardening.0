Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF3C61DA4
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 13:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjBCNuG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 08:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjBCNuF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 08:50:05 -0500
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFA299D42
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 05:50:03 -0800 (PST)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id NoL3pmTc7Y6q8NwS2pIEUm; Fri, 03 Feb 2023 13:50:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id NwS1pxpJeHpQPNwS1p24Z6; Fri, 03 Feb 2023 13:50:01 +0000
X-Authority-Analysis: v=2.4 cv=Zpb+lv3G c=1 sm=1 tr=0 ts=63dd1109
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10
 a=wYkD_t78qR0A:10 a=7T_mhvgX4LM0xDefXN8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nfvZ96BrG5fGeqbIzSxz3kPTSkmeAy6LnZ8/UueNOmo=; b=TfEx5VjdpDytiqvVkfKzqhmyig
        GT8JecRLWYtUwnOTw2twgiuRm4WC9U94X6fKQ1Yj7XwOm37pRHOjFxrildsuKtE+4qJic4gh4rnPs
        67jyNrATMKJ0yjuWzcAC2S4ZCAhekqCT8jlcHpD+a1LUvsEgCbaAWB0Y6xRcBp/RiU3ZTcEVYbiYb
        GErA6TjebKlZ1du/teXeLfRQQdOt2rEUAuDXf35t3Eu7LW0V38WphXHgzrN8RYxrjzP3BBDm4OvWQ
        3c9m4CD16oI9nYCrgVKYx0kM1J2eGyoHKotqxPMu7/F8FS9wMNPa2ca7SLGcXTpuUWEAwa9OOWolS
        LXP8+kqw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53588 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pNwS0-003U2j-P0;
        Fri, 03 Feb 2023 07:50:00 -0600
Message-ID: <0dad546c-203a-062c-8922-54d506529cd7@embeddedor.com>
Date:   Fri, 3 Feb 2023 07:50:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <YzIzUjUuJKf0mkKg@work>
 <fcd83e77-a3fb-9061-771a-8509ea6f5950@embeddedor.com>
 <Y9wmnfTi/p4FuRmd@sirena.org.uk>
 <bb43c410-bd8c-66fe-19a1-0f41442838eb@embeddedor.com>
 <Y90ExljX2qCsowhu@sirena.org.uk>
 <652684af-bd10-99da-1ed8-104407493428@embeddedor.com>
 <Y90P3kik6ONZg3U4@sirena.org.uk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Y90P3kik6ONZg3U4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1pNwS0-003U2j-P0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:53588
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ8b0uZC7SJ7TLSGnX12HQcBid3BzVWBff7tMEZ5fCMpbeyk+37XQDAcF8butoVd8hKjQka1EWKZVUfwNljHGAE1NsPynCg5Jsi/mMMPwMDnu04sKGl1
 +N28Tfm5estl4rrm76HgwTIlnufDWaFtYEXcWdEXuxayHfrifAvrc8O+HV1jsDOEv7J8A6GbYAA3jsUV7wUV9xHbdMLD4p4Yi5r0vdlSOCoc2W8fPTa29M6o
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 2/3/23 07:45, Mark Brown wrote:
> On Fri, Feb 03, 2023 at 07:27:03AM -0600, Gustavo A. R. Silva wrote:
> 
>> I think we have run into this same issue (you not being listed in the
>> MAINTAINERS file) at least once in the past, right? (thinkingface)
> 
>> IMHO, the sensible solution for this is to keep the MAINTAINERS file
>> up-to-date. So, get_maintainer.pl can continue to be useful for people.
> 
> Sure, feel free to send an update...

[chuckles]
