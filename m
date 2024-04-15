Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151F824B7
	for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204421; cv=none; b=qzB0ZGi598nXNjB6r5KN1V6PmxUAJPfaVvK845B9hEe3pbUaoB1esBljSbX3l6SYN3Nb9FsDU4hQVvwXjueZ7kG8svpmyum5VO9hoslTzA7pCa1e3fGT5NBcPn9Rx/VKDjDp6I0aoDy+z38imKR3apnoOIaJ5vMd5Hfih2SSMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204421; c=relaxed/simple;
	bh=xj1SBpac8RAPPa4cYnNvnA8NLdzOnlNHsZUECbeclDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTys4djVRJugIRqUyfC6tW9AaG/W+/fcVSKjkfd8/RDW+/87kSlj17fK5kX7lmpZgbx7ouTearDfyeMMO7TvMVVjq8V/T4r7Tv3KBlXk+LypMwFXuUXkPI/JZuUiIj7mQSeTGi49945VeHGHzdraSrNJfAqTzuNNBKKv64V8+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iX6e8Xt0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iX6e8Xt0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e65a1370b7so13811165ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713204420; x=1713809220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hkvNj0SDmFhhMkw0sRd1k/aPAqSYVAFYS0V+mjg1+Ys=;
        b=iX6e8Xt0Yu6OZ5FskbjoVWf5iLkystLO54c8DKnns6S/V6xNDjhly/cI6KuybJFvd4
         1OOvpoHigs9r1kvP2OV+TrW9OG2k7mXxBel27CFwiKDoYOKUAIdh7VlqOkRg2ntIWPke
         rsbGB+guFt2tTzsvDNPkd6m07blcl4iBB0tBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713204420; x=1713809220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkvNj0SDmFhhMkw0sRd1k/aPAqSYVAFYS0V+mjg1+Ys=;
        b=fuqcH+Fo/rGTChjz+jQCzUNGVZD2vuc58cjs2lS4F7meWw1FD03wIR+7EpNeoPy/w3
         hVnxCGh7A/0jz9p6V7iq5mY7D01a3a8wFhdHn10EzyCoehxAQYr+uP0CaeZ/O2RvWKIL
         15qPvEfNkd1i4EhTpXBF/lzsFSsSDiGYNQmFDvQX6P0SdGK6ni7zsqsFYdWh9zkb02Rf
         o3OksvYW7O0Qva3JtCboBD6gKEfP9/GVg9CKXtXNbztdGn0Jdwg91pDo+rwO0JJAa5OM
         xcLnNm0qJqYEom0lET9CIo24CdVB5ZPq05FtZ3HOtyUvnNa2LTLoj0GQcrlXis+drxgV
         OGUA==
X-Forwarded-Encrypted: i=1; AJvYcCXvJbEBgSH3Dq1CeHXLfQ+/mblkAD2Obe2PEjRTuaSiKTJmgnk7T1JEKVK9HwDTRp2PqTIB2/b0+v2CFJVcKERm7Ot8hX+2ujtlk3WqMcEj
X-Gm-Message-State: AOJu0Yxh4H1+im8f8stDQlpl1aEkKD+Y84tkO98+47JLNXGE0p7hZzJ3
	n3dwxnEEqMlVx7j5pqdGhv7+tfefuW1Ye3oH0LxKfsxTmT3S+iU2o8sWYqrliQ==
X-Google-Smtp-Source: AGHT+IEoSmiqVWll+WGGtai5I1QgX+KNmvNJiMmUzgaHJwAdK89iBoCnt3jFLPWk0W0gCtqyQ9HIoQ==
X-Received: by 2002:a17:902:a3c5:b0:1e2:bd7d:5609 with SMTP id q5-20020a170902a3c500b001e2bd7d5609mr11793136plb.20.1713204419874;
        Mon, 15 Apr 2024 11:06:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001e509d4d6ddsm8398013plk.1.2024.04.15.11.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:06:59 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:06:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Joe Perches <joe@perches.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v4] checkpatch: add check for snprintf to scnprintf
Message-ID: <202404151105.54B9DEABE8@keescook>
References: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
 <48d593c1-c706-4af3-aacf-d1329a8b0d4b@wanadoo.fr>
 <1a4554d39229c790c98bebb213bc9f2423cd32de.camel@perches.com>
 <CAFhGd8rUz_wG+jkW=+17RpG2BQxaRMmZVk=g=G1FogMSeAD7jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8rUz_wG+jkW=+17RpG2BQxaRMmZVk=g=G1FogMSeAD7jA@mail.gmail.com>

On Thu, Apr 11, 2024 at 03:10:57PM -0700, Justin Stitt wrote:
> On Thu, Apr 11, 2024 at 1:56 PM Joe Perches <joe@perches.com> wrote:
> > It could.
> >
> > # {v}snprintf uses that should likely be {v}scnprintf
> >                 if ($line =~ /\b((v?)snprintf)\s*\(/) {
> >                         WARN("SNPRINTF",
> >                              "Prefer ${2}scnprintf over $1 - see: https://github.com/KSPP/linux/issues/105\n" . $herecurr);
> >                 }
> >
> >
> >
> > Though I also think it's better to use lore rather than github
> 
> I am fine with making the UX change in v5 regarding using ${2} and $1
> but I wish someone could have said something about the Github links
> earlier, we already have a pattern going with these string api
> changes:
> 
>      "Prefer strscpy over strcpy - see:
> https://github.com/KSPP/linux/issues/88\n" . $herecurr);
> }

KSPP isn't going anywhere -- we've used these links before and we can
use them here too. I don't see any good reason to duplicate stuff into
lore, etc.

-- 
Kees Cook
