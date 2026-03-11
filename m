Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BD3E6DDD
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255315; cv=pass; b=PDgAa9awU81gbb/K5CxaQ/EZpV/IHEwmqpUykst2Iqm8yTFffwnyTetef7s6r8NNI0PqCSEI9PSX+TTUCO6aTBuqaoKezL14em7UNxcYftOxcgftHDOqmFXAEoKGw/1Gg5jIKxd6bREjIy21UcmMKAxnD/qm1DmX1AVXlBvTV+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255315; c=relaxed/simple;
	bh=irxwBx6UP69oFnPVwuxdcfosSKIVNRJAx/pAMZWSGhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hElG8/AwhgvRycyn1H3jFyKucXeU+vOR/wPEKRhc+CtNQju2RJy7mfEILE2vK1N/DzodRdzCYeIKn7y1fI8khR6OmxykDKyZ0cE2A08Y9mtQkJmueQtTdelvEpDp9dwRjSt/rQTzwT0644RMxQwPPRN3QcFDxLPQkptQcip/Ur8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bECnSL7+; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bECnSL7+"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-662bf05f7a4so166192a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 11:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773255307; cv=none;
        d=google.com; s=arc-20240605;
        b=hAFnSDpqqYV9Azbw99sdwRXypd9Fry3DMc01ITNBHMm1cNmIryQGfu23Cz4VZwzsvO
         HdmNL+xuNdsLzm3Z1XYyrCDz8TWDTGNtTyogLAEJELOq039bvZ7dk+7QOIL/utaXfDZ4
         nsEWRgpUFT8NvGCfs0+HIJLYWOlxRhDzCO2GEcX/qyD+l4kgh5P2RnDSbNW0GuWPP2Fz
         Aj0BiDz9hh0SPFf9pt0lBYfP4VT8KSRM2xPIB8wmiuk1uAhP8p+52TfS/cPHreoZUJo0
         KNDX8YpAqdlRbqqkEFxjgTiAWmqnqchvc+u3Hp0v8yODfdReyp9HLdaxuN1pyTrkvlvk
         5oaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hHaBAq1X6Cs9R/WovG2TDPIdkyxlD9U7dFf+lUqKaZ0=;
        fh=lmt5riVj0CW1yM9NmMiyGEyOuOlNsqwx1vN/Br5aPhE=;
        b=hCS8AGTtq5M99Ou76mCu9l/sHcUAIBp5fCs06b4fTAT13Tdw8F2etaXhxnghIAe+OT
         dE1J1RjJkMEmFNxlMuI/JRvWhBRV+6DY6+xG8rkoULBGCUCgzPrztpZVCe5B1zLn82Y7
         0zoyxJSmnm8S946g6ACsdI39w6/w9USOwA/QcCiXh3zYbzBc9pPA0IOl4zre/LQ35BWF
         Pjr43+ovQ6dcr6kz2gJNJ9bJwPxCHvwQHuevgCvCPl1as4XkWvSorqosLQDLGn7jerYY
         ZVjAuKFYiQcMOUb2RN+osRvkci4OkbWWrGPR0Lll5KSLyeo5aMtUbBj0JKA/oyhI3w1F
         UyWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773255307; x=1773860107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHaBAq1X6Cs9R/WovG2TDPIdkyxlD9U7dFf+lUqKaZ0=;
        b=bECnSL7+eP9KFKgOMAqfs2V0+7MyCvE+Fa0vmsxxUjc20FzB8I8Hj6vrfTJjGaKPAX
         Djg9nbqWr2nsP3+yZwzMbSUbU8wBVxrpPfDTDdExD5qHDBVBCh+FcvxOaTquYtVEuqfg
         QmL2iVUdTmAcM66JCsxyzcADK8Lxun93awA1IoeJEz0sqONjOvslr/Tj6qeYN3d7CJoV
         y+/XyEzW4YuAqqjRPoV8PRfuDSyIaFwMECmC7QUYOpwotHF0D0miq2t/gYSOlf1HTtkv
         KPSZ39isQLTl7beC1Iqfxwaxj1j+Nu686iypeeBblPCeLQG/og+fy8OFKVha7cCpKKVG
         9UGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773255307; x=1773860107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHaBAq1X6Cs9R/WovG2TDPIdkyxlD9U7dFf+lUqKaZ0=;
        b=eGcwEjsPfbcvKJmfLOWcO4kU99wdfNkUcEXM7BTTw9wPHAPHao0xa2fprerqegnVrY
         bg32cdDUPESQ8WaQfJMtF5eWp5r9rsx7Qi+6GwAE/+ZGBYtsDeHPLItQvuMhwWMUhOXc
         moF0SQjssBROmJ6pMS5bqXtiYE0RIoo3DwIOMVClIeVjC0rEeLRoO2tWDBIJPwC6CpJF
         0cfYKNgjQyamzLQkECAs1/pC1OWiMY/fJChxARvLjptyir99Y9UDVPAoUOfqxD7hFquP
         P599Og+rASbMHwOBXhkjob4RmSjanYiSqBZNberbTcKdoRV2M8/ybfa2ykyvmwMu3HBL
         Ak7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRFyGXLxBE9x4A3qPCRBvM6u2ObM3WPFSydAtUIxHzLnCcP0AJK2VNAbblsJackt38CrayV7Vp8rriVXyL8+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4I4XZQsnlscIVbL+Ozes691vQcjQG8Wu3LMsEzX1a/SK3bKYH
	eGZ82pVcFCt8AY42RTo5z7DYIxtpwe9ljfydbBsTQAQdokNZ+h2aG1Hmvo8InM4HxGSEMuLamsA
	FnMBMEjupJtkokYjNvBmGksmCHvr26jo=
X-Gm-Gg: ATEYQzzR2ZhOW6QnZkVFPMiGrtRBBL1k8QKnxj3rxL5LmTlp6fkYF/a2JOCvTdpaAgy
	IlvgyHKEBK8MaUSlWaEL/Xte0NfHnOrhA7EHMIZRER+lOnTx75C9MjTKTclnD4X7DgGnf3vwazx
	aIlR/A2BqavKpLdaBvgbiLhsq2xUdXNz8T5Axv4wkutrjTSXqPwO7onut+kIIxMZk+zHEUhZFGX
	RlQtPGrHEpbhOwSQEj8F3/oDiykBx0p7n0pWhzFja1B7MWVvRlZQjyryS6gQRYcGzO3A9s7CDpM
	e/DKO2zSNw9dPHk4np6ztQw/iqce6DTTZrkXgydSq0b9hEYxb5y8e9c2fLye1S3fqyKcRT9djDn
	rFOIuc1ycrthJY1hu
X-Received: by 2002:a17:907:980f:b0:b73:544d:b963 with SMTP id
 a640c23a62f3a-b972e1fb818mr215294466b.13.1773255306700; Wed, 11 Mar 2026
 11:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306222148.8200-1-rosenp@gmail.com> <2026031127-siding-caress-7ed9@gregkh>
In-Reply-To: <2026031127-siding-caress-7ed9@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 11 Mar 2026 11:54:55 -0700
X-Gm-Features: AaiRm53qW5bk3kKh7rdlWXHeQ5YAkvINL-7BQnfjicz7nmTpcD6zasMPluist-A
Message-ID: <CAKxU2N_dJY60Tp4UgLMZ97ZJywNEktmA1At3z6VOPhhSCRx-1w@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: simplify allocation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:QUALCOMM TYPEC PORT MANAGER DRIVER" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:47=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 06, 2026 at 02:21:48PM -0800, Rosen Penev wrote:
> > Change kzalloc + kcalloc to just kzalloc with a flexible array member.
> >
> > Add __counted_by for extra runtime analysis when requested.
> >
> > Shuffle some code in probe to provide a clearer picture.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../typec/tcpm/qcom/qcom_pmic_typec_pdphy.c   | 27 ++++++++-----------
> >  .../typec/tcpm/qcom/qcom_pmic_typec_port.c    | 26 ++++++++----------
> >  2 files changed, 22 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/driv=
ers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> > index c8b1463e6e8b..4b3915c6894a 100644
> > --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> > +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> > @@ -95,13 +95,13 @@ struct pmic_typec_pdphy {
> >       struct regmap                   *regmap;
> >       u32                             base;
> >
> > -     unsigned int                    nr_irqs;
> > -     struct pmic_typec_pdphy_irq_data        *irq_data;
> > -
> >       struct work_struct              reset_work;
> >       struct work_struct              receive_work;
> >       struct regulator                *vdd_pdphy;
> >       spinlock_t                      lock;           /* Register atomi=
city */
> > +
> > +     unsigned int                    nr_irqs;
> > +     struct pmic_typec_pdphy_irq_data        irq_data[] __counted_by(n=
r_irqs);
> >  };
> >
> >  static void qcom_pmic_typec_pdphy_reset_on(struct pmic_typec_pdphy *pm=
ic_typec_pdphy)
> > @@ -560,31 +560,26 @@ int qcom_pmic_typec_pdphy_probe(struct platform_d=
evice *pdev,
> >       struct pmic_typec_pdphy_irq_data *irq_data;
> >       int i, ret, irq;
> >
> > -     pmic_typec_pdphy =3D devm_kzalloc(dev, sizeof(*pmic_typec_pdphy),=
 GFP_KERNEL);
> > -     if (!pmic_typec_pdphy)
> > -             return -ENOMEM;
> > -
> >       if (!res->nr_irqs || res->nr_irqs > PMIC_PDPHY_MAX_IRQS)
> >               return -EINVAL;
> >
> > -     irq_data =3D devm_kcalloc(dev, res->nr_irqs, sizeof(*irq_data),
> > -                             GFP_KERNEL);
> > -     if (!irq_data)
> > +     pmic_typec_pdphy =3D devm_kzalloc(dev, struct_size(pmic_typec_pdp=
hy, irq_data, res->nr_irqs), GFP_KERNEL);
>
> extra long line, checkpatch.pl didn't complain about this?
>
> > +     if (!pmic_typec_pdphy)
> >               return -ENOMEM;
> >
> > +     pmic_typec_pdphy->nr_irqs =3D res->nr_irqs;
> > +     pmic_typec_pdphy->dev =3D dev;
> > +     pmic_typec_pdphy->base =3D base;
> > +     pmic_typec_pdphy->regmap =3D regmap;
> >       pmic_typec_pdphy->vdd_pdphy =3D devm_regulator_get(dev, "vdd-pdph=
y");
> >       if (IS_ERR(pmic_typec_pdphy->vdd_pdphy))
> >               return PTR_ERR(pmic_typec_pdphy->vdd_pdphy);
> >
> > -     pmic_typec_pdphy->dev =3D dev;
> > -     pmic_typec_pdphy->base =3D base;
> > -     pmic_typec_pdphy->regmap =3D regmap;
> > -     pmic_typec_pdphy->nr_irqs =3D res->nr_irqs;
> > -     pmic_typec_pdphy->irq_data =3D irq_data;
> >       spin_lock_init(&pmic_typec_pdphy->lock);
> >       INIT_WORK(&pmic_typec_pdphy->reset_work, qcom_pmic_typec_pdphy_si=
g_reset_work);
> >
> > -     for (i =3D 0; i < res->nr_irqs; i++, irq_data++) {
> > +     for (i =3D 0; i < res->nr_irqs; i++) {
> > +             irq_data =3D &pmic_typec_pdphy->irq_data[i];
> >               irq =3D platform_get_irq_byname(pdev, res->irq_params[i].=
irq_name);
> >               if (irq < 0)
> >                       return irq;
> > diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drive=
rs/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> > index 8051eaa46991..7c5cf8061f04 100644
> > --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> > +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
>
> Can you just convert one driver at a time please?  This should be a
> patch series.
This is not the same driver?
>
> thanks,
>
> greg k-h
