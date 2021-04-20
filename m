Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C7C433ED
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106D7610CC
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhDTUN5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:13:57 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.129]:45095 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233619AbhDTUN4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 16:13:56 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id E943D9EBD
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 15:13:23 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwkNlGp1VL7DmYwkNlOvYR; Tue, 20 Apr 2021 15:13:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kwn27XPvL7L4MySMkc9jhbsfHOaD1hq6LTYrwrBKc5k=; b=XBR2TAs0kONA6akjKuCET67sS4
        VK1GhBxbFwf0hGWB0SDWujk3fuUfvucOreXyZZo5GJFSFPQPe4aSatHaL+7CtjxT2lQxI+zZTyJZJ
        cqu6zlJDA49x71dUZn2bzG9XJiUjx0kj+EMaTwg7bVmTxcXN8IfhngLGwBOIHo2OBxHYLf+kjZBVO
        hrVjI5lDk80/AgnT/DgWf1IjmddLgTdw3DRVHx+cEL8Ej1IZDEDvfAWISldYsbCyNxrGzLwF5+Tg5
        nnCEY4+flJTo47vZedRu4EkSK3WKwPScVlMXBzp6L0RvTa2RRAEyOVJzQ6ayjLkJdrVv3kT0ZxNqs
        XGWq28yg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:48978 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwkK-002lDZ-GL; Tue, 20 Apr 2021 15:13:20 -0500
Subject: Re: [PATCH RESEND][next] drm/nouveau/clk: Fix fall-through warnings
 for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210305095609.GA141907@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b42a6c20-e70d-c56a-795a-072ecc772bf2@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:13:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305095609.GA141907@embeddedor>
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
X-Exim-ID: 1lYwkK-002lDZ-GL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:48978
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 99
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 3/5/21 03:56, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
> index 83067763c0ec..e1d31c62f9ec 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
> @@ -313,6 +313,7 @@ nv50_clk_read(struct nvkm_clk *base, enum nv_clk_src src)
>  		default:
>  			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> 
