Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1654C9576
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194953; cv=pass; b=T/oCN6JonhCuYGe4sER7YDEv0xaddPDmzzRXQrIm0q3+980UQRgu0UvgN7TG4uTqvqq2kbWlh1A3Ggb4060HIcufLwcytvITe8LYIqix5MR1AVZelWRe618kqqJZg64FoGDqMtjJ9ek5v2Swde9vlCH0AJbUcbAM6f89Og/GXfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194953; c=relaxed/simple;
	bh=z5bbYmTfV3f1fUZkdMtjKau2veIkDy6z1gsrRWGyj8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mey5Xc0YmfLa0svMMoV+nbefFu9U6jBx8r42ey1/BAj7FmmwCPA25YJ2YVjdWHt1Dc+2xKCMdaJIUBtvNtl3DUcT5h7TfW6bdW1SRZSVLVx714wE7t9pmlQXQp968kx9JK8cuTl45KPIh8KVTIiUDJjOdQwjY2Mvnu8ox6jqSf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4OLNhkS; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4OLNhkS"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-453903ee4adso819036f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 05:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779194950; cv=none;
        d=google.com; s=arc-20240605;
        b=B/ThEt/AxYE6Z3GCinQtbH40f7bqmiOt3M+vsBPQulAb34dZD43LUjM1L/GQiE5wcP
         llvLDE0lU7LvFADI3aIqSEgWbu0dx2SlHRYvnXSsu3voCc4V7BJ4twtBbUFveBdiSKIg
         Ad3Q3SOLZQtzlTeNyZyOgKVHKbbS1rY3ETI8B5fWZ1EgtgtxmGgMmeS2sVLoMPPg2ju9
         B31DZlusqo47kyygWZCtTZvcHLweC8M9C1i/EzhmT3jcliO101G/pNPsOxF5HyfrOAyc
         3YVuzQ1xl8IyODC4W3NvAgZfeVzvlz5SGqqFzGOFZXFvy1dBTZYjOv0KUScSYvHas9vx
         HKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gxnCZT3YkTibvlG6nqfkBDd0n82IagINu/+G6406bZ8=;
        fh=lu6SK309Gf+9nskUayJncgFGNylbhxRgvJvysyv8WyM=;
        b=HE55ZSOHOio35c4w3/QURSPrqEBH0kUyoi498Ln7UjAeqvXVacgiacd4uo/IvQ6Z3V
         IzmH1cCiiQpCJhLXmTgacxH76tVUDJAavW+Rejw1cFJHiHrvMZW8o75lA3QFspoqVzRY
         tJq5XoHHQHgWmFbY7VxZNm/+FJk9cAO+POvB6nYcjbSTEfN/M0TYxv3hkohIwzhuyZ8p
         xwNOltUwO6xQGuoSCmqXJPdQKaPZsiriu6uWr+R6HGHZzRYAcLYoltRnV2UECO7GeKN1
         mB2Cb1Pb3gRjTqjH1YzumrhvipZwAmK7PBIYgJskrdANoBGTJ5UXS0nIoXrUVcObrKVF
         GI3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194950; x=1779799750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxnCZT3YkTibvlG6nqfkBDd0n82IagINu/+G6406bZ8=;
        b=g4OLNhkS8VablrP1HElVY7Q/0N0Y+TcJ74gDDNB7zG9gYb1ehYT9sIU+KZ7a5M9bX4
         wCoE3/1cJCBkYYGS0NtGXqM30ShwsML9Ot1uPlF6oWSJBvFIEkkvkbO4ypoxzK3k/V8i
         4QneTYESYwotGCD10AQ6Zt56S7RVAmscKXitKaPlFw3dkx/R2WWRaVi1RXLfcZ3itc5R
         DS6/J/mj7ojC3nQda0sSeH17LR9uUgVkR1gr0dcCMt4NG29dDwiag3MWuo19povkzUwZ
         pdPCbdF2OcoW0hMg8YjRNfISBGN8xAdXrteJesITVcpvw0hg0YFD17d3c85HnmBVezam
         UWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194950; x=1779799750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gxnCZT3YkTibvlG6nqfkBDd0n82IagINu/+G6406bZ8=;
        b=QvWwKgX6yysRwyJRa4OQo1bYPO7Z33UOBTZqlO1qeyXxMKeRjyvh2F1+WLQNJaAxTm
         mbiLM1lqPkPUDLTQ79f8yVyLbYTHmSlC1YB6JFvC4psKdwCW+4v0IhSzY+frnr30cWC6
         X839rMlnv3AfRizI/XGxsKy+L9Z/jFmwPTUVjRBWDVjkqdQC9dUTUvda6mLfiiA6Xl78
         CGfLg10PkQPTb4tGDeo3n10hPJAAYIy6CzrLuSSCaP2ZesVtrObmfWCWQ35gtkGoEx5F
         /6O3Z71EMUnrfs8/kU9m3Jj73N5+KPlCliHvzm83lVGkBALxubOjzJZy+hpJQMJU2zTY
         0/pw==
X-Forwarded-Encrypted: i=1; AFNElJ+i7Znzsha2TNBJRY4tkw6DgpTnXOYRrfhgJJ+jitgkMrdn8VkqtANpVTjYPK0LcS63AXTdv7lXbzbbw4uiBmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHny+4eQ33PNgb9ZWAv/2M+RZOMr8kRfwICqzmsoB7/CXXAW3Y
	35wP/bKdd2QWfNPXiVFjyOY/HOXDZjuNmsnQXxZIJ9ObDQgBqxMdonZJ/yVaFgw/3jI8HDpAS1C
	93QaFQoWJqmk3Hbm6GQqy2VNCmL58wWM=
X-Gm-Gg: Acq92OFvAUV2CqfLaWRPjsxMxDa9+SuOVB5H9SeWzZBLOxvWxpiIWhi73S3lXzXMs1Y
	2D6dc24cG6CkiXWH9bqHCZwU5364OpjbfAUGWPH/RvFIZICkpsaaquktWsgddZMhtIcbJAiep7v
	IsIwqegJn9wLvWI8Dw56NZqLRYX3OsJs4h9bORSyI5ayk88KXBY5iSHKyhioX8mVxu5nXpTkWO8
	cMBZ0PEbIrBz9TcZ0sIxVvxjClIdBht9+Bwsvku/73g4xUNPBEkTKDsp6GGXrn4S8kBcxCsAReW
	z2JNu4rctz6YLfOe6Axuln5R+Nj07rjWnlr5C5rO877Fq/3x+4X6Ne2mym4tFNDPFMpu
X-Received: by 2002:a5d:5d10:0:b0:44e:1984:5f3e with SMTP id
 ffacd0b85a97d-45e5c5951f9mr30114071f8f.31.1779194950039; Tue, 19 May 2026
 05:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com>
 <CA+V-a8t5NZP5QamrdH2-ViMcShcYh3czLsZ+0kkD_kjUodjTyw@mail.gmail.com> <CAMuHMdUZkD0VTdSc4VChuaLvEAZ1j=5_69u8Ef0tO+dwMi6JDw@mail.gmail.com>
In-Reply-To: <CAMuHMdUZkD0VTdSc4VChuaLvEAZ1j=5_69u8Ef0tO+dwMi6JDw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 13:48:43 +0100
X-Gm-Features: AVHnY4I4917oez7RJMmKkLZjNlvjOWucXuN2H1DDq2uw9OwQGkIDoCLJP4CbJH0
Message-ID: <CA+V-a8uT+dkhKL7vAdFqAEX409keehC7RPOhKBTsL_dtEzMK_w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: Fix __counted_by handling after
 kzalloc_flex() conversion
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, May 19, 2026 at 11:09=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 19 May 2026 at 12:05, Lad, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > On Mon, May 18, 2026 at 12:08=E2=80=AFPM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, 13 May 2026 at 22:13, Prabhakar <prabhakar.csengg@gmail.com> =
wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Fix logic issues introduced by the kzalloc_flex() conversion in
> > > > mmc_test_alloc_mem() due to interaction with the __counted_by
> > > > annotation on the flexible array.
> > > >
> > > > Bounds-checking sanitizers rely on the counter field reflecting the
> > > > allocated array size before any array access occurs. However, use
> > > > mem->cnt both as the allocation size and as the runtime insertion
> > > > index, causing incorrect indexing and potentially invalid bounds
> > > > tracking.
> > > >
> > > > Initialize mem->cnt to the maximum allocated number of segments
> > > > immediately after kzalloc_flex(), then use a separate local index
> > > > variable to track successfully allocated entries. Update mem->cnt t=
o
> > > > the actual number of initialized elements before returning or enter=
ing
> > > > the cleanup path.
> > > >
> > > > Also rewrite mmc_test_free_mem() to use a forward for-loop, improvi=
ng
> > > > readability and ensuring only initialized entries are freed.
> > > >
> > > > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
>
> > > > --- a/drivers/mmc/core/mmc_test.c
> > > > +++ b/drivers/mmc/core/mmc_test.c
> > > > @@ -316,11 +316,13 @@ static int mmc_test_buffer_transfer(struct mm=
c_test_card *test,
> > > >
> > > >  static void mmc_test_free_mem(struct mmc_test_mem *mem)
> > > >  {
> > > > +       unsigned int idx;
> > > > +
> > > >         if (!mem)
> > > >                 return;
> > > > -       while (mem->cnt--)
> > > > -               __free_pages(mem->arr[mem->cnt].page,
> > > > -                            mem->arr[mem->cnt].order);
> > > > +       for (idx =3D 0; idx < mem->cnt; idx++)
> > >
> > > for (unsigned int i; ...)?
> > >
> > Ok.
> >
> > > > +               __free_pages(mem->arr[idx].page,
> > > > +                            mem->arr[idx].order);
> > > >         kfree(mem);
> > > >  }
> > > >
> > > > @@ -341,6 +343,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > > >         unsigned long page_cnt =3D 0;
> > > >         unsigned long limit =3D nr_free_buffer_pages() >> 4;
> > > >         struct mmc_test_mem *mem;
> > > > +       unsigned int idx =3D 0;
> > > >
> > > >         if (max_page_cnt > limit)
> > > >                 max_page_cnt =3D limit;
> > > > @@ -356,6 +359,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > > >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> > > >         if (!mem)
> > > >                 return NULL;
> > > > +       mem->cnt =3D max_segs;
> > > >
> > > >         while (max_page_cnt) {
> > > >                 struct page *page;
> > > > @@ -375,23 +379,26 @@ static struct mmc_test_mem *mmc_test_alloc_me=
m(unsigned long min_sz,
> > > >                                 goto out_free;
> > > >                         break;
> > > >                 }
> > > > -               mem->arr[mem->cnt].page =3D page;
> > > > -               mem->arr[mem->cnt].order =3D order;
> > > > -               mem->cnt +=3D 1;
> > > > +               mem->arr[idx].page =3D page;
> > > > +               mem->arr[idx].order =3D order;
> > > > +               idx +=3D 1;
> > >
> > > While looking rather ugly, I think starting with mem->cnt at zero,
> > > and updating it in each step like
> > >
> > >     mem->cnt++;
> > >     mem->arr[mem->cnt - 1].page =3D page;
> > >     mem->arr[mem->cnt - 1].order =3D order;
> > >
> > > would still be better, as it makes the dependency between mem->cnt an=
d
> > > the size of mem->arr[] clearer (located closer to each other), and ..=
.
> > >
> > >
> > Ok, I will start with mem->cnt at zero; with this I can drop changes
> > in mmc_test_free_mem().
>
> I don't think you can drop these changes, as mmc_test_free_mem()
> does mem->cnt-- _before_ accessing mem->arr[mem->cnt].
>
Ack.

Cheers,
Prabhakar
