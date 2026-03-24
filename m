Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202B389445
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367804; cv=pass; b=B46QIDgp9L56pt+olK3es/ef6V19eYZbJFfoy4TOAHR7G+joniJQBnxgwWZD3JFk6Cm4/Y1GrjUDp076Dcbbb6TEN/z5C5XbYYh6OHggZR66sgwrzQHzYeAtVxaOLg+ipLLTFQ/f8qEM1pxWqtZ1mPlUqR8GaeKQOoFyK4DCyqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367804; c=relaxed/simple;
	bh=NcFE19+lHolIoka+UAD/Gg4aP7dmCd3kVrW0euzZIw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGSNN5oBUKJ2Sk4SOdSTU9A+vTLywKoupc/w1/7QENA7/FuMVNcEusH2vrDEjm8cF6comaAeZsvtTzrh3Sa2LZq94yqwncy6hsZx/HXL14i4iHvGV9koIPsiOufRxkCUEMHHBwBaXUuNUr9VspQlDuTBJJE8ThNIL90/ADpL1f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7qTo02n; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7qTo02n"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so660736466b.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 08:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367801; cv=none;
        d=google.com; s=arc-20240605;
        b=V56MNo9E4sfiq1TDVWXFYaVRrnAMHYN4CsUhHelWg2Vi3J0c3+1b110wLt71jJvyy3
         W5Z+hLU9XTWwqETLBwPqIKBkkFinVljHXqZvQ1e2sGe3za+uuK09GHYLASsCT4Iwig8T
         HL1U717uhYxRxMApB8P3A6g11exjUlsJaIOV72NeRVgurahIKHEKTCkxlYJ6aDcSKVj0
         ir/V8wtDXNeHc+NDeiU2Zl5R3Nd6U868GA1f3FvXVn1CT/ONiSD3qEKyqm9RgROHmAj+
         iMtfGEEfluCaUxOXhyt4E6y/k2qF9hz/1tB0z7u+O3uQBCqb1/dVadk6uW2nMLJM/E9V
         pOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f3qRkrcmZqnQcAsHSgrGTF3O2trpu3zcL2/3GqhPT84=;
        fh=2Ozhl7xYFD6TTVAGpr2latQwHr229zW5LzjUXSsTLNI=;
        b=Q66JEwdw1vw9zGiJnpSwy9ILi9OdG2ZPV6ii7qNIuqs479akwv9MSMQxYgoUlqqjhc
         IavI6VbMzqJ2NmkopZb8a2KDpGrgVdBNBCcMUGz3CKmBVjUBJx3pru1iO2pxvAczjaB4
         G+F9qT/CcxTB6t5wkYGErdF1FolXMmqpsasLoXGJtz4adE7JHe4ozb/guNUE4/27CMg6
         KXhkXGCNhFuvltt6CQ4fTQNiYSWE/GOhskjpF2RJPoGQWvps16UFMm5DG32l0M16ATqK
         H7tZz15FSNseETJIs4OIsBOWKwO87b3P0tHr7ntEVdV+7y6taslmV7foNm91yzrvpiOa
         2DKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367801; x=1774972601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3qRkrcmZqnQcAsHSgrGTF3O2trpu3zcL2/3GqhPT84=;
        b=q7qTo02n6KtI43Ap5uUPAShjuPBFjEbcMeALEY7V5s19EZv8S7ihl7Z2ZVR0YA7U88
         PY4bn1gK2PmeKOwB+hsAh7pCEpQ+c6wmB6DgIgMRcAXgNhOOQc9u0gwA0FGZ5P62CIgW
         H7Z9N9Bs0b5xtCPdHva6EGvn61gPW0tRMrQxHmkodWdPdHgZT4qjnWs6HzFVAepEJ2IT
         Z+vAnjnvxt5KkVCjOpew95DEj3iZJH0mNxxIAKUMS3PQ2WL1JJwVQ4MrTWMZPmoHL+44
         FDTZXlOgyXAcXLrbDFTNxboiSQ1GLwZkE2I62UaVb80oLTpgKDWw0rfhKk1/inAt5P+n
         lh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367801; x=1774972601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f3qRkrcmZqnQcAsHSgrGTF3O2trpu3zcL2/3GqhPT84=;
        b=drMrywOGmQn2S/RntK3KnD8Pimfx64mOZi5UqQ+HR5yagfLNOFV5y0yDy7mrDTA+fB
         R18Vmw3+BPmlXvegdKtFh0xLya8Lx0UfxXtcsXOGTZsfqaevxClU6/1ZFp8roBpXH/4I
         LA7MdZ4OOFTp58AcXUhGmg+DAAvoEtlGkgBSqocj0tJFd2g4+jZCYnCjqn2lXnhG375b
         2kaz3u5g24er7ZfTfHWYZkHA3Lzff8Z42B9fS9nxwPA2s1eIn15WsUzk5p11j2MREHvq
         1J0WyHukbbXH9PCuq/EJ0ZvFZZv65JoKLRGLte3TsfyG+P8NCufp6041oNISVbS2KdmS
         TGVw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Fs1yE82SXZuougRDiX3bRylI2DkgQ3yFKfb7Lfj5oX/Hh6OIXDukaYSUDcyqv93IwMoEhvC1y1Vyi1R51N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfuPonSIWf4lU38UoC/LRwb39OTj5dHphU1K5WGIPf4fC2VbP
	0p3pRp+KwluxQ6CW/0ZDcNHc9arOu6fQ02l8PyVk1oEx5sDMsXUeG+Vyxs6jcYoyqk6XAj9Whdy
	cNFUpZijnkUf/4klgpEVkWeZQ+yFsLGF6Oozv
X-Gm-Gg: ATEYQzw4R3dKdGlxd6cn8hc4sDlLoUQ/KOuXIwGdlRH6Fp0PaK6Ha91Rwhu9J3Dh4Qz
	+8fY6Fkb4rptCvPwgGG0ysp2McpCyy6W5J9AkoiP9OFoWbK8Ec2V7S3EVMQZhERyH3LJJR0j+yM
	N/jPfvde4nTGOq/4NfgtIh88cs5Q3Q/k+8sWrdeqgK/ncHWZxz/CQmcB5arx7x/zNReexWoFRx/
	I9UX//hcOZc4+2L5i69FTzc9vcGbKzltToEStQ49dceyRz1T5NOFk1CHPS2Eqh27iDGHugJi8Ic
	Me4pRu9R3KvdiKkivla8EkkbEgB/HKg93AR5IfoI/sConR5zrS0aKwXjHHnf7Q86BgCSq4lLFZq
	4sl6++Q==
X-Received: by 2002:a17:907:1987:b0:b98:e8:8eaa with SMTP id
 a640c23a62f3a-b982f1ed70cmr1176255966b.7.1774367801042; Tue, 24 Mar 2026
 08:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319000558.22108-1-rosenp@gmail.com> <202603201104.8D7B8A1@keescook>
 <CAKxU2N8ZZp5fcCWfMaqZ9VKwNQ3a06fsQPXpBQa-d1N07zPGng@mail.gmail.com>
 <CAMRc=MctGTeqBHQ8zaQ7_2YAoWoTUxOK4_hs+-EHEQEPnz+A-g@mail.gmail.com>
 <CAKxU2N9KdziPen9-_gfe0UZjyuMTOsbb583aeF3=kqm22rGieA@mail.gmail.com>
 <CAMRc=Me2RLj-vvCVNho9CPYVwsQHypC_KvKHJWkLyj=rMkfx2w@mail.gmail.com>
 <CAKxU2N8gudRXR-bLMoyDVDuv3vWuzqrbyVsHL=Gu3mDZWMvs6w@mail.gmail.com> <CAMRc=MeYoDB1QsgckNH9OGWx=WJZofMHq+zL4xY8VK+rzP3gog@mail.gmail.com>
In-Reply-To: <CAMRc=MeYoDB1QsgckNH9OGWx=WJZofMHq+zL4xY8VK+rzP3gog@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 24 Mar 2026 08:56:29 -0700
X-Gm-Features: AQROBzADURwHKy8tFIAJpN4IsVdtcJXR_0r8UlcgpmAhJJaXZDOBRsprwoOTOm4
Message-ID: <CAKxU2N80Qf+Uc_daBSxjz26e54fAz8bLRPVZYdCcaiHhpfHK-g@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: allocate lines with main struct
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-gpio@vger.kernel.org, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:54=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Tue, Mar 24, 2026 at 4:52=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > On Tue, Mar 24, 2026 at 2:16=E2=80=AFAM Bartosz Golaszewski <brgl@kerne=
l.org> wrote:
> > >
> > > On Mon, 23 Mar 2026 17:43:00 +0100, Rosen Penev <rosenp@gmail.com> sa=
id:
> > > > On Mon, Mar 23, 2026 at 3:00=E2=80=AFAM Bartosz Golaszewski <brgl@k=
ernel.org> wrote:
> > > >>
> > > >> On Sat, Mar 21, 2026 at 12:00=E2=80=AFAM Rosen Penev <rosenp@gmail=
.com> wrote:
> > > >> >
> > > >> > >
> > > >> > > static int gpio_mockup_probe(struct platform_device *pdev)
> > > >> > > {
> > > >> > >         ...
> > > >> > >         u16 ngpio;
> > > >> > >         ...
> > > >> > >         rv =3D device_property_read_u16(dev, "nr-gpios", &ngpi=
o);
> > > >> > >         ...
> > > >> > >         gc->ngpio =3D ngpio;
> > > >> > >         ...
> > > >> > >         chip->lines =3D devm_kcalloc(dev, gc->ngpio,
> > > >> > >                                    sizeof(*chip->lines), GFP_K=
ERNEL);
> > > >> > >
> > > >> > > But this begs the question: why add nr_lines when ngpio is alr=
eady part
> > > >> > > of the struct:
> > > >> > Maintainers for some inexplicable reason want an extra variable =
for
> > > >> > __counted_by works.
> > > >>
> > > >> I believe what Kees means here is: you can use ngpio for __counted=
_by() like so:
> > > >>
> > > >>   __counted_by(gc.ngpio)
> > > > __counted_by doesn't support nested variables like that.
> > > >
> > > > drivers/gpio/gpio-mockup.c:59:61: error: =E2=80=98gc=E2=80=99 undec=
lared here (not in
> > > > a function)
> > > >    59 |         struct gpio_mockup_line_status lines[] __counted_by=
(gc.ngpio);
> > >
> > > The following spin on your patch builds fine for me:
> > >
> > > diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> > > index a7d69f3835c1e..9427ab8c45f73 100644
> > > --- a/drivers/gpio/gpio-mockup.c
> > > +++ b/drivers/gpio/gpio-mockup.c
> > > @@ -52,10 +52,10 @@ struct gpio_mockup_line_status {
> > >
> > >  struct gpio_mockup_chip {
> > >         struct gpio_chip gc;
> > > -       struct gpio_mockup_line_status *lines;
> > >         struct irq_domain *irq_sim_domain;
> > >         struct dentry *dbg_dir;
> > >         struct mutex lock;
> > > +       struct gpio_mockup_line_status lines[] __counted_by(gc.ngpio)=
;
> > You're using an older compiler. This does not work at all.
> >
> >  * Optional: only supported since gcc >=3D 15
> >  * Optional: only supported since clang >=3D 18
> > >  };
> > >
>
> Ok, what is this feature called in gcc parlance and where does this
> info come from?
include/linux/compiler_types.h

Lines 363-364 in linux-next.
>
> Bart
