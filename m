Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE003C4338F
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Aug 2021 11:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B70A6113B
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Aug 2021 11:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbhHELAU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhHELAT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Aug 2021 07:00:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1CAC061765;
        Thu,  5 Aug 2021 04:00:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l8-20020a05600c1d08b02902b5acf7d8b5so2674130wms.2;
        Thu, 05 Aug 2021 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GdKJ/76XIyi+KqTfYxSG/ISbmFlzZeKfXC5olcHHZYA=;
        b=Ed2NCkfiEeQv+1lxfHlAxCbsDzsRcZc5cKSsHL6LvgrzEmyr1guxXIhkGGggE2/veo
         3N6CEv7zxTyBjcnIOHdn7vasLopKd4dmyG1Iy16EL1DXRYChOcHNSqsWiNxjiQXOw35A
         5tYiJqnXmebaQDA2ZQkliOk7foDVCDfqHyj2WygsqOqWva/vQooYqIkyTcjmcA8YpG/O
         fv6hG22viPu+sa4x1/cj1coFHlI/jNkgtJArfDDfcSHjauSyRmyNo7c10f71YTeZ/jht
         rkRfcPsOZ1/Xj9q0hkgpTx1VhZE0/TIcsAhtPq+rksPoMXLTDGY65LB5K64na0xYm/XO
         c3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GdKJ/76XIyi+KqTfYxSG/ISbmFlzZeKfXC5olcHHZYA=;
        b=ZQU6BVzTHejAP3GDjp5PkAI36pRIoF0bpnFavjOFiMA0oQTvzcp7qeQIkpCPz38eGV
         lOKu1pMNNq99oIfBALwq48OhoaW6nu637CnuE1Fm/CKP+UDD59zYR3w8rGO28tcGhlza
         JuMmruvleGqXrb37lzofJd3Fe4bACbfN2zKpVb1bNT0+7bJFEKcLl3CgG13t+jhABIL+
         JiyqaqEJqoj9BEQYSBbWXSJHmLrjbrUTI8cemR6aECi0J3NGHfsFN93LEFvthuoYK2TX
         kf4YUSS4LG+64a1sGTcJylqJ4/mTR6uxRCQ3c1JjZSOTNZgWMAITdKPL85xOd0HyQ0TB
         vUlw==
X-Gm-Message-State: AOAM533RE4NWGBnwxPyyLKBlyvl4LojW+5dAxwkqnTPfeaa7hbmGkrb/
        DjmxC4eO1SVJQPNt++zzMHsUTMKB3VI=
X-Google-Smtp-Source: ABdhPJyphZzKYyn5WvyxcM7dFRCPY3IH/YfgIZ9plDKy6RucnA2uDC/S0nk18eARVC2mFwicBitbqQ==
X-Received: by 2002:a05:600c:3b08:: with SMTP id m8mr14646736wms.84.1628161203797;
        Thu, 05 Aug 2021 04:00:03 -0700 (PDT)
Received: from [10.0.0.18] ([37.168.176.89])
        by smtp.gmail.com with ESMTPSA id p5sm6394296wrd.25.2021.08.05.04.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 04:00:03 -0700 (PDT)
Subject: Re: [PATCH][next] net/ipv6/mcast: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210804214352.GA46670@embeddedor>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <aaa77803-fb5f-6444-ae2b-d6498ffea252@gmail.com>
Date:   Thu, 5 Aug 2021 13:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804214352.GA46670@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 8/4/21 11:43 PM, Gustavo A. R. Silva wrote:
> Replace IP6_SFLSIZE() with struct_size() helper in order to avoid any
> potential type mistakes or integer overflows that, in the worst
> scenario, could lead to heap overflows.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/net/if_inet6.h |  3 ---
>  net/ipv6/mcast.c       | 20 +++++++++++++-------
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
> index 71bb4cc4d05d..42235c178b06 100644
> --- a/include/net/if_inet6.h
> +++ b/include/net/if_inet6.h
> @@ -82,9 +82,6 @@ struct ip6_sf_socklist {
>  	struct in6_addr		sl_addr[];
>  };
>  
> -#define IP6_SFLSIZE(count)	(sizeof(struct ip6_sf_socklist) + \
> -	(count) * sizeof(struct in6_addr))
> -
>  #define IP6_SFBLOCK	10	/* allocate this many at once */
>  
>  struct ipv6_mc_socklist {
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 54ec163fbafa..cd951faa2fac 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -447,7 +447,8 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
>  
>  		if (psl)
>  			count += psl->sl_max;
> -		newpsl = sock_kmalloc(sk, IP6_SFLSIZE(count), GFP_KERNEL);
> +		newpsl = sock_kmalloc(sk, struct_size(newpsl, sl_addr, count),
> +				      GFP_KERNEL);


I find the current code is more readable.

Please only change IP6_SFLSIZE() definition maybe 

