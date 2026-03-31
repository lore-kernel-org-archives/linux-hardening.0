Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D71EF39E
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774931363; cv=pass; b=RGQkP3AMXV1RIxzUExgTXBtgxf2uDBtJPNQDJeSOD42fmbAVknLxrIdrkSmDbQZ6wdyyUzsXbUpdy1tC/MokxI2DjAc6i0JlH+ecneTXRFpd3Y+a5IqLFRUBF0UlBQBwx96wP9tPlrx7kiG231hv9lSPcjad1DOmJnpAVbERV7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774931363; c=relaxed/simple;
	bh=p+FvHoQ67nUJi6HBun/oyfLfwLgSq5M7WuggYsg24To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFUtxHhLahH3tuIW5sd1sOTEKwLB7fcXviNscbPA6qD9nwi5OoQ9lk/iQ9bFciXQy3A0BW8QYvDk+O0sz8EYVc3n6QUgMj0wyJiSJhZtoV7lB03UTbo8uExdfpuHlKuPz4L2s3dyYAW450cjK7DgsgI2tiVXYvurMXu9xnoAFBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmLxc+fO; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmLxc+fO"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9910707d82so615999266b.1
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774931360; cv=none;
        d=google.com; s=arc-20240605;
        b=ToKXF4GcX6B3I5mIKHVQRIgbXES7Br6tF33umnu94fQ2JQLXe4gMqdzkJrISoMhJ/j
         m4GGTmr0ARg8izrn3QcEMEQVGn2z0JICA0n9QWBSJa11acBLi7ZmXd+smbFGKA57GN9h
         asQeFYGETZ8Ha/3EgyJG2VtL4HETLm/sLWQoKtXUrr7F1SjKMqDANdf9INSO5ut5WSmA
         gV46WePWBEOlC6o7jL/4DzCywAutmSiYSOArbY1XUJ1UtoHEjxX0DCNPHX4UJoGjUMqR
         0Kjl6mHMKk98pX0ErOXUga1mRn6iMHwQxDpb/VE94Vq8tpQjJrirghE8LV0hncaHpFn+
         PpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PEot+szO3NPt9LVmYqaYJOsqYdkjQVsjRt7jnY+c8Xw=;
        fh=hBg4L09KeI3CsfaqURXerItgV1171LUflJFsBtQMRqo=;
        b=bNothVa1Rs7NxdjZpMZ32/Nd6/psUWDTBllzl/5XYOzBHCT1+MPY+wn48IVPUT0z+/
         TIb5yXLdcWT1wlmP/hFBLl/aL6G4YVt4o03Yt5XopEmY10G7ENtmiomrRTcCZHqUZanc
         GMVwCAzNMRgKEkslTwxUXQeX33RyTMzV1fIu36MMEQn6yxXWKeATbcx/9VM/A4LFz6Zv
         3Bo3rWxSFveyIDIU7FmAFAsL0OwJQlszt6lrHr22VF31+O78IqCgCeIxqEdA/ar0LyEb
         4EA8S70GG8LaKSuZcEFbSyQuJr/iBUxbgxLi5X/wSD+DUPDjmgVrXdX+u16aLXwnergl
         qeMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774931360; x=1775536160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEot+szO3NPt9LVmYqaYJOsqYdkjQVsjRt7jnY+c8Xw=;
        b=ZmLxc+fO3A1ceHISrj9eiLvJuKvrIASudXvlOoAMzy+z5nV3Rj0ZK793nKQFXYuqzZ
         RawRKgIpy/sCf1M4H80RRC8EK3qxpjDc72JmzTDiiLHEHz2tHx1hopWECTq+Rtf8Dfmk
         dUgAQK/Wqcyyh53OBcG01DwF0Dc7H+ofONyPbHAGyDcI2ifswmiGdb+HVSs6jsuyFiMt
         zv06RX9s53ZPse6LAUD2FD337pls4WhDWg5hnqaaXBadWw9NXzH3VU4t7meJrFB71otP
         QyUJNPSluOqKL19BdpP5wl4xk6PXzwwCaLzj/bYk1MynVcVV0VS293t9tTOf9OuNEoEV
         wtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774931360; x=1775536160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEot+szO3NPt9LVmYqaYJOsqYdkjQVsjRt7jnY+c8Xw=;
        b=mr/xp5SKx3BUS7i+Ji1nQrPsgvhuqcdpSnD4zmmzmWWKRfh2c6D40LXRi+WyJhU9Nq
         z/nCKk+IsuBoHkKubBMgI4YqYqgW0D7qiiq2cnHnUpew93Jain7va1r6SwGulVnCH7Gp
         17hJDmCFtYLs0/mVHoMwrIpGK0KkAaldklF19Tl01M5Z3uAL/QL93xfsohg0ouZyXIeg
         fRGYH1yP4rJnftAc9UxHMwiwB2tz4WEDrvAxAyK9txIvC50dVXbCZ0FvKvHrsC59Nd49
         O14mJOSFMR0YZzfaa7TA3j2zkWRTHAax3XwgzlNU6FEKiUKvEhgdnLAnFZiPMl/xbw86
         vkVg==
X-Forwarded-Encrypted: i=1; AJvYcCUT4KSKK5nzlJxKUlBWf4eJJ1ARfIT5F1wGgQrnfbLIs5wi7UHAaxF71gFKDpP8/vs/4APvP56a8DxdHX8hfkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPte89j2N6B7UiV3TDol+YyXR43Qq9QDUfMheINS6Ojez8ud8z
	JsRgWBYYfADXfSZJ85uE5CMUXKf9rQpvjxpk4qi8KXx5A8qlEJc/a5bZX3gIjjzev0+zfBm2kh9
	f3+l/7tt3yznl42eQ4snoRj6OtirSMB4=
X-Gm-Gg: ATEYQzzVcOsChemxmB3uuNLcY2lVq7oPiELeFFySuibVQa7Kx3aoNUZbqfuBJY0ukSb
	HzueqCGcgzJD5sBRpm1z835DAGh1ydFWVjwUNzdTVBFIhwrP4Uzwxq4s8F/ieg7b1Lk4OTVwaMO
	mYBY7/njrXJbtYbLL6FzOlqNSqwZjneboaEUhwLNIAHigKr4FIHElx6K9lhQ+LTg23SNqPzabl/
	3wT2wJJJqEKNtGg8xQEXAhn05/8aJH+KKfx41g4+iSd+QT1seGnonp7yEJIAT36Ib+RmydDTHAC
	uH2R8yaDiGItdOgJOkWsLzHL0EidjxZczLbHabK3TWmaIBYHCAj+oQB6Da4dlD62SZy4nVRPhSN
	AJs5RQFau8y4k6eaPVQ==
X-Received: by 2002:a17:907:6e88:b0:b9b:5648:6e8f with SMTP id
 a640c23a62f3a-b9b5657b695mr925494766b.26.1774931360120; Mon, 30 Mar 2026
 21:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
 <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
In-Reply-To: <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 31 Mar 2026 07:28:43 +0300
X-Gm-Features: AQROBzBpGIynmbsQ2-RVSGCdRUHGb83IEBz642GQmmfamTKmS8_ptyDz1LyuthA
Message-ID: <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
> On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.com> =
wrote:

...

> > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> > > +       /* Calculate nr_channels from the IO space length */
> > > +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHAN_=
LENGTH;
> > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_cha=
nnels), GFP_KERNEL);
> > >         if (!hsu)
> > >                 return -ENOMEM;
> > >
> > > -       chip->hsu =3D hsu;
> > > -
> > > -       /* Calculate nr_channels from the IO space length */
> > > -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_DMA_=
CHAN_LENGTH;
> > > +       hsu->nr_channels =3D nr_channels;
> > >
> > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> > > -                                sizeof(*hsu->chan), GFP_KERNEL);
> > > -       if (!hsu->chan)
> > > -               return -ENOMEM;
> > > +       chip->hsu =3D hsu;
> >
> > Don't know these _flex() APIs enough, but can we leave the chip->hsu =
=3D
> > hsu; in the same place as it's now?
> __counted_by requires the first assignment after allocation to be the
> counting variable. The _flex macros do this automatically for GCC15
> and above.

Why? The hsu member has nothing to do with VLA, where is this
requirement coming from? My understanding is that the check should
imply the minimum sizeof of the data structure and the compiler should
know that way before doing any allocations.

My understanding seems in align with what Gustavo blogged:
https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attribut=
e-in-c-and-linux

The same is written in the GCC patch description
https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html

--
With Best Regards,
Andy Shevchenko
