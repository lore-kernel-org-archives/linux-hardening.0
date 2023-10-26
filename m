Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B881BDC7
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AVuzpXtw"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8606B1AA
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:20:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1caa7597af9so9119795ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698340856; x=1698945656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLXTzOtavTM4dZPYG+XNWZHVk3Ib4e1r6kiIfRSr4qc=;
        b=AVuzpXtwM12ujd6Ig2dGh9jvvF4/g456JbfTUBTQXvqdNBmDUtwa5DwVIx3GXX5mI5
         lP99tikf+SnYjxxTEyldxsLk5gZZdz8qa1NZb1bX8B7vRw4mgxagYhuE4usDivmFgohE
         jRyD9nj/J+hCyZm32eZb2jGoNJ5hvQPzxfehw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340856; x=1698945656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLXTzOtavTM4dZPYG+XNWZHVk3Ib4e1r6kiIfRSr4qc=;
        b=NRTvCuYxhgXMDuiI3RtBvvwXYaombPo7p1ceh3gUfyrQvDa2QPI10EW9GsDyzLI4MB
         1cAGUWfbqnee+yKLVanJUz9MH35QcaxhYK/6XSrMfoU91UclClXXM0cF8I4SY3iyMo3W
         fS9n/9Z5lne6HLq9Xv8hdc14HQsqZN+PWO7DXir2HhFhoDhuUbY9UqI07VSKZu5lTNPP
         wg5Ih/VxReLSq4owotA3ld6JCfAHQzgz41KFIFkx3AhJJJGREgGu0k/X01VJC5cxXWaQ
         kBQJyXwN2ePQcT56K0TfCuIXn43AZMdVBVAEGREeALxQ9VwinoZC+G74D9jNJ7M/L2k0
         qwYg==
X-Gm-Message-State: AOJu0YwqV+R8e20wxX7yUdjAkw41Xnt3I6Ra2NZSv1vEfULfV+9dSyok
	e8jmXDIfcK/YV7RR/K6/V1OV8w==
X-Google-Smtp-Source: AGHT+IHJSLmUKEy3dGDjKezIZa9WLzUAniS+YJWcgL2oDdL/ykmdEe2bZHw04Ac3YlnVoI5x7iOEJA==
X-Received: by 2002:a17:902:e84c:b0:1c5:d0ba:429 with SMTP id t12-20020a170902e84c00b001c5d0ba0429mr178898plg.4.1698340856010;
        Thu, 26 Oct 2023 10:20:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902694b00b001b016313b1dsm11240816plt.86.2023.10.26.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:20:55 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:20:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com,
	SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/2] wifi: brcm80211: replace deprecated strncpy with
 strscpy
Message-ID: <202310261020.2D4DB7177@keescook>
References: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
 <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-1-af780d74ae38@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-1-af780d74ae38@google.com>

On Tue, Oct 17, 2023 at 08:11:28PM +0000, Justin Stitt wrote:
> Let's move away from using strncpy and instead favor a less ambiguous
> and more robust interface.
> 
> For ifp->ndev->name, we expect ifp->ndev->name to be NUL-terminated based
> on its use in format strings within core.c:
> 67 |       char *brcmf_ifname(struct brcmf_if *ifp)
> 68 |       {
> 69 |            if (!ifp)
> 70 |                    return "<if_null>";
> 71 |
> 72 |            if (ifp->ndev)
> 73 |                    return ifp->ndev->name;
> 74 |
> 75 |            return "<if_none>";
> 76 |       }
> ...
> 288 |       static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
> 289 |                                              struct net_device *ndev) {
> ...
> 330 |       brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
> 331 |                 brcmf_ifname(ifp), head_delta);
> ...
> 336 |       bphy_err(drvr, "%s: failed to expand headroom\n",
> 337 |                brcmf_ifname(ifp));
> 
> For di->name, we expect di->name to be NUL-terminated based on its usage
> with format strings:
> |       brcms_dbg_dma(di->core,
> |                     "%s: DMA64 tx doesn't have AE set\n",
> |                     di->name);
> 
> Looking at its allocation we can see that it is already zero-allocated
> which means NUL-padding is not required:
> |       di = kzalloc(sizeof(struct dma_info), GFP_ATOMIC);
> 
> For wlc->modulecb[i].name, we expect each name in wlc->modulecb to be
> NUL-terminated based on their usage with strcmp():
> |       if (!strcmp(wlc->modulecb[i].name, name) &&
> 
> NUL-padding is not required as wlc is zero-allocated in:
> brcms_c_attach_malloc() ->
> |       wlc = kzalloc(sizeof(struct brcms_c_info), GFP_ATOMIC);
> 
> For all these cases, a suitable replacement is `strscpy` due to the fact
> that it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Good; this looks like standard direct replacements.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
