Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E62BEC4E
	for <linux-hardening@vger.kernel.org>; Wed,  1 Apr 2026 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050374; cv=pass; b=FFyzxXrD0z+wcycGBwTpBRk9vsnGPv1nlKQ2vQSGG+n5s6yyjtAE3IG3e5O2+n2NkKUZQfUHJu1fM09vA4Yfo2Uwp477Ba/6eUuKvlpUCUkPU3ovf/K5Fv8f3osV21TBxpXGk+FsnZst5Mog6guxoVcJIJNlZCpVmc5OSLmbnzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050374; c=relaxed/simple;
	bh=ykZlBQP3ui0pr+RmE/BDkLgSNESXpnvh5+IEQp6F9Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4jGEeMf0864PMmDWp3nEiu0bZJXfuaDyCLunog6jqYF3DGy6JdlZjxSAL3IklUaXdL/wlONT+2kddHgIzU16oJEAHYuwVOwekadcHj14OwXjzsXt5GhyeBRck28pyMmHVFPdrKfn5rvnPixKQSiTp7EzcaCldAGJvtwab4jTco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drl+lWPr; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drl+lWPr"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9bff57cb62so279613066b.2
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 06:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050372; cv=none;
        d=google.com; s=arc-20240605;
        b=Ed6iyYNM7XttQBDKUEjO1yhLPOem6NAt/QJJSIu7bwq3x4KMuCtx0mokrbs73yxlsb
         Y0iDT9ZkNHFhZ0B1NVtaEC4QxhqLBL8XD3yZW/stFKiGNLvHoh1NqaP0Vi8qllRUulDz
         r/zehkAnEDDcU5LZ/uI6ezhk2IQpTtUDp+U0o5pBiOErz2tyUmUEPXKDJXHvhCX2HOSP
         42hb59pT9IU0cqv5/jLtmFF0SDgqejBrG/K7OFSL8xEUJPphaVybiRPtWdkTDBQIKTGK
         gyQdCJcSReLhudd6co+GHx5jx/9ERXmh1Y6O1vidzqsjrffMyivIfEk/Wyy35piTDYTd
         tlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XdQtbwlhskFWFC4jOk1CfaWVr+c6qUIfl9XMYThbgKA=;
        fh=GLmXxZhPfm3S5deRb9+gpfz/PM0C3dvxra4AnvV5Kiw=;
        b=WPbGtOwEyPZFsqKHIa6aPehI/BWYU5dxN3FABMfTZu5EYfsalOGnD701mLziNseB/C
         gx+YW78t+ok0J1tNLatb6bTUAivu4MBQdCJGDdgzVNZ3SO1gxMUT03EXte/Nmgqx9LJl
         mVs4nVvZHCfZ1IzeJ53PcPfqH8cGfxKfkuor30MKW9CBDHxbYLUDVuinXgyuWLo6kkcl
         60zoIom7R5ppToTGHb/PDe7q+O7hYvIA3YWSbsMpc7XasEozdDzaBOxZTorziOB5IRcL
         XfAC1mf7SWxK4jy9ZVlGmZyAwUCinczp33Q4yr4brxQneH3DSw9OLd1eWS2cmt75Typu
         tyOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775050372; x=1775655172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdQtbwlhskFWFC4jOk1CfaWVr+c6qUIfl9XMYThbgKA=;
        b=drl+lWPrtGiBxHOM5pgDFJD5CmHy4v+/dJJYWTH3SiBxikgnLRDfkCshRpArShhvih
         0hoNNwidgE8RbdojmOd3fvO3/gHoNCpX0ptr+DKqBEdJKb4qsvIpxb3sfNSQS9ez41y2
         QEwM7RjkQGHgqER68SGmVRFzlfdSBj3SwuyYGrROcTkUsiBqD8cBZUJfVjvSQL/LWjZd
         8V4D0GyYu+dpm8YUA4tJBu967oq0XHtkV2FIxxFPZ3zRaybk2OMr9nvl+Ud5y6KQ5Cr6
         7PNIgYhd27tK4o+zuqn3EWSwaB/RpbKraO5xiNtKg6K6+qRWTZu1DfX8GRIwnggCQrmY
         YHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775050372; x=1775655172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdQtbwlhskFWFC4jOk1CfaWVr+c6qUIfl9XMYThbgKA=;
        b=LNrUS3f9qhHPz+4mtXZaoiC8WQDyFAQC2kf3+EH43PwHFcX8qQ4ebl7j62ioitwd6u
         CCCSEvRpb7ACG8hRZcrq0lOttKaNX6Q7sxHTBpOfeCbxgtuiZHgl17wR4IlwbHhElWjO
         YuTLzT/9rxoKqYreIGjIY5MX9lTR1uPZqdBUbVBkXs47whoPN4CeTc7bLNMWRZLHPTXv
         TbEAvnVNZfn91GRG+VmfXQAISOj16cci623egk64tHGyKvzv9rAnIv4egi0V0CIdbUV/
         muUYuygyeWchO3bd/D3Mz5lriLpb+1K7Psz7hMRocgE1PDAN74xiwUbqJ8DU4A2gsRiy
         3QEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfKYDTNQbqHfAmRULuiFQg0ZVMbAON2SrvzSzpL9Wg9HCI2Tlb9FYk+QndBAm3oKEvwJzOPS22io3QLhxHZO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs+a/4P5RAAut7jJLEdU5gKEWbRYs5Lsk6z7Hcj26/HK/vauIj
	aZY81w5RpSm+kFM05ByCmY0Qlxcdx2+58AvEf0RqpE58JhUXVKZ7ykwR62Ab/qfUJGePnvVCRGE
	Qdw285tmbmhjX6w++gI9FMJXbdQ+daVQ=
X-Gm-Gg: ATEYQzyazp8COmdbKTCkl1L8uanvRdyERbrkli8Hq+t/sIE92QERjFEOtEAb5Ae/nQh
	PCS7njOII/hKJCmWXtvZzXUo0iLrASzNx3op4bnyetKFrzd2Zdyjcrcy7fIbGZ4CdHyqfYzXax9
	HlazZR4MiRLxxiH/DATmciEgV0NnD7CbCKqUaCV3Qzum20L4jHUmcW+XGxvvoUPvGESbPLgOJNB
	nGYtQuBdcFLCe+zZmKtovSoWEI49RpdoxySrnOP6M3v+fbxJTqKUfBnBpFEt5h09IPe3zxbb8Xb
	R2Jr3Oshcgbv54aE+2OP0XOr1EVpmXXaF2kVSlR0fD+1HJlbNQLnMq38Aq9TP5Is/1QbUW9/cRC
	ujEa4MXs=
X-Received: by 2002:a17:906:891:b0:b98:2c19:6c49 with SMTP id
 a640c23a62f3a-b9c139028e4mr197175066b.18.1775050371154; Wed, 01 Apr 2026
 06:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
 <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
 <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com> <CAKxU2N-QT6KAKzAYDUp_d9ug=1VxHMvegEQDbxS4GumH+8QBWg@mail.gmail.com>
In-Reply-To: <CAKxU2N-QT6KAKzAYDUp_d9ug=1VxHMvegEQDbxS4GumH+8QBWg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 1 Apr 2026 16:32:13 +0300
X-Gm-Features: AQROBzDcdLuWeJRe3D71X4YVGCYTKmrY5ZFcR0AhiBibbvw6usBcWjOKiaIKYno
Message-ID: <CAHp75Vf_Q4OqYgEOBhoFxpKpAkw5_+GJxQCTbA6LnbR0xhOnMA@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 12:31=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
> On Mon, Mar 30, 2026 at 9:29=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.com>=
 wrote:
> > > On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.c=
om> wrote:

...

> > > > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL)=
;
> > > > > +       /* Calculate nr_channels from the IO space length */
> > > > > +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_C=
HAN_LENGTH;
> > > > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr=
_channels), GFP_KERNEL);
> > > > >         if (!hsu)
> > > > >                 return -ENOMEM;
> > > > >
> > > > > -       chip->hsu =3D hsu;
> > > > > -
> > > > > -       /* Calculate nr_channels from the IO space length */
> > > > > -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_=
DMA_CHAN_LENGTH;
> > > > > +       hsu->nr_channels =3D nr_channels;
> > > > >
> > > > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> > > > > -                                sizeof(*hsu->chan), GFP_KERNEL);
> > > > > -       if (!hsu->chan)
> > > > > -               return -ENOMEM;
> > > > > +       chip->hsu =3D hsu;
> > > >
> > > > Don't know these _flex() APIs enough, but can we leave the chip->hs=
u =3D
> > > > hsu; in the same place as it's now?
> > > __counted_by requires the first assignment after allocation to be the
> > > counting variable. The _flex macros do this automatically for GCC15
> > > and above.
> >
> > Why? The hsu member has nothing to do with VLA, where is this
> > requirement coming from? My understanding is that the check should
> > imply the minimum sizeof of the data structure and the compiler should
> > know that way before doing any allocations.
> Not sure I follow. This patch changes hsu's chan member to a FAM.
> Where is VLA coming from?

VLA: variable-length array
FAM: flexible array member
The second one is VLA member + size member.

What your patch is doing is changing a pointer to VLA member.

> The current code is devm_kzalloc(x, struct_size()). When it gets
> introduced, I'm sure there will be a treewide conversion to
> devm_kzalloc_flex, which would automatically set the counting variable
> for >=3DGCC15.
>
> It's best practice to assign right after since kzalloc_flex does it anywa=
ys.

Still, I'm not convinced we should blindly follow this rule. The
length needs to be known before accessing the VLA, but it's okay to
access other members. Leaving hsu member assignment where it's now is
fine, no need to move it around.

> > My understanding seems in align with what Gustavo blogged:
> > https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attr=
ibute-in-c-and-linux
> >
> > The same is written in the GCC patch description
> > https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html

--=20
With Best Regards,
Andy Shevchenko
