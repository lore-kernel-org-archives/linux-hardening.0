Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664FE3FE64B
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372584; cv=none; b=HjZYAezZiuspalb9l+2WAqWv/jhANRjRCAbBHyEDCahgl39ngUcuyHWqfTSK2A9dtK4ediXeL1c73ZRaNoy+fkidThntU0Osm46FVdC0oU67S7KliOju4K0q0C5w5l6/g8zJEJ+5giqYvnrrahvTdnL0xBaiQpJhEAo14ffnj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372584; c=relaxed/simple;
	bh=Fj+AtXhBM1UOR856IjycUCEf95rf/PY2qAG7I/xx33U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWju0iOO8YTgXjBIb3XzRWelROC1Y0w6L/Nr3CMdqr1q1IGk8crgTuxXV1fQeSc7+9aLvr0jy8Hy6Qfw/42dFk0uJUQJsgSAk8e53mLGhq5Ahgz90C4c5t2Rqe17K0xnxW9XwqNNdoOHuPVjXR5ATkNhzOKhz5+ehPw1Ma5lTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By1JhFF6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By1JhFF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CC9C4AF09
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774372584;
	bh=Fj+AtXhBM1UOR856IjycUCEf95rf/PY2qAG7I/xx33U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=By1JhFF6eSxxHrRMCeYC4Eadk5Ls7EHIMYc4kYWz5XGUM3mcGWS3LbU8MmEua9Js4
	 QnedlBd8TGZpmulnSu2k9kWz31ybaQVTD/B7hR8EMSAy+W7Kzo6PNHTzEy3XWBTSGj
	 ILK4Q15BeaRMXZMO92W92oI0uDqGkEU3jLFMZs0V8khqb09PGMEiF/CRvx6r864Ke+
	 qSOm8CzIgGgncBDnaT+pSi9OxjA0aGYIzzSlGdvSVVIEazlJyMm1Xll4REUzym59YC
	 Q/tBBmoEIeeSj0pFG0MmjXfJ53kl6K2a+bH+FCFcwJ8AXUZjVq0Z9+0MXAQUU600gc
	 3Y2JcdPQDcfMg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38bf132993dso12950601fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 10:16:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh7uakEpKkhmry6XXxghTJGzs5xYnBDcrJR+jj6xIOtlJ+k0zslw8NXDtNukg54OmNzPmTER2zp55VbB2sFok=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+N9330bbuXmSaHjJAVXZa7MShNyo8B5EyKpUg+Vl72oB/itb
	kBUFfv9x4X39Qu9kDHCxFkMtJynMbqRpeqjApvnVkMR2CERlk53DDRvWV7EDGE5Cevowd9x0Wxw
	NYDO5WImg5X7IapcYGIFkG4voB41xJIlfZhPmzHt+4w==
X-Received: by 2002:a2e:2e06:0:b0:383:282b:7ac5 with SMTP id
 38308e7fff4ca-38c431bdb22mr505351fa.25.1774372582937; Tue, 24 Mar 2026
 10:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319000558.22108-1-rosenp@gmail.com> <202603201104.8D7B8A1@keescook>
 <CAKxU2N8ZZp5fcCWfMaqZ9VKwNQ3a06fsQPXpBQa-d1N07zPGng@mail.gmail.com>
 <CAMRc=MctGTeqBHQ8zaQ7_2YAoWoTUxOK4_hs+-EHEQEPnz+A-g@mail.gmail.com>
 <CAKxU2N9KdziPen9-_gfe0UZjyuMTOsbb583aeF3=kqm22rGieA@mail.gmail.com>
 <CAMRc=Me2RLj-vvCVNho9CPYVwsQHypC_KvKHJWkLyj=rMkfx2w@mail.gmail.com>
 <CAKxU2N8gudRXR-bLMoyDVDuv3vWuzqrbyVsHL=Gu3mDZWMvs6w@mail.gmail.com>
 <CAMRc=MeYoDB1QsgckNH9OGWx=WJZofMHq+zL4xY8VK+rzP3gog@mail.gmail.com> <CAKxU2N80Qf+Uc_daBSxjz26e54fAz8bLRPVZYdCcaiHhpfHK-g@mail.gmail.com>
In-Reply-To: <CAKxU2N80Qf+Uc_daBSxjz26e54fAz8bLRPVZYdCcaiHhpfHK-g@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 24 Mar 2026 18:16:10 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mcv1TW55R87xiuAOQShX1Tjf_=BkwfoXdDN8SfUK=a5GQ@mail.gmail.com>
X-Gm-Features: AaiRm50VUxNmgBJk1Sm41yzBCFZNXDJcscr6VpBVck3WnRLwtXJr2JQpzTHu8MQ
Message-ID: <CAMRc=Mcv1TW55R87xiuAOQShX1Tjf_=BkwfoXdDN8SfUK=a5GQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: allocate lines with main struct
To: Rosen Penev <rosenp@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-gpio@vger.kernel.org, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:56=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Tue, Mar 24, 2026 at 8:54=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
> >
> > On Tue, Mar 24, 2026 at 4:52=E2=80=AFPM Rosen Penev <rosenp@gmail.com> =
wrote:
> > >
> > > On Tue, Mar 24, 2026 at 2:16=E2=80=AFAM Bartosz Golaszewski <brgl@ker=
nel.org> wrote:
> > > >
> > > > On Mon, 23 Mar 2026 17:43:00 +0100, Rosen Penev <rosenp@gmail.com> =
said:
> > > > > On Mon, Mar 23, 2026 at 3:00=E2=80=AFAM Bartosz Golaszewski <brgl=
@kernel.org> wrote:
> > > > >>
> > > > >> On Sat, Mar 21, 2026 at 12:00=E2=80=AFAM Rosen Penev <rosenp@gma=
il.com> wrote:
> > > > >> >
> > > > >> > >
> > > > >> > > static int gpio_mockup_probe(struct platform_device *pdev)
> > > > >> > > {
> > > > >> > >         ...
> > > > >> > >         u16 ngpio;
> > > > >> > >         ...
> > > > >> > >         rv =3D device_property_read_u16(dev, "nr-gpios", &ng=
pio);
> > > > >> > >         ...
> > > > >> > >         gc->ngpio =3D ngpio;
> > > > >> > >         ...
> > > > >> > >         chip->lines =3D devm_kcalloc(dev, gc->ngpio,
> > > > >> > >                                    sizeof(*chip->lines), GFP=
_KERNEL);
> > > > >> > >
> > > > >> > > But this begs the question: why add nr_lines when ngpio is a=
lready part
> > > > >> > > of the struct:
> > > > >> > Maintainers for some inexplicable reason want an extra variabl=
e for
> > > > >> > __counted_by works.
> > > > >>
> > > > >> I believe what Kees means here is: you can use ngpio for __count=
ed_by() like so:
> > > > >>
> > > > >>   __counted_by(gc.ngpio)
> > > > > __counted_by doesn't support nested variables like that.
> > > > >
> > > > > drivers/gpio/gpio-mockup.c:59:61: error: =E2=80=98gc=E2=80=99 und=
eclared here (not in
> > > > > a function)
> > > > >    59 |         struct gpio_mockup_line_status lines[] __counted_=
by(gc.ngpio);
> > > >
> > > > The following spin on your patch builds fine for me:
> > > >
> > > > diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.=
c
> > > > index a7d69f3835c1e..9427ab8c45f73 100644
> > > > --- a/drivers/gpio/gpio-mockup.c
> > > > +++ b/drivers/gpio/gpio-mockup.c
> > > > @@ -52,10 +52,10 @@ struct gpio_mockup_line_status {
> > > >
> > > >  struct gpio_mockup_chip {
> > > >         struct gpio_chip gc;
> > > > -       struct gpio_mockup_line_status *lines;
> > > >         struct irq_domain *irq_sim_domain;
> > > >         struct dentry *dbg_dir;
> > > >         struct mutex lock;
> > > > +       struct gpio_mockup_line_status lines[] __counted_by(gc.ngpi=
o);
> > > You're using an older compiler. This does not work at all.
> > >
> > >  *

Indeed, sorry. In that case I don't know what Kees meant. I'm fine
with a new variable.

Bartosz
