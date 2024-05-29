Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079BD52E
	for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003125; cv=none; b=naEO92jYd2ikC0UFj7oceaZ2ltzKTB2rgiRxEFj1ONAQfxlflNv28v8XVHiJU7ij3lHRzUv31kcvhd2idF89u72sWB5mghPo25pBiVNYqh2XsGDE64Rf7eZ4pyWouzd6xkBSkIUNNUipLBl1FdIu7+LZ0D6m03vgC0OqJKtQeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003125; c=relaxed/simple;
	bh=yueErXx0vBJs5GE6t3f4vzCLsn9G7Wtx0UkvDhnlcvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftn9lFBHAhatPeDpj4yJ7WMKzsVt7aCF+o2KEVT7MPiCfd8tqmTq/TrQ/+nIHSERRWsoeCG4L1/OtzMnATbXRJULwOGY6UjNtikt4Cd2vCwlzTWexM8R0kiqBfhPz0Bz+JjmyWEzTEbFywPh3QMQqiN2kAKCHbfTcRStgAZM3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FzpnipP9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FzpnipP9"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6fbbd937719so1785790b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717003123; x=1717607923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrpFYI9w3VuKjWbWQGILtT92BwGDz8bAIbO4y10qN9g=;
        b=FzpnipP9FGTVMDH7YZQU9A5PevMzOGyxPxOQHFtd9lRfSNm0VUOPHdE1wDqhZmrQnA
         cQkgYwJzGpXHKAntGYiBtHmGnEbDKZ1PYR66aonz1yaQqFj7UkIp5kswDOI/mZ3mjmN2
         WcYV3QhMrZH/owpyj8TtKuTzfPjEmcTNwySJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717003123; x=1717607923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrpFYI9w3VuKjWbWQGILtT92BwGDz8bAIbO4y10qN9g=;
        b=AooR5KEnKfwewhT4AINt3Ul8cURUEgJx1DUh3Rvw5nC1WzCtLnnBk/SJ+rbZhuQm1z
         1Jqi5l7ACUUWRc5WKFMjNNJ7WRR0KqEn4XdSsQOO5shAcaGQbrNfr8VP9BwJF6BY4GQg
         z9PfMQ1xJY8SFx7A83XtxuXW3cJZoWMYbo87PzWqn6c0wLVWKEarK5hVL4sHb8LK74xH
         INMWY/hfA52DL6hHZt2Ahf6OsqutPn4dsVNk+QI0GkGuU2t2aBYYRhvKx4wK5TMcn4FA
         O0bxoelidfH3fiqLQxwtOtrO/z85GVViylYUsqofs5Mt0INV1NVtkKVuuG6Lgb7qRw56
         nSxg==
X-Gm-Message-State: AOJu0YxbOlUj4i8h634pKpTq+Kqs/Hugac1ImF+0sdfgJYFxFCPvPQc2
	rwPQIb+2zdMWa/13ODHFGuftsG+/LgaucA+jdOatiU2UR6R6SXrMEQWOspI2A6y6ntYnlUlhu0A
	=
X-Google-Smtp-Source: AGHT+IG1rpbbKmfTqVpy1OBuEAV41soytZXzb095XpaW1yfXvn2L1zQyhlVhCw35hyefCjHqwVSojg==
X-Received: by 2002:a05:6a21:999c:b0:1b2:5437:e04c with SMTP id adf61e73a8af0-1b25437e495mr4707959637.62.1717003123314;
        Wed, 29 May 2024 10:18:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7022b6a6cecsm491980b3a.142.2024.05.29.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 10:18:42 -0700 (PDT)
Date: Wed, 29 May 2024 10:18:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-hardening@vger.kernel.org
Subject: Re: __fortify_panic() question
Message-ID: <202405291018.F0B37DC6B@keescook>
References: <79653cc7-6e59-4657-9c0a-76f49f49d019@quicinc.com>
 <202405290950.7E61121D80@keescook>
 <1c79d692-bd2c-4125-8a47-7593b3229379@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c79d692-bd2c-4125-8a47-7593b3229379@quicinc.com>

On Wed, May 29, 2024 at 10:09:45AM -0700, Jeff Johnson wrote:
> On 5/29/2024 9:55 AM, Kees Cook wrote:
> > On Wed, May 29, 2024 at 07:36:25AM -0700, Jeff Johnson wrote:
> >> 'make W=1 C=1' on x86 gives the warning:
> >> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?
> > 
> > Hm, I can't reproduce this currently (but yes, it looks like arm vs x86
> > is mismatched). What tree is this?
> 
> e0cce98fe279 (linus/master, linux-master) Merge tag 'tpmdd-next-6.10-rc2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
> 
> > 
> >> Looking at this I see for ARM there is a prototype for __fortify_panic() in
> >> arch/arm/boot/compressed/misc.h
> >> And there is a matching implementation in arch/arm/boot/compressed/misc.c
> >>
> >> But for x86 there is only the implementation in
> >> arch/x86/boot/compressed/misc.c
> >> There is not a prototype in arch/x86/boot/compressed/misc.h.
> >>
> >> The easy fix for this would be to add a prototype to
> >> arch/x86/boot/compressed/misc.h.
> > 
> > Yeah, I think this is the right solution.
> 
> You want to do this, or should I?

Please feel free! I'd appreciate it. :)

-- 
Kees Cook
