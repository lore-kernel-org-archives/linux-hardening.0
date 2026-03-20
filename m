Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237034104E
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047754; cv=pass; b=BRxFkVCzUojYW0L2J/oz3zmavyPiA1AYAqTfuoohCSlZufJniy1Q6y8PUo0moVcaBpDxz/V3g4qQWdp2CiFTkAUtPX4lbXG4vPnGZtpnIMz4AGvZj0EAGw/IL7BiOagqH5X1tVYfqDNqU7xQXNiOdN7Ina8cIQFJgECfMkRbKps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047754; c=relaxed/simple;
	bh=AHyz3fklJvx0xq22pb18w1unw0EL2aMHoAXZ0+CKbWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5+4/deEJmUMh4COy7Yxz1AEnda9QiSBXsqaTp/dxu0a7L678dDpx7bYTMUvzJoBZpO0AmnfwcUH3ULtrR2IEFfGO8o3TmGjpE0SRsifhKnaFyiRe83joi1iws3k1rPJR48gMoy0HCFBKFX19QMyAUlGsnKJgYgN+NPlDgd7kxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZBC+ojC; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZBC+ojC"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9382e59c0eso159839166b.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 16:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774047751; cv=none;
        d=google.com; s=arc-20240605;
        b=kisNMZUDx/oxdf7XYHywSIy7F1wcPu31VpPKMwOgPq3BhPA/n+NJcZYkbntLGIz7lr
         tud2IpbTCJeXK1RpI2IhXvtTnun+fIJ5JVPhQqN7ltXF7MdGoQJYL3dYUHzUuAnHMofc
         5eBY6Cxs8txGh7Bn8ug9w49M5JH3eXxNBRKI9uLKwBodvrF1zKH5yO8LFzhoPCOTZxOp
         1Nn9W7vl7gnud4m1G//uANqEz3tBNg7R1zy8tDQhppzCmEI35fxhtkruZkG7tYqaR6GW
         ij20tYW2H7AT70YmY1QwnAkmspVwGbmodXUeFTniktT7O84u2k19qUSzATYr5q2u/VST
         GmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V07roURxLiPH4bJcO7EjRaWdLNkdljJhSl8QwyA234g=;
        fh=hHD1E4J4RuBuey+W2tMkZMLk6ZJnBQ7RUQ8/8I5iJbk=;
        b=Z1ifYdSuTQESjhSjsWzrn6cnC/GQ3QgctCi3OR92hJqrvPa9LsFghizRc1Req9BdJG
         BAyMp21dy96urRkHNNeUHHsf1KxOYOeaBe5zXn7zLh22OF/Nhaha6/+zgQ03IVVFXoyH
         EZ81BZf1m3lghyQNcB5E5RAxmbOpdVl8qqx2THVZ4AQ5ap7oFnCFAfBuhTwjVmcwyRBv
         RtlS1DLaslfMqtf2qGJ8GftIE1s/qhVgCTjq9zeee36MG7KFCAIC77yg25VjQQLIHB8y
         eNUfHjfmoXur7FO4KUqRBUURmirq9nwIRF+cST0dPyRkgTJiu1+t5VrDmLAk4TORulIt
         zfTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774047751; x=1774652551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V07roURxLiPH4bJcO7EjRaWdLNkdljJhSl8QwyA234g=;
        b=BZBC+ojCwrE3rbl3uOkj2Wm6vKQ3clrYV/+Gxsc4DvwDoWDd/nv0pP0Skd0HkWI1Qk
         IxahjBFArZKMQE011YYio6rB1fQONgNcDsC0VikE0ZnGAgr+JfNIUAzccEGWCjBM4BYx
         dsxpbzartlolzSSOp6R+zFkURUaSqRNbE0ZxqRfLafGSa1XDViyuVuwPgVimud/HHfUZ
         at+HPpK4nADbZt5hwk+MGC2NKy9CZBD+qR5uh2leywDQtC4a5Ao3KDNWAGuphtoZkGIZ
         4Wn+HewdO+u1nT3jlRePaGku/xlNVPr1Xb1JEikasr+m6z4OTzC12e6nKhnE3ceJ+z0s
         Ml0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047751; x=1774652551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V07roURxLiPH4bJcO7EjRaWdLNkdljJhSl8QwyA234g=;
        b=PFhddiULV+iqIfEoS0uBymq25+Ofzrd00mXYS8exU2fY+TR9PLOvBODebjPukI3qxB
         SwM9ry12v+ao5BuZd1kuERAAW4OBmVTBamxsrkDM3Gv7dZAqJDiAgXHCEECTID58BbzJ
         yxTEsHS/iZccQNTM86KB1lKhGBOz53TKRYFINBIlkU1iFsKPX1z4gS/yHpGg0PsevLgT
         bKqCZPNdmTYorJXkUxDL02dqKtK5n9ZB3rWJ2YdQOkNmsvHGNKZ5GV6K5FDycKzls3Fp
         DCcILABDcXMDwKbDPh4Z/tKif73FXSJ6PsjafShxy7HGyUv7oXXllV/Lg4oCGrfbPTTH
         F8fw==
X-Forwarded-Encrypted: i=1; AJvYcCURSFjsPRTlXPmN0hPcPtANAjvr1AUixnnJsQueJiZi0DxaJlfel1pNWA12fPrvKUXyD9J1UIMent7IOQx5IiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8OeUabI90BNm8QKb+hL1rLGMj/TEAHO97eGYtzz7ISnDJs66
	zrZDUK9H7meGMdndO9rS6pBW8a09sBXpPpwLcaRqx+TPEjinOP4BF7neqzcKSb20lcJ3zvWcJnU
	v6PdcXbSSY9fl7Kesw9IMxvwwABGmI6hzw97p
X-Gm-Gg: ATEYQzxcTsIrZ4niaiU5Oqi9Y5j12s8almIiJsOERBTjJcmfA76rH3xJ71/ZLv0XWn0
	uHw2Vva+9OCiP+1By2eVLnsy1qD3zXviffIdQe3O4vD5Iv382HHpEjSb6EHLBiSndL4t6Vb5gRC
	OrHYO9CKCqWMjOlDJ8m/9iN4qc6+k+0pmZuMy4Xlpz5ADmK+Xp945OHSpg5J6tzyl0UI7tQfYVF
	/dDCofJrXjlz+Dm9G4ImB/N089WRP8Go6i1G7rBGCVQ2NeSBQNTw1CVuOQWji9me5zTWxb1pR0V
	tTvKPcVP2EZ21gnwvyOamPFwayZCl+MAnkJnM9xJH0oP6uFq2g8uKmMz5AhPOMO5/m2SfOMiF9W
	1K+l5kmDFi0K6D+db
X-Received: by 2002:a17:907:6b8e:b0:b97:b6ef:fc8c with SMTP id
 a640c23a62f3a-b982f25c0e0mr330690766b.23.1774047750284; Fri, 20 Mar 2026
 16:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320004928.29914-1-rosenp@gmail.com> <202603201131.55E516E@keescook>
In-Reply-To: <202603201131.55E516E@keescook>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Mar 2026 16:02:18 -0700
X-Gm-Features: AaiRm51O8ViZNiu7LruN-oqaROpmM-E7ADuhJhQg9PSIufXB_A0G4gbrOHvaBaI
Message-ID: <CAKxU2N9fqr8XunsR+=-P8AngLbUbphTq6aFnEJ_yEGhue9d2wA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: panasonic-laptop: simplify allocation of sinf
To: Kees Cook <kees@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, 
	Kenneth Chan <kenneth.t.chan@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:32=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Mar 19, 2026 at 05:49:28PM -0700, Rosen Penev wrote:
> > Change to a flexible array member to allocate once instead of twice.
> >
> > Allows using __counted_by for extra runtime analysis. Move the counting
> > variable assignment to right after allocation as required by
> > __counted_by.
> >
> > Remove + 1 to allocation. It's already done in the previous line.
>
> Are you sure this is an accidental +1? I see the "num_sifr++" that
> happens earlier, but it's not immediately clear why either that or the
> +1 in the original allocation are needed. I'd like to understand why
> either/both are/aren't needed.
Looks like a rebasing mistake to me honestly.
>
> -Kees
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/platform/x86/panasonic-laptop.c | 17 ++++-------------
> >  1 file changed, 4 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform=
/x86/panasonic-laptop.c
> > index d923ddaa4849..4d663fffbcc8 100644
> > --- a/drivers/platform/x86/panasonic-laptop.c
> > +++ b/drivers/platform/x86/panasonic-laptop.c
> > @@ -248,11 +248,11 @@ struct pcc_acpi {
> >       int                     ac_brightness;
> >       int                     dc_brightness;
> >       int                     current_brightness;
> > -     u32                     *sinf;
> >       struct acpi_device      *device;
> >       struct input_dev        *input_dev;
> >       struct backlight_device *backlight;
> >       struct platform_device  *platform;
> > +     u32                     sinf[] __counted_by(num_sifr);
> >  };
> >
> >  /*
> > @@ -1017,21 +1017,15 @@ static int acpi_pcc_hotkey_add(struct acpi_devi=
ce *device)
> >        */
> >       num_sifr++;
> >
> > -     pcc =3D kzalloc_obj(struct pcc_acpi);
> > +     pcc =3D kzalloc_flex(*pcc, sinf, num_sifr);
> >       if (!pcc) {
> >               pr_err("Couldn't allocate mem for pcc");
> >               return -ENOMEM;
> >       }
> >
> > -     pcc->sinf =3D kcalloc(num_sifr + 1, sizeof(u32), GFP_KERNEL);
> > -     if (!pcc->sinf) {
> > -             result =3D -ENOMEM;
> > -             goto out_hotkey;
> > -     }
> > -
> > +     pcc->num_sifr =3D num_sifr;
> >       pcc->device =3D device;
> >       pcc->handle =3D device->handle;
> > -     pcc->num_sifr =3D num_sifr;
> >       device->driver_data =3D pcc;
> >       strscpy(acpi_device_name(device), ACPI_PCC_DEVICE_NAME);
> >       strscpy(acpi_device_class(device), ACPI_PCC_CLASS);
> > @@ -1039,7 +1033,7 @@ static int acpi_pcc_hotkey_add(struct acpi_device=
 *device)
> >       result =3D acpi_pcc_init_input(pcc);
> >       if (result) {
> >               pr_err("Error installing keyinput handler\n");
> > -             goto out_sinf;
> > +             goto out_hotkey;
> >       }
> >
> >       if (!acpi_pcc_retrieve_biosdata(pcc)) {
> > @@ -1111,8 +1105,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device=
 *device)
> >       backlight_device_unregister(pcc->backlight);
> >  out_input:
> >       input_unregister_device(pcc->input_dev);
> > -out_sinf:
> > -     kfree(pcc->sinf);
> >  out_hotkey:
> >       kfree(pcc);
> >
> > @@ -1140,7 +1132,6 @@ static void acpi_pcc_hotkey_remove(struct acpi_de=
vice *device)
> >
> >       input_unregister_device(pcc->input_dev);
> >
> > -     kfree(pcc->sinf);
> >       kfree(pcc);
> >  }
> >
> > --
> > 2.53.0
> >
>
> --
> Kees Cook
