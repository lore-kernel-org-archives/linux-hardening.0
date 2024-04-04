Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7874C0C
	for <linux-hardening@vger.kernel.org>; Thu,  4 Apr 2024 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263916; cv=none; b=ac4iuNdh9AjvySDFNlgpCT044jtUe1d02AsY49lCETPOGLzZGdbta3FYSk9w3lqHZNwJQBD/oNwumKN9p30PiuxBhGFW/8JMCr4nFUb1yMaFPA4gK+wwWhT7pm1zAj6YOHMG+M10vdht3G6iIGzeUDJZps7k+oGSN8uauEg/5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263916; c=relaxed/simple;
	bh=YtI2ruwAXEeLsDZf6Ahi6HUoQo1ypf/gr7HozATqWiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZoo9oWPT6Sg7VrBkpEwotqJnvg60Gyfs+CkbmwToSne56l89hj17r7DYkJkUkfJcgAHQLf+CNcMdgh09c20mlz6HFPWRaNWeBVU0lsdiNixZGKJNDRiFEjPY/eWaAXYevN4+O0gjF7Bzs9UbxpGOnAJE91tMfsNeW93y8CjT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oGHezI49; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oGHezI49"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2bbc2048eso8055995ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 04 Apr 2024 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712263914; x=1712868714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IievYpX8CFKdhYar1uMDyClwmKohq+pMo1GKIaqn2LQ=;
        b=oGHezI49WRUhBDtRHKaAsDPCnt3H9YXIMbnvZXYqAsfK+Yiu6Ipr8fp2dddbroiGGK
         TfDcD+b8Q7W53neW7Jn2IrRDjxoDehL45KKhPP8SAOc4VbJjCOONWI/zK+bl+kh6woWs
         yGI5xoL/LBSDsIQ3rmQvT0YGWprepMd1qCKyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263914; x=1712868714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IievYpX8CFKdhYar1uMDyClwmKohq+pMo1GKIaqn2LQ=;
        b=RTEAAoHmhI9yKZYQLfS1DZm9EhdHO9nZxq47vmhzsDCapvUuhqQPZimDqG9LvRT36n
         ekBehGwlVwk5cD8Lz/DLKEDtd/8PQ+R/2voP6tDqdLErWat6gQx1mThCofjSFuhBNZKY
         4023K6L17sE10PM+nGs264AYHEjlxgaNvLtLG4nL3X66ozeNBmHHxDJ4MA+ks7fdFuAg
         qG5HmoD08jKRQtCpOxutTuiuNFEAtl4bBM7wOkueZH5vDj9MkF0fVkDZj3PtrO4XiVYJ
         UfAM8UwfEmr16pDd6mRFsU0HHcRTLzTU8mV2kx8rJAPY8rObKTUNlwxU8CjnTwkfDBBX
         Xa7w==
X-Forwarded-Encrypted: i=1; AJvYcCU7zovbN2F++AEWSMNZV/xVtZ7s1+PghPneRT0MnNsO4aJ5LWTtKJIldoZIuzoTlk6A/hBI59kM4VLjkCIcGixaAdZko+3adPYS+BNhvriL
X-Gm-Message-State: AOJu0YyU843Iro7L1yqks5K0I59nSw+UAVO/VTYiGTE/H/bmF20HXxPi
	AlK4yqS70iuxU8W7YgE5mt0j/VjTCGt/l5ChpnZZF9Q/6NifuX4x2fvftZ2s8p+6sG15qTsvyh4
	=
X-Google-Smtp-Source: AGHT+IEFTkHCy3DwvnHohRthWuZHzZAjk3sv9WbtmQ4rqctgK/TihGSptNJc+b+Ef40jwR/ei0rmXQ==
X-Received: by 2002:a17:902:ea12:b0:1e0:b62c:3ae2 with SMTP id s18-20020a170902ea1200b001e0b62c3ae2mr4219776plg.10.1712263914303;
        Thu, 04 Apr 2024 13:51:54 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001e0a2cf62bfsm46256plg.201.2024.04.04.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:51:53 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:51:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] init: replace deprecated strncpy with strscpy_pad
Message-ID: <202404041351.3631CD6E19@keescook>
References: <20240402-strncpy-init-do_mounts-c-v1-1-e16d7bc20974@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-strncpy-init-do_mounts-c-v1-1-e16d7bc20974@google.com>

On Tue, Apr 02, 2024 at 08:39:49PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> data_page wants to be NUL-terminated and NUL-padded, use strscpy_pad to
> provide both of these. data_page no longer awkwardly relies on
> init_mount to perform its NUL-termination, although that sanity check is
> left unchanged.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This looks good. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
