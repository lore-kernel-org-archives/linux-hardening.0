Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF833659FB
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783770; cv=pass; b=S6ANUUzHpf3t12nr+G6PknjadRsIkFEhhjq3bfiNY2eOYbXyb+QdCoPE9Iw0J6m6VX1HbwmEJi/xv1mqvh/8IXYly1BifiCKkGhCNGbta1rGAk3ZEvRtjeLOqfzy7bbKsvfxIdY4nnGeRzFbM29tUR7zG+aaY1Hx/5PPCAClyzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783770; c=relaxed/simple;
	bh=nhdxmG2CnVr/CRr4beMAPrLypobZ0ZIzUMCKnbLP61E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8GQtBytL9p7GSTkk6W7iwNiysh1J/TFecArgiRLuy489eGj9FwVuFBxZK/a9m9/Dl97yD5c3yMjzCE1Dc2v86pnVZZDrDxBU7gMN8x/sXOXK+spVQA0+r1Z5ggIN6ACtKaGW+Dx/DY7ElIiyQiV8czuNU4Kn93vL6qVtHuKnHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb36f0SG; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb36f0SG"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso2566767e87.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 18:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782783766; cv=none;
        d=google.com; s=arc-20260327;
        b=sqsLRFmy+LZa/DrlGEjDUJqEBU7eKWWiG+SfazVIb8ZuvMy+JXDkC0mkBBfsUQIRb1
         QPJxhiEDp+5z4/6TjmhsEfkNN1tYjl4AadNM89VaodKHKobR6dGlrAXFMP5taYv63oC3
         jcLSfrjGzTvN1q8flworFzkmGd5fYhDcAGbeafcWcLw1hIEtog3yerr5Xk30gmOiubkU
         hnOEaHQSPY2GSneCqgB9XvA089bWK+6/nPfPiHQ/XPWXIl8PMF4mpsu+lM9sAgCtnZZ3
         MMIKeTXM+o3TBv0x8UQR38B0OWl7/JRmRID57/t4U9snpM1y61NwiZmQRpBXhz03PZBb
         WU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=54ZSdcYDtnus7s+PnlVyh1eGHNk8J873Vy4LrzmGSk0=;
        fh=hfSTI/c8PpKVVHDzTQwpP1A8auiiMmn3aou0mpGCAgU=;
        b=pdOU6nsG959lteD9Ebzules46LL69zHqPtqK5IQjhWcbg/x/OVzLRx7GuoclTYIjPc
         xtYUH2TZY0f8llsOBbC2oztRFV0NhxgNSaG7m8UEXESKRYA4leANHC8bihc9+aOgA9nQ
         7YO6FQmZFpfuEq0En+kinG44j0EI5RNCQJn/w45ohdblr34N8/25W1b4oPgvejgYY0uL
         5rSN2DUPUGLTY9lMPQqxxTPQ9T4uPAgNs2g/SqcY4b+cu9Sw+ohICTUnSxUZu4FCBUH3
         pNXfjRgVZlqc4XzkKogvtS8VoZerG6//x8OchDHJC7e5K5gcJQuMV2YtiEgGPdP6qyy0
         a/+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782783766; x=1783388566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54ZSdcYDtnus7s+PnlVyh1eGHNk8J873Vy4LrzmGSk0=;
        b=Vb36f0SGBnaDOf9LAXYNFJ92O8TYawJBwyz4dumckLlqCN+06l81blLL2ZOZ+uv9Ud
         BejmZF8A+tTeloehwic0RcJ5ReyFXxwEtlQY2fSL5tn/ZXHfPSKdzjcNHnz8DTD4kHsf
         wtB+wz/clOC8wXnWAeFSxYeHqUn986FMlVjYjyIz/DYgzisHz3NztRzX2Lv4MiIQeUW1
         eqzFj18FSQ5eqXGjaN5Hjw8KFp+vl0j2u3GWXKnFmv5CmYG7GJw1Db22HbQeeGV1x58+
         Pu8KyP/HoWD1TF4XPlDPMx+9ZtKokf+6VuRbRZ+OQWDyepLVuphZ8uP5U7QdaSsKNO4M
         +3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782783766; x=1783388566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54ZSdcYDtnus7s+PnlVyh1eGHNk8J873Vy4LrzmGSk0=;
        b=ZT/KjR0Kgmx2dYxSv6rONTKh25pc77BWNFC0c/ALcLSmV5vL0uEEGZmVsVOyx0T/PE
         hQuI4nbZo0HcCALw+ymRbDNVG84AYnu0Oi7AgR3y5EoSpo7hbBGlChDtOjmFV3/QRYzN
         0vNXlmy9d0sKpP8hFJpIlmlNzJj60Q1Z6h3wlKvt4AllptwiHlOMDVGzhqchttMaRYO0
         Xt8YSLnLQXCmyWxTYQ7zbCJCvXzEbrvhT4ywCLJYx1iZFhH/+mIb5TYJFHk4xHvNaOxc
         qfD4bbpCvVsjAIBnH8+1vxvInfv3GKO6SdzyqYJ0gFGUGJiaNpMRSLLmfwqqG6pceV5y
         8gYw==
X-Forwarded-Encrypted: i=1; AHgh+RoezFFoWU1SEueH5idAvV6jO1FgY/ibmPolOZs8TjUDUi/ld65iERYdURueY8wguhlZk0wmHLVvRiAi/xgQn4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUdHwq89o38UZrsLGeS7baQd1KfjfboONZBTG6s8bqliDd71oq
	CdKoPUOK2KH/CQyGT5XlG+wAwvlPaZD3X1ejZ+xxSRkmeq/+UD3qRLi9EBj4sR4+7XaoaqzKnsW
	Ue37NCA0z6j7rFUz2R/wff+83TNGMrIQ=
X-Gm-Gg: AfdE7ckEZj9Wl43l8W1/dJc/bhqiOO7cXsx2fT1Zw02y4bS1fAO+h0ss2Pg+UqeEyaL
	hCYQEkakhiHfDEVkS0aDhdn066jc5aLtZzwQrVm4zV8hK6rBXvcFpHtuvO06/uqmc9XFTp2fFNJ
	tkDIxA+xs8gVl0p/07LZNHSRtUMc+FrUq/o1DxZAlerjYcMb9HKNtP32kRaU4aHxB0Pi/rlzJY1
	vxdN/pw5ViUdc7YDb9McqO/0NQVGBOFaRItuEIoTXqwSZI1Dhx2OUUJu8dbvUFvaWpE+kyX9so2
	IgHhoCCVtMzXsh0vIr2hfnGBSq9aUq+6onX48hNO/qmGr/Ebi1gUTODRzpwd9S7rlqGVrAHL8ZM
	jHk9IQPFvWbhhqYMDNP8eTzc9xsA=
X-Received: by 2002:a05:6512:15a7:b0:5ae:b489:b844 with SMTP id
 2adb3069b0e04-5aebdbd1019mr285139e87.32.1782783765734; Mon, 29 Jun 2026
 18:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504031209.618949-1-rosenp@gmail.com> <20260506110910.su2s6ncsi2xfdiwm@pureblood>
In-Reply-To: <20260506110910.su2s6ncsi2xfdiwm@pureblood>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 29 Jun 2026 18:42:33 -0700
X-Gm-Features: AVVi8CfGsOdNjYThOJxFiCSIqzZLS1O4KyLXKY4lRZyMqOtKIckcWa9Mym5j2e8
Message-ID: <CAKxU2N8PUdxo54oHtcroqe+Q88k0obxPg_9OCRsNsoOwvcS25Q@mail.gmail.com>
Subject: Re: [PATCHv2] firmware: ti_sci: simplify resource allocation
To: Nishanth Menon <nm@ti.com>
Cc: dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Vignesh R <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 4:09=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> For some reason, replying drops the CC list. manually added them in.
Found the issue:

https://lore.kernel.org/lkml/20260630014129.1548147-1-rosenp@gmail.com/T/#u
>
> On 20:12-20260503, Rosen Penev wrote:
> > Use a flexible array member to combine allocations.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Fixup k3-udma as well since ti_sci_resource is used there as well and
> > needs fixing up to use kzalloc_flex.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: add k3-udma fixes.
> >  drivers/dma/ti/k3-udma.c               | 180 +++++++++++++------------
> >  drivers/firmware/ti_sci.c              |   7 +-
> >  include/linux/soc/ti/ti_sci_protocol.h |   2 +-
> >  3 files changed, 98 insertions(+), 91 deletions(-)
>
> Since majority of the changes are via k3-udma.c, if this could go via
> dma tree, it would be nice. Else, please give an ack and I can carry on
> my tree.
>
> For the following:
> Reviewed-by: Nishanth Menon <nm@ti.com>
>
> > diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> > index e027a2bd8f26..04d99c1fafa1 100644
> > --- a/drivers/firmware/ti_sci.c
> > +++ b/drivers/firmware/ti_sci.c
> > @@ -3574,16 +3574,11 @@ devm_ti_sci_get_resource_sets(const struct ti_s=
ci_handle *handle,
> >       bool valid_set =3D false;
> >       int i, ret, res_count;
> >
> > -     res =3D devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
> > +     res =3D devm_kzalloc(dev, struct_size(res, desc, sets), GFP_KERNE=
L);
> >       if (!res)
> >               return ERR_PTR(-ENOMEM);
> >
> >       res->sets =3D sets;
> > -     res->desc =3D devm_kcalloc(dev, res->sets, sizeof(*res->desc),
> > -                              GFP_KERNEL);
> > -     if (!res->desc)
> > -             return ERR_PTR(-ENOMEM);
> > -
> >       for (i =3D 0; i < res->sets; i++) {
> >               ret =3D handle->ops.rm_core_ops.get_range(handle, dev_id,
> >                                                       sub_types[i],
> > diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc=
/ti/ti_sci_protocol.h
> > index fd104b666836..7632bb11c862 100644
> > --- a/include/linux/soc/ti/ti_sci_protocol.h
> > +++ b/include/linux/soc/ti/ti_sci_protocol.h
> > @@ -599,7 +599,7 @@ struct ti_sci_handle {
> >  struct ti_sci_resource {
> >       u16 sets;
> >       raw_spinlock_t lock;
> > -     struct ti_sci_resource_desc *desc;
> > +     struct ti_sci_resource_desc desc[] __counted_by(sets);
> >  };
> >
> >  #if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
> > --
> > 2.54.0
> >
>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
> https://ti.com/opensource
