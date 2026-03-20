Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24542DF156
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047619; cv=pass; b=jTgPBSA0juBsWkWbmhRYFktOPYpMyAqqpUuVNxaWJcN+G7UzV3Z45frMqPxik360oFAIXXm529V0qn0Dyw81rP430oARjeRiNoR+h56+BIsQqKJtghPg00Sp7ndFxfhS9ql3tQvjCU4na4NP+6+iUOSh2locu6jfxYBMfX6rzvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047619; c=relaxed/simple;
	bh=mv+mEa8lYPVTeU4UjW5mpF2vNDEGKAmCTJPdr0jAXo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSeoIisYVayNufBMprfWT+a3Lfem5HVAFv6pKbUAQaK7plLayzupiJlr1adEvkFiw0MmBlXpgDLjbcihDYkp++ciz80fsvKkOolrUGtF7RlK4zaAj2CE/96YkOcGW4izTSMf5DaPNCdwYokq+rk0kdxm0QBaBjjADKjl4NFP1Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUXTnEN3; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUXTnEN3"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9358bc9c50so310978566b.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 16:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774047616; cv=none;
        d=google.com; s=arc-20240605;
        b=lRW3XsgsLNI6DCHmFDjfFmJbGxAfAz2k7WIxwSUBnQ4pl7MU9ZgaNowKRpy9ryH0AK
         O6el1wT9DZ7tALF1lBhnR/bmpA52LT5FXWt+OsjllE+qcaNYrLR1M1CeeJdJvkpy3SUC
         KPNsFTdVLZZXer/17iGD6+CVcZKd74zSKlrf/sdWJT+16vuYY7TGxhUDhMTt1WXnX1oz
         QMnHAD9clKPQtnVea8e6s9mUC81SxmNFIcHp971Jhp2nOG1kBEX6B0EzzpcV1dqMPDpS
         91J5d5fw1njvEdZODTK3Wo9VGjReVGYt26g0wrs6fsJaFeI2xPKxnDobx3N/NZd8T8S3
         RV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pAWHlHvrO0epzpavXwEL2ZZmeMxmfsRjc8R4FrsxYJ0=;
        fh=MEJEQPiXa0oeQlaiTDPa5LxSZ7cqoN31YMZyi9ogj3Q=;
        b=O2J6Iaz+VWT0Iw+biKgF/+LbrhmaybmWcQwxhTibjAuN8JazYQSp4MRWK1b8lYbZME
         vfbMAsUZ92y711qONk6YtZpY1fV1MMkHx+pUXx+qyn9QsxYJblOfqqjtpBgqilPvKq1N
         aYCcme+k+82mguzjOv1KLDRqRfXZ3mNoa1F7Eoq2KjdvrUo8h+zeS8Ezcm5k9qJ4iS/9
         Jlh3nI9pvUMDU6ZO5yWaWnr6cZGwai37CuMGOw2B4W7mlXHzrF0AclsXG31crZx3ndG5
         hoOGbS80/cpDY6wFi3HRzIXUJhEFV93Ll68m+ePGWPvd3IlZ3EmEKpG8fXh/dK5f9uoB
         u2kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774047616; x=1774652416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAWHlHvrO0epzpavXwEL2ZZmeMxmfsRjc8R4FrsxYJ0=;
        b=LUXTnEN3Qk9unsOn8b98vV3YnIWZZahvBT19hYJeUIoOJE7ale37jOHvqU0eMyRG6+
         mXC0mrTN/WODNjA0BXLS9d/OKuyENOkVZIKgj3vweFGIMr7010/M6bZ8CZa0cMrcmYPZ
         M2GajskBhhSCkQDRBCdbE9NgrG+0rkNhMGQEqW41/gTi4AmLQP6MnyRWukEnfFNUL5cH
         ubnSYoTw3s3/eBXie8g6zZC7YpDcMpY73+rcKdcqdf2HhtC1ELdHmmNJkwzL0vXUbknu
         ZIZVv0uDkAlnl43o1a1cAuWrygNu8rxsk1t0PKXD/E8XBOLtJ5+BlKmM0HXaTJp5F4bA
         fLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047616; x=1774652416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pAWHlHvrO0epzpavXwEL2ZZmeMxmfsRjc8R4FrsxYJ0=;
        b=GQd14z48T2MsL62JJE2ra+n90u1sABded0Js9l8w2ySIe6UwtnRvK6fJ+Q/jcEyfz5
         rfJ9lhGm5gXdhdnjiozwibH8HZswoqd6TBC5CgC+DthZE/DA5vC2RSj9rNqmMgpe+OHs
         nqXmzuDaPv7yUJQgGbT3mqFyvVDQM4WyK5U5RyEK0+x/Lh5Hp0bEt1GiOLECyA8tpOJk
         iBDf39CuPER07w39IsY8LfAnL8b9XyQ/2e7CYr57ik4zrgrPPq3cWYWXHVE6KOdkdkxQ
         1riTKwT3BAJw8DZppGm8QPljm9DkM48qYZ7s/XawvxnezBNXj1AuBWuaSUxUXoj7cakZ
         zH+A==
X-Forwarded-Encrypted: i=1; AJvYcCXgzY1fzGWt8p3op3MDFJgRf8i4Ms+4lQtoMOyKO7r0SOl8Dh1tHIvzdOXzLS8Pvl/2yj54cjJEKc9HJkV8vuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRc9zlUZZyMYx7KOTyU+Jgy1NxyLcN7NiBVyN/ULubcyxgAOF
	E8jPb2RcQ1mZAOjx3lvPxXIJNTejaZ4CenFSfpotnt0+d7rVRxqmM4wcwdgn3oYMo8I5plnS8DA
	zpT5UhjU2y5Tu0/wSj6f5fj4zoCz3Shc=
X-Gm-Gg: ATEYQzxJfxDbP08R7KY+w0mb26qJu2AHmQn5+ye4grkdiGYPwrgRZn76iGEwYMdUwwb
	EfPZOjvBvpyALR7lONoOITDM+wN6tokgM3z8uVMjQNZfhFBJcVbyGmP8+/v/7VtB5N7N5X5wHA2
	Mi8nwFwxDbqFcsw710uPG1XCir9gwyyxnkh/4kO3HTI6Ku2QomVlnN/x/vv4Mxq9FCA/4KwWiSN
	30JRDMC1sCQaw+lKGFqR33wEE/qUOsm2Xuv++ipEHVW91E8RewRHHAmUudfIj7YQEpgZGL1Xn6J
	LI0V/Wy1sAHX/9LADq+waxYb7y+6s3yvTe6vdPuM42aZDRGkx0aOZoowA2ahUgyHMZW+m+lbdm7
	wjDkGdg==
X-Received: by 2002:a17:906:490:b0:b98:e4:6d1f with SMTP id
 a640c23a62f3a-b982f36d94bmr279801466b.40.1774047615630; Fri, 20 Mar 2026
 16:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319000558.22108-1-rosenp@gmail.com> <202603201104.8D7B8A1@keescook>
In-Reply-To: <202603201104.8D7B8A1@keescook>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Mar 2026 16:00:04 -0700
X-Gm-Features: AaiRm50Lq9aViRrhhRsDErlXez4p8-8WBaip7HhoqPszk6Y0R8DvNbHvdtxBwA0
Message-ID: <CAKxU2N8ZZp5fcCWfMaqZ9VKwNQ3a06fsQPXpBQa-d1N07zPGng@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: allocate lines with main struct
To: Kees Cook <kees@kernel.org>
Cc: linux-gpio@vger.kernel.org, Bamvor Jian Zhang <bamv2005@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:10=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Mar 18, 2026 at 05:05:58PM -0700, Rosen Penev wrote:
> > Remove no longer needed kcalloc to simplify allocation.
> >
> > Added __counted_by along with a counting variable to get extra runtime
> > analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/gpio/gpio-mockup.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> > index a7d69f3835c1..a907ce28cbbb 100644
> > --- a/drivers/gpio/gpio-mockup.c
> > +++ b/drivers/gpio/gpio-mockup.c
> > @@ -52,10 +52,11 @@ struct gpio_mockup_line_status {
> >
> >  struct gpio_mockup_chip {
> >       struct gpio_chip gc;
> > -     struct gpio_mockup_line_status *lines;
> >       struct irq_domain *irq_sim_domain;
> >       struct dentry *dbg_dir;
> >       struct mutex lock;
> > +     int nr_lines;
> > +     struct gpio_mockup_line_status lines[] __counted_by(nr_lines);
> >  };
>
> In the cases where a new counter variable is being added to the struct,
> I think it might be better to have those be unsigned.
>
> >
> >  struct gpio_mockup_dbgfs_private {
> > @@ -436,15 +437,18 @@ static int gpio_mockup_probe(struct platform_devi=
ce *pdev)
> >       if (rv)
> >               name =3D dev_name(dev);
> >
> > -     chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> > +     chip =3D devm_kzalloc(dev, struct_size(chip, lines, ngpio), GFP_K=
ERNEL);
> >       if (!chip)
> >               return -ENOMEM;
> >
> > -     mutex_init(&chip->lock);
> > +     chip->nr_lines =3D ngpio;
>
> Besides the new variable being meaningless for negative values, there's
> a strong hint about its type even from the counter used to perform the
> calculation (u16):
>
> static int gpio_mockup_probe(struct platform_device *pdev)
> {
>         ...
>         u16 ngpio;
>         ...
>         rv =3D device_property_read_u16(dev, "nr-gpios", &ngpio);
>         ...
>         gc->ngpio =3D ngpio;
>         ...
>         chip->lines =3D devm_kcalloc(dev, gc->ngpio,
>                                    sizeof(*chip->lines), GFP_KERNEL);
>
> But this begs the question: why add nr_lines when ngpio is already part
> of the struct:
Maintainers for some inexplicable reason want an extra variable for
__counted_by works.
>
> struct gpio_chip {
>         ...
>         u16                     ngpio;
>
>
> ?
>
> -Kees
>
> --
> Kees Cook
