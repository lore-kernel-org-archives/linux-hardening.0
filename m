Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE00352C3C
	for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420080; cv=pass; b=Pxgof1lfcXxa0CnjXWfbYmngb+GisrusDhF8cqq8YWCVozcCiWEqSlGC0javOJo72/RKHvAbjYaDcOnDtDC7bn78yv9DXVPEwYcc2DM9rS5iU3B0YGXdq48/RrWIOpfNdD1Vq6h96ltpd0RUB/tVUlIEi2zLxJtbHhrnJjjkl8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420080; c=relaxed/simple;
	bh=MJEoW7xmbsgf8ccUD0trvF3J+NKmwZJnCVsuFcirp8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAwdxDZzdO2tJad8PmknmSxLJjbIVQfpUxhz3EDBH/2AY7JhkqVLRIlWZ1qJnfM5DAY+1KLZ6Kb/eStWZtkzPrj5bUNems0q+ivJF7/UgGHZSdpt0jQz9eeASF3Kq+CeXpZPUlGM+v1T0dQ4FY3mBYPclwaMqFeakGkN/4hG3Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcRjmzZV; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcRjmzZV"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso2884508a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 23:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774420078; cv=none;
        d=google.com; s=arc-20240605;
        b=Cha2PZFbjaefsMq0eEEHVQ651QLMC0dB96JSH5LtjBfg9D8ttZbh5PS/WTY5jQ7FVW
         rlNGUmSf1RJLvjXraZN0HFCmH6EaHa8+pI6tYhbaUAPAhHebfAkPfEs4Yv37dTGzoD4X
         qv91fwxdSACattQMIde8p5HOOvLtrkmMB3ARx6bgKPecgRlVHDDCW+0vzS9DUbocs9hQ
         UXfjjOhtTbt9tTmpUMW/wy6CmVgxi9Tql/DV9Li6uAxT0GGbyD+aEqL6ghoOUOwNNrGV
         xiLuLMLAHzfyUis+tHMcSKxph6GibIt0B9fGi3m2aDILBnGRCd/3kXTIhpOpLSVYdBlY
         3XOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M6McgGdWNeUSRU1+qLW5hhdwIQf8ldUK3zxn67ADOeA=;
        fh=n3UwdZjWApO4v27I52cUqMUsgSAkb/bChWkjC6PRil8=;
        b=RL3FPysj/7Cg5kxbMi++dmIN8qxWScgyuke6kMiSvS+NUHSu28ctK5t20Jt3ryxjqq
         Taq0MznD0lA502ShnCbLDZ9cQOW2Nlhnjj6WPEPq4ctaqjl3KxrebLhewG0F30Jzddkz
         bL5oXBcHzkkBl4CRJfz7L4dZLbwRlExw9DatjS+M/RAWQgN0JAruyadi1pRUtDW8VhiL
         x2ugVCV5OQrNlTbolM6ZLOhzko79/PafskoTbBYqCzKzeh23lq+SRnK3A1BU7PLRfY+V
         yi69BBRwFGqg5coUoMNIan/5jwy4HZXX+b3cFgoXgC717tXBoc3lTNjLbX95NaOYZBZA
         A0yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774420078; x=1775024878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6McgGdWNeUSRU1+qLW5hhdwIQf8ldUK3zxn67ADOeA=;
        b=qcRjmzZV1DGcFvsPTbcfa9HCjv0r4ugdclPsDRWRWvlZQT7qf1p+lplFTvgVEE7JYH
         ghKA71R28V7pI32M88GQAexaT+5EToaMyhs3jrDpmdhZJdy5oNt4hcf6TbInyX+zn1bN
         fosEdPwf0aihSrBLCZQ/Je7R1C+w9EFEWIa9OO3AU5yFmZd6o6M+5VZUAnW6nNbDJTbx
         rtpk5ob0uz2eZWMPWsMaQhzX0bjwR9pwQaHSqppigWg5UqqP+F9hHkSrOfEu+WKDPb52
         iYIM1efsZ2KmFOlcBqhd0yt18/cpnVBcbAO6gCh6P7/kKk9J/f01gaakgw0vXZRpJgIi
         jLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420078; x=1775024878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6McgGdWNeUSRU1+qLW5hhdwIQf8ldUK3zxn67ADOeA=;
        b=mcoOkpcqfINT41g3cTVflr+Gpv2pkrL7ay/QHkynC9qMiRuVKN9PYUygebCEUe3z8G
         dWvaT8CJIrBG97O1AL6PY0eE0eSPcp36YswvpJw5Sy1USCCSJ+rPy3Ip1VggETTChGH3
         gq22Ci8Hv4BJOhk7lB4tFO+Aemakm+sIcXBJ5GQj3Fl+rdb0zMGaI6SICKqael5V99Pk
         Vp2NHMEc+Id0lUJh0TVMzWWmhVWOwVBIK10dFUEUxmQXbWfTx/15kO22dP9zflt0OJ4f
         LGiuiwLAp6O/og5Fy+f2o8qMCOuOxm5VCz3j16ePY8eL6yKA/OLqkoHzHTiqsQSbVa4d
         ENYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOhRnttjiSfQ4o9S4UFzq5mOzO/r5RnDoe0GjiEYmYSWKEPKOXO135E8Ciyq0Yp5ahEtNPDAVata9rvQ8Yj1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKI4lGwXMGDWUh5Q/bI4G2josizvt6y4YU975O1okSrjBPIm0
	HJ5/4EQdpsp8cU/tO7GeyPmg48Z2oCS0odpxktUSEDss0OGM4/67ORXMDJ8mYZHhu3k1JLRrJ5C
	NKJYYlRkdi3TAbqEYzL3CPtec2n6DiQk=
X-Gm-Gg: ATEYQzy1tx5b6YZXXWuX20p+slU236fMrS2jpCQxbt+TqU2AyiR67KHucq6Cx/fvVjI
	LplyzO4GMub5gJmaupLEC7WiiZlqmN6bTG9RTXyy83GQ56/yh4GqQp9cEtt3sFZsZoPL1wkJnNc
	yYozrSkYLZ1/S1TAqc4O1xiCrZ3eQh/5mnMN2o3DFbii19R7n/crm+q67v0TftypyfkHfDRiVXU
	h7lCMAITyvQ+2cKtN5sg/QCDW3FvHPs3UDtMdlfklzfSs+JBQ4IHX0sfp8B+EBDp6kMl9YXYBf4
	kHk1Bxn20cmqLcfuNqCcNBng3wXEf+khlfm4wogEYmmNCF3bJjCKCZ0L2a6dbt1r4B/BLKILn6X
	o9+OtFQ==
X-Received: by 2002:a05:6402:23d8:b0:669:67e7:9243 with SMTP id
 4fb4d7f45d1cf-66a826ffd29mr1101261a12.25.1774420077624; Tue, 24 Mar 2026
 23:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306063522.439782-1-rosenp@gmail.com> <CAKYAXd_1WEkL80a_fLR4g7+9ryZRZhNJXtKxQG0UJnifd-y9+Q@mail.gmail.com>
In-Reply-To: <CAKYAXd_1WEkL80a_fLR4g7+9ryZRZhNJXtKxQG0UJnifd-y9+Q@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 24 Mar 2026 23:27:46 -0700
X-Gm-Features: AQROBzCvufYW1IFUKKi4L31QdLKirkufJMjtfLfrtOCbzA3A1hTK49N1Hmkm8UY
Message-ID: <CAKxU2N8fFHOFSeCvmdPrcZcLrT7BP8+AAauz8e5LQ-8yedJ5+g@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: ipc: use kzalloc_flex and __counted_by
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:26=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org=
> wrote:
>
> On Fri, Mar 6, 2026 at 3:35=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
> >
> > The former is just a nice macro and the latter allows runtime analysis
> > of the allocation and its size.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  fs/smb/server/transport_ipc.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ip=
c.c
> > index 2dbabe2d8005..f7aa427a06fe 100644
> > --- a/fs/smb/server/transport_ipc.c
> > +++ b/fs/smb/server/transport_ipc.c
> > @@ -55,7 +55,7 @@ static bool ksmbd_ipc_validate_version(struct genl_in=
fo *m)
> >  struct ksmbd_ipc_msg {
> >         unsigned int            type;
> >         unsigned int            sz;
> > -       unsigned char           payload[];
> > +       unsigned char           payload[] __counted_by(sz);
> >  };
> >
> >  struct ipc_msg_table_entry {
> > @@ -242,9 +242,8 @@ static void ipc_update_last_active(void)
> >  static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
> >  {
> >         struct ksmbd_ipc_msg *msg;
> > -       size_t msg_sz =3D sz + sizeof(struct ksmbd_ipc_msg);
> >
> > -       msg =3D kvzalloc(msg_sz, KSMBD_DEFAULT_GFP);
> > +       msg =3D kvzalloc_flex(*msg, payload, sz, KSMBD_DEFAULT_GFP);
> >         if (msg)
> >                 msg->sz =3D sz;
> We don't need to manually set msg->sz if the flexible array member is
> properly annotated with __counted_by(sz) ?
> kvmalloc_flex() automatically sets the counter via internal
> __set_flex_counter().
Needs GCC15.
