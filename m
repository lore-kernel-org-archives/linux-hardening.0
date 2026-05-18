Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905E2475E3
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071966; cv=pass; b=VgSShtHUJcnyUx6TfmwyKhSGHtTUMWDpMdbMMQw4VOAf30Wz/RvKnNY8dbUXnCU3dm5J2sTL6ge2+UyPz/v6WYIGUDCN9F477Q8XTwiqD4U8zIjdEhYRc4wR4WxQnLzGL1ZWobnfdKncP/NB7wFJcsdUDGvrDbsGeif31RO9B+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071966; c=relaxed/simple;
	bh=Ez7FsfYdRBuDV9VsJ/QsP/mS0cTzmxNd+ivitbeBFwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6XVRI2Xqkno20wBu8NxEue8zY18q8EpDdXC2rVqlC1NT0MJI0Db000JRAhVY+x1EnXw/qNkhKbJe2bHnRYeLY+kvbOaNHgo8TmNZS8EVlzGIyMs7k1UMcz3pVDnrSsW3s88T9ddl18IbC67tzsGrHdsZxzX7MRoVI6Rt/GcGV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAoWKzTM; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAoWKzTM"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bccd251d622so324154166b.3
        for <linux-hardening@vger.kernel.org>; Sun, 17 May 2026 19:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779071963; cv=none;
        d=google.com; s=arc-20240605;
        b=QtxLtlSW4zvSlcC9lJcMgQ/QSTS3ROgQQzEySzknrWwnfBIKrEpiwc7JvcuCzBU5xZ
         l5KARXgs7Gk5uSMYV8dX1lJZf3KJ/ZDXtPLti1kI8Jd4OT1Ix5zvnumj4qWvAjSlzjDO
         025UI8uIiFSZ8kZmo7bdesRaYUoFbI4W+8ROEgjy7usawST+VvNgWPlws1pJNKTHhbCV
         s041z9fKsuPaxSrzSc0t3nW9VOwurNCcdKz5nx+VdGXHJyxd41c5x2KTRRHm4AwEanQa
         CGYbKyeqgRbKuVGwOmZvLMyFDNq/8Hsfw1YvUMt1BEZpVCnXI0jRPeACyxtSi8++F8bX
         y5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KVBTsjWVsXH7/FkzqpUy1kZWPM9AqvC7WFZ8Aad8JA=;
        fh=kHW+1eTm8Ddsyfk4PjHCchjczF7WU3AiZ+8qtzJ3ElA=;
        b=i4/Yz3irJKdkP2lDh+iVciEmF5ABdyGe9s8rWaXnn01JRBIP+ffdSyT7aQDz7ASKY0
         DnwfjV/MkmudeFwKn050COdofZbRdTD5mFhzp4yZGOOIJYXKaGMJzZsCQpOF8Z6AHA1S
         rzzE77qYfb1eAU1/pSpwQz/yMWKDYgpHm4hYwC6gV/tVMH+d/YV4T6DLRtUQm5g2Nze4
         h5D5kncRpNsmd1uHbqTNvFiIqTQNoAcDVHEOloMe3xO87tvyL8Mp/8uG4Nyn1+gXTKWJ
         GuXRo9A3RoSxLmcYxcla1cZRJyDNuUmjirJBQCWPMWOSdvzU29owOkg8g/5yxwrt3GTP
         DirA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779071963; x=1779676763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KVBTsjWVsXH7/FkzqpUy1kZWPM9AqvC7WFZ8Aad8JA=;
        b=EAoWKzTMxmPqDDfC9r8FgQkzIExQRnI95omZUYBn6/Vn9oyEDscABEKAwyEggwnLwS
         C8pdXdBfnT1rVDY9PQwkCopRszEsaqSBVZVQVI2sy8wdIkpJc496amm3sNrU2Vo0vT9I
         igYv6UKdpbh8LhyV5jG/s7VoEQAlmLgr42N2X2BTyILMt4/hRK22xPBuXWhwLVGiOn0b
         C9VSYfTVJlWTi4KDIaroJcdOFdAnoeDPlRanUB3a+VIDQqKNFKkJe3aM5ShisNoySuwh
         gdCoaBuBvJEsiDhknG36gG/AZnL89U0X630BXyend2W0aa9IaFePUjBFD54pVlOQ4HLz
         OUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779071963; x=1779676763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KVBTsjWVsXH7/FkzqpUy1kZWPM9AqvC7WFZ8Aad8JA=;
        b=H2DiCnPS98trkrFPcqD5e1T3Wn6mOyq2wPVxcXynw/Kr/DT9suDXC+hoZBJeIF/2d2
         PvrV1TLmdYHOhLQsEMET2raTn2vJ4gw4lpDvgrMxvALt2D27wdfBgiLWyazKWodQmfNZ
         2HwlKmYQTcFsvrXMow7PTS+c4xkvAFMVmA5sMee2bsFMlF/HCA3ld2Q1/KCNjbYy09jV
         ztu4yWMkbFrUPCp5zZU+gaAryBjsHz3w7wDQ/KVox36dk5oLMK4eFVXDSa6SPmipDgyE
         zoeCht0dvdb5OTTsFVhycSU6B2VwBxmMbvxl0WqVp/hvO8WGY2sQuw5MbuAqi5DxP6Et
         UAiA==
X-Forwarded-Encrypted: i=1; AFNElJ9mOVIioqyvSNuDL97ekVw7xAYjfs4ag3UsGZcZksPjI+zXp1kSrCzNM8Ojs49ywFHaXWxaPLYwlrk/e1HRyWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8bwq9a5HX9TAB07kutitAsqdtqvxPvJFcUn93ohrO1rj1pgQ
	z0U1y/OVImiOh/gq2cEr0YwZ9NufvqVPHZun3H6JmmBmu5VsZWGnxzggjuaJRwkEhpBaR/KH2pi
	lvoF97QsIDTyg/vQ+Wv/ZNLwU1tp63UI=
X-Gm-Gg: Acq92OE2Az4xEXNyiHmjUOunz2afbaydSEiip8YMcDDn4AVj5m5kxBJ21PR4zP3o46u
	wxrY0pXbWykg6zco6AL2UVcaVxXAnGr7DrttG1rYNuLOASJ0OJGSTDVLTLtLI98/VM8rLWCyDre
	ZP2o+Kzm3WjD+O4pqALWWWFMy+tDYnNMga8JLS9khbzxnXe/PCkyULcraXIYfyAv5h6tEwpwi2R
	nolK7NW0NVfhrY8TkELNM3CSQ1wjygsM2lLAXtB81F4andNAUg16gOv2K4Y+qLz7eQSjdlCpjzd
	r4vI1WzO15HhgD8ZXBLweSrRDJ+zwWkC0sT124hXQ99P5gPlu6/Wbyh4iBS2JEQL8AMT+myWIqR
	Uc7e4MNQ9iJAnPSAaIMNjqKkBl+6YhNaKIdLpp2W8+zfx1n24wl/GjdMeNQ==
X-Received: by 2002:a17:907:8b98:b0:bd3:413d:c51a with SMTP id
 a640c23a62f3a-bd5178848demr676428366b.17.1779071962572; Sun, 17 May 2026
 19:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-jh7110-v1-0-fdb0daae5a4b@kernel.org> <20260518-jh7110-v1-2-fdb0daae5a4b@kernel.org>
In-Reply-To: <20260518-jh7110-v1-2-fdb0daae5a4b@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 17 May 2026 19:39:10 -0700
X-Gm-Features: AVHnY4Idk9jCpV-zhG8adjTBTd5fcWR3AHwRvmwB0i1OrPWizj_xM6iKDb1FHVE
Message-ID: <CAKxU2N9jD5Mj+ZeQbtQV+hJ5zknEbVOiniGUdJysFOSLTzMKEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: starfive: jh7110: Avoid ifdeffery
To: Linus Walleij <linusw@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 4:01=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Use IS_ENABLED() inline assigning a variable instead of ifdeffery.
>
> Cc: Rosen Penev <rosenp@gmail.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/linux-gpio/CAMuHMdX7t7VHTzybjYo3s8SU3XLEH9G=
KsxmLBbh7p4D1CT3H_Q@mail.gmail.com/
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers=
/pinctrl/starfive/pinctrl-starfive-jh7110.c
> index 3fb9aa8ddf07..ec359cb873c4 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> @@ -845,6 +845,7 @@ int jh7110_pinctrl_probe(struct platform_device *pdev=
)
>         struct jh7110_pinctrl *sfp;
>         struct pinctrl_desc *jh7110_pinctrl_desc;
>         struct reset_control *rst;
> +       unsigned int num_saved_regs;
>         struct clk *clk;
>         int ret;
>
> @@ -857,15 +858,12 @@ int jh7110_pinctrl_probe(struct platform_device *pd=
ev)
>                 return -EINVAL;
>         }
>
> -#if IS_ENABLED(CONFIG_PM_SLEEP)
> -       sfp =3D devm_kzalloc(dev, struct_size(sfp, saved_regs, info->nsav=
ed_regs),
> -                       GFP_KERNEL);
> -#else
> -       sfp =3D devm_kzalloc(dev, sizeof(*sfp), GFP_KERNEL);
> -#endif
> +       num_saved_regs =3D IS_ENABLED(CONFIG_PM_SLEEP) ? info->nsaved_reg=
s : 0;
> +       sfp =3D devm_kzalloc(dev, struct_size(sfp, saved_regs, num_saved_=
regs),
> +                          GFP_KERNEL);
>         if (!sfp)
>                 return -ENOMEM;
> -       sfp->num_saved_regs =3D info->nsaved_regs;
> +       sfp->num_saved_regs =3D num_saved_regs;
yeah and this is used absolutely nowhere. Both for loops are of the form

for (i =3D 0 ; i < sfp->info->nsaved_regs ; i++)

I really don't think __counted_by is worth it here.
>
>         sfp->base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(sfp->base))
>
> --
> 2.54.0
>
