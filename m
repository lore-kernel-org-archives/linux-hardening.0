Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710BF51037
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309853; cv=none; b=HrftRDbLnCgY1TroESFaNocuaXMix1YDpETXKYOvUDNw+9PefhyOcKcFvVXNj6uwqjUjjmU+AV7YAJPS80G5tXK7t642y2Vmq4ItpeEZjFYgw6kr79ncKPzNVs7FlCW/l8biKchhQ9xOCYMfAdGB7pY9lUwW5pViX+9BjGDfRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309853; c=relaxed/simple;
	bh=Zm28gy7JneQI86vjRiocJqTdrtybNTFIpBfp44vYclc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS+7EN6sgZ/oSDrOySWg5Hi/CvP2L9+3B751oQdOr7dr0dlhc/VRDfzkmqIUzNOZ9h/fvP8Ra3lPLpnne4TcCOI9m3f2biUTzEZZcOwZS3RofjcQYMr02/50jNLaILgUU3MuAA/L4dimDOunemxL+wLAzv4agXk51Vk5cHNsGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpDBaDip; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpDBaDip"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d51ba18e1bso9875915ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 14:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706309852; x=1706914652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNeQV+teY78A4CeH6MOUnq15lI/jHlKDDnV2ttEl5UM=;
        b=EpDBaDip+p2gkkUEisyEBiC+ZEK4KHlFaZkIisdXF0E/pS53NqYqDwi3o3b3cTvdtb
         swS5BqrYS9VHX95bAcjWgG1hQ8Jngwv01+rKjeIUMKJGjeUsGmU5R31sU/2bRcWddttT
         9V3GyJ2nWV2qSE/4pXXaJCVPNGf164TgQEbaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706309852; x=1706914652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNeQV+teY78A4CeH6MOUnq15lI/jHlKDDnV2ttEl5UM=;
        b=avK4YyBvcRSiU9qrFkvyTGXuY331ocUxotM2J/3Rk2ppwiWX4mnF3jV6xxfsfNjj57
         1MYTnozIHYri+nqurSZfpqqXmhbQoPF8xcOe86jiYvl1UKzsa5wfBZxUcob23HuAdw6e
         jQIBO0d3Nuk+57n765MworDDAjOTU3LtOqezCtuuoBPmzafg6tSpNnIu4qeufNjj1+SM
         ZoAwlJm5Qh1KVwap+bS9b/6qA97JPkkj8m3JYvTGHfbbW62bx/G2cB+DeO4l4v/Aya7f
         o50xwKPT5dn6VaYvlhZEvcysAZG1qm2MFLOpn3gE4mldccjpcAu+TZJ2tp670ip76BS7
         OOlA==
X-Gm-Message-State: AOJu0YytprOviXaIJpYzA+43oYRq2els+Dqd9LeA+esmSg8yfDl0s5gQ
	XbsaOFkWMducrqKgS0R/9co1rR4xyxzb4mOpU8tRlz9Cs2bRExJRrJvQybXimA==
X-Google-Smtp-Source: AGHT+IFa/a51ef4u5Txe4lN0/riq4dPPU5C/s4ogKAjOdUPLp9voycoxbrQZLW13AiNuVW2M7eXSjw==
X-Received: by 2002:a17:902:ea08:b0:1d7:24a3:278 with SMTP id s8-20020a170902ea0800b001d724a30278mr627215plg.91.1706309851913;
        Fri, 26 Jan 2024 14:57:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902c44900b001d71649bf9asm1413199plm.252.2024.01.26.14.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:57:31 -0800 (PST)
Date: Fri, 26 Jan 2024 14:57:30 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/82] overflow: Expand check_add_overflow() for pointer
 addition
Message-ID: <202401261456.3D126A50D7@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-1-keescook@chromium.org>
 <20240126225257.lfgeom4rhjzx2wrf@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126225257.lfgeom4rhjzx2wrf@google.com>

On Fri, Jan 26, 2024 at 10:52:57PM +0000, Justin Stitt wrote:
> [...]
> >  /**
> >   * check_sub_overflow() - Calculate subtraction with overflow checking
> 
> Does check_sub_overflow() deserve some more love in the future? I
> imagine "under"-flowing pointers is not at all common, though.

Yes, though I hadn't found any cases of it yet in the code, so I didn't
want to add a helper that would go unused. :)

> Nonetheless, this all looks good to me.
> 
> Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks!

-- 
Kees Cook
