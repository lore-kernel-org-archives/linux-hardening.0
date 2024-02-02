Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE0605D3
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864692; cv=none; b=Tc7/ifOZiaGBvr9tMKDKfgvEBIWixB7VowXFK14jTmjs80OSVc0ZhogFxmAbYC3cA7jUTq8kAoorRwLjcxeYabTVRYrWD9dU2VpJEijtcAzdtjHC0ImwpwnBnWa7FaKGqcx78rBJAO+tUJgB0YeshTvz0RemrCrz/rA2uuXBrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864692; c=relaxed/simple;
	bh=BBiGTQfCNaB7Kq7YA7wFiG5dKzt2Z3UPZ6PxC1Q2fSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pggoqcetb8VvBz5G2oX8/rmNCwqXMdq7BFhyI5s5jycNJ8YIOpTOtF13Qurtha+r5eB/1qR+Z5mWl0o4Et0/sL78MRsDy79FKlEYDmxo+LWv2Dgev0nGEi4xlF25ukJgUDO6+ZL5BUx79H+PlaAOsZMQiNz5bgeZS7RRAidureM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b4BdVuMh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b4BdVuMh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d8ef977f1eso14638345ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 01:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706864690; x=1707469490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwFlbtdJ66pyTm9gRHW+e21CqmMPWXkoeEmM0oDBHOU=;
        b=b4BdVuMh0HR8pwhm3eoQvzcUSGO7Rmyz32RYYNDJ+IgmAFOWErIC7fFPx89w1Vd4ue
         DJws+REQBoGEqGHvzKWKS2Vv2DX1n7ztiEnpnZDyzvUVzSErrVDbZQti2zoAOCNUyPie
         Dckn3xMR6AfnBoLmCQ8hDYy0wupk5xXFYUEQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864690; x=1707469490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwFlbtdJ66pyTm9gRHW+e21CqmMPWXkoeEmM0oDBHOU=;
        b=lGfiK1L1Ism+zMqw/IkzzJc1xRib6H1qdfqN4cTrcgg/NNu6/zaiuPcQC3j6ZO7qUi
         KQIZx03y9SGjQI/5KR4MsesTMeQdqcPfo4jgYEsMD60imZFDUpigDQsVOgrVJfxFb9h4
         1uvfraZIRn1DO2pTj1RHbGCXRZvBuTi2iKTqubwJD0zUMQQ/bAiz3dpIs+8nOQJlgCNr
         rY+RrsidJplMgmdt8WnCvF8cB5pvgbPirzSKCchHCrFbXbaDEi5Thj8DTjQtMx4NAeOW
         rLikcmhLPMZjftwTW0IxYo8qkrmdDxK7TvOnCrT7dpWW7/eCbwMrttjcAfJXxN4luAf/
         RXnw==
X-Gm-Message-State: AOJu0YwYrhaC/cWMRe3Pp8rC3ExSL2826erhWYTr4761tBVpj1OSlZRM
	xexXm8zxQfh1LFx1hTE9t9uaLqfZuMHAaoZaw844bquwsTk8hIaJ4Jsk9wvVoQ==
X-Google-Smtp-Source: AGHT+IH4DGw/F8QxwcSONRsrVNZjflMrFI8GEknv9TxkBxZqyPabQDb8V1ZdoMmSWZsNrlkuSxPisQ==
X-Received: by 2002:a17:903:286:b0:1d9:6dc6:6616 with SMTP id j6-20020a170903028600b001d96dc66616mr1772479plr.68.1706864690141;
        Fri, 02 Feb 2024 01:04:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVvAhy/5lWIwcusNfI357lT+O4WYngZgf1cmI8o2gZZkdf/5rDyAgPd9oa/BweTZ8uawdphoTjmHGQGD4JtVnWkN6Zk1vl2atj/DkS1hEF6P2/w3wIU4wT/2eR1iDeT7PyXWzH6fRvmudDn7AIfnS+oZWmJBYjgikELMa2Ui/iWJ9d5K04SJw62rLeV/8Mv4Rl9gq4xz2YmY4rF0jtoI+zcRV1B2rxrgc+diNPooF1tQ9CbaJFzfDizLiI32TYsswr057p/WYdcVoS/GKY0X3EiB3KyD3nZFXVbtWi2RBjW/nkWIUOH3H+Mg3yq6Spj3PRK8jZK29H7dGRnx9Aix5dfUFkuFcRPMyXaPfhRygTwMWhe2jYBZRfwt2WJ3WqjSAgkMtAb3/VGAFk3umRVRL6EOxwoabcP8k0yBFZMpfbVoAX2WHAnMehrl3S6kdSz9FNCNUgNhDxv3mpy8uc7rAbs14LzW3lFR3q9F3hD
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001d923684323sm1116244plk.195.2024.02.02.01.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:04:49 -0800 (PST)
Date: Fri, 2 Feb 2024 01:04:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] overflow: Expand check_add_overflow() for pointer
 addition
Message-ID: <202402020102.FDD94EBE2@keescook>
References: <20240130220218.it.154-kees@kernel.org>
 <20240130220614.1154497-2-keescook@chromium.org>
 <ac88504b-1edc-46c5-ae61-7a634b156275@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac88504b-1edc-46c5-ae61-7a634b156275@intel.com>

On Thu, Feb 01, 2024 at 10:19:15AM +0100, Przemek Kitszel wrote:
> On 1/30/24 23:06, Kees Cook wrote:
> > The check_add_overflow() helper is mostly a wrapper around
> > __builtin_add_overflow(), but GCC and Clang refuse to operate on pointer
> > arguments that would normally be allowed if the addition were open-coded.
> > 
> > For example, we have many places where pointer overflow is tested:
> > 
> > 	struct foo *ptr;
> > 	...
> > 	/* Check for overflow */
> > 	if (ptr + count < ptr) ...
> > 
> > And in order to avoid running into the overflow sanitizers in the
> > future, we need to rewrite these "intended" overflow checks:
> > 
> > 	if (check_add_overflow(ptr, count, &result)) ...
> > 
> > Frustratingly the argument type validation for __builtin_add_overflow()
> > is done before evaluating __builtin_choose_expr(), so for arguments to
> > be valid simultaneously for sizeof(*p) (when p may not be a pointer),
> > and __builtin_add_overflow(a, ...) (when a may be a pointer), we must
> > introduce wrappers that always produce a specific type (but they are
> > only used in the places where the bogus arguments will be ignored).
> > 
> > To test whether a variable is a pointer or not, introduce the __is_ptr()
> > helper, which uses __builtin_classify_type() to find arrays and pointers
> > (via the new __is_ptr_or_array() helper), and then decays arrays into
> > pointers (via the new __decay() helper), to distinguish pointers from
> > arrays.
> 
> This is (not just commit msg but together with impl), at first glance, too
> complicated for regular developers to grasp (that is perhaps fine),
> but could we make it simpler by, say _Generic() or other trick?

I haven't been able to find a way to do this, unfortunately. :( I would
*love* to find something simpler, but it eludes me.

-- 
Kees Cook
