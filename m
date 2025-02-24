Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E171EA7F9
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424051; cv=none; b=aa0tJMDvpL/N4npHORToRnwjBmSZSDYZVh0WQ1kRvm37ySgnHMw8yaLnKJLiCDIbia6vxaI37dpylDbgo+B4ulGdxngpcS0Njd90w0FFSesqJ6FTyzLCES46yv5bCkYNgACEpmE0ebecMJN8I7EuvUNK+Wr9MpUwlJrZCv/KMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424051; c=relaxed/simple;
	bh=GbuUXHqUtP/Zw8eNMCTnJLOtMqQEM+OFbTLgxZqprGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WR5SKUxIiRDfVTAdmur2MDkovOncfDOi1Rvgyd2DnWnJj4oDQaEGkqAfxzhL0CX3FOSRzfxFfzpSTesZww9cvVaEKlmQNKrl6vsLidg/NH4vGFkU9rui3L5SLIXnu8ZDRTK/UoRNtj3RBO9s5jMjvVWX7yHxIfF+tB5qBs3hl2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dIHNiEnW; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dIHNiEnW"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2bc919f16c4so201541fac.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 11:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740424048; x=1741028848; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQCHGb/1mEcTjB0ohJkHDUAZUcOj91T5VUbYgnfzfKs=;
        b=dIHNiEnWIVWmOw1r432MBjAWluocUeWXz11TtpsWGtyet7Wp2BlgSMexd2JdgAPeTS
         xxCqIPEsuKf7TbMV75RQerE6gmFmPGwetKBilHB7rqvvTfu4IEcJpqQvgf3U5L7UqU5t
         CWcb/1l09DoRfW+8MlXyOsND5znqTdgZyi/sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424048; x=1741028848;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQCHGb/1mEcTjB0ohJkHDUAZUcOj91T5VUbYgnfzfKs=;
        b=qaHIBKEWJ5gGUX8qFSHNididbEXlV0e7aRnUMDARjbsKLO6fZKlWikK9+Rqg0KZwTy
         Jqjinu+k4E9yWmEql85mXe6AiSfDSA7mFUPNcQhqvfSW2miElzjWUApkHOBaG1czZuQJ
         ji7ZCa+//o+fMgLj/tZ59eGha8Op5PZB36Xg7mk2rzhBQphGDQIDkrqujwuoH+e8sR1T
         6XH3joGXoVAcCZ1LGKbAR+DXd041GdJtf8+FDdtmktYHtwwP9J0yTP4FcvGTudFxK/1p
         44vmphPWx7LPDWx9q3tcAt4uj4/Fu3dM3Oh/0dgLZabob6WPFFszUjO3B/HiUTnvnBkf
         bWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzqlTEIhJi7rsVPZmdFp51A/tE7aLsJfjPgf8Mct2gIuFIfFxyjhrFlfNSBy5JWxPaVBq96Y8m7dWOjmbF4ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWI7066w4E/yq2nb7BBVNf9AvJEyxziHW9oursehzEM5x9uhmQ
	gu/5jLQ/gEM3lALqT2DDFhcwuj4lBE2YPUPqnJFlEx7OJt8MkjjYMr67C0NmeiXdSA/NRTMKHlX
	VXXJoV5MYQyOBxyiNEG+n2JxQhQW/zExrRmO3
X-Gm-Gg: ASbGncuVIaKxpai6MHcDg1L+LZjrmi1UEPWidCvVEnk7maCjauou5r+foFkHqwUt74U
	aKEH8Pfspun8C7+m2F4GtD2gHHl+h6MymI307oTacoqB1m2h0K6Rkr3mPXT6cZUAFGzl/2vogZo
	1gwnMASpvt1wgDSahAEVBDWjuMYRYA4vQZQo4L
X-Google-Smtp-Source: AGHT+IFrbrwEmuYOunYtHNdMni7okQkt3QFjQtD8vHn5l5zTdcXfnyAMvDD/7Ae+veDhcxsJz6JhhrxQ5jvSrdRN1DM=
X-Received: by 2002:a05:6808:201f:b0:3f4:11a1:615a with SMTP id
 5614622812f47-3f4247a9cd8mr4184198b6e.6.1740424048367; Mon, 24 Feb 2025
 11:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
In-Reply-To: <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 11:07:17 -0800
X-Gm-Features: AWEUYZnFbU7bWMO5mDGdFqrYIJo2aJVDJw1Nuop8sup_tSwiXkOaJwtHACFOP_4
Message-ID: <CABi2SkUfABFR+SpjBzHT9dEcsJ0OOHiyttKkQVhqrHLrtZzopA@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
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

On Mon, Feb 24, 2025 at 11:03=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [250224 13:44]:
> > On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Dave Hansen <dave.hansen@intel=
.com> wrote:
> > >
> > > On 2/24/25 09:45, jeffxu@chromium.org wrote:
> > > > +/*
> > > > + * mseal of userspace process's system mappings.
> > > > + */
> > > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_SEALED
> > > > +#else
> > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_NONE
> > > > +#endif
> > >
> > > This ends up looking pretty wonky in practice:
> > >
> > > > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > > > +     vm_flags |=3D MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
> > >
> > > because MSEAL_SYSTEM_MAPPINGS_VM_FLAG is so much different from the
> > > other ones.
> > >
> > > Would it really hurt to have
> > >
> > >  #ifdef CONFIG_64BIT
> > >  /* VM is sealed, in vm_flags */
> > >  #define VM_SEALED       _BITUL(63)
> > > +#else
> > > +#define VM_SEALED       VM_NONE
> > >  #endif
> > >
> > > ?
> > >
> > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
> > the build. This is intentional. Any 32-bit code trying to use the
> > sealing function or the VM_SEALED flag will immediately fail
> > compilation. This makes it easier to identify incorrect usage.
> >
>
> The reason that two #defines are needed is because you can have mseal
> enabled while not sealing system mappings, so for this to be clean we
> need two defines.
>
> However MSEAL_SYSTEM_MAPPINGS_VM_FLAG, is _way_ too long, in my opinion.
> Keeping with "VM_SEALED" I'd suggest "VM_SYSTEM_SEALED".
>
> > For example:
> > Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu=
.c,
>
> third_party?
>
Sorry, I pasted the code path from ChromeOS code base, it is actually
in the kernel itself.

fs/proc/task_mmu.c

> >
> > #ifdef CONFIG_64BIT
> > [ilog2(VM_SEALED)] =3D "sl",
> > #endif
> >
> > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the problem
> > in case that  "#ifdef CONFIG_64BIT" line is missing.
>
> I don't think it is reasonable to insist on doing things differently in
> the kernel because you have external tests that would need updating.
> These things can change independently, so I don't think this is a valid
> argument.
>
> If these are upstream tests, and we need these tests to work then they
> can be fixed.
>
As above, this is actually kernel code, not test.

-Jeff

> >
> > Please note, this has been like this since the first version of
> > mseal() RFC patch, and I prefer to keep it this way.
>
> Thanks,
> Liam
