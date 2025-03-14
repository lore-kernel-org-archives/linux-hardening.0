Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B12E3364;
	Fri, 14 Mar 2025 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948900; cv=none; b=aylUfzl6Gsf9rhtXnwXoxoYglOcghavtKr/lH2pxPYB66cdbjIyyBj2oiktoGRqZqcfBOqkzyjFkfUgqmLBd64cz3Ic5QwLA12dRPaXbvnXqmk0P27REmP2/u97zVO8faGPBuzWVTVjjOu9QX7C/9ObNT5HXMOf3EmvDZy35cjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948900; c=relaxed/simple;
	bh=wAAvNKLgusOlGKrlaYUuKsJhxSJUHhdhjnh6zR8JtpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+8h5S07187RpUUf1oZH00JIjVh5EAAomqBYYQkHB8rRzWyk38ozfiViwf0HIlxoYD5p2x+53a21Ig6dY7WqoGlwm9GHaStxuNl0usnxvneBVcTEEkUwaManw4QfRzQzL0mXcaM6DHWRnxf9EPH6Rj2EynC1+kNoyoTkQ22Bhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523f670ca99so832318e0c.1;
        Fri, 14 Mar 2025 03:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948897; x=1742553697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2a0XdlHfVGimiEmhJxXLC0f6yubhW0wG4LfXdbrzhk=;
        b=Un1acpBUd3K2AjLTu6B/HXOH19hCV829hX9KPTVZ4Td6OPaTTItOFz5CemXFUL7yom
         pAUGNb4TxKf7FfAntsbeXFB2Nvk2oGLwQh9m0YYvlCUoWdG4chdeeuiUf7wRCAM2mAlI
         DVfFDJn17MwcmRZcOwbhFsemD6sME72PxK/wC496u0Y80MR4jPYJw9ObXrEKtXVD2P9X
         YbolecRMbv5INzzQH1w93lrCGbWHy45Ah8OAakpwsh/HIA3WrMSuXtOXwnUkZUP3qVSe
         cQTLSMXDUdVKafXYv5vit9kNO81rIFAgkgc5o0YuN94H1pTUJfl1D192N33c9xvpXomE
         /NQA==
X-Forwarded-Encrypted: i=1; AJvYcCWXoAItN81orOFUr428O3Vv0mBQJIlkgYGZjQc+rKbiUhKuwcIKK186g0ZqzdE4ebvoVOVy/eMYjo3vIwFc@vger.kernel.org, AJvYcCXVG5YNVnYVw1YDrlyKZ1eXI42MkIjmhhK01wlPUaNQkDy1wXSsO7Qb7kVGIGoADJJuIFAxtbNWvaOWuiU4vzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0e6jSOSZUBU1S2bxkpgCFyTm/RazYyTQjVcYkcbkLGiTo/at
	EzY3So6p0TsEcEitPKlhdkPkLxu/gG7sMkxLnlcG9NS+sC21Vni97x+Xagv9FYU=
X-Gm-Gg: ASbGncsZlp3w9/WLSxsiAJUAkPLNAxK4brm0pn7A6BAzD44kER45f8cXnajIsNXsuDm
	F/ldzrPUserc6ZRuq08fDFFT0/CSD8mUomoAWz9ve9hoCx68lolgKfO4/QsRsVlE4UlPjVCfznc
	PuZpgxfYkGHN+6Zb/QjAHouS76XnG9d4LD85F2T7S5ZTYKMfByoEE8Djnh7JKg1mU+smV4r7rIa
	2rJ5B16FHs0xTgmRD54ox3jqrOJlx13hBN05QzLVQ5PUoSbcICqwCfm1Auxn8qt/5gP18xiQ05h
	ZJpI95ztSAjPF0GkYfL88/dM7n+YfUtk0Ore7fApuAzzO8XwYeYuqatQfAYsYN+ssOBh94SnQLE
	0gTsqLINP8LA=
X-Google-Smtp-Source: AGHT+IHZ7/OyMcc3ElKpgF+M9tmh4nsO/N/NHbZIT4O3+Zi1Qu+25o6s+j+uZxZ5umYmL/w01RUX3g==
X-Received: by 2002:a05:6102:c88:b0:4c1:8b8e:e9f7 with SMTP id ada2fe7eead31-4c3831423f0mr823093137.8.1741948897060;
        Fri, 14 Mar 2025 03:41:37 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a7184c5sm510212e0c.41.2025.03.14.03.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:41:36 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523f670ca99so832308e0c.1;
        Fri, 14 Mar 2025 03:41:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCuY1E6ZAjao/1sScLagqL66WRar2LE0Y4Ki1SCXoItwTTSjNRMBJCjAiE9fEB4QUavDPP6dtuv7U5fbdC1HE=@vger.kernel.org, AJvYcCXnrM/s9JHohB+IQ5iN/uiehM93VCL+wZMA5udxIRG6QxjZqH/8l9+s9JnwAVQSeTpwQ04NDkH0qK2DaUkF@vger.kernel.org
X-Received: by 2002:a05:6102:291e:b0:4bd:3519:44be with SMTP id
 ada2fe7eead31-4c38316528dmr841929137.15.1741948896717; Fri, 14 Mar 2025
 03:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
In-Reply-To: <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 11:41:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpDaLQEVLSNN7-GYtJjARXg8j9AqQzFp9qJxVfEnQq4UCam8hYvNh7zaf8
Message-ID: <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Jeff Xu <jeffxu@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, svens@linux.ibm.com, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> wrote:
> On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > > Add Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Thanks for your patch!

> > > --- /dev/null
> > > +++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > > @@ -0,0 +1,30 @@
> > > +#
> > > +# Feature name:          mseal-system-mappings
> > > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > > +#         description:   arch supports mseal system mappings
> > > +#
> > > +    -----------------------
> > > +    |         arch |status|
> > > +    -----------------------
> > > +    |       alpha: | TODO |
> > > +    |         arc: | TODO |
> > > +    |         arm: |  N/A |
> > > +    |       arm64: |  ok  |
> > > +    |        csky: | TODO |
> > > +    |     hexagon: | TODO |
> > > +    |   loongarch: | TODO |
> > > +    |        m68k: | TODO |
> > > +    |  microblaze: | TODO |
> > > +    |        mips: | TODO |
> > > +    |       nios2: | TODO |
> > > +    |    openrisc: | TODO |
> > > +    |      parisc: | TODO |
> > > +    |     powerpc: | TODO |
> > > +    |       riscv: | TODO |
> > > +    |        s390: |  ok  |
> > > +    |          sh: | TODO |
> > > +    |       sparc: | TODO |
> > > +    |          um: | TODO |
> > > +    |         x86: |  ok  |
> > > +    |      xtensa: | TODO |
> > > +    -----------------------

> > Plus I feel this need expansion a bit 'N/A' is because of being non-64 =
bit
> > right?
> >
> Below is the definition of N/A in Documentation/features/arch-support.txt
>    | N/A|  # feature doesn't apply to the architecture
>
> It fits the arm case because mseal is not supported in 32 bit.

IIUIC, you can already s@TODO@N/A@ for all other 32-bit architectures,
so we don't accidentally spend time on looking into adding the support?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
