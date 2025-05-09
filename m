Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CD2918CF
	for <linux-hardening@vger.kernel.org>; Fri,  9 May 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797616; cv=none; b=GmJPGPbQg7sRctd+27IM5lk9IyA7EN85efrP2wZIplgHOlRk0v0qiXIlcjYTd4vKKXVNh3SG/mn9aqWqig5XjND5w27sZLLu1KXPhw/qEmgrYCoNWgiqVzqLeXpFHnx+OMiLAcqczrpIal7laBbT8aCtZqvS0eOHExeC6Wa/8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797616; c=relaxed/simple;
	bh=TlkSYuqs+traWUaA3K1HwpXrmTQmXOWxUyVb6ntrqxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSDizgHuhSxbOcgYSSjcPrjOPZ3oDdE/3ClGJJQJno8nCpvelSlUKBODA9d0gYClYFNkhDlEDwyzsc6BrbareWDOOm6b65+RFtwuteC3VlHW2OI2HqnickokaFscgp+mfodDUJW9jIYb35q95qG6FKqqNZM4AhdBFLgNS8uNvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EnWyqmwT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EnWyqmwT"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-326cf24aa35so902471fa.2
        for <linux-hardening@vger.kernel.org>; Fri, 09 May 2025 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1746797612; x=1747402412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyTEj+ygo5+Kkz2DMrVi7Q4tbRBWdTGHuOvCJaygYnA=;
        b=EnWyqmwTTH7t/lJXqovsbpnUSYBu1TblFw2aQjlPtSGPusPIJaAQ6aMbf5Qq8nGKRu
         PC+YRHDTqN4i8gdl3szK2ghVP51R7nXzPzu+L0MjnXLdCXovoIHe9otRhdH1P31mw/5z
         g5JYyllS/bUYNTlmRjX6WBBEk1yYh/QzMZi/tvOX4dj8uBtqCAdkSheA0Gn9hd5JHO1j
         GcZO/njv1AG51XHRLg6gWHdjHmE6Ki2YvXbWtDlbwIl0XQH+juBAd7G5E30wz5nVEFlK
         YU3Us9E32Mkn8d1vhUKjsjThXixJOKMqMfCBWf9nEWdVToSZfGUeqBDABCEZL19Yr1FX
         joVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797612; x=1747402412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyTEj+ygo5+Kkz2DMrVi7Q4tbRBWdTGHuOvCJaygYnA=;
        b=ubISMSpFckIErJsuKdTYPm9n2/gNVHAagvzKKvDshEePflyLY24KIFi5P7jcnhY754
         mNGndPMpEr/q4tRZoZNDcyRFuP3kU8SplGs7T1Tlys3v6rK4vQ8zuaCkX3HPmZ9Ky7Pu
         DiTScLoNjhElYPmmvutWVUTVBU8JVP9fEejztjg9mNOrB/s181bAedomWCsgsM9MAwYj
         ndlqOFoPj9HtvkAaYKw9zoaomSvWjtLC4NpcQnzVFPpw2yyFDp0xBpz6aFt8L9NA0x6y
         GOkPHR4b8eH/2/1OE2mmIQfOu3ejAL0w9MV95u6wOkI4RIknXzKd353XWCwj9reXdXaR
         l20A==
X-Forwarded-Encrypted: i=1; AJvYcCUCNFhvluzvKRaVOlzAEyfTnyCpWhJpP6EnTnv9aMWuKIWdtPJUf89gbHKr7zdFC6Cy0x2SpY/0/4n5NjeA2IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJDlRmyYSa8cPmfwK6rPr1/vE9slrzqXOutzKgTydG+j+jbgk
	/irm6DZd1XNdTfgxV4Os5gAT3uYdpc6flqtqbuNYbIV2mv2zULrq9wNkLUgkzsaNG1hpubP33uf
	TaMLFZhVdjtQsNObpHIESsO15X3Ki/16zXdNi3w==
X-Gm-Gg: ASbGncsp3CX7tu9DdFCaJ8JVgy4Tm15zFgCpsw/c0V5Y0mRJtF9VpdPVpV4YATGkHow
	bywt+xAinDvV7mxN5gFK4iyvHIQifNLWJmEJ9qqpPl+mQ7/5c3l6UHylDOsGx3yniXDk47wKGE9
	bRawqMBVy2+D46WrSV7g1YnW8x1HhlOBV1JxDvdrYmNUYiqXIf9QgNfQ==
X-Google-Smtp-Source: AGHT+IH+RK7/XEa6JiT7pqhmb3oGoQVrhP9K1d8JyHBGzCVXdWspuBYjMtak9HjjuGq6re9lqeqvC3BDvp4KpIO5YTk=
X-Received: by 2002:a05:651c:a11:b0:30c:160b:c75f with SMTP id
 38308e7fff4ca-326c46b1a39mr15861731fa.36.1746797612514; Fri, 09 May 2025
 06:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-aaeon-up-board-pinctrl-support-v5-0-3906529757d2@bootlin.com>
 <20250506-aaeon-up-board-pinctrl-support-v5-9-3906529757d2@bootlin.com>
 <CAHp75Vdg2LE885+qjpYLkQrdNqaahJc3=Ki7op=6jJUJfJM+sw@mail.gmail.com>
 <c3b9c494-599e-4d99-8645-589c1c0c106c@bootlin.com> <CAHp75VcKsq5_+uwwVKeq8++H+Rw1giH-TKUErsFmdKPiu5kY+A@mail.gmail.com>
 <2f02284d-2922-4bc3-ab2a-8848023019b7@bootlin.com> <CAHp75VdZuqP_ga_i1=kERQbscu55GFShPK_AhYF1jigoBz8wpg@mail.gmail.com>
In-Reply-To: <CAHp75VdZuqP_ga_i1=kERQbscu55GFShPK_AhYF1jigoBz8wpg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 9 May 2025 15:33:21 +0200
X-Gm-Features: ATxdqUF1PrMyfdLebwhfVKGAVlYVaBvsllsiAwoSwuvvCaSGYfX2F5YWtmxv7uk
Message-ID: <CAMRc=MdBwRMfpXG-bAWTAaiD9E7sRzr5RTfMWJ-2wAryJ-EcKQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] gpio: aggregator: handle runtime registration of
 gpio_desc in gpiochip_fwd
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:24=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, May 7, 2025 at 4:54=E2=80=AFPM Thomas Richard
> <thomas.richard@bootlin.com> wrote:
> > On 5/7/25 15:24, Andy Shevchenko wrote:
> > > On Wed, May 7, 2025 at 1:10=E2=80=AFPM Thomas Richard
> > > <thomas.richard@bootlin.com> wrote:
> > >> On 5/7/25 08:34, Andy Shevchenko wrote:
> > >>> On Tue, May 6, 2025 at 6:21=E2=80=AFPM Thomas Richard
> > >>> <thomas.richard@bootlin.com> wrote:
>
> ...
>
> > >>>> +       /*
> > >>>> +        * get_direction() is called during gpiochip registration,=
 return input
> > >>>> +        * direction if there is no descriptor for the line.
> > >>>> +        */
> > >>>> +       if (!test_bit(offset, fwd->valid_mask))
> > >>>> +               return GPIO_LINE_DIRECTION_IN;
> > >>>
> > >>> Can you remind me why we choose a valid return for invalid line? Fr=
om
> > >>> a pure code perspective this should return an error.
> > >>
> > >> I reproduced gpiolib behavior. During gpiochip registration, we get =
the
> > >> direction of all lines. In the case the line is not valid, it is mar=
ked
> > >> as input if direction_input operation exists, otherwise it is marked=
 as
> > >> output. [1]
> > >>
> > >> But in fact we could return an error and the core will mark the line=
 as
> > >> input. Maybe ENODEV ?
> > >
> > > I am fine with this error code, but do we have similar cases already
> > > in the kernel? Do they use the same or different error code(s)?
> >
> > I dumped all get_direction() operations in drivers/gpio and
> > drivers/pinctrl and returned values are:
> > - GPIO_LINE_DIRECTION_OUT and GPIO_LINE_DIRECTION_IN (make sense).
> > - -EINVAL (for example [1]).
> > - -EBADE in gpiochip_get_direction() [2].
> > - regmap_read() return code.
> >
> > But from my point of view -EINVAL and -EBADE do not match our case.
>
> Hmm... I believe we need a GPIO maintainer to have a look at this.
>

I went with -EBADE in GPIO core to indicate that the underlying driver
borked and returned an invalid value. I'm not sure if this is the
right one here. I'm not against using -ENODEV.

Bart
