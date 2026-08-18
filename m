Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBBB346FA1
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087157; cv=pass; b=nmNdt5CrlacbH0RiW8Y3uDU3KyyjJBOFauzBDrQIV6wIFi5EwJbZgIE8FLHNbF5WFC5UULpJVvT+Qgcq0k67qnZoxBAsYEaQKkgWQ5YXRwafxQ7guT9Q9t3JAXORb9kWoDqXndn5bxHNMyGgDIVs+6p8mG3X9bJaFfbqLxFGQHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087157; c=relaxed/simple;
	bh=eaiZGhTFkGSfUcIl89fwxJ6hO6jgRXyP3XW1j8eLIR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T31qx79k8txYSDIm7lHD2b65ZHmU7qh7e3kvSI5iWXsFWx7o100ZA+/2+q23P0OZh2tCXHdUdVn3ToAOas9s31JLlbd9mcsJdf29sRwvzrKncasGqmOBGyH3cvWCmqfkr7ef4T3+wujDEZ7y49ni1BO6WGG2KsIGbm8aTZcjp3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqBe7Rb2; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqBe7Rb2"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bf9466867cso133523e0c.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787087154; cv=none;
        d=google.com; s=arc-20260327;
        b=QNkP1NVSRSiEkiqOln2NaOu0o4XAykhDH+9kNI+PQlEJKrY2cVKh3AULwZ/nWho+Pq
         EzDCQKrGk1VRcKWOVZUftI4hjabOM/Wp3u5JnJLgUEUblcF200vKBc+MQFyGrCuMSofA
         R/tTWKxgGXOSlaP57AHTX6cKXU4MZj5Ms0HYaTpWMILvzOUaWiwAUbYxzubD6SKG4Taq
         z6PAsn+P5+qeCF02Ta/m3W1kgxzYBbp9PzHwhKEiQdTzrfdkuLb5dJvkU3trgPGsjF6h
         Q0OAw2nwA6z3jVoKugbvgidtYOwYn7PkkFx8gH85qkMOdD6B6tuJuDPKSl7ikf5W229j
         +8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w65RnozkjZAQaQTG29xDabJ4i5pwIahs9WVifSWjt2I=;
        fh=J/WYfFAexhok/ctFI+73xLiXau7y95YifhuGI2TLnXM=;
        b=fWpmnonUhexELCsgzrwiVa/7N6Hz2lprbNkvmF9wTv7SzG9anHVxZrTGy+V8aEd86u
         zRa5TF3+2X1xyBd3kaSaAbeFapk0Qh1SBG4L4uPkAXvJTAmh0qLk/s4UiaE0GASWeSWt
         gThrwcICX8tLg1hqm495t0AVsHeDKTHzwW1fuodJKI9jmoWmFODz0S1pRuxIIJ2fFB+n
         huMaESsk3Llt1QAJlE5bw2al/BJUEkzSbFFzto7SYR+espeYUcQgL0Mc9QHDZp3hkjFL
         UgG+yLMUIk7Zjq4dXiUJp05zjTfyGqIYvrPYzPbXQ0Jud5P6cX0NfYJrHaCVvLhMhrFv
         QmJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787087154; x=1787691954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w65RnozkjZAQaQTG29xDabJ4i5pwIahs9WVifSWjt2I=;
        b=XqBe7Rb2aXIrL58QzBetFbB5cR1YFxWXXq/WWMxz5NoohtoHLMZJP8qYZ16w3yQ9zy
         KKTCrWmbXDdp+uJMwFlV3QJB7eLindLwo/kzCTCDQfanziC0XbIlm1qYw/gg1KjJfY9f
         IdEFXGbTjVnNNjB+/DY9F5yK4n6RabUnfq6kCJewMLMgElpVDh56XNRg2qpH8JM9W1vj
         4NjkP0hyj/oFro4jvIOWibvbLxyb0972jrDugXtfCKHV/BvKBQJV7EO3CSrooRn0NsZI
         CgU2BhlX0YauBwyW2vjh7KXXE+4BA8mW0wTlJ6p6vKV5YmW0tomIbH0d7fn9XBdufYMd
         pnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787087154; x=1787691954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w65RnozkjZAQaQTG29xDabJ4i5pwIahs9WVifSWjt2I=;
        b=m3wQDhP1W/aUToSfAk7Zot/RfT0H/+lWkpLxlw1e452XgcNGpbYgzRFvxfmhZOe6ti
         hAysVM6fKwLGFoodXKPaSkTsuhJfnwj1WpOA9Y5pFo2FDzt0XQgjW4xpm3YW3inasVhb
         AL9TZlmDYIQPWZg4qdcipH9wpdPnbvfCa1WFBaUKwDwHGEKXzh+fUOuTLNPwaHSXR37N
         239lj/bYhRe4BnrbKvbIIZEEq96FLNwHz77bMA8RodVa7AdZ2C59Mz0PMrYAPaePW4N+
         QUYhZX+X5G+mRMIZFiuhJgW2bYWkWAs56Fg9pUdm6Eov66HGz80sDxrmob5KUVCguJGp
         uZCw==
X-Forwarded-Encrypted: i=1; AHgh+RqTdjcg0XizOYpSLenlo5IRRGs/9NyiQHX7cElp4WXtulduuPOSHnP2Qh3c1BWxbSFpBoukKeaOy9EsfYtZ5dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1V0RQ8o4w9CypoUuBUGu79SlPx+XBcd5kSR21W7d3nx8wRY9x
	oBw5XfxtabPGFtGuYNxGA8V5akuYpOgBXMDljH3LGZZvDLiNg4v/F+gfQNYHUkMleZyKCslIj1j
	a/d5Dn2T0jdlfJfOCQFOT3YgksFHXwWulU4gQmIC6
X-Gm-Gg: AR+sD12meAXEXMF9o5u0rOWNz5OUCJV3l5cAGh0zgV2I+A+Nf2cUfOzRnGEtIadB4UZ
	hlZzjkM1+W/dZM8eN5Qq2bCyi+hBCvFt8MIf/Pjg2vKe0QG3YxP82tJFShuKrRk5/70pOjSug86
	RakhwdpX1FE0fE+RcnOk6k5bv0o8a/p1XNHwQXloM12+sjqvI5YEiBgDumbyIvjgPhoYg3N7jhB
	y+kVpX8Awo1h0JkE/qZD4jyotO+fjGGeFLvBiHyY3gcznhVuIo4L9KQsCzLG0vCZzSYz8Byhb4i
	D2BnO5p0LIs7aqy6T4MdYIee5F5vNJMUlDbUPkIkV8Chg+CXVvBHtuuVgWIvKr0feFL+9Nl0l+D
	1Ew==
X-Received: by 2002:a05:6102:5087:b0:772:94c0:fa4 with SMTP id
 ada2fe7eead31-777b8becdd3mr326722137.12.1787087153716; Tue, 18 Aug 2026
 14:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27956255dde39f58d73a7b51cb53cbe3d7804f54.1786411026.git.mariianikitash@google.com>
 <20260818095548.27e0edb2@pumpkin>
In-Reply-To: <20260818095548.27e0edb2@pumpkin>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 18 Aug 2026 14:05:41 -0700
X-Gm-Features: AcwNN1XPdoRn06Kbjdp5yMNEHfNd_fxF4aqaUzMomekFpCZQpXJpbK6mr3zZqTE
Message-ID: <CAFhGd8rGren7EwjASppcx2WW8d-ky-T7k6mTxK-MpHfZmFTtbg@mail.gmail.com>
Subject: Re: [PATCH] NFS: nfsroot: replace strlcat() with snprintf()
To: David Laight <david.laight.linux@gmail.com>
Cc: Mariia Nikitash <mariianikitash@google.com>, trondmy@kernel.org, anna@kernel.org, 
	keescook@google.com, linux-hardening@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nikitash.mariiaw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 18, 2026 at 1:55=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 14 Aug 2026 00:28:45 -0700
> Mariia Nikitash <mariianikitash@google.com> wrote:
>
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
>
> I think I'd have gone for:
>         size_t len =3D strlen(dest);
>         if (len && dest[len - 1] !=3D ',' && ++len < destlen)
>                 dest[len - 1] =3D ',';
>         if (strscpy(dest + len, src, destlen - len) < 0)
>                 return -1;

Can we run into underflow issues if `len =3D=3D destlen` during the
increment. imagine @len is 10 and @destlen is also 10. We end up
incrementing len and our strscpy receives `10 - 11` wrapping to
SIZE_MAX.

Maybe this isn't reachable as @destlen may always be larger than what
`strlen()` can give us but that increment looks suspicious.

>
> Although it would be better as an 'add_option()' function.
> I suspect the it used to be just strcat().
> (similarly for root_nfs_copy() which is a pointless wrapper on strscpy())=
.
>
> Much more worth while would be fixing the sprintf() for NFS_ROOT.
>
> David
>
> >       return 0;
> >  }
>

Justin
