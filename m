Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1573385AE
	for <linux-hardening@vger.kernel.org>; Fri, 19 Dec 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148350; cv=none; b=gQxCEHNjOFYCq7vgOEajfgFplS0sP1HJBIPUOj7i3OU03jURpP50q1YC4/pYxmMg93el7mLJwWLCgeSNmYEVZxt8dNUl93ODBU1tPaA2UMcMgsH+JngBph+JD5gC1rr2TehBITnsIhAoFnuChzAN+vBud9FHR8V8rLdN3lfWqpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148350; c=relaxed/simple;
	bh=rSL621rykIUEPUs9lqTSuM839KvPGrjZGBWPyNzT8tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpQFzbqFDqSw9C3uPa8pXdyzsiYgIVqYp6WHhYPpyLyI47juogx4MzircuNQecxcqIw8tc3t//fZ7UhXR9CqWozJkbBrFFDrYFwZWDTPzOqOtT6hvOv8xfx9fuke2GdCPTCrc0KOQ4Y8G0s8vQZfRB4Hyhf0pitzWaIuqqnGpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQpkga8O; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQpkga8O"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso14747315e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 19 Dec 2025 04:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766148346; x=1766753146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ReSbGlU8XRlW0YyM9RKHmUTpdJ2dyefmPFjmWe9yo0c=;
        b=eQpkga8O1WWXNCP4aoXHqCIbJ7gVwsSLHneGuSdfbPjlLtZGuQrLS1bk5ZO3JadWQ7
         CLmK8PjcYTDB+DI/KHO3qEwwZPmBq5T1rClsOdv0l48G1b6CLpm96i9ZYU6lnCwOxSGD
         GuhfxmmDP4uLBgDPZ4BQSdRTDZCzRQ6u0YH6Dv7uxhDMuy+8+aUZp4bipKlgDp6ya8qV
         slcYmam0D2aCKLp4J3yafWj8gNzDdvNghzyqQOka7rkjC4E/1hnLSRu04tNBZ+n3OeAA
         BuD11SK3744bzAQir9MOzWRcoZ8mzVh0vb0DMHM5HUVDfEZZuq+AyzTKydtrvlksOouV
         eJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766148346; x=1766753146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReSbGlU8XRlW0YyM9RKHmUTpdJ2dyefmPFjmWe9yo0c=;
        b=vvknwMwXk4Ulqwrqvccbx4GrDOo/NOsTqsg8d/1ltX3DU41FyqTa59UXA/R5EfkqFv
         s+H5MPhWMOG/0IXI4uIrtRcZEDOOr6PpLPItqLWFPtW8v5vJgBHC+LyijWl9YtQWQc7K
         sOu2wn/l9hUQQTKbWlNp9FsW3zWruYg2mjP5aZ0jouOxwsvQTdnf7vLZIQ3JZz5PwBj/
         UhtwBvLhmZIb01k9ZscsjnAEXOcCF6XIswv2wf2UTojDtahPiy5ma1ZtgzEDyDllTufS
         R5qLtfeOsCF7PDuIrAcfUYH3uQJbdgoX2QsgZ5v7gdMV8/bLwXjwzNcNdWdTf27243HJ
         MT6A==
X-Forwarded-Encrypted: i=1; AJvYcCWgZO74jQYdNfbOIjCGhY4MGSEfUhO7hYLoXwoNkX4ug4VAht5WgDUbikpsfRFoDAF5x+v2XX04j0o5ln8Jw+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5L31oifg+Fq5oF7nSVC/NazbKJNiHnPaAbSYkw8F0jgnqN/f5
	BUk5vpaHgPWl4awWgN7an2dc0YKOuV1C8WrgEi+4sDlk4iHde38mBFr8n3jkBeZbgQs=
X-Gm-Gg: AY/fxX45ihvlmj4Fl1ioSAoWBH2vugW+wzMNdQ/uWFULYTbJfCSBGHujnmvtiqbzGus
	ifGwm53SV/OF+LF8B3xETOusaMYY3YrJrzHyUcBcfLa5/oK1A+xofc4/nOKfsj9GFVUh5AS+P5c
	ZAyExnRy3vmLaXM8u+6dMomeFTMvErTt0CjF3PMVi2Gv9+zKnkHn9bj/M7OgzpVZkQjJhRsVxld
	bP9FBIDbrpUZRduGALaojCypCsMIEtmQZ8HHSNpYgbfpsiEDtueKhvIjIyrz6xo+KXuu8AeQkjo
	ONYP4ek2qwAUPuiaFAW8TJs2Y+tBYDFDVfp3H5QrmLmC7gqSqUIEumKo9FnLio27O/MOQZwbGF+
	Br9y9PgYe8SBHUTdXVdGCaPQiZhBZpMP7H2k1SBSVJ0kA0rUN+7ebNUjb06XXKd0S+10c1vjqj5
	6n6wrS5ioEeQ2Z4vmQ
X-Google-Smtp-Source: AGHT+IETZ0G01z1cE7qdPgY5yrMZkHUa63bk9+h/z7utiQB+7f6R6xnjXPBJ2pNhG2GNw9+omqfAPg==
X-Received: by 2002:a05:6000:1861:b0:430:fa9a:74d with SMTP id ffacd0b85a97d-4324e4ca445mr3427880f8f.24.1766148345817;
        Fri, 19 Dec 2025 04:45:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm4702525f8f.7.2025.12.19.04.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:45:45 -0800 (PST)
Date: Fri, 19 Dec 2025 15:45:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	"Luck, Tony" <tony.luck@intel.com>, Chris Li <sparse@chrisli.org>,
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <aUVI9smf2t7PvDF6@stanley.mountain>
References: <20251209001139.GA7982@quark>
 <d3dd8fc8-ab46-4cf1-87a9-0324685ba2e0@kernel.org>
 <SJ1PR11MB6083C6D97484ED4E4710268EFCA3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aThSGiKwJRYOB6kx@agluck-desk3>
 <aThqcq0iGge1pQCr@agluck-desk3>
 <20251210010020.GA2522829@google.com>
 <aTn0WdVv-S_EpQmS@agluck-desk3>
 <aTqAxfiVCR2ch4I5@stanley.mountain>
 <CABCJKufWw4VQA_k6Deuf5Bn6401cbYv_St8VV_0-LAau6F0nTw@mail.gmail.com>
 <083ebd92-4b3f-47f8-bf0f-395a604b5f05@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083ebd92-4b3f-47f8-bf0f-395a604b5f05@kernel.org>

On Fri, Dec 12, 2025 at 02:30:48AM +0900, Daniel Gomez wrote:
> Maybe the flag fix just needs to be applied to the evaluation? Other op
> structs do the same. But Dan's patch did not implement evaluate. E.g.:
> 
> static struct symbol_op constant_p_op = {
> 	.evaluate = evaluate_to_int_const_expr,
> 	.expand = expand_constant_p
> };
> 

I was waiting for you to send this as a patch.  I can do it if you
need me to.

regards,
dan carpenter

