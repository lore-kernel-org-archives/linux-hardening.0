Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17986AC5
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937670; cv=none; b=UW/2sDJzvQ3TRdVziP17qUgtC/IqmI19DACB3iONOQiUIM6gcbpdiQutroNJOVuNw75Vl3AWesMDpvNj/wetAMU7OTBJp9wVZW8tHGwUPP7AwnaJu4854AWi7E4wU4lwzOScMZA61WQT2sTTeimA030PJrTTI3mlnWKPTznzF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937670; c=relaxed/simple;
	bh=2SKYVcaHK9Pi50JJ9qkGcbOdbkWBf+DMZ9eNF7pBTr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozu+B6AUIYZxQjMQVxWBCdo7JOu1M5h6gvtpAfsI9l7CNJyfpCQhsB9DR5OR0JtJ4UVtUG+wlRBZORzrZ0iTJyvqqDGFEWZStbfkTJ5muJpHdHlIqWKy5DDxW8ZHrpQDTeMmljQsbrWDXY72DQiinK7R/lDwzBV8u1syNzCGZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NiWZvYUE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NiWZvYUE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1db559a5e1fso543275ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707937668; x=1708542468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/B1Y9HL3y5nrnbC6GpGjHmIUmKtamyRLKuJReGlvf54=;
        b=NiWZvYUE3z2L6qo6ulQkwYD05x/54OS9SxjLnPozFBxA9o/g3FjbcNx66k+VRU6TMa
         gLDF88+CuAJw3R65X6MmOPL5QqntUnG/toIpo3nCWvcuRx+rdu7yxER0/XqpZP5t8kzH
         UirZlfFd7ycebpNl/rgTMyMEKmPqVHB2pp0Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937668; x=1708542468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B1Y9HL3y5nrnbC6GpGjHmIUmKtamyRLKuJReGlvf54=;
        b=hMjUs+6uwx86H3zmNFNAHGyYummFEdAPZotpCMvbXewbovbE+J2YG39JwqrOtChea+
         EVJGa6jV5w+HxeC7XkefvddEWISMZRJo/oc1Aui2IuK4vrgyFuITeZfePBIV3BQdssOD
         /W9HK5c3QJWcEcApA2EHv36arQhO0TY8hnkIPHu3m88ueRFeL+oBUnhdA3xysrOjOhrs
         LJj8l6Hn9dnewDOSK3n2BviFJpdYuGvUYp+ShgTgGlxW3SrT3ODHIhM+3kRAOGUwdosK
         44imzOkjNH6YMAvyn6tf6JcDdGlPXFRPq/BLL5FKsioFc/ADvl3ekDMKBaXL26HOCpOR
         anMA==
X-Forwarded-Encrypted: i=1; AJvYcCX4M8+dZb+N555NB6HNDmfPESwCpQZuQdfSLJEAYpbEjJrfw7AiLLYq5LEHEjcFNMUA21YgWSZ5fKVMzeglhZPQpTPfPShLHiydJhmjZ0a7
X-Gm-Message-State: AOJu0YzKNqf9vtNBPAKoTJ2hZJaooPiLiaCdfHFTIZZSZRbLxvIYRTKA
	JtYk9qiX+vQXTYMV7M/4av7gMahaRcgyhc41dR5FLNUlCQ45IwPQ/wojLYK33w==
X-Google-Smtp-Source: AGHT+IE8J8rrcTmub8stcrpUL5qz49QRIuK5nOh7loZERo0Uce3M003Ihxxjk2PSMtmIQRZnRBEpmQ==
X-Received: by 2002:a17:903:2794:b0:1d9:196:4dae with SMTP id jw20-20020a170903279400b001d901964daemr3459122plb.8.1707937668559;
        Wed, 14 Feb 2024 11:07:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6XeoXCMYLkV1S+bV4hT7/ynDniMYLBxhic8VAh5dDN854Fd5Bb/AOhvwFcEU/nDqc1Qtk3Ky5WnzGk9t7Ru4P5VoUM16Mmp4IjL3yN6L2jl73okXLfSYUWzY9vW04sU0aX9AHWxSylbmPAg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001da108ddad1sm4013071pls.252.2024.02.14.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:07:48 -0800 (PST)
Date: Wed, 14 Feb 2024 11:07:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
Message-ID: <202402141104.642F85D@keescook>
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
 <Zc0BkKXZfIkwnvRs@smile.fi.intel.com>
 <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com>
 <87y1bm6gpu.fsf@intel.com>
 <Zc0LQ8YAWBwNptBF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc0LQ8YAWBwNptBF@smile.fi.intel.com>

On Wed, Feb 14, 2024 at 08:49:39PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 08:30:53PM +0200, Jani Nikula wrote:
> > On Wed, 14 Feb 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Feb 14, 2024 at 08:08:16PM +0200, Andy Shevchenko wrote:
> > >> On Wed, Feb 14, 2024 at 05:50:15PM +0100, Michal Wajdeczko wrote:
> > >> > Add str_plural() helper to replace existing open implementations
> > >> > used by many drivers and help improve future user facing messages.
> > >> 
> > >> Any user of this, please?
> > 
> > git grep "\"\" *: *\"s\""
> 
> You know what I meant.
> Second patch in the series that shows usefulness of the first patch.

Or a Coccinelle script that could do some rewrites? But, yes, if you can
include some examples, that would be nice. I think the helper is fine to
add.

> 
> ...
> 
> > >> > Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> > >> 
> > >> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >> > Cc: Jani Nikula <jani.nikula@intel.com>
> > >> 
> > >> Move these Cc to the after '---' line.
> > 
> > Why?
> 
> At bare minimum to reduce noise in the commit message.
> If going further, to be environment friendly (no jokes).

I learned the above-the-line CC habit from akpm. But in looking through
recent commit history, this does appear to be the exception now. I'll
need to adjust my own workflow for this too...

-- 
Kees Cook
