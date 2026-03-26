Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141931ED80
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552668; cv=pass; b=tB09bwo64tpM8qviaJJB9GC9Tgokt9vnUbpJ3XcgbM+0al6otmCZcQOVTy7qBHUr1RdZlp696JEEVhzw9euD4qR99yxP5So9gv7g8dcqw0aT5T9KCZVgS9GAm+xKrVpMJFlz7rWqYimuVjZNJUYV2NOd3F2Ds32KOppAJyrHQNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552668; c=relaxed/simple;
	bh=5nrGZTbAT14Bb+EWmgrupuzltdQ77wCJq78VUhn+Bv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKHl4+UG3nl2+pGB8izqE7AX6mPdj+MuKsg6wMn4EFBDnqj/PUbA97Mjb/JQExR5Tf1hOlGhcRBkUXluTqVyq60MnZPEVxDPxY1E/wlyOj5NtSZZ/BfLU1xld04obfh5C19rvr2HAYmi/p7/q5yD7jFbu/O9SCD0HfVWeV5gOSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0Xqy5Rq; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0Xqy5Rq"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66a851e62c6so1413076a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 12:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774552666; cv=none;
        d=google.com; s=arc-20240605;
        b=iCGrMcF3YowzFgXdsjyzAeLCwgF3zi9G3F6eb8bkCTWIOf9Nn1shWZlVxs0gTH8/8v
         vWXpFJzFJaRRjQJLNV8Tsx9WeeN5ZSH+OMpHk9ao4F7+AcucCiq7mvXu1u6hFu4GDDBI
         Kted1wCMuoGVEdQUDYXOIlrLnUkTJhZWsVMopGeLNU6QmcJYq1bX9hWqatVvYxQXS6jw
         8a0ygRBSOogklgYSSsp8VQLsGoNcrf2xz/qsppOHWhxFSHzkqarPSyWNl2l5nlPYpLDK
         JndZpw29IwkcKyAGGKqvnnEEmiMDUCftvQn1X2jXuN67Yg1u4Zoh7k7y5XonulEU2yM0
         71fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uo3rm/n38aWrxHsHtkGNbJCQJLFP7vPzOiRzCB4mnuk=;
        fh=toD/4jcZykaoz/g3ak8yG6LkfVPb/5TxESfknAArNvA=;
        b=bXIES/dhbcyOxOPE1lEJ5W76198ivrGB7j5R2RPVCfixvav/hZADEknp8jKZamBBPK
         8JaqdwO/zkiji0XSb1eaZeX+Xi4Qo78PCKKLcl20bt5QgdaK2LwzTjcsUcllwehX7lT1
         SBT6rboEmbUiqqt/XoxDzrWIDA34KDFucFusRzdgVKiSaTRitBnnjTHp2AL+plIc7MUH
         pf4SGR3fWWaGXFeeKSkywDAwi1dVp3iXn6aA/dtnEDFbsYVCCnP+ZK+qvqMpgKTudvP2
         aKAmAainOYz+iY+WhwQ7dxjVNzwdjq2meVNvEFzMAGA8P4rTgWejL8hW5siNnZFX11RM
         kJqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774552666; x=1775157466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo3rm/n38aWrxHsHtkGNbJCQJLFP7vPzOiRzCB4mnuk=;
        b=L0Xqy5Rq5aAGLxkdxasFAl9qXTDJX0WKOsptxFZw0a9eu5AV8kUa5QrnG+8mWeXchP
         H9FBjeCl5tf2RDWjVKSOQs8ztoxPgh5zrjQsUa/znSvF95Anz+6mbJufJ6y+JECaJFCT
         NuuMkRJq9CaRfdR42i11mFTK4RqjBZY42d4jLNQBRPyYXRvPJ726NDA/2AE+UCKjP0dM
         dBF0Ztp+SHrYxNiXfzFIZhzkAa6vHiHgVlRKc/dTJFDLU/K3wvdiuXaHV/6/igfTn4S1
         VmBXju5+a1+rLTxaAtsZQQDWMLKOlGDc6dMZcDC9kHqdO+JX5bIdwK9iVO2+z/bpVHvH
         iBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774552666; x=1775157466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uo3rm/n38aWrxHsHtkGNbJCQJLFP7vPzOiRzCB4mnuk=;
        b=BpsFRx61/C7ASbf+LfEogezrNju4h5IRqwDlFHuoq0jco5sBLyA+hETngmvtAsthN2
         BN2nDKJFMfLRk1rpAA49XXe3LQtLJkjOxbN51+sBN0SGZ731wYqhKbhuRdM0SOM70a0s
         vQTLF0JWY14Q2PBK7EtoPGF43p815/beASpm6ZdQm8bSjvRpGfEgAq31cBlip8uij9Lk
         oz2NVclNQ/Avoq5kfbTwE1H5wikhYRWAQoiVAQIpxsM4osoTaBlZQ9ZxTfN0zJZ2fuvK
         RMMEiRHjcCNQPujmxOV7y2cIZdvOAOzuliNhPE92sfwGM/znUUsOO/+JXW1BnKrWp5MG
         0qUg==
X-Forwarded-Encrypted: i=1; AJvYcCUGfZRi9RG+nJDzmHbObYPCwN5wv/eN0k6K1bgXqELyVT3xPEdDo+HXXpK6KTqWP3E+Iz6yTy7w8UsqGhakQ9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGmLqwIu1klpQR3MIg1nw4ooaAXz+XEIoHDvORJjZsQTG/E6i
	DoR2W4nNvNUdhwayEJn0Xvl90zExXnAbsLeiTOFroQOFAY47L4c0QuYr06/PGryzvLmvU+b0BQD
	LomxM/M3il9sszGkLErVxmxF0ErMSz9HFod7q
X-Gm-Gg: ATEYQzwFv2ap1UhIZmXCY1OKsWrnl/rR0dxiKF9R1RP0i3T7OIEvpIywGxCCWdkywyb
	xgDWXb0WQRTKGgbkR1BgvqoeK7ht1jdSsRpj8+F3Z2m9F5JfK4b4pNglC6PoqoavsfOxKb1jsmu
	AbhCfVN3di5gX0Sra9038/oqsFIGtrU9REvO5YjBjcJqHoApoITgN8wVZArUqmUv3+SNnLqZsRQ
	n8McrY9BNe9NyM7jZK/buixVN7Sp7HWnEM3BJRNiJbPFT5kTTXrzn/SrzfhNIOEgV0vNoJFHSES
	ceAtu/dYPU9Wy9Aimr1Y7/1Zby5SxYrApK1c6VvbyxUBci1IMSnoE1Q7m/r91VfQe7qWByqqE2H
	HZXn2Bg==
X-Received: by 2002:a05:6402:144f:b0:663:4bea:c74f with SMTP id
 4fb4d7f45d1cf-66a826e2bb7mr5965349a12.17.1774552665417; Thu, 26 Mar 2026
 12:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326044725.234216-1-rosenp@gmail.com> <20260326-pastel-monumental-bullfinch-44df90-mkl@pengutronix.de>
In-Reply-To: <20260326-pastel-monumental-bullfinch-44df90-mkl@pengutronix.de>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 26 Mar 2026 12:17:34 -0700
X-Gm-Features: AQROBzC6rvGDUcbQXKjCwtaQKfb6kF2DCW-Rf5DEt4FIHWvKvyc55WOeVTo30RM
Message-ID: <CAKxU2N_0EJfv4EHyLbBJsn27Hui9U3SvaZ_bnbcnmAx8=mZAvw@mail.gmail.com>
Subject: Re: [PATCH] siox: use kzalloc_flex
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Thorsten Scherer <t.scherer@eckelmann.de>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:KERNEL HARDENING not covered by other areas:Keyword:b__counted_by_le|_be?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:22=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 25.03.2026 21:47:25, Rosen Penev wrote:
> > Use the proper function to allocate a struct with a flexible array
> > member.
> >
> > Add __counted_by for extra runtime analysis. Add counting variable
> > assignment as required by __counted_by.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> NACK - What's you motivation to do this?
>
> > ---
> >  drivers/siox/siox-core.c | 5 +++--
> >  drivers/siox/siox.h      | 3 ++-
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
> > index 3e8f3b6a4555..b87e2a12d640 100644
> > --- a/drivers/siox/siox-core.c
> > +++ b/drivers/siox/siox-core.c
> > @@ -689,10 +689,11 @@ struct siox_master *siox_master_alloc(struct devi=
ce *dev,
> >       if (!dev)
> >               return NULL;
> >
> > -     smaster =3D kzalloc(sizeof(*smaster) + size, GFP_KERNEL);
> > +     smaster =3D kzalloc_flex(*smaster, buf, size);
> >       if (!smaster)
> >               return NULL;
> >
> > +     smaster->buf_len =3D size;
>
> The "size" extra space is not used for master->buf, but for
> dev->driver_data. master->buf is allocated in siox_device_add().
I assume this means a new struct member should be added and
kzalloc_flex modified to work on that.
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
