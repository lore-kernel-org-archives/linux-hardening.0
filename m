Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55735F614
	for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108055; cv=pass; b=RS1OFjlllVQSsTUyzPfOaDLbGq/gqZiUzmQlI0HQrdu4byQxLPo8N0JO6dPFbuQSkzVB8Z0k/A6HSpu7e3jMdyipbMU5PlJisjkbspFi5UXLnGBSSOOEUIMyvTD4GmjFq+g4sCGl8WVUxLK22lJbTd8HeGaeIaHgPtXU7RjGX/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108055; c=relaxed/simple;
	bh=gOZHoGsfMHU8YEyRDbAh79rI/Dyzjr9SzF5coRCsLPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A60pRLaFe0hEDOSwJh/tWuRcOuXlCntdZvx4sQIla5mAlHP07GEg78fdozyWtgtnIfFPufyt4PKL3RsiyV54eN461Z8tWST4+JPeojGBfwnYljE5ChwgHkBxmKQwD9LmrdxDWmXOLMLwrgycGwEDQHNBGTj4OcQhjmpci4+mYrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRyJlnQM; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRyJlnQM"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so4691613a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 12:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776108053; cv=none;
        d=google.com; s=arc-20240605;
        b=cwLelvWdU0Cz3pkldYxFammj3+9Qnu/mmkG8Xd4rj9fGLgCoVbhfxuL0gzOk4rd/kd
         Jhe+U+2aoNb+5/lVppGjBIe/sd/+A+Cnne0zdDJrXaAtFqyhERliwrPMFGzWaFCzYBdj
         RWdLI6uTCQ9uFeF99eQmmPgtZTSeUzEAXnUrAx7I/MovJH0Q41j1RYuL1jNxIhLCwAsw
         /vlbkxlEeOAift9YaBIWJZiOWr43YUFvnSCsCd8raVNnUAOsT3UOKvaTHQmsm4qeDWBZ
         TEFdS6w/iv4polBFCQ0oEG34TqJWcsP5TwjF6vRNOOv7WVYXVmbZLvXp0wYDJgIgrapv
         zwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6j2DEXG/4irDMZVc5XFysACYZ5vdAPgoKfQ75xHiNk8=;
        fh=mxBDJZthEYnzJLdPJWJ0grw1UYwJlJj3zJf3CTKmbLw=;
        b=Uk7D9gDkU4tkyz+quXlQJt4k9Wo+qWvUmSrmnVflhwD7JK5tx3A34jtgWYv4E8RWG7
         ynw5xATwe15bfr7IDJdvPv9dKmDbPLWAD5s8GYKfA7qGwmoXl4ZJD780yAQpe5uTNwWl
         JkMdA9O01GG3gAppw9SkOrgcGEcYk18ixP4tXNYPD7XrNk7vnpftU9M5WHSnuFHTK79+
         EuDeuSgqlfumv94ze5mLHyFidXRQpQh9O1aTqCeC3VosYL/vkDjYV1JvPxVWufdwW8HZ
         9rnj5pNiLP0/tcplIhEwtD7GI+xpl1in2jga47HhFVvNNXEQvaBS1hHGSFtgVXxMkJFL
         JYkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776108053; x=1776712853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j2DEXG/4irDMZVc5XFysACYZ5vdAPgoKfQ75xHiNk8=;
        b=LRyJlnQMFPoHrVT0lHiyOmwo6kPeAWNdjjVGAvwCeMyVfC7CJruGFSZ7NPaO4Q6hLQ
         InW6K30P8CQiusXjEqyKULqlwZcu61/cYeYDw61WoAsNfpg6GGE68AAabIqvxpm7BQ0w
         9KJsPA98oLrgm1Whs7jsaFd9GoIjQgufEbyl69VeIm4sFREGz9J5i8TEc+BrxYSp9SO7
         dPvrQz9sdw8g3K0BI8Q4Y6QHlvwpS2LajlQ48/Y27RBJdv7FcG8U6mw2Zq4voX+6Ttub
         U9YgFSqHQvyPgf4bxz6YgUWLP3dt7bWWVeSXPO1Q4GCAVXTDgVbNKKJrn4dWueW1kUNz
         JKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776108053; x=1776712853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6j2DEXG/4irDMZVc5XFysACYZ5vdAPgoKfQ75xHiNk8=;
        b=Yl19h0Wh7bTu+lsZ+WJMBmrVxmWI71pa05USzAFHiklNkzJvJ9yyKjoS2pFtjL9edV
         9hLGBkvJHCWsy0mc/RGr2gsQLEIv9U2ijeWehEoyIfG+r1biM1oCS8GSDAvq4yEVqI3k
         Uklv3dereKKFbm0RyI/FD0FBrhMDaV3Vya2VPhQyLvCRBwMjjRuowU38zNACq/nfgqG5
         RS7gjdITcgDzZnN0JI2fusA1QpaSK3pRBOTcSg1X4drBIHXM8COlrvDEb4nL8Mg5xMki
         oFQRLN4mqoi3xzZfkFRPB4uz5Lc9NFjNwvGV1dDVOKdzYHGvGzs3rMay3eHd3eZ7How8
         FX1A==
X-Forwarded-Encrypted: i=1; AFNElJ+gKmg5pQGNYZmqOKxIK1YEgI7xMG5Sqh5L9H0H16In1qvfi2Dal+hps99L2qdafyCzb7oJGVoN9XKvrOA3u2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgk27Wdzb3Rms6L9oW1L6iNsuLyT6z0SGx7frOyvVnFlxkK098
	a8j9Y9CZh/Fquml4oaG6V76QmvscZc1PlzymtreV6H5WkArRqUeDLD9Cati9M4v0PrTbyi9xy5j
	oAWtq8Z+CZwUM6cHVIZV0mFyw+zAW3Rg=
X-Gm-Gg: AeBDieuIsUXE19OUISMOtYFG57Fzu8sk9+YUYNEtyft6k00mfZ5g7I3IzR8NuN+ENL0
	2BGya5BNqkftXXWxJJiVFKlvoQg45JBAoiPIfHoXNe0L1e8i5U2VdBQRzPC/dg+VxcW6G+c0tSx
	SPhxH63V5qStFDhhL4ZmQ5KzMsbJ89QpY/VsIerq+0lUpR/dEy3Z6VtzsU2AyHA1NG0wWZFntof
	PeU8MOR0fPfG+NkqV/iTKCRCast75k/2LNu0+aHpV1Q+sLt3Vcmq0c4PulfqqKOUyk1X/kypq6P
	1OLOUGBKC05Hz65FeHPv+APaSanOQfYPiFF8LQC9GbP4SOgBeh7+nbPN8Dlqkd2gkTSPhVVP9l+
	EaEtNeA==
X-Received: by 2002:a17:907:1c84:b0:b97:992b:8806 with SMTP id
 a640c23a62f3a-b9d724361dbmr886354866b.11.1776108052561; Mon, 13 Apr 2026
 12:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411041252.166816-1-rosenp@gmail.com> <f8ea0484-6f6f-4426-aea6-fc45f566f692@broadcom.com>
In-Reply-To: <f8ea0484-6f6f-4426-aea6-fc45f566f692@broadcom.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 13 Apr 2026 12:20:41 -0700
X-Gm-Features: AQROBzDPyJ7FUAtzKiOWMEu6eQr26UUe0KIXBelmHSjDVPDSI80zsIbF6CykwyY
Message-ID: <CAKxU2N_xvpo-vzsffPHUuNDW+Ew0gBVBupmmOts3WXJO=0D9Mw@mail.gmail.com>
Subject: Re: [PATCH] usb: bdc: allocate phys with main struct
To: Justin Chen <justin.chen@broadcom.com>
Cc: linux-usb@vger.kernel.org, Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:51=E2=80=AFAM Justin Chen <justin.chen@broadcom.=
com> wrote:
>
>
>
> On 4/10/26 9:12 PM, Rosen Penev wrote:
> > Use a flexible array member to combine allocations and simplify code
> > slightly. No need for a branch deciding whether to allocate or not.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/usb/gadget/udc/bdc/bdc.h      |  2 +-
> >   drivers/usb/gadget/udc/bdc/bdc_core.c | 20 +++++++-------------
> >   2 files changed, 8 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/=
bdc/bdc.h
> > index 2f4abf6f8f77..cc961161eb46 100644
> > --- a/drivers/usb/gadget/udc/bdc/bdc.h
> > +++ b/drivers/usb/gadget/udc/bdc/bdc.h
> > @@ -409,7 +409,6 @@ struct bdc {
> >       spinlock_t      lock;
> >
> >       /* generic phy */
> > -     struct phy      **phys;
> >       int num_phys;
> >       /* num of endpoints for a particular instantiation of IP */
> >       unsigned int num_eps;
> > @@ -453,6 +452,7 @@ struct bdc {
> >        */
> >       struct delayed_work     func_wake_notify;
> >       struct clk              *clk;
> > +     struct phy              *phys[] __counted_by(num_phys);
> >   };
> >
> >   static inline u32 bdc_readl(void __iomem *base, u32 offset)
> > diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget=
/udc/bdc/bdc_core.c
> > index 438201dc96ca..4b16b85da450 100644
> > --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> > +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > @@ -487,14 +487,20 @@ static int bdc_probe(struct platform_device *pdev=
)
> >       int irq;
> >       u32 temp;
> >       struct device *dev =3D &pdev->dev;
> > +     int num_phys;
> >       int phy_num;
> >
> >       dev_dbg(dev, "%s()\n", __func__);
> >
> > -     bdc =3D devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
> > +     num_phys =3D of_count_phandle_with_args(dev->of_node,
> > +                                             "phys", "#phy-cells");
> > +     bdc =3D devm_kzalloc(dev, struct_size(bdc, phys, num_phys), GFP_K=
ERNEL);
> >       if (!bdc)
> >               return -ENOMEM;
> >
> > +     bdc->num_phys =3D num_phys;
> > +     dev_info(dev, "Using %d phy(s)\n", bdc->num_phys);
> > +
>
> This feels like a step sideways instead of an improvement IMHO. And we
> are also moving the allocation and dev_info() print. Is there a reason
> to change the ordering?
Of the allocation, yes since we need the size.

Of the dev_info, no. I can move it back.
>
> Justin
>
> >       bdc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(bdc->regs))
> >               return PTR_ERR(bdc->regs);
> > @@ -508,18 +514,6 @@ static int bdc_probe(struct platform_device *pdev)
> >       bdc->dev =3D dev;
> >       dev_dbg(dev, "bdc->regs: %p irq=3D%d\n", bdc->regs, bdc->irq);
> >
> > -     bdc->num_phys =3D of_count_phandle_with_args(dev->of_node,
> > -                                             "phys", "#phy-cells");
> > -     if (bdc->num_phys > 0) {
> > -             bdc->phys =3D devm_kcalloc(dev, bdc->num_phys,
> > -                                     sizeof(struct phy *), GFP_KERNEL)=
;
> > -             if (!bdc->phys)
> > -                     return -ENOMEM;
> > -     } else {
> > -             bdc->num_phys =3D 0;
> > -     }
> > -     dev_info(dev, "Using %d phy(s)\n", bdc->num_phys);
> > -
> >       for (phy_num =3D 0; phy_num < bdc->num_phys; phy_num++) {
> >               bdc->phys[phy_num] =3D devm_of_phy_get_by_index(
> >                       dev, dev->of_node, phy_num);
>
