Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543582FA0DB
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768460163; cv=none; b=hH1Lb4LsQFDV4QgKQ7OPjY4qRue7ISLWD4UpFs9GR9N4hze7B+q2DgDZLCphKATGcvNmOAHKpWEF9wNi92bfyUE1UO+lPZQpqSvyOp2zNKAlL6bPhVZ5i2oCdimJhzMfhgMifDET4+nf0EEBSGieDaxF3Rdhyrzmm5xRe1Y+SkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768460163; c=relaxed/simple;
	bh=D4V4cbRZJd4tKJ8TgzhmWVWUaqzv6/0iS79jgSXT22k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoFv9ZJ2gwuCIVW5O6QRjrlTNymp4IKpO+9YavbRL79/4KfYVacxoFUJ/Qz+WVu2JP/nrEdoWizr3UCTFw/Irec0wzZYLoZYF3T8mrOegzXnB/ZfSL0WdkuQRAjRYnGtUHikI6Ww+Ks+NC5U4QYR8Lvz2HP/2w87h2HMn+Yodxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKQMR8kL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKQMR8kL"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so899670a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 22:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768460156; x=1769064956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYnt5uZdVRjX/TH2DmOHbsi489uV8nGgAATMESeXy9M=;
        b=IKQMR8kLE0mi3+H+ELVVVtsoal2iZ6lWuHTB0eBa1VBwravJRi92OTFEupSLT7dStT
         dy63qnCdNSr9bD/VewIC1BxKZu96O4c9t5e4x0B7eqNkSoNQkkdoNPaMEiHQJwnXSyRW
         4InwuQO1gEZ++YhgHeodNgNG1qkmR8e4va1le3rFILH7WMjkV2NBogfsx8PHhJLOweUS
         c8olouTv5msPMLagD2RFBtHG5bi085x7pe7WzAv+KLLSJI37GfD6HwIA0BARQtBIvJA9
         fjFZO+YXDSlNjEWqJ8T+SVKU0QRQvtuCLdUTcUKUSo4Zv2oFwljWhb2s/oseTfki7P9T
         4gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768460156; x=1769064956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYnt5uZdVRjX/TH2DmOHbsi489uV8nGgAATMESeXy9M=;
        b=eDaMLrjk4ViTbvl4Btj64QWtIhTBIokr8UzSbTOt/H2jayUjbXsKS10p65yQeDhAzB
         5EnfsICMOCpKGeN1Kot20tkJ88Gig/iH2CGU+KGy9Xcjr+q413ym87M68/4YBWX6TWRq
         pdk931MSxGhJj72QLr8slIzCVZWqo9LuQVTrw8Aq2Fxmf3f16k4ueJUcIxihsnnRGbi9
         iPqhHwGIXXWpz2/dqZRtmkADd5fW/F7qkkIMdRXQevtBab0AmXL1WqEVNtIjB8jID9YK
         yYkn+pBEsru3lRxsYFy1nz56Z0APH66UI8zNljqySRMREhuP76QszJjHnsA5YW17IA5N
         K7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5C4Tk/Zy78PQNsG/p26uHe9FL3Oyk/OXCdrdpyX4+jiTN8KLKNKmB4/bO/hO+OfRmd6qPUGXGYNNR0Tsu1CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGr04wuLzD/iwpjAbCWmp2NueLYORj6ImX7EjjTSqzNB2oi6Y
	LV3miChIMiBALDB3Pt0kR4T16UKnGn9zkqRoMiFv8M2n52U6/Ymx/2+7sfQtPF+Ll4vss+3MiyE
	9ToYQdeGw+oQlJIy0UAi9c5a0DkOu5xw=
X-Gm-Gg: AY/fxX6jiaZ5RTcjo9E4fNKNfVtAF8gDtrBv5B262QO9rUJbn32OQ/QzrA47ScGrKJO
	ht50/u384UfV7w/wOoK5tLsHiQoFyMcIFEBHpreWnv4jkXZfWpJMhxbG4f+19rdHiXYT+RPhCTT
	OGNKIgflbXUHyFL9DsJP0jJ2EA+obZ/J9R5OjV3+yqyDNyFH7Xte6SxdlYlSDF53BElZKgHA8UX
	CeLC2RSH8aPbXP+HBnFWnfAGFEwF5DdsCcU0DK/8xhij4fK9weBqGL6COS8bKQvKh6KB7EGxCYG
	+xPsN2PNp9LCUncRV5VVeOl+HvvZYt1oNIdnd1qff0xklBvh5aQ6PgDpX7pttTb/eI1NV8bL/a4
	p+N6Rnlg=
X-Received: by 2002:a17:907:3f98:b0:b87:2630:e67b with SMTP id
 a640c23a62f3a-b8761286700mr421274866b.50.1768460156172; Wed, 14 Jan 2026
 22:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113082748.250916-1-jiangfeng@kylinos.cn> <20260113082748.250916-2-jiangfeng@kylinos.cn>
 <20260114000151.GB2178@quark> <20260114101034.7961852a@pumpkin> <19a5a6bd-2645-4be6-9e21-c78e820886c5@kylinos.cn>
In-Reply-To: <19a5a6bd-2645-4be6-9e21-c78e820886c5@kylinos.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 15 Jan 2026 08:55:19 +0200
X-Gm-Features: AZwV_QgcQg2yFl3kenFIgEZA_bCo4ozJi3yvM8wLZL_115P5Z6TtaUVc7xL-Q90
Message-ID: <CAHp75VenLXeWBjvjd6A2q6gepQdqkgGFzTMHZ-UY1s+4UHP14w@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] lib/string: extract generic strlen() into __generic_strlen()
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: David Laight <david.laight.linux@gmail.com>, Eric Biggers <ebiggers@kernel.org>, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org, 
	andy@kernel.org, akpm@linux-foundation.org, martin.petersen@oracle.com, 
	ardb@kernel.org, ajones@ventanamicro.com, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, linus.walleij@linaro.org, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 8:51=E2=80=AFAM Feng Jiang <jiangfeng@kylinos.cn> w=
rote:
> On 2026/1/14 18:10, David Laight wrote:
> > On Tue, 13 Jan 2026 16:01:51 -0800
> > Eric Biggers <ebiggers@kernel.org> wrote:

...

> >> A similar problem exists with the architecture-optimized CRC and crypt=
o
> >> functions.  Historically, these subsystems exported both generic and
> >> architecture-optimized functions.
> >>
> >> We've actually been moving away from that design to simplify things.
> >> For example, for CRC-32C there's now just the crc32c() function which
> >> delegates to the "best" CRC-32C implementation, with no direct access =
to
> >> the generic implementation of CRC-32C.
> >>
> >> crc_kunit then just tests and benchmarks crc32c().  To check how the
> >> performance of crc32c() changes when its implementation changes (wheth=
er
> >> the change is the addition of an arch-optimized implementation or a
> >> change in an existing arch-optimized implementation), the developer ju=
st
> >> needs to run crc_kunit with two kernels, before and after.
> >
> > For the mul_div tests I arranged that the test code could #include the
> > source for the generic implementation so it could run that as well as
> > the version compiled into the main kernel.
> >
> > This involved wrapping the function in:
> > #if !defined(function) || defined(test_function)
> > type function(args)
> > ...
> > }
> > #if !defined(function)
> > EXPORT_SYMBOL(function)
> > #endif
> > #endif
> >
> > So the test code can use:
> > #define function generic_function
> > #define test_function
> > #include "function.c"
> >
> > to get a private copy of the generic code.
>
> Thank you for the suggestion! That technique is very clever and interesti=
ng=E2=80=94
> I've definitely learned something new and will keep it in mind for the fu=
ture.
>
> However, since lib/string.c is such a foundational and low-level library,=
 I'm
> hesitant to add macro wrappers or conditional blocks for KUnit. Given its
> importance, I feel that increasing its complexity for side-by-side testin=
g
> isn't quite worth it. I'd prefer to keep the core code clean and follow E=
ric's
> minimalist approach of benchmarking across different kernel configuration=
s.
>
> I really appreciate the guidance!

I second you, we currently may stick with what Eric proposed and
consider other approaches in the future where appropriate.

--=20
With Best Regards,
Andy Shevchenko
