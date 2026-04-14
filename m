Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA18371D1E
	for <linux-hardening@vger.kernel.org>; Tue, 14 Apr 2026 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199631; cv=pass; b=SZ8a11dxKiQWPEZMrUxlP1fV0jv9/DO+2Kcb+YlqRs1Wcr85tu/QbCnuD5ceYixtRM5UtWKuRVS+dfF2pklyd6kTQT1ZZ9M+2JkSV3W/5vyAp1vBG1C4q4upPGZwFD594hu7mn4q9OnncZqL8xKWxDVRG0H9MRTo7Q+ccyvN7Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199631; c=relaxed/simple;
	bh=w74mUAf5VahjnEJnuSGpY2y5M9gKcwnQOiPx4hHYhvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKYDfQ2c6Zikqwtdg7KWvxGbpPLbrp+MrbmaXu8XQya4O/LdpB+beF0qOgwX97i6bK5SqYSM5huVS40BKr7+S7dWd+IPGwLKpwObgy9tEOU860c4p78Ts22ku37SF23Hesi/DeP7qEx7i3LKMdAMiZj0LCNJl8MnO3Ujuw8Tty8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/uXR2x8; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/uXR2x8"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c11eba219so765606766b.2
        for <linux-hardening@vger.kernel.org>; Tue, 14 Apr 2026 13:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776199629; cv=none;
        d=google.com; s=arc-20240605;
        b=LQTYIHzBsfJTGHnRoY4rkgJYfImNZWQs1xctWPNqDJdfv+VYKMLFCCQLTWFs+D4Tyv
         bKVPsRU3CIRFRtq/gAN4MmWroccpI9I/com17sG05ax4IB5EWSN8drFgRT1Ti6FYyA4F
         Xp3j1mxyUIiMbYwu4viI8XtlEwLI1CNsH/5ui81Qm4JVWsZidVHL6Ber/SyqSmj4TJZg
         8ncSgdIPLCY9yNdnyz+91XuE2bBqYR4AAZLdOuWkcHfiURIEYf7cpCb6s4rl4CkFjF8Y
         cPeNORxNe51+KCdACtD/kGwkjvJCr0uwDZjzV+sDxqbDklz1b8j6aOEtLDA//NTlsMdo
         rkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ULQscP/jHQhzC6bIBAm/mnPePwL8/2Be+C8MegQPnW0=;
        fh=fYmGu2QaeSb3f0y5XbB/4c21sF1wUCWMWVtOYM08Ikc=;
        b=JofeVub0SzBecbVWX5cEPudLpvPsxN0PCp4t2QsSX4ktCUvfQZ4u8ik/EtdloHCTw4
         kycqp2TEV55O6/kk8Gf+XCjM4zE5OxHGOdOHpu95/M79d2cInfQlqBqQHSYYAHEhqYPW
         BMdNfbpoh7FlV+ugLgrf0Hb/QchSX3tR++MzcxjBjxsSXX1wP2wzAK7OXI6ZIyM97dTa
         /6oC62FSGEYpLO/WgH90o64cqfknRKwt6dODGblFnKkkhC9UtKONXvbJXepblS1y0w8Y
         v3divGre51Pq/pXFCbLE9MRp65VlWyEMKz1tr8on3q7QbLI1xZLj186JyRn5AoMIJPu1
         mQng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776199629; x=1776804429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULQscP/jHQhzC6bIBAm/mnPePwL8/2Be+C8MegQPnW0=;
        b=T/uXR2x8sOCQj5JnasSVimdT6XFAD2+dgKJXcruygbd3Wg94RRCAbg2ga4qLnsB6yu
         lqI3cB0t0TmY9180yQ5ibTlO/l0Wg/XCkbMzWiblqfRwcSm9x8RXUArCBhqijGNCysa0
         ajulAScKpCiGw+rw+3oNHzWXjuDnDyynYymeec0GZjP953MiDfZ1TCvuHU27azqAVdbZ
         Xw7p5IN08uO32maJke1OORpyPJeM/e55zARQW9/omz/AWJVRcKYlYaksGNTt8lYLhfMz
         SmQvrS9bns8CjreKiok+ZKe4K4Hz/eMdUvB2drayDR24909WAAeWzg58Q1yApBcu9VvO
         4G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776199629; x=1776804429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULQscP/jHQhzC6bIBAm/mnPePwL8/2Be+C8MegQPnW0=;
        b=pp2IEiw04l8Esvc41bM2NqrQwtFxDwqPH3qKw94P/lWyirGfrBaiCqk7TUmrQk5kyx
         54OotdmU/nfTaix6K8zFOmW7w3SCwauqwvPj0YtxzoswKA0G2p33M7BkqxpuCIYl73cr
         3b0YnIojJ2A5ooaM3hgehdySfsq7Enmai4AbbKf2w79wYvjsjpvyaHdsNrFcRDZQlNA9
         I6qS+Y+MkAcYUecshX2PSr92AxqH6RYHirzcwatpKQULi2Np/U1e2jVZJuShaPDvJmEA
         3hWywPo6ajZMUdwjNaHbfPG+DMLBgiU8b9Jw10nrpyzvOEiQ0MCGAK4zOSsLdJmCZfah
         rQXw==
X-Forwarded-Encrypted: i=1; AFNElJ+WFb2gmmHPQcLPBZO1onpLraj7Iht5AAY+MRsFbjAxBuPiuRAToWDcKZIvtF6Z95xui4MUi8m+LaEmu+TrrJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+/3NrIRNLt6RVPjum4LJh+UZnF5yw3SoKrabMqohs0qXthHR
	Y/xtrVWo++ASbPhQ/KxvT9TlPIfmzBdkUSQ3FRbdFEHy2mBuY831VFMQ4IngMwZrjQFxsxncZ65
	iqmZb6pJFlYrD2OVk8H2Q4rf901X0IGg=
X-Gm-Gg: AeBDievI0VahSDmJihT6139DLOg2Cbn1Ur42IKaVcNsmrhNUH9Dp8PSaQBjHbUn7sNF
	LvTJhvLCpbv2CZDyqSOQlL0R3x8iY0lelJTOKl6HbPX8Hxe8lvnh5V1m335807IBFcI88iuX9ys
	NHo6HTietP5Qw+a6ZM6pwkYgfrFzT9Ih4GPYn9gv04VjDpZWGrkijj5KVn5gjyH7+FugQAcW2e5
	yNpJHXvYafvqp01b8JhFE3fE6VffnqqQOgf/k0luQKtbujWOZ/EryEThYE+6sFob+1EZhbtlHeS
	vGHyHwwliCCHTZLL7HsCyL4IYOAbNiM8i2NOGNXCywJEGHFsk3xGP6OgDGbvf1LzuiBEPlFSBkd
	hpsMahADhzIXRrZ+E
X-Received: by 2002:a17:906:fd84:b0:b9e:3bd:6ed3 with SMTP id
 a640c23a62f3a-b9e03bd788amr413611066b.47.1776199628403; Tue, 14 Apr 2026
 13:47:08 -0700 (PDT)
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
 <CAHp75Vf_Q4OqYgEOBhoFxpKpAkw5_+GJxQCTbA6LnbR0xhOnMA@mail.gmail.com> <ad415SF1zIrCof8W@ashevche-desk.local>
In-Reply-To: <ad415SF1zIrCof8W@ashevche-desk.local>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 14 Apr 2026 13:46:57 -0700
X-Gm-Features: AQROBzCICMG8Zo6fYMVai50qbGVhi3q2wK0diZ3X13vuWCIcE4K4JnPpYpjQdUM
Message-ID: <CAKxU2N-xb8CKuwxAXMhix9BH31UBSBLwAkxXiewyUQ=t0BsOTQ@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, dmaengine@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 5:41=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 01, 2026 at 04:32:13PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 1, 2026 at 12:31=E2=80=AFAM Rosen Penev <rosenp@gmail.com> =
wrote:
> > > On Mon, Mar 30, 2026 at 9:29=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.=
com> wrote:
> > > > > On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gma=
il.com> wrote:
>
> ...
>
> > > > > > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KER=
NEL);
> > > > > > > +       /* Calculate nr_channels from the IO space length */
> > > > > > > +       nr_channels =3D (chip->length - chip->offset) / HSU_D=
MA_CHAN_LENGTH;
> > > > > > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan=
, nr_channels), GFP_KERNEL);
> > > > > > >         if (!hsu)
> > > > > > >                 return -ENOMEM;
> > > > > > >
> > > > > > > -       chip->hsu =3D hsu;
> > > > > > > -
> > > > > > > -       /* Calculate nr_channels from the IO space length */
> > > > > > > -       hsu->nr_channels =3D (chip->length - chip->offset) / =
HSU_DMA_CHAN_LENGTH;
> > > > > > > +       hsu->nr_channels =3D nr_channels;
> > > > > > >
> > > > > > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channel=
s,
> > > > > > > -                                sizeof(*hsu->chan), GFP_KERN=
EL);
> > > > > > > -       if (!hsu->chan)
> > > > > > > -               return -ENOMEM;
> > > > > > > +       chip->hsu =3D hsu;
> > > > > >
> > > > > > Don't know these _flex() APIs enough, but can we leave the chip=
->hsu =3D
> > > > > > hsu; in the same place as it's now?
> > > > > __counted_by requires the first assignment after allocation to be=
 the
> > > > > counting variable. The _flex macros do this automatically for GCC=
15
> > > > > and above.
> > > >
> > > > Why? The hsu member has nothing to do with VLA, where is this
> > > > requirement coming from? My understanding is that the check should
> > > > imply the minimum sizeof of the data structure and the compiler sho=
uld
> > > > know that way before doing any allocations.
> > > Not sure I follow. This patch changes hsu's chan member to a FAM.
> > > Where is VLA coming from?
> >
> > VLA: variable-length array
> > FAM: flexible array member
> > The second one is VLA member + size member.
> >
> > What your patch is doing is changing a pointer to VLA member.
> >
> > > The current code is devm_kzalloc(x, struct_size()). When it gets
> > > introduced, I'm sure there will be a treewide conversion to
> > > devm_kzalloc_flex, which would automatically set the counting variabl=
e
> > > for >=3DGCC15.
> > >
> > > It's best practice to assign right after since kzalloc_flex does it a=
nyways.
> >
> > Still, I'm not convinced we should blindly follow this rule. The
> > length needs to be known before accessing the VLA, but it's okay to
> > access other members. Leaving hsu member assignment where it's now is
> > fine, no need to move it around.
> >
> > > > My understanding seems in align with what Gustavo blogged:
> > > > https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-=
attribute-in-c-and-linux
> > > >
> > > > The same is written in the GCC patch description
> > > > https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html
>
> If you agree with my reasoning, please send a v4, I will give you a tag.
>
> Otherwise I really would like to understand the justification why the
> assignment going first is the best practice and how it may help the devel=
oper.
Merge window is closed right now AFAIK.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
