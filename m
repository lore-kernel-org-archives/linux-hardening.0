Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA9171671
	for <linux-hardening@vger.kernel.org>; Tue, 30 Apr 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499320; cv=none; b=o7RYW6hk1wgKssUihSbCCYUIyLTj3TIkGo761yRJ75amedpXWSbVa00DsBU04jYnku4pA2SwNwK6eEBgWaQA0FfWgOC63ZgLc403ujLokM4gKDSce1Tg4SQGGaGW/S9wtTJkgvGhzix6baHPZjpzYToW0A9+mLQOhxB9tTPsOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499320; c=relaxed/simple;
	bh=ru2MPyzMZQzjMduhv2N2UQ/9xbQn6QLmgfDKm1rsklI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiiL+VZYUijbGhuroAP5cBMOR2Vq2r8tjFW6o+kSjE210S808wgcFEzCdR8j0NS61adkkJvdKMk4zfBH7v3JjmtaCVgm8RBNCyZ23XDosVuyFZSedtkiDeLuKei9o0SdwqglBhK6xg8uH1DfzqRhTpSME99pOLcz+rRgeTq6jwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YlWfulRY; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YlWfulRY"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa17c29ba0so3992704eaf.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 Apr 2024 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714499317; x=1715104117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDq8d+gYPhH6UpCrQkijKEWZF+TRlH556m+C6sytk2c=;
        b=YlWfulRY7nqh3laQUcmN1fEm+6AaaTNAbM0M0PvA/Ad3IlANOoIDFKMRqieXqscD9L
         S2063I0rnjX5djdZo6JncbvbWsEHBi4my9rWG2UE9ku93DiXD/XdX/0Ma0VdhytQxvXH
         tavJxQNCWhxr6AhfBL8j0GiY2ayarvEst8738=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499317; x=1715104117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDq8d+gYPhH6UpCrQkijKEWZF+TRlH556m+C6sytk2c=;
        b=RACJWb0jUkz8SeZbJC/l7fYK8ie/fJaix+G4kqgWDPqXE7vjaMC1ElZcm9OcF6OchC
         7/Pf1vDw2D91IXGUOwUxuF5u+zS7Kw4zRzan2Cjl+JAkp3zuuK4nXepn1VIJAXu9nBzy
         Ys1GG6pmyaZpJCIOS+g8GhPFLNQpM7iknfgwTko248Mg78FlcKK0edCGzJdPV8ib1lnq
         hq9NytCihHJCbRswUnHAVOjkMDvMJMlNgaJ1ybimIQdgnhUtu+sAj3rKcsXlJuMSNrbc
         ot0NCCCNziyzpNf185IQor215v+VcPglAofNjWwmDj0zKAKNux3xEV/4JVVdWRjuktOY
         y+UA==
X-Forwarded-Encrypted: i=1; AJvYcCXkWxnPlOmXdI0d2H1Y4A6Z/xuBoU7obLETbqUXVi7uKfvyjlbZLr+gLfMncW8KJhDYYWP4OPU0PDaOssLuPS3F2JbqQlJE1xHkpW3pn0XE
X-Gm-Message-State: AOJu0YwE+QzQNlHNV7lrXwpRCfpt0cEAd+MtBTg5qcL8jDo2KI8AZ5rQ
	ymbTJmVylBxASoq5pZXzOZrX/1u3UmMVCq31nKgNNH2EvnY/14T055X/gBvqVw==
X-Google-Smtp-Source: AGHT+IEmbtVwIHw8WS21DEFm3vZJtcsGN62O+K99Z6mISqTw/HC8GJbY1ZGTCLogwTQdWEB73IJAOg==
X-Received: by 2002:a05:6218:2616:b0:186:5c1:1dd1 with SMTP id oy22-20020a056218261600b0018605c11dd1mr672678rwc.19.1714499317510;
        Tue, 30 Apr 2024 10:48:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l185-20020a6391c2000000b005ffd8019f01sm15483435pge.20.2024.04.30.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:48:36 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:48:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <202404301037.9E34D4811@keescook>
References: <20240426222940.work.884-kees@kernel.org>
 <20240430092140.GE40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092140.GE40213@noisy.programming.kicks-ass.net>

On Tue, Apr 30, 2024 at 11:21:40AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> 
> > - CONFIG_CFI_CLANG=y for x86 and arm64. (And disable FINEIBT since
> >   it isn't as secure as straight KCFI.)
> 
> Oi ?

Same objection I always had[1]: moving the check into the destination
means attacks with control over executable memory contents can just omit
the check.

But now that I went to go look I see 0c3e806ec0f9 ("x86/cfi: Add boot
time hash randomization") is only enabled under FINEIBT... seems better
if that were always enabled...

-Kees

[1] https://lore.kernel.org/all/202210181020.79AF7F7@keescook/


-- 
Kees Cook
