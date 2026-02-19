Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB32D193F
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488072; cv=none; b=S4g6eNgztDTUdIzmxJep75kgPGFcH3Q0jLjm2GUg/NfgnaIKwJbu6j+yWD0fZkfaVdgOt0qTT7jmwBA1ADD9SftXTtTxerkkW6aTkLcISgekCWf/H35XwTf7I2gRScnk6tZCleBCOCgGZcIs08jYiOmiaiw4zLBLRjQPGmkUPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488072; c=relaxed/simple;
	bh=97dxDuo1CGiK//r6VlQ2n/mnPEoD6lcPU66zb/bJ+yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa7L5u8p8244PICc4BWDHALGu23Qw3NFw9RbFB2oGGICy+XMr2DXc6GnbJPOPila9EVUp7YjJjjf5Z59zlgDs7U8TthW4s3HBSl1/AQRYcdk4sVKeq80YzDAvtWs1u5tDyaDHqV5Nu3ZFa3qSTMUm7vbDwarzwcA7rEKcjgmAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vVSh+qQd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVSh+qQd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4837634de51so2926985e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 00:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771488069; x=1772092869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEQ27jPIjOmpNod7ihflopMRb8gsNhXOZ78DPDWRDlQ=;
        b=vVSh+qQdoWRndVsMFPeBdlP2w98Bf0QA9IOMtgp1L1hgAdmnJUOr3TQM3qq1VxfMVg
         yhaaP+uODJGTcdofs9f6M4EJ8cmJLqmF+QLavY+KBK77Q4nrYCwc34r/4OjpWf+yhdS4
         AQ881pIl/dLwF8CLJ5bQXBc/S0xjU9AO1Z2KtVg3+LbY1J2ZbELBMQUbGTi4njtANowc
         HI4AatlQmBqeWRJBfTw4a9XqSxvktUqxEgBVjeIBvPrRGSSspvQOxiPQOydOVrmmBgzK
         /zMrJ1aGo59yvdiSJ5i8QNd+OAsul+ZMOTojICyrY8Oz5D8rsqaw4RuWWd2M0wgyJLSu
         urXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771488069; x=1772092869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEQ27jPIjOmpNod7ihflopMRb8gsNhXOZ78DPDWRDlQ=;
        b=F5l8MkKwZGPsf8nedBjpKJrAI9EH+5myKj9cLSbRhEvYzqthpxAjtZUqDfd/ri6679
         r1vOMOsMSLmGzU7notJf9L1RfHsKiJYNtB6cozGvg1Ab/Gf1/x2xBdmEYx8kXbmM1//D
         /NjFySpbyeggtBuyopxHrtE1CrfyCfhwgMeSpm5vH54SblpO9sFN4LpqFrnMKOU2Rf4m
         BiTJykQ+MrXVhaugUaX3vJOBVCBj/lmR21FfIO9Xystfw34httXT0er4lJ7aRxqVcZ1r
         Vpv540+b/QKjbdFfa4woouh2cXlcMYsO40lfdIv17icYXVpw+xRzViqbVFsKdswE7iAe
         HhRw==
X-Forwarded-Encrypted: i=1; AJvYcCWy1eCLFxrqpYG+CmLKiOfZM9dq/6Po1ndbyp2MLQkFdIA2uPXtW2XXQAwh1y1dPMi/YLMMPKHvqGBR9f8/3vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVB0exhKcLYaI0EC/80GF673jky5TLwo4O7TTAgV7pC/0b3Yrd
	ezXLXSW8+OHsBvigZIaHBi8Azhkv4CZGBEY4dCYVXwl8xUE+/h2NNuZtvzow7miyt7c=
X-Gm-Gg: AZuq6aKJJDNjbgUgoYVMSdz0+Aum6VaFsqQqWWhLryDC0rnNh0O7BjXO8Yy3wc4RTMo
	8+hh1Qu509m4lrfbndcactu0I2jRj89n7mXAPOeVmYekgS7sn/pSR+D/cK6QdDagHxTMEoeTN0B
	heVWgTo3xJ2YcBQMXKl9x2rLTnV06zcmgj836IeXDbQxkNrgczohEDYm+Uuxbr6UPwuWJYDI0uq
	OCcwsizN3/kHdAu4p0PppGzhJ7+PgwjyPAgsjs0OZewrQUxxCEwCtGUVdItwewAA96Y99tqxgoW
	oeJCIrYC+cW+eK4+ZDiqkfJL6z0KNI+gct+e1tcib/ECvL4ss9rY/VWPkAGaar7wsKjKrovBmmx
	ptXaQiTRFKHi4qE0dXnnciupUoMwBqvwLUTTCV8Mp/4ISX3NRgHRw/8r0UYoILF+1tFi9R6APms
	1wbTc99NBUCHOWvOBS8GkyTWH8s56TJec3T7rIys4=
X-Received: by 2002:a05:600c:1381:b0:483:ea6:8767 with SMTP id 5b1f17b1804b1-48371098c8dmr309544945e9.36.1771488068588;
        Thu, 19 Feb 2026 00:01:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837b68e5adsm461946265e9.9.2026.02.19.00.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 00:01:07 -0800 (PST)
Date: Thu, 19 Feb 2026 11:01:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 1/5] slab: Introduce kmalloc_obj() and family
Message-ID: <aZbDQLeMsHCv32X8@stanley.mountain>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203233036.3212363-1-kees@kernel.org>

On Wed, Dec 03, 2025 at 03:30:31PM -0800, Kees Cook wrote:
> Introduce type-aware kmalloc-family helpers to replace the common
> idioms for single object and arrays of objects allocation:
> 
> 	ptr = kmalloc(sizeof(*ptr), gfp);
> 	ptr = kmalloc(sizeof(struct some_obj_name), gfp);
> 	ptr = kzalloc(sizeof(*ptr), gfp);
> 	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> 	ptr = kcalloc(count, sizeof(*ptr), gfp);
> 
> These become, respectively:
> 
> 	ptr = kmalloc_obj(*ptr, gfp);

We are already getting patches that covert these to:

	ptr = kmalloc_obj(ptr, gfp);

(without the *).  This feels like the obvious bug people will introduce
with this API.  I sort of think that "ptr = kmalloc_obj(ptr, gfp);" is
more natural, so maybe we could make it work that way instead?

regards,
dan carpenter

