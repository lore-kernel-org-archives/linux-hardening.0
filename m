Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0C3B289
	for <linux-hardening@vger.kernel.org>; Fri, 29 Mar 2024 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685093; cv=none; b=UmiAyNF+SEJoxij2YC1RsfJLSg9iQi2lBBqLVcR0oZbnQ916Fg1FNsMAGmNXjv4pECdHVmV/CKC/ouvkh2RZtEbKBozi5RrcsoCTkCxLbslDieykaSNg5nZgRcWEaaRsE2LkukLpEobOvkvEv6h1AdDGl9QlQTk5/BTmCad2FzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685093; c=relaxed/simple;
	bh=fx75aDeb//DCFTHJW3dMQvi5gnKmJfUkKWLKThTPR94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orJcPK0vyAECBXa+lBuSZqXBQqJwpfwUC/RX5R8d2Tg6ltGQkTUHOxFfEcEdQSvTjz9H4GZ0ElbfcPT8e8qqMtGL4AUHhK4xpuCXBXH9h338bjyWGSEvhS8HeuXXAXpRu3j87aCttE0ZyWF7XK7YuwrSsY6pbaBkYL4YJnB9XRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ARKkytZx; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARKkytZx"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a550ce1a41so954550eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685091; x=1712289891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69VUW1JBrC64hXBRbspWF21+J8tNtsC9yt2uIqIg1HQ=;
        b=ARKkytZx7biCoF4FdX911rnJCexBt0iG+IlY+ojHC5xM8lHiSpUIq2CG8gJaeSlMWT
         nsPMe9VyQDwpIYZliclOQHQOr8os5bQJU+hkKiu5pDe0HCp7R83QzE1+NtEO/eFNqPUG
         JPNX8VuAh1HeKMTvaQyumwnHeGervw7jYlD3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685091; x=1712289891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69VUW1JBrC64hXBRbspWF21+J8tNtsC9yt2uIqIg1HQ=;
        b=PI/UYeOvhK96//bZilUuBfC+dHIFieaFDFoOmiKBfzIz8Ifb5c0zSuU8BoswHjpvKC
         cCgNQZlf68vaRYwoMMc/nwXkEpLekdT33ErR4yoKNKJOvupmXzox5O/rxXvMY3KG+E2E
         VxAiv+9+BF0YrUJkk3SWB7u2CM9lwO30/6VfgqAVvBoNA60VStfj6osMgmeMNxObw6P3
         E09nhAB9O7EWKG0VxE/ORpFHTUBMoTq7PwxTWpkbbxkCtef9zpS+hJ4szlMT8/WKx6cc
         QG/8mwQEYae2YoCZ8AYANPoePxay6cycPsMiqex769gHyvgnK3fO5HUMT6y6OKbMBWz4
         4o6g==
X-Forwarded-Encrypted: i=1; AJvYcCW42DclH2CFaoKzly4qNHmG/ZlJrnIA+SiioCjI+SJ8rXfCCBRP3SeN14icPWNsSmGqBrSIFtDaVgw/QVNimHmbFqYt2AL9UtdSY42hXkoF
X-Gm-Message-State: AOJu0Yz9V+YXli2f78JvHdHlciX5d2ZSdC5wZesXiam/jrj+pE7uETMb
	z6dVF56PtJbUWL/IEHhytXjQe7QGeJdOJHok3zDKpfou8MNluTs0TCYSigR/Iw==
X-Google-Smtp-Source: AGHT+IFvNh8aPME+bk9MigIg8cgiL4SPF+c4/TssLm62fUGeJU6j/Ecq0WtTIJm48S6HEzmuuKfGsA==
X-Received: by 2002:a05:6870:c34f:b0:229:c1d4:83bf with SMTP id e15-20020a056870c34f00b00229c1d483bfmr1130237oak.8.1711685091224;
        Thu, 28 Mar 2024 21:04:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7982e000000b006e73508485bsm2159777pfl.100.2024.03.28.21.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:04:50 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:04:50 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] video/hdmi: prefer length specifier in format over
 string copying
Message-ID: <202403282104.CC17451@keescook>
References: <20240320-strncpy-drivers-video-hdmi-c-v1-1-f9a08168cdaf@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-strncpy-drivers-video-hdmi-c-v1-1-f9a08168cdaf@google.com>

On Wed, Mar 20, 2024 at 11:22:02PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> It looks like the main use of strncpy() here is to limit the amount of
> bytes printed from hdmi_log() by using a tmp buffer and limiting the
> number of bytes copied. Really, we should use the %.<len>s format
> qualifier to achieve this.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
