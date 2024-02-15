Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6641A81
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026294; cv=none; b=XFvTFgkAIhqecRVfq4T6T1jRO3y0cpRjAjdUfmH25+eBJKdbPv4LfTPMH4W4SVaHT5gHqdrqphQEZGpEZNuIrkUQLrcpIfisHaEMz+5ri1RHk44+D4w1V0JEDiXAhhv2a+BjbB07+fcILxHHIDo+JfSvBKLW4TgepIN8kXw+f7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026294; c=relaxed/simple;
	bh=3cQ305fQjLggWM1EqW102dAerdwvIg6LDFX8WTSlQBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiwZ7rp4NiXehWKd5u6Jd4Z6yWnSZjXuFGetBkflEgJihOnpgpBc+fJo21PxOKst2iRYRLVNrf3Ngd8/cE1H1imheiFki1MHySqu4mqDTlp+sqrlTmiSHG61C97Q3y8T+OsODLKc7D904OIMWn/U8SS646SWwxZpSG17L07TYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aGqecW/i; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aGqecW/i"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso881240b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 11:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708026293; x=1708631093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hDV144BFjsd9eBmeIR68UbZ9/AgjyHKPCmhViDvmjs=;
        b=aGqecW/icQqZdRGfozZoLDspPO0Y73F3xwlKF4uDhicaMTJcxxPFpYr40aOeGrSXXO
         tUOmpvT/p+8bsQusDSQtnXOOp7nru25dFzYCmageEAW1RcrCftnpbEnqDCX3+00FYCG5
         5diXyeXjU6yM9ayHnvJznkoM6rhSfix16/vvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026293; x=1708631093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hDV144BFjsd9eBmeIR68UbZ9/AgjyHKPCmhViDvmjs=;
        b=uy3CHZxKUGlezzBcC2T81Jzcv6yrtUnZH/noaLjNLyx+A+40wOG1dzsRdb8zwCDg3Q
         kiENNNxS0chNm7RMPuhWL98wxjGjtffsGerT3OASDCYMGwSZivqvgpxaxhSKaJQIO7K2
         MPPuBzBLvkTrF+j6wY4LG/DWH7sHEyWDHbF47xqcXCKGIxKDXzawANjL5CzgYwrJ5LmI
         X0/l/fzRWECDW305SMaalliHLDHbLS+sDhXHTN+ce/F7Lso0g1cgxRCG9VNtbc781ptz
         pU7HmXaVm+vFikgPyr9vhm92SZggQU+t9D7jDER+ByNULrZ5zoQkOXBCOQw+6nIflXn9
         bqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk3OJoVlpWAuOIc8qqTSiYBppV7V0YbcNf7wSvbze324vMF25vT6vlYc58SCW5zrxXuXx7tmoEunAK93dJCdIv/wtMAbTndI1ppwVQzTew
X-Gm-Message-State: AOJu0YzKTkXrwg27fcu3/2o2UPhsyaVYT8OY7MDMiYeDnKPhVzoOHz2s
	YAbsI8a0GUlf4yK3gCEeWcPZU75pdr0snKcq08tFMMK5qDClRn9OhWG1YvnuRGxpiWFPzj0a4Cw
	=
X-Google-Smtp-Source: AGHT+IHAlFu09JKJgWNU7G7gtL6cufvqGGvWZ8o5JKMDXq3LqEJ77Og35l7+WVrzQRVTXVY8pxpJ3Q==
X-Received: by 2002:a62:f20c:0:b0:6e0:47b9:b727 with SMTP id m12-20020a62f20c000000b006e047b9b727mr2675158pfh.30.1708026293017;
        Thu, 15 Feb 2024 11:44:53 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k19-20020aa788d3000000b006e07f1829b0sm1695902pff.219.2024.02.15.11.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:44:52 -0800 (PST)
Date: Thu, 15 Feb 2024 11:44:52 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cocci: Add rules to find str_plural() replacements
Message-ID: <202402151144.70E863483C@keescook>
References: <20240215180156.work.548-kees@kernel.org>
 <Zc5nCsE74E33PdD2@smile.fi.intel.com>
 <Zc5nKZezYhg3Khtr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5nKZezYhg3Khtr@smile.fi.intel.com>

On Thu, Feb 15, 2024 at 09:34:01PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 09:33:31PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 15, 2024 at 10:02:00AM -0800, Kees Cook wrote:
> > > Add rules for finding places where str_plural() can be used. This
> > > currently finds:
> > >  54 files changed, 62 insertions(+), 61 deletions(-)
> > 
> > Can we extend this to cover string_choices and call the script probably
> > str_choices.cocci ?
> 
> (And add it to MAINTAINERS?)

Sure! I'll send a v2.

-- 
Kees Cook
