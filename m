Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85333264FF
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021003; cv=pass; b=RUAETnY0z3iQTbwdY2A56EcOuS5dca61JSgMjZzIlhOqkyZOEK0qoAgSYFe6rbRWsMlTzxrqaIh/CwVK1eMW/NhbV4kVTihyFwKSIkvHQE66i1RQyAWKRC188gnRLzBCLVozAdQGMVB88HNbjiTH6uEFAIR8k2DCqwwOU6xcrcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021003; c=relaxed/simple;
	bh=iIkKJXiKA5O+0rk8H/q91t9S2KnW+ZRKSQpznvFiTeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tqb6bGnzeLgJfm7rGIcIwuKazQ/0Hbr0eXEyNhVA1/OrR/l4C70HXnMFUdPvvT5Vx3h/8xXE2LMLtIXhcCllvPv6HJ6LZl9peZGnpRsg4D7qXh46Zcg9+ZisjtO/d4v9lWpmIY2Y1qwwF5vDOY+i38/zpROFg/HSrLEZCoA3KKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTtqZlZc; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTtqZlZc"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3938d17d6c5so30536721fa.1
        for <linux-hardening@vger.kernel.org>; Tue, 05 May 2026 15:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778020999; cv=none;
        d=google.com; s=arc-20240605;
        b=JthjPQQiyTkgFt9xRKAhIRxwc1+o//ghjQcCVIDFUOfulzVn1IRdevcbOSR8PF0hde
         3K+LxhfvmSyhpQbfHjfGfJffKhm9AFiCSJ3u5yn/2GNB6pmsu4+TbqwyPS3vT8+4aSSn
         z+9dSQPToh24nGjfFDsfEiEVBSeQJYuVWruDNafkUhlbJtqeOAflduQYFjuq4R8Ns1iG
         uD/YOCUSsY5b2G+yLpqLvuk+2QP2mxeZ0FOsI1hBpLcSiELhop+0axeGLe8R6RfDEVJ2
         kiWw6AUXrI+7kqa0jKWG72l8yi1Z/kzeuZ3tUlyryv4cW6p5RuDmLWCaIOS69UN1wzxq
         3pBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NyngZeINrYkAsC1U6D4ztqT6mI0eVivk/jzOO+xk58w=;
        fh=EXQniKtiTDDd8/rCSzh7Rewjgr+3M54pAf1xzYvluu8=;
        b=ZUxHexNToN6RxXHA9FgcA8UHmGTMFjpmSThD+H/Aiw+KxDWVSFa/eFEMFrL6+sxMCA
         BVNazTZ5Gz3aJ0rjxXDQVFiDRvOp4J56nb1yCtTOHSX8tkzMdNK1Z3YXarBprcK7SnI3
         RgE2mccXRTN2mF7QYaeA+SrUAoK0Aq2LDur5woXbkcovJFStsVQdyPsdgcbD8JkiN+zS
         vkyc3dguzs8OyTHnZduL7SQZJXSGYvZR3TWL0fF2UcLrK3TVZ2N+G7aVUgrN5fp8JXY0
         Cz2ahVcMv1YMBK28Jnu2E4ewriIy3w9LYj1BvzuR8h4dFEZ2AsupVWaF8w1cIux8yiRn
         pMOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778020999; x=1778625799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyngZeINrYkAsC1U6D4ztqT6mI0eVivk/jzOO+xk58w=;
        b=gTtqZlZcNQ9y2kuRw4WBAO1uuW3/YUYFvyNDeKV2CH8pue9EYajww+2suW9dnlIODg
         t+sB2GVx+4ysjvQe11Ldci0uJqW/C4MlIqCI9G3v5eFudUGr+Yaiul6F9Tu4OAPUKLTs
         auKhbw7n/QrO/7AeCyU54M/6LTea7XE1OG2GSHrsD7tZz8jn659Abv1CosLGDAt+FdHx
         e0z3YQ9oAjLU3nZECEOyWDu1HW7+cn+pnHmSIpodyZt4AnACLVOV5N4eLRaWgqHgxxrk
         2L7DUsfCkrDv6rCsmsLqxrybBE0t2pc0j8jrSZMrwRJ4/Ljjq3eRpCasndpjtao2rllL
         at/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020999; x=1778625799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NyngZeINrYkAsC1U6D4ztqT6mI0eVivk/jzOO+xk58w=;
        b=UdblQoZRG2wBc7avnnHajJqk9gF3UleB6tOBIijmmjKMh5gnbN+gjGSCUaj0bUXoam
         j4V9xS4gaKCrOTPO8hDuW2V0Fzw2F9PvCeMg5FXZ4xKDUfVTwK9vTvWjCu2CgciLOH9c
         qWfjIFsNyiOOCawzgv+8hWYu/N87yy8/vbm/NuykD3gWvV7oBWzjzYZay5LXWTTQd8FG
         gP4yrpq4JZ7KZ9Xw5HqsYe87c8fWnh7Cmzzw+Ee+W6/FaQhNA63u9xoKB7b5QQGcCcBl
         eQa1hVTvv3hdjfi1nrg4Lzb7ndBVeJHHolYDdgZRLLcIXcIYWtXOohqM1clRdomiE/2e
         Y/eA==
X-Forwarded-Encrypted: i=1; AFNElJ9QJ4HiXJdoQ1fIxUILcaxu2xEqwrQwNeJ9hzToGHmkmEse4p1fQfAzWodcM3p+qbpX6c91pXveNdyJmeiJuW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9dquHIUgICJ0IjZodd/NRu2X1NEh0vhxwsaWe8fNC4e1FGB5
	Td/hA7rcSHcW+Saboz99Afp/iZoCIYygYkhW2FK8jo1MB4QMPAu2rW/5dLK8mpMb//AdpeTrPjG
	6ezdWskuoXhN3flC424THPAwiy0Q9PzA=
X-Gm-Gg: AeBDiet4ae+CG5vYnkMwwO6SpHpqwmhyfKWDlT1oxokTLi3pdgDrlhgZewZ2fgM6LGL
	fWkf1zwdjQY695f7R/Yzin26LvLiJZDr3AAv7Jjlksnhy3i/7BNV+V65bme9olCK5EmiBuZeUs+
	os/z5orUKVJuJUxaksowOMBqvPTBtibBKQE9YwH4VyI0ivEs5zAtPNi4W0fHnV1w1vKogNlslMH
	FX6XjSX0ZNJsAgGfZ2e069z0voCX32nVYE3D8Dk3K64h668hEp2Lh7apPwMa2KOnB9mxteXPQTS
	em97UK5QmfTiR8XsBu063onTRvUO88AEb6IgQym3SMSwEp/TrfArFpu0QLJRsPrZ0yedLakSpsd
	BfsdTUM7HV4MbvNuTeFw46a9VXMciXPyBKVkDb9UImJpcohA/VvmrxLd9evoYGAB81tzA41R5BR
	cSYdk=
X-Received: by 2002:a05:6512:3a93:b0:5a4:e6:8fb4 with SMTP id
 2adb3069b0e04-5a887ae2861mr210106e87.14.1778020998499; Tue, 05 May 2026
 15:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505073705.8810-1-rosenp@gmail.com> <afmo6sJlqbjCWd9A@gondor.apana.org.au>
In-Reply-To: <afmo6sJlqbjCWd9A@gondor.apana.org.au>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 5 May 2026 15:43:06 -0700
X-Gm-Features: AVHnY4Ju2pQzmdQ5_EYMwW3Rvst_VPzsAJVY8Rv5tf7BEwqrm-X72SNtp8pvaZY
Message-ID: <CAKxU2N-T0t0K9Bx6UYm6XUxBUMGys6_avcPH3aBjc2Vh2JFe7Q@mail.gmail.com>
Subject: Re: [PATCHv2] talitos: allocate channels with main struct
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 1:23=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:
>
> On Tue, May 05, 2026 at 12:37:05AM -0700, Rosen Penev wrote:
> > Use a flexible array member to combine allocations.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: add check for of_property_read_u32
> >  drivers/crypto/talitos.c | 19 +++++++------------
> >  drivers/crypto/talitos.h |  5 +++--
> >  2 files changed, 10 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> > index bc61d0fe3514..e1f009684216 100644
> > --- a/drivers/crypto/talitos.c
> > +++ b/drivers/crypto/talitos.c
> > @@ -3409,14 +3409,20 @@ static int talitos_probe(struct platform_device=
 *ofdev)
> >       struct device *dev =3D &ofdev->dev;
> >       struct device_node *np =3D ofdev->dev.of_node;
> >       struct talitos_private *priv;
> > +     unsigned int num_channels;
> >       int i, err;
> >       int stride;
> >       struct resource *res;
> >
> > -     priv =3D devm_kzalloc(dev, sizeof(struct talitos_private), GFP_KE=
RNEL);
> > +     if (of_property_read_u32(np, "fsl,num-channels", &num_channels))
> > +             num_channels =3D 0;
>
> Does this driver still work with zero channels? It should just fail
> the probe.
I looked through the dts files. All of them have this property. I'll
have the change.
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
