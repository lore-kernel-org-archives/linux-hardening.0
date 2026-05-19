Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B25481FA2
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185346; cv=none; b=gY46jVv5D+BzGPsULwDS2mQ72iWdQw2nBKEWe4OBcWCroAnCo9rKBoWJjeY7uVMNknLL1eeHZgPiRn1yMYGypKRYCcFwa30jXM/NBZKmMG72cvGPegJNcQdF5In569H0xaf4YGW5fu+9Q5dvgCjeU6jJPqMzyRq21ksG110CpUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185346; c=relaxed/simple;
	bh=d5wqftF63M6yklv3zeLt4GQqpDKoy4cN11UgWv71+J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRHY6Ocpd7rgMVRTkeErqaP1of6+1pR/xP7laUgW2DpRbt0+XQqLoOXNW59CHDl9nmH5tOyjB2yiqMMRqJjUwky7AToHJ6Veua8dh5/XdaBGgh+hqdluR6k+kw9+kjlDehkK87BOqCc8vjvtTs50sdp1BY++CN3kBeFTMEKnnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-57512a429d1so2922105e0c.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 03:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185343; x=1779790143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxuVldO4eyfcDOsGEwUBhaeFLVJjGaNmFshsGT684kc=;
        b=jL/nT7IQPzvcGzOwhOs2LFTghIkBaCc9TLGU8s74CgB4/33fUPYdMdoffBRK5mbVNI
         jM3l0UdH07j2U7b8WsDHJPcM0eGtxiIKvI3pG8wLvYwUREPBYxWHdlcDXuBTAB36MfFj
         Svh/3pJehueTm/PxJ1wO+4/PYCa6d98vYEP4P1uYb++zZLDtc2zACtqzRXP2OpBNLxUz
         oIzgu3WkID6NpVWhYPu60aDyhY8T6GcgXdZk2m1BPg11j8YcynH/I/uIgkjVPf0g9gJm
         AHcbzvzXX/ntjzpHp4tFpkwrrsRVUVEwt9U5eqwEWbNknZeTf6vFAZCFE9MTJsrWAkOL
         QceA==
X-Forwarded-Encrypted: i=1; AFNElJ+XzHYR9qdm1P2QC7mSU4aBeciAd1IPzIWkcMcBZD3jTn1Z7l5OTFiR8rsDVqBhkpgVdbgVg99yRwb5vMxoLS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP+5OApdqbRcpe2PpnQ3XualHYNLyWMoeSLefyQ8V589XbjxaV
	URknbLDmlb7wW2DkLORUVTCgFgXfXaZr+DG9xfrS5S9LKioXCjpvgpYeKSPtzyLq
X-Gm-Gg: Acq92OEfxxgDl4Zw/cSuBOw4uhrb4owmP6iGdBDhQxQDlIMP7t8U5s7SKxposgY4/DU
	gzkEQSST9zhaMKdc61I+Rn/0ApGnRZ1szDO0Lk33Sv5DLBe2coVXfRXTI/GltcqgeDRTCQhMffi
	QM3V5/Ju9mL64UNJb0hwwxDI2EhCP1S661MNy+RA20yq8iBAPzIgdfT/HuH93lrVeLL0fFMy7dP
	9SijyXVyJ2M2HzUy3NUmmjFEgohlUz+dGBnbi15i1CzgKUdn5GXM2RqOLPsw56G9mJ0olOtLDJR
	MiiPGIijAYaHGPEbLiNq+oKPMt3wcKaY4qlmMDxZNYEPIvz7g5ONqO/nmJTC0HUdf7npziSliih
	76QoiuxC3lWKGkAa0Biorm/VLuEqcJC1xN2CzbCGgFF3pLABVU8WnTWAapK0UlLm80pY65jfWii
	PqpZB93pDt4ZEyqTmrssdGqDMB1rdXvHw7a31nkMaTdHInVMuhachF2Rd1BJ+y
X-Received: by 2002:a05:6122:181f:b0:55b:d85:5073 with SMTP id 71dfb90a1353d-5760be92579mr10307337e0c.4.1779185343326;
        Tue, 19 May 2026 03:09:03 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760fa5c008sm7993711e0c.12.2026.05.19.03.08.59
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:09:01 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-95cc3522c40so2277914241.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 03:08:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/l37xNtdVqK8f/mZVfY9uldb6RPdh+5XWmmIvV2EE/thr/khQZgoMLvuW0/cmo+GhUQFlxxj0WffjYGYEQMxg=@vger.kernel.org
X-Received: by 2002:a05:6102:854d:10b0:650:94b2:b209 with SMTP id
 ada2fe7eead31-65094c2070fmr3495426137.4.1779185339284; Tue, 19 May 2026
 03:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com> <CA+V-a8t5NZP5QamrdH2-ViMcShcYh3czLsZ+0kkD_kjUodjTyw@mail.gmail.com>
In-Reply-To: <CA+V-a8t5NZP5QamrdH2-ViMcShcYh3czLsZ+0kkD_kjUodjTyw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 12:08:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZkD0VTdSc4VChuaLvEAZ1j=5_69u8Ef0tO+dwMi6JDw@mail.gmail.com>
X-Gm-Features: AVHnY4KXSTDQjh_29RoOYl4VnSgomB8DY9x_PMa5sxwN-vFAI033A9vKOGLVEQ8
Message-ID: <CAMuHMdUZkD0VTdSc4VChuaLvEAZ1j=5_69u8Ef0tO+dwMi6JDw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: Fix __counted_by handling after
 kzalloc_flex() conversion
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Tue, 19 May 2026 at 12:05, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Mon, May 18, 2026 at 12:08=E2=80=AFPM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, 13 May 2026 at 22:13, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Fix logic issues introduced by the kzalloc_flex() conversion in
> > > mmc_test_alloc_mem() due to interaction with the __counted_by
> > > annotation on the flexible array.
> > >
> > > Bounds-checking sanitizers rely on the counter field reflecting the
> > > allocated array size before any array access occurs. However, use
> > > mem->cnt both as the allocation size and as the runtime insertion
> > > index, causing incorrect indexing and potentially invalid bounds
> > > tracking.
> > >
> > > Initialize mem->cnt to the maximum allocated number of segments
> > > immediately after kzalloc_flex(), then use a separate local index
> > > variable to track successfully allocated entries. Update mem->cnt to
> > > the actual number of initialized elements before returning or enterin=
g
> > > the cleanup path.
> > >
> > > Also rewrite mmc_test_free_mem() to use a forward for-loop, improving
> > > readability and ensuring only initialized entries are freed.
> > >
> > > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>

> > > --- a/drivers/mmc/core/mmc_test.c
> > > +++ b/drivers/mmc/core/mmc_test.c
> > > @@ -316,11 +316,13 @@ static int mmc_test_buffer_transfer(struct mmc_=
test_card *test,
> > >
> > >  static void mmc_test_free_mem(struct mmc_test_mem *mem)
> > >  {
> > > +       unsigned int idx;
> > > +
> > >         if (!mem)
> > >                 return;
> > > -       while (mem->cnt--)
> > > -               __free_pages(mem->arr[mem->cnt].page,
> > > -                            mem->arr[mem->cnt].order);
> > > +       for (idx =3D 0; idx < mem->cnt; idx++)
> >
> > for (unsigned int i; ...)?
> >
> Ok.
>
> > > +               __free_pages(mem->arr[idx].page,
> > > +                            mem->arr[idx].order);
> > >         kfree(mem);
> > >  }
> > >
> > > @@ -341,6 +343,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(un=
signed long min_sz,
> > >         unsigned long page_cnt =3D 0;
> > >         unsigned long limit =3D nr_free_buffer_pages() >> 4;
> > >         struct mmc_test_mem *mem;
> > > +       unsigned int idx =3D 0;
> > >
> > >         if (max_page_cnt > limit)
> > >                 max_page_cnt =3D limit;
> > > @@ -356,6 +359,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(un=
signed long min_sz,
> > >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> > >         if (!mem)
> > >                 return NULL;
> > > +       mem->cnt =3D max_segs;
> > >
> > >         while (max_page_cnt) {
> > >                 struct page *page;
> > > @@ -375,23 +379,26 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > >                                 goto out_free;
> > >                         break;
> > >                 }
> > > -               mem->arr[mem->cnt].page =3D page;
> > > -               mem->arr[mem->cnt].order =3D order;
> > > -               mem->cnt +=3D 1;
> > > +               mem->arr[idx].page =3D page;
> > > +               mem->arr[idx].order =3D order;
> > > +               idx +=3D 1;
> >
> > While looking rather ugly, I think starting with mem->cnt at zero,
> > and updating it in each step like
> >
> >     mem->cnt++;
> >     mem->arr[mem->cnt - 1].page =3D page;
> >     mem->arr[mem->cnt - 1].order =3D order;
> >
> > would still be better, as it makes the dependency between mem->cnt and
> > the size of mem->arr[] clearer (located closer to each other), and ...
> >
> >
> Ok, I will start with mem->cnt at zero; with this I can drop changes
> in mmc_test_free_mem().

I don't think you can drop these changes, as mmc_test_free_mem()
does mem->cnt-- _before_ accessing mem->arr[mem->cnt].

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
