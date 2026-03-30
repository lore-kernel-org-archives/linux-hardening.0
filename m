Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB83393DC0
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903314; cv=pass; b=sXriOSCpdsQ+Uhp2PKhG0kOY5mC9wIj+c2RNYFKtqbW33rNE0Knp52jMj1n4AbmmWGOjfbmRoRVXOU9wna4rc+Uqf20nmfOHYqmuRtJkeoB6gGYtiqE7nqQL85pP/42ZXhIAuRx1jgeac7L1DoV0P0OLi9lTHfQ3CGLMxt39nn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903314; c=relaxed/simple;
	bh=DIK3V20QZOCwhmN6cwDKL9qfq86Sgll3B+nkwUxu4A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTu8mZHT4Vy00VVtXWIwUB7rRZwqlB1+6Zc9wJJBU4sg2ZGtpSFuFgH334ux4lCJQ4B38wPmyoawiy1xhp/iNMd0g8/p3aYjdRWNjoJn1SfRt+qRq1BvsCK4MThtvR3lpEcTV4KZGTsEXp2yZaZ1L8bDakLxs/tIZDKlxVBVdtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyMzFySJ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyMzFySJ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66aed966c7eso7775521a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774903312; cv=none;
        d=google.com; s=arc-20240605;
        b=ANnvD/zxvtEH/d/qxcvDcN6R9pkdWxFT0KHb3ThFuAJYXEbm08spM9oMSBdVNeQzbY
         Q5Te8Hcq2O4l9o65BIWjgjnCZRgGTSihdq7wUCeijlSTWdUzkWFk7PPJNe8UtBDcjHTK
         Vm4RUXkXOBB76LJGyz5meGaIqQ2uA2EU5wqRt5UbJg/Q+4peZvd6uZ0sy4wFUgzYoKbQ
         ++h5uOo+yF9MSVKrWbUsmpEGZS8BM6BnDhIxSbbbiLoQ7RU+KStmQPjyZmsYd0I+Sa1B
         gRdimykebnz8Pqv7lBX0Yol9zGHazB7wolXCbYeUDNVO+kn1qPGV52OYVqEa64Idfkxv
         IH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qQLQvYqOdJ6/QLS7K4HwUw3fLx5r205prr9boPIl5PA=;
        fh=bbyTmYj8AcOWx9LuOhl0z151f1X5Dq3JeM+ZVVrBUig=;
        b=bZOKNTxwzrHzBNYUKMxYFvq1vKfSBNXkfty5GOtgsNnF1NqN8JR2flBB4Q3wo9CzRo
         vmEAtToL5L5SDqnkLYg4zuo9ReYCxvjMkd753Fgf8YPTuG1dPu9zUjJheJJ6mnNyQtjt
         xRnVx9gAC3odE1oWvInOUMs05iJSBgLTjg5hLQFX5DyJhzt4VKnX7vsvYEFMLDU+JNkg
         8GOJi1F6T9GBw/4ibxzucKrvgkjXKOHkJoVwHO4Jn7ix+bXj1TxWZmZ6ksewe1qLym7q
         UFVaXc1Ph8vyvVVyJJ/GHmBFpx4xs2zM+0otoy2HZB1+0eUoa1LLczFSTUUbCYc5av12
         1Aew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774903312; x=1775508112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQLQvYqOdJ6/QLS7K4HwUw3fLx5r205prr9boPIl5PA=;
        b=WyMzFySJevzlKkLSoBfI5wLYZEvHyZ6dn1/fMBhf9MJMXOVi3ENJNJqG20SIEIqjFO
         x4z53JUdhr74o7YT9wjk5KxWjowywhESECRaYKuZfcwt8Ixz1Qv7bC9koKkhCN296vSD
         6Yu1Tkx9zMuCcDIV+42fDntGHM1TUEsnF+IUhBFOG6x1Bgf6dqssUyaCJXczTToZQL58
         ytmjYfZD92Eemc2k89Lubr2hV1vXrHZKCu8nBh6kBVDIJOswWXROeGvTa3zbgMO783Hs
         t1j+O8qBC9Bu0Fc8Yt3k0jNjiPkSRi+uW/LX8bWHZKyAhBSyLMHI8ppgIH48ravn9BFx
         WkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903312; x=1775508112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQLQvYqOdJ6/QLS7K4HwUw3fLx5r205prr9boPIl5PA=;
        b=f7lGvFN6+phDGMOMn+pu9pGRyedT/awmqQVDwcqpRZZLyCD7qx4+wsIAYFgRQnzgYo
         7O1fdhraZdgi3gj9Puun3YCTIlYBjWtsM++9B2lDJeWC2muMO6PPG/6W7XLTHLJixG8c
         l0QPjolod00lW5UpQM+VUGAZzoDkthJLllZoV3udjy4AtpeMTZRXotFpvpx0jr5qIjMw
         KnyfLpIu32mYLa//Zw1jdhj31biVrmwnU9Et6YXY/bdL3GFaDHEMB3h5nj59QTeeqyKH
         iI7iwq88bYvlBoLIX59CK7LSni6ZFLoBGeC8LLvi+ypW/sUDy+jfhKd88/ApbWI2X7P0
         mi7A==
X-Forwarded-Encrypted: i=1; AJvYcCUR7yKpw37OjM190gOIfXHU8/5512/03KXq4MXzPfT2Rnc3018yN+KETD84B8s2/GmdMmcRSXHE841GJBEi0qI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Mz6i5OoS/J+xnmOpfcJZBYMMvbK1XqPr8gJhqL5xYzVYmixl
	J/ZoPN0EDWB1Y4z8I63I6IDtZBf5YZP6C0+XE2FD2adTTN4o2+uFbFIqMIaB+BT+qTMzOFf99hB
	7F7pSfeTYAxP56gzub1MHiznYgXhCyhU=
X-Gm-Gg: ATEYQzwPV7Sg2nlZpgGQufLXnl7YCzVz69fUJNyZx7IpHgtoYbyyKWhT2dGduEMfhsr
	dwKv0TSC5FahmahWZDosv35xP5mgYNACNfPoMg3xJ7TLoS9CS5+pcDzHUINpibqbvGA1t2zJmwq
	q3tYgcuSiPq/lxUdPgs+sZYfWiVaCW/8hLwxI9bWcQu+KLJXdBzZo3wOAcKXOGX0TLm1ziFXkap
	vKm6eN3oPfbIhJuGm4TGEsvFEcfBCY7BF/2XzdJTpcb6sfhQIImm+pnr9i+xg2PQEbNJucBxHsw
	BqfDdRwW2Vsj24d+b1jbFY14zhBOAKJOZVJT21NuErOUMrJtiTSUEjlV656NOvKJiAn0j0Fe5AU
	p8ZxJRA==
X-Received: by 2002:a05:6402:1469:b0:66c:36d2:6fae with SMTP id
 4fb4d7f45d1cf-66c36d270e1mr219646a12.11.1774903311681; Mon, 30 Mar 2026
 13:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
In-Reply-To: <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 13:41:40 -0700
X-Gm-Features: AQROBzDXfG62JkfLV_TELbkAYfelfc9Gc3QRSzDnyOpWEW5ceHPkCS80BBCOS2s
Message-ID: <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > Simplifies allocations by using a flexible array member in this struct.
> >
> > Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
> > this single usage.
> >
> > Add __counted_by to get extra runtime analysis.
>
> > Apply the exact same treatment to struct hsu_dma and devm_kzalloc.
>
> We refer to the functions as func(): devm_kzalloc().
>
> ...
>
> > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> > +       /* Calculate nr_channels from the IO space length */
> > +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHAN_LE=
NGTH;
> > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_chann=
els), GFP_KERNEL);
> >         if (!hsu)
> >                 return -ENOMEM;
> >
> > -       chip->hsu =3D hsu;
> > -
> > -       /* Calculate nr_channels from the IO space length */
> > -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CH=
AN_LENGTH;
> > +       hsu->nr_channels =3D nr_channels;
> >
> > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> > -                                sizeof(*hsu->chan), GFP_KERNEL);
> > -       if (!hsu->chan)
> > -               return -ENOMEM;
> > +       chip->hsu =3D hsu;
>
> Don't know these _flex() APIs enough, but can we leave the chip->hsu =3D
> hsu; in the same place as it's now?
__counted_by requires the first assignment after allocation to be the
counting variable. The _flex macros do this automatically for GCC15
and above.
>
> --
> With Best Regards,
> Andy Shevchenko
