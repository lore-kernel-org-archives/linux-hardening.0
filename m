Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E285199B4
	for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708999697; cv=none; b=ceOGLgEIaGRL8VScppVZyn5WIQ+bb2mvZqc3l0cJBATSnsE1Dsc5rcoe5W7bq+9EMfwFQYpXDMtmF2IzW/K9FDVn+LcmsPDPfVqdg6pDIzTOCz7JGGOB2lIMG20OoeDCysaN9Dlfhkx1cuLrQiFk8DGzIZ8YNvfHtqA+DjikVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708999697; c=relaxed/simple;
	bh=1nrHMmEG51Sj437E4s1EkfyuxGl2jRLjyHs/cGUfhXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuzAfuNsnb2XHo+eyDlGvFR0VtL0Ml5GSAvwv+eTvkHdyIQ5LQNbCyndcN5F8rz7+bm8JGpOr4TYDBsd80sqLNxMKBVqttbW69L/Lh4xTC7vqKJU1+DGGLlMeR2e3DAGELRHOpYG3a/xGgyblbnso0UeMhGt4tDreYWHlifCB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VN3fDdh0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VN3fDdh0"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2518955a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Feb 2024 18:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708999695; x=1709604495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVkpTbipxCiUrmv2gBFC6axIfIqg3FWn8ARyZarMPgo=;
        b=VN3fDdh0y5kZtNXMiVduELns1/LtGi0eSX7gEYeiZJ45KXPE9TRJg+vqINyXbqLYDh
         6Gdt2zD00qOTn439iZfqo6Cq7A30wkr755wXL8M326ysJUmslnHeUvGPQWN6P9tyRw9v
         shuuA/mFvrsuO82KKvuAgR89tD7FkSEsreLrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708999695; x=1709604495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVkpTbipxCiUrmv2gBFC6axIfIqg3FWn8ARyZarMPgo=;
        b=stUM9NZaYpf5f0MX+gTpJKk7kRxG5oNxrCoISk51zBR1IH9Jsjs8q1PZdDmBmhG6N1
         UkZQtmpR5iw/VLdn/P8NXex2qlPoVW1e3rmcObrHg6l4+MTYs1EtycKjuLUgs2Ii4r0J
         Mi4WT2JEzkHn1vImTP+nS3cxsooramHncEvQvPkkXv6rOwmbqlJRMZiXdHlAnRC6CVMG
         eNtLPs10HEzhB0NY1BRVnWH4nCrkvU7ThJZfq8cf+rjg3xPOlPdv4QL7E709IwsNy03u
         8L3X5+PKqrx/x86fsiH+kjRiV7YzrkYUaAe3SSasXzeiQS80ZyCCjwsYo9wIK+agPpkp
         /rJg==
X-Forwarded-Encrypted: i=1; AJvYcCWTuHTZLIeXGyW5tPpaThhj66sXR0aE8xXZJEVTV1Uu2efwplvJ7npQhugA7Z1TpVgQGjcsB3UG0MIihVm+gzX568DQ0YgYPpmIQKeMLTYx
X-Gm-Message-State: AOJu0Yz4umNTs6o3xaIJp9jvZVK6UEnxNtOVsslb4+KKrOMPvW7/e686
	or/crWw2qFNoHYLkqJa3dkkWC2qG1ehfcK8FtZCNUScvIjVqqbrMw7xYZz4oRQ==
X-Google-Smtp-Source: AGHT+IF6zdQ/2mc8pHy3ltuh8A68wKo1/k8qw2couBJUhs2wfECHjSq4AtVGKGBQE7knMNxjo75dzg==
X-Received: by 2002:a17:90b:124d:b0:299:32ee:a426 with SMTP id gx13-20020a17090b124d00b0029932eea426mr5747343pjb.32.1708999695238;
        Mon, 26 Feb 2024 18:08:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s62-20020a17090a2f4400b002992f49922csm5774240pjd.25.2024.02.26.18.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 18:08:14 -0800 (PST)
Date: Mon, 26 Feb 2024 18:08:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, gustavoars@kernel.org, morbo@google.com,
	justinstitt@google.com, stanislaw.gruszka@linux.intel.com,
	linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Message-ID: <202402261806.A8340C71D@keescook>
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>

On Mon, Feb 26, 2024 at 05:54:58PM -0700, Nathan Chancellor wrote:
> When booting a CONFIG_FORTIFY_SOURCE=y kernel compiled with a toolchain
> that supports __counted_by() (such as clang-18 and newer), there is a
> panic on boot:
> 
>   [    2.913770] memcpy: detected buffer overflow: 72 byte write of buffer size 0

Yay, the "better details" output is working. :)

>   [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 __fortify_report+0x5c/0x74
>   ...
>   [    3.039208] Call trace:
>   [    3.041643]  __fortify_report+0x5c/0x74
>   [    3.045469]  __fortify_panic+0x18/0x20
>   [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8
> 
> This panic occurs because trips is counted by num_trips but num_trips is
> assigned after the call to memcpy(), so the fortify checks think the
> buffer size is zero because tz was allocated with kzalloc().
> 
> Move the num_trips assignment before the memcpy() to resolve the panic
> and ensure that the fortify checks work properly.
> 
> Fixes: 9b0a62758665 ("thermal: core: Store zone trips table in struct thermal_zone_device")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index bb21f78b4bfa..1eabc8ebe27d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1354,8 +1354,8 @@ thermal_zone_device_register_with_trips(const char *type,
>  
>  	tz->device.class = thermal_class;
>  	tz->devdata = devdata;
> -	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>  	tz->num_trips = num_trips;
> +	memcpy(tz->trips, trips, num_trips * sizeof(*trips));

Looks good to me; thanks for catching this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
