Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE8DEE021A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 04:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjIOEhi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 00:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOEhh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 00:37:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036FD270B
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:37:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26f6b2c8e80so1379643a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694752652; x=1695357452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lud7J0kQvKKVpUJfUwiDxIroUbqIAEqeTTjdBEz5LAE=;
        b=HyK5FtHkPTo72Z3h5Yg/eOa/OPfTG5u3mhniwm6m/yGQjt11mjjjemwGHUt5nd3P4V
         +ZYj42/gn8ozOpV6EXQXUjMzfK1YNB/rcbf0ilBKZL5DlsCRqqSlJd5yXm+17MpIBmsH
         gjWZhef92Iqr6ydkNXapcr7yjmqtJgnX9QnKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694752652; x=1695357452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lud7J0kQvKKVpUJfUwiDxIroUbqIAEqeTTjdBEz5LAE=;
        b=jSXAmRQZ3zeoH/3gNHNNbGUiCn7YnOn0lVhorm9J3fHLritd+V7XCQPRPFyXMbo3y1
         PMMG3Shtm93dSfnqQAnas042U1IgFTBcZYWjii//u5hkpE4CccacazvcNqM2Pd1IpsPe
         d7VoB5/PwVocuJeJaNjzaqFWAwwEsqskZh+ZqCuWZD8Dwc0vRqRXc4QjTOwdupPklhuE
         Wc0G/luqEBN1UuOynZ+xeiCl1uCtI22+/aeo3QT5BuqVfhAn3BFs8bacPuZyvDQys84n
         p3Y1o2AWfvUQJ9Vg/IcSkDnFZ9t9H1BDzjf7Qyec0Ht1PvZgyxySSlv/BxG8AHbfCkrW
         O4WA==
X-Gm-Message-State: AOJu0Ywpqr4h4klnTAHGJdtMETuXPWDbYsl/nUlE47mEwnngaPvw29gH
        4kM3Grlwh/jSyfz7oeSL+fEEeg==
X-Google-Smtp-Source: AGHT+IGIeRbvnxCp056eR7o04HYzcINgzzT4WzRCg/DYfYTFWSI7K7p21iVLjcZDM8PdtIN9vSXuEQ==
X-Received: by 2002:a17:90a:83:b0:274:a021:9383 with SMTP id a3-20020a17090a008300b00274a0219383mr227611pja.17.1694752652282;
        Thu, 14 Sep 2023 21:37:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gv4-20020a17090b11c400b00273f65fa424sm2107850pjb.8.2023.09.14.21.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:37:31 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:37:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/gma500: refactor deprecated strncpy
Message-ID: <202309142135.16032DEA8@keescook>
References: <20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v1-1-0a53a076ce20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v1-1-0a53a076ce20@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 14, 2023 at 08:52:21PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> Since `chan->base.name` is expected to be NUL-terminated, a suitable
> replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without also unnecessarily
> NUL-padding.

How did you decide about %NUL padding? (I see it is kzalloc'd, so it
doesn't matter.)

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> 
> 
> drm/gma500: refactor deprecated strncpy
> ---
>  drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> index 06b5b2d70d48..68458cbdd6d5 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> @@ -141,7 +141,7 @@ struct gma_i2c_chan *oaktrail_lvds_i2c_init(struct drm_device *dev)
>  
>  	chan->drm_dev = dev;
>  	chan->reg = dev_priv->lpc_gpio_base;
> -	strncpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);
> +	strscpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);

What's going on here with the destination buffer size? chan->base.name
is 48 bytes. I2C_NAME_SIZE is 20.

Ultimately it doesn't matter since the source is a const char string,
but it's still weird. Therefore:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  	chan->base.owner = THIS_MODULE;
>  	chan->base.algo_data = &chan->algo;
>  	chan->base.dev.parent = dev->dev;
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-a53c6d8bd62f
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
