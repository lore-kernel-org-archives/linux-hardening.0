Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641F364E95
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367531; cv=pass; b=kZBDtNiP//T7fDnxoQ4SJhup4DEbQyxIwgjHWlNpeW1kO7RCRUdRvwM4BvpxhSeJalTe+BYqojBeVN+fJ0xYVCL8f6g/Q7W+/f68dj1yWORTUa0AWPpUAW1id8KyOD3CHTJ2aXA2+lie3BLfNN7e9KNmK8RYMF3VGfin50oBDlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367531; c=relaxed/simple;
	bh=MeB5P/o+6ukbkA61NR67lkTMMytZ8ZhzDzkbS6f7sZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5qSPWaQJqxeNfHjaPPMSAOH2mEVBCRg9cgE5saFPFRWaEKH8/coOOaFdEk/WGnGqhMcs4yVNydO+yNdtkxh6HBLouU/6MCBRtN9SkxpCEK+P6tFKSRIlK8U9j9qp0w8+v127LTJ9IR4uoGH/YLO+Jh9wvbTfXDMDHJijYXpNIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKuDR9LJ; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKuDR9LJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b980b35534eso25166b.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 08:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367528; cv=none;
        d=google.com; s=arc-20240605;
        b=fqqqq1WhSilWJHL06Kv0enXXkFtZaxhAqUup5M3epK0nRr7OG5bnNI/VDCRMpbh0kx
         nxFjNV8TCsZQ5kaq4Bq2VSjKe9G2jjTq996wFNdWhl1c/FZv9CTkCryTQMtLNLy1+MFp
         7MCFVJPoYSJiMXboqI/DsKygZ3jXUzFAaO6weyHS31C7+zKucYV131nKa0pBWewtcnFu
         tKIpycr8o/pRupz/6UCLjCaLqTwv/WleS0WL3YkdGo9L0cyxcGXrPoxQLYKQdVqUvQNG
         NG6dlKNZ9pxPKwfW02rZTj18F1GgxPiArw9e0ecZbPcEQUZIidhiML5RLmJGtiOuIbdj
         vcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lD7l9bDtZUKA/Q1Nlb2bt3XnckUYIqjo8i1RjZDuiQU=;
        fh=+nMubZzBX2exqpKELjLdGnMhENTDnGbWjv48/rqt8aU=;
        b=i0J+oZwLOOQJhPMrl6W0wPL/Lpq31b9ZlynQroKWUAb3luwi3RyjyOt1aQf/Z5h/yR
         i5oDyFDdM8x1A6Dt0aW/DwIUhwMMhONvVxvV2ICnBjRr0qZGjGATChOdpriyAlI7wcIg
         pAWoDsCxQ6p34MC2lcWt7VSnlZAYfONCUk8PAM/C2Yst/MNaas/SFrwzQYAdkFkrZUdL
         CinOlBUmvPS4rihaof471YLZ5ah4W+nKXnp8kr/tk0wWQqVdnGnUd6AEhVBheSwyOyiL
         cWuHf2axm3LHEOdCjvhZmx8MpABCbC07MeDuBk8DqO1/VGGg1IYfd2es7IHna9QE/KJI
         qHpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367528; x=1774972328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD7l9bDtZUKA/Q1Nlb2bt3XnckUYIqjo8i1RjZDuiQU=;
        b=tKuDR9LJvdkt8/vPynnMgaP4vLMCFbdoG1nlhonK97Jq5LZDwph8mGbKcs0Thii4Oj
         h1on/ZNLx8vK4jdkFP5KXP3OiNdIavPfyvPB7a1fvdu5sgfi72VrnV2GiMI5N3GV7BtB
         mDun79UU/fTByv1Q9w64/XrunbddSSA/u6tN0irJFjb5MptDQLh2QxLKmEdDteoWrU8p
         spyBlcN9IN7o3vC5OOH5jcQiXDSrbTRiLoAxQap89LHTFVUtV9Npyizrq2NHdx83OhsR
         DaWPw1+JA0RFGqjorbK9D79SN0SfoyZrfcZ6RgJezX5TQX0gen17lkwZwuj6P8tV5z5W
         1McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367528; x=1774972328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lD7l9bDtZUKA/Q1Nlb2bt3XnckUYIqjo8i1RjZDuiQU=;
        b=ix49dmVZU82u6fs8Vgf8bf34tJlvQuW/uXRrcA0eUSmqAwRHxePcOV9wqlDSybqA3l
         oSEcFcIwedv686OjvqCA7aUmnt3ptSwF+iaX3+PXtWGRvluQ3hVyj0hOnqXny5BioL7w
         ag9Ll30LlxWrdsG291V0tt5LhsEkmndRlm/xl5iRpxVzvAWmgzq4R1tCqganVOIjIwZJ
         P+40k91tsDHhtf55LDmUmaJMw5s7LtoA3djo43t+fq+xXwo0D5g9p25y0G4EmQWSxcdX
         HCTs/54XjwrvNoRYJPMI6x0MvuevDQLueV+Hv28WQbr0JpWj2j9WUI9QSrpcr39xqiIe
         SAmw==
X-Forwarded-Encrypted: i=1; AJvYcCWKjsjRcT82pXOxDczZPXIa8R+F9xZukjUnfcHVQmWdv35pazQV/MeWnmweaK473CuvsI60YtwgLQ19bWB/bkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybXq2RgpKBtfj7JObkATVR7ItoGtRgvJszeyt22PMYdcRnVC6A
	wSaI1TuLfhijXM1zaGHOetmOAE3iISysXMSUREZPKAP0G//W833KnmeBvTdlKifsF8/Ws6LZp1f
	bwRVTpcc5KLoXDm0Hu0/8xrlev6zMLYc=
X-Gm-Gg: ATEYQzw4p82XAywHJ8xYQczkb4e8tu9QEgZsk0wyKqneZxIx8pdtUq6GSMP/LXt16Oo
	1nrkcY7hXSBlW5P7KuqP7yHE0dGwpp2qpYGBste6hHi1Fx+cQ2Ul7AopNokyWe+aDrYZusNZA3/
	RrWC96EmCrI7s6sEgnnaA1fX4C6SCuJfhXf6oJu4J7UhujLDshgrgbmND4EoJaFvduquQNQ07RR
	+fBayoUx9m/zkuUM+DsFPdRemhJsnWRw52VF0WWTk/wjkIbg7/rLrxBwKKoX46zr7zRFaUQmGOP
	QCuPDZ8tl2P96Iuf4mqekI46t60sSIOShTwOHIV0J5uPQ6g9HlSgAjNebTVrHqhRJIjaUcP94G9
	UvyXRBQ==
X-Received: by 2002:a17:907:7b87:b0:b88:5b72:ec39 with SMTP id
 a640c23a62f3a-b988630badcmr241190966b.5.1774367527875; Tue, 24 Mar 2026
 08:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319000558.22108-1-rosenp@gmail.com> <202603201104.8D7B8A1@keescook>
 <CAKxU2N8ZZp5fcCWfMaqZ9VKwNQ3a06fsQPXpBQa-d1N07zPGng@mail.gmail.com>
 <CAMRc=MctGTeqBHQ8zaQ7_2YAoWoTUxOK4_hs+-EHEQEPnz+A-g@mail.gmail.com>
 <CAKxU2N9KdziPen9-_gfe0UZjyuMTOsbb583aeF3=kqm22rGieA@mail.gmail.com> <CAMRc=Me2RLj-vvCVNho9CPYVwsQHypC_KvKHJWkLyj=rMkfx2w@mail.gmail.com>
In-Reply-To: <CAMRc=Me2RLj-vvCVNho9CPYVwsQHypC_KvKHJWkLyj=rMkfx2w@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 24 Mar 2026 08:51:56 -0700
X-Gm-Features: AQROBzA3I7YQY7GsShXPNk_xQ1egepYa_RDQXlRXjm_maNSW7HaU5ezLIW7I0hk
Message-ID: <CAKxU2N8gudRXR-bLMoyDVDuv3vWuzqrbyVsHL=Gu3mDZWMvs6w@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: allocate lines with main struct
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-gpio@vger.kernel.org, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 2:16=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Mon, 23 Mar 2026 17:43:00 +0100, Rosen Penev <rosenp@gmail.com> said:
> > On Mon, Mar 23, 2026 at 3:00=E2=80=AFAM Bartosz Golaszewski <brgl@kerne=
l.org> wrote:
> >>
> >> On Sat, Mar 21, 2026 at 12:00=E2=80=AFAM Rosen Penev <rosenp@gmail.com=
> wrote:
> >> >
> >> > >
> >> > > static int gpio_mockup_probe(struct platform_device *pdev)
> >> > > {
> >> > >         ...
> >> > >         u16 ngpio;
> >> > >         ...
> >> > >         rv =3D device_property_read_u16(dev, "nr-gpios", &ngpio);
> >> > >         ...
> >> > >         gc->ngpio =3D ngpio;
> >> > >         ...
> >> > >         chip->lines =3D devm_kcalloc(dev, gc->ngpio,
> >> > >                                    sizeof(*chip->lines), GFP_KERNE=
L);
> >> > >
> >> > > But this begs the question: why add nr_lines when ngpio is already=
 part
> >> > > of the struct:
> >> > Maintainers for some inexplicable reason want an extra variable for
> >> > __counted_by works.
> >>
> >> I believe what Kees means here is: you can use ngpio for __counted_by(=
) like so:
> >>
> >>   __counted_by(gc.ngpio)
> > __counted_by doesn't support nested variables like that.
> >
> > drivers/gpio/gpio-mockup.c:59:61: error: =E2=80=98gc=E2=80=99 undeclare=
d here (not in
> > a function)
> >    59 |         struct gpio_mockup_line_status lines[] __counted_by(gc.=
ngpio);
>
> The following spin on your patch builds fine for me:
>
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index a7d69f3835c1e..9427ab8c45f73 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -52,10 +52,10 @@ struct gpio_mockup_line_status {
>
>  struct gpio_mockup_chip {
>         struct gpio_chip gc;
> -       struct gpio_mockup_line_status *lines;
>         struct irq_domain *irq_sim_domain;
>         struct dentry *dbg_dir;
>         struct mutex lock;
> +       struct gpio_mockup_line_status lines[] __counted_by(gc.ngpio);
You're using an older compiler. This does not work at all.

 * Optional: only supported since gcc >=3D 15
 * Optional: only supported since clang >=3D 18
>  };
>
>  struct gpio_mockup_dbgfs_private {
> @@ -436,15 +436,16 @@ static int gpio_mockup_probe(struct platform_device=
 *pdev)
>         if (rv)
>                 name =3D dev_name(dev);
>
> -       chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +       chip =3D devm_kzalloc(dev, struct_size(chip, lines, ngpio), GFP_K=
ERNEL);
>         if (!chip)
>                 return -ENOMEM;
>
> -       mutex_init(&chip->lock);
> -
>         gc =3D &chip->gc;
> -       gc->base =3D base;
>         gc->ngpio =3D ngpio;
> +       gc->base =3D base;
> +
> +       mutex_init(&chip->lock);
> +
>         gc->label =3D name;
>         gc->owner =3D THIS_MODULE;
>         gc->parent =3D dev;
> @@ -460,11 +461,6 @@ static int gpio_mockup_probe(struct platform_device =
*pdev)
>         gc->request =3D gpio_mockup_request;
>         gc->free =3D gpio_mockup_free;
>
> -       chip->lines =3D devm_kcalloc(dev, gc->ngpio,
> -                                  sizeof(*chip->lines), GFP_KERNEL);
> -       if (!chip->lines)
> -               return -ENOMEM;
> -
>         for (i =3D 0; i < gc->ngpio; i++)
>                 chip->lines[i].dir =3D GPIO_LINE_DIRECTION_IN;
>
> Bart
