Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1EDC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 20 Jan 2022 23:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378254AbiATXWX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 20 Jan 2022 18:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347894AbiATXWN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 20 Jan 2022 18:22:13 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48832C06173F
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 15:22:13 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w190so1026206pfw.7
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 15:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=egMwIptYpGbsC4XxY+2pETIXKwRmweD4aAOClQc8FOg=;
        b=j4GGCU1LW7aQgvrd+Lz43oPyrQTqCIyQoc6damDU85BEiX4EjPHox+J6XMEr6p37Ug
         FUVyNP5vcpMg6VQVjWSQsAXBlSyyHvX1azVDGc6U6R65pQjxW9MeXOI5KViTR8vEFY8o
         ANrlB37o2SeyYSXsKBblX32sWYT9tDRU319IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=egMwIptYpGbsC4XxY+2pETIXKwRmweD4aAOClQc8FOg=;
        b=VIIWY9Kzi9qcVT5CDaW3DtRY6impNYkwBKCidWORanmd0MsbnY0GMk/tw+dQc9Z3aV
         V7mN/f4kCt7seG+H0DOFkQdgdqBRPwBQmw/J9AOjnwZ8b3kHYKuDDc4zowfONEWd55RK
         UYM8m66ggv73uWzTZWS5JRJCng0SAs54/jZjXFkQDy8TdmWGE33zuxdecAN4haWQUYBD
         ab9iQYeOTWRKTpLDRdF9MHP4JCgP1eKiHefuCP3JLkfBHUZvbO0aeVMqxuiPoBX45DuC
         MRSAZYnpdPwl1XUdKuC+IuFcXIGONh/zdncKgxKGTIHSDeM0wvUdljN7MYYk3zW/6SkR
         B+NA==
X-Gm-Message-State: AOAM531mo7RZEk7SATZ4o3CWsrQJu0Z5PHlZL7aFRS3SEX96cFT+LWOq
        wBp+wsoiGGSpJHJr3jSjiLJJYA==
X-Google-Smtp-Source: ABdhPJym1c+5Elx/jqSx5/twwAq6/wX0UlB8jSjMP5BZBOA7fq0C2i3GvWJv84TUYMV6NEMTCS4VFg==
X-Received: by 2002:a63:1d7:: with SMTP id 206mr840156pgb.111.1642720932694;
        Thu, 20 Jan 2022 15:22:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm3202700pgj.41.2022.01.20.15.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:22:12 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:22:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] ALSA: usb-audio: scarlett2: Use struct_size()
 helper in scarlett2_usb()
Message-ID: <202201201522.5E744C15E9@keescook>
References: <20220120211600.GA28841@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120211600.GA28841@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 20, 2022 at 03:16:00PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> sound/usb/mixer_scarlett_gen2.c:1064:28: warning: using sizeof on a flexible structure
> sound/usb/mixer_scarlett_gen2.c:1065:29: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> Changes in v2:
>  - Use correct format specifier %zu for type size_t argument.
> 
>  sound/usb/mixer_scarlett_gen2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
> index 53ebabf42472..7ff8a4817c67 100644
> --- a/sound/usb/mixer_scarlett_gen2.c
> +++ b/sound/usb/mixer_scarlett_gen2.c
> @@ -1061,9 +1061,9 @@ static int scarlett2_usb(
>  {
>  	struct scarlett2_data *private = mixer->private_data;
>  	struct usb_device *dev = mixer->chip->dev;
> -	u16 req_buf_size = sizeof(struct scarlett2_usb_packet) + req_size;
> -	u16 resp_buf_size = sizeof(struct scarlett2_usb_packet) + resp_size;
>  	struct scarlett2_usb_packet *req, *resp = NULL;
> +	size_t req_buf_size = struct_size(req, data, req_size);
> +	size_t resp_buf_size = struct_size(resp, data, resp_size);
>  	int err;
>  
>  	req = kmalloc(req_buf_size, GFP_KERNEL);
> @@ -1111,7 +1111,7 @@ static int scarlett2_usb(
>  		usb_audio_err(
>  			mixer->chip,
>  			"Scarlett Gen 2/3 USB response result cmd %x was %d "
> -			"expected %d\n",
> +			"expected %zu\n",
>  			cmd, err, resp_buf_size);
>  		err = -EINVAL;
>  		goto unlock;
> -- 
> 2.27.0
> 

-- 
Kees Cook
