Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E381FA17D
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249985; cv=none; b=dslImGc/UUyzol6gejoP/0Q4ZKSlO9Q96GC1J1BsNKZ3DSJuOn9qV/qCowtxn6iZVjLbZbZ55IM2hSFuTA4z9/PfGR50/jZHVklBPgixfEr9D4T+XthmfWRtQNuE4LeX1xr98TvRb/zadOLMUubx9Rs69Psr+HVHW+GYr62Bzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249985; c=relaxed/simple;
	bh=RCR0tFWLzjY5bZBl9sbvDjNga6GxafuR/0wB0Gtox0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pocCEeMK/yF7R3BRdkvnJhTgC98VtGBzuM2zhsMZfgk0d7ywIUdoSYLp5+LNA7pc83hl+AiAisDclAs5Amg3oybRDrJP7P5e4nD/hCD3jozEUXNWvglJc/eAyv86zdQbN85ZahCeCw9duwYohOgFCFjlO24SkOSORFdeEjtppac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LO1sSBOY; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LO1sSBOY"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f1ee547352so466979eaf.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 10:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733249983; x=1733854783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59eQH95pHmwNRP7ZMbIOvFCuElg7B93/Yej/yv4KCTk=;
        b=LO1sSBOYzQaNmeXbAjl406MASbRpAByZQRyH1dHXTLNjXAFIyLNOktKaK0vjCTW4oK
         FBNt8Ko2N6tRSs2lWUjuIVNJBg//W7li2rmmqugPgybIjEvbVab0rRyK/Qa/hQEx0Vi4
         X7zY/0hRPlFHtC7975khFXt/+MQ4nNrZ/wHWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733249983; x=1733854783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59eQH95pHmwNRP7ZMbIOvFCuElg7B93/Yej/yv4KCTk=;
        b=GxmsoMmtwD35PfV8mMXrgJRCEuyfvpE/H8EMqWs6EWqYRPTwVFbCIgyrhlRJnv4DDr
         pExU0b3pGgkFPgZ+6nFza5PbWBB0HvBBQWLQhJRjbHUatWrSnzWHm2dvW9lAWPN9MI58
         kxkMYbmh8QddG73VEzt+jTaBUV9KtK8nL9j54sXqPdV9ct+HofKgvu88q5+QUe5eVmmj
         IO6TOvOQSltN0x4KHrDpxzOey0VhHpakYnxKIyZ3dkqTWM82y5J+Ywpsv8o854w4yNCq
         E2gkA/8huaHMB9Ou1GO7b4a7OhOZ6LNnQw4nkLNl0QjxNHvfUt8N4P9ZIRAJ4XEMbtgq
         7aJg==
X-Forwarded-Encrypted: i=1; AJvYcCU30deQ1dwsh41ICCde/qEdiKpSZXzucAy68b4Z5FUI6WdHRg4do7ZdZ8b5wjmObdjcLWX7eB8vraEXmWgWWwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLRJ7njPwFRbXqk8HnZcPiUiMNZuUJhi5ylVDkM2225beg+RM
	al9ceOORhHjB7YA9LdF2gDq/zMvDai2OeZqCZitm01U2xBRg6s7A6wIqNVhqnF0VMIb847jUDJY
	bC5EkILXUShrasoNH5L9kypKpCJRjWKabLcaz
X-Gm-Gg: ASbGncsCIe+LVS2GWZ3N3NzbaLjBtLm3P3iSKWB2exi+0fmcHZmf1JudMZgNA7wtm08
	zxbp30tr5FfsEabTTZGiGUmHUhQtkeY9o7O3qryktz4nodbibCfXf6VSidw==
X-Google-Smtp-Source: AGHT+IH+vEOEpO2+ZsBkpay9GHcb2GL2m9aq7zERS1Q2Q1gPnjbTAr0lIYB6hDIEcFeiE2Hxt31L+EcCaeddWdn9Bbk=
X-Received: by 2002:a4a:df56:0:b0:5f2:37de:5808 with SMTP id
 006d021491bc7-5f25aa87e00mr553699eaf.0.1733249982542; Tue, 03 Dec 2024
 10:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <ce2bd3dc-e7aa-41b4-9d57-2cc683b5659f@lucifer.local> <CABi2SkUFCqy0pWfrOcfC0a0GMVpFODtb=Hunw6WW1D5N-A_MXw@mail.gmail.com>
 <0f22048c-e24f-4539-8af2-63879971f6e1@lucifer.local>
In-Reply-To: <0f22048c-e24f-4539-8af2-63879971f6e1@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 3 Dec 2024 10:19:31 -0800
Message-ID: <CABi2SkW-AmkqooXDDFDTWV3FGJufqXJ19f03uEUSFbkZoQgV8A@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, enh@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:35=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Dec 02, 2024 at 12:38:27PM -0800, Jeff Xu wrote:
> > On Mon, Dec 2, 2024 at 10:29=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > > >
> > > > Those mappings are readonly or executable only, sealing can protect
> > > > them from ever changing or unmapped during the life time of the pro=
cess.
> > > > For complete descriptions of memory sealing, please see mseal.rst [=
1].
> > > >
> > > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > > generated by the kernel during program initialization, and are
> > > > sealed after creation.
> > > >
> > > > Unlike the aforementioned mappings, the uprobe mapping is not
> > > > established during program startup. However, its lifetime is the sa=
me
> > > > as the process's lifetime [2]. It is sealed from creation.
> > > >
> > > > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > > > _install_special_mapping() function. As no other mappings utilize t=
his
> > > > function, it is logical to incorporate sealing logic within
> > > > _install_special_mapping(). This approach avoids the necessity of
> > > > modifying code across various architecture-specific implementations=
.
> > > >
> > > > The vsyscall mapping, which has its own initialization function, is
> > > > sealed in the XONLY case, it seems to be the most common and secure
> > > > case of using vsyscall.
> > > >
> > > > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) =
may
> > > > alter the mapping of vdso, vvar, and sigpage during restore
> > > > operations. Consequently, this feature cannot be universally enable=
d
> > > > across all systems.
> > > >
> > > > Currently, memory sealing is only functional in a 64-bit kernel
> > > > configuration.
> > > >
> > > > To enable this feature, the architecture needs to be tested to
> > > > confirm that it doesn't unmap/remap system mappings during the
> > > > the life time of the process. After the architecture enables
> > > > ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> > > > CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> > > > Alternatively, kernel command line (exec.seal_system_mappings)
> > > > enables this feature also.
> > > >
> > > > This feature is tested using ChromeOS and Android on X86_64 and ARM=
64,
> > > > therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64=
.
> > > > Other architectures can enable this after testing. No specific hard=
ware
> > > > features from the CPU are needed.
> > > >
> > > > This feature's security enhancements will benefit ChromeOS, Android=
,
> > > > and other secure-by-default systems.
> > > >
> > > > [1] Documentation/userspace-api/mseal.rst
> > > > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM=
4XkRkL-NrCZxYAyg@mail.gmail.com/
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > ---
> > > >  .../admin-guide/kernel-parameters.txt         | 11 ++++++
> > > >  Documentation/userspace-api/mseal.rst         |  4 ++
> > > >  arch/arm64/Kconfig                            |  1 +
> > > >  arch/x86/Kconfig                              |  1 +
> > > >  arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
> > > >  include/linux/mm.h                            | 12 ++++++
> > > >  init/Kconfig                                  | 25 ++++++++++++
> > > >  mm/mmap.c                                     | 10 +++++
> > > >  mm/mseal.c                                    | 39 +++++++++++++++=
++++
> > > >  security/Kconfig                              | 24 ++++++++++++
> > > >  10 files changed, 133 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> > > > index e7bfe1bde49e..f63268341739 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -1538,6 +1538,17 @@
> > > >                       Permit 'security.evm' to be updated regardles=
s of
> > > >                       current integrity status.
> > > >
> > > > +     exec.seal_system_mappings =3D [KNL]
> > > > +                     Format: { no | yes }
> > > > +                     Seal system mappings: vdso, vvar, sigpage, vs=
yscall,
> > > > +                     uprobe.
> > > > +                     - 'no':  do not seal system mappings.
> > > > +                     - 'yes': seal system mappings.
> > > > +                     This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=3D=
(y/n)
> > > > +                     If not specified or invalid, default is the v=
alue set by
> > > > +                     CONFIG_SEAL_SYSTEM_MAPPINGS.
> > > > +                     This option has no effect if CONFIG_64BIT=3Dn
> > > > +
> > > >       early_page_ext [KNL,EARLY] Enforces page_ext initialization t=
o earlier
> > > >                       stages so cover more early boot allocations.
> > > >                       Please note that as side effect some optimiza=
tions
> > > > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/=
userspace-api/mseal.rst
> > > > index 41102f74c5e2..bec122318a59 100644
> > > > --- a/Documentation/userspace-api/mseal.rst
> > > > +++ b/Documentation/userspace-api/mseal.rst
> > > > @@ -130,6 +130,10 @@ Use cases
> > > >
> > > >  - Chrome browser: protect some security sensitive data structures.
> > > >
> > > > +- seal system mappings:
> > > > +  kernel config CONFIG_SEAL_SYSTEM_MAPPINGS seals system mappings =
such
> > > > +  as vdso, vvar, sigpage, uprobes and vsyscall.
> > > > +
> > > >  When not to use mseal
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >  Applications can apply sealing to any virtual memory region from u=
serspace,
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index 63de71544d95..fc5da8f74342 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -44,6 +44,7 @@ config ARM64
> > > >       select ARCH_HAS_SETUP_DMA_OPS
> > > >       select ARCH_HAS_SET_DIRECT_MAP
> > > >       select ARCH_HAS_SET_MEMORY
> > > > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > >       select ARCH_STACKWALK
> > > >       select ARCH_HAS_STRICT_KERNEL_RWX
> > > >       select ARCH_HAS_STRICT_MODULE_RWX
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index 1ea18662942c..5f6bac99974c 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -26,6 +26,7 @@ config X86_64
> > > >       depends on 64BIT
> > > >       # Options that are inherently 64-bit kernel only:
> > > >       select ARCH_HAS_GIGANTIC_PAGE
> > > > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > > >       select ARCH_SUPPORTS_PER_VMA_LOCK
> > > >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > > > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry=
/vsyscall/vsyscall_64.c
> > > > index 2fb7d53cf333..30e0958915ca 100644
> > > > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > > > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > > > @@ -366,8 +366,12 @@ void __init map_vsyscall(void)
> > > >               set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> > > >       }
> > > >
> > > > -     if (vsyscall_mode =3D=3D XONLY)
> > > > -             vm_flags_init(&gate_vma, VM_EXEC);
> > > > +     if (vsyscall_mode =3D=3D XONLY) {
> > > > +             unsigned long vm_flags =3D VM_EXEC;
> > > > +
> > > > +             vm_flags |=3D seal_system_mappings();
> > > > +             vm_flags_init(&gate_vma, vm_flags);
> > > > +     }
> > > >
> > > >       BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=3D
> > > >                    (unsigned long)VSYSCALL_ADDR);
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index df0a5eac66b7..f787d6c85cbb 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task=
_struct *t, unsigned long __user *st
> > > >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned l=
ong status);
> > > >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned =
long status);
> > > >
> > > > +#ifdef CONFIG_64BIT
> > > > +/*
> > > > + * return VM_SEALED if seal system mapping is enabled.
> > > > + */
> > > > +unsigned long seal_system_mappings(void);
> > > > +#else
> > > > +static inline unsigned long seal_system_mappings(void)
> > > > +{
> > > > +     return 0;
> > > > +}
> > >
> > > OK so we can set seal system mappings on a 32-bit system and
> > > silently... just not do it?...
> > >
> > I don't understand what you meant.
> >
> > The function returns the vm_flags for seal system mappings.
> > In 32 bit, it returns 0.
> >
> > the caller (in mmap.c) does below:
> > vm_flags |=3D seal_system_mappings();
> >
> > (The pattern is recommended by Liam. )
> >
> > Is that because the function name is misleading ? I can change it to
> > seal_flags_system_mappings() if there is no objection to the long
> > name.
>
> No, I'm saying that you're making it possible for somebody to enable this
> feature on a 32-bit system, and to think it's enabled and that they're
> protected when in fact they're not.
>
The kernel cmdline change already has comments about 32-bit:  see:
kernel-parameters.txt
"This option has no effect if CONFIG_64BIT=3Dn"

> Which is, security-wise, I think rather unwise.
>
> Again it's an argument against a cmdline parameter. See below.
>
> >
> > > > +#endif
> > > > +
> > > >  #endif /* _LINUX_MM_H */
> > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > index 1aa95a5dfff8..614719259aa0 100644
> > > > --- a/init/Kconfig
> > > > +++ b/init/Kconfig
> > > > @@ -1860,6 +1860,31 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> > > >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> > > >       bool
> > > >
> > > > +config ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > > +     bool
> > > > +     help
> > > > +       Control SEAL_SYSTEM_MAPPINGS access based on architecture.
> > > > +
> > > > +       A 64-bit kernel is required for the memory sealing feature.
> > > > +       No specific hardware features from the CPU are needed.
> > > > +
> > > > +       To enable this feature, the architecture needs to be tested=
 to
> > > > +       confirm that it doesn't unmap/remap system mappings during =
the
> > > > +       the life time of the process. After the architecture enable=
s this,
> > > > +       a distribution can set CONFIG_SEAL_SYSTEM_MAPPING to manage=
 access
> > > > +       to the feature.
> > > > +
> > > > +       The CONFIG_SEAL_SYSTEM_MAPPINGS already checks the CHECKPOI=
NT_RESTORE
> > > > +       feature, which is known to remap/unmap vdso.  Thus, the pre=
sence of
> > > > +       CHECKPOINT_RESTORE is not considered a factor in enabling
> > > > +       ARCH_HAS_SEAL_SYSTEM_MAPPINGS for a architecture.
> > > > +
> > > > +       For complete list of system mappings, please see
> > > > +       CONFIG_SEAL_SYSTEM_MAPPINGS.
> > > > +
> > > > +       For complete descriptions of memory sealing, please see
> > > > +       Documentation/userspace-api/mseal.rst
> > > > +
> > > >  config HAVE_PERF_EVENTS
> > > >       bool
> > > >       help
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 57fd5ab2abe7..bc694c555805 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapp=
ing(
> > > >       unsigned long addr, unsigned long len,
> > > >       unsigned long vm_flags, const struct vm_special_mapping *spec=
)
> > > >  {
> > > > +     /*
> > > > +      * At present, all mappings (vdso, vvar, sigpage, and uprobe)=
 that
> > > > +      * invoke the _install_special_mapping function can be sealed=
.
> > > > +      * Therefore, it is logical to call the seal_system_mappings_=
enabled()
> > > > +      * function here. In the future, if this is not the case, i.e=
. if certain
> > > > +      * mappings cannot be sealed, then it would be necessary to m=
ove this
> > > > +      * check to the calling function.
> > > > +      */
> > > > +     vm_flags |=3D seal_system_mappings();
> > > > +
> > > >       return __install_special_mapping(mm, addr, len, vm_flags, (vo=
id *)spec,
> > > >                                       &special_mapping_vmops);
> > > >  }
> > > > diff --git a/mm/mseal.c b/mm/mseal.c
> > > > index ece977bd21e1..80126d6231bb 100644
> > > > --- a/mm/mseal.c
> > > > +++ b/mm/mseal.c
> > > > @@ -7,6 +7,7 @@
> > > >   *  Author: Jeff Xu <jeffxu@chromium.org>
> > > >   */
> > > >
> > > > +#include <linux/fs_parser.h>
> > > >  #include <linux/mempolicy.h>
> > > >  #include <linux/mman.h>
> > > >  #include <linux/mm.h>
> > > > @@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, s=
ize_t, len, unsigned long,
> > > >  {
> > > >       return do_mseal(start, len, flags);
> > > >  }
> > > > +
> > > > +/*
> > > > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > > > + */
> > > > +enum seal_system_mappings_type {
> > > > +     SEAL_SYSTEM_MAPPINGS_DISABLED,
> > > > +     SEAL_SYSTEM_MAPPINGS_ENABLED
> > > > +};
> > > > +
> > > > +static enum seal_system_mappings_type seal_system_mappings_v __ro_=
after_init =3D
> > > > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPING=
S_ENABLED :
> > > > +     SEAL_SYSTEM_MAPPINGS_DISABLED;
> > > > +
> > > > +static const struct constant_table value_table_sys_mapping[] __ini=
tconst =3D {
> > > > +     { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > > > +     { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > > > +     { }
> > > > +};
> > > > +
> > > > +static int __init early_seal_system_mappings_override(char *buf)
> > > > +{
> > > > +     if (!buf)
> > > > +             return -EINVAL;
> > > > +
> > > > +     seal_system_mappings_v =3D lookup_constant(value_table_sys_ma=
pping,
> > > > +                     buf, seal_system_mappings_v);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +early_param("exec.seal_system_mappings", early_seal_system_mapping=
s_override);
> > > > +
> > > > +unsigned long seal_system_mappings(void)
> > > > +{
> > > > +     if (seal_system_mappings_v =3D=3D SEAL_SYSTEM_MAPPINGS_ENABLE=
D)
> > > > +             return VM_SEALED;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > diff --git a/security/Kconfig b/security/Kconfig
> > > > index 28e685f53bd1..5bbb8d989d79 100644
> > > > --- a/security/Kconfig
> > > > +++ b/security/Kconfig
> > > > @@ -51,6 +51,30 @@ config PROC_MEM_NO_FORCE
> > > >
> > > >  endchoice
> > > >
> > > > +config SEAL_SYSTEM_MAPPINGS
> > > > +     bool "seal system mappings"
> > >
> > > I'd prefer an 'mseal' here please, it's becoming hard to grep for thi=
s
> > > stuff. We overload 'seal' too much and I want to be able to identify =
what
> > > is a memfd seal and what is an mseal or whatever else...
> > >
> > I m OK with MSEAL_
>
> Thanks.
>
> >
> > > > +     default n
> > > > +     depends on 64BIT
> > > > +     depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > > +     depends on !CHECKPOINT_RESTORE
> > >
> > > I don't know why we bother setting restrictions on this but allow the=
m to
> > > be overriden with a boot flag?
> > >
> > The idea is a distribution might not enable kernel security features
> > by default, and kernel cmdline provides flexibility to let users
> > enable it.
> >
> > This is the same approach as  proc_mem.force_override kernel cmd line
> > where Kees recommended  [1], I would prefer to keep this as is.
> >
> > [1] https://lore.kernel.org/all/202402261110.B8129C002@keescook/
> >
>
> This is flawed on multiple levels. Firstly, from the linked change:
>
>         +config SECURITY_PROC_MEM_RESTRICT_WRITES
>         +       bool "Restrict /proc/<pid>/mem write access"
>         +       default n
>         +       help
>
> There are no 'depends on'. Yours has 'depends on' which you've just
> rendered totally irrelevant including _allowing the enabling of this
> feature in broken situations_ like CRIU, as I mentioned below.
>
> For another, the linked feature changes behaviour and a user may or may n=
ot
> want to allow the ability to write to /proc/<pid>/mem which is ENTIRELY
> DIFFERENT from this proposed feature.
>
> Under what circumstances could a user possibly want to write VVAR, VDSO,
> etc. etc.? It just makes absolutely no sense for this to be a boot switch=
.
>
> So the arguments presented there have zero bearing on this series.
>
> > > This means somebody with CRIU enabled could enable this and have a br=
oken
> > > kernel right? We can't allow that.
>
> Please do not ignore review comments like this.
>
kernel cmdline is a valid user case.   The reasoning is explained in
the previous response, it allows users to enable security features
without having to rebuild the distribution's kernel.

For the concern that CRIU user enables this feature through kernel
cmdline mistakenly, there is already instruction and comments
throughout code to make aware of the impact to CRIU after enabling
sealing for system-mapping. In my view: users who want to enable this
feature through kernel cmdline  should already have enough context
about this, i.e. it is an educated decision rather than experimenting.

That said, if we want to protect those CRIU users from mistakenly
enabling memory sealing,  we could add a check to verify CRIU is not
enabled, i.e. if CRIU is enabled, the kernel cmd line has no effect.
Although in my view  this is an extra complicity without meaningful
benefit -  If it is the user's educated choice, I prefer to honor it.



> > >
> > > I'd much prefer we either:
> > >
> > > 1. Just have a CONFIG_MSEAL_SYSTEM_MAPPINGS flag. _or_
> > > 2. Have CONFIG_MSEAL_SYSTEM_MAPPINGS enable, allow kernel flag to dis=
able.
> > >
> > > In both cases you #ifdef on CONFIG_MSEAL_SYSTEM_MAPPINGS, and the
> > > restrictions appply correctly.
> > >
> > > If in the future we decide this feature is stable and ready and good =
to
> > > enable globally we can just change the default on this to y at some l=
ater
> > > date?
> > >
> > > Otherwise it just seems like in a effect the kernel command line flag=
 is a
> > > debug flag to experiment on arbitrary kernels?
> > >
> > > > +     help
> > > > +       Seal system mappings such as vdso, vvar, sigpage, vsyscall,=
 uprobes.
> > > > +
> > > > +       A 64-bit kernel is required for the memory sealing feature.
> > > > +       No specific hardware features from the CPU are needed.
> > > > +
> > > > +       Depends on the ARCH_HAS_SEAL_SYSTEM_MAPPINGS.
> > > > +
> > > > +       CHECKPOINT_RESTORE might relocate vdso mapping during resto=
re,
> > > > +       and remap/unmap will fail when the mapping is sealed, there=
fore
> > > > +       !CHECKPOINT_RESTORE is added as dependency.
> > > > +
> > > > +       Kernel command line exec.seal_system_mappings=3D(no/yes) ov=
errides
> > > > +       this.
> > > > +
> > > > +       For complete descriptions of memory sealing, please see
> > > > +       Documentation/userspace-api/mseal.rst
> > > > +
> > > >  config SECURITY
> > > >       bool "Enable different security models"
> > > >       depends on SYSFS
> > > > --
> > > > 2.47.0.338.g60cca15819-goog
> > > >
