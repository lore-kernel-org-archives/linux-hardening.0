Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5624315689A
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467016; cv=none; b=CcyaSyo6OVlZQ0rC1CTn4HZ/nj/RBgQgoH/Me3FPLeaPIpbASXXvqBQUz/ZkyE5DwOP+1pIWuZFy6PgdshndocSjP6c6IoJlDi0GXp+iv1c9gFsZRioqoGtCrpFN3nwpG8Ewo8CXIOSkqjSFsLgaukTXDovqcTWTzqg5vohkfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467016; c=relaxed/simple;
	bh=GnnlHo3AN2X6voTtxaBU3/Xd7w16hkql2u/UErCIXZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hwgrvi+HkOqrEw7+LnrUWa0j3oP2cJvhRS0LGklDkF9XV6U5Br3EOYl6w19poy/djltl8TyiVfX5ny0oX07gfIprUkW0z0T+2r1V0tZsta4LLRBd5X7w6dJwCt00YCBmq8IIhSUrlAb3G+O+x7dYWFuKFMckoYgy7FDKba3abmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SjK9gTRg; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SjK9gTRg"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2b855afd9b3so29104fac.1
        for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 09:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739467013; x=1740071813; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBy9giu2XuH33LZCPuALTlrK7I4fNXTlE0NtPV35u4I=;
        b=SjK9gTRg/q6brHd1qyx/ShNJhosbomtMC4+LFoZM/JeDtEfp184HCA1qnnKq0JEAjj
         hDeotNdBcFLwYKx4bCrH+734R6NtcmmauojIPf08X5AX0xrbv9BFCulUVPgP5upWsGL8
         c+0Umv7erJ8e1BKu01c6Q32XC9kGJlEu9GkK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739467013; x=1740071813;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBy9giu2XuH33LZCPuALTlrK7I4fNXTlE0NtPV35u4I=;
        b=tbozf4toPbD9sWl1KxXRdbw35Jee5drMFox3ZsuMcKD3EHeXZJOEe1U9pdbckRjEPf
         uHT34XIV0w+t4yiXNdmD7+V++ujlrmB5/sXXwtCFY+vOpfNS48Nyx0qRaB2UUIcQjCi6
         46x6w+1sKhCmTqCJ+Ahxgpx/COoj5q1ZJZcvE0KLmsD7tJwexBf8d7rU8QpqzYr+FId7
         WhWiTLHzkt8H4coMMmu5hqDmx3KGK/E5qfHvN/VWN0TNruHNGIIn/BBmDOjCwLODo+Ys
         EnkPz46x3VYnM5g2NCU0ho0Bil8he4Pbc7wHn7RgZxYY1SIjl9+qG1exz1z1WIlUjNCy
         H42g==
X-Forwarded-Encrypted: i=1; AJvYcCXK24ja+2hIViTDEubRc6YpkD2UWs3jaqxB274djYb6hx1LWzug3jb6zjy2nhbbfBYBZNNOpiNqQXNnqZFcX9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5cvroOi3/VV37m+hj7VnVic6Ar0DnOwR0Iuq/h+qq/5Wji6ma
	zgIhTc1mRrJeDw7GyzOcjokc3S1wsCBhjvRrObRDSETLWSF4gJUkuiAv21XKU8ZeWqaAc9GeW8i
	g0h3cUPBt0Lvf0DRAMRzpLRq9CRyW4qwWqIaz
X-Gm-Gg: ASbGncsjeDRGCNE5+yn8Xv+lJY+iBfQTquPkYgIVNNLUcSkrZFnYVW6ZnA1iVETo045
	iMC7p1C7pzqU/o4fYIVk1vpsDFc4+kTU38h8VJUDtZvkzBm6YDDrrKmmj91IZs0SSi25hOxhYab
	Uo8y5GTOIZxba1bqKGq3L254kDKrmU8w==
X-Google-Smtp-Source: AGHT+IFgl+AN2r8X6K1wzkDWdEWSCbY3TrGWVYP851EsxR7f08xemuxZwcDGWA0t2Tv/VeZB1tHKMo1KROF0nlz+v0E=
X-Received: by 2002:a05:6870:648b:b0:2b7:f564:a35b with SMTP id
 586e51a60fabf-2b8d67f0b49mr1726124fac.8.1739467013249; Thu, 13 Feb 2025
 09:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-2-jeffxu@google.com>
 <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
In-Reply-To: <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 09:15:00 -0800
X-Gm-Features: AWEUYZk-H7IZgTRLevdACXtvIkKevRsUdXrms45ENhCkHRV0gRY9quOaw4ihuIE
Message-ID: <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
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

On Wed, Feb 12, 2025 at 7:05=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
...
> >
> > In this version, we've improved the handling of system mapping sealing =
from
> > previous versions, instead of modifying the _install_special_mapping
> > function itself, which would affect all architectures, we now call
> > _install_special_mapping with a sealing flag only within the specific
> > architecture that requires it. This targeted approach offers two key
> > advantages: 1) It limits the code change's impact to the necessary
> > architectures, and 2) It aligns with the software architecture by keepi=
ng
> > the core memory management within the mm layer, while delegating the
> > decision of sealing system mappings to the individual architecture, whi=
ch
> > is particularly relevant since 32-bit architectures never require seali=
ng.
> >
> > Additionally, this patch introduces a new header,
> > include/linux/usrprocess.h, which contains the mseal_system_mappings()
> > function. This function helps the architecture determine if system
> > mapping is enabled within the current kernel configuration. It can be
> > extended in the future to handle opt-in/out prctl for enabling system
> > mapping sealing at the process level or a kernel cmdline feature.
> >
> > A new header file was introduced because it was difficult to find the
> > best location for this function. Although include/linux/mm.h was
> > considered, this feature is more closely related to user processes
> > than core memory management. Additionally, future prctl or kernel
> > cmd-line implementations for this feature would not fit within the
> > scope of core memory management or mseal.c. This is relevant because
> > if we add unit-tests for mseal.c in the future, we would want to limit
> > mseal.c's dependencies to core memory management.
> >
...
> >
> > diff --git a/include/linux/userprocess.h b/include/linux/userprocess.h
> > new file mode 100644
> > index 000000000000..bd11e2e972c5
> > --- /dev/null
> > +++ b/include/linux/userprocess.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_USER_PROCESS_H
> > +#define _LINUX_USER_PROCESS_H
> > +#include <linux/mm.h>
>
> Why is this in a new file and not mm.h directly?  Anyone who needs to
> use this will pull in mm.h anyways, and probably already has mm.h
> included.
>
The commit message includes the reason. I've snipped and left the
relevant portion for easy reference, please see the beginning of this
email.

> > +
> > +/*
> > + * mseal of userspace process's system mappings.
> > + */
> > +static inline unsigned long mseal_system_mappings(void)
> > +{
> > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > +     return VM_SEALED;
> > +#else
> > +     return 0;
> > +#endif
> > +}
> > +
> > +#endif
>
> Looking in mm.h, there are examples of config checks which either set
> the bit or set it to 0.  This means you wouldn't need the function at
> all and the precompiler would do all the work (although with a static
> inline, I'm not sure it would make a big difference in instructions).
>
> For instance, you could do:
> #ifdef CONFIG_64BIT
> /* VM is sealed, in vm_flags */
> #define VM_SEALED       _BITUL(63)
>
> #ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> #define VM_SYSTEM_SEAL          VM_SEALED
> else
> #define VM_SYSTEM_SEAL          VM_NONE
> #endif
>
> #else /* CONFIG_64BIT */
> #define VM_SYSTEM_SEAL          VM_NONE
> #endif
>
> Then you can use VM_SYSTEM_SEAL in the system mappings function in the
> list of flags instead of having a variable + calling the static
> function.
>
> I didn't look close enough to see if the 32bit version is necessary.
>
I'm aware of the other pattern.

VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
the build. This is intentional. Any 32-bit code trying to use the
sealing function or the VM_SEALED flag will immediately fail
compilation. This makes it easier to identify incorrect usage.

> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b..892d2bcdf397 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
>
> ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS is more clear.  HAS may mean it's
> supported or it could mean it's enabled. SUPPORTS is more clear that
> this is set if an arch supports the feature.  After all, I think HAS
> here means it "has support for" mseal system mappings.
>
> I see that both are used (HAS and SUPPORTS), but I'm still not sure what
> HAS means in other contexts without digging.
>
The existing pattern is to indicate arch support with
CONFIG_ARCH_HAS_N and   security/KConfig to have CONFIG_N as the main
switch. For example, CONFIG_ARCH_HAS_FORTIFY_SOURCE and
CONFIG_FORTIFY_SOURCE. Since the MSEAL_SYSTEM_MAPPINGS is placed in
security/Kconfig, hence I'm following the existing pattern in
security/Kconfig.

> > diff --git a/security/Kconfig b/security/Kconfig
> > index f10dbf15c294..bfb35fc7a3c6 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,24 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +config MSEAL_SYSTEM_MAPPINGS
> > +     bool "mseal system mappings"
> > +     depends on 64BIT
> > +     depends on ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > +     depends on !CHECKPOINT_RESTORE
> > +     help
> > +       Seal system mappings such as vdso, vvar, sigpage, uprobes, etc.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       Note: CHECKPOINT_RESTORE, UML, gVisor are known to relocate or
> > +       unmap system mapping, therefore this config can't be enabled
> > +       universally.
>
> I guess add rr to the list, since that's also reported to have issues as
> well.
>
sure.

Thanks for reviewing.

-Jeff
