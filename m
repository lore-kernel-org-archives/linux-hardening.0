Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142C1FF61E
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491817; cv=pass; b=IRb6cnXjkP1zaQVAni7c9gxlYAJYW2uL8q3kA7BEgCsseFGyFzQ6pgnRL/qHESu5Xo8ln119hUwYBZrHW1amLbvPTF/bkezXXOupk+saU8TPITTYPE7lHf/qNBF7lvxCKNo16lOd4hPiE4P3ET8lRufAh5fY7wiQkM/Ww5lmf8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491817; c=relaxed/simple;
	bh=BI/2ZzBnY7PxSi9Tr8bBTb2UihcEEreGXl3MBqk5W/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGd2tbOOUnoli9t80alpLMcJgtLdwrTrF7IIqMHlFwMF/5A53rNbUNS7u52pE60p2xbuiA59ZLWXPNa/58S4EoGBOJ6vDGCFSh2/Nav365wLcqHUjmJlELcrtI2iI2spAOAULPTD/GrtzUAQemAddPdHfPiAMXRwQ/JkK/3b00U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpyrGKNr; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpyrGKNr"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9b1df1a6b3so51184366b.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 19:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491813; cv=none;
        d=google.com; s=arc-20240605;
        b=UIuRTfc/N9X2P76G6P2mf/CpV+8Sh6o8YjkREcTorXEVRgaNjjB8T41xt98Qgncbsl
         9NrntsmVWDlrgT4jvcKd/SsVRd0pJkjG/ICovmdIHIGHW21SZTvTAsnqtEgBbECgPlpf
         SHjdf7+PpCmCyace+Wx3ImjK8TWOuid9ZXI4U3B+w0QUm21IhyhVn9rzXJgojEMv2Mmh
         jE5kbwLISsNFL3W8l385GmVMgR1yc6sr2pnBDjdbnTYhRWufQnc09aslNfCFYMDoI+/H
         ftbayxA7wEnCNsclK9y4c+jtMWI1VsXc1P3cO4OlxAyS9CAD4gKBOPJO/znhcwCjErGb
         UgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0s9BYVcUXYfDOp1vglCDYA9VUszvYb7bPcrqX3W0hQs=;
        fh=5mcjdeTZgoUpl/WnQ4iBOLJTeHogYiIEXfi6DaOVeD4=;
        b=MkxD3J9llCOjt3rihITjk8Ku43cRL3zVfy6xD3bbOXvD9qWowYB950B3Es9ZqpaXri
         J96VDooCfy93woP4zkEPrCRIfSMkseFuKrXqTXIjppGtuc7GB7KNXKxbe9hNiSI7OC+k
         zY7x4w5g5dSjK1x8NYnUZ9P57iOERd3YLxAqB8FyLFf3JxoFFVAWwfxxkY61rBhqspx8
         ks6khnAzBLTr4BR3G/yT7bV9TajPvmZI55YK8sqaKn9ZnuWNCsrqPaPG2mgsaQjRczhZ
         NrbzaBhloiql86YNh47IuK3ohSk+Y35TH1bC/kZNCOYtfRAVXMZPIHmYhph0uKH6dG+6
         GVEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774491813; x=1775096613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s9BYVcUXYfDOp1vglCDYA9VUszvYb7bPcrqX3W0hQs=;
        b=EpyrGKNrM+85hsIy6olGYgk14PcgGp6/QT4GAFwdhp3bZeT7Tx1PZQyDHYBUr8su8e
         cjuUMYIPh16KzW58qnhm++qZDIrA0LMdgjuaeHGmzFSq3kmQ99+Drj/DfEFwlGTr/oAM
         IMLGAXT+KcjHcMtdofRoz3aU7jSGMqT2ZuRIzS/gU/MaF92sZECytkTS4QvX66EV5MjV
         2MkryB0kd55PQgluXu/ufrinME/ejzVYYM2gRnolWYunlodsWUfPjLjxaBN7m3+gZFip
         j4pE+avSs/uIDimNscQWuDKieUw04gtzmUWgL89t6fZw6kGCSljDrLv0/nqpce1bxGMK
         vmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774491813; x=1775096613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0s9BYVcUXYfDOp1vglCDYA9VUszvYb7bPcrqX3W0hQs=;
        b=cUOeMw07XvejaKOWDFvIiXYGZHsJiqNk3/l9Ljhoh43Xn+QcksOsS/alfdWtlfI8eK
         OFHtaAJIdey3lqAAajU3r/t+O8BL8pihx2DmHrvvFpOhso8021aOYDNtXuFMvvjUkgQy
         gQNHsbTTK6C8HSdpnx6PLEZsW6s8HHsUtaWNRjbKGtLry1S34oLCB7U2M8Dh+0TeuyUd
         deOfUyqxYsmsk+VZ4trQg8mKQ8vrst7gUnrIfKQEvEHECn2rGBG2f7bhQvFH+SMq2Vss
         D0FzdMOSIFYqplVm5ery/mweZ3BZUROeW77VHbMJxHCFI+SwuP7c5VsH6rW2w4WzT2/R
         bmow==
X-Forwarded-Encrypted: i=1; AJvYcCVImL/3CN1dk9X/m8NSR+8vd6DTN4B7XALeCyIst2nMsIPh6XWJWt/OZbshwNKinb2W7IBYQMoqIICV0pxzGpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXs9V72jYMIlfqjCZniOfeoM992hQ8yJgZ55OJWSqatkZZXzw
	DN2W3GonEb6ub6/CjuyvTYRl5eLZ4+7mpu8YNPfJJYZ0u9UhBsSyl8FUSZTG5K79kFJD+PZS0De
	1OdHc+cz/b8AuBAMzjjUwxKFJmTo1IGA=
X-Gm-Gg: ATEYQzzrkhprT2UFMysq03n/Pkd+priCGEncUwq5UKyKGHvLsZPXg/bPhMnJGg3aUbK
	PL3dIEe21LTKGH6S6+AoxrZkEapVXSxpyezyd1qmmjUPjIdw3ofe2xXkYdfTD9YaWap2CwIGkYZ
	FMIwqjPekHa2yTl5RVBtcYVNRGJWOR59Z0O1sy2BgMct2+IRCc6CLsAQTmHK+dQBrsbf8ZSC9V1
	967GxbI8X4/y7tHrJqzG4OE3eqd05rlc+7reObiXX351dkhWPyba7nb+EsnoY3iYhkIMb9cEBKE
	5P2F2OHX7tVAQJsTDKzVYmCN9dSUTZTQQWS0RGkSqtTm2s7Cm+QDPpJurU0/rq9ST9I81Rdzo4s
	XP2E+9A==
X-Received: by 2002:a17:906:ee8e:b0:b94:cfd:f37b with SMTP id
 a640c23a62f3a-b9a5426928dmr370259166b.45.1774491813119; Wed, 25 Mar 2026
 19:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324032243.26387-1-rosenp@gmail.com> <20260325172734.GA334461@horms.kernel.org>
In-Reply-To: <20260325172734.GA334461@horms.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 25 Mar 2026 19:23:21 -0700
X-Gm-Features: AQROBzDvM9KixCzVDe_3rsnW2weihEvz36neZ5eOgzFxNGkIRclOewKV8fXC478
Message-ID: <CAKxU2N9RJ520QS=rsXujp1RUs=1=DvyC_JF_PNBwnCn4fkpN3A@mail.gmail.com>
Subject: Re: [PATCH] atm: nicstar: simplify allocation
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, Chas Williams <3chas3@gmail.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"moderated list:ATM" <linux-atm-general@lists.sourceforge.net>, 
	"open list:ATM" <netdev@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:27=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Mon, Mar 23, 2026 at 08:22:43PM -0700, Rosen Penev wrote:
> > Use a flexible array member with kzalloc_flex to combine allocations
> > into one.
> >
> > Add __counted_by for extra runtime analysis. Move counting variable
> > assignment to right after allocation as required by __counted_by.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> To be honest I'd prefer that we discussed deprecating and removing ATM
> rather than cleaning it up. Is anyone using it?
Beats me.
>
> > ---
> >  drivers/atm/nicstar.c | 17 +++++------------
> >  drivers/atm/nicstar.h |  4 ++--
> >  2 files changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
> > index 24e51343df15..2f6a3637aeab 100644
> > --- a/drivers/atm/nicstar.c
> > +++ b/drivers/atm/nicstar.c
> > @@ -867,23 +867,17 @@ static scq_info *get_scq(ns_dev *card, int size, =
u32 scd)
> >       if (size !=3D VBR_SCQSIZE && size !=3D CBR_SCQSIZE)
> >               return NULL;
> >
> > -     scq =3D kmalloc_obj(*scq);
> > +     scq =3D kmalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
> >       if (!scq)
> >               return NULL;
> > -        scq->org =3D dma_alloc_coherent(&card->pcidev->dev,
> > -                                   2 * size,  &scq->dma, GFP_KERNEL);
> > +
> > +     scq->num_entries =3D size / NS_SCQE_SIZE;
> > +
> > +     scq->org =3D dma_alloc_coherent(&card->pcidev->dev, 2 * size, &sc=
q->dma, GFP_KERNEL);
> >       if (!scq->org) {
> >               kfree(scq);
> >               return NULL;
> >       }
> > -     scq->skb =3D kzalloc_objs(*scq->skb, size / NS_SCQE_SIZE);
> > -     if (!scq->skb) {
> > -             dma_free_coherent(&card->pcidev->dev,
> > -                               2 * size, scq->org, scq->dma);
> > -             kfree(scq);
> > -             return NULL;
> > -     }
> > -     scq->num_entries =3D size / NS_SCQE_SIZE;
>
> AI review points out that previously the skb array was zeroed on allocati=
on,
> which is relied on by the code. But that is no longer the case.
Will fix.
>
> --
> pw-bot: changes requested
