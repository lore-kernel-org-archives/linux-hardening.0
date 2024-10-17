Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641018641
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136597; cv=none; b=CXbUMUwd3mWkxoNxqMp2hZZ/Ml4C+rVAsz1EL1/e7YwdQzeccpAVosYY81gf8w5YdKxA1SmsQdAarknVe3XIp4WgPIcORSHRhv1LHvTGApHFU0ylzjVM3yjS5pcJONkTuHPLrof9aTaN5URIyem3cPVSQ2Ded6Os+cMqPgfwXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136597; c=relaxed/simple;
	bh=yrnbPCiSsrZZgZYBtxcFt2bgcDeFUYXe6Dpt6KfrYtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Uvux+28iZ/PpWCckuhcpBJOsLxtMa3mZ2mhYPaGH+6qKba2oQk1BXYOzt9CrMX2QyZ+AH0nTb2MM3oxZFB2a+vwfqAZ+piz9wQkCGBFKpsJiQxbMbgyXm5K5sUNZLGbiczai4mWYedNOJ5eIhwxnI2W4ZdaRgRN2+JdDAGcL6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yhcy9D7y; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yhcy9D7y"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5eb644561ecso21443eaf.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Oct 2024 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729136595; x=1729741395; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2Yz5mj+Rbj1K0ofec49O0C3W0tcEFu1ZJqWT+jEV9A=;
        b=Yhcy9D7yBQslEANZJuRJz0yMX0uBMYruKEb8nZpCGY8XNa45dXVHeEM8Tk17m271Kw
         7KJ5Mvo1LnuBHTq5w4dpKgkVM/sqLRkZpBTwDOAvEBXPl+1PjY8TZdzcG2UC4I9+PDqs
         fRBdiBDDUFJWsq3QC2DeNTPHadNEX7YW4xLlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729136595; x=1729741395;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2Yz5mj+Rbj1K0ofec49O0C3W0tcEFu1ZJqWT+jEV9A=;
        b=YYm3q/tX0Kj6sOwxlVVaFVwGApJN/pf8yIslTe4WvTPdcAjZr4syk2MGorP5mmbwLY
         NFktQ25YCEV/EsVIbZCyYfZmpsJpFAQrdrSCJpDhYFaFU1jRNXt2/QA4Egt4pb2Tv+tB
         RAedEv1BlxTB4Xl/9JcIcbZ2e6aAGRwLFNfVuNymSgJNth6HHiPZqrIVcDbBK/xl6KBO
         qfC6ZXonkPjpEu7Wgm02UffRVVKje/VMZjZdUwRKDN3YXjYaWxVYxkvO/7jJjCMKAABr
         ZPBRAdiVEQht/sM/5qizH+YcfePzT42brSeThCWUUxRLmjql5beRDT0cqrT59V80eA36
         MjLA==
X-Forwarded-Encrypted: i=1; AJvYcCV5IyZ1bIXiGsZmGw3iQlCcwa90jTm8B89kEGPqkzkW8CRZOt9vULnagJdRn2pareXzIC2ExQFP/ohuZeNHa/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUe9zgP/FM9/X1UHmgPaRCWeYyn0Qp0DoMxSmdJyX+R2D3Yr/
	ba/Wl4YyZQDEPlrqV6Kk+iK9PjPXiz13uSgYOufPkAae1zEFIRe8ZM1I2sUFBBwhMKlyFtI5R4K
	lb26Icno4BeHQkFjujTT/B/TJyxRwFGq4rt42
X-Google-Smtp-Source: AGHT+IFIDwAMziEhtxc5Z3IqIkm/cNDE2Wqi7oMxVyC4pSWiLeauh/2ofoov3ZF4ZqPNUp5m2v24KlhvxjrxavNvb3k=
X-Received: by 2002:a05:6870:c386:b0:288:2955:3efb with SMTP id
 586e51a60fabf-2890c6ce2f0mr480823fac.8.1729136594968; Wed, 16 Oct 2024
 20:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014215022.68530-1-jeffxu@google.com> <20241014215022.68530-2-jeffxu@google.com>
 <6r5sxlhfujr2expiscsfpdjtraqlvy6k3cznmv25lo6usmyw7x@igmuywngc5xi>
In-Reply-To: <6r5sxlhfujr2expiscsfpdjtraqlvy6k3cznmv25lo6usmyw7x@igmuywngc5xi>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 16 Oct 2024 20:43:02 -0700
Message-ID: <CABi2SkUfXrRLg7+ZrLjMEQzh4FtU0EAfckdiDuza1mFKzi0SAg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 6:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> > +     exec.seal_system_mappings =3D [KNL]
> > +                     Format: { never | always }
> > +                     Seal system mappings: vdso, vvar, sigpage, uprobe=
s,
> > +                     vsyscall.
> > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPIN=
GS_*
> > +                     - 'never':  never seal system mappings.
>
> Not true, uprobes are sealed when 'never' is selected.
>
Thanks. I forgot to uprobes from the description in Kconfig and
kernel-parameters.txt, will update.

> > +                     - 'always': always seal system mappings.
> > +                     If not specified or invalid, default is the KCONF=
IG value.
> > +                     This option has no effect if CONFIG_64BIT=3Dn
> > +
> >       early_page_ext [KNL,EARLY] Enforces page_ext initialization to ea=
rlier
> >                       stages so cover more early boot allocations.
> >                       Please note that as side effect some optimization=
s
> > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsy=
scall/vsyscall_64.c
> > index 2fb7d53cf333..20a3000550d2 100644
> > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/mm_types.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/ratelimit.h>
> > +#include <linux/fs.h>
> >
> >  #include <asm/vsyscall.h>
> >  #include <asm/unistd.h>
> > @@ -366,8 +367,12 @@ void __init map_vsyscall(void)
> >               set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> >       }
> >
> > -     if (vsyscall_mode =3D=3D XONLY)
> > -             vm_flags_init(&gate_vma, VM_EXEC);
> > +     if (vsyscall_mode =3D=3D XONLY) {
> > +             unsigned long vm_flags =3D VM_EXEC;
> > +
> > +             update_seal_exec_system_mappings(&vm_flags);
> > +             vm_flags_init(&gate_vma, vm_flags);
> > +     }
> >
> >       BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=3D
> >                    (unsigned long)VSYSCALL_ADDR);
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 77364806b48d..5030879cda47 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
>
> Does it make sense for this to live in exec?  Couldn't you put it in the
> mm/mseal.c file?  It's vma flags for mappings and you've put it in
> fs/exec?
>
If you are referring to utilities related to kernel cmdline, they
should be in this file.

> > @@ -68,6 +68,7 @@
> >  #include <linux/user_events.h>
> >  #include <linux/rseq.h>
> >  #include <linux/ksm.h>
> > +#include <linux/fs_parser.h>
> >
> >  #include <linux/uaccess.h>
> >  #include <asm/mmu_context.h>
> > @@ -2159,3 +2160,55 @@ fs_initcall(init_fs_exec_sysctls);
> >  #ifdef CONFIG_EXEC_KUNIT_TEST
> >  #include "tests/exec_kunit.c"
> >  #endif
> > +
> > +#ifdef CONFIG_64BIT
> > +/*
> > + * Kernel cmdline overwrite for CONFIG_SEAL_SYSTEM_MAPPINGS_X
> > + */
> > +enum seal_system_mappings_type {
> > +     SEAL_SYSTEM_MAPPINGS_NEVER,
> > +     SEAL_SYSTEM_MAPPINGS_ALWAYS
> > +};
> > +
> > +static enum seal_system_mappings_type seal_system_mappings __ro_after_=
init =3D
> > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS) ? SEAL_SYSTEM_MAPP=
INGS_ALWAYS :
> > +     SEAL_SYSTEM_MAPPINGS_NEVER;
> > +
> > +static const struct constant_table value_table_sys_mapping[] __initcon=
st =3D {
> > +     { "never", SEAL_SYSTEM_MAPPINGS_NEVER},
> > +     { "always", SEAL_SYSTEM_MAPPINGS_ALWAYS},
> > +     { }
> > +};
> > +
> > +static int __init early_seal_system_mappings_override(char *buf)
> > +{
> > +     if (!buf)
> > +             return -EINVAL;
> > +
> > +     seal_system_mappings =3D lookup_constant(value_table_sys_mapping,
> > +                     buf, seal_system_mappings);
> > +
> > +     return 0;
> > +}
> > +
> > +early_param("exec.seal_system_mappings", early_seal_system_mappings_ov=
erride);
> > +
> > +static bool seal_system_mappings_enabled(void)
> > +{
> > +     if (seal_system_mappings =3D=3D SEAL_SYSTEM_MAPPINGS_ALWAYS)
> > +             return true;
> > +
> > +     return false;
> > +}
>
> This function seems unnecessary, it is called from another 3-4 line
> function only.
>
It is more readable this way.

> > +
> > +void update_seal_exec_system_mappings(unsigned long *vm_flags)
> > +{
> > +     if (!(*vm_flags & VM_SEALED) && seal_system_mappings_enabled())
>
> Why !(*vm_flags & VM_SEALED) here?
>
If vm_flags is already sealed, then there is no need to check
seal_system_mappings_enabled.

> > +             *vm_flags |=3D VM_SEALED;
> > +
> > +}
>
> Instead of passing a pointer around and checking enabled, why don't you
> have a function that just returns the VM_SEALED or 0 and just or it into
> the flags?  This seems very heavy for what it does, why did you do it
> this way?
>
Why is that heavy ? passing a pointer for updating variables is natural.

> The name is also very long and a bit odd, it could be used for other
> reasons, but you have _system_mappings on the end, and you use seal but
> it's mseal (or vm_seal)?  Would mseal_flag() work?
>
It could be longer :-)
 it means update_sealing_flag_for_executable_system_mappings.
mseal_flag is too short and not descriptive.

> > +#else
> > +void update_seal_exec_system_mappings(unsigned long *vm_flags)
> > +{
> > +}
> > +#endif /* CONFIG_64BIT */
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 42444ec95c9b..6e44aca4b24b 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
>
> Again, I don't understand why fs.h is the place for mseal definitions?
>
include/linux/fs.h contains other exec related function signatures. So
it is better to keep them at the same header.

> > @@ -3079,6 +3079,7 @@ ssize_t __kernel_read(struct file *file, void *bu=
f, size_t count, loff_t *pos);
> >  extern ssize_t kernel_write(struct file *, const void *, size_t, loff_=
t *);
> >  extern ssize_t __kernel_write(struct file *, const void *, size_t, lof=
f_t *);
> >  extern struct file * open_exec(const char *);
> > +extern void update_seal_exec_system_mappings(unsigned long *vm_flags);
>
> We are dropping extern where possible now.
>
extern can be dropped, it appears not causing link error.
> >
> >  /* fs/dcache.c -- generic fs support functions */
> >  extern bool is_subdir(struct dentry *, struct dentry *);
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index c47a0bf25e58..e9876fae8887 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1506,7 +1506,7 @@ static int xol_add_vma(struct mm_struct *mm, stru=
ct xol_area *area)
> >       }
> >
> >       vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > -                             VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> > +                             VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_S=
EALED,
> >                               &xol_mapping);
>
> Changing all uprobes seems like something that should probably be
> mentioned more than just the note at the end of the change log, even if
> you think it won't have any impact.  The note is even hidden at the end
> of a paragraph.
>
> I would go as far as splitting this patch out as its own so that the
> subject line specifies that all uprobes will be VM_SEALED now.
>
> Maybe it's fine but maybe it isn't and you've buried it so that it will
> be missed by virtually everyone.
>
I will  add "It is sealed from creation." in the above "uprobe" section.

>
> >       if (IS_ERR(vma)) {
> >               ret =3D PTR_ERR(vma);
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 57fd5ab2abe7..d4717e34a60d 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2133,6 +2133,7 @@ struct vm_area_struct *_install_special_mapping(
> >       unsigned long addr, unsigned long len,
> >       unsigned long vm_flags, const struct vm_special_mapping *spec)
> >  {
> > +     update_seal_exec_system_mappings(&vm_flags);
> >       return __install_special_mapping(mm, addr, len, vm_flags, (void *=
)spec,
> >                                       &special_mapping_vmops);
>
> If you were to return a flag, you could change the vm_flags argument to
> vm_flags | mseal_flag()
>
passing pointer seems to be the most efficient way.

Thanks
-Jeff
