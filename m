Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014D1B81D9
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966879; cv=none; b=IoC4XA/dd4ziVjLvXPAfBmdKXH3s7ouhe4cTvH2Xhifqn7rSn/7qesZOOxuZnXTuYlJUpn1LRClzBzWONninMN3rqCyQ3oubOTHXMI7lmjyfkrY9hvc4g+1Nxqdo0ujRHG6w/CChDPLnoCqEb4up147IzETfX/Cp2Zinlai6ZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966879; c=relaxed/simple;
	bh=xI6jWtDgVhVAyox0ou6HEMJsKQJYYT51z7Bn75Qsv9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dy1RIj+1++PYR5H+LMPooA3xVqf7hzzAoBTbHQthTaDsGoZBe7q8e+b5KBdlMd+ylfmL2O3v6A1ceMUJjoPoZ5vUDxVzrkl9JT932wr72fOcY8ZQRTkVswOizjCgbZHgi2IBYI3JXsds+qHF2ZGu9H6ujHWUsEA7e868GWKuIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2gngWWl; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2gngWWl"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-842fd4e4de7so360258241.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724966877; x=1725571677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b74/nL6yM7DqQj6YIDRSkjEeKfBsodW/MeHd7rIt+PI=;
        b=V2gngWWlcqJC2ApaUWpsucqpJ+t7YEUxKIc1C4VAhEdcQsfRXTtwmyKneaKjTpNk0w
         HXI/lNaH4LMBNIg4uHJR7L0vufvXxiH9cPFOZppQDfxmpBrECCTFmDlT+Tv/T6BIKkkV
         BEUjiAbymI+LSt7qXoR3xw9qDQ43jLQiDiZ+DKyo1NDAMuKcoNsVuZt+oQeiaNOyHi6+
         VAqut63UKjlWwasvbVvBWcILXiL2dqpPaoA08ZMNvLZId36pxbkd/a+NbW4rwIL9jpJF
         thol1zPoHEzx0yb+FvKC9f1vQYfsmnBkpw4AeOeKtsRozuWkQpQkpvhYotfRys5qLAnq
         SX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724966877; x=1725571677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b74/nL6yM7DqQj6YIDRSkjEeKfBsodW/MeHd7rIt+PI=;
        b=DdY+N744yEkBxhE/cmJ8lL8j7+xz0AULgNUHc9eznA6BLyGt+sZzNY4xFXHOc+YhNx
         e8taDkSf3nI23yvJmcS0WoWfVEtYxT47GDiNJxa8djDyihBMHiS0Ly2QSQsfmyFONat7
         z0ZoXt2uSQrHxI1kX+xhd0zShd3ebUrmE6/84Jy7QQXxqDvnfTOCNo12HBN9x3FCa1BH
         OIq6P6MDf412ZjGpD1Q1Mr+0g/Ug5Vi8NpYVOjWzZeb/3lUgzUdQ3BDOkAQP70zHQjDi
         6LWmDbzM5xiIQsn4+u5BfxCFdoeBx4IIpipEQp1ZpUr35cDHfnYMCW1rfeY9mXwEvhvO
         uYYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVasNYARk1+SnR1UBGRIEaTOkr4pDfU4saMoxPQaEXSteFo3ym2Aa4YUAijm3wD0X11jZ3l6C+xG74CJXB/Tvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzERox/okNK5MfnHnpIYnfb+bZY0ouKeOO0tj+3CtlUCpCLeru
	hSSKfQ1mSXyBn2ywcbr+DmcmbH/v5BCYqa8T3T96zcFuBrlxdkS+LxDeHskugHFg2sRlFD17wDf
	wnWo6KTZRx/LmRR/RaiPAbaWADX4=
X-Google-Smtp-Source: AGHT+IHFl75GTpZGRhFgVBJELmEX9X/2XagOVMq2pkrForU7wgZKEZm8rM3Zk7y1bShZr5WrMKfOlQpwnaSO7fbHhbY=
X-Received: by 2002:a05:6102:c92:b0:48f:cb62:231a with SMTP id
 ada2fe7eead31-49a5b1a85ffmr4651130137.23.1724966876680; Thu, 29 Aug 2024
 14:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka> <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
 <be4c9110-72d0-4749-941e-797a861d8319@suse.cz> <CAGsJ_4znRBscU8FWMZL7Z9qLUMxCPtupRcJqu+PXz260p-S6MA@mail.gmail.com>
 <c258403c-afc5-4969-b7c5-fa2a6c257371@suse.cz> <CAGsJ_4wu3theWe0iyXdBK-JvLfuBh7Qw-B+9Wztm2XyrU1Uzeg@mail.gmail.com>
 <2663352f-ecef-4e5b-bee5-e31d2b286c63@suse.cz> <CAGsJ_4zY5jwCsJh94OFMi1UqzFu5Ji3OeJZz91p2YKT5jxBc5A@mail.gmail.com>
 <ZtB1lLljEk9PVkU7@tiehlicka>
In-Reply-To: <ZtB1lLljEk9PVkU7@tiehlicka>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 30 Aug 2024 09:27:45 +1200
Message-ID: <CAGsJ_4wZiE08XDjNAPENwH=KQEzdm2FB_bMDi0b7PJx+e7ydrA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, virtualization@lists.linux.dev, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:20=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 29-08-24 23:53:33, Barry Song wrote:
> > On Thu, Aug 29, 2024 at 10:24=E2=80=AFPM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> > >
> > > On 8/27/24 09:50, Barry Song wrote:
> > > > On Tue, Aug 27, 2024 at 7:38=E2=80=AFPM Vlastimil Babka <vbabka@sus=
e.cz> wrote:
> > > >>
> > > >>
> > > >> Ugh, wasn't aware, well spotted. So it means there at least should=
n't be
> > > >> existing users of __GFP_NOFAIL with order > 1 :)
> > > >>
> > > >> But also the check is in the hotpath, even before trying the pcpli=
sts, so we
> > > >> could move it to __alloc_pages_slowpath() while extending it?
> > > >
> > > > Agreed. I don't think it is reasonable to check the order and flags=
 in
> > > > two different places especially rmqueue() has already had
> > > > gfp_flags & __GFP_NOFAIL operation and order > 1
> > > > overhead.
> > > >
> > > > We can at least extend the current check to make some improvement
> > > > though I still believe Michal's suggestion of implementing OOPS_ON =
is a
> > > > better approach to pursue, as it doesn't crash the entire system
> > > > while ensuring the problematic process is terminated.
> > >
> > > Linus made clear it's not a mm concern. If e.g. hardening people want=
 to
> > > pursuit that instead, they can.
> > >
> > > BTW I think BUG_ON already works like this, if possible only the call=
ing
> > > process is terminated. panic happens in case of being in a irq contex=
t, or
> >
> > you are right. This is a detail I overlooked in the last discussion.
> > BUG_ON has already been exactly the case to only terminate the bad
> > process if it can
> > (panic_on_oops=3DN and not in irq context).
>
> Are you sure about that? Maybe x86 implementation treats BUG as oops but
> is this what that does on all arches? BUG() has historically meant stop
> everything and die and I am not really sure when that would have
> changed TBH.

My ARM64 machine also only terminates the bad process by BUG_ON()
if we are not in irq and we don't set panic_on_oops.

I guess it depends on HAVE_ARCH_BUG? if arch has no BUG(), BUG()
will be just a panic ?

#ifndef HAVE_ARCH_BUG
#define BUG() do { \
        printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func_=
_); \
        barrier_before_unreachable(); \
        panic("BUG!"); \
} while (0)
#endif

I assume it is equally difficult to implement OOPS_ON() if arch lacks
HAVE_ARCH_BUG ?

"grep" shows the most mainstream archs have their own HAVE_ARCH_BUG:

$ git grep HAVE_ARCH_BUG
arch/alpha/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/arc/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/arm/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/arm64/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/csky/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/loongarch/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/m68k/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/mips/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/mips/include/asm/bug.h:#define HAVE_ARCH_BUG_ON
arch/parisc/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/powerpc/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/powerpc/include/asm/bug.h:#define HAVE_ARCH_BUG_ON
arch/riscv/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/s390/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/sh/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/sparc/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/x86/include/asm/bug.h:#define HAVE_ARCH_BUG

>
> > > due to panic_on_oops. Which the security people are setting to 1 anyw=
ay and
> > > OOPS_ON would have to observe it too. So AFAICS the only difference f=
rom
> > > BUG_ON would be not panic in the irq context, if panic_on_oops isn't =
set.
> >
> > right.
> >
> > > (as for "no mm locks held" I think it's already satisfied at the poin=
ts we
> > > check for __GFP_NOFAIL).
> >
> > Let me summarize the discussion:
> >
> > Patch 1/4, which fixes the misuse of combining gfp_nofail and atomic
> > in vdpa driver, is necessary.
> > Patch 2/4, which updates the documentation to clarify that
> > non-blockable gfp_nofail is not
> >                   supported, is needed.
>
> Let's please have those merged now.
>
> > Patch 3/4: We will replace BUG_ON with WARN_ON_ONCE to warn when the
> > size is too large,
> >                  where gfp_nofail will return NULL.
>
>
> I would pull this one out for a separate discussion. We should really
> define what the too large really means and INT_MAX etc. is not it at
> all.

make sense.

>
> > Patch 4/4: We will move the order > 1 check from the current fast path
> > to the slow path and extend
> >                  the check of gfp_direct_reclaim flag also in the slow =
path.
>
> OK, let's have that go in now as well.
>
> --
> Michal Hocko
> SUSE Labs

Thanks
Barry
