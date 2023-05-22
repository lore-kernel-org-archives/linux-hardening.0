Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89ABC7EE29
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjEVURG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjEVUQm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:16:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4F188
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae875bf125so24602655ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786586; x=1687378586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tk3bD9idbrl9PK1wi5VEyItHEpJJoo8tWtDD672a6E=;
        b=CLjZcbeeJRsWfyBj8z/QVwLw/ENfE5+A1dPkMRNzX87xKEByhVIPvwWqQm4vMwpfHx
         LkuslqD3tJGP5ZErdH8X4BGmRzZsFV6FOZtqvKaAwxu+bJS4PEowjRWKQf08zVeZOnNS
         nCUd+51z44rEqWO2oc6lzbzLBxNDbL4CuXt+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786586; x=1687378586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tk3bD9idbrl9PK1wi5VEyItHEpJJoo8tWtDD672a6E=;
        b=Wow5eMnJgjXRATLFqNOzm+DmwQ3Ht4zQiDjzykrKicSAR1dtz2l7So+5fw6kYtEJAg
         PyxyLAKmcFhgd94sUghLog4lymFDPqmqWoutLHL+/94qKTp8+C32ihCbt4JLwPm2eLFu
         nVIy5cNLgTVSE6eWacD3Eja+Y4K+bqgr01CbIONc0ctn2uUG1fGfqLItCiCJ6kptCsOp
         HLbZ2dO2OQvbQ5xivefDed4mCG01GtPWHGH2yJ79GqVKNBXCGFGdSBIJspz94ZB+35c4
         8U2tO1IoIVAuP0mL8IxoIkDwCMi6XYXHEhkWnzz5haqOIFchV7lzKUmvk+Bz9qxyaVaD
         xw2Q==
X-Gm-Message-State: AC+VfDxflJ9PlcAzgYv/zXInfHz6qPA6FCjhrzwAf9LHetrt4MLDR9C8
        RnIUYKjn2mXTaNFfYOy4l+q2505sHLQrzkXJV3A=
X-Google-Smtp-Source: ACHHUZ6BuhhlrdHXweBhtsG3t4yfH689XOUIExdIl9faSWmma0pPdymM3tTUL/dYHxtJKYUa0AJF+w==
X-Received: by 2002:a17:902:ec86:b0:1a6:a8e5:9240 with SMTP id x6-20020a170902ec8600b001a6a8e59240mr13889786plg.4.1684786585815;
        Mon, 22 May 2023 13:16:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001ab2b415bdbsm5247910plg.45.2023.05.22.13.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:25 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i2c: tda998x: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221316.C0D13F1@keescook>
References: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:53:50PM +0000, Azeem Shaikh wrote:
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
