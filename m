Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1E2264A9
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773019655; cv=pass; b=HEkqkkfXTYZP8hsoejVxDs0yRDLR45fNpqArkKsSJ8F0VmaEsVAbPOCmeGn5Hz9O2by2REep8V4k2FevtxkbCkBhSfCC33YhQdr3D7TDs6Y4KhJVUuPUpiFiqN4dI//NX/KCakLm0K+xoxwK8OR4Vb9k1mHQio3V2ss/p7dcl3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773019655; c=relaxed/simple;
	bh=J5WOQGgsBgN0mzbAGAd4BjE3fxkas2mV2HC7lbTpC0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evR4nbOmND8aNxNFZe6PTQ2UMtka/ktrYmacS8IsmXL2m6bNXgpxlu3v5B8MP0ePRRRIy/bW1a6W2vWsO7geqYaerZtH05y6v32rysATvKDwHnRL2P49quJ/tngmGW9qaeeYiaGTOhJArPTPhY1chjKVmq4wEec8DSBFKXc3cg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExDbpSyx; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExDbpSyx"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b941d924534so338413166b.3
        for <linux-hardening@vger.kernel.org>; Sun, 08 Mar 2026 18:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773019653; cv=none;
        d=google.com; s=arc-20240605;
        b=XAGLGzXQQzIfQZbbGzsad7OOb5uKpguvHHkXdwmTck0MpJXxXlM3S2F+UvSXXL8Pwj
         rbZ5X5iUt034xvQX86oGAl2wzC86BaHJ/I0t6vxuGeOWVL/6EMJsLlKHYhN/f3CmQNFW
         yvus6oB+ThQFfjARij9EW8rR2F8YcH5PwThRwoZA6PvL+iPQVweaufk1PjMIkhKYeO5O
         2nWra3aW2wRbVqvJnL8jlwIoO87i6qFl5vjvOJ5C3xxVfA4VnnQr6ZSjAG/V9EtJhlzp
         /Wu5f1ltkphaEw5CiRsMMWtpfSEv8Wx/asYYdqxLz+QxgtR8aY4QJc100WXrPXRRS5s/
         8c+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AmrXqlRa6XqcxgRZeLfPo4HT+SM6fCIjFFPpzWuCXEI=;
        fh=mUkHjCB2vpfAqMJ+uAodLjoe36I2mrY23/WGag5Q+Vc=;
        b=jphFCPd9SCziwyJKVq0Qp5No+tH88+I+ys5O3nR9ody7+q0AHddteqPkWXTKS8OstY
         J54dZb4zNw3x+bSAhnTPEPw754J1CDfazhf4OPTK0N6XdALLVu4LXmxx91HHU8lfrLIE
         7BVUU6JO/chOUH5OTig1EhgGsmPpdw8HBrBbWPBJsaxm5NYdtPEPQ5PjbqD2SsgXPrvE
         kyqr9qkxIXSHjZbdova7j04p6nuhxFCUk1yMCt0VcC1rreiRsFaqzWbwTMjaVr2nNocR
         BMNkldRnLEYqhiavLNn1pU1qiOmZ/I3rKwvsHgUD9Vab8PoURDjniPM864JCagwoIGBX
         XPKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773019653; x=1773624453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmrXqlRa6XqcxgRZeLfPo4HT+SM6fCIjFFPpzWuCXEI=;
        b=ExDbpSyxPuV+FqE+rIosW5MEfnry+p/87P7V4Mfv4FJh95wUHRKzkG6pHdTFplNTLG
         pRmO9rCTizoGZ4EpRPeUKKDo0WlbIN521fDyERWbmaKjH3Njh0S4cBy71iqQlf6WtG0d
         5A4BvRSqflZYNRWR0d/b+vXmPo9CCQpTKezPOT2A/xjH6h7SsIhcXuLqa7fF+oqNYP9p
         xfYTIyZgCJ/EaH579/Y6WxUTERLat+uzBTZHGD15VAxLsIJPoKE42ebuoCpyqf1UJjOm
         JKCm620iLESDvQJ3xBmKQKzKvH4iMPO5VIZXtRWzWfwPcBQ7NqlTfZylsnk2cfWnA8Jp
         zRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773019653; x=1773624453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmrXqlRa6XqcxgRZeLfPo4HT+SM6fCIjFFPpzWuCXEI=;
        b=LW0SIGuaG81iRYrgGYhGMbiZtoDdotfaw/Ls6aiKMO0r6o88e/SIC/FE9127f3U/Aj
         xUuLcbJZLJknvmyZFSehyb7QsLFxO5jRlKsUptnd9TYN3MswJWwM4s5iymmC3bML2Qke
         BAPy3cqBhmASTW96HjrNhdRQ/+xiqxJFjSR4WOl9TOxkyUbTnV6mEmFnTkzaXgtSvqVV
         1OEjt1mqYWcy2B8IoHGgaUGuoT58gDrJjRNG2RE8Rdw6c23v4M9ieGCND49SZ4rwSe6F
         dE7ieaobEXllP8OIWa14cykZojb6q78GiTqDOFwE9fWFms1FEEQCM0SngLPryHU5BXFL
         Vn7g==
X-Forwarded-Encrypted: i=1; AJvYcCWm1r7o/lACQz19GStScyYuXP5q9KDDwdCwzC1ByMnWAOLBgVh/xts1xVcB86aRZKA73mcv8qIe9liLq0ohkDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhY5GkAPgcNgTinMoVoGV5x3/syHvopKOqC6kodqFDoCLshOMk
	hIXlqgG1XQrC+Tc3I1KT1mYLQVKiDHOr9jI+Z43ygjfFWqZ5MBYkjqIbueHIpodTxtnqHerSsWq
	fGuYLLAAPsJPwZqqHAZ35vPpB/2TePSo=
X-Gm-Gg: ATEYQzx8SHTAhRn3Gstj5CFS7Ccutm8YRovN+0Ab89iE91UOC4g+YE+hxD9UBworjXl
	GnbUzsyWGb3S+5U+wqpXrz/4iHqGQu5Lyrf6MIXInU6qw68buW9eIav1Rd25/UfdtEq4UpTsvKk
	ksqclaJQENUBzoL+EngT86o0VNFafqnFSndxil3cEyA4XlHjCpIAAHr1wBkmHdnawAD8+FbXbLY
	uh/AsxggHQqCYVvDkT7qa6xa2AGFuMOL/IHfUKLm78ECoD3jhmlP8ye8W2PyzPp7f7oaHM8Q2N1
	Y5NJiGB6hMuhXZRfvPQuTOHWMEKhSFYThr62xhVnPsd7JsYBZ6xWpF8K63V0w+RuVNMwycP8zr/
	eyTD6//dxqcJPgHr5
X-Received: by 2002:a17:907:a03:b0:b88:5bbc:3658 with SMTP id
 a640c23a62f3a-b942e02cf9dmr525408666b.52.1773019652375; Sun, 08 Mar 2026
 18:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021535.48098-1-rosenp@gmail.com> <CAD++jLkLj235Q=U_9E-hSneW5E42JjU=dRBJxKJNnqwgBLCm=w@mail.gmail.com>
In-Reply-To: <CAD++jLkLj235Q=U_9E-hSneW5E42JjU=dRBJxKJNnqwgBLCm=w@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 8 Mar 2026 18:27:21 -0700
X-Gm-Features: AaiRm51DHUN2l4LTGqNpI9x37mFL5UP6Qa3rL8znqPALUSc2sV8jWzO7K995iBA
Message-ID: <CAKxU2N9JbAzEYfmLpbw5b9Y6MsYUZ1FfLirfy8Hg8MCOUY6PAg@mail.gmail.com>
Subject: Re: [PATCH] gpio: msc313: remove kcalloc
To: Linus Walleij <linusw@kernel.org>
Cc: linux-gpio@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>, 
	linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Romain Perier <romain.perier@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	"moderated list:ARM/MStar/Sigmastar Armv7 SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 5:06=E2=80=AFPM Linus Walleij <linusw@kernel.org> wr=
ote:
>
> On Sun, Mar 8, 2026 at 3:15=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> > Use a flexible array member to combine kzalloc and kcalloc.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> (...)
> >  struct msc313_gpio {
> >         void __iomem *base;
> >         const struct msc313_gpio_data *gpio_data;
>
> Do you wanna add:
>
> const unsigned int saved_size;
So in the code there's

for (i =3D 0; i < gpio->gpio_data->num; i++)

which is equivalent to match->num.

__counted_by doesn't support pointers AFAIK.
>
> > -       u8 *saved;
> > +       u8 saved[];
>
> u8 saved[] __counted_by(saved_size);
>
> >  static int msc313_gpio_set(struct gpio_chip *chip, unsigned int offset=
, int value)
> > @@ -631,16 +631,12 @@ static int msc313_gpio_probe(struct platform_devi=
ce *pdev)
> >         if (!parent_domain)
> >                 return -ENODEV;
> >
> > -       gpio =3D devm_kzalloc(dev, sizeof(*gpio), GFP_KERNEL);
> > +       gpio =3D devm_kzalloc(dev, struct_size(gpio, saved, match_data-=
>num), GFP_KERNEL);
> >         if (!gpio)
> >                 return -ENOMEM;
>
> gpio->saved_size =3D match_data->num;
>
> I know it takes some bytes more but it feels way safer.
>
> Yours,
> Linus Walleij
