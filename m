Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339E3E0C74
	for <linux-hardening@vger.kernel.org>; Thu,  9 Apr 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755998; cv=pass; b=aQ/ln9Se7nzkEHRKUF8Oydwk1VLkWJlv7GaiC+zGAXmxxFnu35l3dgpPMHlCEVYBYg9vHbP3UXg4H/ygdtCCSycnHXYxTDeq6erv8kly9g25gwvlFb2BJNIZzBqsVfiAeVIQuxRznUVI9T69S3dcrSElCtFnqOi5/ZGyktzwnE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755998; c=relaxed/simple;
	bh=pAp6FMygBYV1F6TaYcfCi8Htvtlt5svuMU2I9kTySjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkD86qDkabC6HtJhtiJjuqAqdoM/xkx4bdIDEuU19BivCi1ajSNkrjBHzYTxRazKKr6hoDUBwfPNgKAdfXUlGq12q/M1fg0JgIJ50brNp1vYFBfroB3aLwXSU0xhLN7WeOJPdarteJAyK6VBYOu7i4ohkwkMavWNBICn2seE5Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVB09xiG; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVB09xiG"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b886fc047d5so177010866b.3
        for <linux-hardening@vger.kernel.org>; Thu, 09 Apr 2026 10:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775755987; cv=none;
        d=google.com; s=arc-20240605;
        b=eWvOKMknL5rESh4DT3E6R42XBxgHKAqTwhSwh8pCFnp8WFRqq//2BMz+/cVSK1T87T
         anqpfArI53jblNy9JCAdb4BWQSdq5+RzE5d08yfeaCHBlpjmdfNwyiTTHbLzi32iBpbk
         oNz0z0UxnmYUKGCORoPdEdGWx1C6n6T+qOdRYpyzy43rF6mrvJuddXGTmtbL1FPG8Y1H
         HOytyYNaHhHnxJVdxmTAvIiS2cYou/fPJDn8CIWg/4JVmkpHXrUp2AC4vi+hVUpBJTt7
         dNwQ6x3x77x5d5ZhdAlKsqmoCx77qlOr2+Ae3u0et8mbj58YyRFaJtldsfa/f/ZidezW
         3KiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3XPkS92gnUuX48YeJscFkbdS2F7DzIauqRmSzvPVPq8=;
        fh=e2shyWvx+/CAks5NTbxJW9TxRPNLhA+0cG9H780fzKs=;
        b=apOjEa/ERip/vsFIwDxe2wT7u3QQCFIDvg5rNPq+yNkVV/QUm0UH4O6hCgPUizybgz
         NktLc1uiB19uaU9HCsTpQCHk3vd7IbJeDbQOr2Zc9Ij7DrClcJYlUWppUrMntx6+am7O
         Ht4RSnOewzPRxowiGMBiPiuFIaPAYOY/QHBwIDqEiDGvepRRb75aKLm1xAZ2ncwXUuYo
         QEvY1KWt+NkAV3iBxe5XdNvMIqsGGV0pHFaeea/ztxqb2Lx0yyURFbfxT/bU60IZy3on
         B2e2CdbQU9oW/39xJVNTFd/U1gqAHEKFe6QFbgzV0sR3OSHVy4+PdaHFeEHn35wGFw8k
         KrVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775755987; x=1776360787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XPkS92gnUuX48YeJscFkbdS2F7DzIauqRmSzvPVPq8=;
        b=pVB09xiGHF6RqqzYmr3jDyzPLm2CrlDEy+tvdKHBfuV9PCeyqt0XXe9O0UBJ8CsZXv
         XPLqB0AlYxFpD+1q8WJz/7RJl3vWBKLvFmkZSNbF/IwHUr9RvMBy7Y/O6hUWK7MmEWXJ
         mrnt4n0EQ9Ky5NlnG3PO+RwMcFaj+1eVO/gBadJUCYlnUFCdTnA2sNg1f1cyotou8e8s
         JMKaT+Iha7Ol7W8hzDtw+7RxzhRh5Vtdfc6Qv/QNx4FNLVGHT2GYZCQ6yxmd2Im2tYPg
         2EnGFCyMo0B5uazPaG0iHsWwpZHWvpxyOANj72oOQeYnPQs6Vau9f9cL2jrayPbR0m8+
         WOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775755987; x=1776360787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3XPkS92gnUuX48YeJscFkbdS2F7DzIauqRmSzvPVPq8=;
        b=aOn273lkl3SG2BES+hR8UCEz7fFXlqNbSm2UCyuKnjZ6onO1pqaTdPFwlmql4gvzCy
         McFKwIHj7g5maGrDkTn3vQRJBqhTRzfp9PM/gGgUo2SIJQUZSxoHbck6QvtNVa4UpnBB
         FSiT/63+QcBwhaZ4NRT463lxvPqqsl7zJ7oJzrVCZ0Aj1O05FWaOHZAVxQPi/WamTe5E
         79HIw+xdBWHBjnlkT0rRx0k73qwZ3fDGBbcwUI+vxv1LVm5TVWd6Jia2Qqtbe2cMeuu4
         24ekGoRnI9VjLk/rGDmu63c/y/P5YQLFp1il0+bjHPnHeyU8Tyo7C1dbYta7bFr3/Zqu
         uhbg==
X-Forwarded-Encrypted: i=1; AJvYcCWNhRXcurqjywcioGUEDdwRhAqVSPUCfIw65lXqG8XalPhbU9jPNNaTVa0oXg9IBFEI3NHnsmZb9cyKjQ+5lG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKlvpDR92PYwNHXpAv82U8pAKzRzazHkGg57dvm00lg1X3xMtY
	Mq5LU3xqTpLgXQTsJBXo1SeaywnmOWm9DNYVFPZJ56U0jwEpj3hh9LLp1Z9PkE31CU4vZg95j3P
	PN40zAe7OqcDHWkstnB0n58ZSbJ+6t2E=
X-Gm-Gg: AeBDievin6JbVG7bX/0rdfQQKC4AcgvmpF0ZDC0c5gTrv7DGkwS2y/ZbMUK3Sm69/8U
	mMWLLOIeOV/3k5YpFE0glMk3SJaOFIcWGPlgi1eNsAYJ2aw8QVsmCUJKPpXw+3O7Rn7fkCEbida
	6mckLdjS9fNwAYGl9YucuqISjceNiur8o0KECMIppIXGy4lexEXadZdEO8d5U4+CpvJYDVWoHve
	BmWSI7w5zCtJW8ob/JaXdVoqSZ9p1uBHXnBOAZ2ALgpMGFqvgTlz2yrlNdl3OwKBrfsIXO7j3dZ
	L57VpHUONzsw7fNoxmGXXng7KFdyTnoXUyuR58zTINEbtIgHshHDkC0meKkE3l6tv1OpGRUo5Na
	LmW9Dxg==
X-Received: by 2002:a17:906:9f87:b0:b9d:6a06:fab1 with SMTP id
 a640c23a62f3a-b9d7265c9b4mr6451966b.32.1775755986990; Thu, 09 Apr 2026
 10:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320040821.46540-1-rosenp@gmail.com> <20260326113336.GK1141718@google.com>
 <CAKxU2N_8BnBETT8YeDa44bDvC_srepskpA7iDYOwPQJsfb0dXw@mail.gmail.com> <20260409124417.GA3290953@google.com>
In-Reply-To: <20260409124417.GA3290953@google.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 9 Apr 2026 10:32:55 -0700
X-Gm-Features: AQROBzBVfPk1Mg0NTdCC5ZF5QedLEgsgiQZ0J1Ci6_R_-CCKPRkOy_dRyCxB_uA
Message-ID: <CAKxU2N-pAaCDR9vH7PEXLtb__Sc_JU6Qrd-5dgFC3deKmJGFcQ@mail.gmail.com>
Subject: Re: [PATCH] leds: pca955x: kzalloc + kcalloc to single kzalloc
To: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 5:44=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 26 Mar 2026, Rosen Penev wrote:
>
> > On Thu, Mar 26, 2026 at 4:33=E2=80=AFAM Lee Jones <lee@kernel.org> wrot=
e:
> > >
> > > On Thu, 19 Mar 2026, Rosen Penev wrote:
> > >
> > > > Two fewer allocations as a result.
> > > >
> > > > Required placing some structs before others as flexible array membe=
rs
> > > > require a complete definition. Declaration is not enough.
> > > >
> > > > Added __counted_by support for one of the structs for extra runtime
> > > > analysis.
> > > >
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > > >  drivers/leds/leds-pca955x.c | 45 ++++++++++++++-------------------=
----
> > > >  1 file changed, 17 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955=
x.c
> > > > index 2007fe6217ec..ee5f02eaa3c9 100644
> > > > --- a/drivers/leds/leds-pca955x.c
> > > > +++ b/drivers/leds/leds-pca955x.c
> > > > @@ -112,19 +112,6 @@ static const struct pca955x_chipdef pca955x_ch=
ipdefs[] =3D {
> > > >       },
> > > >  };
> > > >
> > > > -struct pca955x {
> > > > -     struct mutex lock;
> > > > -     struct pca955x_led *leds;
> > > > -     const struct pca955x_chipdef    *chipdef;
> > > > -     struct i2c_client       *client;
> > > > -     unsigned long active_blink;
> > > > -     unsigned long active_pins;
> > > > -     unsigned long blink_period;
> > > > -#ifdef CONFIG_LEDS_PCA955X_GPIO
> > > > -     struct gpio_chip gpio;
> > > > -#endif
> > > > -};
> > > > -
> > > >  struct pca955x_led {
> > > >       struct pca955x  *pca955x;
> > > >       struct led_classdev     led_cdev;
> > > > @@ -137,8 +124,21 @@ struct pca955x_led {
> > > >  #define led_to_pca955x(l)    container_of(l, struct pca955x_led, l=
ed_cdev)
> > > >
> > > >  struct pca955x_platform_data {
> > > > -     struct pca955x_led      *leds;
> > > >       int                     num_leds;
> > > > +     struct pca955x_led      leds[] __counted_by(num_leds);
>
> I'm not sure we should we be embedding the full 'struct pca955x_led'
> (which contains runtime framework structures like 'struct led_classdev')
> directly inside the platform data?  Besides platform data should ideally
> be restricted to static configuration properties rather than runtime
> state.
>
> > > Where is the memory allocated to this now?
> > The kzalloc call was updated to use struct_size to allocate it
> > together with the struct.
> > >
> > > Why do we need this in both structs?
> > kzalloc and kcalloc can be combined in both locations.
>
> I believe my original question might have been misunderstood.  I was
> asking about the architectural design choice.  Why does the same 'leds'
> array need to exist in both the 'pca955x' runtime structure and the
> 'pca955x_platform_data' configuration structure?  Could we look at
> eliminating this redundancy to avoid storing duplicate data?
From what I see, this bit of code handles missing pdata.
>
> > >
> > > > +};
> > > > +
> > > > +struct pca955x {
> > > > +     struct mutex lock;
> > > > +     const struct pca955x_chipdef    *chipdef;
> > > > +     struct i2c_client       *client;
> > > > +     unsigned long active_blink;
> > > > +     unsigned long active_pins;
> > > > +     unsigned long blink_period;
> > > > +#ifdef CONFIG_LEDS_PCA955X_GPIO
> > > > +     struct gpio_chip gpio;
> > > > +#endif
>
> #ifdef statements are to be avoided in C files.
>
> Please find another way to do this (if it's required).
This is not my code.
>
> > > > +     struct pca955x_led leds[];
> > > >  };
> > > >
> > > >  /* 8 bits per input register */
> > > > @@ -542,15 +542,11 @@ pca955x_get_pdata(struct i2c_client *client, =
const struct pca955x_chipdef *chip)
> > > >       if (count > chip->bits)
> > > >               return ERR_PTR(-ENODEV);
> > > >
> > > > -     pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERN=
EL);
> > > > +     pdata =3D devm_kzalloc(&client->dev, struct_size(pdata, leds,=
 chip->bits), GFP_KERNEL);
> > > >       if (!pdata)
> > > >               return ERR_PTR(-ENOMEM);
> > > >
> > > > -     pdata->leds =3D devm_kcalloc(&client->dev,
> > > > -                                chip->bits, sizeof(struct pca955x_=
led),
> > > > -                                GFP_KERNEL);
> > > > -     if (!pdata->leds)
> > > > -             return ERR_PTR(-ENOMEM);
> > > > +     pdata->num_leds =3D chip->bits;
> > > >
> > > >       device_for_each_child_node(&client->dev, child) {
> > > >               u32 reg;
> > > > @@ -568,8 +564,6 @@ pca955x_get_pdata(struct i2c_client *client, co=
nst struct pca955x_chipdef *chip)
> > > >               fwnode_property_read_u32(child, "type", &led->type);
> > > >       }
> > > >
> > > > -     pdata->num_leds =3D chip->bits;
> > > > -
> > > >       return pdata;
> > > >  }
> > > >
> > > > @@ -623,15 +617,10 @@ static int pca955x_probe(struct i2c_client *c=
lient)
> > > >               return -ENODEV;
> > > >       }
> > > >
> > > > -     pca955x =3D devm_kzalloc(&client->dev, sizeof(*pca955x), GFP_=
KERNEL);
> > > > +     pca955x =3D devm_kzalloc(&client->dev, struct_size(pca955x, l=
eds, chip->bits), GFP_KERNEL);
> > > >       if (!pca955x)
> > > >               return -ENOMEM;
> > > >
> > > > -     pca955x->leds =3D devm_kcalloc(&client->dev, chip->bits,
> > > > -                                  sizeof(*pca955x_led), GFP_KERNEL=
);
> > > > -     if (!pca955x->leds)
> > > > -             return -ENOMEM;
> > > > -
> > > >       i2c_set_clientdata(client, pca955x);
> > > >
> > > >       mutex_init(&pca955x->lock);
> > > > --
> > > > 2.53.0
> > > >
> > >
> > > --
> > > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
