Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102F2661B9
	for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544003; cv=none; b=dSANYmORYltAnYpsCH3tIS3IjLqiAX981o4MSjHXojS0bTI7ivecnMl5g6Vj0XZJwS3D0hMSumwPbIM1xRvgGYVhFY7RFsgvvcy8KxpNbyrW3/fUDp3Hy+XKl3/wrSI3PQ/b7S6hXVNGaZExo8xKjCDysvagigQmHiqz24M5sx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544003; c=relaxed/simple;
	bh=mSGPqJ7pPobo1joX6a4Mc1VuLcnH0TERvQkFnSYe+Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FsjBqz/wZ9mesryAD7ZF0GgNs2Ek6wsXUWtT48iAN0ILNJ+zdCHphjExm6jVMsFh2p0SuDNL6voGeAF6sTwnVaseMp04FZrnVFMo+gAF7ZgFnUDZV1iM4kK/D+WP+UhpEAz/HLY5iVcuwiEDA1e18t7UW76x9zR5MgwC6Fp7TcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bLa9DvKo; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bLa9DvKo"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72709f5e300so156003a34.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 06:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739544000; x=1740148800; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e50JFqmY2OdzosOXKFQSp920S0Fnul4zaVHjHtIwYN4=;
        b=bLa9DvKoGazWkcbKAxOTeIlpRunD5qz4QLnpeAMe6FRRubbg09eQ3yCFF5N0BmSemU
         GRom7QjG+H4hyJjc3vT9ZuRYJ2E/NERW4DqVa24LR73+MBrItykDI2o9rM77jf+P/8yk
         rENRcY/Y86uaRLpGpCyLzDprf7PbsdnpDb0qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739544000; x=1740148800;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e50JFqmY2OdzosOXKFQSp920S0Fnul4zaVHjHtIwYN4=;
        b=k/DxHi4xcIfBRs3U6wP5/gTfeLVWHistWSURQPGWmz7ZRz7Km8ewt6fgwEWREi01Px
         tiSf+SOUFmsQvqAYGGEUBB22l8lRKCv1obP7Y4lBo2JPkl4hIXmbHbi35lbH8jAINR0S
         wCntnlOONPJ+7UvtCHu20YmNiowpuRVDniRFQ916UFIagD4GOpQUdLbbCfBBFEvy8g59
         FNXSps6UpSgFZfBfl50NN0+uimHzoaS4pr+3gEEMbnJ4LnIlA10G2qf1z2WP++7yp08Y
         xNgGukq5xdkT59kfkPsdCW8gyyNTZYhNBcGz2iNJj09tmyUgi7f7vY1HZFgaJfILMphP
         TWCw==
X-Forwarded-Encrypted: i=1; AJvYcCWWgtJ+OIiHPxxSXMZH7wA2PeDwNwuxkIjDmJtmmyvZCp5M888QqriN1ArHvT1rMKwbQA3Z+KyOaeWo7FoqfqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZUo4W5AcOlWJ/BtByV0y8QdGMAWmz6WWpBUKqn/YfJ+0H0UbU
	1b2PAnoScvwWrLZEBbQRF+9ri8Co0K4FRait79jHLsihKgqS5ubjjja9hKlejOsP4OuQKwfLEBe
	3NpVBsm1oHmfTLQd+6qEdz0oTwpmwm+0ae+sL
X-Gm-Gg: ASbGnctZ8cRQukUO+Jn/ai6ffaQpbdm+EKwBG0A+yAyFrXq+xRFdkZiB5awYcLikGM7
	8t6YzekbYhdjVZ//c9pqTn0h+nqjdDwSOSouUZXOkThxwe39GKx2v7YPy7/W3ax42xt34zK1QUd
	nx75oFGzfUKhpOuaXchblPUgvWlPQjZQ==
X-Google-Smtp-Source: AGHT+IE5phE84a0UTMr4W87ScgbUlW/dFHXl7hg7/1Hl59bEFS9809KM+sJHjNr/1G9i++0cxtWwsdHrnjZkeJlT4Tg=
X-Received: by 2002:a05:6808:30aa:b0:3eb:5372:980a with SMTP id
 5614622812f47-3f3e1a3dae1mr621837b6e.9.1739544000360; Fri, 14 Feb 2025
 06:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-2-jeffxu@google.com>
 <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
 <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
 <66q7feybn3q2vuam72uwmai322jdx3jtv2m5xmh75l6w6etqiv@knpsyh3o627k>
 <202502131142.F5EE115C3A@keescook> <t5hsasch3aybjujmjzs3shpiorcgzp5pjc4fmz77u574voi3hr@qomzrd2llv2q>
 <CABi2SkX3o-PdeuzownVkFT-oo8tjtaaS9ebOALu+r6O1S6W3sg@mail.gmail.com>
 <tfoitovawb6zwr7nvwfo2mnbahgtnoo6umvecj5mgtie4b5vuf@sloraia3ppfy> <ex3y7knp5kmubeauwktvv4fdjqya7ndatzm7ht4gf773c72hc3@y4ow7k54fttj>
In-Reply-To: <ex3y7knp5kmubeauwktvv4fdjqya7ndatzm7ht4gf773c72hc3@y4ow7k54fttj>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 14 Feb 2025 06:39:48 -0800
X-Gm-Features: AWEUYZnFrrkgQutGRNCikvC0GjZmPuFErPnb4MZpk1qZi3Du18JPUWGyIDShPQQ
Message-ID: <CABi2SkW_CqwNXFu9BUDfTX07aq5T8OAZern9hL=WumEWqK=ZFA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
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

On Thu, Feb 13, 2025 at 5:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Liam R. Howlett <Liam.Howlett@oracle.com> [250213 19:14]:
> > * Jeff Xu <jeffxu@chromium.org> [250213 17:00]:
> > > On Thu, Feb 13, 2025 at 12:54=E2=80=AFPM Liam R. Howlett
> > > <Liam.Howlett@oracle.com> wrote:
> > >
> > > > > > >
> > > > > > > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't =
part of
> > > > > > > the build. This is intentional. Any 32-bit code trying to use=
 the
> > > > > > > sealing function or the VM_SEALED flag will immediately fail
> > > > > > > compilation. This makes it easier to identify incorrect usage=
.
> > > > > >
> > > > > > So you are against using the #define because the VM_SYSTEM_SEAL=
 will be
> > > > > > defined, even though it will be VM_NONE?  This is no worse than=
 a
> > > > > > function that returns 0, and it aligns better with what we have=
 today in
> > > > > > that it can be put in the list of other flags.
> > > > >
> > > > > When I was reading through all of this and considering the histor=
y of
> > > > > its development goals, it strikes me that a function is easier fo=
r the
> > > > > future if/when this can be made a boot-time setting.
> > > > >
> > > >
> > > > Reworking this change to function as a boot-time parameter, or what=
ever,
> > > > would not be a significant amount of work, if/when the time comes.
> > > > Since we don't know what the future holds, it it unnecessary to eng=
ineer
> > > > in a potential change for a future version when the change is easy
> > > > enough to make later and keep the code cleaner now.
> > > >
> > > Sure, I will put the function in mm.h for this patch. We can find a
> > > proper place when it is time to implement the boot-time parameter
> > > change.
> > >
> > > The call stack for sealing system mapping is something like below:
> > >
> > > install_special_mapping (mm/mmap.c)
> > > map_vdso (arch/x86/entry/vdso/vma.c)
> > > load_elf_binary (fs/binfmt_elf.c)
> > > load_misc_binary (fs/binfmt_misc.c)
> > > bprm_execve (fs/exec.c)
> > > do_execveat_common
> > > __x64_sys_execve
> > > do_syscall_64
> > >
> > > IMO, there's a clear divide between the API implementer and the API u=
ser.
> > > mm and mm.h are the providers, offering the core mm functionality
> > > through APIs/data structures like install_special_mapping().
> > >
> > > The exe layer (bprm_execve, map_vdso, etc)  is the consumer of the
> > > install_special_mapping.
> > > The logic related to checking if sealing system mapping is enabled
> > > belongs to the exe layer.
> >
> > Since this is an all or nothing enabling, there is no reason to have
> > each caller check the same thing and do the same action. You should put
> > the logic into the provider - they all end up doing the same thing.
> >
> > Also, this is a compile time option so it doesn't even need to be
> > checked on execution - just apply it in the first place, at the source.
> > Your static inline function was already doing this...?
> >
> > I'm confused as to what you are arguing here because it goes against
> > what you had and what I suggested.  The alternative you are suggesting
> > is more code, more instructions, and the best outcome is the same
> > result.
>
> I think I understand what you are saying now: the interface to
> install_special_mapping() needs to take the vma flag, as it does today.
> What I don't understand is that what you proposed and what I proposed
> both do that.
>
> What I'm saying is that, since system mappings are enabled, we can
> already know implicitly by having VM_SYSTEM_SEAL either VM_NONE or
> VM_SEAL.
>
> Turning this:
>
> @@ -264,11 +266,12 @@ static int map_vdso(const struct vdso_image *image,=
 unsigned long addr)
>         /*
>          * MAYWRITE to allow gdb to COW and set breakpoints
>          */
> +       vm_flags =3D VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> +       vm_flags |=3D mseal_system_mappings();
>         vma =3D _install_special_mapping(mm,
>                                        text_start,
>                                        image->size,
> -                                      VM_READ|VM_EXEC|
> -                                      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +                                      vm_flags,
>                                        &vdso_mapping);
>
> to this:
>
>         /*
>          * MAYWRITE to allow gdb to COW and set breakpoints
>          */
>         vma =3D _install_special_mapping(mm,
>                                        text_start,
>                                        image->size,
>                                        VM_READ|VM_EXEC|
> -                                      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +                                      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
> +                                      VM_SYSTEM_SEAL,
>                                        &vdso_mapping);
>
> No unsigned long vm_flags needed.  It's easier to read and I don't think
> it's any more hidden than the vm_flags |=3D function call option.
>
The arch code needs a mseal_system_mappings() function. Otherwise,
I'll have to change this line (in arch) again when I implement the kernel
command line or pre-process opt-in/opt-out, which requires a function
call. This isn't overthinking; based on our discussion so far, there
are clear needs for a subsequent patch series. This patch is just the
first step.

For software layering, I'd like to see a clear separation between
layers. mm implements _install_special_mapping, which accepts any
combination of vm_flags as input.  Then I'd like the caller (in arch
code) to have all the necessary code to compose the vm_flags in one
place. This helps readability. In the past, we discussed merging the
vdso/vvar code across all architectures. When that happens, the new
code in arch will likely have its own .c and .h files, but it will still si=
t
above mm.  That means mm won't need to change, and the
_install_special_mapping API from mm will remain unchanged.

The mseal_system_mappings() function can already return VM_SEALED,
and future patches will add more logic into mseal_system_mappings(), e.g.
check for kernel cmdline or opt-in/opt-out. we don't need a separate
VM_SYSTEM_SEAL, which is a *** redirect macro ***, I prefer to keep
all the important code logic relevant to configuration of enabling system
mapping sealing in one place, for easy reading.

mseal_system_mappings() can be placed in mm.h in this patch, as you
suggested. But in the near future, it will be moved out of mm.h and find
a right header. The functionality belongs to exe namespace, because of
the reasons I put in the commit message and discussions.

Thanks
-Jeff

-Jeff
