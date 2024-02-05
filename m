Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4482C6B5
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137975; cv=none; b=fzQl1VgqB7E6TSGLuAkPPhdrl6b6oJdcdfR7SeO2FOE2wOVITzGiMg7EsyEnZktu0rWrU0lQG+IhAkkl+bT2CZAGO7SwNE1Mvh6RT0+HmyPLIe1xW9BXli6nkhc9DjuYHE29m6tooVJXXu+uXn3/se/V7Ngs7IQTJMIToqBEcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137975; c=relaxed/simple;
	bh=uhFIx9AVIok+41rhp4wPBkQrIYsfWY6OWQrAj4yf+r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUSw5S3mfmqvP4n4u2yTK0/zjXf9SyHEiArUBgXhNC0hUHDwtWg4nKu+HJ6WvRkNEt+xDxPBM4OFvdI4h1aTwVAHmGI+IbecGdB5lrIbcxzo61hstLlxOhrIQZRh+sIOoz+6Nv6Bv1shWUQqxK8aZP84sVKEpmUzS8fLRqr3ydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J6e69CJj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J6e69CJj"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0523fbc27so78438b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Feb 2024 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707137973; x=1707742773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEQX5AABggM2ljP9SXv5rHakiVcpbdiil+FOouwBr5w=;
        b=J6e69CJjS/IUfmK9Oos4c6q1j7o03TWlBBJwzf/LHjjuQhLb5o9D6eEyT8wEhtJN64
         gyRmfyoe2grlpKhdFkwBPIU3slCeu96hMQGmD1N3ChTAarm203FkVAhCfhoika5pVWg+
         akw88kNy6RuorwuFx6D9MXp7mEMSt0BExUE8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137973; x=1707742773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEQX5AABggM2ljP9SXv5rHakiVcpbdiil+FOouwBr5w=;
        b=RZTJifogSD1epVxI1MFrWUXHH8VZXonCBrdN04MhsNwwHQBww1GjmiZFx1/Gawpp+6
         W5cW6F6//JykweWPxfKTMh5s72tL+bQq6Za86PQHdusoLAmTLTlgENLrysp8++3hJNnA
         aoClBLd1lp3pzaQlSSro+w8O+jSFJP5xMbEgENN7mZrVr8wmpYI+7yKBtKxwSntEY+dZ
         NhR9LplMCM7DxojtTdDl1HIyeOLfyIPYEptjvXldbhT6jjPjPCyYFo/D+Z81liYkY5AK
         N9SnSRUYDmfVbRQhl6sO55qonzStb/d+SGTNaAgALx8/2eveJa6us8dVpkhDcWSPTUtY
         XmTg==
X-Gm-Message-State: AOJu0YwMlvbkMIiM8y7M5XEljHbF4sfjfu9yB2kCC+FbA9Ix5A8M6HzM
	YRXprgtaQ9V2bwlaflpbYRQuFD1H6Jmk1UkUu3HB9ecjA/rZ8rYPVIt0LFxpwg==
X-Google-Smtp-Source: AGHT+IH7TRDxNi2WEgGcB1i3d2oWtRwWhybfRytEZQiNCdgIzjYBMwnWPSCbkQGdExjKAlGZJbGBWw==
X-Received: by 2002:a05:6a00:1d82:b0:6e0:4be0:ab8b with SMTP id z2-20020a056a001d8200b006e04be0ab8bmr1564859pfw.20.1707137973105;
        Mon, 05 Feb 2024 04:59:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWdoon760LIuY5iUr9Hi1uwh8Klg/rh5yNXbpvuhjU1iSvDcI3jtn6GKu0BG9nDz2maou2kIO6N2SUXiKFH60gqsiXSMqdrzhd/XB75C3TRmGl1FTT3s9cQl/oSFe+anrJcpQZJevxFFZZfCQGVcOQ3bPlOJZ8o8QEa0A+EdQ8NwvOhefWaUcn4Hrzg4Dy2RXK0JuqOGz3Ubl+yVGc2a8kwz5g1KryQMA/W9cZOaCmo5bBL3JZSyTR6H8RFu1toDUEKycxhoKWLn8r1oxbqM1h11dkMpheSTbqHKQWT+DsCyhiE6wTcCFWBWDjK+TvNajeRGVFA7XKltL0UAHkKcDzp/iEWn5z5Gbn1qgSA8mqCU2R9YROzvb0n0Ny/xazTsKF/pyYWt8epGa5maZYF+tGbqJ6xVgZvn5J+omKKi8/nnmpIq3c8u5LZycH2FfSC0oyewbiOEZmP/QXB8eqs4FMa0V9P+KJ31ARWiXbHqMRd5Nuwj8jsBp741fDJ3iLMjONrghnCqcBB8zboGm/1jAQLbFMvRjYkpIE=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id it16-20020a056a00459000b006e0416c42c3sm188892pfb.198.2024.02.05.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:59:32 -0800 (PST)
Date: Mon, 5 Feb 2024 04:59:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>, Marco Elver <elver@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3] ubsan: Reintroduce signed overflow sanitizer
Message-ID: <202402050457.0B4D90B1A@keescook>
References: <20240205093725.make.582-kees@kernel.org>
 <67a842ad-b900-4c63-afcb-63455934f727@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a842ad-b900-4c63-afcb-63455934f727@gmail.com>

On Mon, Feb 05, 2024 at 01:54:24PM +0100, Andrey Ryabinin wrote:
> 
> 
> On 2/5/24 10:37, Kees Cook wrote:
> 
> > ---
> >  include/linux/compiler_types.h |  9 ++++-
> >  lib/Kconfig.ubsan              | 14 +++++++
> >  lib/test_ubsan.c               | 37 ++++++++++++++++++
> >  lib/ubsan.c                    | 68 ++++++++++++++++++++++++++++++++++
> >  lib/ubsan.h                    |  4 ++
> >  scripts/Makefile.lib           |  3 ++
> >  scripts/Makefile.ubsan         |  3 ++
> >  7 files changed, 137 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 6f1ca49306d2..ee9d272008a5 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -282,11 +282,18 @@ struct ftrace_likely_data {
> >  #define __no_sanitize_or_inline __always_inline
> >  #endif
> >  
> > +/* Do not trap wrapping arithmetic within an annotated function. */
> > +#ifdef CONFIG_UBSAN_SIGNED_WRAP
> > +# define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
> > +#else
> > +# define __signed_wrap
> > +#endif
> > +
> >  /* Section for code which can't be instrumented at all */
> >  #define __noinstr_section(section)					\
> >  	noinline notrace __attribute((__section__(section)))		\
> >  	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> > -	__no_sanitize_memory
> > +	__no_sanitize_memory __signed_wrap
> >  
> 
> Given this disables all kinds of code instrumentations,
> shouldn't we just add __no_sanitize_undefined here?

Yeah, that's a very good point.

> I suspect that ubsan's instrumentation usually doesn't cause problems
> because it calls __ubsan_* functions with all heavy stuff (printk, locks etc)
> only if code has an UB. So the answer to the question above depends on
> whether we want to ignore UBs in "noinstr" code or to get some weird side effect,
> possibly without proper UBSAN report in dmesg.

I think my preference would be to fail safe (i.e. leave in the
instrumentation), but the intent of noinstr is pretty clear. :P I wonder
if, instead, we could adjust objtool to yell about cases where calls are
made in noinstr functions (like it does for UACCESS)... maybe it already
does?

-Kees

-- 
Kees Cook
