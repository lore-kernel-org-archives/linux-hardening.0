Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE03FFAAF
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825119; cv=pass; b=oP0qxxus1Ysr6O4vQw3/l0E89a2s87jNSGsEJ36PpD0fJsigOr/J09d7l5DxN/1ntnD27ZZer8fwm4PlZSnF815gBIpvs4n5mMcZiA5n0Yuxx6eFwtwSeBHXUZLl5jXAYYv1l5L8wHyNNnIablOFvJrZLP3O23z2mvQK1aASBg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825119; c=relaxed/simple;
	bh=r4iJjMV4niWg786VnjwFUWIrF4wy0N1FUb7CmiSwphI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6mAKKk21yTS5RRH84lg2EMsKRpvu521mQMYQpF/silajXquz5ND21qT6FDJp2bFRNYFCSCCY4Ix45hjtLejYpQzZRJyK7Ot0s/2h4xbndVgtC3jNHh6eOkoYU+V5CufBI8wcCX4NqfScCqivd4e97DkInXOWfEODJtJyJ1WE7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJF/pNYp; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJF/pNYp"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9419139eb7so255219866b.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 11:25:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772825116; cv=none;
        d=google.com; s=arc-20240605;
        b=UOMpRd90iVIW0uZZZLVoFgdcA/j8aI2DmB5JF/TrwqujSXyx5ry20Tz+9+Zpl1q77/
         ncZOVdRNN0Iv904kVzUHuBofq5nZhC8AcQa5nErWzHNBmuGWRBrYB9whvJKoJNcz/yfn
         5sBM8LZpgzP6ok6W0MFrU7z+mHqbOAMwEWAn9sVMnbEBpyerZzMFeAW7pjG0DDlAMwjE
         HXHg7X2ZBPxlLdAzlUxYlMWLJkTCQ+hNq77VIm34ZJvTDNdqYMz/5g2WI+z/1Cgc/vwW
         Fw/gg/IFWFtDzJbn6sPnE7x3Kd6kXVP4hMW36b8hnynjY56vJ6VS+gzZE5pixnZCPQSF
         Zp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOnT09156mz9ztAxUhNe8PpOupeAedlDQCuib5+icu0=;
        fh=/QWUrQ0dmhzoXOjsDuDf0aE0X4U6o0tTdd7hZEg6+Bc=;
        b=b7Wg7k4sfDNvCIORF3CcOKe4k4PTmS0CHnxKWVInN8PTCfUjLA7Ne0KipPTqES4Ob/
         6Qf1PA8+rb61v2lH+IBdS77lqwKKoq+Vug/0vKA5qON9KuTWXLWdad3XYbi/dU2MGTD9
         pdwhfdvyPgVWgkQTvT+7T+oJUuZBdwAWVQ6TJ1ysqxPS+pXXnaV4WSZRzGqZ8mC/joHl
         WOVx7OCm4Wx8FBjxjibgn0iadje0CmxJx9ZHX+4jqx8A0TXbIB+KOmPAUyJjAjtKm3EG
         Mn24Q49V/kAwqgDpQtKZUsxvpBtXvZKwEFNrZKYOC31ayBqv5PsZl8F8HmJ0CmYqF0It
         WlQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772825116; x=1773429916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOnT09156mz9ztAxUhNe8PpOupeAedlDQCuib5+icu0=;
        b=OJF/pNYpMtk8MfikCeqy8avYV7Z/ck7pqFkE2zEc4IIrjYn2Qo//jWQHWAtqCUiOo0
         mxsVOFbDMgmYBBGK9n20SCW5W6l1MHOqbtpiQqUFRoe2azn7pNrdlCog4j9YKk3LOAeP
         ZE3uwyUI+W4Kmy11hu8FwSqY74C+nfIkxtOH484o6HQ/r7oCQXiL6nph59GtnQIfx+Ly
         rPogN36EFL1gwmxBgCVXubBRl5/28VAt5JhVPVAK0aILDnHq3O52H3rLBZHr8XtwVFGD
         Nn2aqI1fBd3eK5uH5TanZWBsZYZZiZDIoiX6CV2B7t5TCcS+gHeDVUGRtvVnBN+/YEzk
         IXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825116; x=1773429916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uOnT09156mz9ztAxUhNe8PpOupeAedlDQCuib5+icu0=;
        b=qyYAqwyS67dNfgZrFUwxjndwQHP2RnHznvnr/rAmyhYXByGE1PXjOEns83hdZ5xwMm
         CnB94wfpVtnxz2stCInWGPY5/w94+D1sfT9eOgnVYW78NIILozX4w76+fx/KxrPw2FRz
         u4Ag2Q3U+s3b+XaQ3n19/Dx/WP6S9AGB+RuYZLUMCotp/0mtPUhfEatpPFP1TZrEfXSr
         iQz8Ns6J/ASqZ60jAGti8CG5nrPqMKTQ+B7zqYUz7TZiUVMlCKhrmZJbpJmjBkmfr4Eh
         vDJDcgze9hmKlo2bu4ZW+MPaJzCZ1GKWrxggAz6EcnNIxDFPh/kkpo5F68kxUyRFXWOm
         k8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6a4vXPFLfQ8lItEdJ1WCx/XJ6PQT8+vOqnUHgrmYopZTfrGwZyn4ZrI4qpmqYuYApgWUyciXM5pQNQpx1kaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNzvWMRwFW3dyxMlhPgeTayIM+Blq29n0uEHEEels1woUlNXWP
	ZspadBPRV/Wf0+emuYN6QdZ+Ii+yWLvj1HOzZlP9JHYHA+oAUXkRbAvbJLyPuf1aJNkWQQel/hq
	w4rmKyjMu9NMi/yip/6MFUuU0iXFUjZA=
X-Gm-Gg: ATEYQzzMJvRDSYOXxvcdQPVPDiHTSxhLeJwKxaby78Edlryhi1PezvOLD7C2bu9FUor
	RBbBDkySh8GLmuQEsCoxSwS9p1/9NdMU8DEHReOzJZKQR69mXl76lrSLy4dlpTamKkMJWvPB8Pc
	xm6hOT9qTI1ni6aZRBUx/8IXLrAUy/NZWKYr19m2rv012Z2uDHsFvRAu7fPRsrfp3m6R3oE8zQX
	fUIuG+S0jErDrT7hgI3EWsKYOKEe9WMdPuhY15UyfIoV3S5A13jq7rTarGZR1s/aklB+gUnnmO5
	lJ2Z7PM5lY0+vh65dNe6WAFSTtm5mtmlB8KQKuINsi75uGOUtvfzmcTxrMRU7GvpaIYZYzS1UkQ
	jS8R+cQ==
X-Received: by 2002:a17:907:e8e:b0:b94:1f00:1ffc with SMTP id
 a640c23a62f3a-b942dfaa0c5mr185959666b.35.1772825115820; Fri, 06 Mar 2026
 11:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304232014.164408-1-rosenp@gmail.com> <9dbf5b85-66ec-4d3f-99d6-17cc74a8f912@embeddedor.com>
In-Reply-To: <9dbf5b85-66ec-4d3f-99d6-17cc74a8f912@embeddedor.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 6 Mar 2026 11:25:04 -0800
X-Gm-Features: AaiRm52RG8EIUK4taryf8i0vskX73hh0iig_Nc3FNuaefwD5gTxikZtojl4SYPM
Message-ID: <CAKxU2N9q8c3jE3Ao46BsGERb73jEsBVjWnBFVf=B78=0TNbrxg@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-dvfsrc: use flex array
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-mediatek@lists.infradead.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:21=E2=80=AFAM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 3/5/26 08:20, Rosen Penev wrote:
> > Simplifies allocation from kzalloc + kcaloc to one allocation.
> >
> > Allows extra runtime analysis with __counted_by.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/soc/mediatek/mtk-dvfsrc.c | 18 ++++++------------
> >   1 file changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/m=
tk-dvfsrc.c
> > index 548a28f50242..48b1fcf3e101 100644
> > --- a/drivers/soc/mediatek/mtk-dvfsrc.c
> > +++ b/drivers/soc/mediatek/mtk-dvfsrc.c
> > @@ -71,8 +71,8 @@ struct dvfsrc_opp {
> >   };
> >
> >   struct dvfsrc_opp_desc {
> > -     const struct dvfsrc_opp *opps;
> >       u32 num_opp;
> > +     struct dvfsrc_opp opps[] __counted_by(num_opp);
> >   };
> >
> >   struct dvfsrc_soc_data;
> > @@ -489,7 +489,6 @@ static u32 dvfsrc_get_opp_gear(struct mtk_dvfsrc *d=
vfsrc, u8 level)
> >
> >   static int dvfsrc_get_hw_opps_v4(struct mtk_dvfsrc *dvfsrc)
> >   {
> > -     struct dvfsrc_opp *dvfsrc_opps;
> >       struct dvfsrc_opp_desc *desc;
> >       u32 num_opps, gear_info;
> >       u8 num_vcore, num_dram;
> > @@ -520,24 +519,19 @@ static int dvfsrc_get_hw_opps_v4(struct mtk_dvfsr=
c *dvfsrc)
> >                num_opps, num_vcore, num_dram, num_emi);
> >
> >       /* Allocate everything now as anything else after that cannot fai=
l */
> > -     desc =3D devm_kzalloc(dvfsrc->dev, sizeof(*desc), GFP_KERNEL);
> > +     desc =3D devm_kzalloc(dvfsrc->dev, struct_size(desc, opps, num_op=
s + 1), GFP_KERNEL);
>
> Mmhh... You should really consider building your code before submitting a=
ny patches.
This one specifically I failed at the make parameters.

This patch should be rescinded. Not correct.
>
> -Gustavo
>
> >       if (!desc)
> >               return -ENOMEM;
> >
> > -     dvfsrc_opps =3D devm_kcalloc(dvfsrc->dev, num_opps + 1,
> > -                                sizeof(*dvfsrc_opps), GFP_KERNEL);
> > -     if (!dvfsrc_opps)
> > -             return -ENOMEM;
> > +     desc->num_opp =3D num_opps + 1;
> >
> >       /* Read the OPP table gear indices */
> >       for (i =3D 0; i <=3D num_opps; i++) {
> >               gear_info =3D dvfsrc_get_opp_gear(dvfsrc, num_opps - i);
> > -             dvfsrc_opps[i].vcore_opp =3D FIELD_GET(DVFSRC_V4_GEAR_INF=
O_VCORE, gear_info);
> > -             dvfsrc_opps[i].dram_opp =3D FIELD_GET(DVFSRC_V4_GEAR_INFO=
_DRAM, gear_info);
> > -             dvfsrc_opps[i].emi_opp =3D FIELD_GET(DVFSRC_V4_GEAR_INFO_=
EMI, gear_info);
> > +             desc->opps[i].vcore_opp =3D FIELD_GET(DVFSRC_V4_GEAR_INFO=
_VCORE, gear_info);
> > +             desc->opps[i].dram_opp =3D FIELD_GET(DVFSRC_V4_GEAR_INFO_=
DRAM, gear_info);
> > +             desc->opps[i].emi_opp =3D FIELD_GET(DVFSRC_V4_GEAR_INFO_E=
MI, gear_info);
> >       };
> > -     desc->num_opp =3D num_opps + 1;
> > -     desc->opps =3D dvfsrc_opps;
> >
> >       /* Assign to main structure now that everything is done! */
> >       dvfsrc->curr_opps =3D desc;
>
