Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C422200138
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426165; cv=none; b=Q09xYzXWcDR6orS6rzpqdOZAQwrYfT9k2cN1Fx8BwRWhVgCcrGTYvwl9EKZOaSHAgkobDn8j0bJbmxCr4Hx09l6E6hfzCxOwnpvNkHFcrzkHLoxmGki1buWlfKg+2fPXWGR1LJJnv/BMzWKqAPmDPqBMsS6S6Lk72mNSU4pKxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426165; c=relaxed/simple;
	bh=KQ4mgA7vR3HIK5onJDgr5Ls9mIKasO7wOQLm1ymJX6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+pclJskQ8YQn/J9o4kYa/qbIgRk9HVjL8kfXw/+GG+7Al2g9qqhpRo4O4aaCz0PzcsRJ69C+EJItIL8lxHH0yib4tF6IFTJdEx8h3bqTxvb7/HFU5dHF6bKB/lN3BIdwROsRf9HzQUFMhrGbiTwmR14hpNn+eqe+EhSADsp7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m6Q+tg4/; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m6Q+tg4/"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7272b51f677so647812a34.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 11:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740426162; x=1741030962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Es3p7SgafSY4oLQGoZeThVjJZmm01HoRMAcWvJvl1k=;
        b=m6Q+tg4/ZQ6BH/dedIRcuBZ86rGrdzQUwpV51ZX6NDCjwCBBhF9ldAC8OXGgbu1tp6
         B3FDJM9SobG7QBmT9TC7VFeH6wG/in+tu/XXBoHDaJtjY0/kj0xjzK9gJyd0EL/QTLb2
         nis3tGfRkgNZy9xUwPFgeaLi4oEmKzPLI61aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426162; x=1741030962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Es3p7SgafSY4oLQGoZeThVjJZmm01HoRMAcWvJvl1k=;
        b=P+JnKlVZQ6mPjtGFEMvTVM/EwgSA3OXsCvDej1Hev5BXuw120A511+G1DzuJniRPuS
         fp8q32sDYHKIWMwvTpuQS+SjYI1WLdBTaljYr1v11GgykgLlmygTSuNyO5jJ6iOYUB1a
         X+DZiFZ7ak8MPMSHn7pOQ2GGvyP7OZx838ZbyckRzp6Q2ywJOqDJsdMXawH2zYGKnCiZ
         SxgPCQghzfZY+xRiYsaytLnmOjjtIzzPIsTuZwKW2mNqJx9FNidWFoML4hvm6UponGyY
         kfzKYtFMeMfAYbFHylmuEaTpJkbcUnybXrPLYTvYaq9tdvu6amUGVASwp8CY8zahZpYO
         NwNw==
X-Forwarded-Encrypted: i=1; AJvYcCUWXB5vvs2LWWDWZ3RVAgnLzyXckHe1gExkat+5zFGktsU2khubWL9z8vPu9OUWL5whjuh1vGSKI4DE3sOAvdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjLKzG5ubEahKHD65cLEMr8UwTDievVa6HG5wL1F6OR8d7t9RH
	7/ZNkmeki3l+5+PY10y5TV+S4pMg0YdB+baOXILjX65PZoon4E5yxBj8ekaTGpb6SZ77KxfqbSU
	SqVhdg/ZHQp7PTnCdRL3IDpeIgYiLsTu0qNyY
X-Gm-Gg: ASbGncs9PEbdwheAv2JK1kRpkdQlr4V9Aeld44hdMZVyFTpkh7oG5HZpu31cic1xBC5
	nyho1j/rfjzWepYb1OJXAq+7RdTQ6z2jiU3sxCzwVFKSv0N0UPeRS0dV3aMN70c6tC/J9xcodB7
	r+6773yovWsbuCFan1F3dm9fg8693v02+Igwbv
X-Google-Smtp-Source: AGHT+IHQebWFIc+YbZsrpXi37OAN8G/Vl942Csx4aIQSIGMLUFk3ZZIO2UooV/I8ugypB3Do3y/oUyp5eBDftpI9Je0=
X-Received: by 2002:a05:6870:6e02:b0:29e:5f79:21b4 with SMTP id
 586e51a60fabf-2bd50fb9776mr3779734fac.13.1740426162024; Mon, 24 Feb 2025
 11:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
 <CABi2SkV-RwWjfXZfK4tHzQWG=dCJU7CRGmthSA8vqhHcbeCiQw@mail.gmail.com> <202502241123.D398A24@keescook>
In-Reply-To: <202502241123.D398A24@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 11:42:31 -0800
X-Gm-Features: AWEUYZnIh-aVK2V5D2Z7CSJGHhvBCNIiddlen5uSwHi2kaMpnPPFF88FSIikjiE
Message-ID: <CABi2SkXLdL37LxLuo+W=rUOrBKfMbxgkkR+s3TqnnS-eAQbakg@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: Kees Cook <kees@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
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

On Mon, Feb 24, 2025 at 11:25=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Feb 24, 2025 at 11:10:22AM -0800, Jeff Xu wrote:
> > On Mon, Feb 24, 2025 at 11:03=E2=80=AFAM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Jeff Xu <jeffxu@chromium.org> [250224 13:44]:
> > > > On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Dave Hansen <dave.hansen@i=
ntel.com> wrote:
> > > > >
> > > > > On 2/24/25 09:45, jeffxu@chromium.org wrote:
> > > > > > +/*
> > > > > > + * mseal of userspace process's system mappings.
> > > > > > + */
> > > > > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_SEALED
> > > > > > +#else
> > > > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_NONE
> > > > > > +#endif
> > > > >
> > > > > This ends up looking pretty wonky in practice:
> > > > >
> > > > > > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNM=
AP;
> > > > > > +     vm_flags |=3D MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
> > > > >
> > > > > because MSEAL_SYSTEM_MAPPINGS_VM_FLAG is so much different from t=
he
> > > > > other ones.
> > > > >
> > > > > Would it really hurt to have
> > > > >
> > > > >  #ifdef CONFIG_64BIT
> > > > >  /* VM is sealed, in vm_flags */
> > > > >  #define VM_SEALED       _BITUL(63)
> > > > > +#else
> > > > > +#define VM_SEALED       VM_NONE
> > > > >  #endif
> > > > >
> > > > > ?
> > > > >
> > > > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part o=
f
> > > > the build. This is intentional. Any 32-bit code trying to use the
> > > > sealing function or the VM_SEALED flag will immediately fail
> > > > compilation. This makes it easier to identify incorrect usage.
> > > >
> > >
> > > The reason that two #defines are needed is because you can have mseal
> > > enabled while not sealing system mappings, so for this to be clean we
> > > need two defines.
> > >
> > > However MSEAL_SYSTEM_MAPPINGS_VM_FLAG, is _way_ too long, in my opini=
on.
> > > Keeping with "VM_SEALED" I'd suggest "VM_SYSTEM_SEALED".
> > >
> > How about MSEAL_SYSTME_MAPPINGS as Kees suggested ?
> >
> > The VM_SYSTEM_SEALED doesn't have the MSEAL key or the MAPPING, so it
> > might take longer for the new reader to understand what it is.
>
> I think to address Dave's concern, it should start with "VM_". We use
> "SEAL" already with VM_SEALED, so the "M" in "MSEAL" may be redundant,
> and to clarify the system mapping, how avout VM_SEAL_SYSMAP  ? That
> capture's, hopefully, Dave, Liam, and your thoughts about the naming?
>
Liam had a comment in the previous version, asking everything related
with mseal() to have the MSEAL keyword, that is why KCONFIG change has
MSEAL.

How about VM_MSEAL_SYSMAP ?

-Jeff

> --
> Kees Cook
