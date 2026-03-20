Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189F382287
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047864; cv=pass; b=UwV7BhR2/nFwzrNEE+OvNo0xAUfsZvaAb7Cg/E/nj8KyoH9qK2Kus39IUNcOwa+ZyhojSH3XalrLRuvUFoBq1JRGnpL+mN+iAzAtIxuVfPRxgJlBFsFT9AtcXfBx5qKQwNnr2w4B3AI8Yx9bg/mIW80MG3K4iabpBOawmoa4tVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047864; c=relaxed/simple;
	bh=kbqvkak9EEUmypXJ+V4POVMtjCcscJp2HOu7ZIFqzvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRYvErd7Igrp1E4aAoL9TrzBN6eMSh8mhiccVAcnxuHCqftE68MOPHxPTjs2bg0soxQZdK8BwhKF5puTDnDdrepSgTFwMIyNxUS0M1LjWzXLnJcSHuUGqhA7xy/dmpZ5eGAq1q/EL7fe+ol38sTvMOoSVCKJfjXnt7SZ5jmRB+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afe7LchN; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afe7LchN"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-668d41905a4so2061971a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 16:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774047861; cv=none;
        d=google.com; s=arc-20240605;
        b=ZSVjytb8UziQFKOHVmVFGbXKvyxX+OadrZS77mVzixmXfxELaWa3o7hpWjqmbLzN+q
         spx20lyA5GvP1LvQw7+ti0E98oXqBZCrq1u4UphovLVjusPEbVaHGLoZpuvns2FYTT/Q
         tN35dcHpZaUcWKNghBMde02evZJGO99NyqfY0O2QqU1PUcSYOhuiMZIFx2gzDrYird/g
         ZIBuCOEdqlyrsE2+V77uUBJ3KB+LrTk2FvT3zWe5AW3sqswUDy7eWP1cp0ML6DhvH4wU
         vj7OKrAyGokkq7cP0UPU/YlyNTphUgJXYzQAdDd65s5ewAtR4szwwPhKK8TUGNxYoRg1
         vDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R77uxUSpcwOmp5Wd2oi4VVJJwyjwUIqXwqU/MR5HNeY=;
        fh=G6rD7KYc1+yNFIdHYKWulJv+uvDTOeK1iJCsoPPyRhU=;
        b=isQYmrBY+3YUJIsHnNZsM2Pda5YXx5GfwWSakPS8deW0Enp6N3Lz8j8w1CYqjtqfKC
         oWF2JJeLVZH+/Qib1+lpzJbeyFOUj1D2L8UsD43/e4YL+2rT5TiqT6QSWNSycTjiydC5
         BGhQRmscZNuv2NtVEpURlAmCsrNNd+45H47Qp7nx5cew8h8QFr5yNlItsU30mBoh94sC
         uLC3eXnAcKcjOVha8Ez8rf8X6/lC6lykoJzSZb2jGprICyqSs6O9wbr19FNwKVVk0rL8
         6nthYbnqYdhD7snf/Ri4O1fYFjmm0nuSIJPQioaDL71+84HsQFlCaMkQmLaqR9dBSRae
         NeoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774047861; x=1774652661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R77uxUSpcwOmp5Wd2oi4VVJJwyjwUIqXwqU/MR5HNeY=;
        b=afe7LchNPwWuBwmTeNK7akkbMJ090DBcjdXiHBHztDK8jj6qHYo7PlH9qm6hocauip
         Z09jdkbrIZBOCyA0dQmIcicUQoVeCz7OKpgYDDiW+Pmg9rn3neRCXMzNK1/FyZg/xK6j
         DzSMDIEzHlxd7YqPL3cXyoHIYzkHRsbiOhBFZupLhPibqBFUUnSBETWIlyM2g2VP9YUs
         ejsVcjOsoIBnX+FiPAoTvw5baRFlVePSE4DeyHhcfosKAbelQSj+KUgh/zYp0Yhim/qd
         s570FPBJGy7WQvMhKT5+7qOTPEDYg9C8smt8loqsvd0ekpN7wC+LZys2hEqq+QZp8OS7
         JjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047861; x=1774652661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R77uxUSpcwOmp5Wd2oi4VVJJwyjwUIqXwqU/MR5HNeY=;
        b=hVV8j6+UPLO6/AwgdiHFsJJ89fUxv3GMbzE2VDpvkbNpIvfuhr+B+59igRv4upu7ZP
         5lZPLeA42jZhZkfoDhGzCI4klL2Z7OIYVCxvA/CZenrHeijFsISjpvcL1UJ4S6uAqbdN
         IRByFFQwUuMAMt3ToM32aX9bTHlsdMzsQsXUEha9nL8GwF8Z291209Qy+A2ctAVzkrbh
         77thoi9uhJI5LphJbvu62mKurfBTHPtQWFcqo+AXK2cCbxu5f7+f7Zp8VUnX3sdSWJpC
         4g6ZNS3UIUEJBfbwYeNMN5MC/kd5s+Grf4dOm3h+Oj0V7fALTaiQ6gwvf7FiumA709Mk
         b5zg==
X-Forwarded-Encrypted: i=1; AJvYcCV6yDR45MyzXp/OpNVOQQ86L52W9nfgOmH5uu3cKlet+9v/CthRXiabOKdyIYimQJjiVKlJldhVYM7dAsvyxz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTJLR7/WXtgDipblsKPO+t1Q6aIg9mNazrHu0O5FH39nb+VD5
	uIX/P6ZoTD+8ARgKz0yAwEV21DrjjfmaKol94fTo5wn4Ej9cqdQOmZkmpomnRekffTDY1q/Yxjf
	5rX4rb/eMS/z4BVl+6pWBBCXUa8ub/CY=
X-Gm-Gg: ATEYQzw7XWecv2iUxM1i4y8D0tdkWbzMgQ31aM1/0+8blNHDyPdE4KElppeeZjcbNad
	Hkw5ixuwvPZN6a/T2orIRmDrl0sVZnJQizP6DG82+xdMyZKUQ3hDk0CqamqNwqKHrsYLhf8JcIo
	8Q268tdOIKtIRqVe+JB6HnyESOc5GKeCG5+wd9EtdKNikwV24daVxLZUf+JG+AneINErJ6qyWt+
	zzUe5F7xvHGyxbCH7fhTo3yhNLgnc94CWge+ZI5LmXh/I0sYDy76oKtxUW+UyFGOuimPwBjtjmm
	rnqnizn6045KzZ3jbUwI38nG7KZtmdrNoKehauZbwEgCfXtNWTsg9VjdKXRjnUrTvXTrfYiGv+N
	BrgHbSA==
X-Received: by 2002:a17:907:1604:b0:b96:ecc3:781b with SMTP id
 a640c23a62f3a-b982f0a9521mr383867366b.1.1774047860663; Fri, 20 Mar 2026
 16:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320010212.31425-1-rosenp@gmail.com> <202603201138.FAEE6A52B@keescook>
In-Reply-To: <202603201138.FAEE6A52B@keescook>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Mar 2026 16:04:09 -0700
X-Gm-Features: AaiRm50CnYdiewqTJThc98ujLgqJxlMjDYoRsDJZo2ihylZD1znGEKhaKiTTpZA
Message-ID: <CAKxU2N8LCFMFxFnJp586M2bs7J2gjyoOFH7H8MPYPU8XGpEA6A@mail.gmail.com>
Subject: Re: [PATCH] media: em28xx: kzalloc + kcalloc to kzalloc_flex
To: Kees Cook <kees@kernel.org>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:42=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Mar 19, 2026 at 06:02:12PM -0700, Rosen Penev wrote:
> > There's no need to allocate these separately.
> >
> > Add __counted_by for extra runtime analysis. Moved counting variable
> > allocation to right after allocation as required by __counted_by.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> This looks reasonable to me.
>
> One thought I've had while reviewing your flex-array patches is that I
> want to make sure you're doing your test builds with
> KCFLAGS=3D-Wflexible-array-member-not-at-end
> so that you can validate there's no new uses of the target structures
> being composed within other structures while making these changes.
I did that globally. Too many pre-existing issues with that.

I mostly just run make menuconfig on linux-next and see what happens.
>
> That looks clear here, but I think going forward, it would be worth
> mentioning it as part of the commit log. Something like:
>
>   This structure is not composed within other structures, confirmed with
>   builds using -Wflexible-array-member-not-at-end.
>
> or similar.
>
> Reviewed-by: Kees Cook <kees@kernel.org>
>
> -Kees
>
> > ---
> >  drivers/media/usb/em28xx/em28xx-cards.c | 18 ++----------------
> >  drivers/media/usb/em28xx/em28xx.h       |  3 ++-
> >  2 files changed, 4 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/us=
b/em28xx/em28xx-cards.c
> > index d7075ebabceb..c278e48b3428 100644
> > --- a/drivers/media/usb/em28xx/em28xx-cards.c
> > +++ b/drivers/media/usb/em28xx/em28xx-cards.c
> > @@ -3567,9 +3567,6 @@ void em28xx_free_device(struct kref *ref)
> >       if (!dev->disconnected)
> >               em28xx_release_resources(dev);
> >
> > -     if (dev->ts =3D=3D PRIMARY_TS)
> > -             kfree(dev->alt_max_pkt_size_isoc);
> > -
> >       kfree(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(em28xx_free_device);
> > @@ -3912,21 +3909,13 @@ static int em28xx_usb_probe(struct usb_interfac=
e *intf,
> >       }
> >
> >       /* allocate memory for our device state and initialize it */
> > -     dev =3D kzalloc_obj(*dev);
> > +     dev =3D kzalloc_flex(*dev, alt_max_pkt_size_isoc, intf->num_altse=
tting);
> >       if (!dev) {
> >               retval =3D -ENOMEM;
> >               goto err;
> >       }
> >
> > -     /* compute alternate max packet sizes */
> > -     dev->alt_max_pkt_size_isoc =3D kcalloc(intf->num_altsetting,
> > -                                          sizeof(dev->alt_max_pkt_size=
_isoc[0]),
> > -                                          GFP_KERNEL);
> > -     if (!dev->alt_max_pkt_size_isoc) {
> > -             kfree(dev);
> > -             retval =3D -ENOMEM;
> > -             goto err;
> > -     }
> > +     dev->num_alt =3D intf->num_altsetting;
> >
> >       /* Get endpoints */
> >       for (i =3D 0; i < intf->num_altsetting; i++) {
> > @@ -4028,8 +4017,6 @@ static int em28xx_usb_probe(struct usb_interface =
*intf,
> >                       dev->dvb_ep_bulk ? " bulk" : "",
> >                       dev->dvb_ep_isoc ? " isoc" : "");
> >
> > -     dev->num_alt =3D intf->num_altsetting;
> > -
> >       if ((unsigned int)card[nr] < em28xx_bcount)
> >               dev->model =3D card[nr];
> >
> > @@ -4163,7 +4150,6 @@ static int em28xx_usb_probe(struct usb_interface =
*intf,
> >       return 0;
> >
> >  err_free:
> > -     kfree(dev->alt_max_pkt_size_isoc);
> >       kfree(dev);
> >
> >  err:
> > diff --git a/drivers/media/usb/em28xx/em28xx.h b/drivers/media/usb/em28=
xx/em28xx.h
> > index f3449c240d21..1c2f92927889 100644
> > --- a/drivers/media/usb/em28xx/em28xx.h
> > +++ b/drivers/media/usb/em28xx/em28xx.h
> > @@ -730,7 +730,6 @@ struct em28xx {
> >       int packet_multiplier;  // multiplier for wMaxPacketSize, used fo=
r
> >                               // URB buffer size definition
> >       int num_alt;            // number of alternative settings
> > -     unsigned int *alt_max_pkt_size_isoc; // array of isoc wMaxPacketS=
ize
> >       unsigned int analog_xfer_bulk:1;        // use bulk instead of is=
oc
> >                                               // transfers for analog
> >       int dvb_alt_isoc;       // alternate setting for DVB isoc transfe=
rs
> > @@ -772,6 +771,8 @@ struct em28xx {
> >
> >       struct em28xx   *dev_next;
> >       int ts;
> > +
> > +     unsigned int alt_max_pkt_size_isoc[] __counted_by(num_alt); // ar=
ray of isoc wMaxPacketSize
> >  };
> >
> >  #define kref_to_dev(d) container_of(d, struct em28xx, ref)
> > --
> > 2.53.0
> >
> >
>
> --
> Kees Cook
