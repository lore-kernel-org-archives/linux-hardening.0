Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0861EE021A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 04:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjIOEdc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 00:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjIOEdc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 00:33:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11006270A
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:33:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-69042d398b1so416440b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694752406; x=1695357206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ortdfDKvpNIzeJx8TZszObBou7irHmSbSFxDLFsiIb8=;
        b=GGCdelh6d4U9kJ8E+ZxsM59OP7oXlqOFFazC1jOGOkZsbPJvFWMBNnYGKLOXucMCtW
         6RXdqTSRJf2+LHdYOWbMWEoUEq8LvdaKmsDGqf0jHYhmNRCFj4JvEgH61LQ4AWj0wCkx
         BGXajMPKYe0qANHdgWKOJvIHIhMvbQhQTQGgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694752406; x=1695357206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ortdfDKvpNIzeJx8TZszObBou7irHmSbSFxDLFsiIb8=;
        b=N8BE+3iwloX4bHQd/rF6eq4UdbWpEiuE9DNYI4qV8iCLgXSfWJe8OVpgM2HfN2Nwv5
         pdu8SfnBKTA2ScuwpPn76+7VUBAUHMBpOOUh5L3otlrmQBS+niwqEk1hckKlwe0EHWMX
         X9hRDsKqHCmvyLDlRz7G+hKysNWlovJ4vV/FmI86jS5KqicbmzmT2vryHa8f6xgJyggV
         iCJryhoDYNctt5fA4sPaE1B1lTknXr+c1ObFhxb8WTcOPcFt3BbP3KS0IOMdxBSS8DlZ
         26f3/NnQHMoC+b183dv0z1miAN3vKm6LvbV2j8CH8b0NRpUGaNYN/W3+kXuCE5CNP6Bj
         5DZA==
X-Gm-Message-State: AOJu0YyXVn286ac89Kv1NRVMDlcjlrGct+w+J4vHai0AQNRmG80rWXXb
        qWioh+VNdNHyV//IF0Q2qIvSJGZ2RY6TsqyvVuA=
X-Google-Smtp-Source: AGHT+IGzXgg9/OWEiL8KkvNzLUOYOIZOZmk5y/PBBVeZQiwFgRA29dMIvxF6haF9oKiYXTr2yUlD5A==
X-Received: by 2002:a05:6a20:7d8c:b0:131:c760:2a0b with SMTP id v12-20020a056a207d8c00b00131c7602a0bmr967771pzj.52.1694752406562;
        Thu, 14 Sep 2023 21:33:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902ee5100b001bdc209b9a0sm2400126plo.201.2023.09.14.21.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:33:26 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:33:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Bo YU <tsu.yubo@gmail.com>
Subject: Re: [PATCH] drm/etnaviv: refactor deprecated strncpy
Message-ID: <202309142133.F7FBDD9@keescook>
References: <20230914-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v1-1-3adc2d9bfc52@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v1-1-3adc2d9bfc52@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 14, 2023 at 06:20:01PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Bo YU <tsu.yubo@gmail.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Similar to [1] which was never picked up. Let's prefer strscpy to strlcpy, though
> 
> [1]: https://lore.kernel.org/all/20190328080918.9290-1-tsu.yubo@gmail.com/
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> index bafdfe49c1d8..9e7bebcf24eb 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> @@ -511,7 +511,7 @@ int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
>  
>  	domain->id = domain->iter;
>  	domain->nr_signals = dom->nr_signals;
> -	strncpy(domain->name, dom->name, sizeof(domain->name));
> +	strscpy(domain->name, dom->name, sizeof(domain->name));

It looks like this is passing through an ioctl(). Let's use
strscpy_pad(0 instead...

-Kees

>  
>  	domain->iter++;
>  	if (domain->iter == nr_domains)
> @@ -540,7 +540,7 @@ int etnaviv_pm_query_sig(struct etnaviv_gpu *gpu,
>  	sig = &dom->signal[signal->iter];
>  
>  	signal->id = signal->iter;
> -	strncpy(signal->name, sig->name, sizeof(signal->name));
> +	strscpy(signal->name, sig->name, sizeof(signal->name));
>  
>  	signal->iter++;
>  	if (signal->iter == dom->nr_signals)
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-dd095491dfde
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
