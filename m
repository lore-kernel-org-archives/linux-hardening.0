Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306D4315A
	for <linux-hardening@vger.kernel.org>; Sat,  3 Jan 2026 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767459712; cv=none; b=XLtP2q2mq5xOYw0fWTo2qyr05EVQ86PPMYa3H2MubtycL7yjEDUBu2ZE10pKFICpnfx28FJyVqumzqSn7eh7aDA6q+WslB3+A8wq+/QUYSbo254W1AvDoPFHP8Mvz63CFqrr37aIIR9zbYh7sXZQgfhBYIwrBneLz3bnS2MGEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767459712; c=relaxed/simple;
	bh=KQXl8jGs3GODk15tB6KTtrgOeAb6Hys26tY1ny9AYdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6lnvnSv747GInzqMrtaJoXXArbGRDZXIHnxpGqZy1vywvQrc65mxsbUX57xXzyYy1qy0G1IW0BlWMuAUM8raGE4EMRtR+zLJnL9m1tiGlyTr1mvcGBYI9tIbGweRO4EAPPT8Ob70NchOxSsPrzPoVLZD66ZFp6v4oQJTZLfKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9Cget1S; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9Cget1S"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so7623453f8f.3
        for <linux-hardening@vger.kernel.org>; Sat, 03 Jan 2026 09:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767459709; x=1768064509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHSQMnJBQHG3fEabcx1jHr7yPb3RERixhfZ5sKkWzqY=;
        b=O9Cget1SxzflOyoG1iBj4tgeldJE8YEv+KCX/Po0HJ5CjxayvO5ZpmNW3teQ0qYoGp
         Mhgzx7wb53SdYQTHxLiyCXeRNd9TCYn/BtVvHVIQx9kaCd49JhuG0ztiudTYv7QjEGN1
         CgpT1i8bIeNPIoj9zDuMftOMgJ5UFx1oiZWH1c9LC2kqI1kQnURHDQPAPCBrwX5bTHkm
         vXEkYDhDCsCZ1ArZTs+a0y4gY2BYAMifW5QJUP9q3eoVRY6y3aDljX3v9JxK7S6LlLnS
         agYbSMbNTXAlpQnMn9yGLzIenQjT0k9MCqA8g5+hiOJLFtfHVa2hjin0LA9KmHsvp+ZX
         qqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767459709; x=1768064509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHSQMnJBQHG3fEabcx1jHr7yPb3RERixhfZ5sKkWzqY=;
        b=wdCtggrkFgUuhqwsnlTxkdTwfo6qpnQuJyKJh8T1dX7KHq0iIXjUgKM5npZwu6xkq8
         Ip8JR7lJojGmLKIUMfJIYUCG2vvDLcVlrW6hCRnqL7Vi+Oge3yVzSSyiV8/EZUvouzNr
         BUdwsTHbJStfrPWoat8YwIYlCIhDTZ+b72AoTaag/2iG6W58Md39z+7+3XLsIU8adg8W
         rb04h4RYDXhHB3x1UxyOM4mEQB+ZT1R3RY0Mo7Oq4T/SCtcCrypihRWS+hdqc4coc1qe
         YDfNaO5W+Xwk5L5K5o3tAFda0qWwam+JxPr4nwN20JAAGTm7eV3veaprILWc75LAIDUq
         EZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJIhhoyygnaeHUmOhWgefTSamoDiWbyIeRdd5B0V6X8vGo2czPmTNFrmXjZCD4o1aBUPioXIXT0pk4HT8v3fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbSw+ETr6ilOQwtrW0GPpq7H+wAUVlMlcFUN19nTtTJfZqETpn
	cYTZ9N+f0cVUq9k849L48HeQW2uteto5zd/myrG1zVpA8oJ5mGASSjs6xAiJfN3C4Uo=
X-Gm-Gg: AY/fxX5YVBMitLETWqlqTEzXcTccSNh4lC2K9u8xOLfiQW58jbttPX1AT6+QC1Fw/fo
	ltB46FIcg3Hzhvh4DIxSxUZlmL+FxppAAtaSLYkuSk82JTsZEuBoQml8YPF4dla1gJYeAzlBVFy
	wOCMpn8sLPGsUkJbKf0jErPpBq0YJuTgirv8rz3qUE5WNEMjB3RRMXMYILcR/iZq+gLIMXuS9v+
	3NxLpd+xwxbjpREM6bi+lFMJIFtv+QDanU4NOdyRGYTxsSBv2ilQwjijiuMo4OXsQjZ1A4z682w
	G8deR+gTIIz8W0c4FhOwefShbfJ64YSWbDWIAnGOw3iwtEN+Xl4cYuHP6RmFKkVcSuktHPohpoy
	Vw2jxDeViWRwbD87Mz0KYui8U0IGeUqOZMktXfbLq3ZeGRT2+JA+yLG4H+2iOGP+wMxjs1TRFVI
	K9/PNgb0YhlWTl/we0
X-Google-Smtp-Source: AGHT+IH76r9upX5LgpHZ/fOST6gsEDX5p5oGk436/qE1kT4SAaRLVvV1SuOGoIs6C86iZ8FylfCo5w==
X-Received: by 2002:a05:6000:2c0f:b0:431:54c:6f0 with SMTP id ffacd0b85a97d-4324e4c739emr61327273f8f.4.1767459708384;
        Sat, 03 Jan 2026 09:01:48 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325b6bfe88sm82459187f8f.19.2026.01.03.08.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 09:01:47 -0800 (PST)
Date: Sat, 3 Jan 2026 19:56:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] overflow: Update is_non_negative() and is_negative()
 comment
Message-ID: <aVlKTculhgJzuZJy@stanley.mountain>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
 <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
 <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
 <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
 <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>
 <903ba91b-f052-4b1c-827d-6292965026c5@moroto.mountain>
 <c84557e6-aa92-42e9-8768-e246676ec1e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84557e6-aa92-42e9-8768-e246676ec1e9@kernel.org>

On Sat, Jan 03, 2026 at 12:10:45PM +0100, Vincent Mailhol wrote:
> On 03/01/2026 at 11:02, Dan Carpenter wrote:
> > Thanks Randy, for sending this to me.  I'm on the sparse list, but
> > I've been on vacation and haven't caught up with my email. 
> 
> Welcome back, hope you enjoyed your holidays!
> 
> >I can easily silence this in Smatch.
> 
> Thanks. I ran this locally, I can confirm that this silences the
> warning. So:
> 
> Tested-by: Vincent Mailhol <mailhol@kernel.org>
> 
> > diff --git a/check_unsigned_lt_zero.c b/check_unsigned_lt_zero.c
> > index bfeb3261f91d..ac3e650704ce 100644
> > --- a/check_unsigned_lt_zero.c
> > +++ b/check_unsigned_lt_zero.c
> > @@ -105,7 +105,8 @@ static bool is_allowed_zero(struct expression *expr)
> >  	    strcmp(macro, "STRTO_H") == 0 ||
> >  	    strcmp(macro, "SUB_EXTEND_USTAT") == 0 ||
> >  	    strcmp(macro, "TEST_CASTABLE_TO_TYPE_VAR") == 0 ||
> > -	    strcmp(macro, "TEST_ONE_SHIFT") == 0)
> > +	    strcmp(macro, "TEST_ONE_SHIFT") == 0 ||
> > +	    strcmp(macro, "check_shl_overflow") == 0)
> 
> But, for the long term, wouldn't it better to just ignore all the code
> coming from macro extensions instead of maintaining this allow-list?
> 

Of course, that idea occured to me, but so far the allow list is not
very burdensome to maintain.  I maybe should disable it for all
macros unless the --spammy option is used...

regards,
dan carpenter

