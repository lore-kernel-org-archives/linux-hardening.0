Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A313B78C
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939540; cv=none; b=G4wAF5ytoiWbHdrdXeIeW944xpBea1shgJdOO2p1Pf2Zdqf8VqCxuyOb7ihFl1pnIpc/woRRc5nSPUJ7H4drhRZGf7l6XRVEVoBwxd69X6Gnz6/GOLJTaZMUCeSmcL35VsDshsvkMaUQdVcGN7WxtuFU2j9lJ/9OpWg/DtCtsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939540; c=relaxed/simple;
	bh=uK/uiC9xQoMrRYzHaj/0K7lprzw7OLm3ONfyrd3XA2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzGdTRBggd03NbnTR0rrbS6yzJq4ozdIk0kJieF3e42prf2f0LGbrfxnLGBXO88cJlKpmvDjwnvaG1b8BALU31BMxkLvRtFPlFaWNaVNl7yrMeMZM3EgBsPnC0qt6TDnR9sr6DXbQayub68/ZqaanTRmqHF0X+WmFMSRwY99Q+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QxM9v6zF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxM9v6zF"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-296cca9169bso131445a91.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707939538; x=1708544338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rQz56FZw2RH2/D+KmiOQoX2U0utfpN1YnKl4r/zwck=;
        b=QxM9v6zFd4CGlpP3G4ukKltcjkvOQ8xSHSrHg0swTj9iUB5/6Xuew6PhfbKmSEjemO
         rmbQ5k3cQKhBBtSGo9AotZuisZc/3O1TQusMIze18dDAjV+1yrl9Mb+6dh1otJfMGIqE
         m04HzeKvsGg3tnDojam64hV1atXqLANR6yqBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939538; x=1708544338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rQz56FZw2RH2/D+KmiOQoX2U0utfpN1YnKl4r/zwck=;
        b=iB/G3VZOIdwEXNiBupcoK2Zl5SaXtO7++kFdXOSeLTveFZOWbjmn26XbgESjtVEyyJ
         y0R2JeyZhn2+eyAgxOEC1GQVmWuj0zzNfd9Xr8bHBs3EYM0tZpf3x2FhaM+DyeCj5eA4
         qkNozqVqx654cyvzYBQWVqVhHrJ6EvUZ9cQ6yenvgxFzyI/gXFDZZgztO4TjuSpwm9g0
         GdEsGcv1WZjEvIUSMR8WXvaleAHGSA14cW7F1Int2EzYOXlkFUaj7Brnb79osNdy3nfP
         7gtFufkIdcplOkySXUJP7XoGPu4XxORKfqlKxh1jVwGGuqlvI/eKcERJzP4nE8ntv9vm
         bg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJehG9v6UqyhFyCYEkZQz/GhNtgklCtMIwFJT+lAO3XYPLtGL62gJYWQ/LyUM2rSopT2kzCLNZGrUCxsjicgiNke3tLjvtWvcbzT5XR8xc
X-Gm-Message-State: AOJu0YwTuw35qpWv4LTRx6KVgQYdzj7FkmTVsNkD/tDApMLXA8Z4I/qI
	9ElW/pPUULMuQDnGDg9fA1sr/XMgIT5fktq5hPLvBahVSCLN2WdUQ51u0FwkU8iFqpBggij+0Pg
	=
X-Google-Smtp-Source: AGHT+IFeLbM4q9oE3yTdnPC3ZKFeX7ALUUgaZIz9TQ5M0+/49eUCHnVui91o6qgIZaw5T42/8VQ34A==
X-Received: by 2002:a17:90b:605:b0:296:2057:28c with SMTP id gb5-20020a17090b060500b002962057028cmr3614823pjb.31.1707939538082;
        Wed, 14 Feb 2024 11:38:58 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090a604f00b00298cc4c56cdsm1795818pjm.22.2024.02.14.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:38:57 -0800 (PST)
Date: Wed, 14 Feb 2024 11:38:57 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] overflow: Adjust check_*_overflow() kern-doc to
 reflect results
Message-ID: <202402141136.6B12D6E6@keescook>
References: <20240213220844.it.345-kees@kernel.org>
 <20240213221100.3556356-1-keescook@chromium.org>
 <ZcyqqN3wVrKwkzrs@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcyqqN3wVrKwkzrs@FVFF77S0Q05N>

On Wed, Feb 14, 2024 at 11:57:28AM +0000, Mark Rutland wrote:
> On Tue, Feb 13, 2024 at 02:10:57PM -0800, Kees Cook wrote:
> > The check_*_overflow() helpers will return results with potentially
> > wrapped-around values. These values have always been checked by the
> > selftests, so avoid the confusing language in the kern-doc. The idea of
> > "safe for use" was relative to the expectation of whether or not the
> > caller wants a wrapped value -- the calculation itself will always follow
> > arithmetic wrapping rules.
> > 
> > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 7b5cf4a5cd19..4e741ebb8005 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -57,11 +57,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >   * @b: second addend
> >   * @d: pointer to store sum
> >   *
> > - * Returns 0 on success.
> > + * Returns 0 on success, 1 on wrap-around.
> 
> Sorry for the last minute bikeshedding, but could we clarify 'success' here?
> e.g. I think it'd be clearer to say:
> 
>   Returns true on wrap-around, false otherwise.
> 
> Note that also uses true/false since these all return bool (as do the
> underlying __builtin_*_overflow() functions).

Yeah, that's a good point. I'll update this.

> >   *
> > - * *@d holds the results of the attempted addition, but is not considered
> > - * "safe for use" on a non-zero return value, which indicates that the
> > - * sum has overflowed or been truncated.
> > + * *@d holds the results of the attempted addition, which may wrap-around.
> 
> How about:
> 
>   @d holds the results of the attempted addition, regardless of whether
>   wrap-around occurred.
> 
> ... and likewise for the others below?

Yeah, that's more clear. Thanks!

-Kees

-- 
Kees Cook
