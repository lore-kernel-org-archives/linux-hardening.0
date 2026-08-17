Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262E3DB30B
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999922; cv=pass; b=b5Sp8FV+nND6God7PeF+74XE8tY00YwdSbnYj5d7Em3DootCgxw00Mx2QURSAoXKPigXqonlOUX8nKaqkU8DElNUu+pwy/6yzRg61SJeM5tbhtVrfiC2NAcxW5PjYFJv8AAfr+WJvwsHEUwT3m8A48Swe+EylUJWM3lj7UHMYyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999922; c=relaxed/simple;
	bh=6WuzAbspB1ExSogF8kqjQzSwSHTkgCAcgZZwabnez2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lggAYTGp/is8hEWPU6MgpQrwolBOdSpFlCgVFVlXzljzb9Jqnb+FuwM80wt6GIMDiu6IlZHojbwwg7qNUhxc4CPRD6KWWvqR0qGdIgl9LswbBDU6zcFkEUZkNvWsDTyvG/Q2y9iCDNWFh1hKUZF9LMO0RPj8vxFnTdVRIbZO0S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhOHFZ3g; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhOHFZ3g"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bf9466867cso1214005e0c.2
        for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 13:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786999918; cv=none;
        d=google.com; s=arc-20260327;
        b=jXSwJkHAgh5ORMK9DXbHazJLJx/InZ03erf0m54OHOKYJkyBAyOHTZpNhXfIfn/bjM
         DPw0Pq0xEq8qAyJjMNL0xOuveq44bTwdOxYlNiRT9eDAeHt3hkp8N4iqOeHcNX+i6Dnt
         qblQu/Sulcsv3g06hKIp+12CY+Heuznz/LmOXOQ3biKv8uSxXD5HvkDEck1EuSwnk4ej
         6W7/8VJqDjyLS+piCiOgWPu6IJJeWjyzNP7Yri5Bft5L3XZQ4XGMInKQgYnVzsv4qS9M
         nEeEw51FawKt4otOjYOdcqLY9n08WwJxM8lGOA8X4YvENB38vIJ+39XyIHN0WAnN25/A
         wvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eF1JE8DesWnKgF2u3tRIF8wb7IKv2IB08SAz4bl5DYk=;
        fh=X21gwRyRLJapgdg8pf0N2pHC3kOvW61ag8+SlgY2uzs=;
        b=Cp9hGCm1sDOU1fl9S8dMPQTWxlrSQwkSGUnRsf4rUf1TV+o9pcArl0eYuf5f4LJl6M
         Ze8wGz4BrRs/stIOSThH1irHNQIQl2TKwcRJ3BJF78+8vIoLzNCJf2pXGI3VTF+pSS93
         9yXadgoO2gnH/ujVEa5S7093psasVi5Dn4Y0YuXv6wzy1vc1Y/CRs7DHeLtjsAsmPbn9
         7+WpMMVN6KtYS6ScVt+q7q5zz0GSK7t5PQw5I/Cm2d4PDzU75FHettgPM6D7Wr+aI5k3
         DOoIdGKr5rxmIC5d/JzYnXhMioaPRxOQqk4DakMHFlFMXNxvneJABoo3IrVedoR2B5M8
         TsUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786999918; x=1787604718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eF1JE8DesWnKgF2u3tRIF8wb7IKv2IB08SAz4bl5DYk=;
        b=PhOHFZ3gQ1FZ+GWctd96IbMbpV5YEaOZSE+jYQtO6tlA4KD2uopyvtbH75bpkgLMOV
         89mGyZOoAZsEeG5p/wWUipMMoIPpGakqtboWTJ8YOOIqg6Vh73XJYVj5HR+Aa9JGQlMe
         A/9tXHSmLfUALEuEaNwrIgy7J6n6mRQ8yJvE0bkqfIVofeLzoJlQofntO1xbCDUOhHRh
         wE39K1ggOhGYAe6mhJqnBW/ETZgKAk9OTwEaRpNt+4WG6tATYwAASem42VClIvsskmXR
         o/XWQeYzC00vOItTMLVPnoeFdCBFFWuM5oNLU1JDITwwtgbL0nhRZrlenC35EUbj2pSC
         Z6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786999918; x=1787604718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eF1JE8DesWnKgF2u3tRIF8wb7IKv2IB08SAz4bl5DYk=;
        b=l1nHnTRNFLhii9CgSXVO1O6dsMPTFbimLeDIprhsd2Ahb6cfIO8vDL64ZTqGfvuCmf
         oIPUOiBaAVl6thCSFxf7nWH1JB0VZ0U1U5yQYb6+PwnKUa1D4Y3c5AzXN4MmCA1jDFWF
         e7rLl62Qtt7f7vVBTM4lpkINokb/JWhaucjbCTbYTdInBnsKS54rCVjj0NfwUTOvindM
         RHRTV3j+CepED7PIZseWKyO7yBRL6LF2obQ/qZdkSkw9Nrfv9kYgG+u5tTDtgP/r6VZ6
         xxqLu+JTS8dSDwdgIeIE9mx7ni5fA1XSmmfTrY53XUUTUqjzFwdnTfl7aOs6hQPDn78J
         o6OQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4lcqgRVBrDEdXJXKD95opKueFg6DjkQHYiNAOQuXVolYrrb9Z+d8C1UM4aAnFqjaCxx5LYIZ/RRupy/fXRvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPE1bkHpmsYIBKmGCKDcfwGRjDNpv5XrTdgB15wnXMFWKIj+wN
	aHaZfwnVN2Hmo2rCQVNnazaVAZ2UiD6BHp58N2TwohXHk9RNJRft6Y9xZbor1YFYUo2RtRYvjCt
	tWxjwOH8uzdh9iTR2YC+3VTQpNnGO6Pi5Y66lK4w=
X-Gm-Gg: AR+sD12al8v1eOyBl21Rlj6sYbTcPx9N0N2X0mLgIIrMaZvqdtF6s1Yp+wHBePoX5Hp
	01eIozn1XGQ5mhlFR6+kMfXgmJFbu8QW3PYi9iVC0kHBWfJx1Z/PBkdZ886hVa8LMc/2DY1Q4U2
	SSWjV8LuJd6lvpRhPJDcKdH1s05anMgp5dT8BSycVaYpFKxCEyyZ0UuAGkazh0DGNMJTt21SUrP
	eNYin+pmLKxVdArZozJV9wOcBO8dge77Kc9gfDrVBfVLKqQ280u9Lp8+E3WZLYf9qVgxsj/1tjJ
	V9Gg/zFX2KrsDnJfCzXU81xRKNq0KN+ZILthJ6RKpB4+jRl0fTituCEdBKhJ32StMPJUTtKMLgg
	kZfx8dX1Lu390XiQdHMQJheXHJA9dQ5ia7wb7YSXYJg==
X-Received: by 2002:a05:6122:1d8e:b0:5bf:7f98:9657 with SMTP id
 71dfb90a1353d-5c591d1e4b3mr5206909e0c.6.1786999917761; Mon, 17 Aug 2026
 13:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27956255dde39f58d73a7b51cb53cbe3d7804f54.1786411026.git.mariianikitash@google.com>
 <aoNuOD6CLopCgxtU@google.com>
In-Reply-To: <aoNuOD6CLopCgxtU@google.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 17 Aug 2026 13:51:41 -0700
X-Gm-Features: AcwNN1UiSchRXIblAc0RIrxdgm7oeFqezFJfw_ciVQw3x4wTmpuPp3ASi6kdEAY
Message-ID: <CAGG=3QXu=kioXx3dRB2GO=qGQ+SqSuenbqMrrLEFz8KcRbn35A@mail.gmail.com>
Subject: Re: [PATCH] NFS: nfsroot: replace strlcat() with snprintf()
To: Justin Stitt <justinstitt@google.com>
Cc: Mariia Nikitash <mariianikitash@google.com>, trondmy@kernel.org, anna@kernel.org, 
	keescook@google.com, linux-hardening@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nikitash.mariiaw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 1:33=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Fri, Aug 14, 2026 at 12:28:45AM -0700, Mariia Nikitash wrote:
> > In preparation for removing the deprecated strlcat() API[1], replace it=
s
> > uses in root_nfs_cat() with snprintf().
> >
> > Build the separator and source string in a single call using the
> > remaining space in the destination buffer. snprintf() returns the lengt=
h
> > it would have written excluding the terminating NUL, so comparing the
> > return value against the remaining buffer space preserves the existing
> > truncation check.
> >
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Mariia Nikitash <mariianikitash@google.com>
>
>
> Reviewed-by: Justin Stitt <justinstitt@google.com>
>
Acked-by: Bill Wendling <morbo@google.com>

> > ---
> >  fs/nfs/nfsroot.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
> > index 432612d22437..e951fe731679 100644
> > --- a/fs/nfs/nfsroot.c
> > +++ b/fs/nfs/nfsroot.c
> > @@ -173,12 +173,12 @@ static int __init root_nfs_cat(char *dest, const =
char *src,
> >                              const size_t destlen)
> >  {
> >       size_t len =3D strlen(dest);
> > +     size_t remaining =3D destlen - len;
> > +     const char *sep =3D "";
> >
> >       if (len && dest[len - 1] !=3D ',')
> > -             if (strlcat(dest, ",", destlen) >=3D destlen)
> > -                     return -1;
> > -
> > -     if (strlcat(dest, src, destlen) >=3D destlen)
> > +             sep =3D ",";
> > +     if (snprintf(dest + len, remaining, "%s%s", sep, src) >=3D remain=
ing)
> >               return -1;
> >       return 0;
> >  }
> > --
> > 2.55.0.679.g6767b8d81c-goog
> >
> >
>
> Thanks
> Justin
>
