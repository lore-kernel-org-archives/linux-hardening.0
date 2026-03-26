Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC823328E6
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551893; cv=pass; b=JcgI21k6Jb3r5BY5b6uhZXs3xioLcySMWYOk6V3UI6Uuqw02vDRFOU2QeKpW97KPGjd54uKm/A1aq7pBe/dy4Of6o6BxV69QPI8wOPfvyUs1cil0Rbm0avQLR7/wnmVRRyAg/yLVJRjiKIMetE1zGNNNHbiAY20NRD+jKvnLTIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551893; c=relaxed/simple;
	bh=RWTNlpcNdGltwoZYCZGEe+3cY2BbwIINBFwoppx91tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQgdCViByVhM1XKb7inXQIDclIWhY+nGQgLTVN5fEC2UqVw1PzJwryZfDIpr4rxfL4DTPrV2Q35ulmggLpx0383taXA8NC61BxfpgQfYT1PE5f6IaEqSu7Z+eqIO3Md5gv4VdX0VnDUOv/tf/kO0BNApYhWRB8uRDMKij+wzdgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6D+KsVL; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6D+KsVL"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6644a3029b3so2172104a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 12:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774551890; cv=none;
        d=google.com; s=arc-20240605;
        b=dJ5IGqePFH1fJfApSzq1S9/0Yq4e73EifRt/FtbMBgYvnm+0bPpW6LACCnxR+cT/8E
         8YTLana3lmIDbHnJLe29ySKWZ3cPh3HTpGWtTtwI0+wXcs8uv8oofmhthUoaypqPw5B7
         VWipCT1ruwHylLkmo1NpaYpbmMwwCCQD6H5mBvNrjbnTunv8rXDNbNO0giIWvud9ygOr
         gQKDV7CDX7V7CuD7CIYc+XwI92CDt5hz9pHM7MGHJ0hIbG63XUzcM+sS0nGBMrATl4tM
         fCPtggp2s1/YmsOsmknE6DebEUUfM6HP1e7k7z0ovlUzjFP0/Md12FWFtmikgiybGdBY
         YSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fKnBDIr+tRJpkvUEKn0Xd6uLa/KGKg5mcNt/DWZZSps=;
        fh=if0hLnjMGPkZdSqz3RX4sx3DstOcRNPX0kLirRO/EBI=;
        b=hN3HcTgQE/DnEswmZln+lnDLxg1spHkiPNq5j2HzzMGOoERnD4cooakxg5r9VE6tDW
         8c3xnVgIv4DCHzlGzL0nyYJqgMmvXynBALfpIk1V3A4jgKiX4q5nmjfrKsZTUoF8Lztv
         TtazzhakelIcT0L/jF4R9EnDzQh/K1t1wjupnRv6BKlkQd4wsymGPMJsprIuUG17CW/T
         GIZupSKg+FmPhAaKttNk+mS1P5orEVPmd2PVroK0F/ZwzeBpiGteNyseFaJ1r1KXUo8H
         oKU/idPd32v3RJfDp12krNEjz5Eoq3Asd6PLbqtHFrg62qbCsvjdBod4bzV84Da9zBMJ
         UuUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774551890; x=1775156690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKnBDIr+tRJpkvUEKn0Xd6uLa/KGKg5mcNt/DWZZSps=;
        b=e6D+KsVLS1QIdrh5CEWJQDzcyVufTUnY//abIwu/iKYIgcVbGSOGuXfa4R/daKrcwv
         +CEjgB4tP64vpIJSN3AkmkCzFL+i29mixKnriiJqSctxqsh1aVdigeBoIG9JbdZPSpAY
         CCT1IQrqQFuHxr5MxocRhscwtBIH5a79xWr7dRAX2DRFGgwixbIZ2zNIsqftPTNYq9jM
         TnNBHBgp3Rt3XiGLZXCuLnLfvJ85Vq0/siz5tJ5YrjEko6RHpBypBSZm0JV4ZwMVNrcc
         N5tx+sn61+ZRki+0cckfp7/FrXneMCJ9rmM7XW0MNXpvfdGLkYRaWCUepM45G1kq2p25
         qRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774551890; x=1775156690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKnBDIr+tRJpkvUEKn0Xd6uLa/KGKg5mcNt/DWZZSps=;
        b=skfyI/Fjml882h3SdqhaFhOZjJY7V7/9es71y8y1BPUVQBQ/8F7RTXPfsgofxBEZJ8
         xJWrAR5h1nZAhnbUGisWst7Ys4thd0okAHtaKqZLNqz8sKjuS52uYb2tttDJ9bnhLtdL
         UGp0D1AiuU2Cx6EbsiWtyNuJ8fiEhjbYgtj7n6RAIJSJKc9hldMVOkzFPje5eosIr+83
         DeYfc9rAh5srFzlDt4WOMDYcaehmKF3xqS5c1pFAzqfAOATQ1AS2u6zGzf6klUewOTzF
         HrAhoLJa8PT3VhqmFcTnlTkeSo3Mbfksciy6SXOvBPCwSWPFHsHgvsQOg9GjgpXbd/OO
         Ss+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkYfJyBolQJmunN8Ozp1pTbqNRPqMm5P6TZkZLVfhgnmvStg20h+39JQ2X5y7ZT99JWuF/BuUBn7SspsmMAG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjIRLEu2T0jabhzFES87V1fUYNLBxYY1RbpKy1TTCICVEevU8
	hdKvb4dF+7k0lHAXuHuL7BfEVw17q0vF7CMkGmuSsveuwxTCkzEVNIfSMIS397LjyKJXV/yGapw
	JMzoRviW0W5b5aFQ86li49+6aBpq5dkQ=
X-Gm-Gg: ATEYQzzb0ElGMXKYHXNbDZCRQ4UpIQ6VQBSKmm2AqWe61mXQnlP+WbmAHqCbuOJ2gK3
	4M8Ragdyj6G6DDDXS5l/FqMDqW27R19dU4Ajpk8HbpLnnlaRsd0DgAPFNgeK1vEjsq5pgYOlita
	24a4nTARgF3GUw7Q9vKx7B6Nx5VuUPUS5kZ2vZ/noPAkdC1bFlPBV3axtH32wIBXdMZSqz+uSop
	6eSYahaDyEj0EGJbYP8nrwHEZkGgLqaKO6J8un2lOznYnM0u84jevhor7zHT2vR/N+uCClCnQwh
	FvbqTqDhzwwKiDvlbqWYhvYRqYtOnIvvOvyeFfyyfibCf+NXzaz+Gda4G3B8VYtJZNTF6YF/m9R
	s5WGQYg==
X-Received: by 2002:a05:6402:400a:b0:663:d74e:9253 with SMTP id
 4fb4d7f45d1cf-66a826e17dfmr6467290a12.30.1774551889751; Thu, 26 Mar 2026
 12:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320040821.46540-1-rosenp@gmail.com> <20260326113336.GK1141718@google.com>
In-Reply-To: <20260326113336.GK1141718@google.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 26 Mar 2026 12:04:36 -0700
X-Gm-Features: AQROBzCZTyvHiViM7w4a5wnlj7r-dKVubkWrdoEcXDG9mbkTLQ1oPqON6pUOgdI
Message-ID: <CAKxU2N_8BnBETT8YeDa44bDvC_srepskpA7iDYOwPQJsfb0dXw@mail.gmail.com>
Subject: Re: [PATCH] leds: pca955x: kzalloc + kcalloc to single kzalloc
To: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 4:33=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 19 Mar 2026, Rosen Penev wrote:
>
> > Two fewer allocations as a result.
> >
> > Required placing some structs before others as flexible array members
> > require a complete definition. Declaration is not enough.
> >
> > Added __counted_by support for one of the structs for extra runtime
> > analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/leds/leds-pca955x.c | 45 ++++++++++++++-----------------------
> >  1 file changed, 17 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
> > index 2007fe6217ec..ee5f02eaa3c9 100644
> > --- a/drivers/leds/leds-pca955x.c
> > +++ b/drivers/leds/leds-pca955x.c
> > @@ -112,19 +112,6 @@ static const struct pca955x_chipdef pca955x_chipde=
fs[] =3D {
> >       },
> >  };
> >
> > -struct pca955x {
> > -     struct mutex lock;
> > -     struct pca955x_led *leds;
> > -     const struct pca955x_chipdef    *chipdef;
> > -     struct i2c_client       *client;
> > -     unsigned long active_blink;
> > -     unsigned long active_pins;
> > -     unsigned long blink_period;
> > -#ifdef CONFIG_LEDS_PCA955X_GPIO
> > -     struct gpio_chip gpio;
> > -#endif
> > -};
> > -
> >  struct pca955x_led {
> >       struct pca955x  *pca955x;
> >       struct led_classdev     led_cdev;
> > @@ -137,8 +124,21 @@ struct pca955x_led {
> >  #define led_to_pca955x(l)    container_of(l, struct pca955x_led, led_c=
dev)
> >
> >  struct pca955x_platform_data {
> > -     struct pca955x_led      *leds;
> >       int                     num_leds;
> > +     struct pca955x_led      leds[] __counted_by(num_leds);
>
> Where is the memory allocated to this now?
The kzalloc call was updated to use struct_size to allocate it
together with the struct.
>
> Why do we need this in both structs?
kzalloc and kcalloc can be combined in both locations.
>
> > +};
> > +
> > +struct pca955x {
> > +     struct mutex lock;
> > +     const struct pca955x_chipdef    *chipdef;
> > +     struct i2c_client       *client;
> > +     unsigned long active_blink;
> > +     unsigned long active_pins;
> > +     unsigned long blink_period;
> > +#ifdef CONFIG_LEDS_PCA955X_GPIO
> > +     struct gpio_chip gpio;
> > +#endif
> > +     struct pca955x_led leds[];
> >  };
> >
> >  /* 8 bits per input register */
> > @@ -542,15 +542,11 @@ pca955x_get_pdata(struct i2c_client *client, cons=
t struct pca955x_chipdef *chip)
> >       if (count > chip->bits)
> >               return ERR_PTR(-ENODEV);
> >
> > -     pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> > +     pdata =3D devm_kzalloc(&client->dev, struct_size(pdata, leds, chi=
p->bits), GFP_KERNEL);
> >       if (!pdata)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     pdata->leds =3D devm_kcalloc(&client->dev,
> > -                                chip->bits, sizeof(struct pca955x_led)=
,
> > -                                GFP_KERNEL);
> > -     if (!pdata->leds)
> > -             return ERR_PTR(-ENOMEM);
> > +     pdata->num_leds =3D chip->bits;
> >
> >       device_for_each_child_node(&client->dev, child) {
> >               u32 reg;
> > @@ -568,8 +564,6 @@ pca955x_get_pdata(struct i2c_client *client, const =
struct pca955x_chipdef *chip)
> >               fwnode_property_read_u32(child, "type", &led->type);
> >       }
> >
> > -     pdata->num_leds =3D chip->bits;
> > -
> >       return pdata;
> >  }
> >
> > @@ -623,15 +617,10 @@ static int pca955x_probe(struct i2c_client *clien=
t)
> >               return -ENODEV;
> >       }
> >
> > -     pca955x =3D devm_kzalloc(&client->dev, sizeof(*pca955x), GFP_KERN=
EL);
> > +     pca955x =3D devm_kzalloc(&client->dev, struct_size(pca955x, leds,=
 chip->bits), GFP_KERNEL);
> >       if (!pca955x)
> >               return -ENOMEM;
> >
> > -     pca955x->leds =3D devm_kcalloc(&client->dev, chip->bits,
> > -                                  sizeof(*pca955x_led), GFP_KERNEL);
> > -     if (!pca955x->leds)
> > -             return -ENOMEM;
> > -
> >       i2c_set_clientdata(client, pca955x);
> >
> >       mutex_init(&pca955x->lock);
> > --
> > 2.53.0
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
