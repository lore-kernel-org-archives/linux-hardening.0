Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58134657FA
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992671; cv=pass; b=tSGK0kNEv5adMgwh2DWemwAagwDu13fGFUojyhLS+s2LOjnZ/vm7rBMiLbV/pEpDSimsVqyMNiDwdpG3fLmU0RUVWpGdjPAAF5QzgiFuhtTZXah4eeQ+uIGjcdLz5jJNFyf7ZJeFTBTt6YX7w3FadincsEbhlS+tYBAZSTmVwZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992671; c=relaxed/simple;
	bh=2A2JmefpCGzhygpv75dI+lo6EAqlpCUDR/JlkgSbrRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gzf0/b1eEoP9MW7eCK3og8pbKp/i4ZefuGNH7UphpQFX5BTFSnmLq607IlmaQnkLqBaGtnN0IrXOFDKDW4/ztiZx0dVeYvqdr6RtQ2glDJjYR/XIy6s+9Fv8g9YHTJUwpS3akldOnaz/qcKfYKRSgZMi2AMzCmnrkdypcbhy0SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhlLMpCA; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhlLMpCA"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66c43d3ba7eso1736798a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 14:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992668; cv=none;
        d=google.com; s=arc-20240605;
        b=j0LqD1fHLmM52QWFFWN2oNVPpgC3QnVG6bkCm+ejtrW0pyJE7adZVcGKnTmQS+qFtY
         Fb25cTKrVvcYhBaLqBz0R49qX59fDKjPiw/pqlcuzSfojFYjL5sXPIHTAYdHOOZ2ZXK7
         bkABDPoG6WRpjzzmq6PelBpS/ft4tJXjZcFVLJ2yaBq4zOj/Nq0rNUSZYh1b+ll/b1Uj
         DvhKEMMBaYHXZOpdJqGbWbMvBv4YzkUL74/1lV6yg7mpOIwKFdMLFcvmPpLVdZ87PNcq
         Twzws6NEmLBmvEE405EtdpAXbOEdHOdRWfrCCQ5NBekp7lfMRpe7tgPMmMlHSee5H0j/
         atjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0gAZxdKTrtG0UNe7fhqbtNVst5TpR+8MqiteFQr6YFg=;
        fh=UyNuGoI/AX+GH6qKhsefw2WWO1cPFeTRPOVWbgT4I6c=;
        b=GuiPYj/5tzKOgZX8ThW3baBPhGJ+y8AOGRLLCJ0DJGoGI1ISnmPlt3FnUtrsPdXTt4
         zO3QEcOU97s8D3N689DDCMUtWUhL3OOE/olVkz/4GWkc8VejNjKJa0f4WTyIwmXYiG5k
         4pFOhr/Krt4nR0p+eyRjTywXECKhY0IkV5v1w/1Mctnu3qb+wPxEZvDvo7GOsN1F8YrL
         0XPXQnyR99OkDVS8nOtlC8Y0KrdVuFz7sa6qYip99I2QtUF5EptM3Vf0wixjATjHVVwo
         8cJYjZjwOm1bZqDe9kunz2lUTHYGBxGqiXF/UXdXxVbBExR3JHxCgKWErZGKS5JZkSwH
         lFZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992668; x=1775597468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gAZxdKTrtG0UNe7fhqbtNVst5TpR+8MqiteFQr6YFg=;
        b=BhlLMpCAhFyvu5S5DhCtDeVfYc8uN/TrrB+L2WWjdry4LGFFuw5vPn4uJuVuFSpYEE
         C0Ulc8DVEGp29GpwarEof2pfnS6t7A0p0Vcz23IHyOb1snGU+Bbqn24gvhBiL9lUvEmc
         Ty+TSfhBMbWOQaCh22rQwhXRMAWllw5VIhFQCyLnJKMnYOv2dPrN9IvQeotReEc0MOt5
         jUiJTCxAuBeilSyELeJFL8lXD9NNNZ8YBdycFnNQEbf/iO92F+s2uqkgGC43uiJVOVoo
         KrMf51fVZHOl2iuza9z/bZOEJGz1jhHvhc6Dp0ltFQXLAnuVeVyVtVPeY/coO1uB8h2V
         TkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992668; x=1775597468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0gAZxdKTrtG0UNe7fhqbtNVst5TpR+8MqiteFQr6YFg=;
        b=HvYZ8VzGYGEsrZXn49DkwGq+QEhwJvmt0vSAIJte/eecnViEta+fXFdZafXK35lCQd
         sOrIL3Jt82yHeMKd4uTY4TNGMcDiNoPAAIv4axX13BGw9NUIrFfvsXJrpXoOrZbiZC8T
         lZ4xV1WwBIGnoIr0UZUgr8lasbloaZ18eXYEgFLHokqQm/Ro13YANi+nYaELSRS3B6vN
         JnaOEFlz2scpiktckz/yOsE3C6d5fvH7AiOigBL1G82zmejepLMVvxd8lS/7StuwwB7i
         T5xZ52cnAZJAzsp9LXGEztZINrijdmYI/oQe9GbJRxoxrM+zJd0YSdIPGWFQc45RrHJX
         jbuA==
X-Forwarded-Encrypted: i=1; AJvYcCWyoziZLBPUdFgOWJ5OqTVFXGIrZAJjS6V7R5UES84MAXC+MFSnWNH4F6oiqXFPMGnZEem+r//jI/yYoTm8+t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTT81XKX6i7mFHLi26uIFIVdIdjmVe6CGcdGW5BUXliOnnIxe
	CJVokdy4Jl6zNr5KzFxCrbJmFzFIdeqaqVoeBTO1ffNsmluyfrKN9M6Fp6L2rBvGZoKMJ4IG/gZ
	kTliaruUr4NXPH5Smn8rxB/TyueOvaCg=
X-Gm-Gg: ATEYQzz7sxrElrXczvwNkIYHfqnH/Ru0v/J7JXp+E7UPYMwIZV3U14al3aAw3VL714f
	jb+deMd2iS7DOykqjLi5AAhzc4ZizDd0vuv+6q+QNvMo0MEPe7l0rz9iEa7GWMdCL8roXnrgnsA
	LGVnWbQha3x7l0AYqsPVA1X4dOTmxVSl1V+oYTPkR3s/+gm8BNwyqiEDgMZp916CggP5hEDOALm
	Ezt/gtorV5SzXtKSeem2pvtXrxdhU6Ejasyv2cYlZKExthZwJfEqLOhBjiG36CtN+PGveFcYpaK
	YlJS98JRX46i9cc6odg+ERzT0ZfUhW8LimtZ/7h3xChIieZs+Q4oXG5dycXS8cR2dujfizWddK+
	ygrbpCQ==
X-Received: by 2002:a05:6402:a0d5:b0:66b:aa56:ee5c with SMTP id
 4fb4d7f45d1cf-66db3f96414mr555333a12.28.1774992668047; Tue, 31 Mar 2026
 14:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
 <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com> <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com>
In-Reply-To: <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 31 Mar 2026 14:30:56 -0700
X-Gm-Features: AQROBzDOlWtP4rTa212l85ZHquL-AO6utx3CmRcZmj7oHcqq8AvGqVreKjXveeQ
Message-ID: <CAKxU2N-QT6KAKzAYDUp_d9ug=1VxHMvegEQDbxS4GumH+8QBWg@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 9:29=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.com> w=
rote:
> > On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.com=
> wrote:
>
> ...
>
> > > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> > > > +       /* Calculate nr_channels from the IO space length */
> > > > +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHA=
N_LENGTH;
> > > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_c=
hannels), GFP_KERNEL);
> > > >         if (!hsu)
> > > >                 return -ENOMEM;
> > > >
> > > > -       chip->hsu =3D hsu;
> > > > -
> > > > -       /* Calculate nr_channels from the IO space length */
> > > > -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_DM=
A_CHAN_LENGTH;
> > > > +       hsu->nr_channels =3D nr_channels;
> > > >
> > > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> > > > -                                sizeof(*hsu->chan), GFP_KERNEL);
> > > > -       if (!hsu->chan)
> > > > -               return -ENOMEM;
> > > > +       chip->hsu =3D hsu;
> > >
> > > Don't know these _flex() APIs enough, but can we leave the chip->hsu =
=3D
> > > hsu; in the same place as it's now?
> > __counted_by requires the first assignment after allocation to be the
> > counting variable. The _flex macros do this automatically for GCC15
> > and above.
>
> Why? The hsu member has nothing to do with VLA, where is this
> requirement coming from? My understanding is that the check should
> imply the minimum sizeof of the data structure and the compiler should
> know that way before doing any allocations.
Not sure I follow. This patch changes hsu's chan member to a FAM.
Where is VLA coming from?

The current code is devm_kzalloc(x, struct_size()). When it gets
introduced, I'm sure there will be a treewide conversion to
devm_kzalloc_flex, which would automatically set the counting variable
for >=3DGCC15.

It's best practice to assign right after since kzalloc_flex does it anyways=
.
>
> My understanding seems in align with what Gustavo blogged:
> https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attrib=
ute-in-c-and-linux
>
> The same is written in the GCC patch description
> https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html
>
> --
> With Best Regards,
> Andy Shevchenko
