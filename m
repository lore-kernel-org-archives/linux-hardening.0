Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C3B1DE4C3
	for <linux-hardening@vger.kernel.org>; Mon,  2 Dec 2024 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171922; cv=none; b=Q9agrEbj+xHFVMdzBgOrzQFc5hc2StyrBXtqMGBSvEvvDOwl4wXfdmnMupfZuUyYXP02Fa5wohgI6BRDAcvnSjk3qwbb//9Vn4b3nP8+Axvdi4B+bKrnrK1qqpfBbDn8Iz+nB4+CKmDvtwG6GKfBwbSImuIFxx+3h1Zj1wNlSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171922; c=relaxed/simple;
	bh=9xmP2eTmMplUnhynevEPpU0cKpNPiGHzOuGo+r0uphs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klNIilVKwtCP4DyxqOMrBUQl78vkDSGK+bceOaN6lot5Yo4BjID/+m1Ldik71UMx3OTNX3QojXafCHps45fcvm3K85TScnX+ngBL8GLC0Zb4O/1C0qt8FTv9GxHJX6bA1dAFZgg6y3d2/c8qgVB6e27ZmquN45aNVy7ZRc/7lFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MbO32fcd; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MbO32fcd"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f1ee547352so373680eaf.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Dec 2024 12:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733171919; x=1733776719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0X6OEIkVtg8mglQu3l9vojDOVfcsAHFlpXbtqGqML0=;
        b=MbO32fcdRIwYICN4Dj/9GsxwQAG2hp7fqb7EkZN0jX2dvKEphSUscgLctVNZp0qne9
         XlLcaeD0sbutDGZXaJ2E+qgUBCOa8FA6iPijYGKMTuEsA+RXOjFFRKf/K97uCeohSAhS
         V4MPCxzioa61fLVxNcKr2R7+t8qTR+ucm2DPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733171919; x=1733776719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0X6OEIkVtg8mglQu3l9vojDOVfcsAHFlpXbtqGqML0=;
        b=Jm6MtIsdCLj2wUUtuSIxb9o98yXsahV1hRmos7x83maLVV3k9YFmYzN8xjSztGPAxV
         XvxRFo9kzBKokYa9Ka3koCI5cxYGnIGN2veOTP3BDk4s8tibpQf8Hi4bXXvaLnQzTG7s
         k7AjNUYw7p+jF5KZoK548CTTE4ULPyp3clYvrExIuY5cNkgAA/jep/GH5mBtd3faOJ8w
         L2qYNNX4+c34EM875SMx9T1/aPF65n9V3X5xq8fw4VXqb9pcQ1MdBrJAqOFBHpv6y81B
         ayHBbWoKUaSp2fRdrCAnkEHt08R8Cuwv3YN5Az2sphzUOamMP/RcandiHu7FGH1IC9BW
         TxAA==
X-Forwarded-Encrypted: i=1; AJvYcCXja2WN9wa1TsNunFQJj9MnHkkFWuD/DaItmWrn+2o4A7grJ+7obhkaE77bM9lwlMuA2JBA38dEfwfdKeq/53M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hgU7ZvfL0pdwlFKc0UgyNSZhZAAi9H+nCunOY4IxIuYDqr/+
	EYYPr2Spyl3Ipqv6i8MFEmCZOuQepl4D28EzfvO7GJz/X/FGgfBUVLoNcbmEruaIR1UczNYwQfr
	7gA3Sm2ML4jtteEx3bOLDAyYl2cdE/PKH1GjW
X-Gm-Gg: ASbGncvnQ5+8j/obTy1pqrev7DNoFkLdM49roc6r1VlQ604f47rxC9NxVAKv2QLgJAW
	E/f3dWacWmz1FSCYaqzTEZsboMDVLlln+DUoKaC/7spbTWsgVA6VYnPuh5Zed
X-Google-Smtp-Source: AGHT+IH1/VptVzBQX3IBzQRHqBJGb4fybvSD2MG77swvKst1nw/Brqs4C5o3lOQSMY2zT77xZG5Fr6iQkk8F216vdk4=
X-Received: by 2002:a05:6820:54f:b0:5f1:e1a8:ff4c with SMTP id
 006d021491bc7-5f20a11ffd6mr4779754eaf.1.1733171918838; Mon, 02 Dec 2024
 12:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <ce2bd3dc-e7aa-41b4-9d57-2cc683b5659f@lucifer.local>
In-Reply-To: <ce2bd3dc-e7aa-41b4-9d57-2cc683b5659f@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 2 Dec 2024 12:38:27 -0800
Message-ID: <CABi2SkUFCqy0pWfrOcfC0a0GMVpFODtb=Hunw6WW1D5N-A_MXw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:29=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing or unmapped during the life time of the process=
.
> > For complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization, and are
> > sealed after creation.
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [2]. It is sealed from creation.
> >
> > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > _install_special_mapping() function. As no other mappings utilize this
> > function, it is logical to incorporate sealing logic within
> > _install_special_mapping(). This approach avoids the necessity of
> > modifying code across various architecture-specific implementations.
> >
> > The vsyscall mapping, which has its own initialization function, is
> > sealed in the XONLY case, it seems to be the most common and secure
> > case of using vsyscall.
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the mapping of vdso, vvar, and sigpage during restore
> > operations. Consequently, this feature cannot be universally enabled
> > across all systems.
> >
> > Currently, memory sealing is only functional in a 64-bit kernel
> > configuration.
> >
> > To enable this feature, the architecture needs to be tested to
> > confirm that it doesn't unmap/remap system mappings during the
> > the life time of the process. After the architecture enables
> > ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> > CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> > Alternatively, kernel command line (exec.seal_system_mappings)
> > enables this feature also.
> >
> > This feature is tested using ChromeOS and Android on X86_64 and ARM64,
> > therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
> > Other architectures can enable this after testing. No specific hardware
> > features from the CPU are needed.
> >
> > This feature's security enhancements will benefit ChromeOS, Android,
> > and other secure-by-default systems.
> >
> > [1] Documentation/userspace-api/mseal.rst
> > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 11 ++++++
> >  Documentation/userspace-api/mseal.rst         |  4 ++
> >  arch/arm64/Kconfig                            |  1 +
> >  arch/x86/Kconfig                              |  1 +
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
> >  include/linux/mm.h                            | 12 ++++++
> >  init/Kconfig                                  | 25 ++++++++++++
> >  mm/mmap.c                                     | 10 +++++
> >  mm/mseal.c                                    | 39 +++++++++++++++++++
> >  security/Kconfig                              | 24 ++++++++++++
> >  10 files changed, 133 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index e7bfe1bde49e..f63268341739 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1538,6 +1538,17 @@
> >                       Permit 'security.evm' to be updated regardless of
> >                       current integrity status.
> >
> > +     exec.seal_system_mappings =3D [KNL]
> > +                     Format: { no | yes }
> > +                     Seal system mappings: vdso, vvar, sigpage, vsysca=
ll,
> > +                     uprobe.
> > +                     - 'no':  do not seal system mappings.
> > +                     - 'yes': seal system mappings.
> > +                     This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=3D(y/n=
)
> > +                     If not specified or invalid, default is the value=
 set by
> > +                     CONFIG_SEAL_SYSTEM_MAPPINGS.
> > +                     This option has no effect if CONFIG_64BIT=3Dn
> > +
> >       early_page_ext [KNL,EARLY] Enforces page_ext initialization to ea=
rlier
> >                       stages so cover more early boot allocations.
> >                       Please note that as side effect some optimization=
s
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > index 41102f74c5e2..bec122318a59 100644
> > --- a/Documentation/userspace-api/mseal.rst
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -130,6 +130,10 @@ Use cases
> >
> >  - Chrome browser: protect some security sensitive data structures.
> >
> > +- seal system mappings:
> > +  kernel config CONFIG_SEAL_SYSTEM_MAPPINGS seals system mappings such
> > +  as vdso, vvar, sigpage, uprobes and vsyscall.
> > +
> >  When not to use mseal
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  Applications can apply sealing to any virtual memory region from users=
pace,
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 63de71544d95..fc5da8f74342 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -44,6 +44,7 @@ config ARM64
> >       select ARCH_HAS_SETUP_DMA_OPS
> >       select ARCH_HAS_SET_DIRECT_MAP
> >       select ARCH_HAS_SET_MEMORY
> > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> >       select ARCH_STACKWALK
> >       select ARCH_HAS_STRICT_KERNEL_RWX
> >       select ARCH_HAS_STRICT_MODULE_RWX
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 1ea18662942c..5f6bac99974c 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -26,6 +26,7 @@ config X86_64
> >       depends on 64BIT
> >       # Options that are inherently 64-bit kernel only:
> >       select ARCH_HAS_GIGANTIC_PAGE
> > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >       select ARCH_SUPPORTS_PER_VMA_LOCK
> >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsy=
scall/vsyscall_64.c
> > index 2fb7d53cf333..30e0958915ca 100644
> > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > @@ -366,8 +366,12 @@ void __init map_vsyscall(void)
> >               set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> >       }
> >
> > -     if (vsyscall_mode =3D=3D XONLY)
> > -             vm_flags_init(&gate_vma, VM_EXEC);
> > +     if (vsyscall_mode =3D=3D XONLY) {
> > +             unsigned long vm_flags =3D VM_EXEC;
> > +
> > +             vm_flags |=3D seal_system_mappings();
> > +             vm_flags_init(&gate_vma, vm_flags);
> > +     }
> >
> >       BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=3D
> >                    (unsigned long)VSYSCALL_ADDR);
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index df0a5eac66b7..f787d6c85cbb 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_str=
uct *t, unsigned long __user *st
> >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long =
status);
> >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long=
 status);
> >
> > +#ifdef CONFIG_64BIT
> > +/*
> > + * return VM_SEALED if seal system mapping is enabled.
> > + */
> > +unsigned long seal_system_mappings(void);
> > +#else
> > +static inline unsigned long seal_system_mappings(void)
> > +{
> > +     return 0;
> > +}
>
> OK so we can set seal system mappings on a 32-bit system and
> silently... just not do it?...
>
I don't understand what you meant.

The function returns the vm_flags for seal system mappings.
In 32 bit, it returns 0.

the caller (in mmap.c) does below:
vm_flags |=3D seal_system_mappings();

(The pattern is recommended by Liam. )

Is that because the function name is misleading ? I can change it to
seal_flags_system_mappings() if there is no objection to the long
name.

> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 1aa95a5dfff8..614719259aa0 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1860,6 +1860,31 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > +     bool
> > +     help
> > +       Control SEAL_SYSTEM_MAPPINGS access based on architecture.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       To enable this feature, the architecture needs to be tested to
> > +       confirm that it doesn't unmap/remap system mappings during the
> > +       the life time of the process. After the architecture enables th=
is,
> > +       a distribution can set CONFIG_SEAL_SYSTEM_MAPPING to manage acc=
ess
> > +       to the feature.
> > +
> > +       The CONFIG_SEAL_SYSTEM_MAPPINGS already checks the CHECKPOINT_R=
ESTORE
> > +       feature, which is known to remap/unmap vdso.  Thus, the presenc=
e of
> > +       CHECKPOINT_RESTORE is not considered a factor in enabling
> > +       ARCH_HAS_SEAL_SYSTEM_MAPPINGS for a architecture.
> > +
> > +       For complete list of system mappings, please see
> > +       CONFIG_SEAL_SYSTEM_MAPPINGS.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config HAVE_PERF_EVENTS
> >       bool
> >       help
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 57fd5ab2abe7..bc694c555805 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapping(
> >       unsigned long addr, unsigned long len,
> >       unsigned long vm_flags, const struct vm_special_mapping *spec)
> >  {
> > +     /*
> > +      * At present, all mappings (vdso, vvar, sigpage, and uprobe) tha=
t
> > +      * invoke the _install_special_mapping function can be sealed.
> > +      * Therefore, it is logical to call the seal_system_mappings_enab=
led()
> > +      * function here. In the future, if this is not the case, i.e. if=
 certain
> > +      * mappings cannot be sealed, then it would be necessary to move =
this
> > +      * check to the calling function.
> > +      */
> > +     vm_flags |=3D seal_system_mappings();
> > +
> >       return __install_special_mapping(mm, addr, len, vm_flags, (void *=
)spec,
> >                                       &special_mapping_vmops);
> >  }
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index ece977bd21e1..80126d6231bb 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -7,6 +7,7 @@
> >   *  Author: Jeff Xu <jeffxu@chromium.org>
> >   */
> >
> > +#include <linux/fs_parser.h>
> >  #include <linux/mempolicy.h>
> >  #include <linux/mman.h>
> >  #include <linux/mm.h>
> > @@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, size_=
t, len, unsigned long,
> >  {
> >       return do_mseal(start, len, flags);
> >  }
> > +
> > +/*
> > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > + */
> > +enum seal_system_mappings_type {
> > +     SEAL_SYSTEM_MAPPINGS_DISABLED,
> > +     SEAL_SYSTEM_MAPPINGS_ENABLED
> > +};
> > +
> > +static enum seal_system_mappings_type seal_system_mappings_v __ro_afte=
r_init =3D
> > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_EN=
ABLED :
> > +     SEAL_SYSTEM_MAPPINGS_DISABLED;
> > +
> > +static const struct constant_table value_table_sys_mapping[] __initcon=
st =3D {
> > +     { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > +     { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > +     { }
> > +};
> > +
> > +static int __init early_seal_system_mappings_override(char *buf)
> > +{
> > +     if (!buf)
> > +             return -EINVAL;
> > +
> > +     seal_system_mappings_v =3D lookup_constant(value_table_sys_mappin=
g,
> > +                     buf, seal_system_mappings_v);
> > +     return 0;
> > +}
> > +
> > +early_param("exec.seal_system_mappings", early_seal_system_mappings_ov=
erride);
> > +
> > +unsigned long seal_system_mappings(void)
> > +{
> > +     if (seal_system_mappings_v =3D=3D SEAL_SYSTEM_MAPPINGS_ENABLED)
> > +             return VM_SEALED;
> > +
> > +     return 0;
> > +}
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 28e685f53bd1..5bbb8d989d79 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,30 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +config SEAL_SYSTEM_MAPPINGS
> > +     bool "seal system mappings"
>
> I'd prefer an 'mseal' here please, it's becoming hard to grep for this
> stuff. We overload 'seal' too much and I want to be able to identify what
> is a memfd seal and what is an mseal or whatever else...
>
I m OK with MSEAL_

> > +     default n
> > +     depends on 64BIT
> > +     depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > +     depends on !CHECKPOINT_RESTORE
>
> I don't know why we bother setting restrictions on this but allow them to
> be overriden with a boot flag?
>
The idea is a distribution might not enable kernel security features
by default, and kernel cmdline provides flexibility to let users
enable it.

This is the same approach as  proc_mem.force_override kernel cmd line
where Kees recommended  [1], I would prefer to keep this as is.

[1] https://lore.kernel.org/all/202402261110.B8129C002@keescook/

> This means somebody with CRIU enabled could enable this and have a broken
> kernel right? We can't allow that.
>
> I'd much prefer we either:
>
> 1. Just have a CONFIG_MSEAL_SYSTEM_MAPPINGS flag. _or_
> 2. Have CONFIG_MSEAL_SYSTEM_MAPPINGS enable, allow kernel flag to disable=
.
>
> In both cases you #ifdef on CONFIG_MSEAL_SYSTEM_MAPPINGS, and the
> restrictions appply correctly.
>
> If in the future we decide this feature is stable and ready and good to
> enable globally we can just change the default on this to y at some later
> date?
>
> Otherwise it just seems like in a effect the kernel command line flag is =
a
> debug flag to experiment on arbitrary kernels?
>
> > +     help
> > +       Seal system mappings such as vdso, vvar, sigpage, vsyscall, upr=
obes.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       Depends on the ARCH_HAS_SEAL_SYSTEM_MAPPINGS.
> > +
> > +       CHECKPOINT_RESTORE might relocate vdso mapping during restore,
> > +       and remap/unmap will fail when the mapping is sealed, therefore
> > +       !CHECKPOINT_RESTORE is added as dependency.
> > +
> > +       Kernel command line exec.seal_system_mappings=3D(no/yes) overri=
des
> > +       this.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config SECURITY
> >       bool "Enable different security models"
> >       depends on SYSFS
> > --
> > 2.47.0.338.g60cca15819-goog
> >
