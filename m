Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B024A06D;
	Thu, 13 Feb 2025 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477476; cv=none; b=jnijhQULej7Tw2xByAnL7s2SnbzuRcnP7tdfKXsZtvfyRatqQoXmnMK63Wqu464QdvJzGQfNAWN6MDZXmjlruRyEgQ4xVI03SgHmMkGP4t24xRS/VE7cYja0dZ6Xn8x/Tnilblqsi9e31NuEb2Ycsc4V1aeErOmUUpvURKVfsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477476; c=relaxed/simple;
	bh=rzAwFOtx8Mlk85SmZ1zam/aDQjsGN4PrEsXmYEmHYhI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nedJchHoAt5H9qLcqDG++wy/KB/AOLDhSG7JgNkwvE83tDP0r6zHH+nKH1NG31Kop9eCUeuWlPeeuln2Mqp0lQzFr5JeGZNNvQxv/55s5k27lnLXtsIlpGoAZAVN+GrwQgfi/9fT9OegNXCtwErsTXrjk6a07EM2fxTYSjxqCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t13YTDLY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t13YTDLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29FDC4CED1;
	Thu, 13 Feb 2025 20:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739477475;
	bh=rzAwFOtx8Mlk85SmZ1zam/aDQjsGN4PrEsXmYEmHYhI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=t13YTDLYBaaZK2ruzOlvQHeKpXg2E7ItI679u9HdrNJF3HveaxsCsbGIIYvLiNRi9
	 AxQfpqisjqFRpwsfQuSsmWA3+ZqM69Vh31eu1pvIQJhWDlaD6coWzNvw6KKZlIXezh
	 uxYE6hc00NDguZbn/z15fEqhwdG5iJ5umvS1bg1V0yDkArTxYBWZTPFpUo8E2s3AL2
	 NBuI9Qc5abWfzuU1knx3BpU2KL1jlAcCjqexNSqILcdKomnnO0F0xqBCNQRgK8NuSF
	 8XanoXuVjWGji48r2cke8eG1T0r0n8fCukSTronAt4gOpwsB3Bj9XDsSPMucUx3Q6L
	 xqWnfXWbgGbuA==
Date: Thu, 13 Feb 2025 12:11:15 -0800
From: Kees Cook <kees@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
Message-ID: <202502131142.F5EE115C3A@keescook>
References: <20250212032155.1276806-1-jeffxu@google.com>
 <20250212032155.1276806-2-jeffxu@google.com>
 <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
 <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
 <66q7feybn3q2vuam72uwmai322jdx3jtv2m5xmh75l6w6etqiv@knpsyh3o627k>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66q7feybn3q2vuam72uwmai322jdx3jtv2m5xmh75l6w6etqiv@knpsyh3o627k>

On Thu, Feb 13, 2025 at 01:29:46PM -0500, Liam R. Howlett wrote:
> * Jeff Xu <jeffxu@chromium.org> [250213 12:17]:
> > On Wed, Feb 12, 2025 at 7:05 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > ...
> > > >
> > > > In this version, we've improved the handling of system mapping sealing from
> > > > previous versions, instead of modifying the _install_special_mapping
> > > > function itself, which would affect all architectures, we now call
> > > > _install_special_mapping with a sealing flag only within the specific
> > > > architecture that requires it. This targeted approach offers two key
> > > > advantages: 1) It limits the code change's impact to the necessary
> > > > architectures, and 2) It aligns with the software architecture by keeping
> > > > the core memory management within the mm layer, while delegating the
> > > > decision of sealing system mappings to the individual architecture, which
> > > > is particularly relevant since 32-bit architectures never require sealing.
> > > >
> > > > Additionally, this patch introduces a new header,
> > > > include/linux/usrprocess.h, which contains the mseal_system_mappings()
> > > > function. This function helps the architecture determine if system
> > > > mapping is enabled within the current kernel configuration. It can be
> > > > extended in the future to handle opt-in/out prctl for enabling system
> > > > mapping sealing at the process level or a kernel cmdline feature.
> > > >
> > > > A new header file was introduced because it was difficult to find the
> > > > best location for this function. Although include/linux/mm.h was
> > > > considered, this feature is more closely related to user processes
> > > > than core memory management. Additionally, future prctl or kernel
> > > > cmd-line implementations for this feature would not fit within the
> > > > scope of core memory management or mseal.c. This is relevant because
> > > > if we add unit-tests for mseal.c in the future, we would want to limit
> > > > mseal.c's dependencies to core memory management.
> > > >
> > ...
> > > >
> > > > diff --git a/include/linux/userprocess.h b/include/linux/userprocess.h
> > > > new file mode 100644
> > > > index 000000000000..bd11e2e972c5
> > > > --- /dev/null
> > > > +++ b/include/linux/userprocess.h
> > > > @@ -0,0 +1,18 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef _LINUX_USER_PROCESS_H
> > > > +#define _LINUX_USER_PROCESS_H
> > > > +#include <linux/mm.h>
> [...] 
> 
> Also, I don't agree with your stated reason for a new header.
> 
> Please remove this header until it is needed.  It can be added later if
> it is needed.  If we all had tiny headers because we might need them in
> the future, we'd have serious issues finding anything and the list of
> included headers would be huge.
> 
> You have added unnecessary changes and complications to this patch set
> on v5.

In all fairness, I think v5 is significantly less complex overall. Jeff
used his best judgement with a new header, and I don't think it's
unreasonable. That it is unwanted is fine, mm.h it is, but I think it's
clear the intent was trying to make this as least burdensome for the mm
subsystem as possible.

> > > > +/*
> > > > + * mseal of userspace process's system mappings.
> > > > + */
> > > > +static inline unsigned long mseal_system_mappings(void)
> > > > +{
> > > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > > +     return VM_SEALED;
> > > > +#else
> > > > +     return 0;
> > > > +#endif
> > > > +}
> > > > +
> > > > +#endif
> > >
> > > Looking in mm.h, there are examples of config checks which either set
> > > the bit or set it to 0.  This means you wouldn't need the function at
> > > all and the precompiler would do all the work (although with a static
> > > inline, I'm not sure it would make a big difference in instructions).
> > >
> > > For instance, you could do:
> > > #ifdef CONFIG_64BIT
> > > /* VM is sealed, in vm_flags */
> > > #define VM_SEALED       _BITUL(63)
> > >
> > > #ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > #define VM_SYSTEM_SEAL          VM_SEALED
> > > else
> > > #define VM_SYSTEM_SEAL          VM_NONE
> > > #endif
> > >
> > > #else /* CONFIG_64BIT */
> > > #define VM_SYSTEM_SEAL          VM_NONE
> > > #endif
> > >
> > > Then you can use VM_SYSTEM_SEAL in the system mappings function in the
> > > list of flags instead of having a variable + calling the static
> > > function.
> > >
> > > I didn't look close enough to see if the 32bit version is necessary.
> > >
> > I'm aware of the other pattern.
> > 
> > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
> > the build. This is intentional. Any 32-bit code trying to use the
> > sealing function or the VM_SEALED flag will immediately fail
> > compilation. This makes it easier to identify incorrect usage.
> 
> So you are against using the #define because the VM_SYSTEM_SEAL will be
> defined, even though it will be VM_NONE?  This is no worse than a
> function that returns 0, and it aligns better with what we have today in
> that it can be put in the list of other flags.

When I was reading through all of this and considering the history of
its development goals, it strikes me that a function is easier for the
future if/when this can be made a boot-time setting.

If mm maintainers prefer a #define for now, that's fine of course. The
value of VM_SYSTEM_SEAL can be VM_NONE on 32-bit.

> Also, my vote for where you should put this code is clear: it should
> live with the mseal #define in mm.h.  You're going to need mm.h anyways,
> and that's a big hint as to where it should live.

Sounds good.

> > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > index d0d021b3fa3b..892d2bcdf397 100644
> > > > --- a/init/Kconfig
> > > > +++ b/init/Kconfig
> > > > @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> > > >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> > > >       bool
> > > >
> > > > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > >
> > > ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS is more clear.  HAS may mean it's
> > > supported or it could mean it's enabled. SUPPORTS is more clear that
> > > this is set if an arch supports the feature.  After all, I think HAS
> > > here means it "has support for" mseal system mappings.
> > >
> > > I see that both are used (HAS and SUPPORTS), but I'm still not sure what
> > > HAS means in other contexts without digging.
> > >
> > The existing pattern is to indicate arch support with
> > CONFIG_ARCH_HAS_N and   security/KConfig to have CONFIG_N as the main
> > switch. For example, CONFIG_ARCH_HAS_FORTIFY_SOURCE and
> > CONFIG_FORTIFY_SOURCE. Since the MSEAL_SYSTEM_MAPPINGS is placed in
> > security/Kconfig, hence I'm following the existing pattern in
> > security/Kconfig.
> 
> Okay, thanks.  I really think SUPPORTS is more clear, but sticking with
> whatever your area uses is also fine.

Yeah, I've really scratched my head over what the best practice is here.
There's a real mixture of "HAS" vs "SUPPORTS" across both hardware
architectural support, software features, interface implementations,
and compiler behavior that bridges between those. When I've looked in
the past, it seemed that "HAS" was in the majority, but I've never been
able to make sense of it.

Let me look again. Today, HAS shows:

$ git grep 'config .*_HAS_' | grep -v Documentation/ | \
  awk '{print $2}' | cut -d_ -f1 | sort | uniq -c | sort -n
      1 ARM
      1 MAC80211
      1 PGTABLE
      1 PPC
      1 RUSTC
      1 USB
      2 ARM64
      2 SIBYTE
      2 SOC
      3 FS
      3 PAHOLE
      6 SGI
      6 TOOLCHAIN
     10 ARC
     20 AS
     32 SYS
     34 CPU
     38 CC
    105 ARCH

Looking through them, it's tools (CC, AS, PAHOLE, etc), and
system/cpu/architecture prefixes, with ARCH being a clear winner.

SUPPORTS looks similar, but isn't as widely used:

$ git grep 'config .*_SUPPORTS_' | grep -v Documentation/ | \
  awk '{print $2}' | cut -d_ -f1 | sort | uniq -c | sort -n
      1 PPC64
      1 X86
      2 CLANG
      2 GCC
      2 RUSTC
      8 CPU
     38 SYS
     71 ARCH

The mips arch is using SYS, and distinguishes between HAS and SUPPORTS
in the sense of "this kernel HAS support for CPU $foo, which SUPPORTS
features x, y, z".

Looking through ARCH_SUPPORTS, it's all software features. Looking
through ARCH_HAS, it looks like a mix of hardware features
and software features. Some software features are more about
implementation availability, though (so "HAS" makes sense,
but should maybe be "IMPLEMENTS"?) e.g. ARCH_HAS_SYSCALL_WRAPPER,
ARCH_HAS_STRNLEN_USER, ARCH_HAS_FORTIFY_SOURCE, ARCH_HAS_ELF_RANDOMIZE,
ARCH_HAS_STRICT_KERNEL_RWX, ARCH_HAS_STRICT_MODULE_RWX.

So, I think I'd agree: this is about a software features and not an API
implementation nor hardware feature, so let's use ARCH_SUPPORTS_.

-Kees

-- 
Kees Cook
