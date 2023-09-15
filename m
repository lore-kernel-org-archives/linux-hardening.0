Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BEFEE3F01
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 04:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjIOE6n (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 00:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjIOE6l (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 00:58:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8AF270C
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:58:37 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-577e62e2adfso1425274a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694753916; x=1695358716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhsajtpeOeh2nBytWoKmEmN9EZC9U8e31FJLV6iox60=;
        b=lZ/M2gYzFoXIe586ycgOpV0KFBdVtMzxBZTMLj/kySJdgjTnbnSuRi1YNNDgXlCYjV
         TaRPUxCbs2jqTtJpd+hMoE8abuymSECf2oIj/uo7uHNUlPPv/FtYUolqGBIxYzm9/Oa+
         SDR51MIlJeZBSma3toqdS5h3G77DFUpjdRzZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694753916; x=1695358716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhsajtpeOeh2nBytWoKmEmN9EZC9U8e31FJLV6iox60=;
        b=AO2ZXvuTqW8q218KoNPIod5vYMyIX2Qrv0JzG3G6OOJPaRuiNS+IjyKNQDhOMy+sW9
         I4J3DHlSNljYnExbqH1sPQ8nqVVHCkMFk+ziPc9J7ygsBc+DkqXAoVmYhr4MpFi9L4um
         ngPq1hxKILnm4btLEfBw7KVqu9v0STMSq60MCcfMxJcYQkUcWRTgZ94fOXKjEW8KjHHV
         ztBmnl6UCT2/v2odqccL7stkKb9qFoUlmTbqWC684cxp5I5Anh45AlFoBxpQscILYY01
         7nge50M0mSXj3AMBMg7G+lBDYAgSzQRQh1ujU63xkGJ8SvFVwx6fL6Uq6SPyFqbVmnCL
         hgHQ==
X-Gm-Message-State: AOJu0YwBK1hQbCyOFGi3xd7BjL6DD7N3c5ULi2WI/e1xrVCkn+CY0UfA
        6PidjscZpWOLCjZ4v8f7l7q3vw==
X-Google-Smtp-Source: AGHT+IHAmWQcAvThssqgWXbggJNS/TydsVAkxf1KlDv9GNBO38qD+u6WVPMGPpXVEOqFJJZtDsV7lg==
X-Received: by 2002:a17:90a:7503:b0:26b:6a2f:7d90 with SMTP id q3-20020a17090a750300b0026b6a2f7d90mr523526pjk.23.1694753916448;
        Thu, 14 Sep 2023 21:58:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902d70200b001bbaf09ce15sm2448050ply.152.2023.09.14.21.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:58:35 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:58:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/core: refactor deprecated strncpy
Message-ID: <202309142158.9D766D97@keescook>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-v1-1-3aeae46c032f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-v1-1-3aeae46c032f@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 14, 2023 at 09:40:49PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily NUL-padding.
> 
> There is likely no bug in the current implementation due to the safeguard:
> | 	cname[sizeof(cname) - 1] = '\0';
> ... however we can provide simpler and easier to understand code using
> the newer (and recommended) `strscpy` api.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/core/firmware.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> index 91fb494d4009..374212da9e95 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> @@ -79,8 +79,7 @@ nvkm_firmware_get(const struct nvkm_subdev *subdev, const char *fwname, int ver,
>  	int i;
>  
>  	/* Convert device name to lowercase */
> -	strncpy(cname, device->chip->name, sizeof(cname));
> -	cname[sizeof(cname) - 1] = '\0';
> +	strscpy(cname, device->chip->name, sizeof(cname));
>  	i = strlen(cname);
>  	while (i) {
>  		--i;

Yup, consumed by strlen() and snprintf(). Looks like a standard
conversion. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-791223838b72
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
