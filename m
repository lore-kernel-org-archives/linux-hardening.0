Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229FD3587A5
	for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741431; cv=none; b=ZVgbV1X2/BM3quPfrBZdPRE2dXU0wOcvhtRhOAakorvlwUWRkpZ0bGq4BmnjDtTZUa7Hg/rbvljegKNy75KbGugP7dh7FQ9rN83swJ3UkMqGN4pUafeh9nl35bBnwLTjoN1Zci+rPF6QCgkjGk3MnwBfzqNXX9Aks1rVfvVGHMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741431; c=relaxed/simple;
	bh=ni2P6AAAIna0hjFuAO82zYVMn0J7WfuU6b6IJiF1kKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXRXVjb9knIiiGpwOFnaQJSi4rNtNFLJs+DEvr+eZyg99H5CX731tChip56QMT2gTUZueGlTCbyF0DCQoQfvCv87Zpe0ffOjai1Vpp0CTAwPeaLhNeIBRZzEe6Jz8Pl0clcMpaKF15fToHdaUsHFZw0vFT+HIArwd71CZy9hsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F87I/2HK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F87I/2HK"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso1500949e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761741427; x=1762346227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7av6/+8iNuXmmgvTwlUka4Y7XmkOmuVd9YoxH52DeM=;
        b=F87I/2HK8EHJQ7q4NQauRZSN2gkF3Pa6uWaxKT5wFbnJ02O9XJM9CVQa76aAk0TSaF
         76edmu0GN4qf8O7hLOGmgl2m1E/wZWlSCbCwBKWravWbrzWOVNd2Wqlt7J+Ua6qOxZxV
         Vo25gJ6FNxMMGcNYpCsgsF/Dew11WFweBBQN5b/PSxkUJYaDWPJMhjW8sS4ajHDy6GUk
         UcOdOSnXu53Sjp2FtHMI3QAxxu+nHioY2KQfxl0H50DDrK7277Tkwx4zmGEf+2VqRYAC
         XTokfkhjUfDrPSSnkP3OTTs8R08HxGteHAfjxqZNthOIwQp4OQb3FHhc2UN/G9S0PpM9
         LdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741427; x=1762346227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7av6/+8iNuXmmgvTwlUka4Y7XmkOmuVd9YoxH52DeM=;
        b=ZiJPVaC21CUk/6JJa4jBP7gnAJ5rBhYsSMa7RehMKBUgU1WZ1WuC1Z//eLsFCld31L
         vyPXA57tC76U2BpEpjbWHwjdjnTdlFd7ddyJWarPCds8EeoqPErZWNiX99lTUiHC0woR
         2t8ORPBR+zhmd0By+L7GIlaBaU4pWq17U9ZmFTKi3Ko04DTqmexiR6t0PGhnehUaamf2
         zVy/0hMuUUuRD/mcgmsjMRoYHhhUYloj4VJpA9hqnQi1EBvSCYeCQKzjp6ORFKNMQNXW
         QktTon+ZteCZfgY7hxfpr4rvh5E1AQraitk/fiTZXu3pkiLpQhkAUn9GYNg9kBZCRxI8
         aVfA==
X-Forwarded-Encrypted: i=1; AJvYcCWmqbTbmtwqS/gwn5/+8PoYpgiWuk4l/LGCkswUidBqIc+hUDTpuSSfV+JMKo6csyryVhsNcElBTQs29KeUvqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0QSDeKubgnTYbPESeyGuE/zlIBe1XI1vlOW24N4aUsF/zo3Q
	JbWzj/W0bTc+5p2jkIEjOC7xcX7aQ8dBvNodWNQtKvWDagqnvoyDs4h4962va47yWMgcEPEfu14
	ZV9SFfFYInin7i9UFx6kmO0O01nmGzmKoXqT23/phrA==
X-Gm-Gg: ASbGncukVUhbt1E8/gfZXTFXcqc6UPPVnvH3SXQlqy9kRHguSEnBeKRK57eii1CN3bE
	tNatxDifj6xfpcE3jpDIfkzw+KrOHeXBvlwKWNajyzcfbdzwj95N0Jd3bsIUcOBQDyataEKr9JG
	t+DjUFbYGyLNcworfklJ05EMjvclPL3jIN3Xm7+63TMyMvknabMm1rGcm/Fecm5WmDwGhBhkU2S
	pMLVM8jCr9teVJdvHCnKlz+7hMfBsgpDePViLKSZw40hf1qKaVvHfWoIAM73fq8quOkaiRAlcEb
	4krYt+nSY3O+lPkS1kt7I/D2WBU=
X-Google-Smtp-Source: AGHT+IEUmGu04036ormM4pltNB2Am321w2VXbEnKTAs3EJCIFCtIkYSiyRchfH1o5wZ/LZR6U90hsv4wZnUUYh2RdrI=
X-Received: by 2002:a05:6512:31d5:b0:591:c763:78e5 with SMTP id
 2adb3069b0e04-5930ee00135mr2032537e87.23.1761741427164; Wed, 29 Oct 2025
 05:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
 <20251029-gpio-shared-v3-1-71c568acf47c@linaro.org> <aQH9gE_fB119CW3l@smile.fi.intel.com>
In-Reply-To: <aQH9gE_fB119CW3l@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:36:55 +0100
X-Gm-Features: AWmQ_blmOzETrnBiOxNQNAG3OMw6fz-E4Nx4SOD4Wgu8a41SpvuD7mJ9RHyBeG8
Message-ID: <CAMRc=MdKfXJx-cxNr1uOCkifD6YVE2t5w4hkuYy7jcnidiid2Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] string: provide strends()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 29, 2025 at 12:20:37PM +0100, Bartosz Golaszewski wrote:
> >
> > Implement a function for checking if a string ends with a different
> > string and add its kunit test cases.
>
> ...
>
> > +/**
> > + * strends - Check if a string ends with another string.
> > + * @str - NULL-terminated string to check against @suffix
> > + * @suffix - NULL-terminated string defining the suffix to look for in=
 @str
> > + *
> > + * Returns:
> > + * True if @str ends with @suffix. False in all other cases.
> > + */
> > +static inline bool strends(const char *str, const char *suffix)
> > +{
> > +     unsigned int str_len =3D strlen(str), suffix_len =3D strlen(suffi=
x);
> > +
> > +     if (str_len < suffix_len)
> > +             return false;
> > +
> > +     return !(strcmp(str + str_len - suffix_len, suffix));
> > +}
>
> Can you rather re-use strcmp_suffix() from drivers/of/property.c?
>

I think that strends() and its boolean return value are a bit more
intuitive to use than strcmp_suffix() and its integer return value,
the meaning of which you typically have to look-up to figure out. If
there are no objections, I'd like to keep it and - when it's upstream
- convert property.c to using it instead. Also: the name
strcmp_suffix() could use some improvement, seeing how I wasn't able
to find it, even though I looked hard across the kernel source, while
I easily stumbled upon a similar implementation of strends() already
existing in dtc sources.

Bart
