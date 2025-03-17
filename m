Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894F199E94
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238144; cv=none; b=ptjYD/eUX2CqVNWNO/7jqHWUHZKD1Ymm3Lk1n8rjW2k069a1408LoiUpZ1Glmwv/FYgLbJ7ysiICv+pi/oKb/gJ+cgL+CV7eATNOes331o66eOnDGxyhzdpigG41UabdNGAtLW6IfECi3e6Yyxbl0bA8F/fRstxpEU6uSfNgZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238144; c=relaxed/simple;
	bh=9e9i9ZGozCVOW+DGfTa7ONycW5gmKaNN01G9YalVMnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRD5pwQ1EJ2OLthavVwdGVeIuXMF13/6LVFtOxa5UKe8Mz2iqyointvy/J4nR88++kJbJHAWVVUBhlO0S0wsci6EO4JzHvXddgZhL2WFP+/b4aMN9SQgWcJTr823/cYijRUSm2mC7M8e0/ps+vkKzlD8bgYsY5cle7iGFhzsihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iuBVtNXu; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuBVtNXu"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7271b86c102so461287a34.2
        for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742238141; x=1742842941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OttsjgFbyyagfKT+Kygos3ffwlG792Cw3EFU42D0MO0=;
        b=iuBVtNXuKGA96zFUix5INJ2s3Ctce0dImws0ayFxPyfQ15L5q6PoVjqodsqSe5T4Bl
         fmeEBMvJvUB0OPCrEuNFvVCkc7RcPfmtotiqzEz4lDqYW3ddTTB7jQZIWouEslXxzUuy
         JFTAFFiJR4fVQ0U9MgsTqfxU6ClQVobHtGPuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742238141; x=1742842941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OttsjgFbyyagfKT+Kygos3ffwlG792Cw3EFU42D0MO0=;
        b=mOxe69fvJk0NVQ0maBwDKiMh8BB3pnXNBxD2Zcl4u/qTt+aDyY9omehTiVoeKnPtJD
         3tLoF2Wbtyk3XT+Y+jswfz3+FeXQNYZmuhkweOWwXRnLW2Gjv8h7zVQq6KcVkonS5Vwc
         oXWOMeP6eeW+7ow96HKLHxk9GaDU4pfekTWfqAcD1audW7VLBLYM2HdLwVeRN5vePrsQ
         XQEFnMC+3lk1hwZinaCh1UJqyMbq3YNgPz46zZOJSjeW6gvklS7zIj5Xv6Id0rFol45D
         8MquG145mVGH+nripemyDJ8YrL2EdTSlfr1vn1L6yIdiyTU5m38aOfIugK8hWoW+q5JC
         GFzw==
X-Forwarded-Encrypted: i=1; AJvYcCUjacceAaKaBh/r7duQa3gf+z8BCyiERXc8oxqsGOjKTK6jQ7DerjPfLIXS+Ezlma7FQsk4V2pARym4YCDGMZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiEuii7gUfLFLV03Ju3mVPWpvyWdsIpvDW1laPPQwWrWHfuL9
	ZFVmlWbu9tRQsobwe1Hmp+k3gzJTPPsDUWlk43AxPShvEHJb4iDps+8dr5dL0j0rl3epyDZfWYe
	FLDBaI1Lqfy0N07DBQW7HJfTsPgVlqYaLp2jE
X-Gm-Gg: ASbGncs+ulki9CjVxALn+9vUFoIi8r2CroxvBbb408f465ZRdk41VmoFUcNZMZYscyW
	w3Oteo5foHPreEPc32GBndpbC0xR8jASlkglVOi0LogY2d9xlQKP3PnYkn5fC+/i6zDcrpQ0pHV
	TwiGEfTInUK4D3fbw6WWT4oW1iP+qtjmK1SZIFbyQR58CwDJ3FmpKW+vk=
X-Google-Smtp-Source: AGHT+IFmhELxsEbF5+FGpij6p/0nGDQxLmvLcCOIk3O1Kjoyj75mq8CVjrKZo8Rz/4RdRDTUlZtx2edlKIyzMHgzB8g=
X-Received: by 2002:a05:6871:d308:b0:297:2582:c66c with SMTP id
 586e51a60fabf-2c690b43ca1mr2433846fac.0.1742238141295; Mon, 17 Mar 2025
 12:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
 <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com> <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com>
In-Reply-To: <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 17 Mar 2025 12:02:09 -0700
X-Gm-Features: AQ5f1JoqLcgifoqvsf2X7sr50no49b8qRyd6QqCFaHGdNwMKDBXBaaWgVcGITRs
Message-ID: <CABi2SkWmxwM-MbfmRCZvBYek8KpmOKPMsFmb=-eZTgKfp3AN6w@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, svens@linux.ibm.com, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:14=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrot=
e:
>
> On Fri, Mar 14, 2025 at 3:41=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> >
> > Hi Jeff,
> >
> > On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> wrote:
> > > On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.org wrote=
:
> > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > Add Documentation/features/core/mseal_sys_mappings/arch-support.t=
xt
> > > > >
> > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >
> > Thanks for your patch!
> >

I used "find * |xargs grep -i  CONFIG_64BIT" to look for CONFIG_64BIT
under arch/, and together with internet search/wiki page, and below is
the proposed update.

> > > > > --- /dev/null
> > > > > +++ b/Documentation/features/core/mseal_sys_mappings/arch-support=
.txt
> > > > > @@ -0,0 +1,30 @@
> > > > > +#
> > > > > +# Feature name:          mseal-system-mappings
> > > > > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > > > > +#         description:   arch supports mseal system mappings
> > > > > +#
> > > > > +    -----------------------
> > > > > +    |         arch |status|
> > > > > +    -----------------------
> > > > > +    |       alpha: | TODO |
No CONFIG_64BIT found under arch/alpha, but search results show alpha
supports 64 bits. Keep as TODO.

> > > > > +    |         arc: | TODO |
> > > > > +    |         arm: |  N/A |
> > > > > +    |       arm64: |  ok  |
> > > > > +    |        csky: | TODO |
(N/A)

> > > > > +    |     hexagon: | TODO |
No CONFIG_64BIT found under arch/hexagon, but search results show
hexagon supports 64 bits. Keep as TODO.

> > > > > +    |   loongarch: | TODO |
> > > > > +    |        m68k: | TODO |
(N/A)

> > > > > +    |  microblaze: | TODO |
No CONFIG_64BIT found under arch/microblaze, but search results show
microblaze supports both 32 and 64 bits. Keep as TODO.

> > > > > +    |        mips: | TODO |
> > > > > +    |       nios2: | TODO |
(N/A)

> > > > > +    |    openrisc: | TODO |
No CONFIG_64BIT found under arch/openrisc, but search results show
microblaze supports both 32 and 64 bits. Keep as TODO.

> > > > > +    |      parisc: | TODO |
> > > > > +    |     powerpc: | TODO |
> > > > > +    |       riscv: | TODO |
> > > > > +    |        s390: |  ok  |
> > > > > +    |          sh: | TODO |
No CONFIG_64BIT found under arch/openrisc, but wikipedia shows sh-5 is
a 64 bit, so Keep as TODO.

> > > > > +    |       sparc: | TODO |
> > > > > +    |          um: | TODO |
> > > > > +    |         x86: |  ok  |
> > > > > +    |      xtensa: | TODO |
N/A

In summary: csky, m68k, nios2, xtensa, arm only have a 32 bit CPU and
will use "N/A".
I will leave it open for a while, If no objection , I will send a new
patch version.

Thanks.
-Jeff

> > > > > +    -----------------------
> >
> > > > Plus I feel this need expansion a bit 'N/A' is because of being non=
-64 bit
> > > > right?
> > > >
> > > Below is the definition of N/A in Documentation/features/arch-support=
.txt
> > >    | N/A|  # feature doesn't apply to the architecture
> > >
> > > It fits the arm case because mseal is not supported in 32 bit.
> >
> > IIUIC, you can already s@TODO@N/A@ for all other 32-bit architectures,
> > so we don't accidentally spend time on looking into adding the support?
> >
> Sure, my architecture knowledge is limited.
>
> I just checked this, it seems to me that csky, m68k, nios2, sh, xtensa
> doesn't have 64 bits support, the rest have 64 bits. Is this correct ?
>



> Thanks
> -Jeff
>
>
>
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker=
. But
> > when I'm talking to journalists I just say "programmer" or something li=
ke that.
> >                                 -- Linus Torvalds
