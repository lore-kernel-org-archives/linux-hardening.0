Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C31102
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709184611; cv=none; b=iVOwQF+9ewidyzRXjDINE9uEUTFehPTZItULBVuV2rSwW9XkvMZcdzVYm01NNps07o2/pgUjiCkR7GAa9lMszNQ2s0ax1t00eSgXSd4fvgfw30v87D8w5PbzitzrirKjGAJ0rXF70xHTXe6v3P3JcMa3UMVQQrSusdjw8kpOxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709184611; c=relaxed/simple;
	bh=YhjLc7kg+mjDhNCTVdtDb9a9jac05G1YNQyXQBE9s2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLBx2bF+QfpV/P0ofaOlkUg4v7NwtjJmKH76wSVGSYzj2y27/gqqdr1dMUTG+zIkzcnwFolGSPgYEyKTaF6u+h43Ad9pIJC/h03Kd8o098zmpCBIA/yewyP+B5JTcUmf3x1x/O9QJr4NWuLUXsUSvlH6AdQXswhkG9V22fHHYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bPq81Mbw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bPq81Mbw"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dca160163dso5643105ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 21:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709184609; x=1709789409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrxKyNWlmvL9yXlSieNBBpwrlrp5vuGIWUfJ9r+fVlo=;
        b=bPq81MbwQ1pdDPtMwyxXkCLI3rcq+BYeLUu9VG12jpX9yFAcit3B815+d1jbc3qYvU
         tY8Dfmiu+qWRZc/7cIQeFZThfw26y43cbVT/b9XP8Y7O1NPHGpJDq9ck7uZfll30aiVh
         1DPD3Ifc817At/kfgTfLtylGnY3gdqeKmiW4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709184609; x=1709789409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrxKyNWlmvL9yXlSieNBBpwrlrp5vuGIWUfJ9r+fVlo=;
        b=h3/ZJMTFVSplQVP4MYH07K1Pha6cQvph3zopydvFeQvUdZFCsMahT8AkBg2HqFz5ck
         iFtcwhXoYMnijcBRhi1YnNlNFHqnUhuOVopocugWIJyUmnX/MyG8kFQ3LDihShXZ9xwj
         Q5M5oAZx4BKKfLCKkSlroao7V4M2XC0MIjS8dOku6+bCNvwq/PvvZRI3NcNUaIl0SKXR
         2nNggj705sbuyCBuAfZYg0G6Ky/oQ3h676Lgu+3zgeNJG6G0HmeYQbhk/sbh6ddH8l5U
         gBXe0j7YqroOsr8ExMo7AC+/fQMRUQ7Ra8wCCYxu9Zm3KmnCq65kIyXFCQduUCBL+JSq
         VZpg==
X-Forwarded-Encrypted: i=1; AJvYcCUzlqZTK8b8Gw8zEAJ0T7molfNzZxxV6rxSDDI6YHipoMtDPLN1nauDezQBuZoAMoe+ric2z4Iab9vShe12zoQh5vvAdtFu76JQ80BWp9Au
X-Gm-Message-State: AOJu0Yzi11J24/yD+KY54as/enHhsPzH+B8GrkGMKvD2L/Bs1q2GjXLL
	3Erhui5CAC3yIiDrO87tBCnQ08dvqKXwDRLKOOor0OhePEFLiVP72DWOxGWVUA==
X-Google-Smtp-Source: AGHT+IFqSMdFat3TYqmlr5Vmh4bfjdbaQ3YVGl+s7Oeb1J1jNvTj1IAcgXzTFW3SrDSZv8CYuRtmAA==
X-Received: by 2002:a17:902:ec81:b0:1da:1e60:f9fe with SMTP id x1-20020a170902ec8100b001da1e60f9femr1021801plg.54.1709184609168;
        Wed, 28 Feb 2024 21:30:09 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001dc38eaa7fdsm406258pli.278.2024.02.28.21.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 21:30:07 -0800 (PST)
Date: Wed, 28 Feb 2024 21:30:06 -0800
From: Kees Cook <keescook@chromium.org>
To: Tobin Harding <me@tobin.cc>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	Greg KH <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leaking_addresses: Provide mechanism to scan binary files
Message-ID: <202402282048.0CA1A50@keescook>
References: <20240218173809.work.286-kees@kernel.org>
 <ZddnEtnxhJsafdcF@tycho.pizza>
 <202402221249.FA17A8940@keescook>
 <Zdfdhl78xgBuZdXu@tycho.pizza>
 <ZeAKrU9IfcNpIURB@alke>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeAKrU9IfcNpIURB@alke>

On Thu, Feb 29, 2024 at 03:40:13PM +1100, Tobin Harding wrote:
> On Thu, Feb 22, 2024 at 04:49:26PM -0700, Tycho Andersen wrote:
> > On Thu, Feb 22, 2024 at 01:00:40PM -0800, Kees Cook wrote:
> > > > This does bring up some interesting questions. From off-list
> > > > discussions with Tobin, I believe he is not particularly interested in
> > > > maintaining this script any more. I was never set up to do the PRs
> > > > myself, I agreed to be a reviewer to help Tobin out. I'm happy to
> > > > adopt it if that makes sense, but I'm curious about the future of the
> > > > script:
> > > > 
> > > > 1. is it useful? (seems like yes if you're adding features)
> > > 
> > > Yes, LKP runs it as part of 0-day, and it's found leaks in the past[1].
> > > (Though its usage could be improved.)
> > 
> > Oh! That is good news :)
> > 
> > > > 2. does it make sense to live here as a separate thing? should we
> > > >    perhaps run it as part of kselftests or similar? I think that e.g.
> > > >    681ff0181bbf ("x86/mm/init/32: Stop printing the virtual memory
> > > >    layout") was not discovered with this script, but maybe if we put it
> > > >    inline with some other stuff people regularly run more of these would
> > > >    fall out? Maybe it makes sense to live somewhere else entirely
> > > >    (syzkaller)? I can probably set up some x86/arm64 infra to run it
> > > >    regularly, but that won't catch other less popular arches.
> > > 
> > > We could certainly do that. It would need some work to clean it up,
> > > though -- it seems like it wasn't designed to run as root (which is how
> > > LKP runs it, and likely how at least some CIs would run it).
> > > 
> > > > 3. perl. I'm mostly not a perl programmer, but would be happy to
> > > >    rewrite it in python pending the outcome of discussion above.
> > > 
> > > I am not a Perl fan either. It does work as-is, though. Address leaks,
> > > while worth fixing, are relatively low priority over all, so I wouldn't
> > > prioritize a rewrite very highly.
> > 
> > Yep, fair enough.
> 
> Thanks for taking this in through your tree Kees! And Tycho for
> picking up the pieces I dropped :)

Hi! You're welcome; I'm glad I have this script to build on!

> I can help review a re-write if it helps though I don't write Python
> daily and I am long way away from kernel work these days so I doubt
> I'd be all that much help.

No worries. I suppose we could rewrite it in Rust! :)

> I originally wrote it in Perl because I figured it would be easier to
> get past the old guys, six moths later I regretted the decision when I
> tried to re-read it.
> 
> Thanks for ping'ing me.

Good to hear from you!

Take care,

-Kees

-- 
Kees Cook
