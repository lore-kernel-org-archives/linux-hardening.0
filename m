Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A053D0B6
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996103; cv=pass; b=OKabfdgctimJO8AodlIWIOBA4ET/E3KNQSxN4J4IfZSMd013dItnDtj5D7aZNbxPISKpxvwRH13Cxx78pEDcb/1jFK63khPUsImAfdBagxZ0IYbQhqa09utXxbj4V+HwhcUwmIP9+MzTE/llAs5aIzOgxtrA70XKVm3AUbhA/4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996103; c=relaxed/simple;
	bh=3mwSDPTFjJGkaatL1Lo6Mh8o6JdUk3CgZRH07sGguXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzxZAwsTl8Sf3ixVjt4zhEyY256poqMn8Vni6wcmBywI8ReY/1sdFQd4Im5Z0TA2mSCKtO1wBl1VOJTPdowmrX7S16KPVRfvGwiezQPg8N2O2KX8KMMV6FiwBecS0UWhoGzzLIfWe2p+Plu7eKofJFgkcy9ELGJTY+H3izM+QFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hn6gY6AQ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hn6gY6AQ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-533202fe429so1289101cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 09:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996101; cv=none;
        d=google.com; s=arc-20260327;
        b=fJcbKTkW52vIDIsUZplh76E1aQvTjNAB2ZUzHQkurUwXsnw6BlG7d+TWsRHqrLCt2I
         wXNxDR2XwSIKE9hImL7BUJ+y60EvGgHjdELg+DFrI21bM9R2Jwvz1XP87wgbyrWdwoZJ
         Z5gqb9lcXrn0Dbh1UMw0+Yv3kvo3Z/+sMHcEesOLWhfqjlzyH5+JvSyqcb2eBChSaZTe
         PWufQS7JZ3aY+kinHuNW/Way4hIMbOHK1NkICewAxfO8CDns7iu5qbqlWKE7ICW4Szp+
         jhNbXobnnyZBtjmaujHYLY06UCbC8U1XKAqY5m4PEqGmog5eNQJzm8lyFg9a2/sYzqRx
         TjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        fh=lb8HJx1Abn9Rt1Uww2QemxNIAOGz55e/RgUZHkRg6TM=;
        b=G08mr7XqrmpYCSHjIuRPUSsyDUh767V4HzSJNgmIeh16yfkE+c9c2XrXGLTFN9mbTc
         CmexbUd4cFhCYvKCikBww9FYjArrIAjas+jCMDBFm8S09XHPk3pVZ7PMhYoYe1AzOlzK
         gZni5vpbrjbcU5tdPFy8fAqjcI4iRIwuotfrdAubPgbA36ZsDZ9Fo8RyUaq5IUQEewSA
         JXxtW1R1JBAp0YJl3S8ozvnmegC3ZPE2DtoMbeIcuXvA7HsXM3068ScKUZ6fEpelG1PC
         puMSs2uHd6XqYTwC58v+lsVzwhMaUAjkjbSWCT9Bef0Et9Oqf/ZgKPdyjSI6wsk3BpaL
         juFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996101; x=1792600901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=hn6gY6AQ8AAnNhTaU0N75MDfD0FUEi/TS1FQv/5xODiS3XSIIpRZA4uI854TMOXWTL
         oAKzMqege9dcjh+UBBr9gHlJWK3oV7PxImPfewoNMn/EfdEzRDzvWDWH1/CN2d1rTIhX
         E4uKRJoYRoXsOdbi3811XsfUltYcCi/vamM8315us6Xt1/+FMMK3T2iRHvxcItINXwKv
         JXVsCF4aEuMT9IO3oVd/83rtsV5cBEOwC49sKoJnNK4YkCpdSwd0zEQ1XfbfvimkTaah
         P0JtGLIkp85IK9GNbD6Q8rYSpQvetcZmk6NO9Dxnc7buPDQPoy3/zQDHNaNhywl6Ako6
         /EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996101; x=1792600901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=sWbf8pjB+z307sJ2H0WtRrS5Vi2nEQA6AKZeWcBYqS3XP0jHkI2SxA9CaoJLJsPgyK
         unThR3SRNR+Htghvcbz2Bc7mCSwzEQuHASsbUtFgDIYWfX8+HZbDu1OlxxQEILifBTD9
         7EDmrQLFGzMsMTKSYqVMMsb1N0AZ4FeA004TqAzZyNd6M1dbgE7UMhZISPQf8NkUiuIA
         O+kAqRCUtee9DHepJjER+Eu6+gltwn7STBUQddGVD5CRJZXd78W1ApyNu3RSAwJ4dZli
         jY1KCpyFBPnL7Y6Kh3klLMBEjXa7ZxbYJi3LJczqBF3rny1/5Es0fdmi6v7vagrsevSD
         O6+A==
X-Forwarded-Encrypted: i=1; AKwUvBwvRFkn3Klxrw8XKWaFtve69iDo4cQcPsse628pZXhZjkf0kCttP38JpTaKMHtnneR312SfdLTV47FDa/8qrUo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGm8cPI+3L9asUZkEMTXxmw4iVJlBsotspZtR9CmoELgUQNeoS
	/dFbEoNDXFhpUShpsFECJo80b+5VUEexn9RcCGXhDCuVgN6NBZU5GXBrpeK0NqOU4zMVkL8zmh3
	IcoOpnTrIpQmMtNqMN55q+EVFbwqeF3eMPhLnuqS9
X-Gm-Gg: AYBFou2/JNIqmL0S6IRx4/ZJjiY7ZUe5gBs9Nq6EaLUqqiZr/XF0w5q3DVfcHLYQ4ZE
	A1eEkdWylOjfpTeYBRgoML3MjSbfEc0+8dmm74lFUKx7a2dhE2SZ9YA5YzoRmIcjzbrYULqgDoJ
	G5F0mJzyjLHEA2BMSGbMHHw/7BEgL97dRi0kQ6tgAum10g3MNG0AuqTfP1BiDk2NB+9EF8C49JQ
	KI8HX07V970Y/5o0Z33nP5URBdWkE7IIocBvNgKq+2i+aN69e1BoxZ9tqrBQAIyKU2+TVzHae2J
	PS6Ky5Etwfss2MOmjaCHtW9gFNyaPG9s/dAUy6zcWJrIpfXSIg7zcHUdKkJrgRevfmKQU5/N6BL
	JWHp1YmNkFw==
X-Received: by 2002:a05:622a:1108:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5360573c96fmr14813151cf.5.1791996097367; Wed, 14 Oct 2026
 09:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Oct 2026 09:41:25 -0700
X-Gm-Features: AclHuK8_g-YOJgMR77fEpf5RTsveF4u_ERdXz6lvoN6wh_uF7KP8ZsaUSV1ti8A
Message-ID: <CAP-5=fVLWh4uay2HGy6DOpZmtTr5WAd-TehAkN+P-pQgq_BZhg@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
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
> On Wed, Oct 14, 2026 at 07:36:41AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> > > Clang supports the 'require_explicit_initialization' attribute on str=
uct
> > > fields to enforce that the field is explicitly initialized when an
> > > aggregate object is constructed, emitting -Wuninitialized-explicit-in=
it
> > > (enabled by default) if the field is omitted.
> > >
> > > Following discussion at the Linux Plumbers Conference [1], this serie=
s
> > > introduces __require_explicit_initialization in
> > > include/linux/compiler_attributes.h and applies it to
> > > struct kobj_type::release.
> >
> > Cool, sorry I missed that talk.
>
> Yeah, I'm really liking these compile-time checks. :)
>
> >
> > > As Documentation/core-api/kobject.rst notes:
> > >   "One important point cannot be overstated: every kobject must have =
a
> > >   release() method, and the kobject must persist (in a consistent sta=
te)
> > >   until that method is called. If these constraints are not met, the =
code
> > >   is flawed."
> > >
> > > Annotating struct kobj_type::release caught 30 struct kobj_type
> > > definitions across the tree that omitted .release:
> > > - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
> > >   allocated kobjects, ksets, or enclosing structures were either leak=
ed on
> > >   kobject_put() or freed prematurely before kobject release (risking =
a
> > >   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=3Dy).
> > > - Patch 11 annotates struct kobj_type::release with
> > >   __require_explicit_initialization and explicitly sets .release =3D =
NULL
> > >   (with explanatory comments) on the remaining legacy struct kobj_typ=
e
> > >   definitions whose kobjects are static, per-CPU, or embedded in devm=
- or
> > >   parent-managed structures.
> >
> > Sounds great, but let's fix up the users before adding the attribute.
> > Looks like some of these need another version so it might take a bit of
> > time to get them all merged.
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

I'm happy with that. I'm working to address/incorporate the other
feedback for a v2 of this series, but I can drop individual patches
that have already been merged. Thanks, everyone, for the positive
reception in getting this landed, I plan to follow up with patch
series for the other uses I found.

Thanks!
Ian

> --
> Kees Cook
