Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE5AC4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 19:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJRTbs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJRTbp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 15:31:45 -0400
Received: from omta37.uswest2.a.cloudfilter.net (omta37.uswest2.a.cloudfilter.net [35.89.44.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F93F6C745
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 12:31:44 -0700 (PDT)
Received: from eig-obgw-5015a.ext.cloudfilter.net ([10.0.29.155])
        by cmsmtp with ESMTP
        id kOh1oUcTwqEICksJToeuBB; Tue, 18 Oct 2022 19:31:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id ksJDo4DWNmDtJksJEo4kQr; Tue, 18 Oct 2022 19:31:28 +0000
X-Authority-Analysis: v=2.4 cv=Se/ky9du c=1 sm=1 tr=0 ts=634eff10
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VLn1U4HDsV/kFU42pi1uTw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10
 a=wYkD_t78qR0A:10 a=cak1eodxRRWiubympP0A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B8sItrIzPT1FhGdQ0ENveK914e997Na/QHZvsstLhtM=; b=EtFXKgE3/C7QhFoXgAIqcn+mHq
        n0jpJ1yc89SZFk3QRIYWQbQFlkZdKqHQVNmC25NtWS58DqjR9hP8X7VDgpmbZ5z9sPBo78pcP7MAk
        lTqwTU8S2sLegbh6wRASDikI9wq5d5HT/2cXKFlzchDXxggEfq6ayJ5Ilamr1vBho8EU0ef/ogJKM
        YBMxKWwKUop1rMOwjLtEFiD+UVGKYS2AwP+8ex28C0DBva22ITFJsYwS3LH59OxtuaMrUIgVfpCrx
        iWHsqSFZKD3WenFiqyFkTrKo3lMyMEXfdNeKKlDBWZrd9FWi4zDzBNtc+T6o3Kz1deV1SN+Xh7ImB
        mfQVRQ2Q==;
Received: from [187.184.159.238] (port=8860 helo=[192.168.0.24])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1oksJ4-0006S8-1O;
        Tue, 18 Oct 2022 14:31:18 -0500
Message-ID: <71935a08-e9d3-5f9e-5b9a-7847bd38b756@embeddedor.com>
Date:   Tue, 18 Oct 2022 14:31:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/6][next] cfg80211: Avoid clashing function prototypes
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1666038048.git.gustavoars@kernel.org>
 <291de76bc7cd5c21dc2f2471382ab0caaf625b22.1666038048.git.gustavoars@kernel.org>
 <202210171939.61FFBE79A7@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202210171939.61FFBE79A7@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.238
X-Source-L: No
X-Exim-ID: 1oksJ4-0006S8-1O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.24]) [187.184.159.238]:8860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFWZmIuXsc88rouhFJP9cO7Dg9j2QVR7fwYeTrpevYC+asbbh1yl9vSTiGrliNnHF+rLH/mOlXvv/iDM/5VpDI3+XWL0KKnvxqe/S5CZ+SGphJkKvXgq
 0wf+Ywc2JqAdtrOx9ZjJpM9P9QqrKcqaa/j+jWMx/xRZLX1exwV5A1NNjjd1ivgUGoOwWZ959nmEeNCHpRuX5Per3kOzG5UvHZtys3O27gqigiGMP9IxcAq4
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 10/17/22 21:41, Kees Cook wrote:

>>   
>>   static const iw_handler	orinoco_handler[] = {
>>   	IW_HANDLER(SIOCSIWCOMMIT,	orinoco_ioctl_commit),
>> -	IW_HANDLER(SIOCGIWNAME,		(iw_handler)cfg80211_wext_giwname),
>> +	IW_HANDLER(SIOCGIWNAME,		cfg80211_wext_giwname),
> 
> This hunk should be in the orinoco patch, I think?

I just didn't want to have this huge patch touching multiple
different files. That's why I decided to split it up into three
separate patches.

But yeah; now it seems like a good idea to merge patches 1 to 3
into just a single patch.

> 
> 
>> [...]
>> +	[IW_IOCTL_IDX(SIOCGIWRETRY)]    = cfg80211_wext_giwretry,
> 
> The common practice seems to be to use IW_HANDLER instead of open-coding
> it like this.
> 
> 	IW_HANDLER(SIOCGIWRETRY,	cfg80211_wext_giwretry),

Yeah; I forget this after reverting Sami's changes:

32fc4a9ad56f ("cfg80211: fix callback type mismatches in wext-compat")

I'll fix it up. :)

Thanks for the feedback!
--
Gustavo
