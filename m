Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0AB48CCC
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046997; cv=none; b=u3xYoJ7ExohvLc2Oj7IhS7+RPx7UbP8bGLGxlb4oAKqA/2kauRjh/SwoTawh77oaQY+xLVQYA5S2mtOaq7l/xqYisnWkerYvvMfpp1cM7VGUfcHDBie8SYUlMcjvOHw+5DJumO9PBzdCqwbFY4ZCyQtl3QJVqRQP1XAE/wAh/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046997; c=relaxed/simple;
	bh=0c0F7eeZoGxLjeqmmKMm57vl0kvVl9qLdYbdVXMjG/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcrVD/eeKfpz3H7KYrV3yqO9U2E1iy1lHUgbcJdll3/mRdFRii4lvZ5IRrU3iidGRdVTzF2Af7C4kWpxGZVABgDjAERrpCKBCOPb0mGk5Ufl4P93GTA1U+jAVc/m7Pcgg4QCqpRtMkWVFDuqI8eQddTl6BpsvceWiHGPj9rtpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dnUsN6DK; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dnUsN6DK"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59969ec581aso1992573eaf.0
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 13:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706046995; x=1706651795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9lSja7LT9ZtyMjrI1OsUow8Sb3Qq23rG9UTWBb1Ccs=;
        b=dnUsN6DKQh+VpiCCuR37lloHK4N+7R+RrkbATSNTwzOVUoquPjBXkYO4b4/1E0a/Bb
         Lvj+F1d9YgEK79pu6YXtXvLijPzWslhB4cKK7R7DeP9LnP5vcULVDKtKiTfqRxJL0Ewb
         es1itWf9x4GhHLJsHK04rMahYijelxnFy4qZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046995; x=1706651795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9lSja7LT9ZtyMjrI1OsUow8Sb3Qq23rG9UTWBb1Ccs=;
        b=RNVL5R7YLCcTZdah5AbJphjq5qZmDuv8/psSSy/Ovp892hT9ol5T327I9OlaC9qO8M
         s5Pr/wqgIw8LHFcjQ1LgIv5jcmJI28SAJe0xZpbDugT31+oVn6FvUPnWnw8RXDeuzww8
         uucwlhhNBUqJ7nPlLjWVfbZeGzEyC0jFVaQxqbjQSROiaYAWEWuq0EXoL8FU5sWhhsuo
         YREB7ieBI7OiZgj5YB7LE9boDh4SJirT/7Nq7XbYZRa11n+W/p+faOI/7vg4yavYiWvi
         3qcx3NuCebAf1Zgg4FufQkYMQACALqye9o7ygYWrN8cf3pqUze3lZGR13WRLHv+K3mwp
         tc4g==
X-Gm-Message-State: AOJu0Yw+v/ig1A4kw1NJAK5S39f+H7qj9pW1Uf68y0EDg+v3m3TPIy70
	DPSfB6YdOyc+uYqbFQiA6vM89KAtJEpEZMedrXQph6qvOSfgSPSAFl6MoZAkjA==
X-Google-Smtp-Source: AGHT+IHrC0JsOHXDSkWplzZP5dJON/Iq8CLEVyg/OoprJ47UgtWcaFQU2EZfDJcGRYxMPUlvC77W1Q==
X-Received: by 2002:a05:6359:4598:b0:176:860c:cc5a with SMTP id no24-20020a056359459800b00176860ccc5amr588759rwb.5.1706046995347;
        Tue, 23 Jan 2024 13:56:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y14-20020a62f24e000000b006dd85222cc3sm683579pfl.134.2024.01.23.13.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:56:35 -0800 (PST)
Date: Tue, 23 Jan 2024 13:56:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/82] overflow: Refactor open-coded arithmetic
 wrap-around
Message-ID: <202401231355.A94FADCAE@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <Za-K-3aSBULf4NWE@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-K-3aSBULf4NWE@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:46:35AM +0000, Mark Rutland wrote:
> With that in mind, I note that this patch primarily modifies addition
> operations, but leaves subtraction operations unchanged (even though those
> permit the value to go below the minimum, or above the maximum if a negative
> value is used as the subtrahend).

Right, this was kind of a "first pass" on what I'd found so far.

> Shouldn't we address both at the same time? I'll note that in many places the
> same logic is used for both the add and sub, and can legitimately overflow or
> underflow; I hope that whatever we use to suppress overflow warnings also
> ignores underflow.
> 
> [...]
> 
> Looking at the diffstat, I think you've missed a few places:
> 
> [...]
> 
> This misses the include/asm-generic/{atomic,atomic64}.h implementations.
> 
> This also misses the include/linux/atomic/atomic-arch-fallback.h
> implementations. Those are generated from the scripts/atomic/fallbacks/*
> templates, and you'll need to adjust at least fetch_add_unless and
> inc_unless_negative. As noted on other patches, my preference is to use
> add_wrap() in those.
> [...]
> This misses lib/atomic64.c.

Thanks! I'll take a closer look at places we can use the helpers on the
atomics.

-Kees

-- 
Kees Cook
