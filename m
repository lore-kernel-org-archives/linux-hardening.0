Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917F37EFE1
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860384; cv=pass; b=C9WMIAaKxfJsoHslBU6069VOlCktq7B2pG52/9eKRiNBb7O5ebr94Qfh/p+a8ti8zlvu2s/gPfOBq3obV+N1AIFz/9YZbSeSlaoeXk32Os8d7e0sSp4BA988Ow7Yxzj2cLDYPdYXaPPhkmYFxLT06ixeQID4r9fHBsuJN+CsKzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860384; c=relaxed/simple;
	bh=QxDfPaftSvz+dpA0njCWwKFR7kOEN38NSwOeQcS5Y+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tq6hQcW3fjKCNyE4xR6P095EfX/5T5YrkdePsQ9Y1kxS9ofDOuqOv189yglvy4Q0HaZCRZSRSSEGhGE5LoISvcaoBgKWBK+b1gII7RdSIemozf0IHjH0MOYqF0tfNoI3izeC2LmO+JWGUHDWGnjTTIbfvhWZZKLoKmn7eRHa5Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5LSGpuD; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5LSGpuD"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9910707d82so476231666b.1
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 01:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774860382; cv=none;
        d=google.com; s=arc-20240605;
        b=gT1FV1VUgbZure89WM4hMrCGasntR1Zzq9JwvDFKJkt5BST3Bvijo3PmsKrPpg02II
         eWYInsDfF5GXXKE3+WBAgqmKe8W/V9Kpd9RPYE+ZOmVpt+SB5Pq/exs2n93Be0ZIcw1d
         hmLSH9/5D2Kn05ssoarNbnL6e9gys5HIcjnNvj6N3JmpZQVvuc3B71BCYmLyd9kPMBlz
         dQA2YY2/K9ZGCoukaJmp38Ute9O8GiZnrpOlleQaL5GRBp530SWdX0Kp8OeauWd6mdgY
         iLrDEhnIw3dM/A5gAnQ0ncoEMXoHbdCWpUgcKCD/MUUkl/rzlq3C98JfYBZOEYAPSMac
         mO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HFdi+sAMmTXfvai5RWnTh1O1stM1wk8EESAWCob6UZc=;
        fh=yl7rHz71rE5CTRYkVWWmLlZdesABp/1Y/z2RyVPlGoc=;
        b=Xo/YnUsoGRJTcjZJMiOHuJK425TqOxwsK34mGY12LVT/wjIbKTQfunbVVotl3+dHRN
         uXFhjEEM7aE3abGq2pg9/TgqMdiOxTYydacYY+yFkFEwT5MKiHqqqJ0kbpg01wSFMCQe
         5on/20WNo0aj2WNJsGTzj3NBmYHeM6iLiojc1yGSbKwMSGLfEB7fh1+ZUCqE9aSPTMNa
         wiXLfGdRtDoV9Z3S47/v7q3YQXvCJ+1zi0ATBX1DmmJG6Ph5DWJDtPphBuYlTmSE1yEv
         kPTTe0RPAVz+qUU5CI/2hy0Hd6pCEKA4Sde33s09jluPjGeV1CCkQQpV+9sTPcaRyphW
         EIIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774860382; x=1775465182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFdi+sAMmTXfvai5RWnTh1O1stM1wk8EESAWCob6UZc=;
        b=I5LSGpuDdwNpvffY2tGnC1XbAepwoMxsCxDrSdy/voK+zjwe+bujJbz98++UzfEAqf
         2qPH3hb6S1yrpLFul9mNRFUWCOKWzDe/2kZKLsov0rQMjydSSAimGMAVg1TNQvShPL4C
         rnMDBPWIULV/zDnP1kuQd85ukWpCOcO7FEUGILXUzbJ3Z64tPaTY5Cf/Xh89VfLT8D+u
         8sBJjJ8V0n+JnkyDqWHzhCBCDD3UggHiphITMdmniYlCIkRX0jIfPde/EbrS5Gj2DhzV
         PmH8U2aMsf/lUz23qXYJardlwhXDn4rQTE+HLeN+Irar/9BTzcnZEXcL6cEh8lFac+Hg
         U7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774860382; x=1775465182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HFdi+sAMmTXfvai5RWnTh1O1stM1wk8EESAWCob6UZc=;
        b=qiUwKH+BwQTXFPVJNOqrnj03tQBV4VGZ+a2HIdUuZY1+H5yIuT89sdDpeUy8tQICfe
         BQexwuFAwkGw3ZA2GxYydaBFMl57HlhOUGMsK56LneEmiBRtKqmiLOM3MO1yqDpySDY6
         NYC+bmlWABZVIGnk8DQDhc0uLrSMu18JUws2O8JhzwEuVmHzmt5x+lBCgDqzSYwbyyEc
         EDFbyP/dxwh2Kd9MfSTryhqxokjp70jqrcv2Mrq+4x6Igrf4eGAKuKm5z1S5pNa3aUvb
         KuuvnuwL+dozhmD0RL51F5mRjQFHsKAf/WQEY8yv8LQggWz9ipi31HLcQqQOsjt2mzcr
         hZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLufbnN3wABtyE/e26xTMdqmvuBzHsHKzt5f7L5zr9CbdQUj6OjbaGVh9OKJzQFgexeEXzO0UQvzLr7TUJZY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4UkvUL7H8j3+OQp7gaMJRwFAZX0XgCDJqd8yJUN18k7HobsU
	h0rGyqwl/CW1Jptupoe2Io/3CNqCMcnujMxhEsI5tGGnrZOF82ZRMphjwJXUQWZK6rNU220Y5X7
	0YXB1+3m3KguMDwj3KonVPeQImY4sllg=
X-Gm-Gg: ATEYQzwbYcAWgblE0k94Su+YyQxzjOXsFOiBkR+8BNKB6WR08Yf3+N3UtJhV9iZOmEa
	lsS+pvq8CTanwCQ3O2kDt2juT0Midg707hw0BAmPVD8x6Bvwn7fyEXZir9quIeyS8U+nvHZmxn/
	0I3O1fqaO1rQmThzVpDGZyQly8t3bTtNob0njgcYABJVPY+apg0+a/D5mY3fJRTKOvMGm93Fv57
	8U/rrvVBb7/zCsfomIQpFmHWV98VcKsE+HhtM4Vb2gFCkx6FBt04n3k0s3QN/OX4XbXerJ02Uva
	sFgwG+lKGu8Oq/FQkre6SVXifKI6S3XECD365iHLWplAyf562B8X6cUPtFih2YoVmyS/dAnLh9e
	xwm086ts=
X-Received: by 2002:a17:907:1c09:b0:b97:a12d:ffdf with SMTP id
 a640c23a62f3a-b9b509236eemr751885866b.38.1774860381552; Mon, 30 Mar 2026
 01:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com>
In-Reply-To: <20260328191646.312298-1-rosenp@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 30 Mar 2026 11:45:45 +0300
X-Gm-Features: AQROBzCSP-ZAq9l_JkG3Lk4O5AEzGIaeQWyy0gfG65bU_hKwDdH69EYGwCz99tY
Message-ID: <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Simplifies allocations by using a flexible array member in this struct.
>
> Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
> this single usage.
>
> Add __counted_by to get extra runtime analysis.

> Apply the exact same treatment to struct hsu_dma and devm_kzalloc.

We refer to the functions as func(): devm_kzalloc().

...

> -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> +       /* Calculate nr_channels from the IO space length */
> +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHAN_LENG=
TH;
> +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channel=
s), GFP_KERNEL);
>         if (!hsu)
>                 return -ENOMEM;
>
> -       chip->hsu =3D hsu;
> -
> -       /* Calculate nr_channels from the IO space length */
> -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHAN=
_LENGTH;
> +       hsu->nr_channels =3D nr_channels;
>
> -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> -                                sizeof(*hsu->chan), GFP_KERNEL);
> -       if (!hsu->chan)
> -               return -ENOMEM;
> +       chip->hsu =3D hsu;

Don't know these _flex() APIs enough, but can we leave the chip->hsu =3D
hsu; in the same place as it's now?

--=20
With Best Regards,
Andy Shevchenko
