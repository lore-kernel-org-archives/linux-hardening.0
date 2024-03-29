Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9C39FF7
	for <linux-hardening@vger.kernel.org>; Fri, 29 Mar 2024 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685152; cv=none; b=aLUcLbEsjKCB5I53krAml8s6tE4wJvK5X8xDj+zT0VGm73LlUrzU5KfmT9QNFNbFbXx92jOsbIMFsbFxwGAmJYxbUNWUGILoKRshXCoxkImpfdoMSaGUOCfRepX16zs9/OFVtU79dfE5MDMed+4SNIDOU00p3c9bIvEkGpBNLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685152; c=relaxed/simple;
	bh=ugCIfDN+OS9coGjwoiaf4ai/m8GH8gwnqHmA5Gon2/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAIR0kAV/eHGr3XDdxKvDHuRQ4TUIt9+PK6tcQ8TwCIcuH1af2bC9M09BCihm1/dIjoQK7SalpTGoEj6qtRE62UOn09yTRgDX4rNdrb063i0M7CHVpvt1O7qBNqn2fNdQ3byFdHn1vfXSo7jIbnL3MpLuz0g5ulIUJMIWwaLS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cbCphAJ/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbCphAJ/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0411c0a52so14907435ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685150; x=1712289950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ChZsgQ1Elm6q3+e9M0QuKvut1I0AizgGhlSGf+ASGQ=;
        b=cbCphAJ/SIsKeYMvVlUUKVR3hb6BCeqlG8dh8614+n6QCNMHn/Ot/lm8RxZJJ8ZbCS
         l/5ABluekQarr3bXfg2Ypc0+JxbEkYda5VV5rWLVYEAyR7Fl9UnCHUz2e7uGL+7i7voh
         AE3OW9uf08XQJRxj/2rh9/sCUvntaH3rIHevo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685150; x=1712289950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ChZsgQ1Elm6q3+e9M0QuKvut1I0AizgGhlSGf+ASGQ=;
        b=bjUeK1QzcwLT2K1v21bJtUO4jsIsYFgoUnA5enXEHYE4Dyxmz0hG1dSDHYPDNBCdYH
         CaU9BKt7nV/9otnj7EZ5VNoFeEOKUCJBsf4cX2tEuAKqaRmMR4txUqee0xKKBp1iUydM
         R1DcEyvoQJAEsAQMbOijnyFg5NdouvLuvCcTmUj8ewUlVXbv4o/ZVJ2QCfi6SaWeFcfj
         m3cxrmkTQoRX7os8HMkBEtxx8gCaXcAYiGS0zd2/d22bwqTclPj5IVzqhC3QjU3wI2ML
         Fsw00yC5OtdKd/Cey5JXJNvuAB2yBgWkmj452Ux+cGTD/p2U0962qmdehSCjwSAn69tR
         4sNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwPgQRQuJHUhRC0taOhced7EHKzD+6Bz0TP5VmE9o07B8WX00fC6MXBl07goYcIc2eO5vc1/P7EvQXUBwSWwv6JdqfG6zKZ4QKYvVGJdnM
X-Gm-Message-State: AOJu0YzEi2TqMaMekC1LioorqHUnTGPfDGDYBwTjbjEfpFQCdMIaJGQ8
	URH3r1BfkSDeBw460S159qrChUEOK3HTCGvl7ThoWRBbPHpSSCwVmLfjnFqobCZr+HGxMAKUX2g
	=
X-Google-Smtp-Source: AGHT+IHz/UtiavMzvnaxiQB62DEnni3iPoJJtX7YuCgTzgK2VTzAXvvO9TtTSynjiOUlcZ2jj/z94A==
X-Received: by 2002:a17:902:ec8f:b0:1e0:bddf:7ed0 with SMTP id x15-20020a170902ec8f00b001e0bddf7ed0mr1612364plg.27.1711685150349;
        Thu, 28 Mar 2024 21:05:50 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001e211a291d6sm2465575plg.260.2024.03.28.21.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:05:49 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:05:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Fei Li <fei1.li@intel.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: replace deprecated strncpy with strscpy
Message-ID: <202403282105.321DAF619B@keescook>
References: <20240320-strncpy-drivers-virt-acrn-ioreq-c-v1-1-db6996770341@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-strncpy-drivers-virt-acrn-ioreq-c-v1-1-db6996770341@google.com>

On Wed, Mar 20, 2024 at 11:27:09PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We can see that client->name should be NUL-terminated based on its usage
> with a %s C-string format specifier.
> |	client->thread = kthread_run(ioreq_task, client, "VM%u-%s",
> |					client->vm->vmid, client->name);
> 
> NUL-padding is not required as client is already zero-allocated:
> |	client = kzalloc(sizeof(*client), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Note that this patch relies on the _new_ 2-argument version of strscpy()
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
