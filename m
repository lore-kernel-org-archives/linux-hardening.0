Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09287F9
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528255; cv=none; b=Yeyecv6l2U0sI1/W5xkzOCwYD7lbn1pF7MNS9P7nEjA/S+dqdf6B87hTN7e0Yo791A3psZ/gGGQnB5QkWqjEGZHRzo00dQvQgFCE5WGF1GfAuQrwTZHc1DjIJqrLLql7oJm+8FiMkFqCFsJNbdWqJwXSWvtJc+6y46tLfECt3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528255; c=relaxed/simple;
	bh=1yX+lPMj/Bv38F7QE3GB0m1ooEESeQHqZ0n0tU+wUmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aqjcKG9/WU5cydoR+o2l7k5nS5CP/oTYdca/r+TdEa5Rp1pCCiy/xjMKOJZ42CuUNy9LM6sZAmlMA07cbFjc3FR8GERq/hLocJuN2zHOiUUKVE8uR9C84TiUg+zXN0iaFlYkRDZIjZGUJLpNou06cfHjcaJuyne/p4x7xxPg59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DlZKOvmg; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DlZKOvmg"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f405bdee5dso141271b6e.0
        for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 16:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740528253; x=1741133053; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAjEfO6OUPLrsSI4+ZqyyWf8aULkwTfzrb9ydxvzH2w=;
        b=DlZKOvmgiC8i7byYMe8iuVUS5gPGy3UVTuR3O7B9H1Y1W3cAUccOMYvcFN1vaO9CR1
         Gjrdz2quFDKEj3atGLmLYjzUgk+Myg28P7+YJ0wYw+rN3cdSi20ivfZj+z5HmFhhQq+O
         1E/ju7BJZh41cFy+Q01LX4jCGhus5erWdGVSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740528253; x=1741133053;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAjEfO6OUPLrsSI4+ZqyyWf8aULkwTfzrb9ydxvzH2w=;
        b=vDefF4ArB5AF4jWLmKggJL6ufF/j0OM1Alpn6MR3SmHkC69ZcPHR6XTK/DHERwPVvg
         QOVDKLHjQjpft2GM5jD+qf2IgEFoRqulLiagnSgdAjr/RMj2y80XhmNJT9CMgpRYcjWM
         1hzAiLNsQXOFjOPR/HpNRjm6wD99mSNQvgUOkOOM60GnCQYb3t3Wg4IQ1dxc7rMdj70p
         tikUAsRCLrsbqJ6NQMpFd7lflJ44LmV/5GoA30ZNlwtTay4TonQDET2yxycGZbK4kkmJ
         2Q7SPP3lI6LdklqLvpj4CetIkFMVpawpArgDbNWm2KkczETeLF3SZFL+kU8aK1n4OIPl
         E2sg==
X-Forwarded-Encrypted: i=1; AJvYcCXW27xM6SDdSl5q03L4ZsMu3JlXQSaRP/k159sTelvpznvSghPJ/KdDopDhcE8y9fyRGIcrf0z1cTK3n/oNdB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEW7spkcV1faCoaxn4in4JSVL5JVagPxhnp6pPCD0ifPk+0Y1g
	qULvEkCfpf32jUsHN1zxbzTM8Afbn+I6TcXC1mOQgRP4+Ahz0w15YGRkBoWQMbzbatr4+ZstlZZ
	chF91CN01OlBC65IasdfSENgKGg++d0eWwvKJ
X-Gm-Gg: ASbGnctOdqS+UJpefAPMqokqJ3oVTRqXKXue6P8d82qJXsYQBu5Go1+5f1WAw82EmZI
	e/cpdi3iRhKS6UIA4gmQH2NY58vXsi180GV0vJ6BUbOlvo3/+3h16GuBnI7ql04sqslNh/cZesN
	M4U12LN6pwO+CHaemnLACbhwITKeMP6KIw1UQ=
X-Google-Smtp-Source: AGHT+IH0tMkf7zVWE5oKycNi7tQ+C4mulyLIE+qkN1l/yiOlxc6TGinKcH0YiGFDJxWMSgE3ga1mFWhDjmTihTwlBJg=
X-Received: by 2002:a05:6808:218d:b0:3f3:fe33:9ede with SMTP id
 5614622812f47-3f4247d625bmr5111584b6e.9.1740528252736; Tue, 25 Feb 2025
 16:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-2-jeffxu@google.com>
 <bekot7b4mhgdsp636e4zltao4bnqoeiu46yehrwpuzydfgt3ya@t5njn75sbvym>
In-Reply-To: <bekot7b4mhgdsp636e4zltao4bnqoeiu46yehrwpuzydfgt3ya@t5njn75sbvym>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 16:04:01 -0800
X-Gm-Features: AQ5f1JqFUipPq9oY_uCEGFr6KvVeMOr2ifqonAZbCccBXdmDsOIiZ7y0Q2hJqUY
Message-ID: <CABi2SkXSSmmMExLkwEH8GVknf0eaAZRQ+phvu1FLBR2wkJwQvw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] mseal, system mappings: kernel config and header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:23=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [250224 17:52]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide infrastructure to mseal system mappings. Establish
> > two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> > ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> > macro for future patches.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  include/linux/mm.h | 10 ++++++++++
> >  init/Kconfig       | 18 ++++++++++++++++++
> >  security/Kconfig   | 18 ++++++++++++++++++
> >  3 files changed, 46 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7b1068ddcbb7..8b800941678d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_str=
uct *t, unsigned long __user *st
> >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long =
status);
> >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long=
 status);
> >
> > +
> > +/*
> > + * mseal of userspace process's system mappings.
> > + */
> > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > +#define VM_SEALED_SYSMAP     VM_SEALED
> > +#else
> > +#define VM_SEALED_SYSMAP     VM_NONE
> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b..07435e33f965 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
>
> I think we said ARCH_SUPPORTS_ for software features in v5 of the series
> [1].  Can we also make this change please?
>
Sure.



> ...
>
> Thanks,
> Liam
>
> [1]. https://lore.kernel.org/all/202502131142.F5EE115C3A@keescook/
