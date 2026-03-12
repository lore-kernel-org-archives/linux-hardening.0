Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4E39A05D
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773290662; cv=pass; b=ZIT1KizFDMCOrsrVcKYnZ6lMStCmMSzGrq9ZP+xgadO3w6Hfsq+ILNwDEldUykKoyLARzqs0avlqA11lPpPji0taveRyMecnwSJthOzPVETF0JNYsPItpZ9z5S63kAh0dQdrfyPQIeNJLR6WlElnGrMMQbukZxma+LZvg34mA3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773290662; c=relaxed/simple;
	bh=ohdNMiGDsJ9qXT/qMT6p3+umPlNFYkYUeMT/HuXPekU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUCxhe3SVZXnc7IpSLjgBBAanZ0SZaVm+S8z5Hn4hHTkym1YLFrHijfpP7mcdbynUkOLL9JDBC4ok2n2deMgHrA4IqMNRG8VWRmnWbF9+vIRgwkMJNHwAuegD94txy3Nu9OMkw/ZqX9R0/L0FyiQmBLmzaEFdAO0CncGFR5oU0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaDywv26; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaDywv26"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b96f02b4329so88815466b.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 21:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773290660; cv=none;
        d=google.com; s=arc-20240605;
        b=PTLhfoj+F7T0vaMqU1q9RO/8CylISY9tRVc004Blhjt4DX+/Y2MMGmrEHjdzEKEboO
         EZJebV2408BJ+a6JsCMBRD9Ww8scRKZpcZ9H9Z7azWJKC5x+phUaXh4ovdeinJZ4xzwO
         ox3XyFX55d7DyA0sMtBJ3JQnhBysvXnHLitIdH+qjJwk2daz3wGYDpcSh7hVIeQSBu1B
         0GhJ/3W9RUd5bnZVQfZH2NpnuC6xhUXNLo18BRfyAtUElwACZKfIQtNRSg6Vi68GPnix
         YteVhGG5Iyeivm/FGE7RAK5tGdfg91JhLcLUI5zyrRT2SgsW7FPZFDuwcNlJ5j1zFBdF
         Q97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DmbSeeL5YKTmZzl5uFsKI4sYasWlIRX3peN9L+EGfFg=;
        fh=0etnIWcHUwU6nwGC8F46/ZnU/D3AEq2ov/JUJMMghs0=;
        b=h6ium6QD1g6mC0HVbwSH2kUfTgLfoo+ShsvPst1Z2pRi7Hl7BzI/SMd5ds/zKYfsco
         LqNc8OyWIBEfgbuB4+2QphPfW2ayeCERkHumF5iY4HNx379hIJsP5+skHwdFW6xmUsc7
         LeiAIS4g3MtffAh4I/EA51zD2Nm/A3vscIWHn/RqQETwFGXW/ojo5BYsPQHctkK3l2nw
         ct3ayekhaNhI/Pm1MAYA+M1tU2Ea+gy1Z5Vz/RYhSkP3aHCSzx7kL+9EBYb5svHVtfdK
         V83B5DdOC9R9sDtglLS0Q5hA3z0Un0CIGf7BovAbl667THdzAQt/dJf01orhlIIvTick
         igpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773290660; x=1773895460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmbSeeL5YKTmZzl5uFsKI4sYasWlIRX3peN9L+EGfFg=;
        b=eaDywv26Tdq1Zhyr06t8b+6hazRT6EAAlq4OGV6yfPj4Cd1+dO8HrKkAdkOH3TpH6H
         QZ+SgbZrp//KEQNCZDABJp2whcW6CghqDqMNqkp/NLRziiV39VkwAp5q+/tFP5mpqQrb
         wN9+6xCt5FL0mpC/+Onwy2Q0lM078tyrwDr1EUxSPW9I++NEuRekXpt7KwsJENhlrAf7
         9GX1f6fGC85VsshF+ZmuaKZAebF/wVBAOgRmVqORPstjHGiieoYsH0bSbd/SXX/KqVL3
         JB+y79M+8IH6W7KtA4zpL6Z/qnzRDkcNk4wkZmXvmHCfpa5kI8W/n72VVmu6wPw8DO3u
         wCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773290660; x=1773895460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DmbSeeL5YKTmZzl5uFsKI4sYasWlIRX3peN9L+EGfFg=;
        b=Tap8Kqe5i1HCsj2aohTw79ftk1+zQ7b4lLt0u8sDO0NGZQJyhwthKWyBlRhBGKQ+LU
         q+GDGeadVjTI6/ELhyl2BgzT2W3zyv9tqTdkQ/fqOl2L6QPSNnNOjeQgTFlLG+TdUIzm
         uzdIfp15q2YZcEqAHPSquQhPk90RZRokyb6QVm5C+bWV+aZwLhUPeeCgBAQlRHyvmhSH
         MTAQIyqsf5w/ZO5x6NUecHefqqjKavvVQr+Icieff8Bkp8zCcIJq4AjmV05x6gQPBSQl
         D95UuRSsF0T2Bw35h8kYEMAGUwpug4aBlACrqvWUzZhrGyd2ZaA/LEfe6gyY8YsyAmZm
         b23A==
X-Forwarded-Encrypted: i=1; AJvYcCX/vCXuusD/cMaXKt6T7trdEg/1+hidt4rws9lKKtSFhF/JGVA8USSGafY9BHjKo6HzY2pjpBXoEYBubvwknBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnqjm3RBTktLDAzfqhhHAHCNbkPsUbNCWmrxjApLVuxw60Dg2
	v9BIF11rwAtCia50CwlmPOHQDjKsTySuY9qvrhWa/Nf6nrQzwdhfMhhwFbretKxTDAFAlGo2gj5
	3R++MpmDZY8i1n21lCecjDz5cMTyXNUhz9/Zr
X-Gm-Gg: ATEYQzzeibFKN6gR2+JasyDGaMIqWt9xmEll4gaM1SqWT1sjBo3hOrktH2k3RbT2v5p
	2L0nwU12l1voXiBjoSfn3y5G1XF6FhHws/xfoyfQvaNAKSl8Zjr0tr130apKRoZlC56bU4302jI
	F1BT5aJqtzIvG5txpbW1OFJxYvh7Oga/zBxEjeRlkOI5yNaXqSyPWu2pa3Us8hwPNKAegMFWwGz
	2xMjOhnJCv4hjF9dL9OAUVb5cn5M7g5sVuDKF7ikatQ6kpZDyFeKRg7DoKQJr+xqKwZtmg+bZYj
	n3XbVn7HF5BP+sv6DpSE1BxUdReC3I+uhfgA0+nYVYBMDMGMP3/PctoRdZnemzEictMfcYHsvW0
	HAdnKXg==
X-Received: by 2002:a17:907:c05:b0:b88:5158:d10e with SMTP id
 a640c23a62f3a-b972e1b75dfmr285621866b.21.1773290659499; Wed, 11 Mar 2026
 21:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311232545.18492-1-rosenp@gmail.com> <CY8PR11MB7134FC62AB39DEC3AA26DE2A8944A@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7134FC62AB39DEC3AA26DE2A8944A@CY8PR11MB7134.namprd11.prod.outlook.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 11 Mar 2026 21:44:08 -0700
X-Gm-Features: AaiRm50L8GrqFvM-8cKp3CbVyfWXKBxxI39QTyqzMo4HLW_-AN-ijV3wIqXam3Y
Message-ID: <CAKxU2N_2w=3Sh=1Ymkc48psUa7pNkFM5Ci4sR5qdXiPec6bQ-Q@mail.gmail.com>
Subject: Re: [PATCH] EDAC: sb_edac: use kzalloc_flex
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:\\b__counted_by(_le|_be)?\\b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:28=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
>
> > From: Rosen Penev <rosenp@gmail.com>
> > [...]
> > Subject: [PATCH] EDAC: sb_edac: use kzalloc_flex
>
> Could you use this style of subject:
>
>   EDAC/sb: Use kzalloc_flex()
Will do.
>
> >
> > Simplifies allocations by using a flexible array member in this struct.
> >
> > Add __counted_by to get extra runtime analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/edac/sb_edac.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c index
> > 09d4e816404b..7b282dfd093f 100644
> > --- a/drivers/edac/sb_edac.c
> > +++ b/drivers/edac/sb_edac.c
> > @@ -364,11 +364,11 @@ struct sbridge_dev {
> >       int                     seg;
> >       u8                      bus, mc;
> >       u8                      node_id, source_id;
> > -     struct pci_dev          **pdev;
> >       enum domain             dom;
> >       int                     n_devs;
> >       int                     i_devs;
> >       struct mem_ctl_info     *mci;
> > +     struct pci_dev          *pdev[] __counted_by(n_devs);
> >  };
> >
> >  struct knl_pvt {
> > @@ -771,21 +771,14 @@ static struct sbridge_dev *alloc_sbridge_dev(int
> > seg, u8 bus, enum domain dom,  {
> >       struct sbridge_dev *sbridge_dev;
> >
> > -     sbridge_dev =3D kzalloc_obj(*sbridge_dev);
> > +     sbridge_dev =3D kzalloc_flex(*sbridge_dev, pdev, table-
> > >n_devs_per_imc);
> >       if (!sbridge_dev)
> >               return NULL;
> >
> > -     sbridge_dev->pdev =3D kzalloc_objs(*sbridge_dev->pdev,
> > -                                      table->n_devs_per_imc);
> > -     if (!sbridge_dev->pdev) {
> > -             kfree(sbridge_dev);
> > -             return NULL;
> > -     }
> > -
> > +     sbridge_dev->n_devs =3D table->n_devs_per_imc;
>
> What's the reason for moving this line of code up here?
__counted_by requires setting the counting variable first.
>
> >       sbridge_dev->seg =3D seg;
> >       sbridge_dev->bus =3D bus;
> >       sbridge_dev->dom =3D dom;
> > -     sbridge_dev->n_devs =3D table->n_devs_per_imc;
> >       list_add_tail(&sbridge_dev->list, &sbridge_edac_list);
> > [...]
>
> Other than the comments above:
>
>    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
