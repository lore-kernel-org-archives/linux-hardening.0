Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49F13AD0
	for <linux-hardening@vger.kernel.org>; Tue, 22 Oct 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582231; cv=none; b=qyOTxe3ckhvc4MTMUCFVmUAruU2DcPbiatIKXIis4F7v3vTO1a/WeXPXPcLb7+mhUyMoiotrHWTIu7wIk97sB1C1XTAnob2attBw/chSA1/Rcp5noBdYX33O/UtYrPE6Jy/dvgcEHXOkstGnc2ii+A+d3K4nLXw+3Dv7W/UCRes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582231; c=relaxed/simple;
	bh=s9AlGR3aC/jkfp5wIIAiFqq80453+YrFszZA4EOS9fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5soGW1pmQ0rZMB/NMmsYwABMxRLJdFcIxoyfBHtuNWch/ukpkCOV94qGhcodpS7eQvA9GnwnL9KlbAgdvy+AFZWCsjAMkCw12KUXWd3HyV+orEojgIu9bOmvgXVsTUTereWSJ2sxziOIKGUAvNLAols7hRB5G3C3dr21oSaFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tbehmfhi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tbehmfhi"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539983beb19so5860625e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 22 Oct 2024 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729582228; x=1730187028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9AlGR3aC/jkfp5wIIAiFqq80453+YrFszZA4EOS9fY=;
        b=tbehmfhiq8xGkwApxzC2ZCqTdI5cdhsh4MgyS0QGSJcVffr2ou6Y+NuEbEuw0NLQBz
         P+BkmVP/kdMoHjAbavcOWCcitX22Gsq5rYTBlYCq5ArR2LHHgbOX9HdUaYiuPbWgYwyY
         HX5zCs5/W1j8IWjI3Fu2eyMhK1couCOcGp3hAvFzSHCvjH+wUkbp3QbPCNz4gcIDeg+M
         JtrkmzpQZizHmzIHn59VycoeskpI+lCQSrFNW5giWOHF4DyjnP436wecb6IWEtiDR1bY
         09yjq9F0sgl54dWsQlXHqMUpObD6sN0S7rtkwdGhl3Bcwa8VF9S9QPeeCdkSEFOksou4
         DGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729582228; x=1730187028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9AlGR3aC/jkfp5wIIAiFqq80453+YrFszZA4EOS9fY=;
        b=NcaF3V4ph6EE/CvX45iMfDV+gfpSndvceAHk6uNxT33vXx68eXH8UWoXL+Diw9QGkM
         I7Iw9zNe3gv5qg47dm+NvtFlef4+HzS1J46GDTrEj1pj4xkq9Pl6ITRYQ4MRA0O/jHib
         PgZHVubHn7+gHJ+KDj5SDm6Tl0561OoI5cIe24Ax/25vN9kahEnvj07V4DUbrVHq/rBd
         FIDvCz3agHIusetYKC9cb8PVGoRsQOrhR3+O1mQlm+Zg26j20J39DTlZ5XT66yyjs+jy
         R8Gy3lGCwXq304MSiVHl5MIBVnviY7oHQ0VthXthEb1tbu6ycqemSqbJtXl9g1tcSW5w
         InGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW712kSV/cjGOHZolZcmhyfbfyLXRAmmbIAXnZJqIbjh81Ez1m4dVA33NsS4iKGW8AZHf/r+QwUiKRjoMinJLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xPuFSpq1ZMwqZqUAN7JN4FwO/M4Hez3fqH8f4wfIJTufYL5G
	xqbclcE5ij+a358nTGg8IZr82pBG0GfapGNW/BTsQrSKSHDwWVg+SWM0o+sYSLb+P1FxAKZPcby
	nfGyTRmM9bdnqEYX53TT8zrIJvBPOb4N4q9LvtA==
X-Google-Smtp-Source: AGHT+IF49dZCMKViDbxpV2eKhiIHV1RDGA68wUouph+dlIMJN4RYm70o7grRVK5xXCDp2yY2Ikg40KfZMweGVngtB7k=
X-Received: by 2002:a05:6512:682:b0:539:89f7:3187 with SMTP id
 2adb3069b0e04-53b13a23dbcmr717950e87.47.1729582227670; Tue, 22 Oct 2024
 00:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021100421.41734-1-brgl@bgdev.pl> <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
In-Reply-To: <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 22 Oct 2024 09:30:16 +0200
Message-ID: <CAMRc=Mcp4LBj0ZZx=hUg9KBk04XXcAtiNv+QjQesN1iCpDC+KA@mail.gmail.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:15=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 21. 10. 24, 12:04, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The output of ".%03u" with the unsigned int in range [0, 4294966295] ma=
y
> > get truncated if the target buffer is not 12 bytes.
>
> Perhaps, if you elaborate on how 'remainder' can become > 999?
>

Yeah, I guess it can't. Not sure what we do about such false
positives, do we have some common way to suppress them?

Bart
