Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B8C7EE29
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjEVUPi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjEVUPe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:15:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9769AB6
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:15:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso3742921b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786532; x=1687378532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUSVdvb79gbFeSBJR73SGjUk4u7N4upLsGKBG6cFJho=;
        b=d11p2MvCaOb9DoRlM6AqC75l9/TUamQDOrS4u48NcKgH9GH6J4JPrMKK18a8tUR/LU
         iYPejOwfb9QSEG/SUBcp0ItD07IbC5SLO/puDtWsARfYOpbtRDOshBvSPAvq3U97snGU
         Rl/nd1M85ilGLAVKdf7X5MSSGgcMUqX1gysQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786532; x=1687378532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUSVdvb79gbFeSBJR73SGjUk4u7N4upLsGKBG6cFJho=;
        b=NlFze0ah3hVKaIGNeBSdvtfmTDn0MtXEo1r6GLPJrfV9xc/lxL79x5/pAvI19BGoi4
         NMeJnbomZVdtsS4c6oi8YtCr+MnHzqEOJdY3xvObc+II1giP61YZhFQunbEygrQ29ouS
         RpQyMhDz41mPBCI36HshuFIaPUeILB3WO3+o7vZzw5bTk68+x0JoI1nmM3l4MzQ8xLKE
         1Yf8iZF28gOvpsMDxSKWSSlIlDNsXS0Jarmn41F+Yr2ATtVU3FfqgDTVESwMecTKyfjo
         sAU+/XeJsgNkJzVrTwmG/LBOMC1h1p9BqYLb0UmrK5cXd6jueIlTNa2bMzDYVy4L/yVZ
         Mzew==
X-Gm-Message-State: AC+VfDyNw4tDU/XAR3VYTyxceplZeChnYswzw55hhBH2pfNCCxJcGSbW
        ncbUQLYFVbSQ3v8Pqt2PNAh5aHwW93NsP+aHYm4=
X-Google-Smtp-Source: ACHHUZ4VR/bDiX3LTGczRv0D8hkVMKl4vQGKQDUaV1gV6VAWekr1r6jnhzrZ2egrciE2eQESOZ5R/A==
X-Received: by 2002:a05:6a00:2282:b0:63f:18ae:1d5f with SMTP id f2-20020a056a00228200b0063f18ae1d5fmr16955940pfe.29.1684786532020;
        Mon, 22 May 2023 13:15:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m8-20020aa78a08000000b0063ba9108c5csm4585207pfa.149.2023.05.22.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:15:31 -0700 (PDT)
Date:   Mon, 22 May 2023 13:15:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        linux-hardening@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Maxime Ripard <maxime@cerno.tech>,
        Lucas Stach <l.stach@pengutronix.de>,
        Guillaume BRUN <the.cheaterman@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Replace all non-returning strlcpy
 with strscpy
Message-ID: <202305221315.8E1A18B4A@keescook>
References: <20230522155210.2336690-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155210.2336690-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:52:10PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
