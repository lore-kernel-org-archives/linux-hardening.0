Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5D2185B8
	for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523027; cv=none; b=LZR8tlK7HLHZHxMhnIUlkIZ++07m7ckIoVKudkVXYJOFzh4x5Y4qrEo/VcnMF69Z/wyT4hVN2aOjvtLpfpWm7VGRU97Dt7JAIO9XktdqSWOWLaSYIwu8p14a0w0mxcdVbSKgB+tPZU4ojsLSHkabzqO7clo0WykSaE/sNdh/bxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523027; c=relaxed/simple;
	bh=pc2psdDs8CiausNYsO+iqMICUCJoqsAkW4t0aSZcJeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opjS3hH3whuYkL+6i93HZz8YYY4J/kVOLc7Xl+mfWiNr1t4YsF0Nyu3h/lPmwfIaNcBeMU9PvCSc6jp/5tQ90qnZcf6Urrmkh9fosPzaEgnj2nuT30TjMRKNaYk3XVokWpNldetWy8+lL3fAjypBH9uA9AVw5b4+bnbIrRWZroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZSbBirH2; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZSbBirH2"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-724daedf8c3so1567460a34.3
        for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 14:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740523025; x=1741127825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he1zzs20/BQZyBVCAwd7XVf1k94Dy4rhXpIs1H1s64Q=;
        b=ZSbBirH2bSSWyd+Lt4vmOZG1WROidfkVO8TKWydgCWxP0QFFvJz1wAXLZB0u2k3Mgy
         81bBDVFPy9J8EDyvRCf5qI96zhzElAnhmX2TPVt7rAgVY4L+vsGcyVL8JCrs69yKwzBK
         h4JA/9gAZgC02HOZbkmtyOqbEBYdvxJlWONik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523025; x=1741127825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he1zzs20/BQZyBVCAwd7XVf1k94Dy4rhXpIs1H1s64Q=;
        b=hZGtAaxjAJC0lAoP6xIPi/UdPaHcTv2L8yzKQD28kYHavYtemHPQ1zPaerpUG1OMQ7
         HozMTO2rk3zfhiJvrRYnXHW+CoKWApKwqlLB3V0YAkmeCV61FzLetQSxwVTWpdHW6wmq
         2MSBNLWMgPDRzalAGROxb/C+t3xL4X664+VJZ8BSvl+r2FByf0rJhBMhdl687nsh3z6d
         8eqElH4yyOrxD1qgb44/YGVXKeUwrHdi1PjvHqj3O3KKr57/hihKdqQTcBkSGCsBhWYV
         xpGUAmz5CLpnAtEWimXu06CZ1yKw3MFH8cDiAhxgG1TEN0CY5kWprT3VEC8Lia8MGlwH
         9+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU2u0rTLP248IxDNcLHqTSs3AqqYg2g1Ccyg4+nekE1RrkZTa3aMCdFKuKnn/fc2HAW4sYGQ+nge3cat5eEjmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNB6cmMxfMIHyy9ZJNBnRq+sB3oORWJr/dpIJLJ2GNd3ztIfhN
	gwr1v8v8QjI49bPz+fIUN0vMwnFmJh5Gx38FYhFnSAHMrkABVkFHK54RU9fcOjYQLHKzydvD41J
	mrupwhsmuoJdfssfcPYuv2PDRk6csyTSaA3sH
X-Gm-Gg: ASbGncs3LzE8Zu5WVTls3K4rB19jqVualBoXOybxvg5JZFYT1AlmJdNGmd87AqBDVO+
	62s0zyWoV9zI7+qMoooyHOq5+zTrfHbJV8rhXfDzEDfL2I2tQmAl+AA2iczVroQFq0NNSWJKZe+
	YXWoujkk2d/LTT798g7d1ELJi/p6gXipzAmrs=
X-Google-Smtp-Source: AGHT+IFE2qDJ7AHvWU5W+D1us/Ww7fyyu2BX+ztGdxXVJZ4ljOzbiiha3CUiXpNqk8NwHYvFjmfBwARhpEbPpjVTcNw=
X-Received: by 2002:a05:6830:439e:b0:727:43c3:2a6d with SMTP id
 46e09a7af769-7274c195252mr4799190a34.2.1740523024831; Tue, 25 Feb 2025
 14:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-8-jeffxu@google.com>
 <7e1bfbf2-3115-408d-a40c-ae51a7ffffe4@lucifer.local> <CABi2SkXcYnSOTPHy=VYCUGA9UpXSt_2fCqF8sWS8nxrah5ziPw@mail.gmail.com>
In-Reply-To: <CABi2SkXcYnSOTPHy=VYCUGA9UpXSt_2fCqF8sWS8nxrah5ziPw@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 14:36:52 -0800
X-Gm-Features: AQ5f1JrkU6JVMfs8G1GrfbCiG-C4QL3T9-vXo5FQIi-W0ggnJJciFOmJtuj5F0E
Message-ID: <CABi2SkXbtF1GmbJWO+F2KM7sFv6yh4cHpNGkes4A0aRWd+fiQA@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
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

On Tue, Feb 25, 2025 at 2:31=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Mon, Feb 24, 2025 at 10:07=E2=80=AFPM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 05:45:13PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Update memory sealing documentation to include details about system
> > > mappings.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  Documentation/userspace-api/mseal.rst | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/us=
erspace-api/mseal.rst
> > > index 41102f74c5e2..10147281bf2d 100644
> > > --- a/Documentation/userspace-api/mseal.rst
> > > +++ b/Documentation/userspace-api/mseal.rst
> > > @@ -130,6 +130,13 @@ Use cases
> > >
> > >  - Chrome browser: protect some security sensitive data structures.
> > >
> > > +- System mappings:
> > > +  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_=
MAPPINGS),
> > > +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso,=
 vvar,
> > > +  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, r=
r are
> > > +  known to relocate or unmap system mapping, therefore this config c=
an't be
> > > +  enabled universally.
> >
> > Thanks for adding this.
> >
> > Similar comments to the Kconfig update - you are listing features that =
do not
> > exist yet, please just list what you're doing, specifically, and avoid =
the vague
> > 'etc.', we don't need to be vague.
> >
> OK, I will remove etc and list the known mappings here.
>
> > As per the Kconfig comment - you need to be a lot more clear, I think y=
ou're
> > duplicating the text from there to here, so again I suggest something l=
ike:
> >
> > WARNING: This feature breaks programs which rely on relocating or
> >          unmapping system mappings.
> >
> >          Known broken software at the time of writing includes
> >          CHECKPOINT_RESTORE, UML, gVisor and rr.
> >
> Sure.
>
> > You also seem to be writing very little here, it's a documentation page=
, you can
> > be as verbose as you like :)
> >
> > You really need to add some more detail here in general - you aren't ex=
plaining
> > why people would want to enable this, what you're mitigating, etc. from=
 that you
> > explain _why_ it doesn't work for some things.
> >

The mseal.rst already includes below regarding the protection/mitigation.

Memory sealing additionally protects the mapping itself against
modifications. This is useful to mitigate memory corruption issues where a
corrupted pointer is passed to a memory management system. For example,
such an attacker primitive can break control-flow integrity guarantees
since read-only memory that is supposed to be trusted can become writable
or .text pages can get remapped. Memory sealing can automatically be
applied by the runtime loader to seal .text and .rodata pages and
applications can additionally seal security critical data at runtime.

I could copy  some sections from cover-letter to here, specifically
for special mappings.

>
>
>
>
>
> > You're also not mentioning architectural limitations here, for instance=
 that you
> > can only do this on arches that don't require VDSO relocation and listi=
ng
> > known-good arches.
> >
Sure, I will mention the architecture that has this enabled
(x86,arm,uml) -- I don't think there is an architecture limitation
though. mseal is a software feature. The reason why other
architectures don't have it is due to the fact that I don't have the
HW for testing



> > This is a documentation file, you can go wild :) the more information h=
ere the
> > better.
> >
> > WARNING
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > > +
> > >  When not to use mseal
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >  Applications can apply sealing to any virtual memory region from use=
rspace,
> > > --
> > > 2.48.1.601.g30ceb7b040-goog
> > >
