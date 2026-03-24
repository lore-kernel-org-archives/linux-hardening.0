Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1239F192
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376745; cv=pass; b=PUK6vZQeWQxVBCR7MdGjcRKsHQ5N7yLMgm18AiS+GQcy01bI8Qi7HsU2Oyg7nG40jnceWIRxMAZXE+/MRXTd/x27UZP2BWzUDVzCL0dOX1yy6ejhRsGdByFlmDma39rt2/g4FQ5a+dGUXtw7He2RJeSDuuYLCXReZSStFtCoGOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376745; c=relaxed/simple;
	bh=nSeJjWi9ff21ilzihYD7YJPR61++LDGp71PADOCu5cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXbO1hluIRshPR2sgcs+JH1Y+yKSO0wpcDN9CE77gn+TXbwZ3CkIiAMU2NEAEbCp25UrEIfWFaOQHd0tRqMVfFb27w6ZUQPiNf/CWK+n2C2xv5X+wctc+iW0ToxZ2Fc7Y8Py8048R9UcNRtBu8Cgy8mUVX+jxtpRBFy5EEK97vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr0JnZCI; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr0JnZCI"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9358bc9c50so253323766b.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 11:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774376741; cv=none;
        d=google.com; s=arc-20240605;
        b=hfYtXeXEHN1fiQidVYvUt/NhBaSFly2Llw9OVVRRa1b/tqHZO13CW6EnEF9WjESe2X
         4g7sCV2TNuYoJTwOMlKlP4Fb+6TOl8UtItg9JPXYWow1f+Pq7nMDoZtc2eDbwi9g7fDa
         +riF1Cy5CbzJjrZ+j8EWJ0kIFCOPbhZwaF/ns5Yarh1thECawE/8IgeyOYSfZmI5f3eE
         5JJbekNCXsyobrWC5JStFXGM1tweuQOzMd+5Ml6scHgLBCJFnSPthLSZcLhDdzgJAl/t
         2W8Ff4yl5F7RumqkUSXyM8VxRJYvq1roGusACiZnheo79mYejirJ1IwHbpvX9v98L5mp
         CMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QK4NUvTEC0se5sdlimEBUGkPC6mWj52an2k34LrXOLs=;
        fh=X7xBdfSvO7xdsoRQypAnfa5eJbRIUIpsytai8ivZQj8=;
        b=Ko+BJRl+/u1fn27zThOJi/Pr919yOPIqzX9ZEJ+0Xh07JjyrgkvMJ4K0GUhGL0M4k1
         Hd7/mpq/4BFrJxao1RcLiJi2ZC036xcu2edHuY4Z6ozcFvChToCtThOpjzUZfC7hQ+0c
         g9MyKbc8u9H+drCzqkfyXqNaL6Nk+K5AhJZtJiZ+27plb0p8pshQ1thwEXfy2qeeIxyB
         Rvmit+KXQ3gkqMVwUdPxIQq1oaW6mCIMKmQ1Itp6sQJTD9cw1fae2IyP2bIrw7Saztpr
         JiQHKCk69BHJkU2V6tbA7PS6+KlS3fOP45+tfPWX3bephFzReQig4TePsGTOI+EXYkSo
         zjfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376741; x=1774981541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK4NUvTEC0se5sdlimEBUGkPC6mWj52an2k34LrXOLs=;
        b=Wr0JnZCIrytmmcN/pEfjMSz1DKNpQTX1Zp/hXxE21IHktTEagZT8ASEunmUlmu1v9h
         nfRuZp/bWegr0JqYMf7z4KDFeR3M3edbh18KntwvpjVnGLkoBlfwgbCZ3fzgH1+c5f3E
         I9pVrXpXcET9fqq4oDTvJ/qj8Iyvo8C63VC1v3WAzyCXssgsdPDt1SOBOkmbm0dIL+xc
         6G9WRW0NkTwJbU9W/z46Y+LT0fYtth9gaNpsKJWhbolZGcHHuqB+sjJ9b9tshYM22ngf
         ArxzcTIKTgH/fFh2eKH76nEreiXj2VvFFUNHqr8HtI/wOO9dJahy6EzS99H0ewnBgv8q
         ZH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376741; x=1774981541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QK4NUvTEC0se5sdlimEBUGkPC6mWj52an2k34LrXOLs=;
        b=AD6KJ+LbA6vf7+hi+ipy0ZZopN+JzIncmjljgxoQE196pbZ74YeG9HGgjjNP6LN4gv
         XDgGZjt5R0T4RwoPNJgK4cm03E6SU9E5v29ryl+yEoU4oR9HQcfjfrL3W+POpPUfwKSH
         rU0Lcn1wugN1UDovMLX1z40gTaN72gtiP1vJ+04IdnKjVOKZfl0FHNpNUrUu2JAc+0jT
         xHQxRefm7QvjmM73NlPIncRGqxRHD592e+GtjLTip6TwOLJOu8+h4h9jToCidtD9KAHC
         1o/hfbUqVLwRCfuedaxygP1sH17zumw/o79xIB+1T4EqHaFKym4Q2uo84y3hUrXfppT9
         +46A==
X-Forwarded-Encrypted: i=1; AJvYcCXCe2Fv/6Mv2GmZQHHSkBtsgtLES9HO4cR2KDlm0Cjr+tsI6svHkfYACo8hkWJW9Kn1znHMd7xdcTrFkgV9ruY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0DxSBfmsZmKBJKL+QxDhk1jPE3FtN8VXLWI5Frdb8HX/286i
	y1zzTjTrUmn8ZeebvXt2e1lD+c4S1negXjTMlgiAO2ZJQjRpik4bvwZJJgD7IK08fB8xkGEZ/LX
	0YeZJbK9+pXuMr6AovWC2fhmsJtemNK0=
X-Gm-Gg: ATEYQzwIQMqpT2RZuhWMiQoDgKgTu52R/Of9g56hGuFnRaAe7lMFOqUBcCb8EYF9O55
	MlMu3UMilX6c/FPABHy0maBJjK1OZvs2Ss50+TFEZy9yv0P942N4JS3AYbCxHkiAp3TfMrC/Mun
	KvfCeeeJUe/C6VXD8AwEnj8nTPGX/rAdZbBbILtQKP1XDqF3xAw7c1D7ADRplPmZNal8d7tWkrw
	sRW5Yjl5ipkG9Xa9eDAYfE2jDZ0x13LnNoPXR+sFpC5dI5ASlM95ruPWYkRAYZkVVl/FDR8kPtL
	53Nijkpg7bV/Sl77Rj5R1UldW1lXgqd4j8iK1d2d9bob8VJx98nnuX+5lkL/TDtKxV3CwW+GLFc
	tZDvllg==
X-Received: by 2002:a17:906:f59c:b0:b98:8a4a:7d15 with SMTP id
 a640c23a62f3a-b9a3f1a70fdmr30898466b.19.1774376740366; Tue, 24 Mar 2026
 11:25:40 -0700 (PDT)
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
 <CAKxU2N8gudRXR-bLMoyDVDuv3vWuzqrbyVsHL=Gu3mDZWMvs6w@mail.gmail.com>
 <CAMRc=MeYoDB1QsgckNH9OGWx=WJZofMHq+zL4xY8VK+rzP3gog@mail.gmail.com>
 <CAKxU2N80Qf+Uc_daBSxjz26e54fAz8bLRPVZYdCcaiHhpfHK-g@mail.gmail.com> <CAMRc=Mcv1TW55R87xiuAOQShX1Tjf_=BkwfoXdDN8SfUK=a5GQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mcv1TW55R87xiuAOQShX1Tjf_=BkwfoXdDN8SfUK=a5GQ@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 24 Mar 2026 11:25:29 -0700
X-Gm-Features: AQROBzAP0LwYIgjA2GAFD4uEyPzen9IwFHr8wG9Eghx_TY_10NtmkgkzTOhTbjo
Message-ID: <CAKxU2N9gCoyDapYmiY31EMPnTr0vPns6nme26xtibw+Ybs5iHA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: allocate lines with main struct
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-gpio@vger.kernel.org, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:16=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Tue, Mar 24, 2026 at 4:56=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > On Tue, Mar 24, 2026 at 8:54=E2=80=AFAM Bartosz Golaszewski <brgl@kerne=
l.org> wrote:
> > >
> > > On Tue, Mar 24, 2026 at 4:52=E2=80=AFPM Rosen Penev <rosenp@gmail.com=
> wrote:
> > > >
> > > > On Tue, Mar 24, 2026 at 2:16=E2=80=AFAM Bartosz Golaszewski <brgl@k=
ernel.org> wrote:
> > > > >
> > > > > On Mon, 23 Mar 2026 17:43:00 +0100, Rosen Penev <rosenp@gmail.com=
> said:
> > > > > > On Mon, Mar 23, 2026 at 3:00=E2=80=AFAM Bartosz Golaszewski <br=
gl@kernel.org> wrote:
> > > > > >>
> > > > > >> On Sat, Mar 21, 2026 at 12:00=E2=80=AFAM Rosen Penev <rosenp@g=
mail.com> wrote:
> > > > > >> >
> > > > > >> > >
> > > > > >> > > static int gpio_mockup_probe(struct platform_device *pdev)
> > > > > >> > > {
> > > > > >> > >         ...
> > > > > >> > >         u16 ngpio;
> > > > > >> > >         ...
> > > > > >> > >         rv =3D device_property_read_u16(dev, "nr-gpios", &=
ngpio);
> > > > > >> > >         ...
> > > > > >> > >         gc->ngpio =3D ngpio;
> > > > > >> > >         ...
> > > > > >> > >         chip->lines =3D devm_kcalloc(dev, gc->ngpio,
> > > > > >> > >                                    sizeof(*chip->lines), G=
FP_KERNEL);
> > > > > >> > >
> > > > > >> > > But this begs the question: why add nr_lines when ngpio is=
 already part
> > > > > >> > > of the struct:
> > > > > >> > Maintainers for some inexplicable reason want an extra varia=
ble for
> > > > > >> > __counted_by works.
> > > > > >>
> > > > > >> I believe what Kees means here is: you can use ngpio for __cou=
nted_by() like so:
> > > > > >>
> > > > > >>   __counted_by(gc.ngpio)
> > > > > > __counted_by doesn't support nested variables like that.
> > > > > >
> > > > > > drivers/gpio/gpio-mockup.c:59:61: error: =E2=80=98gc=E2=80=99 u=
ndeclared here (not in
> > > > > > a function)
> > > > > >    59 |         struct gpio_mockup_line_status lines[] __counte=
d_by(gc.ngpio);
> > > > >
> > > > > The following spin on your patch builds fine for me:
> > > > >
> > > > > diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mocku=
p.c
> > > > > index a7d69f3835c1e..9427ab8c45f73 100644
> > > > > --- a/drivers/gpio/gpio-mockup.c
> > > > > +++ b/drivers/gpio/gpio-mockup.c
> > > > > @@ -52,10 +52,10 @@ struct gpio_mockup_line_status {
> > > > >
> > > > >  struct gpio_mockup_chip {
> > > > >         struct gpio_chip gc;
> > > > > -       struct gpio_mockup_line_status *lines;
> > > > >         struct irq_domain *irq_sim_domain;
> > > > >         struct dentry *dbg_dir;
> > > > >         struct mutex lock;
> > > > > +       struct gpio_mockup_line_status lines[] __counted_by(gc.ng=
pio);
> > > > You're using an older compiler. This does not work at all.
> > > >
> > > >  *
>
> Indeed, sorry. In that case I don't know what Kees meant. I'm fine
> with a new variable.
I think his comment is that there's already a counting variable, with
or without counted_by.
>
> Bartosz
