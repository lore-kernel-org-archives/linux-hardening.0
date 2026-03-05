Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E23375F62
	for <linux-hardening@vger.kernel.org>; Thu,  5 Mar 2026 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700740; cv=pass; b=JE/Pgpzxtr7zh1dhiyC0G626mf+BIIAR7VTh5fRnGr5PYMdRqrmrjXxv9F9JTjmPN52zs1ll/F3pvm9o5/RwbBpK8K3MIHdmTWBAy3ROSf5vboMEVNi9vbUjShIy6r6ImIIu0oYYrYhL5TahIcTGuhvzNEz7m24U1ZgFDvPUWMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700740; c=relaxed/simple;
	bh=wtdMWn8usfPicPIFXfZjj1ISjY0gUIV8qPaJ5pu3VPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZJGUZuwwFjvlQLy/4z5hs9n5Jmo6MDHSr4+VAOiVOxLSwy656omZ3pYx0cOFVfWB7Gl76lzMqANcnBdmleYkB/sB2ntUo5iqihNiqelL19OkX7SmjAAmnKQvdgPwWiq6LG6YKZyzYhjh+OjPcq/In2lIO6I3V15BFFAbFUa6Ax8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjDAsy05; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjDAsy05"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-660d2e4846cso2479629a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 00:52:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772700737; cv=none;
        d=google.com; s=arc-20240605;
        b=H6ZXxGzwZLvbBdV9u+5CT56FKHKxBBUOO8fTbHNvUAcdeMwqC5PWZORd236P9uDS77
         yY6VFvxQ8UAVqmq52Q7q8YYrHD0k/GYSXZ3998n4FLlODJgy52FESJGqNWSMZ9IX27ue
         ovkGkrtmtroowILpXB0VZldnkCJ3+/BWe+P/aFtAS5+A2mYoHVmOORKqhW0MHLrk7HOX
         3Ezi+tMUxUgM49AzGqtdJKCT15iC9UhwtJ77dUh7CTEeK0zqwVnNhcj6rGPd/TLwUxCa
         Vykcs7MzEp3sSij1Vgew4rXsDys/yQ5Rd/EWoB67k3yPZ6b5naCcJ6aTU/HUckZSpXv0
         PAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40a/3CPiG7qehOiiDE9oqYRGlJke2ucfupNz3X0xFrw=;
        fh=mHafSk81Ydsbqft+qR/uUQSfDUAh5q0lR/iSeUAs3P4=;
        b=kFUsISoTBTCO57tKGGe7XOZTguOqz08KoVWjsl8g4dFfl10IH9+WzwUjg8RpCnlTnL
         HbHGU/0DvzEDva0py3FvK1fpYJYMV0dZ6eOYne+F+EgbIwezUlnb9J318F/9f/HmSReZ
         VDP6r4FlwKvcpzjNpoxMDD8IeHDLct3zt2nVdp9r1oYw1VYx68QMiHVFQ41cVgqiZSYe
         7DEVM96Q23PTxKA1JUqojZ/MQwb7pckIKJZOkirK5QE6j6PFIIbfFVO9jXD8ltl21W2y
         u1QArI3iwjCRuqHUYSk+5NhXQrOH96iThRMS5ogKgeewEW991hCWpihBeiOfJchK0RZw
         vWOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772700737; x=1773305537; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40a/3CPiG7qehOiiDE9oqYRGlJke2ucfupNz3X0xFrw=;
        b=CjDAsy05/wL31zumpISeNTm5Ni983Q1MBGzNICqHiiPCgTtGqWxRmmeCWuvszYCifW
         YFLLd51SysrSzkCuCo31Rh6ozehslOp5M5vu7qa877bQ2CogsUP902t/YAd8AxJW/kTt
         Bt8kKaVgiEARdlMc7QJnkS6p3CR68KnNUQYkhnWiHyXfYFxukVwWn36uP1u05mhekx7E
         CRcjD13AgGdkIF77qbLoSvpGHrPCZWJec3kdlllXsHhHpRnPSAOipS5Zp/A+JpxgFKDo
         0QsuhRY7tecn/ezeg2LR6K3jme8P0f/LcxtCXtPZO9N9qKhHyA5KEdz0cI/7i1ZUAAD/
         r9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700737; x=1773305537;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40a/3CPiG7qehOiiDE9oqYRGlJke2ucfupNz3X0xFrw=;
        b=se48RvrB/ceGe0DvddHVmPKcVo+3kZJWCAQVFatV5QMzF5umHTGjke2ub98Utzmk4C
         //4mlFkJ6wREKqyCCIuS3S+47cnmx0Q9L8YREfZjoaHPpnL1WYg61pekre4O28ETSfVt
         R9tqSa1jImFCxNN2IOr6Ld+VIAyOZ7PTxhcI2/ZxChO8iBYU0pdIwnR3wgQBqpiOS9zb
         9SYavKt8TM3XjLPK2kp1+4uwoeApQhpJTxNDicHVtJYceXObRks21OC7foT+KhWDePeQ
         TdhhmBdT6KuOR+joPv/y1DGaaDk0m5eMApTowcP8HBba7dRcqCybjUe0XKYMraSKI7v9
         lNMA==
X-Forwarded-Encrypted: i=1; AJvYcCX+sJ/bYtWzLG+jrr0cfp09jl4fuGIlZ1wo/14xsui1x1LJl3J4xO2JS6c8AEtEIv3m9BwgCdpWT+OBpfyRF3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmxCY4yopaYq6deQjKhRIGDZv+mhAOiCt5WkluPkh+ctWezBJ
	fL2o7d92HgmXBNwCNXj1j/r2FwdJDZzNjCM+FOcLx+OaiXfx/Yzy0v/NqVKco2UpUl2PvOlsDK5
	5b42WoCIXk/ZbMfJoN1SijR9kxf+kObI=
X-Gm-Gg: ATEYQzx3Jb0LRy6mOEbMI4h0PP6kx2Cv7ACjyubFrjOZ5VIn4gfqwIz8D+JkmpvRqCM
	bKIWLHw2flcfXXjXFncjPG6FtnO9zcYFW0ft6KGlwjhvcBdElzYiII/jEjGAWmiA+uq2yLNbzoX
	WuWNHJggFyGIl88v16n3h97tm9f80jBJez7BHzsl7YOJvPrUKQ6aOlSzT5VxhgZ3wbzsgHa2z48
	LecfRPcR5sfwQRPvTGkifZxH4bjYeA2qIfA4MdAGSHDAyFp88Z4rmEEfhG7alJhoGPsjBciAhiC
	LEkHruFK3g1fmvTdabezJMpnKt04OMCIVA/35sJRqsTPikTNIVk6d0KBawYQMDSkUcZI5f3Hmtw
	zcZWnww==
X-Received: by 2002:a17:907:3f1c:b0:b8f:9d12:2386 with SMTP id
 a640c23a62f3a-b93f14f0ce7mr293846766b.51.1772700736535; Thu, 05 Mar 2026
 00:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304221530.15018-1-rosenp@gmail.com> <20260304221530.15018-2-rosenp@gmail.com>
 <aakr_hzORmNpme9Y@birdy.pmhahn.de>
In-Reply-To: <aakr_hzORmNpme9Y@birdy.pmhahn.de>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 5 Mar 2026 00:52:04 -0800
X-Gm-Features: AaiRm51ft6iqUq8bp34c33S5cVyGwg1PL3i6u05x7BmB6Pj6urenWKcFpxjnPOw
Message-ID: <CAKxU2N-wXRGC0YegCwNLOKowUKJ0GeOzQc1660cNtPMVwL=4Vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: virt_concat: use single allocation for node
To: Rosen Penev <rosenp@gmail.com>, linux-mtd@lists.infradead.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 11:08=E2=80=AFPM Philipp Matthias Hahn <pmhahn@pmhah=
n.de> wrote:
>
> Hello,
>
> Am Wed, Mar 04, 2026 at 02:15:29PM -0800 schrieb Rosen Penev:
> > Also add __counted_by attribute for extra runtime analysis.
> =E2=80=A6
> > diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_conca=
t.c
> > index aea88d1c9bc5..89e223edac6a 100644
> > --- a/drivers/mtd/mtd_virt_concat.c
> > +++ b/drivers/mtd/mtd_virt_concat.c
> > @@ -31,8 +31,8 @@ static LIST_HEAD(concat_node_list);
> >  struct mtd_virt_concat_node {
> >       struct list_head head;
> >       unsigned int count;
> > -     struct device_node **nodes;
> >       struct mtd_concat *concat;
> > +     struct device_node *nodes[] __counted_by(nodes);
>
> Looks wrong. Your follow-up patch does that:
> -       struct device_node *nodes[] __counted_by(nodes);
> +       struct device_node *nodes[] __counted_by(count);
D'oh. I'll resend in a day.
>
> Philipp
