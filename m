Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C2318B8D
	for <linux-hardening@vger.kernel.org>; Wed, 18 Feb 2026 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404533; cv=none; b=OT+sOxFZTOvqukeIB2necuJJkMqUDo4qrdlU4lWCu5aGPLanuXjPQTjkUCA1uiO4j7XVWiKTS7D75Ime0ZwtWaY/99YT30Me3CyB2Wr9mOxbM5BVmmS02u3z8q5GdZTUgmoUEk9mVVBlwbJYkBeNjXfYHT4XVqH0M/n4TIUIzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404533; c=relaxed/simple;
	bh=F1GBs5gqEy3379HyRiPCC6e5C2VAveRNCrKe3sIHkF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvjuN/hrcSg7sXmjYiAC7oeK5Zj4cgHVqUGN46xbfD3SRUj/aEggq8zBU45uXC4wrWIrXn8HlTz1E14SSYsBoszPhdab5I7t5w1i02RpVPRN05OYdw554bw8DiJqbg/Bi/FntB5S06J9dQBlg/yQx/Ryi21JzvM6L6PXv0o10tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZyEKT6H; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZyEKT6H"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4be7c4ebeso2877534a34.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Feb 2026 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771404531; x=1772009331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQTXQYFav49jYyRtw64JUokHu/z2PFtLBgO8hXSnfbA=;
        b=fZyEKT6H96whqpVUQxbaurFvGtBmhS7g9eUk5oWGYjyLpYyR7Zaz2QAM6NGeFz01nK
         evslKaVSJhY9133TJaOzMMszaF2ihIqjz0e78g58qLb8+JAFoE8zdYmy7/hErNw5BS8a
         lp1RgIQ+xaYm1JHQpWOoxpT/qRy+4/mHd3KOTbjHHDNOKrxx/M0SkY477iXrc4eLfBiB
         9P8MGlODMEf7YQeGbwj/F+wI1jEHPWQrnJcZN9PTwQ6rz8qehlz/wrF6f+097iFsAbrH
         enQIaLDC2Mw+QRTxvkwTL3mdxHiDKhm/2NZKCkFhT8JxboJbaPfAKtfuMFUIroFw2UJr
         39eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771404531; x=1772009331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQTXQYFav49jYyRtw64JUokHu/z2PFtLBgO8hXSnfbA=;
        b=obzcMk94Fey6DMZo1Ph9Hp6Z5yobQOWIHhLCY/cEBpmdO72tPHHfx2cX6pteXFWfmY
         rp5fHHwr/mEr5GCqY3rRSzygqkAX24oyM+2szwd6qUQRKWBI/7AQ5ztAupzKTgxu93Cd
         BvS0N4JsJwMB4HFiU7P3e7ZxMSv2L/Vsx5lII1nHie3IyUsx9la9NBdPk5aqpgIUtrwE
         bmGZUz9w9+1mRRBZzleGQ/rxrv36Xrwb0rZZ0AcvQdwoNCPe76TdSoGXcVUvT5Xg+nYW
         2trMZLvZ82xKnD0UtzBlIiaE+1Jl9SwwaL00/3DeqL/Dyvxp6Zbrz5AeRi3V0E0DdW/x
         uXJw==
X-Forwarded-Encrypted: i=1; AJvYcCXASYiKbXY3YL+PoBxv9tfRyjDDTZolYbYjuznlQ0ydm4pD0ueeB5XQ8IWutcd22gVOnYI2kNF4+Ox4dxnEC2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpsUDu4tMkXHfgSBh6pTdFir+xuLKMEBLVsL9sLhwOUP0GECA
	i774I/YHkfkNHUKjZjth0dVKdQrIWKb8vLXPE9Ue8t+SIC7Lh4z6LV2r
X-Gm-Gg: AZuq6aLNE2dwTME2n60ZBb+WmLG7UgQwIYfCSLB9tHGHsPkvHZKetAXFCqVZBlK1MRF
	jd02F3XZZ1J5mkVqjtqkNSxpltlFm0DXt2XkmGaaB7k6eF8pEMciBl3qQJRiMwUOiVoiA7wkl3b
	46trEC7PtNeXUMTDXoIn5gVVYBav5snws8Kn25Ww+djrNjjxtpJnnq7T7I7mMNA90adWi/rSwVB
	tEV9MaL0WH1+LqUTGH62+TBygliGVM4uWGRoetD13aZjMgnGQa4YDhNllLgr7N5mLYo1baauonT
	X5GsWisN0y+acUTA0ekieqSjnaWoXC3wmIy6GHrc/7OKvyvuewe4cD0VTuNx/yLo9PKSslAhprX
	2pvZlS2h85A5K3sZ5sYU+RgC90nIIBcIeKECgLcH585mU00jav+vbj0rNAW0HcbLcYMU3xIXmTs
	KTeIeiFmtQ8DAnCjH0jkkB3RAgbjOzaIdp4dINbKAJyWwgElD0ShGvT3v6m78ueyoc
X-Received: by 2002:a05:7022:a88:b0:119:e569:fb9b with SMTP id a92af1059eb24-12759a00d27mr429509c88.10.1771397414519;
        Tue, 17 Feb 2026 22:50:14 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:968c:f102:3683:408a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742b62274sm23152120c88.3.2026.02.17.22.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 22:50:13 -0800 (PST)
Date: Tue, 17 Feb 2026 22:50:10 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Chris Li <sparse@chrisli.org>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>, 
	Malcolm Priestley <tvboxspy@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <aZVhE90b6dZbGpfj@google.com>
References: <aThSGiKwJRYOB6kx@agluck-desk3>
 <aThqcq0iGge1pQCr@agluck-desk3>
 <20251210010020.GA2522829@google.com>
 <aTn0WdVv-S_EpQmS@agluck-desk3>
 <aTqAxfiVCR2ch4I5@stanley.mountain>
 <CABCJKufWw4VQA_k6Deuf5Bn6401cbYv_St8VV_0-LAau6F0nTw@mail.gmail.com>
 <083ebd92-4b3f-47f8-bf0f-395a604b5f05@kernel.org>
 <aUVI9smf2t7PvDF6@stanley.mountain>
 <aUV7kyjxlijuy5sC@agluck-desk3>
 <aV9vo7_turBr84bs@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV9vo7_turBr84bs@black.igk.intel.com>

On Thu, Jan 08, 2026 at 09:49:39AM +0100, Andy Shevchenko wrote:
> On Fri, Dec 19, 2025 at 08:21:39AM -0800, Luck, Tony wrote:
> > On Fri, Dec 19, 2025 at 03:45:42PM +0300, Dan Carpenter wrote:
> > > On Fri, Dec 12, 2025 at 02:30:48AM +0900, Daniel Gomez wrote:
> > > > Maybe the flag fix just needs to be applied to the evaluation? Other op
> > > > structs do the same. But Dan's patch did not implement evaluate. E.g.:
> > > > 
> > > > static struct symbol_op constant_p_op = {
> > > > 	.evaluate = evaluate_to_int_const_expr,
> > > > 	.expand = expand_constant_p
> > > > };
> > > 
> > > I was waiting for you to send this as a patch.  I can do it if you
> > > need me to.
> > 
> > Al Viro thought this was wrong. His alternative patch is here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?id=2634e39bf02697a18fece057208150362c985992
> 
> Sparse still is PITA as of today, can we get some fix (Al's or alternative)
> ASAP to be applied and sparse tagged as 0.6.5 so the distros will pack the
> new version, please?

Any update on this?

Thanks.

-- 
Dmitry
