Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F964370AF3
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201516; cv=pass; b=frNxOjS3wAzcJ8D2/XoKSrFrU2aHPvj7Id4I14qHpZ2b9s/x9PWY0M1REBx9hcZ33Xyfmlv+6B+6yqBeZyfV/b+yzVog8fjykLijJlIM6mfRva8XcQKQXG3IyLtux3+1SBtudHdeYkda2bpis+XJsGdsTKkT+jFAakulvMCXHBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201516; c=relaxed/simple;
	bh=cj8fMYGGV50JmuPH7dRsygkr0LOScVOWkGLEok5hm1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyObCdjTM6R9qlvBDZYbolnblNRlM1JwYXpLadhqA8F48mFShjRoaqthn9EloNPCrSKPgjKrYiBzkTF+CD5FVUtlX9uo2qvr6G2wVQHdj0+O3t7Fcv5YV7s7T66AKsYhonuC50IsCk5grAZJzO8mjtRuqkgMR1Q+l5Tc6p7KsoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCaHPohZ; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCaHPohZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so3136092f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 07:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779201513; cv=none;
        d=google.com; s=arc-20240605;
        b=e1B3mYY1LJrAfpwVbBcSNDojnMXd2Vwf8jI6ma6iVILahKPEcAowHRfco1yGscZZvw
         NuQJK5O9RAoST7V1qVjpQ+82ecr0qi6AC9nZEeMQNHAHDYFRQKJT9sUycm4AoVvGFoVu
         iQ3IoQ7UD9nvZ6h4Divf2gmqB9VtYVXEMR/XGU6Q4NG5c66yefvu4aToW8MSj1R96JXr
         KStKJEzfaJqupMHC/HKzBL2BohTvbheq0fv1vm9RCk/P+PYJvCHQ2nxu7YWSJ5jPDN4y
         xFwGV+DK5HbwPPI0mP4bWFRHVaB+k5RH4a3NVx8IFyu/iCy02HMbfuzNHUyT4ITiUI8Q
         yTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8B0kUihN/kZA4O0Fnbmlk4Xoxc4WIG8UJmCytLrBe7g=;
        fh=OwsAZid2eo5sj2p0Pf9Q+fLpLkGwvii0dj0Cox6xQUY=;
        b=HDjYPzHlWs46uVFg9mvCWa5/xy85fIYL9UIW5Q3bGR98YOzoTHp+WZplVi6YX3CQH2
         n9N2A4yc6VkyyEI0VNWoCtmrPWmoUaPZeUriMKnbxmRWR+cZAXrW42LeFqcxnksjMTt+
         40BKwT2hGZFj3rsnd/VH7uvWuveQuHDsA8YkIYUZjYexV/4d68IBo9JKY4sqvzoev1nC
         j6sIkcPa15bqEvgj74AWCD5Aey3L2INpp3MQTaUtyqEpRpPXVh8NmnR5ATcW0crzQL+l
         eZqE/+xpDuTozBWHdyLO1tuGih0N4bewkiTwu1WIyarOJgSy2S0bLUox3nn634f+XYnT
         NgmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779201513; x=1779806313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B0kUihN/kZA4O0Fnbmlk4Xoxc4WIG8UJmCytLrBe7g=;
        b=NCaHPohZtYO/I58mVjHwW7twI6RUFQE4eNDYKyYezif9e7RdL8dQZq7BaQmz7XS/pC
         fNbXv8qhD1fFrFbMQwKnEn5HSjcR2liwTnnDxbEJrA7ypSldP+qVQGekw3Zky38fb3K4
         tQtiRolB+milGEmLfhOKvDL37UPxm9vboI5OqLIbsuVY9+bZ8/h5iTHRRqxlPF1FuMvV
         cxksloucOHcb2NKODfRraRJRh/PT5iqLq+sTHe19j5mq7GMath1hFT2R10lx0CaZXuVM
         9aZ7An2HgnpKjaIIVo47bnIpSjWlH7T5KfDCGGsmiOu081YD7TNMaeedE+fmNlp2DBf+
         engg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201513; x=1779806313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8B0kUihN/kZA4O0Fnbmlk4Xoxc4WIG8UJmCytLrBe7g=;
        b=jK0xz37AsIRjVlmPaIuZaOHZMTBG7NCUFwlmup4IBUgpFViRdVclcP1Ao/p/rKBw6U
         weRJ6XK6HqBmBQ+QZ+pqtSu9nYkV/hccU8QSOkxLxJRJpTKPLFPSPDQ9aqIP5FmZfQRY
         AVH932WPQbdwNyaAW6W8Kg2wY+I3oWBAUOrQwk9vcFFBcFEZJFjOglb0LywcjoxfSNuW
         sKqj+WNWdjsLdG/R6QCNLb1cwsxxCnLM14E/MNhGYgFEPh5V/15ZGR1l9cxsHKFTA4Z0
         hyq643O5eTxtdMOGljaddeSi/xh20sap44FmYJD8S5wE4IXrvDYwjRDPtRmX6+XA7D8N
         7xeg==
X-Forwarded-Encrypted: i=1; AFNElJ9CpkPhGbtQJSYOs3GwnW2KJn6BxHMrIBgWeU3nztAq0HCHluW9IWGgeGrYMUHud9TUkUpQfqWp+wimLZMpqCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywye89X2+1d4BGdN+xgvR0r9wKx/8glR4PR4rTBF8h3xqlyAW+p
	Nnz6pr9UxvKRhDpTtQ6jf5aoDS80e8fCTjb68okJz1WGzDVw8CZylmSf8FDdJwV5I1kKjrD+IgK
	ozpwuoBT/YnG2cRVqKYxi0XEwLYbYW6s=
X-Gm-Gg: Acq92OFbQI5pr+bs6nartxOUvbb1jisFlTRzrMPA3XmgwD6EUuFvP3Md4PaUn6tVjn2
	Omuc7Eyi9wSAHq0LFVo6VjT0ag95sPv8jxKemrYpicLmqiE4VYNiyV1lkqrIzeV+Jjqz9REetZN
	zSCETh6cmZOrXIilWBklyzZg/ZyeO7tokyz3TXenj//2PQybSAC6758INq2M1lTiIfso4bi7XNv
	cxd0kSQBqjK2TjNTmtJpyxpZpFhff1i8Zq+Abu+JcmURXt28bEaD6II4O8qU2H5FbXnCcD764M6
	gikiDm8uQ99pu67eqK1Lattjb8j3h/1RUpPqt5ESr/doLpvpQAn9GDDAGjp3Q6mzLhlO
X-Received: by 2002:a5d:64c6:0:b0:43d:210:2b2d with SMTP id
 ffacd0b85a97d-45d958e057cmr39062509f8f.31.1779201513379; Tue, 19 May 2026
 07:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
 <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com> <CAMuHMdWZGv6BwjGwRhU+x8iE2pXtOSz21RG64bsNoPQQCjTVjg@mail.gmail.com>
In-Reply-To: <CAMuHMdWZGv6BwjGwRhU+x8iE2pXtOSz21RG64bsNoPQQCjTVjg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 15:38:06 +0100
X-Gm-Features: AVHnY4KUmVmbQaA9sHRIcWj7rBu76G43r-b8iP8pGkSNUit944VTI5cgfQcFjvU
Message-ID: <CA+V-a8ujJ5AL8S6DABmZjmJbXMQ=umPDCZZfXsgyuj-9mTt3GA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, May 19, 2026 at 2:55=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 19 May 2026 at 15:44, Lad, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > On Tue, May 19, 2026 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com> =
wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Fix an counter tracking in mmc_test_alloc_mem() that causes a kerne=
l panic
> > > > during error unwinding.
> > > >
> > > > The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation o=
n its
> > > > flexible array member `arr`. While kzalloc_flex() initially sets th=
e
> > > > counter field (`cnt`) to `max_segs`, the allocation loop needs to t=
rack
> > > > how many elements have actually been populated.
> > > >
> > > > Previously, leaving `mem->cnt` at `max_segs` meant that if the loop=
 failed
> > > > midway (e.g., "Failed to map sg list"), the error unwinding path in
> > > > mmc_test_free_mem() would attempt to clean up uninitialized trailin=
g
> > > > array slots. This resulted in passing NULL pointers to __free_pages=
(),
> > > > triggering a kernel panic:
> > > >
> > > >   [   66.172845] mmc0: Failed to map sg list
> > > >   [   66.176722] Unable to handle kernel NULL pointer dereference a=
t virtual address 0000000000000000
> > > >   ...
> > > >   [   66.432747] Call trace:
> > > >   [   66.435191]  ___free_pages+0x1c/0xc4 (P)
> > > >   [   66.439119]  __free_pages+0x14/0x20
> > > >   [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
> > > >
> > > > Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> > > > allocation. Then, move the existing `mem->cnt` increment so that it=
 occurs
> > > > prior to populating each array slot, using `mem->cnt - 1` for the a=
ctual
> > > > assignment index. This guarantees that the counter accurately track=
s
> > > > initialized entries for safe error cleanup, while dynamically expan=
ding
> > > > the `__counted_by` validation boundary ahead of each flexible array=
 write.
> > > >
> > > > Additionally, rewrite the cleanup loop in mmc_test_free_mem() to us=
e a
> > > > standard forward for-loop. This addresses the unsafe post-decrement=
 logic
> > > > in the original `while (mem->cnt--)` loop which evaluated and decre=
mented
> > > > the counter field before indexing the array, and avoids a potential=
 integer
> > > > underflow/wrap-around of the counter field if the cleanup path is i=
nvoked
> > > > when `mem->cnt` is 0.
> > > >
> > > > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > > > ---
> > > > v1->v2:
> > > > - Started with cnt =3D 0 and incremented before assignment to ensur=
e
> > > >   accurate tracking of initialized entries in mmc_test_alloc_mem().
> > > > - In mmc_test_free_mem(), replaced the while loop with a forward fo=
r-loop to
> > > >   safely iterate over initialized entries without risking underflow=
.
> > > > - Updated commit message to clarify the issue and the fix.
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/mmc/core/mmc_test.c
> > > > +++ b/drivers/mmc/core/mmc_test.c
> > > > @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_m=
em *mem)
> > > >  {
> > > >         if (!mem)
> > > >                 return;
> > > > -       while (mem->cnt--)
> > > > -               __free_pages(mem->arr[mem->cnt].page,
> > > > -                            mem->arr[mem->cnt].order);
> > > > +       for (unsigned int i =3D 0; i < mem->cnt; i++)
> > > > +               __free_pages(mem->arr[i].page, mem->arr[i].order);
> > > >         kfree(mem);
> > > >  }
> > > >
> > > > @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > > >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> > > >         if (!mem)
> > > >                 return NULL;
> > > > +       mem->cnt =3D 0;
> > >
> > > This is not needed, as it is set to zero by kzalloc_flex().
> > >
> > Actually, kzalloc_flex() automatically sets mem->cnt to max_segs
> > because cnt is annotated with __counted_by. Because of that implicit
> > initialization, we need this explicit reset to get it back to zero.
>
> Only when your compiler supports it[1].
>
> OMG...
>
> When I commented on the LWN.net article[2], I considered only the case
> where the compiler is too old, and the counter stays at zero when the
> user forgets to initialize it explicitly.  Now we have the opposite
> case, where we need the counter to stay at zero :-(
>
Yeah, it definitely introduces some tricky, asymmetrical behavior
depending on the toolchain.

Cheers,
Prabhakar

> [1] https://elixir.bootlin.com/linux/v7.0.9/source/include/linux/compiler=
_types.h#L549
> [2] https://lwn.net/Articles/1063295/
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
