Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04841273803
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643869; cv=none; b=GpefNoI9kkvBhBBxdXiEPtC9oPwLEftHO202RUIRFIErb2a1I34+6fB0fEUbWc1Gz6P0vdyI9+zIGVfT8YKn+2Cnz7Iy8bCwNu4nZFWI09PkKwrR2keiwvraYk4iS2FUI66KaWmx07tgn10hVwLAhuzB14aBATsfBj+G+7n54GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643869; c=relaxed/simple;
	bh=7DrDkh1MdA6uSqBQ5CbfVgpSm9/B9vMLnaxuhoH18iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trSqP/50cqDP6+w5bgHntxxGIOaVk7sUXkQOrtkylmGRhBcAjqNDu5506KTqLV7KCaLNr36xAGFaBmoXZA8AIH4u/iw61ROgPNbNdt2xjvM8kFsxPUitWpzmmxqRqm+RjC7HvIcwY1N9ZD05/197VKfSy3ZgiT7j8z1ZflcLYR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FJW4H1Wd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FJW4H1Wd"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so339630066b.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774643866; x=1775248666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Av/df3qif+QjKoKY9+YCbaJXOTim/GWUPhw+sxk+WsA=;
        b=FJW4H1WdqLnE6kAk/ohj4JNa+FCEl/xpeoOFKQ+bxXfRzkJp80a2NDnkiuZZUv2Jvd
         xPE1giPpeKdE4VXv30OPI3G4tc5+uRNJCfHpiPkRV2XYu1Qhgj/+jPOiNJVKpEB4sRos
         1DQwpjZVApDe9lTND1QhIwKlwQRh1JLdhw30E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774643866; x=1775248666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av/df3qif+QjKoKY9+YCbaJXOTim/GWUPhw+sxk+WsA=;
        b=meqVnFdAiP1W7/1PEK1f1pLOTtey7PkvFfhX1muNiJT4dawzFFKCdY1hnYEgy8xvCX
         l8ZzlG3+0LgaYa3lQkwumT1XVjSjxVoEQcyBPgQiAFgIyowAyaytpfKioUYTPAaFZLif
         O0GJEHAI5GkYIZbkSsVx/E+/RgInInHYDccrfTmn+9ORXZYWzJKDzAJnhnDDB7a2SSqI
         as2dRJfWLKb47CZFvE1LIog40U+cFxIRG7/sQ3R5TF0CHncdeCgRsxlvAWxKDKhLsdPm
         tSi0Iy9W5YDeut1KoellsQ/djFVpZqRnGaw2MlWiyPphNEj2UQiftzXKGF0jHbdmk5nb
         6u0A==
X-Forwarded-Encrypted: i=1; AJvYcCVyAfWj5LuGfhqfiL7LMlF3LBD+UWjls0K2UIyhGzUEWpx47GNFYFcBwUOEURAYwFE+nw65+19HRKjt5SGT+a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtnPpcR6QLU+leSmeBW2eR76uA3o0vvrV6d4tGmGbGGEUJQ/Gp
	NrOZbke8+24917KhixBRMDNuErenq3HzwWd5QEKyRgLNXoe405HuKfJeJDtnXerJ93YxRemo1IE
	T62ipjy0=
X-Gm-Gg: ATEYQzzp8f9vjfyboa6huS2U5/lBJ892vxYSEoXjlDY/klu95qsSL7cbsV7OZv81VRP
	jNbqsRQFWW/5Bxj2zBPEYU3ATnJ2USGFKHBdyf73P5BDRVTbjW3kh5RZE2BqY9Ue0Djy/fW2YWI
	kUSCnR9rtHz5L/LccB4Wo6/UR0sgBz8d0CPAyiunh/v+HjaJ05k/LeGLUu7Q9iriBIDzBt44BaA
	Kkm1QecomYAWSHv/+T1ZUXVoJf1ba/gifhb+P0JpZbdaoiRJYYk5JRcAdPElzNOPNPAQ8NwIkti
	GSwb4+Te0FMkG5Qtm4921VmL6dwt3cK4KgIMFH/4KfcyB6/JJHE/SOUolP4rcO1O25t1XBc/5kd
	ZvR+oRCNfT2odg1kuAsBVnWlpQi9C8NLP27Oasr1mB+fsFHqcZvzuKTnQGjlPx3aD6RNqNE0/BN
	uuPTmQfcnB/jvWAhrzfuAyXl1aJF2nBsogJWT1DqIWFwijgXbs3rHZRgw/w4j4AjYAUVLFtNg5
X-Received: by 2002:a17:907:84b:b0:b97:1d24:bfed with SMTP id a640c23a62f3a-b9b5090d89emr285793966b.41.1774643866142;
        Fri, 27 Mar 2026 13:37:46 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae23f0dsm11649966b.11.2026.03.27.13.37.45
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:37:45 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66aed966c7eso4096420a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 13:37:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXH19nx6YrHHnLNjovIWOaEONRVW8cS3f441cF/oYL2byN+82L8WUnK8QZClzpXFykFWT/ugYpvZK/uPlE5aag=@vger.kernel.org
X-Received: by 2002:a05:6402:27ca:b0:666:d779:1f40 with SMTP id
 4fb4d7f45d1cf-66b2836b5a0mr2511706a12.9.1774643865164; Fri, 27 Mar 2026
 13:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327195737.89537-1-david.laight.linux@gmail.com>
In-Reply-To: <20260327195737.89537-1-david.laight.linux@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Mar 2026 13:37:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgADjjXEN_8ANbU_E94uxbQHW-3v5p0-pwLOtTvL+0Wrw@mail.gmail.com>
X-Gm-Features: AQROBzBZeBQ2z8oENy3-idgK3uCSS4AhNqKO0uX5C3CRTWMtDw8UM_NDiLWhs3Y
Message-ID: <CAHk-=wgADjjXEN_8ANbU_E94uxbQHW-3v5p0-pwLOtTvL+0Wrw@mail.gmail.com>
Subject: Re: [PATCH next] string: Optimise strlen()
To: david.laight.linux@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 12:57, <david.laight.linux@gmail.com> wrote:
>
> Using 'byte masking' is faster for longer strings - the break-even point
> is around 56 bytes on the same Zen-5 (there is much larger overhead, then
> it runs at 16 bytes in 3 clocks).

What byte masking approach did you actually use?

We have 'lib/strnlen_user.c', which is actually the only strlen() in
the kernel that I've really ever seen in profiles (it shows up for
execve() with lots of arguments).

That has tons of extra overhead due to the whole user access setuip,
but the core loop should be pretty good with that has_zero() thing.

I do agree that we shouldn't use 'rep scas'. It goes back to the
*very* original linux kernel sources, though, and I've never seen it
in profiles because very few things in the kernel actually use strings
a lot.

               Linus
