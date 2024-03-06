Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FD1CABA
	for <linux-hardening@vger.kernel.org>; Wed,  6 Mar 2024 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768572; cv=none; b=WJHP5pzj1tYg74LMwQFHswo6q0A3RLjA2t3jAdD1SFhBdpHiIpidPrGEiczwPPPanhAxawMgSxWgsnyXXD1lxju4G69mtX3QCgEBLrWMIcu/LiDkK0xQUA19gamfwGLgK30L0uXLFjMB74CrRmfLi8zLHQD/dDkH5NLv1VhcxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768572; c=relaxed/simple;
	bh=1uAjtmVUg8TOo5XCruda8HusbcghSINaRVyMFyYA2J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnNGUnp8xB4+b2SWME2jrU6V6otJ9+Hbc462zQpHPd6+TbhBySTmVuc4qszyVwPZssC8KyBJHNLjQQNsJu6M85C8u1fMSDDKCow/TLlLdCsGxtyasgnqiTN5J7dozZlZv2eBxVoDV8rpaFUynoHK+YXGwtPlp2DLpRh7UPj4Ukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FmSbYH6f; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FmSbYH6f"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dcad814986so2582495ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 06 Mar 2024 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709768570; x=1710373370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXRCoET8aNW/39aRLX1D1ZOWhLKJAW+cDfFuNbY9XEo=;
        b=FmSbYH6fycrBViC7DCGpYBQTBNKeiLm5BFgumllN9wfDs9gtX8DjA+H2k+7xsw3uZh
         dVDfu9e02ZMkLJebbKwQGddns31OuD4WcmFXqqLYzox4ntB6UaHyv9djld8SEyOQScJr
         /jvP+RRIS4GVngcdsgUr5JwcyrGtNEeWI8B9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768570; x=1710373370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXRCoET8aNW/39aRLX1D1ZOWhLKJAW+cDfFuNbY9XEo=;
        b=mLYCx3DunPZkHLEWKl940LomeMZmRuA90oHuQ/xy+oKYJoBcYYxKbMBDZ6MafTApyX
         N0gOQ7raqvKPKbSvtQno+0tPlVg1CTvXg9CJ1ZKsrn/NB8/Zx9/mcLbks5NbzBvX5Cff
         CDdQ47/tm1PMnEWHuy73IXobcTV25k8ZjdExgwhAkkAoVoQjxcNVGh9TsI5AFeT4smCD
         dlWqaemns/yMhZBzyBqhyWNvQKsQcJwstSFl9TDnpnyiVkrrvviRfrIvebzSEWvKS27q
         jjPXpFHg+cmKfIY/RcVNi/w5qV4LusJy5uDzpqgZgLBEzuwDyYD9L4lumDyhbRx9tGw8
         Xtcg==
X-Forwarded-Encrypted: i=1; AJvYcCVYXFxtL36WGbcCh4ULkeA2T68PIb7kf4iAVo9QTWXp1viV43yH4g5hVYvy+wGZlWA1beJDnnA7FWgOl+yUN/4dZls+6SPipiLQ+Hb8k60U
X-Gm-Message-State: AOJu0Yz7hSupbVgsUCSFI2kndIWjyNoBufE+Dv719LNRCiFw5UCLMo6D
	CKI2G2/k2q24HJ4Zd9WvvaxxJf+je6N/+EsT2bXtoe6C6//pjKvUiqz6Aassjg==
X-Google-Smtp-Source: AGHT+IHADupVs6FRdhDggj0sTct4wDHOWb2w2b9Auv5+VfZEeMw6HDOu57s1NGT+WKYASYmgqSVHgw==
X-Received: by 2002:a17:903:11c3:b0:1dc:d8de:5664 with SMTP id q3-20020a17090311c300b001dcd8de5664mr7564197plh.33.1709768570588;
        Wed, 06 Mar 2024 15:42:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b001dd0d090954sm7330904ple.269.2024.03.06.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:42:49 -0800 (PST)
Date: Wed, 6 Mar 2024 15:42:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Coco Li <lixiaoyan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Message-ID: <202403061540.A8462E9@keescook>
References: <20240229213018.work.556-kees@kernel.org>
 <20240229225910.79e224cf@kernel.org>
 <ZehsoPb/WZzUcFHa@gmail.com>
 <20240306070658.4216fdf2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306070658.4216fdf2@kernel.org>

On Wed, Mar 06, 2024 at 07:06:58AM -0800, Jakub Kicinski wrote:
> On Wed, 6 Mar 2024 05:16:16 -0800 Breno Leitao wrote:
> > I've been looking at some of these embedders as reported by Kees[1], and
> > most of them are for dummy interfaces. I.e, they are basically used for
> > schedule NAPI poll.
> > 
> > From that list[1], most of the driver matches with:
> > 
> > 	# git grep init_dummy_netdev
> > 
> > That said, do you think it is still worth cleaning up embedders for
> > dummy net_devices?
> > 
> > [1] https://lore.kernel.org/all/202402281554.C1CEEF744@keescook/
> 
> Yes, I think so.
> Kees, did you plan to send a v2? Otherwise I can put the cleanup on our
> "public ToDo" list :)

I found the requested collateral changes that popped out of v1 to be
rather a bit much for me to tackle right now, so I think adding to the
TODO list is probably best. :)

-Kees

-- 
Kees Cook
