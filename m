Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7990388E4F
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607653; cv=none; b=LttZ5PgNonVGHlYomq2SpGiXkR80qHacWY9Velmfr1E4K3cE3GQCW/M1rrvmeoKBoS+z5qAUEYSDPvGmV2J/2+zUCH4IA6Zd0DmU48jgYZTccyG/UhMiBapgDAVSvtAIt0ygXV8y81xOkVoUngVASLlLsMebDNXLey11q0tDWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607653; c=relaxed/simple;
	bh=z+qESeFpb2XkTbR/Okjo5v5Qr3euoD+chi96tqKTTqs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYdRP5KZMNTGQB89ZK3m7ZcaTt8zuZtOwNVr7f38n7v03XoxoeQYxs4e4k/FBTuR9ystx1tj9VzpSWVsBfvLfUpJEZUwwfryAjlLlzQNwOJBYWzVB5r42Py0+gMu+xlRkjS1xNQms8INeJ3X9/pONQ8tt8LOOGZojygexlXgiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwCb3wmD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwCb3wmD"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bed2195323cso666389966b.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 04:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607650; x=1782212450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9bZm1yyHX30uMCUt+HLHYBYfIefkCZ4T7Ob1gBqI0/A=;
        b=GwCb3wmDSBcGiuACUIqdGpuzq2GbWc0KdPaUlYqos+6L8IUWvdwVBAmnYY0vYXoSJR
         +VcPZvrZaubOdx4Nc/m6W8SwoTpQ7BAg72RbOZFZJ93v4zyjFc+oCuNEc3sWR2PHB+BK
         LfIydCd48Cw/sQmxqytXXRQ8fIR+Hs97mbFVW+VApdO9ZnGMLjvUMWZ4sQs9ugTG456A
         y6aOSU1UDqwIyN84uYX7tsD5g/+MX6dVTAca6AwjWVzWKva7rt7PSh7LwaWspZsSBtxm
         OLwfLLW774EFUllphcIYjQ6m/fLpwuBvEOcG5U4QFlq/iZX5OSESbiTTghyEE32G5hk0
         /qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607650; x=1782212450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bZm1yyHX30uMCUt+HLHYBYfIefkCZ4T7Ob1gBqI0/A=;
        b=Gas0FynII7Q3FuzCq1pXmosLcY+/2ET0mAbjp+BI/aIGBpWN6Y2lIxEmVAoFxEmB9z
         Rnz4Svkibpu9dnxUBr9JBPE369tIwWXpnhXv6d1l2NgYJxRnf1Y49axZvyMAJuPO40dD
         liGYfLphzTtxpFTy+cbseOlmZBoR2CJ9zOMIycKZD0dASoR8/a/HsN/mHyjgLYxmkR3Q
         vUGyOrQSjal/aGDFJyZBSxQMfBiJysYmOAJBQWERCas3/sfFBdQTT4p9uZf6RcOGJrQi
         j913gpk7D8engZrXSVtVVoRwT/d6BDdQ7s9s4oaOHTe3j2dq2Wdfha2dW4jFHOhddeyF
         pyJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jLsoAtDZtHfOLI+dCQasr/XYcZaNofgQnIfXGUQLxO4Yn9zVeg4yzjXfvl0AeuBAKZcgpgVbfMDR5jyzKNrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylCUX475x1B4vCb12ApZDFz5AyAeD3m3s5gCCjirHq/S7mLHTO
	6xHjx2+n5Zc4/KfFn6Yv6YcU8s1etfq1wBFE88xZ3ZgnrM2/4o7Nh7BE
X-Gm-Gg: Acq92OEZXWVwXxFeizUfvGdN08lAPzUDxks4jXkgEtAjxgtCSapcTS6+gzGHG0fFS5+
	e1LmWOHuavXhFvFQdfue8jDaSHztFX7OZotplP3sOpfQgH/eENJzUY37NvUc3JYUkb8d/nJia05
	cQdx2vQfy/eZBcmbCmjxwXFkZKexcUpYvyQbZTSJgto1er1+Vued9PG77ooIz6KhKfozUuV+lA8
	CwT7nEXDGIbAJb8woyO+WRDV7y3JR6PeDAlehn8fJBk8xNGcpvqTCAuvIL2R1iI0dD0X1hCK0Q6
	F4+2udO7Z5hsT3lg5Xpo6KNF/7l6+GD99DVK7xYoILWaQ/BWLfACkEg1iDpplfS3xOUSxfKCE6W
	ujn8bYUpTZbB0UuNI6uUaQz93MXzYGDWBjawKVOAAEE0vzQtuUHtekQlkHmvaHWm3wwug39qgnw
	wiZb9OTXyB+fnqsZZLKDPbUUST6zOODFrQ0ySLVjNCaDQP1y/1V/JXXFF5//Ki6SIyCILwWkNna
	eueevyAwJzDRN456nvXAjLoBWJWBBhCmmqItNQ=
X-Received: by 2002:a17:906:ef0d:b0:bec:157:a630 with SMTP id a640c23a62f3a-bfe28e12485mr939660666b.23.1781607649727;
        Tue, 16 Jun 2026 04:00:49 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b240bbsm640211566b.18.2026.06.16.04.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:00:49 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 16 Jun 2026 12:00:47 +0100
To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Maxwell Doose <m32285159@gmail.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v3 11/12] iio: dac: ad5686: read_raw/write_raw: use
 guard(mutex)()
Message-ID: <dpxl3uucfdlsu5e644zrezquf7raeuy2aaiximxgy5dfjwtdt6@zp4hnebhfwr4>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-11-f829fb7e9262@analog.com>
 <ajEo5pOp3ElX4cP7@ashevche-desk.local>
 <bguen4zngbwsnoxbis7mfrmo6q3vbccpntfzr6bsiog76kdhvp@3lcygxwlg2kv>
 <CAHp75VeBE12U6dELhtxnL7ah4WEmAMVk-jq7vky1ynzdp_SAZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeBE12U6dELhtxnL7ah4WEmAMVk-jq7vky1ynzdp_SAZw@mail.gmail.com>

On 16/06/26 13:52, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 1:50 PM Rodrigo Alencar
> <455.rodrigo.alencar@gmail.com> wrote:
> > On 16/06/26 13:43, Andy Shevchenko wrote:
> > > On Tue, Jun 16, 2026 at 09:21:17AM +0100, Rodrigo Alencar via B4 Relay wrote:
> > >
> > > > Use guarded mutex lock to facilitate code review when adding new
> > > > attributes. This will allow for early returns, avoiding error-prone
> > > > locking and unlocking in error paths. This also adds missing include
> > > > linux/cleanup.h. Gain-control support will allow the scale attribute
> > > > to be configurable.
> > >
> > > What about interrupt handler? You just added yet another mutex lock/unlock
> > > there. Perhaps this patch should be done before the previous one?
> >
> > Can't add the guard(mutex)() in the trigger handler because of the goto.
> 
> It might need a refactoring then?

It would deviate from other examples... would either repeat the code in the end
inside an if statement, or wrap most of the function implementation inside
one. I suppose the first option would be better.

-- 
Kind regards,

Rodrigo Alencar
