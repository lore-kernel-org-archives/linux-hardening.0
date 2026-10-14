Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B055294B
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996286; cv=pass; b=XIZFld40hGHlDMLiOIjr6r/TcYwoa2/NVvhsN+Fmffbzx+DXeqWgs3evN128F4sGOTVHCpwbeawga/WtKUiwIn6/qJdN33f0cG0rbSqJ513EvMtOdN0xsWyiaKBx5lJB7uko9sB3XxlwCvjkmxudKYCKxxJvylsdxi0uuXK1yo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996286; c=relaxed/simple;
	bh=aCsxctc/xcnHv1pMHQu5CMpv8HUZNsqkMA91yRiQJRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWR06swWaT2Nf9YeN/UIZ+tmroWT1foqy2wzA7RRmHfEB1YO5u2P206F35m4YSofCTP2zbDLud3XQ9XqPvWlNOqkD8XpJLcOI8Jg/Z3xDBiJuXQ6bBOLFPjcjku8Hhy62rse0gqjhxEao2QoMpiLUIqPr0QpETAtRLiPKqWDFEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MfSn5+O+; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfSn5+O+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1ad2e2391so15719255e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 09:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996282; cv=none;
        d=google.com; s=arc-20260327;
        b=ZTS3EUL7rAJMj83wcmmj2CzXHPvCcLMbNPjJHUvFNzoibG6DT0vmLWXolYzOOitKVh
         /wO+Kmn9/n7knPXNSXVmNnY2x0m5ODB9eRA2ibGmVTC5oDMZX7o0RmVFY5gt7RuuUiup
         0ASB0NRhCv5BTTgfBe+SJ5LdBKEglmM1/egEDbppMnipiOMIp7YQekbY4LnBYs2Xgq94
         4MkKQnsKA++0lo2f72RK/jFeF8lMM8zU26vbd6E7sp3lrmPTgCH1H+uqeVagPo8+qVZi
         MTHaHVj/MJ2RGRW8/Vzuwi5L9c5HZfFxM8qBABBzDNHGHheAhZ6JnmHH2QGk4e97nsRv
         +FNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        fh=Vyxtl8EjILBaX2avZceVubCN63QfvNCmTaLD3ARVZr4=;
        b=P7pG3yElcV1K623S/ykWZTMyI6xDMr5sODbcrcv0zBne7uWmYXuOcAolSjxxDJb7sh
         FM/BXkioQR4Y9NhIpaUH+WAF0M5ELVKTyy0Eu3upJfsyfKruv80Qp0/WqSldcYQrn9KC
         osNT97cWNGHJ4VN0B5pXb3koKLxCYA6NUYwzi0IIvwcyUj6C2VCWRzILxOpH/oL24nKr
         UxvtIPUA8p3UVGu6O2uiKS5NNwzjMT40uY9mbY1jVLisJO1R75zhxkzrVFD2jZDe0Oh0
         OZ7rWFvkDHhs59wP/jOFTCfgVpe8IhU02A5Nis5Qj8+JJuMKUHpMPSN1oz7CnItYZ8eW
         HcyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996282; x=1792601082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=MfSn5+O+jWmDzU6Qat1Y+ZlT9jQoLCDnc9H3KO4dn05UZFbknls9QJdUQdVHYrbH/r
         BjOqlf3kmLrvBEN+Mtojy4fbT9cweHy1LxBSI+bW+ULfJ4/rlZFR25iTxRiVLmL1gGnX
         c8rZefI4LK2DJZIZjJVSTObVpjKw+wSEK5PJDepzjqgXoKlUd1jDQgsozfPwxsvd6/DH
         QdTpkMk+HGHIM3ND3MsUt45ZR7+33r6TOkpgl6cxhB1Gizo3hgEYuVd3UeABgWu0Jsfr
         6IcFCEE+7ZpZDqM6N6SHznacNDYLDeiilTwNXJL4XcQzUiy1RKhY4gBMUtMEVldNdt/7
         vPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996282; x=1792601082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=uxqyoIHZ8THXQPe1ASv28yOsiRsK6oh/863fgRyh/Yetl5ysrZlvvgrlxZ9WLAw6RW
         GK6rMyb/h9TGWykHJ2nBlKUc4sQ/+7lz5FdBJV0qtxMei7yeAzAthUtZXcLIY8X1DRZJ
         zJolfyc73Sdo4mdu+aZfNuS2Op3DEcFMEVZiPnEVRuVHnuvIpEQkzEYGkXg743Y5lo4f
         MruZXmv+Isae1K/6L0nBYn/P5Ojbp6ygvBIcFurEJz+3nSoOV8Ws//hHOxKqQCmg6y3b
         4tFPWUcZqS4qWGWVMlOWmIaEBpFieCnif7u5WL53e1JTCOZ0ERtc9gHcc3WF7RKKsAWK
         PHNg==
X-Forwarded-Encrypted: i=1; AKwUvBxtim0tGRHz29A62/I6gNhbxYmYzr5JncGVsJNtoKE7InaiXBUxd4Qtxq0y97qN5+igoD6ny+IJ47bnLH+7YV0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0DrdjJlyXpTwDFbbes0gh4+nAOAxuZz6lOkGlLwCVW4Dlk/yN
	CQ5xUwYsDLvTyW+z7jB/jiXkzsdT+E+4gdGySD6NLJXPYvDgVdyuFR6BdisICHDSSU6F8tgGopU
	fJFCpGzbfVkEsftWqUKMV4AeAQjGKZnvXLVAEAkup
X-Gm-Gg: AYBFou1vSQunbMdNXhA+nWd7imhmQmYptgW+jxF4CT5shu+NmFJ+H2geHC8MpjNp67N
	dcxsXRF9JQdv2n4gnsAubkjdyEQHJIwIW1E6BMUgyHmeWTrfjTtFHM36mSAmecEYgeCRex8TfS6
	NM0JYYHe9eOzo7a3V33B9O7M81KxYZy5kv9EfzLxBpzIeRTyULrwIEzLydxe+c9DIiixunS93y4
	orKOYfXQAT3R4qa8w9drr/3al5d6il4aWvv5tUeBnq625EjiRkxeCktCbuqE/dMN6iKnUFYhHAE
	tJDiQppcvqgFMIV5JVr5cA5bHvW+E2n351R3k3ipen0E/i07S7E86zzSQrunKBP/GCgGtFNfUSV
	MqE6RyB2V6oWH1PQuHinhHJhyI8bxZQpgcuwaBS02KTTvkBii+m7NxIdeNh5vTUrG7qxzS6HOBS
	OaGC+b7hOWlVG2KC4cj7hLOGMUXMADWX3ZwKr3u94n1+kMz+VlCPfy
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr329192565e9.0.1791996281614; Wed, 14 Oct 2026
 09:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
 <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com> <202610140937.B68C8C9AAC@keescook>
In-Reply-To: <202610140937.B68C8C9AAC@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 14 Oct 2026 09:44:29 -0700
X-Gm-Features: AclHuK9LUe2FvddsKjj0vYiArabpm2vrSaqioSsrjl7koqqOn_VyYRh6l-6milM
Message-ID: <CAKwvOdm6nO6skW4-AZtmzpGoNyO126L_AN3Mz2fu23+3QXcshg@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 01:28:55PM +0200, Miguel Ojeda wrote:
> > On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > +/*
> > > + * Optional: not supported by gcc
> > > + *
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#requir=
e-explicit-initialization
> > > + */
> > > +#if __has_attribute(__require_explicit_initialization__)
> > > +# define __require_explicit_initialization __attribute__((__require_=
explicit_initialization__))
> > > +#else
> > > +# define __require_explicit_initialization
> > > +#endif
> >
> > The LPC slides mention Clang 14+, but from a quick test in Compiler
> > Explorer and a `git log --grep` on the LLVM repository to confirm, it
> > seems the attribute was introduced in Clang 20+, no?
> >
> > If that is correct, then it is not available in all LLVM versions we
> > support (LLVM 17+), so we should add:
> >
> >      * Optional: only supported since clang >=3D 20.0
> >
> > With that:
> >
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Yup, I can confirm, I only see it with 20+ too.

Fix up the comment and have a coin, witcher.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers
