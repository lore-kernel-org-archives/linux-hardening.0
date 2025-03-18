Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6F151990
	for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323175; cv=none; b=QibpTgyXfVxwtHUfr8zE2TVg9Qa9D8kCwZAjrfBQYemlNAnsPmk2kq2RM6cAySRr7JrayvoMBO8z2PnXgmESJpfcRPl3wjOm7ETIB8MDLlxRkGTmW/ccXLK7qIrs72CltI3z1h31GdY/EfPWpPt5PrKcACRlEDtTkklXxrfn3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323175; c=relaxed/simple;
	bh=0TcUd7Hl63YILf+lnmo+04OQn5BnU2xfbZRZeHl3APQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1ME8lo9am5CbXCJJP0Ny/7w1EMbZhBaUryaZvHoY2P02mzmsjwxVceHc1n6nXmTJoiEVrfxyseOorx2PXvgJPJPVJw3i3GrcPVzqnFjzFrPovbzjaFIGOJ7NzmOPhB7obyrUXmNtq2jhHvHZ7JGinmARJ9SmDN/SCZamjpQ5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KX5lTn91; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KX5lTn91"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c2dfd67dc4so1206985fac.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742323172; x=1742927972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK/HaNNt16Jn6Ltrxg3s+WfbaJC8sctuUw0URkrTOFw=;
        b=KX5lTn91bzS//LFRpKPLmEzSqaytDDoCJDmn+FQGQY2cOf3FOgVzKjjsw8CTpuuijB
         qPaFayBFdy5KdZUcYPiFetC57uLYTMzOP8aeIGD0mDXTzAPFJvGRwlYNr3fmMlRHdNPv
         6ttg1H5uLTxr4p86ga/m8RtV0rQXY00z0khMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742323172; x=1742927972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZK/HaNNt16Jn6Ltrxg3s+WfbaJC8sctuUw0URkrTOFw=;
        b=EbEB+Uyf2lVyXjy6Ux03WvD7ofg3cuBNrHbC5Q4y4qcOMckj6gdWfxKTR/N8K7cxPy
         k6j0WlWZdVxm6OwFy7xuEaIp07WpDp0/ETGIAxFQisYuZpUaMW8X+2mKsKLBYdytPytV
         aweH0Pe4m7xNYN9Z78qJzfja96xg18DHdwNxrFfKPt/rOCFov/rKvWtheDHLOohlsz1H
         W4wk7uy+VB2zRSBEQ856xuoem4WVaPbqs1NbNt/YJrVHeV7ACSrcrgvP0t43hcI3TVu9
         YnWCWjlg58cUCHv97TjLbOyKVtTSu52LBjgcNRoiyJzXA2svcw78M0lYCGKRgsLkNXwC
         GkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmT7pLSb7fiYVd2x/uqRaggxkkFtAbdrmCymEVV1ndQkTNnSfY4ui3fBxVVN66DtZPmaruSl5TESI7BSKBDtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWA91uWjJGx0aPhk0JDctWZz9KPup/C9Cz/d8TZx4F0AV6ofO
	uCrbXFChahIhzkO3oDY1UOFrq9L+oiq6Ei6sZQJVH/cbBZTd0Z/iFzj8xcyMmU18wP7b6jL78XP
	Ic6ZmFf5twTdLEW1H++1NBLzDXsNaBATxoBM2
X-Gm-Gg: ASbGnct5O4gWiEDKOnzyKBQM37cLNbYxzeEjN3/YHiBn3J276SsJ2Au6l5ESa9AgWZY
	fq5xRJnaRHXEISisQDVxlXQ/QUnQl2mWwlK0vU9PvPboNliqXGRfYbegY+hqqjs0VyN2aXMRZGO
	qsdHwKVp+0APMG/f0YGStoD/IozBZ2ezkMWQ4hrDddmNURF5+j7fgJGEo=
X-Google-Smtp-Source: AGHT+IGyA3j04un2+ESjxa+9cBpRt/juEG5Ye4atB2rjEsAbwslLKwYkSJYOHSgwji8vp6mIVLmkKLGzqqwscbsJQDg=
X-Received: by 2002:a05:6870:158a:b0:2c2:3c72:77c1 with SMTP id
 586e51a60fabf-2c6911a0550mr3196716fac.8.1742323172390; Tue, 18 Mar 2025
 11:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
 <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
 <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com>
 <CABi2SkWmxwM-MbfmRCZvBYek8KpmOKPMsFmb=-eZTgKfp3AN6w@mail.gmail.com>
 <CAMuHMdWUHwRXR1VHEVJm36Dp0B_H6SNwtWHAW1dMQ-iM4ORUWQ@mail.gmail.com> <CABi2SkVndMyOUpRR8z7f0J-r7chkVNZ17-kaEcBje1kBjk-1iw@mail.gmail.com>
In-Reply-To: <CABi2SkVndMyOUpRR8z7f0J-r7chkVNZ17-kaEcBje1kBjk-1iw@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 18 Mar 2025 11:39:21 -0700
X-Gm-Features: AQ5f1Jo7pYVmyf59Pe86F5P8HtE9QOhxjfl1f888QvxyvlojUrP7qGyQTg6VBF4
Message-ID: <CABi2SkUAnWAu9L-Km35U4XMmbp9-w+hKCXkM6MYNejYi5ip5Tg@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Geert Uytterhoeven <geert@linux-m68k.org>, edumazet@google.com, m-malladi@ti.com, 
	Kevin Brodsky <kevin.brodsky@arm.com>, guoweikang.kernel@gmail.com, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, svens@linux.ibm.com, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert

On Tue, Mar 18, 2025 at 10:21=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrot=
e:
>
> Hi Geert,
>
> On Mon, Mar 17, 2025 at 12:14=E2=80=AFPM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Jeff,
> >
> > On Mon, 17 Mar 2025 at 20:02, Jeff Xu <jeffxu@chromium.org> wrote:
> > > On Mon, Mar 17, 2025 at 11:14=E2=80=AFAM Jeff Xu <jeffxu@chromium.org=
> wrote:
> > > > On Fri, Mar 14, 2025 at 3:41=E2=80=AFAM Geert Uytterhoeven <geert@l=
inux-m68k.org> wrote:
> > > > > On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> wrote=
:
> > > > > > On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> > > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.org=
 wrote:
> > > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > > > Add Documentation/features/core/mseal_sys_mappings/arch-sup=
port.txt
> > > > > > > >
> > > > > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > >
> > > > > Thanks for your patch!
> > >
> > > I used "find * |xargs grep -i  CONFIG_64BIT" to look for CONFIG_64BIT
> > > under arch/, and together with internet search/wiki page, and below i=
s
> > > the proposed update.
> >
> > That way you only find users of the symbol, not where it is defined.
> >
> > You can use
> >
> >     git grep -W "config\s*64BIT" -- arch/
> >
> > to find out which architectures are 32-bit, 64-bit, or support both.
> >
Microblaze, openrisc, sh, hexagon all don't have CONFIG 64BIT defined
in KCONFIG, and are not using CONFIG_64BIT in their arch code.  Is
there something else that makes you point out the hexagon as 32 bit
only (and not other 3) ?

The microblaze/ openrisc/sh are currently listed as TODO in this patch
, and that is because the search results show they have 64 bits CPU.
But I like to double check.

I  included some people who recently merged into those arches in case
anyone is familiar with 32bit/64 bits usage in those architectures.

Thanks
-Jeff

> Good to know, thanks!
>
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/features/core/mseal_sys_mappings/arch-s=
upport.txt
> > > > > > > > @@ -0,0 +1,30 @@
> > > > > > > > +#
> > > > > > > > +# Feature name:          mseal-system-mappings
> > > > > > > > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPIN=
GS
> > > > > > > > +#         description:   arch supports mseal system mappin=
gs
> > > > > > > > +#
> > > > > > > > +    -----------------------
> > > > > > > > +    |         arch |status|
> > > > > > > > +    -----------------------
> > > > > > > > +    |       alpha: | TODO |
> > > No CONFIG_64BIT found under arch/alpha, but search results show alpha
> > > supports 64 bits. Keep as TODO.
> >
> > Alpha is 64-bit only. So the code under arch/alpha/ does not need to ch=
eck for
> > CONFIG_64BIT, hence you didn't find it;-)
> >
> > > > > > > > +    |         arc: | TODO |
> > > > > > > > +    |         arm: |  N/A |
> > > > > > > > +    |       arm64: |  ok  |
> > > > > > > > +    |        csky: | TODO |
> > > (N/A)
> > >
> > > > > > > > +    |     hexagon: | TODO |
> > > No CONFIG_64BIT found under arch/hexagon, but search results show
> > > hexagon supports 64 bits. Keep as TODO.
> >
> > 32-bit only on Linux.
> >
> Ok. Thank you for correcting this.
>
> Thanks
> -Jeff
>
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker=
. But
> > when I'm talking to journalists I just say "programmer" or something li=
ke that.
> >                                 -- Linus Torvalds
