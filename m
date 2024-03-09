Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DFE1BF53
	for <linux-hardening@vger.kernel.org>; Sat,  9 Mar 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710016368; cv=none; b=TRlOIk0tbIjKPOEyZu29qUf5f6oo9M4K0OUTvA60Ol/8wNMe+PTnZ/7Ks6pZQpX5YCaly/yjQVotP6RNgXfumJH2UCEwY/TvxZ7Gr9ZJt9SBKNKtcQ8YJOge4vuo53NzGEQh5jxGl8IZPa3/E85bEEinNduCfXnraBUiPH0nn58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710016368; c=relaxed/simple;
	bh=Rjri3ieAXjiF3QC4d8XL08f7tFXcsnCGE3JiXZ7x5Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTvXo1jeUhr92McaqIx0CI0RF2z1bKMXSm7eg1YQ89zQsg81DSfvE/vh/fQ3c/eKtslcO5/7fG2WV9cVrGI2u8xV+bT9hGR7f7XFOqQjSt/SpQOZoZOaBIyFRTk8sbN16ZkwLIVdNdCeW9CqF7T1ZZ6j0I1ZIhNmrv4ks0ZjWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=COoPRRPA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="COoPRRPA"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29996cc6382so2293506a91.3
        for <linux-hardening@vger.kernel.org>; Sat, 09 Mar 2024 12:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710016366; x=1710621166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OTMXNhmX4O6lceZQYHXvvgYFS14rznJ5JJ4O2NR9B8=;
        b=COoPRRPAFdy+cz1+6KCb8xTwFCugnIQPeG2yF77/JikCm4CvPPWgheFLlPohShXh6v
         ofogxqN0z1g4fgZhKjhElx5gnXba/OzYK5hTRcIGLEGzP61NNZzIk8czMXvrLTSpra2I
         R8gnSqmP1w3hQCMkDvD0aZB9Vf4nb1zgHUSj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710016366; x=1710621166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OTMXNhmX4O6lceZQYHXvvgYFS14rznJ5JJ4O2NR9B8=;
        b=kDZwL8xv0rtgPxl7TkC9jwPg338M6pALrJwbpN+wOmPjZJb4HHJQTEySMUWkM6F6G9
         vCTPmGqD0IGZbudYoVfxvqdamZhAdKU3oyPuTq1kMBWK+IkJaRQxDwoTojp6aXyVq27r
         7QSfYeb/D5xW7+64Cxz8NitFwxZQ8WFHgkdTlzH6YQnT9oQndvcvWvhzsEIPWOwnOvHY
         WrHkSunJPxp9KdMcFOr4bTVKLrfd9Dzr+yxzFb5tYombvCHS03VWspy5YGVf4iHEnLPA
         bitqALTuONyxkAN9hXLrhB73S1k5dg0+NQ3gh1YOFUe0asj9Cc9O3Qjg+MTTqdE7V3Nr
         Oxgw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+hcaDJtXQgX5Ttd7NidoVKioT7qyycWieDuYsyNzct+fLxdLQ5PRHVy0Xu99ZaF4m22CgSQ7pOH2G0YOrQMwLWEuAgMfg5AlKu0qQLRK
X-Gm-Message-State: AOJu0YxrwTH+2OCUQj4pJ6oGK44QYeOdBOXS360CPZDHTUYa80MI8rMB
	PnrFC+zO0HwdISXEXsEhn58I9icIuMXOPCmKFs7he3mnLWCCLGpkVgRhibKJnQ==
X-Google-Smtp-Source: AGHT+IGQkvj/tf7BRo0+9QPNS1Oh6nikqb9cyPmTEPrdArJNXrYufFGDu4ArsCBeCVR+xUAj9syNog==
X-Received: by 2002:a17:90a:1347:b0:29b:7fe8:be84 with SMTP id y7-20020a17090a134700b0029b7fe8be84mr1876129pjf.41.1710016366573;
        Sat, 09 Mar 2024 12:32:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a34cc00b0029a8a599584sm1797656pjf.13.2024.03.09.12.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 12:32:46 -0800 (PST)
Date: Sat, 9 Mar 2024 12:32:45 -0800
From: Kees Cook <keescook@chromium.org>
To: Simon Horman <horms@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Change DEFINE_FLEX to take __counted_by
 member
Message-ID: <202403091230.ACF639521@keescook>
References: <20240306235128.it.933-kees@kernel.org>
 <20240308202018.GC603911@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308202018.GC603911@kernel.org>

On Fri, Mar 08, 2024 at 08:20:18PM +0000, Simon Horman wrote:
> On Wed, Mar 06, 2024 at 03:51:36PM -0800, Kees Cook wrote:
> > The norm should be flexible array structures with __counted_by
> > annotations, so DEFINE_FLEX() is updated to expect that. Rename
> > the non-annotated version to DEFINE_RAW_FLEX(), and update the
> > few existing users.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Hi Kees,
> 
> I'm unclear what this is based on, as it doesn't appear to apply
> cleanly to net-next or the dev-queue branch of the iwl-next tree.
> But I manually applied it to the latter and ran some checks.

It was based on v6.8-rc2, but it no longer applies cleanly to iwl-next:
https://lore.kernel.org/linux-next/20240307162958.02ec485c@canb.auug.org.au/

Is this something iwl-next can take for the v6.9 merge window? I can
send a rebased patch if that helps?

> > @@ -396,9 +396,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
> >   * @name: Name for a variable to define.
> >   * @member: Name of the array member.
> >   * @count: Number of elements in the array; must be compile-time const.
> > - * @initializer: initializer expression (could be empty for no init).
> > + * @initializer...: initializer expression (could be empty for no init).
> 
> Curiously kernel-doc --none seems happier without the line above changed.

I've fixed this up too:
https://lore.kernel.org/linux-next/202403071124.36DC2B617A@keescook/

-- 
Kees Cook
