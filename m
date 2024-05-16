Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FF157480
	for <linux-hardening@vger.kernel.org>; Thu, 16 May 2024 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715890032; cv=none; b=BKYhiW2cJRn1PQTdcZfFtDcYs3lg0hbF+JMB5mMGUt9PhKDAD/4sMQgn1r+sUi84+lPo2PHmUIxBBrru0cGtFt70nr30UoKAJKKexu3CMPXyGlPgMlZ+QTidZKJ5duFRfvS1ZLXvYymLTPaXeByi2xX1yF7U6p2xxMaJhdd9pc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715890032; c=relaxed/simple;
	bh=PHM05l3dg41vpIlXCvO5miEj3ChNSyOJ7ppgPBZeDaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1+GzClGNtz2bmMcV94vGyi+HnGBe6LDhezOGHWACz/FDgIpSu1aV7trZNHH3rdzTccXGDvfO0gHQUqv0KV3f2cUZvYknUH+vG0aa0pCfElynhorhejZpLqi8ETHaGHUn/Xm6ekRB78gKn5jW/5qnodmE0JP7t/JTerYyhVvVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CQYkJvzj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CQYkJvzj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec92e355bfso81144905ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 16 May 2024 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715890030; x=1716494830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KyG12zQ6p7/BXdJX9MxBxAQEGuyOmeFERaocoWUX2nM=;
        b=CQYkJvzj284k/xT2T2CDg/po6QZTl01lbXDUhG3930Xfk0raFbhdPd1lTF1JuFav8s
         ut/kJUneDemDBBi5q0V0ujIF+kn0tox6JYiVX6YHLpYiXNawZs73oclNmPqakFDghXyB
         QWAvLJmx6pTkQgaTRpv6EDvYmPZHsszSIO07o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715890030; x=1716494830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyG12zQ6p7/BXdJX9MxBxAQEGuyOmeFERaocoWUX2nM=;
        b=hUWsJee1vSD1CUAyivVVJgV5D9qDIFLC2gH1mbrK5enU7uR4JqP5EgFpsYGP8mIxAr
         JZwv2u30pfAOaK5RMJqDj0tPYmLqzTNLJ7ggDB6wI8hQh99JrSRvZB92AnocYpyWu31U
         Re2oVFvUSqAcD5bEN5bh7Fiyis9UW68QUvATUI0dvPQNPviLqqvkEG5dPrNY4ITFlo3A
         uYMpQizN4Ty2kmmndpYiD7vdZu99vc1YxBMTIM/VTSjqH8/XCfe/pnGhA01C+bTzlV3g
         Te253b32ePm+G79K2clYMSCTtVIsmc9diZvIIrINulKYGpwkRXvVyVkL+D+bL+/FPkY5
         iqMw==
X-Forwarded-Encrypted: i=1; AJvYcCW3VO3tRj+5ABeatrdrkdH1APGC51oBcWmxchffVnyLij3wbdOTDjSfUZTsEKLv1W4bU04ALTnVfJBR2c1pfp/ksP3Cfjo+y/7yahxfzC3i
X-Gm-Message-State: AOJu0YyvbapilQnCv6UBodFHxeYGagMf7Pg4HUkQU0z4aISKCoR/ip+6
	drOwhvMpoo82bsXZyaskXGwJtYij61v8V5jac7W3YmSYk55Ekdr3Maw7b/Q9OA==
X-Google-Smtp-Source: AGHT+IGTRclh1CigI5i708kRIjv4JGvkOMw+J0DApcHCOCHAenoDy7R8CP0aQXtDPKQhtOx2gDwoFg==
X-Received: by 2002:a17:902:8542:b0:1e2:be4b:dd9f with SMTP id d9443c01a7336-1ef43d29670mr181010385ad.15.1715890030540;
        Thu, 16 May 2024 13:07:10 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f096da40a4sm29452455ad.66.2024.05.16.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 13:07:09 -0700 (PDT)
Date: Thu, 16 May 2024 13:07:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202405161254.D4F33F7@keescook>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net>
 <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
 <20240516140951.GK22557@noisy.programming.kicks-ass.net>
 <CAFhGd8qCCCrccQ2z5bjBD5YcMWHkym9aVz_qYkyyj662XEeHvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8qCCCrccQ2z5bjBD5YcMWHkym9aVz_qYkyyj662XEeHvA@mail.gmail.com>

On Thu, May 16, 2024 at 12:48:47PM -0700, Justin Stitt wrote:
> I don't think we're capable of identifying every single problematic
> overflow/wraparound case in the kernel, this is pretty obvious
> considering we've had decades to do so. Instead, it seems much more
> feasible that we annotate (very, very minimally so as not to disrupt
> code readability and style) the spots where we _know_ overflow should
> happen.

For the baby steps Linus wants, we can walk this path:

- Finish the *signed* integer overflow refactoring/annotation.
  This is nearly done already, and every case we've found is either
  a legitimate bug (thankfully rare), or happens in code that is
  either accidentally correct (thanks to no UB), or the correctness is
  very unclear. Refactoring these cases improves readability for
  everyone and doesn't change the behavior.

- Begin *signed* integer implicit truncation refactoring/annotation.
  As Linus suggested, dealing with this will catch a bunch of the flaws
  we've seen recently. Handling the false positives here will need some
  investigation and some compiler support, and that'll happen in
  parallel.

- Tackle *unsigned* integer overflow on a per-type basis: we can start
  with the place Linus called out: size_t. This will let us focus on the
  first of the unsigned types that is not commonly wrapping, and is a
  regular place that unexpected overflow gets the kernel into big
  trouble.

What we learn from these three steps should inform us what further steps
down this path can look like.

-Kees

-- 
Kees Cook
