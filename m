Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4B381D1
	for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974142; cv=none; b=VYpIaWQH2ZsmS+RUTL5eE4A/iR1aGg+jCpEqUPudkWTA9GgGn/3QQSgP2lVHrT1zgtTylzsr++clPtjdaMVKy568i7xl0Yt88k2hpmSz0lWIYu4l4kVcTCwlxwjcHFiAnTKCdhpH9a8XGKFaq0SuoQSNYdGeHl4eXOxWxrRwkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974142; c=relaxed/simple;
	bh=NMlbaJEt7YuPuHyd8puVAOBb7ZGjFfwrKm2bJ1oJU84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnjE9WS/JBYz7q+GgGRsB1UIfcY/zDSI2SY8O2IgewXLqiJlW7xRdC4YUr4rxqWg9Ci+q8frBUMeCXL9LLMdEvuSoZ5ABLjuyAAfc8iFbCPdSM3rBMZ5O4pJjNhOaeZYi26KsaB4haPeRvvF3u3amFx7wgZHQZgwiHIwqpf8izA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eV/obVnn; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eV/obVnn"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so6705211fa.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710974139; x=1711578939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/Eqc8JOcHZY7IXZvTiJ/8bJTfQGWaXx+KUSs3MCDdw=;
        b=eV/obVnn+pkRFC3DIHtOu5DiaFg9XNthy/K/L8aCgvXkkVDNtcfuWph3MLxuKV98UX
         M0JYxVfXuG+JJokGK4wic7VpBuTRAZOWTbXrsPtAKPSUtBcw8TBRijyUyponujSD3QS2
         +Z2nqUTZmEvsKLFJyNZoig9Vr/F5mxjH3UqxHkK+w0MUE5HqWbGoWGmVjZWB8gyKoLCi
         lTXr6JXgp1RRCl7og/nEiCyZXQbkHWWGQvvUavvB5FvqthlhPN7NcPPCIL0oLeCvqx81
         VsqJtBQXQE0v88j4tshpdM8NspKjyTVDY7oIIRJHurS42m2GpMGgXR8mx/Ry+Y+TpaZ/
         XoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710974139; x=1711578939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/Eqc8JOcHZY7IXZvTiJ/8bJTfQGWaXx+KUSs3MCDdw=;
        b=D9JBcJtW1F4RT6DeppNzyy6i7G/0dpljsn2O99tjBojkOc/a62UIkgolkJVpHChQLc
         zMQ1zNbWGnSRtx5SEAkHGC6oRFUDK7dlhnz/Zu0Y3nKA4YAz6dbKPZdsDFUAlhyHdRBP
         TM2+g4Fh+qTjoY6EDaC3iycnJy6IKrtLnaJSBJ4E4sT6OwP5QVAS5qku27ROh8M9tq/c
         N4EycBf+Z9zFqMZy/rN/mdvXZhKwBlAY+dbhjefak6xlU9SdbV1AU+CcX9ViABdBfcZO
         NpFtTsz6Uq7UwhntHA/yaU7XlzPWuxasz/h7m8jAGcjh5BkTtmRjqEDOgDHQkhiVgvJI
         rmog==
X-Forwarded-Encrypted: i=1; AJvYcCVSZSskgLa1bi3qSCI0C267gfeo1Wp8UpLMTQG3wUaj5jpXXrePMKFsDd9V8sNJJRUKqYkO4a7yoKVQzklIqWkTP00/UZ9FNTfwY7LvxVgq
X-Gm-Message-State: AOJu0Yy3HYKLZpTzB3Ah7HAY8cxoXqA9ZFI8z2u0RNbqVAfDhyjvmqNP
	UBsEqKEJsf/iCgqsIldhgDRfaoP80UJ4zh9QrE3dkBRZgEW5ceLlS89yPngyjVBJTyeitEfL97Q
	tTxJVIkF+GbgIjqIHyoOd59AuDKglEAyKGaiB
X-Google-Smtp-Source: AGHT+IEn5Owi2sPtfaUxycTRYFwNeKA+Pm2rq41oCVa8/UT2ciC5oEejXaO971X27DHZCT9SSJ+kpz2ClHcFLTEpRno=
X-Received: by 2002:a19:431c:0:b0:513:e17d:cf3c with SMTP id
 q28-20020a19431c000000b00513e17dcf3cmr8896729lfa.1.1710974138867; Wed, 20 Mar
 2024 15:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-strncpy-drivers-video-fbdev-au1200fb-c-v1-1-680802a9f10a@google.com>
 <53670007-edbc-4762-9e57-0b3c29220d9e@gmx.de>
In-Reply-To: <53670007-edbc-4762-9e57-0b3c29220d9e@gmx.de>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 20 Mar 2024 15:35:26 -0700
Message-ID: <CAFhGd8ppVq9aGbfFLeL30jQ15KHS=FoLh0c1udXo=Z+pCfXL1g@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: au1200fb: replace deprecated strncpy with strscpy
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 20, 2024 at 12:56=E2=80=AFAM Helge Deller <deller@gmx.de> wrote=
:
>
> On 3/19/24 00:46, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > Let's use the new 2-argument strscpy() which guarantees NUL-termination
> > on the destination buffer while also simplifying the syntax. Note that
> > strscpy() will not NUL-pad the destination buffer like strncpy() does.
> >
> > However, the NUL-padding behavior of strncpy() is not required since
> > fbdev is already NUL-allocated from au1200fb_drv_probe() ->
> > frameuffer_alloc(), rendering any additional NUL-padding redundant.
> > |     p =3D kzalloc(fb_info_size + size, GFP_KERNEL);
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >   drivers/video/fbdev/au1200fb.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au120=
0fb.c
> > index 6f20efc663d7..e718fea63662 100644
> > --- a/drivers/video/fbdev/au1200fb.c
> > +++ b/drivers/video/fbdev/au1200fb.c
> > @@ -1557,7 +1557,7 @@ static int au1200fb_init_fbinfo(struct au1200fb_d=
evice *fbdev)
> >               return ret;
> >       }
> >
> > -     strncpy(fbi->fix.id, "AU1200", sizeof(fbi->fix.id));
> > +     strscpy(fbi->fix.id, "AU1200");
>
> I wonder if you really build-tested this, as this driver is for the mips =
architecture...
> And I don't see a strscpy() function which takes just 2 arguments.
> But I might be wrong....

I did build successfully :thumbs_up:

Commit e6584c3964f2f ("string: Allow 2-argument strscpy()") introduced
this new strscpy() form; it is present in string.h on Linus' tree.

>
> Helge

Thanks
Justin
