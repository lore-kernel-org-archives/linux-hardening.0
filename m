Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043C19AD70;
	Tue, 22 Apr 2025 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305436; cv=none; b=VOfgTEQ7jZA+LINiQ3suvMLtR1AD36SN7USsF+yZqZAy17aOHR/Kw3CMX/wXAbXqw/5+ADASKHGMY9IFX9hJgSIWwAQtG4AG8QPfs1bv2nePd2OFarICpEkfIS7t79lU95QciQv4QOAJfHj1REgFrXmS5NAs4A6q757IiaXhREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305436; c=relaxed/simple;
	bh=tYbMWgCVMGf6YZWOsnPA1SsgNuLrNVou12YJYKuZRmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcxKKkwwwUYaDL6F3viAmErW73Jcz+xxlYP9Far6YlpC/+cRSylUhrJLBUDx+MOR0T1dUIOFlT2KN0u9he8kOOkTpzbaKWvm2rHBgS1jTV6mlhAFDki74ecZfq3LtrDPYbaDrTSHXPqhJ/NxZwSW4SbLHTLgmJLB6UVwkM9isxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51eb18130f9so2123104e0c.3;
        Tue, 22 Apr 2025 00:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745305431; x=1745910231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjQ6P7xPHpYA5hR0NBtg5+glzAqNpKTB4hO/66i0slM=;
        b=bUgnk1ZAUoyaFp5t3iD5eC3txSn+2O77nbuFJFEq4QmUgoF+dBe+ZsLJud9YYfvpNR
         CbhJAhxHCI0iQfAn9lY7h+biC5sX8l2tXAaCELHnnKTHXNkny+d4DN/b7GpxNhm7zF76
         wWAuSFAA2huCBZXN6GKpvDxbA54uPr1tXuNd4cVR6/R63/K/3YnrRv7RFGpPPvTIUqcY
         +56chsrUVyB6qu9p9lAoGeYjDn1JzVf6/WbVUNxlD4/XCfQIO9k8m2T4s7KWCvqtkRJl
         VxwoUdM8CNlceD4uN2Bbcn0+pQfG1yAF8woNK7YLdgb4rAzU1tf7dtA1lVuCeqxGVMDB
         I6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYLkDfb5zs+qsEC1WmVBVdsfwZvIs1o3WY4R8AjH5mwWJqa4PXxv8sKSQRuvLN2Y+ZzHfj9ZEMof6T2hLI@vger.kernel.org, AJvYcCWBIUKXSeJZtGP35/fzP4aCGy8esJSCt7cyOmwgv1eiWitlkgbO7s+laek5U7zuc0Y6KoFE2meHUCFC7k/OpSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3Ucw9sVDHI593zrLCoz0V9F2XAq2pleB4ukcRGexWmUhlYtq
	y/vdSqii+F0CGE7OWBOzikokAR7rUXUQhG4+PKEFVWG5cccDHo4/qjW7gEUo
X-Gm-Gg: ASbGncuSXig7PAPNuzfQ6TFcl+tGutFphoQzMMKwk2dOTPCA5JCIAxpu+5S6ltExQ9V
	A3eFFj5KO9vGGYfN2OX0FzJHymOlquU7oxU5VxXbGQOU/Ent4FbvI/xhedm+4dzKbeNBTH8yXr+
	XsNKfqrHp9DhKml8IgDT3bb4MAb3eVt0vRZB3HSPG99QN37TJoIwCAPyCYz6Xyl0y+ChT+jXer2
	tFmgHUwcEwBdO9AlaQhHjPIJs/sUNLq5GuVY4qt16QCaq7SjrxFJxgQahXrD76D0FOdYB1uaHxm
	mU75Dqmg8JtBTAG5/FLB+jm+5BlTTA1O61GR2VMbYa8626Gi/qXvegYMuTuWcE4GSBkQfG31mKG
	Z7Hk=
X-Google-Smtp-Source: AGHT+IFPoPodXAzgrq5yC8eUlwumdNHIT0YIYnglmcpPFBZyg7aX95WmS7BYqM2C0NbEwjDzkEaFeg==
X-Received: by 2002:a05:6122:489a:b0:529:c87:e4a5 with SMTP id 71dfb90a1353d-529253cc2a1mr11464061e0c.4.1745305431362;
        Tue, 22 Apr 2025 00:03:51 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-877647999c1sm2156432241.29.2025.04.22.00.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 00:03:51 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86dddba7e0eso1820672241.1;
        Tue, 22 Apr 2025 00:03:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW69Z58Gon6zfPCgwdpGg4qLnJbaqReUfSqXFxsal9Hsu6zmmCA8hvSgDmVgKjZPny6IUQT8dN/M0KzQ4OO@vger.kernel.org, AJvYcCXHbPntFdAmFuvHX21A4OTOOFCqlKF8mnVJD03cLYuyW6yLs1MolZ3pD9Xr4O+a8IyoWphAxyDnhgYVulptRWQ=@vger.kernel.org
X-Received: by 2002:a05:6102:311a:b0:4c4:e42c:38ba with SMTP id
 ada2fe7eead31-4cb80145a4bmr7009563137.13.1745305430717; Tue, 22 Apr 2025
 00:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421122839.363619-1-thorsten.blum@linux.dev> <f178cc44-1b97-4e72-94ae-cffa08173a99@yoseli.org>
In-Reply-To: <f178cc44-1b97-4e72-94ae-cffa08173a99@yoseli.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Apr 2025 09:03:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxdhTrxHuP5AmZEj2c+RRnUf0qfwsdmJ4CJNGg2AwXug@mail.gmail.com>
X-Gm-Features: ATxdqUEaMllpvSmtk5uCeOO86P44ubvL2-2J492ivHDXIiPpiUf3EKaelrDCJLY
Message-ID: <CAMuHMdWxdhTrxHuP5AmZEj2c+RRnUf0qfwsdmJ4CJNGg2AwXug@mail.gmail.com>
Subject: Re: [PATCH] m68k: mm: Replace strcpy() with strscpy() in hardware_proc_show()
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Kees Cook <kees@kernel.org>, 
	Greg Ungerer <gerg@linux-m68k.org>, linux-hardening@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jean-Michel,

On Mon, 21 Apr 2025 at 15:02, Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> On 21/04/2025 14:28, Thorsten Blum wrote:
> > strcpy() is deprecated; use strscpy() instead.
> >
> > Link: https://github.com/KSPP/linux/issues/88
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   arch/m68k/kernel/setup_mm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> > index 0fba32552836..c7e8de0d34bb 100644
> > --- a/arch/m68k/kernel/setup_mm.c
> > +++ b/arch/m68k/kernel/setup_mm.c
> > @@ -484,7 +484,7 @@ static int hardware_proc_show(struct seq_file *m, void *v)
> >       if (mach_get_model)
> >               mach_get_model(model);
> >       else
> > -             strcpy(model, "Unknown m68k");
> > +             strscpy(model, "Unknown m68k");
> >
> >       seq_printf(m, "Model:\t\t%s\n", model);
> >       for (mem = 0, i = 0; i < m68k_num_memory; i++)
>
> As we are not using the return value, I think it is a safe replacement.

strcpy() and strscpy() not only differ in return value: the (optional)
third parameter of strscpy() specifies the destination buffer size.
When not passed, the size is taken from the actual destination buffer.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.16.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
