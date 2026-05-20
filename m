Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A530F934
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262887; cv=none; b=Qy2UJ+PusF33LnaOoKH2DlqwhJIsMs9v9FjefqbgCm6plewl35HCNo4VcgwDos4XsHlBSWE/dPAnPnksZ6p6S5c3pvTo7aLhspg6m67KW5uZlq6IZnEDusE6+K4Qa/rZSBENdOXVK7Q8v/UFMqunMpAg3qrVk/MrtadiGLjhD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262887; c=relaxed/simple;
	bh=GGC3bFBP/3ByVZ/MY3UquCkN0tW0C4a1P7AtWMjyi9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNnKg+6mvtjCYtyBdcci08iulUl//gg6yJuk3sp2l8oSaBLOTCdM2HMO0E2DpX1OzGgKnAMUUEMXmZjfuZWNHhe/FF6fBWzq7MzAu8I/Z3nMXcXSBh5OvvyLTe9XI7UBofuDvsAotGDVmFD/n/Dufx/rQaRHBv1vl86vgyiPzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-95cd9a5f24cso1094761241.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 00:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262884; x=1779867684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UZhaROgHXzu5fMLFg999WSqpULkYuqJChVRCQj6qLHE=;
        b=kxSPIMz/0CS7cI3lngO72PB1BfknBKMJhP+7s/u+dhAqhuUlQSadk140pVUDUYWCmY
         HXTznY29r4vCMfjo7mGSMx+NgVLF+vkcBY5vOD2W381DQAigdJpLEQJEkALJGwZVej8L
         kXZoxuKwmWjK3VRvs33/AsMHRrpD/f7cYTcxzj6NbRK7eaMbglidMaAUbS0MB2uWb/p9
         ZFeawN4hXJO1d5HF+aX9upN9tsnPZ2dnZZLH9J2hSBZNeku5SUK2Jv7aPCPyEDMe8653
         ff0qA5fonXyXKCp6+cZx/VOsg8nSyfQIKGOzNtfCkkk0pv8hl/oUObvCoZ8Zx8mbscYn
         7/Vg==
X-Forwarded-Encrypted: i=1; AFNElJ9YUbbSNrY6GJWiwTcF4uSANIYxavVpryA6QWrgwSsb9ELTPWkYcxNy5+zu85EqpneqoBWkQxBOjiZH1g3R5Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGuoGzOLaG27lJjC88ujbC9X1soFd2yQMDYNM9DOYu7iLrWmTv
	EbCOgHNO5bbpZCRBCjXkWYhmllcaQ8veNBpR14E0XHKeVWEezdb8VAntZmKOso8j11s=
X-Gm-Gg: Acq92OHfHamx8eucQu8B7Z5kEkd64/sMXCqOpD+87Nn39+QMF5sBcThvjlUJ2z5WEk+
	fjhsbRYc/c5NG/SPAQfnnHLQXcDfuRiysIxcNplu9V2OKo+OI5eo0oY9bjBjzUwyreQIaU7omhd
	2BHdQzyo7uBmsPZNAF9oUX+gWu2WRlJm0va7FXI5ZfQ0k4jiUm0F+ds/ZTuLsLexeRT0lCKwPvt
	Eo/fg1OMvqA3ysQ4QdN9RfARxd0puboYN3nWujTFpChJSytPRvP/ZvvGi70rYpowS477FlZ4x4R
	LhlhUifs74dDL1iYvF7fDxiHQZdolKUVmvY6XHNS1CGRo6TQ/XKxhRGBddOeaCKDO+BWpLglhxC
	7SX7F4OL5cP99KGsok6HipaF41wCIvMYz4g8HsEUmC2NzJjjNRu2xjsGryAYc8S5dWUzv8VjsX1
	jIQuy10CfOUnr2PusdHWojrO9BcZZ4cDSgF4chZe9q65F9aPnvbgauvHtafqgX
X-Received: by 2002:a05:6102:956:b0:612:21f8:5afd with SMTP id ada2fe7eead31-63a3d94e0ebmr11108013137.12.1779262884183;
        Wed, 20 May 2026 00:41:24 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2d324a6sm7738562241.7.2026.05.20.00.41.23
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:41:24 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-95d0476492eso1093856241.3
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 00:41:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ZX4jb6N212SSwzQcyRT79POR1Z4rbNqIUizZI8G/EttfTiu9XbS/KRqZ0b36YnsGjEEPTq41k6JMMmGcsOUw=@vger.kernel.org
X-Received: by 2002:a05:6102:f85:b0:631:4d87:ba5f with SMTP id
 ada2fe7eead31-63a3d0182e9mr12079127137.3.1779262883651; Wed, 20 May 2026
 00:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
 <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com> <18c41409-e1d1-4877-87a6-1c3156f943aa@embeddedor.com>
In-Reply-To: <18c41409-e1d1-4877-87a6-1c3156f943aa@embeddedor.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2026 09:41:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVznvSLr+ap3QwawZdu8fc4dZjpkWi7wgUA815KRfCgEQ@mail.gmail.com>
X-Gm-Features: AVHnY4IbN4gvBXfEdCbvoV1Bz24wCmRs3C2Yr4J_UWX62ZxMsTA07ZYlhMORYx0
Message-ID: <CAMuHMdVznvSLr+ap3QwawZdu8fc4dZjpkWi7wgUA815KRfCgEQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, 19 May 2026 at 20:44, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> On 5/19/26 07:44, Lad, Prabhakar wrote:
> > On Tue, May 19, 2026 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> >> On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> Fix an counter tracking in mmc_test_alloc_mem() that causes a kernel =
panic
> >>> during error unwinding.
> >>>
> >>> The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation on =
its
> >>> flexible array member `arr`. While kzalloc_flex() initially sets the
> >>> counter field (`cnt`) to `max_segs`, the allocation loop needs to tra=
ck
> >>> how many elements have actually been populated.
> >>>
> >>> Previously, leaving `mem->cnt` at `max_segs` meant that if the loop f=
ailed
> >>> midway (e.g., "Failed to map sg list"), the error unwinding path in
> >>> mmc_test_free_mem() would attempt to clean up uninitialized trailing
> >>> array slots. This resulted in passing NULL pointers to __free_pages()=
,
> >>> triggering a kernel panic:
> >>>
> >>>    [   66.172845] mmc0: Failed to map sg list
> >>>    [   66.176722] Unable to handle kernel NULL pointer dereference at=
 virtual address 0000000000000000
> >>>    ...
> >>>    [   66.432747] Call trace:
> >>>    [   66.435191]  ___free_pages+0x1c/0xc4 (P)
> >>>    [   66.439119]  __free_pages+0x14/0x20
> >>>    [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
> >>>
> >>> Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> >>> allocation. Then, move the existing `mem->cnt` increment so that it o=
ccurs
> >>> prior to populating each array slot, using `mem->cnt - 1` for the act=
ual
> >>> assignment index. This guarantees that the counter accurately tracks
> >>> initialized entries for safe error cleanup, while dynamically expandi=
ng
> >>> the `__counted_by` validation boundary ahead of each flexible array w=
rite.
> >>>
> >>> Additionally, rewrite the cleanup loop in mmc_test_free_mem() to use =
a
> >>> standard forward for-loop. This addresses the unsafe post-decrement l=
ogic
> >>> in the original `while (mem->cnt--)` loop which evaluated and decreme=
nted
> >>> the counter field before indexing the array, and avoids a potential i=
nteger
> >>> underflow/wrap-around of the counter field if the cleanup path is inv=
oked
> >>> when `mem->cnt` is 0.
> >>>
> >>> Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >>> ---
> >>> v1->v2:
> >>> - Started with cnt =3D 0 and incremented before assignment to ensure
> >>>    accurate tracking of initialized entries in mmc_test_alloc_mem().
> >>> - In mmc_test_free_mem(), replaced the while loop with a forward for-=
loop to
> >>>    safely iterate over initialized entries without risking underflow.
> >>> - Updated commit message to clarify the issue and the fix.
> >>
> >> Thanks for your patch!
> >>
> >>> --- a/drivers/mmc/core/mmc_test.c
> >>> +++ b/drivers/mmc/core/mmc_test.c
> >>> @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_mem=
 *mem)
> >>>   {
> >>>          if (!mem)
> >>>                  return;
> >>> -       while (mem->cnt--)
> >>> -               __free_pages(mem->arr[mem->cnt].page,
> >>> -                            mem->arr[mem->cnt].order);
> >>> +       for (unsigned int i =3D 0; i < mem->cnt; i++)
> >>> +               __free_pages(mem->arr[i].page, mem->arr[i].order);
> >>>          kfree(mem);
> >>>   }
> >>>
> >>> @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(un=
signed long min_sz,
> >>>          mem =3D kzalloc_flex(*mem, arr, max_segs);
> >>>          if (!mem)
> >>>                  return NULL;
> >>> +       mem->cnt =3D 0;
> >>
> >> This is not needed, as it is set to zero by kzalloc_flex().
> >>
> > Actually, kzalloc_flex() automatically sets mem->cnt to max_segs
> > because cnt is annotated with __counted_by. Because of that implicit
> > initialization, we need this explicit reset to get it back to zero.
>
> An auxiliary variable could be used to avoid having to update the
> counter too early[1][2].

Thank you!
In light of this, Prabhakar's v1[3] is the better solution.
But perhaps that the addition of "mem->cnt =3D max_segs;" after the
kzalloc_flex() should be dropped, as it is done automatically by
compilers that support __counted_by, but is irrelevant for compilers
that do not support it (the correct value is set at the end anyway).

Gustavo, what do you think?

> I think it'll eventually become best practice to defer updating the
> counter until after the flexible array has been fully initialized, or
> after every major update that requires changing its boundaries.

In case the update is a _decrease_.
If the update is an _increase_, it must be done first?

> [1] https://git.kernel.org/linus/ea9e148c803b24eb
> [2] https://embeddedor.com/blog/2024/06/18/how-to-use-the-new-counted_by-=
attribute-in-c-and-linux/
> (I'm in the process of updating this blogpost with some *alloc_flex() exa=
mples and more.)

[3] "[PATCH] mmc: mmc_test: Fix __counted_by handling after
kzalloc_flex() conversion"
    https://lore.kernel.org/20260513201315.3186621-1-prabhakar.mahadev-lad.=
rj@bp.renesas.com

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
