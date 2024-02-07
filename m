Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F020DC1
	for <linux-hardening@vger.kernel.org>; Wed,  7 Feb 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297533; cv=none; b=sHFcmozixN46qImdg1ZNuwT8lD7VUF/oiruQS2Hmbx7vjnPINrz3AMsQ8YETlJhQuE1R5NBSLuMqwEqmGPOSb0ezj/y743WPNa01C4lCY5i1ADzT3x5akin4+eay2OiBX7wk7Qyu9MUPuRBa83socGdjwkjaFkFQOcR9zmVSSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297533; c=relaxed/simple;
	bh=1jfkXzEU42XrNlTOrYgVxpel0/h+5EUT5MRCBrv1Wg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCgkpcTloVje7cOfumWqbLAGANhWpSGR7BYvHCC0HvFWw8yLgdv1oKLbv1WgSnPqgg2HrF//cX6kubn2vgBQACegEWfgnRedzkCvCTbw5TqUb9NTDZNgdE+m3sWIep3LReVIDEwFM8pcIiE/p0Xx7KtXItlXr+FuAAt69QTIP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hnmakqU+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hnmakqU+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d731314e67so2964725ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 07 Feb 2024 01:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707297531; x=1707902331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvvwDnpbjNBn+9NOt2kovthLIHMOsqPt4VSpCq5q/E8=;
        b=hnmakqU+26C6QwLJ7B2JkS7tm5s2QTRJfGk1/u1AKMqeEU+mrJ7DVII+9NCs3eNLfx
         fGo8qUikwF8I0XfYXj/LnwO5PjbOwG8wrAy5+54E9NuJ73pBhNxArbBPPna8a748SmdM
         BvFc3JGy93ACt5BSQd5dp94Xw5n6elTafzG8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297531; x=1707902331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvvwDnpbjNBn+9NOt2kovthLIHMOsqPt4VSpCq5q/E8=;
        b=bmFQfyiHcp2xosSCEwjUdJEbLSwTl3p2daHKppem1KaDwl5hxyn2ZaV42E0BF7KaE9
         QYL0BhbpTZVR11TiDmTJJblaEnEgCBY6POsQ6CbIxJQ22laVMeX1znyIv0zOMrbej3t+
         yh7UtTYRgTvLGW9MpMSGS9d7WmdPYpgg45sEY77DyHMBWMUXZU83cWag4fmI9u2nfA+V
         AgvIIY1EtqDMCk3mkAxCQA8E1Df/enfJeiyU0S72NLLPgFZS9QMryLlTnVnGeL9ea14H
         WYRKxJwZ4erRlUkba6ZXT4W7qLAGgdQqYcS0TxfBWpI7Z9h6LEu1pEcXw7621kGMfdfw
         jTKA==
X-Gm-Message-State: AOJu0YwHdjW7o1PeEfWeJNS0bHC7q9JPSfa3GaLAjNMXYI24+sR/6VWJ
	nw8ZMHM7XzgZSI2k3+gJmn0NJqW5Nc6Bi7FG7yhRVz5Ku8NscPTqbzUa1U4yaQ==
X-Google-Smtp-Source: AGHT+IEFQALsTSc/iApggEuMndGposLY0LsIv3nQL6+uN09l4rY630QyTpJ4hUME2/Vgo02gZWcpOQ==
X-Received: by 2002:a17:903:987:b0:1d9:2369:d0f8 with SMTP id mb7-20020a170903098700b001d92369d0f8mr4423261plb.9.1707297531344;
        Wed, 07 Feb 2024 01:18:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/ljlKv0gnPptnrgqIOdlLMqVbp7UOFuc0CZtBwpmV0aWypPzVcmXrY3WBHqm4Mbgx1//7mxmWJbFePvmMV/FTz9PAzADgmUMWZQ34w2gzb4jtCtkpNV8kl3qGM37sfq883PJL/ytuxw0IsOhFZVhK4IfN1Y/WRnzeenWktf/CAT0lT0I+jfJEtbWZLxpeIN3u+7Kl8PA0/8QDWMMXUniGiCzYC0fbR4lklo1idbnRDUFcqeskrWWlSD4upPNso+SSC8RA6GniQ5DFaOue32MDKW9Tx45fEUFMlVdge9S0823TrVJ7FLJd61HJW84kuvsIPkdklHic03dqBZDSGFl7BqsqXaCsee2VsBzedyaeZ4hlLiIXHlRDwIleVMoZZQRDkKCdiuHm6aHAtpLikEKbpAJfp06iWzzwJFTroo5+yj3GozHdax5Z
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ld12-20020a170902facc00b001d7233dc459sm952236plb.76.2024.02.07.01.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:18:50 -0800 (PST)
Date: Wed, 7 Feb 2024 01:18:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v3 3/4] string: Allow 2-argument strscpy_pad()
Message-ID: <202402070115.2C86687F@keescook>
References: <20240206142027.make.107-kees@kernel.org>
 <20240206142221.2208763-3-keescook@chromium.org>
 <20240207005151.lyrtgqd4wekolwe7@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207005151.lyrtgqd4wekolwe7@google.com>

On Wed, Feb 07, 2024 at 12:51:51AM +0000, Justin Stitt wrote:
> Hi,
> 
> On Tue, Feb 06, 2024 at 06:22:18AM -0800, Kees Cook wrote:
> > Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
> > optional when the destination is a compile-time known size array.
> 
> This patch is diff'd against Patch 1/4 in this series, right? I wonder
> why you split them up. If I hadn't literally just read that patch I
> would be mildly confused.
> 
> I suppose one reason may be that 1/4 is a standalone change with a high
> percentage chance of landing whilst this overloading magic may not land
> as easily?

I viewed it as a distinct logical change. I could certainly combine
them, but I think it's easier to review the conversion from function to
macro without needing to consider anything else. No behavioral changes
are expected, etc.

But if they were together, there's a little more cognitive load to keep
the func/macro conversion in mind while looking at the optional arg
magic, etc.

I don't think it's a strict rule or anything; it just felt like the
right thing to do to split them up.

> At any rate,
> Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks!

-Kees

-- 
Kees Cook
