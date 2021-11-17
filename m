Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FFCC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8418A60E53
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 18:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhKQSte (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Nov 2021 13:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbhKQStd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Nov 2021 13:49:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDC8C061570
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 10:46:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so6015782pja.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 10:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3NBdeMa7UJMp4oi4jtQR34QCAkYIt9zpa2vLRHjbdpw=;
        b=lN5cP4MflcVUN1WmXVMPFWM/aHOSEKfEgvuMYKcvxfCau4pbSypcVZjz+3oM9xySCt
         xXwZYEeHT49QEC/pMboGvTGIhGFLwLLKXvlT/X/vaSTO9UGAGdPNNOFBQpnSf19pSoBm
         fUIv/Hbym58VbLb6LtebxSLCy7urH0Rc43Oj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NBdeMa7UJMp4oi4jtQR34QCAkYIt9zpa2vLRHjbdpw=;
        b=cf9fNwk1qs+YkHFpeUrMTT8qnu41hbVXJRbUYPtKYmXycvfTdnPaC4GKj3DBMAOydC
         Aumw2dUe3T25AqRVuLHPd9SlcrwqjcvZwAElSFliUph8udjbr5bmrzK3GUb/ikFc16rg
         HpSmFL/5cLctHBU4YU1XhOmDh9nQhnX5YF8rbDOEZIZa8ivGx3YHDZIJaTehMwan9ebO
         QqqRy8jUKe00H5Wlsiea+Y2YqCaTh0Y0xfFkdF0Aw46HLXWE5ZOhGtJi/8fMLNCcYXuM
         UswF992id0HRSD8tS9WW6zyWRUlVGBCiDmKOKwlmj+JA1b7ah/H8rrTSMLS88WnHj3is
         +J3w==
X-Gm-Message-State: AOAM531YfuSQsBRTK0Ku+f40xVBr9KcCt85WcKfxw6z1PDJT2wbnCYh9
        2EWynjzcBVnCRFRl2/7q078e/g==
X-Google-Smtp-Source: ABdhPJw+8DZ051H38mziwHvk/XKKV65pKWaK+EuXnBraSMFA9Kra9YEDD6X9lyJxzsX4nTdCK+RgCw==
X-Received: by 2002:a17:90b:1b45:: with SMTP id nv5mr2352297pjb.120.1637174793988;
        Wed, 17 Nov 2021 10:46:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u9sm362856pfi.23.2021.11.17.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 10:46:33 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:46:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] ipv6: check return value of ipv6_skip_exthdr
Message-ID: <202111171046.A3390D8A4A@keescook>
References: <20211117181610.2731938-1-jordy@pwning.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117181610.2731938-1-jordy@pwning.systems>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 17, 2021 at 07:16:10PM +0100, Jordy Zomer wrote:
> The offset value is used in pointer math on skb->data.
> Since ipv6_skip_exthdr may return -1 the pointer to uh and th
> may not point to the actual udp and tcp headers and potentially
> overwrite other stuff. This is why I think this should be checked.
> 
> Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> ---
>  net/ipv6/esp6.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index ed2f061b8768..dc4251655df9 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -808,6 +808,11 @@ int esp6_input_done2(struct sk_buff *skb, int err)
>  		struct tcphdr *th;
>  
>  		offset = ipv6_skip_exthdr(skb, offset, &nexthdr, &frag_off);
> +
> +		if (offset < 0)
> +			err = -EINVAL;
> +			goto out;
> +

Oh, and, this needs { }s. The CI noticed too:
https://patchwork.kernel.org/project/netdevbpf/patch/20211117181610.2731938-1-jordy@pwning.systems/

>  		uh = (void *)(skb->data + offset);
>  		th = (void *)(skb->data + offset);
>  		hdr_len += offset;
> -- 
> 2.27.0
> 

-- 
Kees Cook
