Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB72571B6
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424235; cv=none; b=NC1DVXNBcjwGu5c73G7FpbzEThRW/PY/oHs8Ztw1laU6/JE+1dBmhVmIJJ40efnrvSGbHVRH0h0v1UwCjDkj0zEHARjpDtAbxCiIxhhyPKJGZLWA9Z19XtJ5yf7cZLMKghjMGYZvVK4U1Vrwl1fwtVdp2piR5tbttHYi6hlyb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424235; c=relaxed/simple;
	bh=JJqwJdyWEpP4WKiHJPh2dMaurzmP+l2Jd9yHTkji/14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lIq1VwEz2hmMQlbSsyWPUWmAfab2bNAGEyUHEgRjk+MsKkRzhIO94FTR7ReWu2vuox/Mgt3r/aQaXKCYm2aEeRAuz0/qflDnIjoROcw71dEaLTRE4m1TrIMh1f+WhyEaRLD1re4CyB0ZubZ/aeROVGhqbHMozA/zvKwMJRC4GwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GYzoG0fr; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GYzoG0fr"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-724daedf8c3so1222338a34.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740424233; x=1741029033; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9GUPPHtI/YKh17WuuJkLZZaFJrQQSx3CAYW3DjQ3WE=;
        b=GYzoG0fru+lRDiHghSLjjSUyuXZjUWR4g92Y3KChJ7ewHbwE/DdkVUHgos/NR9/9Y5
         sdPXwZVhrhNnzVLPjZohoGxgnskln2fz7D7wEjZNUEE2K2ux3/1t7hZc9EQhXGplaVIU
         uy31plx6ocVNEhz7uqhQoZJ9I4a/lpL6+P/sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424233; x=1741029033;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9GUPPHtI/YKh17WuuJkLZZaFJrQQSx3CAYW3DjQ3WE=;
        b=esboHJxR9ylywug18UtHszT32IkSoHnVlGe6GNX3+VgkzH5eXEQFs8GrsYlRrD0O10
         UiIa0kQTbiueJ826lnAxA9085QUOnNz2ISgRlWTr6VajefeXXtSrryWGZY/bkmUVv2Ni
         WcknW4/kk4Nzmn4e5TjqQoKR1kLbX1c4GDDMxKxNhwpFPHOITn30hRd+TZyYn9ZaK002
         0C7R5WyACxT0GtX1fMRNX3PyFLYRpdd86CLxqp6t406pCiSSLoLE1tmz+A0uCJptrXIu
         5XpGDWbnS9nleDI0JPbgIatUBO16EBl3qYESUWCR/CZlqRGKbqLvdcEe7yTg+zbKFdxV
         O40A==
X-Forwarded-Encrypted: i=1; AJvYcCWITB/4zBHmiSkv+20ULLF5G+2SzmAXzPRxchHVOHQCVSA4fU2YzA3sLFjLOaS/5MYhJI5MaAT922YARFkbgIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9lqGXmgJKtOwCiPdDVpcOFt4tPpOAuyoqx4SNrQf2EpX4vl6
	fGLmUmm02dWRiTwaYVr1QEODheLt/pcI3T/Iew/CeYrXZIqpwHvOs3+LiYwSBaS4g7bg2pwVkEU
	KGuUxXD4XcYi8kBWijfzgxws/Srul4rsASl6c
X-Gm-Gg: ASbGncsoqyxUIbVQnMzXPgDF5CjPaoWjBWque1tL+Vo8vbatHcn3j1I8U1c48ze3P55
	1MM+ArTE2ZqR+JxR0xliRgy1xlMaSX9Bag6KQsCYBXt8c+1+ClE0G5el75hAcz71sGT+wKpuKrg
	a4u4Ih4srg+Mb1FMitH3CAFr/nGXVizCQ3Y3Lq
X-Google-Smtp-Source: AGHT+IFlDVsxYo9mfEvAqcvS4ITFW3i/z/MP2mONGiYQhwahTiLBP8R5L4zcHu5ETCTa4Vq9saY30CuDm1u91AncVR0=
X-Received: by 2002:a05:6808:2227:b0:3f4:ad6:519c with SMTP id
 5614622812f47-3f4246b3b10mr4256084b6e.2.1740424233263; Mon, 24 Feb 2025
 11:10:33 -0800 (PST)
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
Date: Mon, 24 Feb 2025 11:10:22 -0800
X-Gm-Features: AWEUYZmwpnqiN9sqZHdi21X3o8pzG8dSdU0zfO4HZpkMFe9rZXpLE-Vov3pXiB0
Message-ID: <CABi2SkV-RwWjfXZfK4tHzQWG=dCJU7CRGmthSA8vqhHcbeCiQw@mail.gmail.com>
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
How about MSEAL_SYSTME_MAPPINGS as Kees suggested ?

The VM_SYSTEM_SEALED doesn't have the MSEAL key or the MAPPING, so it
might take longer for the new reader to understand what it is.

-Jeff
