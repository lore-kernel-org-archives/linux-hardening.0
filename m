Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A814F369D61
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198276; cv=pass; b=lgPNDm/H6E9AiYm5yZNCA+Fq/dwAotEUmy00kwKYj+CjSBZWMpw/pIPiM6Lt656+C6FC8vWrxdArI/wf2Z2vgOiCJqrOUFu2xX72nmz9u3hsS52gP1/sC+DpCVpr/bCkQtL0vpCK+Rwq4gesyP3Zo4rRmYg29BtbNVh6TIVdA/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198276; c=relaxed/simple;
	bh=opOVFODQci9HR/5dFhKBBRniDOSVqW6FnIkz8KfOIxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzpE9rzcTlTDTASVKJTnKdyVUjZ091z4CjpdtNl4Rb3bjxAWTLiNf2QHdZwcVeLkM6kVoj8aUVJV9STpXyfmaVwGva7flhj7TwJgtxukgVVnznnyCqRp5Pk2MDebUmdj52gaciz9Dvw+X+xMPHsY78r7YcoUOpYaOSKHDTZqJbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeY/hFnH; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeY/hFnH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45d96d21e82so2109830f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 06:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198273; cv=none;
        d=google.com; s=arc-20240605;
        b=lTGqhHeWrPSAePgxkE7SSUi2Rs/equoaztFAMKJPm6XZbxj87EoOhB/lboXRtwOjC2
         Lu7JS+39ymn0u0YavgArU6WpcKR5Mrm/AuLN812lDvjClqe9YmWoRU9nMBuxzS+KraRL
         g8FkUQ46rzRcmiP7hXM6UoXlm+CJxVKrUEndVSfr+rH2A6cjSd15G/541Bx1pyplwnI4
         Of390vZ/kcvV5vsEbtRitGvsMMo2hsp+bMuFGImYCxAX05aPylu33X/RdrXDGQo2H0xz
         Ldy3YF/fv37tTk/WQxK81D8aNYoieP3o6BakneZfKVHbR7ZPjtKTc5fRyszp+BS6rnCM
         8NTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O+YkZX+39OPcemnQqAhpYtGbTbuu0be2yB+wxTeVaUo=;
        fh=qGq5vq2yyf9Af/XK+puBQ+S9SRO+42zg8rbKlZ/QP+4=;
        b=Z5JxpGPbUPgsTiuMaBuiMcZuKfKfXs+GSy0YmhT0cCsWiRF0MzTxuHtV/D1bSIRvUX
         jVQsYoiYcch87Yj5HtdLhBwnD6xtGYsl3od0l954y6TBBJn50fMlMleFlo9lIOTF5Gzb
         s6kMZJOkXO3eqjAMNL520WGqUo2qVcVjBhERD8Tu63ndY79RMzAZhxGTNBu1n90QM+8o
         H7pahg7kUAceVByALTdMDEdM8kGhf5+nNKy7cGOeqpGJI8Nbelg/03IRRuaFRIeMvK0G
         CFFep27YDF7nrOQL7Z70shwBDO0c8fWJ2ukxC4RF/h16OATJQDJ1zXpqRhdikBLA0Mp0
         BsSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198273; x=1779803073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+YkZX+39OPcemnQqAhpYtGbTbuu0be2yB+wxTeVaUo=;
        b=UeY/hFnH5Fm3/Z+luDGQ6LJAttiECk9Esn624YcdJOtKUQe3FRzSTGJb3SWq1z9YHB
         cKTX+NwXMnzqbTGHg+hy4HP3wFndSIoYngLayx6hOifGmoxj8nKTBHBoe5AgyWznb/Y4
         jxNOr0Jg+3mh0exey/zr0wg4bQyli6qCXgeq2gHWm7MBU9NpTEbvzBS0XcYTeTQdn/sS
         /WJtHojhyd+VHFYNVvgDY4RZ8Hm2ay4QVxTBEf28g5uy02b7IOm5h/5JMIuxIbAYwbq/
         7VC6qV08pikIu53Wy3H0XpYJ1QuASddZAZZPd/lv/2prxgrm1CtSA0wBFQAs0NDq+5Wc
         wTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198273; x=1779803073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+YkZX+39OPcemnQqAhpYtGbTbuu0be2yB+wxTeVaUo=;
        b=rhN7UgMIOeo9cRLMTvwxgQeiwwLtYrCylTPyJ6UdC9LnkNoBuboujV7M8t+sIPTJYn
         ZI98rd0gUOZscd/H8T8YUUfMU8GG8gsDhLGgQsPjqMrep50pi6beySDo/1J+PAZqmI0O
         5qQeeyzYiOO2sihTV2gXYaCGj8x+IO2NxfUVGEAntA7oXhM4Raz6J5V4FFnZiNP2sy9h
         JJTvE+uDD9CHcmTMpqaWGguV6iUmkGmMenkEACjblkycp+KuAHgcksl+fzwq0iROlE1Z
         /3P6uNE3OMsFaaNqZvX2JnP9t8TlJzTYQJcAQ2Jx4jiZbzMkAMVTpVKqe+/w8jyH38ua
         F6qQ==
X-Forwarded-Encrypted: i=1; AFNElJ87k6rGTBJcDtYaBzILKl+QhC5Te6CBp4e0xDBxKL7HX7ZNfa6iSTSjDKUNbluW/xHxYnWWHvIhvEfGO3zXTdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjvZ5wjo0FI231Mi9laRXeoMR4l+Lj7NpST+v5zSPIZbGhcw8
	3RgvbB3dFMS32a6xPilobidITCEsu3fleYQonm2i1NQ/Uaks+cwZF2JaW1ZaAobp+aXR8OafYi/
	qCyXUhoo2HsEi2ZKMePUWDgKkzvOlaZg=
X-Gm-Gg: Acq92OEnR6hF2JYIYxCecQKCREN2dc2LpXHyGatoIxDD+v/XdGR7SBElR8aaNYtEJVJ
	xBBSXnuB4jFfUeMB5K6wBPsbtEN9Mr1zQU6QGFBBhPCiaqtSjxvtFpxecuZcghIiqntgD/z5CLx
	A4D1TsZRn65zhV1qPaOjBeq3fJ7OQikO1JfkXNgoM6+7J4jtTxAgsWhudbM8H1BzcEnNSj0aVA2
	VuRGrwF175891eEBlsh3Pt6inSoI97oyXVkidzGSyv55sVVkeBJzXlEz47Y3a6JazHpcjeiAvPw
	S/VeTm68+8tLEQlqRrEub9BQSSiYHkR9t7CKustcHok8G5E3o6Ic0AT/86MW7wHT7Sg1
X-Received: by 2002:a05:6000:25c7:b0:452:79c0:f7f1 with SMTP id
 ffacd0b85a97d-45e5c349e9amr32067188f8f.0.1779198273012; Tue, 19 May 2026
 06:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
In-Reply-To: <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 14:44:05 +0100
X-Gm-Features: AVHnY4K_DFHUucHBZroz2WyX0_7Z_w5XdSocDRcWygqdYSVku2G-sqkFB5JtEaE
Message-ID: <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com>
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

Thank you for the review.

On Tue, May 19, 2026 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Fix an counter tracking in mmc_test_alloc_mem() that causes a kernel pa=
nic
> > during error unwinding.
> >
> > The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation on it=
s
> > flexible array member `arr`. While kzalloc_flex() initially sets the
> > counter field (`cnt`) to `max_segs`, the allocation loop needs to track
> > how many elements have actually been populated.
> >
> > Previously, leaving `mem->cnt` at `max_segs` meant that if the loop fai=
led
> > midway (e.g., "Failed to map sg list"), the error unwinding path in
> > mmc_test_free_mem() would attempt to clean up uninitialized trailing
> > array slots. This resulted in passing NULL pointers to __free_pages(),
> > triggering a kernel panic:
> >
> >   [   66.172845] mmc0: Failed to map sg list
> >   [   66.176722] Unable to handle kernel NULL pointer dereference at vi=
rtual address 0000000000000000
> >   ...
> >   [   66.432747] Call trace:
> >   [   66.435191]  ___free_pages+0x1c/0xc4 (P)
> >   [   66.439119]  __free_pages+0x14/0x20
> >   [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
> >
> > Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> > allocation. Then, move the existing `mem->cnt` increment so that it occ=
urs
> > prior to populating each array slot, using `mem->cnt - 1` for the actua=
l
> > assignment index. This guarantees that the counter accurately tracks
> > initialized entries for safe error cleanup, while dynamically expanding
> > the `__counted_by` validation boundary ahead of each flexible array wri=
te.
> >
> > Additionally, rewrite the cleanup loop in mmc_test_free_mem() to use a
> > standard forward for-loop. This addresses the unsafe post-decrement log=
ic
> > in the original `while (mem->cnt--)` loop which evaluated and decrement=
ed
> > the counter field before indexing the array, and avoids a potential int=
eger
> > underflow/wrap-around of the counter field if the cleanup path is invok=
ed
> > when `mem->cnt` is 0.
> >
> > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - Started with cnt =3D 0 and incremented before assignment to ensure
> >   accurate tracking of initialized entries in mmc_test_alloc_mem().
> > - In mmc_test_free_mem(), replaced the while loop with a forward for-lo=
op to
> >   safely iterate over initialized entries without risking underflow.
> > - Updated commit message to clarify the issue and the fix.
>
> Thanks for your patch!
>
> > --- a/drivers/mmc/core/mmc_test.c
> > +++ b/drivers/mmc/core/mmc_test.c
> > @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_mem *=
mem)
> >  {
> >         if (!mem)
> >                 return;
> > -       while (mem->cnt--)
> > -               __free_pages(mem->arr[mem->cnt].page,
> > -                            mem->arr[mem->cnt].order);
> > +       for (unsigned int i =3D 0; i < mem->cnt; i++)
> > +               __free_pages(mem->arr[i].page, mem->arr[i].order);
> >         kfree(mem);
> >  }
> >
> > @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsi=
gned long min_sz,
> >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> >         if (!mem)
> >                 return NULL;
> > +       mem->cnt =3D 0;
>
> This is not needed, as it is set to zero by kzalloc_flex().
>
Actually, kzalloc_flex() automatically sets mem->cnt to max_segs
because cnt is annotated with __counted_by. Because of that implicit
initialization, we need this explicit reset to get it back to zero.

Cheers,
Prabhakar
