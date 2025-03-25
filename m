Received: from b224-18.smtp-out.eu-central-1.amazonses.com (b224-18.smtp-out.eu-central-1.amazonses.com [69.169.224.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D41EDA1F;
	Tue, 25 Mar 2025 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.169.224.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930525; cv=none; b=Le8w+P8SXN8wjnSKycKzfsDMmr6k2/32jGsTEtCqBkTe8F477AAUSscVyoVf7KJcutE/UUh/ZlUbNNpawfhIwGQdXXNtwSmfrgsjMpoV0/T4umCSxa5YcYntata8+gNaFweFIy8MKz4VrvpIilFraCfLqGeBFF+UweJSPjSxNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930525; c=relaxed/simple;
	bh=FdCrWB/PGMqRl9E6yvI0q12+/fCRDq9CWfKgDzpVcYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGFPI3iGElRqNXjreKqacfbNoXXOW1AIVuRxeU5QL6ZqnnIE+Xum9etmWAtyUQ8uBQ6TQ5qmAo/696Q6qfLDbFDreYR5b5zmJigFdn+xAysapsHsN7NqknTaAskjIvp+YFEL8Jhf8SGpOpFkTy2dvKy6trNDkym4mr2uGjPQeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=mail.riscv-rocks.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=hKmcSJA1; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=AVAiw6cD; arc=none smtp.client-ip=69.169.224.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="hKmcSJA1";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="AVAiw6cD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=2kaovp6zxy5nzp5wqunvdq5vkiqbeqln; d=riscv-rocks.de; t=1742930520;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
	bh=FdCrWB/PGMqRl9E6yvI0q12+/fCRDq9CWfKgDzpVcYs=;
	b=hKmcSJA1MuhxsIZPZfj7XEvEo2N6UH79MdWW9aunUqen4zNxJjW5wra5v/QO8qRT
	yHSCH0G142gjUOtflLMR95TxxWgE6GQhr555Ds6o8gCRnj3sIKuQWRbIKKCAqaW1dwk
	JjzNQYfx+6fZdXjpwp/nm5g0gr7aRGe4oHB2Tgo4drsF9dKykpVmbFwmBELXa+TxA0I
	70COdN52Q+P45OpdGYqpthsQMXJb0zymfGlfgRwmltdIUJGkCcygt9fVSXg8gL4NRVk
	Mj3BL5cdFR3KWewke+oo2W62KFEfOHSSHXalPODMl0EZCgkbdPeIqsHSjgbGOCYa2dF
	09Z1/KaK9Q==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=54ecsf3zk7z4mwxwwox7z7bg6e5gwjsz; d=amazonses.com; t=1742930520;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Feedback-ID;
	bh=FdCrWB/PGMqRl9E6yvI0q12+/fCRDq9CWfKgDzpVcYs=;
	b=AVAiw6cD+raTgnEdmxwoAMbu6Kb/WbReAY5v8LAYSDk6+Exstz74K8Fs12KL9V2M
	8Os6Q8Yg3H4up1nbWyLjFsciZPWu046fbGEcRjOOoi8dVACNUBFvEWeVDNUCKAXgIzy
	kMfXfH4L1wztt45u6aiYNQyPuSn8BmIXXrUNZlFo=
Date: Tue, 25 Mar 2025 19:22:00 +0000
From: Damian Tometzki <damian@riscv-rocks.de>
To: Nicolas Chauvet <kwizart@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Kees Cook <kees@kernel.org>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Add __nonstring annotations for
 unterminated strings
Message-ID: <01070195cec129de-3a185083-9c9f-451c-a7f9-3798f9eb5954-000000@eu-central-1.amazonses.com>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Nicolas Chauvet <kwizart@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250310222355.work.417-kees@kernel.org>
 <01070195c306db7f-9f28efdd-9456-4db3-b6c6-343298bd571b-000000@eu-central-1.amazonses.com>
 <87r02ma8s3.fsf@intel.com>
 <CABr+WTkggOTDDzgPFmnJo3Dab4QYxLRt=_g7in3bgr0z6jXf+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABr+WTkggOTDDzgPFmnJo3Dab4QYxLRt=_g7in3bgr0z6jXf+g@mail.gmail.com>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 42 (Adams) (Kernel 6.14.0)
Organization: Linux hacker
Feedback-ID: ::1.eu-central-1.yMcBPu/jK26Vj3HVmCFyFk75QMsS8V3QY5HbXP/Qrys=:AmazonSES
X-SES-Outgoing: 2025.03.25-69.169.224.18

On Mon, 24. Mar 22:19, Nicolas Chauvet wrote:
> Le lun. 24 mars 2025 à 13:54, Jani Nikula
> <jani.nikula@linux.intel.com> a écrit :
> >
> > On Sun, 23 Mar 2025, Damian Tometzki <damian@riscv-rocks.de> wrote:
> > > On Mon, 10. Mar 15:23, Kees Cook wrote:
> > >> When a character array without a terminating NUL character has a static
> > >> initializer, GCC 15's -Wunterminated-string-initialization will only
> > >> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> > >> with __nonstring to and correctly identify the char array as "not a C
> > >> string" and thereby eliminate the warning.
> > >>
> > >> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> > >> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > >> Cc: Zhi Wang <zhi.wang.linux@gmail.com>
> > >> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > >> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > >> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > >> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > >> Cc: David Airlie <airlied@gmail.com>
> > >> Cc: Simona Vetter <simona@ffwll.ch>
> > >> Cc: intel-gvt-dev@lists.freedesktop.org
> > >> Cc: intel-gfx@lists.freedesktop.org
> > >> Cc: dri-devel@lists.freedesktop.org
> > >> Signed-off-by: Kees Cook <kees@kernel.org>
> > >> ---
> > >>  drivers/gpu/drm/i915/gvt/opregion.c | 4 ++--
> > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> > >> index 509f9ccae3a9..f701638d3145 100644
> > >> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> > >> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> > >> @@ -43,7 +43,7 @@
> > >>  #define DEVICE_TYPE_EFP4   0x10
> > >>
> > >>  struct opregion_header {
> > >> -    u8 signature[16];
> > >> +    u8 signature[16] __nonstring;
> >
> > Why would this annotation be needed? It's not treated as a string
> > anywhere, and it's u8 not char.
> >
> > >>      u32 size;
> > >>      u32 opregion_ver;
> > >>      u8 bios_ver[32];
> > >> @@ -222,7 +222,7 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
> > >>      u8 *buf;
> > >>      struct opregion_header *header;
> > >>      struct vbt v;
> > >> -    const char opregion_signature[16] = OPREGION_SIGNATURE;
> > >> +    const char opregion_signature[16] __nonstring = OPREGION_SIGNATURE;
> > >>
> > >>      gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
> > >>      vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
> > >> --
> > >> 2.34.1
> > >>
> > > Hello together,
> > >
> > > it doesnt resolve the build issue with gcc15 gcc (GCC) 15.0.1 20250228
> > >
> > > CC [M]  drivers/gpu/drm/i915/gvt/scheduler.o
> > > /home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c: In function ‘intel_vgpu_init_opregion’:
> > > /home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c:35:28: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
> > >    35 | #define OPREGION_SIGNATURE "IntelGraphicsMem"
> > >       |                            ^~~~~~~~~~~~~~~~~~
> > > /home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c:225:57: note: in expansion of macro ‘OPREGION_SIGNATURE’
> > >   225 |         const char opregion_signature[16] __nonstring = OPREGION_SIGNATURE;
> > >       |                                                         ^~~~~~~~~~~~~~~~~~
> > >   CC [M]  drivers/gpu/drm/i915/gvt/trace_points.o
> > > cc1: all warnings being treated as errors
> > > make[7]: *** [/home/damian/kernel/linux/scripts/Makefile.build:207: drivers/gpu/drm/i915/gvt/opregion.o] Error 1
> > > make[7]: *** Waiting for unfinished jobs....
> > >   CC [M]  drivers/gpu/drm/i915/gvt/vgpu.o
> > > make[6]: *** [/home/damian/kernel/linux/scripts/Makefile.build:465: drivers/gpu/drm/i915] Error 2
> > > make[5]: *** [/home/damian/kernel/linux/s
> >
> > What about this?
> >
> > IMO it's anyway good practice to use sizeof(dest) rather than
> > sizeof(src) for memcpy.
> >
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> > index 509f9ccae3a9..dbad4d853d3a 100644
> > --- a/drivers/gpu/drm/i915/gvt/opregion.c
> > +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> > @@ -222,7 +222,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
> >         u8 *buf;
> >         struct opregion_header *header;
> >         struct vbt v;
> > -       const char opregion_signature[16] = OPREGION_SIGNATURE;
> >
> >         gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
> >         vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
> > @@ -236,8 +235,10 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
> >         /* emulated opregion with VBT mailbox only */
> >         buf = (u8 *)vgpu_opregion(vgpu)->va;
> >         header = (struct opregion_header *)buf;
> > -       memcpy(header->signature, opregion_signature,
> > -              sizeof(opregion_signature));
> > +
> > +       static_assert(sizeof(header->signature) == sizeof(OPREGION_SIGNATURE) - 1);
> > +       memcpy(header->signature, OPREGION_SIGNATURE, sizeof(header->signature));
> > +
> >         header->size = 0x8;
> >         header->opregion_ver = 0x02000000;
> >         header->mboxes = MBOX_VBT;
> >
> >
> >
> > --
> > Jani Nikula, Intel
> 
> This patch does solve the build issue with gcc-15 on Fedora-42
> (gcc-15.0.1-0.9.fc42.x86_64).
> https://copr.fedorainfracloud.org/coprs/kwizart/kernel-longterm-6.12/build/8812754/
testet-by Damian Tometzki
Thanks
Damian

> 
> Thanks.

-- 
VG
Damian Tometzki
