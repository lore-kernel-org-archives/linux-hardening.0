Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811514AD24
	for <linux-hardening@vger.kernel.org>; Tue, 19 Nov 2024 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060189; cv=none; b=bG1QBorLxBBYCy33wn0YdFQvQSLp74wpcK4tPaz5+23kOQNd/ifXke8RgmcpWjZnmvtBLX4U83u67/5Jjs6MIdus4ppFfpg9tzh1vfe7WMDzWnOBCDXwMF71f4Z79d77pZMGbUaEa8RKI+DvTpK6+0rc9Fj9jjzpdiWAIAppImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060189; c=relaxed/simple;
	bh=3Ukx6PK8AG1bI+VgmAEZX+5dgIZ8O9s9Qbcc+IfF5iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F96/oX72ZeIKZNZE+vT+NXjXIUKneRBzsU8uiy/Vx4fxRScWIw4mwmwR9IIf0jNNyWvm9MkVGe0XM9mmLFdnSYrvzBw9xuKcZuIOnZ5EB1fNC+pH+GS4O79FHHaHSU3p4JVipNEaT71uE83cafwz1Vm3tV8JE3zKuFDFlK5SZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ApQd3HBK; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ApQd3HBK"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e6095eab45so257165b6e.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 Nov 2024 15:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732060186; x=1732664986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5iheQODuTvu37VA0qmjd17458UC/wtiE8myRuiuf4A=;
        b=ApQd3HBKyG0IMACoFWmfPSECJjKGcvhvCTPIIBpw1ZimafPhz7hl3BpeQJXs50W7eZ
         8egUl1W0GCo3qMrfTTv+MKWNSIhq5UrTXVR/uFQ93Ok5a4Gx+atFPCo1oAxxrS8mukMY
         zrV+ixXpf3NFwVgaeTQfP6MLhrsW5WTt0Eyog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732060186; x=1732664986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5iheQODuTvu37VA0qmjd17458UC/wtiE8myRuiuf4A=;
        b=sYpIf/ZsIk38R3/3Wfpj4Zpjjp+atGb7RIfvvc61bJcDMixZsibsJxTRkuDTIxrUy1
         0LMJYmBb25dVkys4V6d/69Ab7VHedGcPeVMIPBEKNWegUaSy22c5BvSANTv0n0ya4exv
         Agma0htSoGGPOfvXYnJlCNzPWSQJ5rlQIdydwwmBWAekWY5zzORbObNqfPx6x4EXYADW
         Ik6jSjuewdDBCEzrIC1sy9VidTvflMR3ef1vsuJzo3Rz4FfPm85swLRq4yystPakXl0y
         TtJlx0M75a7NQYboegDaTk7XCXLCaIoumALu0U4xF3fFHJqO5xKbUa6Mn4tXBqNp4QXF
         dXyw==
X-Forwarded-Encrypted: i=1; AJvYcCU3q4KToPLMe50BlN5Hu2pYVgDSgGPwH24QxaoXKTL1+1wbEzG882Y9lSDGWBmFUfbkIWnLGtmw5V5gsvwNbx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk5qRYDwri+grhNGwS7bLmvW9mF8SeaC7AynVGuP26wnm7f247
	gimLgTLzFlCYxqRmS1MWxKILhFkjjnHJ1lpyDe+wOZ3Tj+JsRgj2/Vtz44+7Wvs/iemoVXAzN9/
	0gKabarR7onvrtdHHOH7Lma03coX/xOdYpchY
X-Gm-Gg: ASbGnctkX+DxGCFWfayRlu/uNijOl1KnPc3BaawvuysQFvEO1nkMCFFscwlZKNb1Jhw
	KhRiGesrMx6UIJFYJ+OEQ5ShvHqaJn3pmRP65CFJm/FnQbYXOUFWjWuotXkFU
X-Google-Smtp-Source: AGHT+IHD31QPNsbvkVhw5i8KrguJ2U7sdB7qpTdgMRr/hV5KyjzGtEb0LlJ573XxGhkwH8vOMD2IjByodRbLD/sUBtU=
X-Received: by 2002:a05:6871:e417:b0:27b:b2e0:6af with SMTP id
 586e51a60fabf-296d9b159dcmr180047fac.2.1732060186511; Tue, 19 Nov 2024
 15:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113191602.3541870-1-jeffxu@google.com> <20241113191602.3541870-2-jeffxu@google.com>
 <d3f61d89-77de-42e7-b16b-e5b1031ac8bc@lucifer.local>
In-Reply-To: <d3f61d89-77de-42e7-b16b-e5b1031ac8bc@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 19 Nov 2024 15:49:35 -0800
Message-ID: <CABi2SkUEd5xPhghhgYCTN_dG4aG0yE6-2dfVHPT+E+CP-C6tjw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] exec: seal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
	groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Wed, Nov 13, 2024 at 12:47=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> I'd prefer not to move forward with this until we have confirmation that
> adequate testing has been performed, given how invasive this change is,
> even if behind a flag (unless we explicitly mention it is untested in the
> Kconfig).
>
> We are touching arch-specific stuff with VDSO, VVAR, etc. so we need to b=
e
> cautious when we're in effect hooking an arch-specific function in mm.
>
> Other than that, the actual patch isn't too crazy overall.
>
> I think a sensible approach might be to only enable on known-good arches.
>
I responded to this in the other email where you raised the same point.

> On Wed, Nov 13, 2024 at 07:16:02PM +0000, jeffxu@chromium.org wrote:
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
> > as the process's lifetime [1]. It is sealed from creation.
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
> > across all systems. To address this, a kernel configuration option has
> > been introduced to enable or disable this functionality.
> >
> > [1] Documentation/userspace-api/mseal.rst
>
> It'd be nice to explicitly refer to this in the docs, it's not quite urge=
nt
> though would be nice to be part of this series.
>
will update mseal.rst next version.

> > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 10 +++++
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 ++++-
> >  include/linux/mm.h                            | 12 ++++++
> >  mm/mmap.c                                     | 10 +++++
> >  mm/mseal.c                                    | 39 +++++++++++++++++++
> >  security/Kconfig                              | 11 ++++++
> >  6 files changed, 89 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index e7bfe1bde49e..469a65b3cf50 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1538,6 +1538,16 @@
> >                       Permit 'security.evm' to be updated regardless of
> >                       current integrity status.
> >
> > +     exec.seal_system_mappings =3D [KNL]
> > +                     Format: { no | yes }
> > +                     Seal system mappings: vdso, vvar, sigpage, vsysca=
ll,
> > +                     uprobe.
> > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPIN=
GS
> > +                     - 'no':  do not seal system mappings.
> > +                     - 'yes': seal system mappings.
> > +                     If not specified or invalid, default is the KCONF=
IG value.
> > +                     This option has no effect if CONFIG_64BIT=3Dn
>
> Or if CONFIG_CHECKPOINT_RESTORE is not set. Please update to reference th=
is
> also.
>
I will update this part. Liam has a similar comment.

> > +
> >       early_page_ext [KNL,EARLY] Enforces page_ext initialization to ea=
rlier
> >                       stages so cover more early boot allocations.
> >                       Please note that as side effect some optimization=
s
> > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsy=
scall/vsyscall_64.c
> > index 2fb7d53cf333..185553376f39 100644
> > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > @@ -366,8 +366,13 @@ void __init map_vsyscall(void)
> >               set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> >       }
> >
> > -     if (vsyscall_mode =3D=3D XONLY)
> > -             vm_flags_init(&gate_vma, VM_EXEC);
> > +     if (vsyscall_mode =3D=3D XONLY) {
> > +             unsigned long vm_flags =3D VM_EXEC;
> > +
> > +             vm_flags |=3D seal_system_mappings();
> > +
> > +             vm_flags_init(&gate_vma, vm_flags);
>
> Nit: remove weird whitespace above. Also might be worth adding a comment =
as
> to what we're doing here similar to the one in _install_special_mapping()=
.
>
Done.

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
> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
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
>
> Nice comment!
>
> > +     vm_flags |=3D seal_system_mappings();
> > +
> >       return __install_special_mapping(mm, addr, len, vm_flags, (void *=
)spec,
> >                                       &special_mapping_vmops);
> >  }
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index ece977bd21e1..0a9d1e9faa28 100644
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
> > + * Kernel cmdline overwrite for CONFIG_SEAL_SYSTEM_MAPPINGS
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
> > index 28e685f53bd1..63b87a218943 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,17 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +config SEAL_SYSTEM_MAPPINGS
> > +     bool "seal system mappings"
> > +     default n
> > +     depends on 64BIT
> > +     depends on !CHECKPOINT_RESTORE
>
> Would prefer to depend on actually tested architectures only.
>
I responded in the other email where you raised the same point.

Thanks for reviewing

-Jeff

> > +     help
> > +       Seal system mappings such as vdso, vvar, sigpage, vsyscall, upr=
obes.
> > +       Note: CHECKPOINT_RESTORE might relocate vdso mapping during res=
tore,
> > +       and remap will fail if the mapping is sealed, therefore
> > +       !CHECKPOINT_RESTORE is added as dependency.
> > +
> >  config SECURITY
> >       bool "Enable different security models"
> >       depends on SYSFS
> > --
> > 2.47.0.277.g8800431eea-goog
> >
