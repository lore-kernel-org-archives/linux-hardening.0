Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB81365
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524357; cv=none; b=R9qFtINruVePQJL3SZYB2H7f3fph8/wQ8e26yDHQZNrur0yJjwD0iV1bXLHTKJYVPWuTHldPFncsH4lVSQTDgTSkA0TfWmbg3B0jNwMsTT9fmuTkG7Nd1Jp4I8xMQCVMkI/fh1TyJgjtuaeQWZV6djc3HZbbyRDt0HE0mGZe7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524357; c=relaxed/simple;
	bh=iq6fpzNvbrNJsO1zqHNpHfgJclfdwgHoVjvfJjXyk8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgM8Yz8sjLSc+bl1BHTnW1GtYofwA29F+4vnxJWJ3Ob5R8pOS7v3ideLuZP3Z0ExsUzF1+GPUTbbKBSnn+6Pe7xfrYcBNGWkkbmh58ZxBzGDZqgfHtYq/SfiwJwu3QnuB+u59MtIsLz2IDghUhWoZ4d9f0B05MQytDlxGXDLdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UYrDWC6t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UYrDWC6t"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d94323d547so14166285ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 09 Feb 2024 16:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707524355; x=1708129155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wpUjtDpALKnkVEQ80qom9sdufdRNVtjYZoE0nb9Fp9w=;
        b=UYrDWC6tIM7omHrmRTTJsCJUa2c/XicRE2tzQ2uRVBXOTu8734asInWDCqR6lE2Sa3
         CKUP+cdHX/SJx07MjXMaAySBfBEuR/GxyvhN//kdaqOv9tEXH8aqdbTIHLBc0lrvZn0v
         UrD0j8OqRmniFiHZBdtPxlPvWo+G5pGJ4P13Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524355; x=1708129155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpUjtDpALKnkVEQ80qom9sdufdRNVtjYZoE0nb9Fp9w=;
        b=JbVSPMBZn8k0Z+RkvNPt8R2RAXh+CrTfyGsp8CQd7NfIdCTPkOBaDhtvkjdzJXid8w
         OO4RZObuiHeI4LHuGa1FMQMuD+ZkG0o3ZDnbkKmGFW9ZwxfzEra1xEEuXrT+mlYNnibO
         W/fMbl3OoOPJTTLWZM10xLLAnC/WyFb82HFoWnqXsuKyUpTXx0XSioD6h86HdSYwRzUR
         iakiJxeiv42KJKECkXPmQm+SZLihghjaTGQG8kJWOU+wT5KY/Ybup3bPkMyaNGtZt1Zf
         4KS7KM+pAoVs2NySKp0PDkw6ZOcL5Oce1tX+bpjnukHk13oz8o5+olBWVP+V1nu81xaP
         qQ+A==
X-Forwarded-Encrypted: i=1; AJvYcCWpZ1GFoz9+jWezZnwfkYzWqFM7uCovN5+Ht8+AS8o85489KYUqmhE2QZar7JQvCgg9x+Vx6RM+qUJSAyPUewhVq6ENEmj9SpFpKg2tRwfP
X-Gm-Message-State: AOJu0Yz9O7GRE1PAPeQIJkIFW6qfWRPi+42AtT7x4oNlWQSsoNrj63Su
	dxQDRA9+FhUcUwtQlVG2lp5Lay4iLRUTcsOAF1nYYrixZx+4d5jVsBODVlzOXA==
X-Google-Smtp-Source: AGHT+IEEBZzTNPkIRqK2x7x6H9MYcqdhzdSNvyTXpmFuzJHAi/DDHjTK4INmh8ggJYegRx2ervn7bw==
X-Received: by 2002:a17:903:28e:b0:1d9:c0a0:b3c8 with SMTP id j14-20020a170903028e00b001d9c0a0b3c8mr1269965plr.17.1707524355084;
        Fri, 09 Feb 2024 16:19:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWzJB3vM8kE82tscM0uXjwXFtLiuKgEcIbJeO/MfXudqoMVv4GPR4GutCMGagbghF3TM43L91pHWQJS0YbZ/USWxr4nMQdu0MHtSxprge0pe8hl7WtjsO+43KuUT3djqjHrBDavO1+OJZWU1QI2x/1JnJ7rWWr2Js/rTMw7+TfobFYaR2TUmrWW18msicFvg8bVxr92aNyEcu6ygqKoN5u9hsvGkwkax6dLEdx7HSj6H2a9G4Xr1hbxbLP+mC/QntrZNQsFcDIpyOSQ+mNfk6uvOZyU8Sb5zuncks=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m2-20020a1709026bc200b001d958f8ab2bsm2043788plt.107.2024.02.09.16.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:19:14 -0800 (PST)
Date: Fri, 9 Feb 2024 16:19:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] irqchip/bcm-6345-l1: Prefer struct_size over open coded
 arithmetic
Message-ID: <202402091619.80D0AE3141@keescook>
References: <20240209181600.9472-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209181600.9472-1-erick.archer@gmx.com>

On Fri, Feb 09, 2024 at 07:16:00PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> As the cpu variable is a pointer to "struct bcm6345_l1_cpu" and this
> structure ends in a flexible array:
> 
> struct bcm6345_l1_cpu {
> 	[...]
> 	u32	enable_cache[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the argument "size + count * size" in the
> kzalloc() function.
> 
> This way, the code is more readable and more safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162 [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
