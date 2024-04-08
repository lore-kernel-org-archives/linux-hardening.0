Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894891DA5E
	for <linux-hardening@vger.kernel.org>; Mon,  8 Apr 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618436; cv=none; b=c5WtybGry5sku/WeV4uJYz79IQsXkHhOnlbInpvuHNIx2XY5msZ6wY5i7w24vfpm6r4CyWc+w/lO+ouUhz6j8As8pwaQzTV/6h0CxhaegeMEwWkldCJAqgiXPZCTSeZKntQxPlBdzPY5zyY5Uvi0/rwivvLsA9VT03JhoVcdOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618436; c=relaxed/simple;
	bh=R0vbJw/BDBrD1C3Wb0cjCIKzALfO3U+u/MPT5lmUcrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYqUzY5zQ3MsgYcARY9eS6/8I6ktwEqK7eeOQU4otkoNdCHiWgiXalY0OiZKh10meSgtdhbYWe4ZeLw+JBcqXCUQ9+/zHNgRCTNKBruD4C2GO9jkw1PNQyjKKZvQFYFl1dBzKNtxVkxmhQ6/hJQPtGdzGRxaVCxz8gb+ABxGPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V1fUp2g+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V1fUp2g+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so1079755a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 08 Apr 2024 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712618434; x=1713223234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGfzW3KSWciZlgCPg70ValvXebgWwF9Br7yRSrVmJ8Y=;
        b=V1fUp2g+b7qKJEiXATTj3FznZF+WdNt+AtO6VyvLMvHxOmtkuDnmjOo2U4LR9nLjiv
         RjSSNGCQsNt1CbjKNwSoXpfQwjwLgdVvHBc60lnilbtasvP02TIckI6oCjoegQQoMS54
         FjBu2yDrfJftb0uz/aoOZw2vfkzy4SAoi3ybo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618434; x=1713223234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGfzW3KSWciZlgCPg70ValvXebgWwF9Br7yRSrVmJ8Y=;
        b=XnlBwzSAuMsix6g9y7HhOLDgYuveV64IXsIo/f4KUrTpG5tdFO32Z3HYipXkqYDrgS
         mq6DqScnNMLRo6cvEzSkUNu7a/4851JCANbRc/z95behVhT8tXn6HwO+j16w4yGu1pv/
         mUSYqfmG1A9ZDyldb2JMSVmRxo37s36r1I+paF918zgEwqrPg9KiD93r/s+EO7E4rSn9
         jXDvkb4/p9EWsdmxA6o2Rh8Ac9LWGBo5Q2A87SyB2emtJ2SFmQj19SZ8F/sjwOOBUp5O
         chr3mCLsFNDQm4rndUePU5xUGoY8dS0zwfTiD3DMvznoddqlHoOTcgNgWipF2h7eJr/D
         DXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzMlDmykO7ObH+wSLMFbFZbe2xHU17qTZaKgiOxqEYe7ZxlqPrchtK1py8tDB9wsAv/wvOeO1D8hus7rIr+FrmV+nCQQ0qUHTe/3/1z96B
X-Gm-Message-State: AOJu0Yz+0HIOyLrsLNvU72A93Cn8lZjhg7FNKWep4aXK4tahrwPgeUdG
	knJ2ekpS2v+gXCUHdvC/PHaU7EYxxRyEXv59n/gIuzUAo52+kzCEPsJKMhhRFg==
X-Google-Smtp-Source: AGHT+IHagw1kJFyHr7aumQ6VVYFpyQcraFdxbmvsNxzzJN/4xkU5PmluPOJ0qvhBBB6jr79Q6fO2fg==
X-Received: by 2002:a17:90a:7286:b0:2a2:d41d:2258 with SMTP id e6-20020a17090a728600b002a2d41d2258mr8360479pjg.28.1712618433895;
        Mon, 08 Apr 2024 16:20:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fz7-20020a17090b024700b0029facfb3f25sm7026022pjb.45.2024.04.08.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 16:20:33 -0700 (PDT)
Date: Mon, 8 Apr 2024 16:20:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v4] checkpatch: add check for snprintf to scnprintf
Message-ID: <202404081620.551120F8EC@keescook>
References: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>

On Mon, Apr 08, 2024 at 08:53:33PM +0000, Justin Stitt wrote:
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
> 
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
> 
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
> 
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
