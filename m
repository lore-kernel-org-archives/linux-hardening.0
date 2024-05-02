Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A34153833
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661653; cv=none; b=MC5KI+mbHRvRUBd/7bzQARAP3fgcuk22mLBhUqXkXbj6y2+N8f/QsXhCtudYBoVhXjnqala+3bi0t9QfOGJh91KVMXfJhFfNEU67Ny8aCxm6qLtUaSkJjLZCYBV+L3e+xLLW72cYguuB/V3F+Z2GcSH9tHQVTXDKoAVlqG77n+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661653; c=relaxed/simple;
	bh=dLyycVBVkCwJPrx8KzaTxTts64S+6ktjBjYM8nUQXFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YScORpOMh4bK5waeYSgWCwTAFVEyZujDLcIaxE6dDGUWrTMUxUBgeCuUYOzMsc+RFFrvAYrVyxtx2hJredJ/tygvsgAj07uErcAEyr16oznlRbxGRbhdsthDBxmRTAOZv1Ni4pQx0atKEWbFpqYFfMdebczyUrvcpzzerGSd9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nKLmFHdF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nKLmFHdF"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so6792034b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714661652; x=1715266452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=toaDt0gOM/D9JW9cXIx8ra8kanOeaIOI7YXzr0B4QfY=;
        b=nKLmFHdFCt/pv/ZAHD41QaOMbOVSLeoGAC47j1376BZ+ghwPkSDzXOzmKsYyED/YHp
         qKy1Cyn/5IQ8e0StiLunmy16/I9gwyIzcLpG6Nvk+8wvO/zxjTvvzBrc7XTFo8eFMgrR
         q1wsa+FkHItLcf57zQpNacC/kBqLlpV0kkO2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714661652; x=1715266452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toaDt0gOM/D9JW9cXIx8ra8kanOeaIOI7YXzr0B4QfY=;
        b=anCmb/JWL1Bq93ATLyqvzQ1VBoDLjg6xX9e1bWWksRvCIfPS1IelhXtSQw9g0X1uxy
         X2L/Ax7/MEUxE0aYCuAk2F0ws37R0mvVq7ff1twzDSH7+PiuqQur4+xeC7nzG7JrdRQd
         iLDSD+IoErg0pJEtuOexe9CeVGFPvooiBHEDZEPBOvsF8KH4kDfn1uMM1lJSWX8A7kP/
         6hFMGnokGYeaLU1HQW9kgOcHPLQfyDsYW6tjz1MpbIU/6p4+40Kb2bte5W485fOi06/N
         xFC6C27Lm8A8ilfPhzmZjy8LUb43HYM7yoZxoUrjzSCu9X/GvYgAzGUSf/w9lXFnizXc
         rvOA==
X-Forwarded-Encrypted: i=1; AJvYcCXD+g5y8hG7Ai1WZJ3ruBYvnh7ZeN5OEcALO7DClF2Y2toVpV6cqvNJcGPCQuhu70D76LOEHsBYUj57frFewTiatPzCqvMdnlB/bfvFp2Ra
X-Gm-Message-State: AOJu0YyqOexmUeJCIO9fwfpe1Q5H1k4vqMb9WhyMaSClOIosNEarNDo3
	6flEmfC1RizvZjv010QGTN0qFUar/QES4Hhaovv5HpKnLwomrIZmGH1vHdDPKA==
X-Google-Smtp-Source: AGHT+IHTLCUnM12DuL3VBb7A6wxk1Lbr3S12D3rWq5l5tjqb9FkNWWaPYTh3WMolJVPPLDC4uTFZwA==
X-Received: by 2002:a05:6a20:3218:b0:1a9:d6e2:66e9 with SMTP id hl24-20020a056a20321800b001a9d6e266e9mr2076610pzc.28.1714661651780;
        Thu, 02 May 2024 07:54:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j4-20020a62b604000000b006edcbbff2b0sm1311726pff.199.2024.05.02.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:54:11 -0700 (PDT)
Date: Thu, 2 May 2024 07:54:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string: Add additional __realloc_size() annotations for
 "dup" helpers
Message-ID: <202405020745.725A922@keescook>
References: <20240501233201.work.732-kees@kernel.org>
 <CAHp75VetkKYhnOaoM880D+VTR96NscQfBGddgAwKz681Uk5ZJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VetkKYhnOaoM880D+VTR96NscQfBGddgAwKz681Uk5ZJg@mail.gmail.com>

On Thu, May 02, 2024 at 12:45:33PM +0300, Andy Shevchenko wrote:
> On Thu, May 2, 2024 at 2:32 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Several other "dup"-style interfaces could use the __realloc_size()
> > attribute. (As a reminder to myself and others: "realloc" is used here
> > instead of "alloc" because the "alloc_size" attribute implies that the
> > memory contents are uninitialized. Since we're copying contents into the
> > resulting allocation, it must use "realloc_size" to avoid confusing the
> > compiler's optimization passes.)
> >
> > Add KUnit test coverage where possible. (KUnit still does not have the
> > ability to manipulate userspace memory.)
> 
> Makes sense to me,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 
> > +               checker(len, kmemdup_array(test_phrases[idx], len, 1,   \
> > +                                          gfp), kfree(p));             \
> 
> Despite being longer, I would put gfp on the previous line for the
> sake of logical split (and additionally to be consistent with the
> below).
> 
> > +               checker(len, kmemdup(test_phrases[idx], len, gfp),      \
> > +                       kfree(p));                                      \

Oh good! This bothered me to no end too. I will adjust it. :) Thanks!

-Kees

-- 
Kees Cook
