Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9F135A62
	for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111729; cv=none; b=IH/Vs/neeHDVdQli9TKokUTBMZA/FWPSEz71ZNHS7pu2De3Bcb3dMJjbgdlUR4yh/d3zQj1rpSaNWs3ja/QjXaB8yuh1r6yoowMISfnYNmjO8KNtA9Vv03qJ3X2bgj3O0Ch29zXdfM7b6jjQKHBpFmQkv3tfORreONi1hTOozrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111729; c=relaxed/simple;
	bh=lTlPLpCMgZP3J5G2JyWCxdrQPIx57yknIxy+xzBAuiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt82a2GD7p/y9oYg/eIutGry0a1Q2BPARm9qBFaDxShRb8OdJ40dNJHQBKXVBFRsJA5nAjYvlKgw5xg4DCQi9LJW0xUVifc2Z97vcfWWKoKWqS/wl4O7bn/GGyUCvwIiEdszs6sdhbNupNPTyHPxsVBahjyHqYNnB7AxJMsTB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R5coQsS2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5coQsS2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d932f6ccfaso21617995ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708111727; x=1708716527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8WkqZPPSvCs0Xbxi28cm5IAK+G5lVBNtuRMx7zqp6A=;
        b=R5coQsS2C1Vv8ORE4KkSAKbL7np+3B8cvptkWAn6ATmF49khFocLjmmzWjUCXVQf3G
         ZdQ6Wtk/WC1PU1DLBzXClJ9LHH2dfjOtssCJVm2vKJRP36783uvFJcvruU7v6J/5mRZK
         UHRscOq1hh9o2QadEgfeFLQFCJ8F6J3PiLlzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708111727; x=1708716527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8WkqZPPSvCs0Xbxi28cm5IAK+G5lVBNtuRMx7zqp6A=;
        b=povrJL4o5kZYASoX0CO/cbh+xgkvYn9XdL/FcQUOQa4ohRvOQgtisPPF/RD/pStRcr
         KLY+gWHXRjnxQPh6DT4dJWtIoorkgR5N8y/56gMeFPWbh2D0KflXwZlKHC9DxRGODJfT
         g0zuj4DEByzuyKQItxyN1Rsu194rTzUrQv9qQJbokB5WCbm8uc7JLGo9nosvPBWpsw4K
         4ojfzrOat559u+eQ9T+R95HHIlWgR9BqqK/bP/92hqNQiADJ+4Nv3iaPU0ZU2iGHIJQw
         8PJ8vTCK/DbVjxMShxtdg90KzGTdEXOoAKRIA8DUhRFTXZHzUmljlHgQOCX3fTgBXkBf
         Y58Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMMb+trD6nPpVG+y+FATaD5qqnDIjPAMG5zhBsfeRjLP11L0raCtxLUodFoMjkyFCZFOVFlB+QEoPvt9ws4Gn4AZaihSj+/ubtlbIyk2cw
X-Gm-Message-State: AOJu0YydbVQVSWmC1bWZFAikn9knRDdT/7tb1XhBw+mBTTTsmFKXq36j
	7Bop9+aaERzbk8Tv3zjpKQjIEzwwxWryLC1SykYzRdD1WUsjuZbFqwNYH6q77A==
X-Google-Smtp-Source: AGHT+IHfhAKa5A+x7ys9ADrXomzy798qL2jSR2XKtHRV7rpOOWmyF9ZLqe3tbjMMeK5txf1tPbVmkQ==
X-Received: by 2002:a17:902:ce90:b0:1db:c1d4:8151 with SMTP id f16-20020a170902ce9000b001dbc1d48151mr348857plg.49.1708111726925;
        Fri, 16 Feb 2024 11:28:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b001da0a698095sm205675pld.282.2024.02.16.11.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:28:46 -0800 (PST)
Date: Fri, 16 Feb 2024 11:28:46 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] module: Don't ignore errors from set_memory_XX()
Message-ID: <202402161128.21EA3F8@keescook>
References: <21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>

On Fri, Feb 16, 2024 at 09:14:27AM +0100, Christophe Leroy wrote:
> set_memory_ro(), set_memory_nx(), set_memory_x() and other helpers
> can fail and return an error. In that case the memory might not be
> protected as expected and the module loading has to be aborted to
> avoid security issues.
> 
> Check return value of all calls to set_memory_XX() and handle
> error if any.
> 
> Add a check to not call set_memory_XX() on NULL pointers as some
> architectures may not like it allthough numpages is always 0 in that
> case. This also avoid a useless call to set_vm_flush_reset_perms().
> 
> Link: https://github.com/KSPP/linux/issues/7
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Yay! Glad to see this happening. Universal __must_check for set_memory_*()
starts to appear on the horizon. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
