Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C64A7CA7
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058411; cv=none; b=EWRqDSye1RXwG+AmMq4Z2+AhiFfzLohg4r1rXB/1hNkjM9D0+Ye93f0LRd/9/YTdZNf0ruPNvGySZSFe4sAa2iY5I14XIfnfnB5NPLFXK3X84gIOaswcUEMkmWWHVQKdBjTyGipuLjAJSvUhhfkTCp8S2To4m0Q9EM8akcneJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058411; c=relaxed/simple;
	bh=SjEQ8H2Gnac/gEm9uYsODYmROgwSKBl/hOwkIumqcRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVphojFu8P+G9gcFt6lpegU6LF260GRD12pGOE8Ve/2KbWtqVvmNrULaQqkT/QGTcVPOw0iI5J2wxdeXx/R+ahpAjDYzfcQXQ/e7Dfr/omiyYYb184oPfEQ5jccc9guSRUoRDEI0XpHGXtFQiSsVZjmkp5pbZHPSQwtkDJy/nfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxQ+rWNW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxQ+rWNW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a020e65269so33105685e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792058408; x=1792663208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jx2lN3TQTEdtT7xvZk19rDQD0CSdvj/cxtOH/r75Cpg=;
        b=fxQ+rWNW+4bl0cxjuqV0YcTVUBmKkITFlfgXLiJrghGz6GH/w4+xdUPaQSlPEskvQk
         /rtlVQ9rYd1uN8iltrrTzmG7gLdS7zbOVWGhlxsuVokhKw4Bz2lp7Kc74eH20bDV6HaT
         6soGnEPMPorjc9a9xMH+pgP5iatfokFlPRLANpDVdPmpg206zJKHHnF32qnlKnMI73dP
         7jjti5kXtFqqZwhmC8F5mPzXfixkO5dNDN5aljLInUPhiC4fDrflN849vLLVIz2e33Ah
         Y6XN2j103jU3zVpXFMjmmfbfshHXxT7hqof7R4/pafaX1gE1/KPQEguixuC19biNOsus
         Xh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792058408; x=1792663208;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jx2lN3TQTEdtT7xvZk19rDQD0CSdvj/cxtOH/r75Cpg=;
        b=VKFKCZWvYrYW5suDzNu0IGqKAvmSpZsh9bvwlojUAynBVNYgBZHUS+s+gtXzJFbt8r
         fCZb12NGaEQdsqs0JIx/nkgrxdF/j/kemtL2NVfGzd7ilwgkwqeImblYzw+ENEyo/nrO
         a6IFgnKHSNeIdqdiwQBiTDG0ruNnPX2fkvm78+O5SmTg5cHpgQA4OvkKfLyj8NHhhDam
         rPYh3KV7u3NYYO+El+ji2HaAbY7YoHlUv3pTKACIqrhKht88veSKkpbjE2nWBkoE5zCR
         RPFcPwt9iRbH4RcpduqkRK4PJh8B1IyBSudtVDWDu7LEa/qRvTWljQsM8Xc+Rvn0X2Cq
         TRfg==
X-Forwarded-Encrypted: i=1; AKwUvBwKOMYg89h/2K6MtQEL0S5YmCSaR548GvjfjKHGe1AFi8fMtXc2tOoYdBlbHnkVchAhkQm7bBTbMKXnATY1KPA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIt4s/cbbuoVmcAmAuqqVs7RRQtEoxCwp4LlB5OD/CkZBd6M4wF
	Mo2KTTiBCfU1RcqOgy3iQEz/yHe+mLNqHDxa9OggYzhxdoJ2wWxxez7N
X-Gm-Gg: AYBFou1NxZwKj6IhSO9RMxA7OR+GP6DH7C1e0zdSizU5CQmVSRYWp0MuvdkwvKB8J1s
	210uleoZpyddhB1iZGR0/Ev/lhnQsCEuYtjlaavKUhbbWm0+Tgv+PAkuwgP/Xm6tqRLV6TOe91s
	lURa6+bDyrCncBy9Fmwb2dhJ61/XVure7E43KtpyGGBbsZFuTfIrGMCk+QU/sWDsYxKEf5ZPgju
	Nspc61j7aYzPcPvbqc7VZSb6J5qL+frByP/anjP9FEv5Yh65uHiWqUM6vfNZsLiDtEY9yb0uaFF
	VyFUIUjY9lhq/n2SjMGkKLrPJEhL5uZY6YBY1JeMa3h1JOQpcS14tNEKg2jivbg2YuSP8RJ8CPI
	P38moL7xJN9LDQ/fZsqqjKfv7QENgH2Vz7n62bW+mDUqVw1PsfEJAB96tICLRfMvzyiI4iIjejh
	fvcGxm5pJ3xyyutcE3p/Un2ZiilqjZbxcAn6epRAYAdnNg3sLiAUa7rBY/cKTy8VPCiayi5+6Ca
	f4fJLQ9fzLoTAI/31VsdzcCSZZWdECuzPE=
X-Received: by 2002:a05:600c:4fc1:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-4a19a9cf1e6mr262162165e9.30.1792058407424;
        Thu, 15 Oct 2026 03:00:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6834dasm53584865e9.4.2026.10.15.03.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:00:07 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:00:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Match arithmetic in both parts of
 __builtin_choose_expr
Message-ID: <20261015110004.6f77ea67@pumpkin>
In-Reply-To: <CAGG=3QUZna+bi-_nmJh-1aWBBtuURbexQczXCNt0R+jDSb1NMQ@mail.gmail.com>
References: <20261012205919.4012405-1-morbo@google.com>
	<20261013203146.387344-1-morbo@google.com>
	<20261014133805.47afdb0b@pumpkin>
	<CAGG=3QUZna+bi-_nmJh-1aWBBtuURbexQczXCNt0R+jDSb1NMQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Oct 2026 13:39:03 -0700
Bill Wendling <morbo@google.com> wrote:

> On Wed, Oct 14, 2026 at 5:38=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> > On Tue, 13 Oct 2026 20:31:46 +0000
> > Bill Wendling <morbo@google.com> wrote:
> > =20
> > > The two parts of '__builtin_choose_expr()' had different arithmetic
> > > expressions. This patch corrects it so that both parts calculate:
> > >
> > >   COUNT * sizeof(*MEMBER) + __must_be_array(MEMBER)
> > >
> > > In practice, '__must_be_array' is meant to assert if 'MEMBER' isn't an
> > > array and return '0' otherwise. However, symmetry is less prone to
> > > subtle errors (and far more satisfying).
> > >
> > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > ---
> > > v2: Don't use 'size_add', which just adds more complicated macro cruf=
t to the
> > >     expression. Instead, just adjust the parentheses.
> > > ---
> > >  include/linux/overflow.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > > index a8cb6319b4fb..d0f04436343e 100644
> > > --- a/include/linux/overflow.h
> > > +++ b/include/linux/overflow.h
> > > @@ -418,7 +418,7 @@ static __always_inline size_t __must_check size_s=
ub(size_t minuend, size_t subtr
> > >  #define flex_array_size(p, member, count)                           =
 \
> > >       __builtin_choose_expr(__is_constexpr(count),                   =
 \
> > >               (count) * sizeof(*(p)->member) + __must_be_array((p)->m=
ember),  \
> > > -             size_mul(count, sizeof(*(p)->member) + __must_be_array(=
(p)->member)))
> > > +             size_mul(count, sizeof(*(p)->member)) + __must_be_array=
((p)->member)) =20
> >
> > Why does this use __builtin_choose_expr().
> > The types of the two expressions are the same so it might as well use ?:
> > =20
> It's to emit only one of the expressions rather than both. If the
> 'count' is a constant expression, then it's possible for the compiler
> to perform the calculation without having to hold onto the "false"
> path of the ternary operator. So much more efficient in the long-run.

I doubt it.
Even with __builtin_choose_expr() the compile has to do most of the work
for compiling the 'false' path.
If you use ?: then you can also use the much simpler __builtin_constant_p()
and possibly pick up cases where it is only known to be constant later.

>=20
> > Also doesn't this optimisation apply to all uses of size_mul() (aka sat=
urating_mul()).
> > Presumably relying on the compiler to report the compilation time numer=
ic overflow. =20
>=20
> I'm not familiar with saturating_mul(). I'm sure others on here can talk =
to it.

That is me giving is a better name.
The same is true for size_add().
IMHO saturation size_t calculations is really broken because it allows
through 'bigger than sensible' sizes that still might cause problems
(eg kmalloc() of sizes just below the limit.)

David

>=20
> -bw
>=20
> > David
> > =20
> > >
> > >  /**
> > >   * struct_size() - Calculate size of structure with trailing flexibl=
e array. =20
> > =20

