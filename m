Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73559369D5D
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198925; cv=none; b=av+XfIhcWuDJnkki8YwjbpaRAYGV1xDBa0LWsoiUCfX++SwLULBHYXPqYOLjoqQUJ7sU+c462bwoa9NwgCDsOzxHhQ72jkbjrwcA7FTG7H99kE8ZniC+VR2ctoD/LoZKBLWwPjUlHBUbWM4t6k2BaCYWbRrkavjpOVroYQH8ggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198925; c=relaxed/simple;
	bh=ropJiXj/HBYvwp5Msa8W8dOE9wVAViMdDjVNcwFpVB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3SdlmAGGvRwMIO0vwSUkhVm34dpk0kO9y6VQvKdM39gHlbWrZv604ZlJy7diGhm9T1dI/M+p0XKSGVyVvMGuv+fmdl6ZxKVqLkXGnAXhokvYV30hJi2rMutLh+lcf1gTEX/Dfidgx8Ow5TO94wrCwSXyZlvI9rLnVr8w1WY1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6313c800372so2730523137.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 06:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198922; x=1779803722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hf4+Ek9YRT6fN0h/tFO9bOB6UgGg8JC36KgrKL0v3M=;
        b=evdBNFUTvHTm2xN5NgMVABPmGuckfHCQOT6MsZJ/QskgJjmjPwa6vqiAYOPJG9b4Fg
         0+rozadfN1rb/nVB8JkpF3C996jf09a9rzSXJsCaaimtqV/FV7+10WQLO9gilKmYrijv
         llYTqbhkY+JmfaMQbU2YG89rDBPPIYNJOmf9dUrNBs96nuhvRttICgdEjptEICkBbl5Z
         XVNNZ6/WTPUqtYVHoirtPdYJexrhsLls3La87/LJUtrdzNKH9/6BNSp9yPslbq0JG28g
         A81aeEX9I1167w0k6ALm/FEUd0CgpXJTsz1O4yhIckE60PqB/ParxJIU1kADXT3D4Ys4
         Y2Og==
X-Forwarded-Encrypted: i=1; AFNElJ+v41Zquyd8LQ3edGylLmtIOzbU1SkiK3LRLZyiTtewr9n75ebFulE/5S/VYlsPfTlBywJ10QFTwSSk0Pts4wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynO5v++2AyQMim6a1LFihHE7m4KLIFlp/hQkBQqP8XD5NPmXqs
	KYMqCnREG7Z0NchLvgBAro9bEs2dWzBSKqLI1zL4bd+zrpQJhe0PDzYyYSDHllZu
X-Gm-Gg: Acq92OFXpcZ2iGUfj+dtN9sO1XoEJMoVqTENz+eyq/upGpq/6iTN22/n705/XIUywNX
	qZLGc7ztt3Nrl86kVySlzQpl4hJL9JIEVCKfHYrSfsai7eacAMRcxl7IJzkoMlAX40yYD+vYter
	EB5XqRHoamAFRG2GKj/MoSGw+XA2G4rMOKbJogZ26GesbhLR8IYn85RHOIg3LGRleNnM4cQFxgW
	ay6THgGfEcE+Tr54JS4NqN0mdKaHY9XJB26OGU4jlKmwN2s7aXm9YD2y+gyefB6fOqW9sln7xky
	kY/Ct2uAS7lviIFttO9ArBZNlst9mPW1qS+mmbYHcnK47n3mmEVJ2NtIoTV9uFaC6b+yiv2CgrL
	vAeqxLI6Mi030EcZjlHMtQhFheUkWO0s4J1pMlWbmEy8DZtYJuy/or+K2byKpW0ox5wsAbnq+6A
	n6dMuAHZDrNasTic9FwzeORuy3SdzcDhLWQG7qRENRbF9NOAIOYIbfJDyCc0pGnra2
X-Received: by 2002:a67:e105:0:b0:607:95f4:53b5 with SMTP id ada2fe7eead31-63a3cc0dc18mr10991110137.4.1779198922185;
        Tue, 19 May 2026 06:55:22 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-63ccf18bd92sm6250194137.3.2026.05.19.06.55.19
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:55:20 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-575267e3398so2956736e0c.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 06:55:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8OF2YeiqYMAiPyWpCdsIH5b4JWfbBVxUqo0hLjB7tfUlSbIhiLoJuugNqgT++s/qWVn7GCJ6R4vXzM57HrY1s=@vger.kernel.org
X-Received: by 2002:a05:6122:4b8c:b0:56c:ca03:b668 with SMTP id
 71dfb90a1353d-5760bfb8ca9mr10883102e0c.3.1779198919511; Tue, 19 May 2026
 06:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com> <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com>
In-Reply-To: <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 15:55:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWZGv6BwjGwRhU+x8iE2pXtOSz21RG64bsNoPQQCjTVjg@mail.gmail.com>
X-Gm-Features: AVHnY4If75BE1VFsoTcZFsczakSSYimGh11UdyDyK4f5gTnPlxJ8oEAkRkMK1OM
Message-ID: <CAMuHMdWZGv6BwjGwRhU+x8iE2pXtOSz21RG64bsNoPQQCjTVjg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Tue, 19 May 2026 at 15:44, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Tue, May 19, 2026 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Fix an counter tracking in mmc_test_alloc_mem() that causes a kernel =
panic
> > > during error unwinding.
> > >
> > > The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation on =
its
> > > flexible array member `arr`. While kzalloc_flex() initially sets the
> > > counter field (`cnt`) to `max_segs`, the allocation loop needs to tra=
ck
> > > how many elements have actually been populated.
> > >
> > > Previously, leaving `mem->cnt` at `max_segs` meant that if the loop f=
ailed
> > > midway (e.g., "Failed to map sg list"), the error unwinding path in
> > > mmc_test_free_mem() would attempt to clean up uninitialized trailing
> > > array slots. This resulted in passing NULL pointers to __free_pages()=
,
> > > triggering a kernel panic:
> > >
> > >   [   66.172845] mmc0: Failed to map sg list
> > >   [   66.176722] Unable to handle kernel NULL pointer dereference at =
virtual address 0000000000000000
> > >   ...
> > >   [   66.432747] Call trace:
> > >   [   66.435191]  ___free_pages+0x1c/0xc4 (P)
> > >   [   66.439119]  __free_pages+0x14/0x20
> > >   [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
> > >
> > > Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> > > allocation. Then, move the existing `mem->cnt` increment so that it o=
ccurs
> > > prior to populating each array slot, using `mem->cnt - 1` for the act=
ual
> > > assignment index. This guarantees that the counter accurately tracks
> > > initialized entries for safe error cleanup, while dynamically expandi=
ng
> > > the `__counted_by` validation boundary ahead of each flexible array w=
rite.
> > >
> > > Additionally, rewrite the cleanup loop in mmc_test_free_mem() to use =
a
> > > standard forward for-loop. This addresses the unsafe post-decrement l=
ogic
> > > in the original `while (mem->cnt--)` loop which evaluated and decreme=
nted
> > > the counter field before indexing the array, and avoids a potential i=
nteger
> > > underflow/wrap-around of the counter field if the cleanup path is inv=
oked
> > > when `mem->cnt` is 0.
> > >
> > > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > v1->v2:
> > > - Started with cnt =3D 0 and incremented before assignment to ensure
> > >   accurate tracking of initialized entries in mmc_test_alloc_mem().
> > > - In mmc_test_free_mem(), replaced the while loop with a forward for-=
loop to
> > >   safely iterate over initialized entries without risking underflow.
> > > - Updated commit message to clarify the issue and the fix.
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/mmc/core/mmc_test.c
> > > +++ b/drivers/mmc/core/mmc_test.c
> > > @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_mem=
 *mem)
> > >  {
> > >         if (!mem)
> > >                 return;
> > > -       while (mem->cnt--)
> > > -               __free_pages(mem->arr[mem->cnt].page,
> > > -                            mem->arr[mem->cnt].order);
> > > +       for (unsigned int i =3D 0; i < mem->cnt; i++)
> > > +               __free_pages(mem->arr[i].page, mem->arr[i].order);
> > >         kfree(mem);
> > >  }
> > >
> > > @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(un=
signed long min_sz,
> > >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> > >         if (!mem)
> > >                 return NULL;
> > > +       mem->cnt =3D 0;
> >
> > This is not needed, as it is set to zero by kzalloc_flex().
> >
> Actually, kzalloc_flex() automatically sets mem->cnt to max_segs
> because cnt is annotated with __counted_by. Because of that implicit
> initialization, we need this explicit reset to get it back to zero.

Only when your compiler supports it[1].

OMG...

When I commented on the LWN.net article[2], I considered only the case
where the compiler is too old, and the counter stays at zero when the
user forgets to initialize it explicitly.  Now we have the opposite
case, where we need the counter to stay at zero :-(

[1] https://elixir.bootlin.com/linux/v7.0.9/source/include/linux/compiler_t=
ypes.h#L549
[2] https://lwn.net/Articles/1063295/

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
