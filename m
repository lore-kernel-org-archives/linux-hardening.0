Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C836F41D
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825779; cv=pass; b=pA+bjVtdGHrihj3BaFRoU2LM1ElhvLfMYXTyl0tQkPfI+gT+ylAKn/6gH6dbzs48VqhrJTqtk8xiaLhraPGGnNrJTkX84QeaU05FCZVTp+86iMJYLA7xtd3aT6mXO8o/tj6FlrKWq/y4vyKIhsPg9B9UqWuG/q/LKc0y26Jn6z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825779; c=relaxed/simple;
	bh=kBADCY8xRTKuyS6NbFgOY6Yr3oz8xfDhJIPEL3xVJwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6wnkq+vwXwc+gpPK0zmLRyqEJuxE8jFWCPux8cBMGPMMIx+8K8HAF3AZM5y94QWXSHAKOxjjw5U996nr2Dbiyef7dfe/GdQo1HMiCLGNIrkZz9qWIa3g5AD+tggrmr5EmDdOkVc0KnT4JtrpTU0ygN+IoOB9S9kBGlJ/WM8/z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krSEa8oh; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krSEa8oh"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b941ec6a368so229047366b.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 11:36:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772825777; cv=none;
        d=google.com; s=arc-20240605;
        b=FbT+4x0PC/P0tiuGSKts4MuK9QINx7H9zl5PtTy8+9w4On5TVPBkymcaMTVkv5fIFJ
         m7lqpniAf+RoNB411kOMXdhZiZzRt/WHg9QOQTF6yYJqSZpFqdgxjT0mTCwjxxlSe+8V
         37bJmN7ZVKkD3zmsAsk4eYyMq1hdpJWWPd3ISiizZCujhOX7uiAnSSa6zeeIO81hislF
         BOj45s5TxnAsBpnogUlz9Uy3Svs5wbaA2PzByLeOVtejCxz7yb0yJCd+aL0fCh5wDFgl
         ZyGsaS5mHbbc7mm8FCFa0go6bAkLZ9Ww3lopGtMvbmmZxl9W8d9KFsXvoHX/NfoYKTp7
         IB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/oFep3QUMArP/Mg+XO3iZqRWYbfwWlvGA+rkFHJ1kfo=;
        fh=IxWuG/PLli7ArOOxDukrfwNd+CtOhd2hFCwYn0SnYGc=;
        b=EN+dkzNMpdiuqJ9yn+ujvSpHBjJEdvISmW7fHcuZOqAU4nFuZvSUZB2iaB1obFGlTa
         LuVatZ7bfuGv6nj9+HxdIuUhAwO3GUBDLgs9T15xy1/1hbFm50bt7TlG8LQMgdqIlIBI
         ipbEdZLLsVGq6ZEhG9GmVjV81qG/kYL8GQrRxM+i9UciD56OUJmRDhvQEJCRLuNWR8Us
         UKmo0vLuM24TAua3mrvVIOKZfbgle+FO0nDsfczsrqsUQjtH3jSos0AVned20xObRnJA
         QBQtNslHbxV2J94pKcqa60AYePDAvfL9WZFMnQy7TNlz154Gpw5quKgnzMX7V29+0R7x
         im2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772825777; x=1773430577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oFep3QUMArP/Mg+XO3iZqRWYbfwWlvGA+rkFHJ1kfo=;
        b=krSEa8ohVGU4hTLEE+g/nKEw8hZAvzYOlJaI3siT8nn2hICG9XHn7GByBdEsbMfzAX
         +0WGqXMNpEMoE54q6CLi6EG+hQXKA1k9elvilbP66Gidm1E25RUncFMhnuTL5s1viCVZ
         UOQVNIXrhoPVh/kuzLUsUOMQLt3gR56G/HZRwR6DFrEu540c17rds03//IG6iLg9f3h3
         7M+b+1EzvwHwsS1P6dXWPPvJGjh5XyVxB/hHOTAP3LN9DBAD9PVcuoxiNxx+3/Dai8lU
         tlMYYh02C5jBT7wbYYDLgtM90IKWQkVl/J3tEq2ynNomrHH+7IKMtyxHRn5WYd2aJzvO
         6u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825777; x=1773430577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oFep3QUMArP/Mg+XO3iZqRWYbfwWlvGA+rkFHJ1kfo=;
        b=BqLyb1aUdlBmwodeSO5keHXI7ICLTgczT8FMlkeTXjCEsAI9c733TGey27Wp1M1/pp
         6654aWCVYnGbOIkbO2SIkQ4O+YRMAUKf6+v01sDaPsG1O+OfHtqJ9pQcdIuQ5dN9uDkj
         U/SIT259MJt35Dhf+5Ouf3T+jXPn93PX1zM/X+EayDuqaavUZk7iT+/KwHcf3Zy3/OHw
         B3UXNymBAeiYcbZVfQWObtt63851naBSi1oEX4CMrnoI4hsIUqXfQxsRY7gRJ0p9FVCK
         ZAQi9yF9ozLMQWvXtpgysISpAyCW1gviAVYseraVV8zsSy5ONlg6DpARmBbZCppYu1nH
         QXxw==
X-Forwarded-Encrypted: i=1; AJvYcCUh487Zu5Llk2PE5vL5/pQokfRvXa9/Q4Q0g4qTYswmTsYesu4VB8k+pu87ryvjL1QbUZDRGytKrnodWdRMkIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk5Mz+IPRy+++FwFWdn62zy7tBfBL5Q92aIL1sS232OZYAf5X6
	BGaMT/KZq4ZrlFZDVIMUemkFWDrLdwjhTAeDTo1+3ybKsGjA51+hCW0ASyiZIVSN3w84nZ9nlD3
	jHsWlMukiGvGPzRSM/ifOWuQYqO5EFKI=
X-Gm-Gg: ATEYQzxgUo6+LozebELb+PfhIyZKnGbyX+heY0ZNLnLaGiBS5NmAQ18VOfxuRC40602
	9HMzkOgi/XWPwf4lKjf7qJTBYI79NtZLp5RbGLQhKykvrPPZg8tePeGxTONtNEVm1hOURbb+PnR
	bYdO87Q4MyzjschV7iuZPQEfBEZD/GP5I9N6rSz2RvWnACEhrNmu1rvEPPdhM3DZmPjGuloSSxw
	AYkrlKIBAjX9wMBel2LwjtJk6RrYvCrGmjkVD0B6ztts5QAQAD293ezDtqSOUHESDHzaxkPINRK
	1WYLAPwgVQmK8LL8FoRDwntLgBfI9mDe7urk3EADHE0/24Ddtv2hPcYODR0tk/DHHLsEQAygllJ
	VqiFsFA==
X-Received: by 2002:a17:906:9f89:b0:b8d:bf38:7025 with SMTP id
 a640c23a62f3a-b942dcec7dbmr224391366b.16.1772825776547; Fri, 06 Mar 2026
 11:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304232848.469446-1-rosenp@gmail.com> <72e8b51c-4dcc-4c42-9e26-8ad8f9299c76@embeddedor.com>
In-Reply-To: <72e8b51c-4dcc-4c42-9e26-8ad8f9299c76@embeddedor.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 6 Mar 2026 11:36:05 -0800
X-Gm-Features: AaiRm52MbBKFLewPkU2F6yezblScaa4YRJUtrHXt3-c7p3yL5wyd8k_-nrQOniE
Message-ID: <CAKxU2N-+hE8BZ=cf3VF0Kkac8G9KWrmvQaCnWfcVSzv3MCm7CQ@mail.gmail.com>
Subject: Re: [PATCH] phy: miphy28lp: kzalloc + kcalloc to single kzalloc
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-phy@lists.infradead.org, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"moderated list:ARM/STI ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:28=E2=80=AFAM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 3/5/26 08:28, Rosen Penev wrote:
> > Use flex array to simplify allocation.
> >
> > Allows using __counted_by for extra runtime analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/phy/st/phy-miphy28lp.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy2=
8lp.c
> > index 43cef89af55e..fd931ede7162 100644
> > --- a/drivers/phy/st/phy-miphy28lp.c
> > +++ b/drivers/phy/st/phy-miphy28lp.c
> > @@ -224,8 +224,8 @@ struct miphy28lp_dev {
> >       struct device *dev;
> >       struct regmap *regmap;
> >       struct mutex miphy_mutex;
> > -     struct miphy28lp_phy **phys;
> >       int nphys;
> > +     struct miphy28lp_phy *phys[] __counted_by(nphys);
> >   };
> >
> >   enum miphy_sata_gen { SATA_GEN1, SATA_GEN2, SATA_GEN3 };
> > @@ -1168,16 +1168,14 @@ static int miphy28lp_probe(struct platform_devi=
ce *pdev)
> >       struct phy_provider *provider;
> >       struct phy *phy;
> >       int ret, port =3D 0;
> > +     size_t nphys;
> >
> > -     miphy_dev =3D devm_kzalloc(&pdev->dev, sizeof(*miphy_dev), GFP_KE=
RNEL);
> > +     nphys =3D of_get_child_count(np);
> > +     miphy_dev =3D devm_kzalloc(&pdev->dev, struct_size(wiphy_dev, phy=
s, nphys) ,TGFP_KERNEL);
>
> This is bad... it looks like you didn't build any of these patches.
Missing COMPILE_TEST on this driver. Will fix.
>
> -Gustavo
>
> >       if (!miphy_dev)
> >               return -ENOMEM;
> >
> > -     miphy_dev->nphys =3D of_get_child_count(np);
> > -     miphy_dev->phys =3D devm_kcalloc(&pdev->dev, miphy_dev->nphys,
> > -                                    sizeof(*miphy_dev->phys), GFP_KERN=
EL);
> > -     if (!miphy_dev->phys)
> > -             return -ENOMEM;
> > +     miphy_dev->nphys =3D nphys;
> >
> >       miphy_dev->regmap =3D syscon_regmap_lookup_by_phandle(np, "st,sys=
cfg");
> >       if (IS_ERR(miphy_dev->regmap)) {
>
