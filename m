Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE3335BDB
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855028; cv=none; b=UylAAiFZREydIHsOvHhQNKoEkb2YTCaz3PeQW3sReLNzYul+d7Aebt12oXMzIGYzEYRBmUUclYpJtYNsfWP9KC+n5itD0Gse13FoZ7sZAeQXO3S3qSYuINA411SO5/ZH2E0z2KAjLFXHnT6wzTUSUWlOEcgCt9y/6AueXD4rI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855028; c=relaxed/simple;
	bh=JtwQD+WieKqcogcMHWpjbsbEMyUOZdEqFz8nYzUh7VM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT3iLmiQVZ09qoB/fACtizotVyjFQAHuCIxjW4aWlxFXxDjq2OGbYKOEX3iTzg1Hb3TGJPzfJpEG18/vEGaemBFobQa0Pj2Ec/i5bHlPe65+bL15eEcmONM+ZSrq1U+F/8EHxiGtNcVF2TQMVtaR+nc+zvrf/rKJVQnO6H3D+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTzJfeNP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTzJfeNP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0b9328c4aso13446315ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781855027; x=1782459827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/CJyPY47191DNK2I5FV8tH3A2JiB8r3XI4Ww1d0nJQE=;
        b=JTzJfeNP86y6ShPISQBwgECqNb1la4It+H6oAl+3bd1wGP49meeHZ+TC6oxa5qm+X8
         V1aq/HwgTYREZSz1AOuIcytOOOy312PdW5/TqO5idUgQwS0pZS3tiBV1EOUebVzmRO2N
         seHwxCGj11oXzS9XRcYGO3O3NwTUbPqr3/g9j5Bugwzxd2lBPNpTBfrUHOKxrP4zU+wn
         0pK1hcawnEKUecYiQWN55hOun8u3/h4HgrMHJV6KhCojXOyRrFDif3zPG0D22RmWhRi0
         LP61/H8d1+3ueVlFGt/Z4lvmRC25UzhrutfOgmpOMSKZQSUM1SrSg86ayYKKvDdooE1P
         uLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781855027; x=1782459827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CJyPY47191DNK2I5FV8tH3A2JiB8r3XI4Ww1d0nJQE=;
        b=NZJkaFU2WwufwtTGLpqLGofdwrBYIUXQ6joORUY35J2n5vncAuwQJCR6fSfrFoa7zH
         s4JTRGeaUOYx8tFhDEFkZOm/dGcoCXBhYBdgxp7NdF51VyAgK+EzOy3+nAopcClKljNn
         Erzg5m/MH5m3FI+V9aUIKh2kEhZn8au6V59KylV8SfD8O8UunVa6TKi7GAINzfUK5d4Y
         0HLLrhv+bWhzOQsD8ff7FO1MEeGO3V9Eqs5coTThXJDstKrJnF4uGCnfYSkwDSuXFOx4
         fZsUsIkyeyqySf7p6QmM1aDYbgOSTjQ6vdu+Nu1QxOAxZtJWQ34QSHcHrxkc2lxwBf9Q
         +/Qg==
X-Forwarded-Encrypted: i=1; AFNElJ8cH4+OYfOfLbHn8Vi82VmYWgpkL+R7bo7j6gFhQ+81D0T2zeLcKctU9vZeH2nzN12fVvwEHu1aDSQGSU/xOf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfR3YFBnPWJzWUiDQNGGXEsC0csPVjnDkGzQkV3MUbmQ7XK7S
	Ow9dlrxI2mk/oKQBz467Dhu1CrEGulF43Dfsl1gr4wfIcKngN3f5PSRi
X-Gm-Gg: AfdE7clZvJHW7qnB3+u+h9qdvFtJozdzIJ+XbbpsyUN6QZXoms2U+iwPk4XSbfou0pX
	OQIWX+B/7CCKR49KDelqvL14xzWPdN2hIyf8hXPG/vbYU728xIxgjrobRdQSEdy2ooy4n6vyf2m
	fRL9Spu41z0A9tW6bN1MqDDB/RJqQya5tsx1p43pfASs8SbYwfv6idBgKmhBVaWD71LvGWSpSmx
	QeYjp0znXlboByWGYVuQCTg17MvIKoJOVaLd4Pj5WWB45YDRVRSjQeuQ2wnQV9Z5FDfOKJpZPGC
	lHF6Ms53ew82k2KWbgrCG7lC1Yjqzm1ZZYKmpNb75HlSHvXp1kZ06Br19GmmWJBB8m1FtIAtaGI
	BM2uZEhm2dQ3ur5Kf2OsgB2ZQ6FIQzYelcR3iq2QuepDhVgB+n1Im8l1WJ325FdX3qTmz1AK/fZ
	mXkIykC8F2D+Qhvug121o+C5Lh5R23V5BhGjorW8OnZrIxmfKMhKMeqmCgKElj6ErQbTdqQr13d
	u4uX8fAetrty9d9bje3ZY/EKJkJ
X-Received: by 2002:a17:902:e5c3:b0:2c6:6926:8968 with SMTP id d9443c01a7336-2c718fc3191mr28913805ad.20.1781855026787;
        Fri, 19 Jun 2026 00:43:46 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c72089c1cdsm14474145ad.17.2026.06.19.00.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:43:46 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 19 Jun 2026 08:43:24 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 06/16] iio: core: create local
 __iio_chan_prefix_emit() for reuse
Message-ID: <dlisetsssjoyodmv5ubl4rzhxtla3g46mrrzv2f65nqecel5fu@dqiqsayr4aip>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-6-79125ffbe430@analog.com>
 <ajQGTQ1_qcOwfzne@nsa>
 <x3aijvc4buo7aqbchikuoyyrgiq3afidtkla37h2rg4tvfdbc3@h42qp3estg2s>
 <ajQ1bZSNHQ96pyJx@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQ1bZSNHQ96pyJx@ashevche-desk.local>

On 18/06/26 21:14, Andy Shevchenko wrote:
> On Thu, Jun 18, 2026 at 05:14:19PM +0100, Rodrigo Alencar wrote:
> > On 18/06/26 16:06, Nuno Sá wrote:
> > > On Thu, Jun 18, 2026 at 02:27:22PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > +	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", prefix, postfix);
> > > > +	if (!dev_attr->attr.name)
> > > >  		return -ENOMEM;
> > > 
> > > I don't oppose the change. Looks like a nice cleanup.
> 
> May I oppose it? I found use scnprintf() is harder to follow in comparison to
> nice kasprintf() that takes care for the dynamically allocated buffer.

In the next patch the function is reused in a sysfs attribute read handler,
a context wich would not be nice to have dynamic allocation. vscnprintf() is
the main building block of sysfs_emit() which limits the buffer length to
a page size, so I used scnprintf() trying not to deviate much from that. 

kasprintf() it is still used in the caller, where the logic was a bit confusing
as it tried to avoid multiple allocations.
 
> Also there is a chance to get a name silently cut due to insufficient space.
> Besides that this function can't be used (again due to 'c') in kasprintf()-like
> wrapper. I do not consider this as a good approach. Have you looked at seq_buf
> instead?

NAME_MAX is not the maximum length a filename can have? I suppose there should be
enough space for the channel-prefix. Indeed, seq_buf can be used and it cleans up
things a bit as it tracks the the position in the buffer.

> 
> > > But bear in mind this very sensible as any subtle mistake means ABI breakage.
> 
> Which immediately raises a question of test coverage. Do we have one? If not,
> this code must be accompanied with one.

Agreed. Will see to have tests for v7.

> > Yes! I tried to be careful... this is dangerous stuff!

-- 
Kind regards,

Rodrigo Alencar
