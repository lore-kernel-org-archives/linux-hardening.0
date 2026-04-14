Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38E3E5EDD
	for <linux-hardening@vger.kernel.org>; Tue, 14 Apr 2026 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776210964; cv=pass; b=gmSZcpLrPRI0xyPL5I1QxFCt1qYYs0JE/A7lcbZHEBJp8HYfYcJpLx96vh9yOXkPkvtfoMXz553VbVNzQZvdXKWZiveFLgnGu59gNTdOg/fVx4ml5Iu6gfxK4NZo06VrMbLa6REMKhoEGk3LX1xRSvXizTMqiBiMZK1M8AeYUpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776210964; c=relaxed/simple;
	bh=y7XgWgkBSM0u7n7VbhHpCkbU+WLbxF4zLee8oVSGQxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCRcjvQI4WbDpvjWY2BUjcEluXS8RhysCxRhhBdBeFuk3vgO7Lik6JoHvJTwfz2TmEGL0E6LewnlxPz9By5gUg38Jv/MDDEK/IQadSpNzeZepc3O2Z5CPd3vPpHd/MX6IFIuKeAGB7jmHtsh/FVGofF256y3jk36NXmGH54A6qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/L6d41G; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/L6d41G"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66ba9898ae8so9111972a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Apr 2026 16:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776210962; cv=none;
        d=google.com; s=arc-20240605;
        b=aOBjMKC9x9+f7y8n2ZeWknKYXzYb0F9IcL3Au8OGhUWV+kvVg22h7PpWw/QOgTRbQ1
         pqJKYhsSf/o0ActiaBUICp4iRjdokPIoIw9/OAMDs3QJltFAmljEJpcJ6fmC1y5EW19A
         oaSlt0LV6GZnPokaU/HAzsT9lICYljCgUx95c5r4djstgLVefMnZ59DbO9d37gA43BXM
         2FHqVK+1OlgAWJeUuUYFcNiPiSK3oI0WK3Bol465d2BZ4GD1SCHXfUDRs5+S0pwaQz9f
         iGtWQpuz9crZtN1Y7QrX8BcC7foWgFjSJpdMqk9KWm+mKivY//6vpnUiaWYHnK/mHfu8
         wpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9NGwEvw3zvZJdwFjwrPp+/w3C9krMuTgJ+uxpVOpFI=;
        fh=bkTlqIAnVXpi5jm+Yd4sglbIG4zmQandWXXql10Gy/M=;
        b=UBh4G1nFbItFJDldbGu+9c+fYwgXlV2OoDqLn7+lI7EodqXtB5UGvz7PC1GbeYOL2P
         XFphQmFiAUObgoBh9uGRshtgwtO2DVT7duM3Q5eWQ27WBNqLUvhGUuI0OWuio6YsSvDy
         st74Am+BtsWoEUXatZLYqap34bWe4agbTSfIb6C8jRUOZ6As6QCgxzH0erarGUNQw+9n
         DlKQAGzC8v1LTTVCJbik0crcSuBbtHpJByBzGRwdh9Jyo8RTF5cDNhesXHb8bwKdP/ET
         kl3v9WhZaNoolpyLk+LB+Fu75iTulUxcsDe9uxMDDwZ2/FPvq/wzdJX2u6X8w/Kw2L+Z
         L7Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776210962; x=1776815762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9NGwEvw3zvZJdwFjwrPp+/w3C9krMuTgJ+uxpVOpFI=;
        b=A/L6d41G2LKEOOivBHfti1A+M8gzlFbguvvHMutWDUWzAo862hJJ55pp0aPeukEO5h
         yMQpRFgH2lwLyge/VOaHWAiA8csrKQe7N4+m3ktwQZkBsDEPCAmcdG5p3LV6wxOYJX+i
         tIk6okwVBs9O4EAHSux+4P0ym1fIO+9xtsIHjHvlwuYBwFb3sW0BauWTir966a03HWzW
         qlIo3laqd00MNjW6TI8gUrZyAUivSnq3jFIrDTitfzWCllaNKwGl9Ny3R7x+u23iMpqQ
         XLvmof+ie8Y8OiL2A0bCRBC9FnFyvreoRghIIucrGPYzwCksV28eNwkPlPF9pvEM/U1J
         cP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776210962; x=1776815762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9NGwEvw3zvZJdwFjwrPp+/w3C9krMuTgJ+uxpVOpFI=;
        b=exjaGMhOIabRIxYtTbcGRhqyLU7scwsWTHKsBL1H1LT3D3YvfY1aEBc8qMMNt+d+rD
         JCKoh7Ci7fnrcQrNv6tTG5Q5TMqDTtuueg9gLoEnSFNPMbzoaJEI9NzwDLVHcOIRfLK2
         euXiC80P76ad7ja65qWhlRamOfl7MoCuVY0rzZQwqlMKVD7MGkBnimsI3chlNR/lQFlH
         xjs/ghQ4828D/EUmu0AKghGtgG+GaScIJgeIqRXsy71fPk3r+wcPXowRevWkBNg6PiCO
         gmvBTk+SBkh3cKuxFb7eVNeyOQmP78JLRp2k+0okPs14H0fKpifvLiKLi+zlra0prMyc
         BJ+g==
X-Forwarded-Encrypted: i=1; AFNElJ92LKpom4Ub9r7rapLxU5mLDqODKvFoen20Dj7keXDZo6rjPeedoNazeCFilMY35TJM1hUgtgVd0eqOISSIpfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbhk/iSEAi1k2Y6YxEaMiYTurBxPT8B+juvRzocOpDlwDgrQT
	Uadiol6mzXbAqCCFT8x3qKG2K01z0MroyC9BkPTzu346hUTeIN28GVg/vHygQ0G20Sr0PwoHHKG
	W+WEsqSC34mB8NcyCgCsQhlUO+RTUp8I=
X-Gm-Gg: AeBDieut8Uv/mLx7XBrqnvs1X0ykXselAZsgBvy54tbqJkBmoanb99E6JwVellmnrCU
	lQZIhQsJgutAEVeYPYlVAW2/Gy5ZOImwWG33mWXoD51wx07A2dkkwsvP78ZVqRGW3BIj9gEcVFI
	Gg6i656VeASqdyLK8T5Kc18Gb0aunw46x7topDW3JsYzz3mwzBy203zt93VMDzhJRS16ACNX1s+
	HkWgL0dmWc89CXsW4xjF4E5HMH1KkwZpcn5NgDzpvOlkP09N4hcUX181Lxto52wHFqApuAWcHTh
	G8Lud6MEOr53mpsgzgWUcTeHHyS2sfzOiP9HTe+MrZrPI7q23seelqa/U6SNnJpTbevh5rL7Rim
	wV+dryVJBTt/RDL8ydw==
X-Received: by 2002:a17:906:f59f:b0:b9d:dc1d:7660 with SMTP id
 a640c23a62f3a-b9ddc1d77a9mr602506366b.7.1776210961238; Tue, 14 Apr 2026
 16:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
 <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
 <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com>
 <CAKxU2N-QT6KAKzAYDUp_d9ug=1VxHMvegEQDbxS4GumH+8QBWg@mail.gmail.com>
 <CAHp75Vf_Q4OqYgEOBhoFxpKpAkw5_+GJxQCTbA6LnbR0xhOnMA@mail.gmail.com>
 <ad415SF1zIrCof8W@ashevche-desk.local> <CAKxU2N-xb8CKuwxAXMhix9BH31UBSBLwAkxXiewyUQ=t0BsOTQ@mail.gmail.com>
In-Reply-To: <CAKxU2N-xb8CKuwxAXMhix9BH31UBSBLwAkxXiewyUQ=t0BsOTQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 15 Apr 2026 02:55:24 +0300
X-Gm-Features: AQROBzAxO97PyxOP3pR4eo-Z0iwjdUGfYaxFOtjmUaYqYtfLqd53KTVAmq_Xl_Q
Message-ID: <CAHp75VcBTjnYRfOgdObhNwhyx1j224iRoDi46J5ULmPVrVB0Ww@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Rosen Penev <rosenp@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dmaengine@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 11:47=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
> On Tue, Apr 14, 2026 at 5:41=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Apr 01, 2026 at 04:32:13PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 1, 2026 at 12:31=E2=80=AFAM Rosen Penev <rosenp@gmail.com=
> wrote:
> > > > On Mon, Mar 30, 2026 at 9:29=E2=80=AFPM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmai=
l.com> wrote:
> > > > > > On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@g=
mail.com> wrote:

...

> > > > > > > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_K=
ERNEL);
> > > > > > > > +       /* Calculate nr_channels from the IO space length *=
/
> > > > > > > > +       nr_channels =3D (chip->length - chip->offset) / HSU=
_DMA_CHAN_LENGTH;
> > > > > > > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, ch=
an, nr_channels), GFP_KERNEL);
> > > > > > > >         if (!hsu)
> > > > > > > >                 return -ENOMEM;
> > > > > > > >
> > > > > > > > -       chip->hsu =3D hsu;
> > > > > > > > -
> > > > > > > > -       /* Calculate nr_channels from the IO space length *=
/
> > > > > > > > -       hsu->nr_channels =3D (chip->length - chip->offset) =
/ HSU_DMA_CHAN_LENGTH;
> > > > > > > > +       hsu->nr_channels =3D nr_channels;
> > > > > > > >
> > > > > > > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_chann=
els,
> > > > > > > > -                                sizeof(*hsu->chan), GFP_KE=
RNEL);
> > > > > > > > -       if (!hsu->chan)
> > > > > > > > -               return -ENOMEM;
> > > > > > > > +       chip->hsu =3D hsu;
> > > > > > >
> > > > > > > Don't know these _flex() APIs enough, but can we leave the ch=
ip->hsu =3D
> > > > > > > hsu; in the same place as it's now?
> > > > > > __counted_by requires the first assignment after allocation to =
be the
> > > > > > counting variable. The _flex macros do this automatically for G=
CC15
> > > > > > and above.
> > > > >
> > > > > Why? The hsu member has nothing to do with VLA, where is this
> > > > > requirement coming from? My understanding is that the check shoul=
d
> > > > > imply the minimum sizeof of the data structure and the compiler s=
hould
> > > > > know that way before doing any allocations.
> > > > Not sure I follow. This patch changes hsu's chan member to a FAM.
> > > > Where is VLA coming from?
> > >
> > > VLA: variable-length array
> > > FAM: flexible array member
> > > The second one is VLA member + size member.
> > >
> > > What your patch is doing is changing a pointer to VLA member.
> > >
> > > > The current code is devm_kzalloc(x, struct_size()). When it gets
> > > > introduced, I'm sure there will be a treewide conversion to
> > > > devm_kzalloc_flex, which would automatically set the counting varia=
ble
> > > > for >=3DGCC15.
> > > >
> > > > It's best practice to assign right after since kzalloc_flex does it=
 anyways.
> > >
> > > Still, I'm not convinced we should blindly follow this rule. The
> > > length needs to be known before accessing the VLA, but it's okay to
> > > access other members. Leaving hsu member assignment where it's now is
> > > fine, no need to move it around.
> > >
> > > > > My understanding seems in align with what Gustavo blogged:
> > > > > https://people.kernel.org/gustavoars/how-to-use-the-new-counted_b=
y-attribute-in-c-and-linux
> > > > >
> > > > > The same is written in the GCC patch description
> > > > > https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html
> >
> > If you agree with my reasoning, please send a v4, I will give you a tag=
.
> >
> > Otherwise I really would like to understand the justification why the
> > assignment going first is the best practice and how it may help the dev=
eloper.
> Merge window is closed right now AFAIK.

You mean opened. In any case this kind of patch can still be sent,
it's just no time to review by the maintainers, but on the positive
side while they are busy with other stuff all kind of CIs, test bots,
AI reviews can be performed before the maintainer has a chance to look
at this. Which saves their time as well.


--=20
With Best Regards,
Andy Shevchenko
