Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90D149E17
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jan 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585000; cv=none; b=kSscMV6fa5Oq+NsF1xEylL1pH1X+rAbwjIHepkuc+zwa1JanV+M/uKzwfep7QSU4IpRV593AYNCA/yD4Yck6rC67aywFR0fsvKyGe4GPRvnQMMKL+xDWF+a00Qu5Dte4BhXoSoLrO4FNru0C3B7a8So4y3FM0jQGEpJ74XZAkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585000; c=relaxed/simple;
	bh=g1cDQplVJ0SR+tp7hPTRxHAdOvMqFGLnt/sJ70Wh/l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LGRNnRVi/mHvEdoMSFbNu+5Mfo4/q90aqj9EDJIT0fjDoJgRjfGnL2w9DKrEVD3GQU5JxXcObaUzLiGsKt6w5pc3xx0x+H9cexQYE9eIzT4ul1AzBVTovrM3iYY1qGpazuiYYf7DFrffgxZan0RNNY7Ebh7eXmeCMHxLq14IGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAMezyfx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAMezyfx"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467a6781bc8so2295581cf.2
        for <linux-hardening@vger.kernel.org>; Wed, 22 Jan 2025 14:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737584997; x=1738189797; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjXLTwokHULFLJy9HXfEAVLYI075PwVsMqVHUQWpd8A=;
        b=oAMezyfx9PzMn/Clzflbzo8GsPazsZeQoJlmd3aJ3gJw0Yb4qMv5clpGbwImLuGGxR
         HuxgahZ59oz+RTFH3Lb9HQjnZBK921ar7q7cDdV2qRQ8/0QBSNUyljUS000ORM9NJyou
         3DnGdptyO9x6P7aquT92M5xEiqBScK2q1LHCVg2AfnLioK5laxENlh8CxCyGepoVE21S
         LNsWd2Mfc/5V7+4Xe8MtIHmNwg2be5v2v9rqbrzBDEulCW2I5UYfv9/DNdRmrPmhtFrf
         ZnTQ7mk3vIs2TjwR3mizNTpwUtx/jqUaru3oLaxOBtd9+5oPTTWVRLxIPG/riliygtqx
         c6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584997; x=1738189797;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjXLTwokHULFLJy9HXfEAVLYI075PwVsMqVHUQWpd8A=;
        b=ZhDiupZN3uy8j74RKF0FaxDIXy7/kkoqdMmO0/bVoaHrdhzPxxoa7AeiorsK6PXwhX
         Px2esMhNfC8vA/PoC0n7/WUbhbw74rAS8c9A7z9pFACclMHh1goXnzNWwrCxCFW9sYX4
         rqSEFryNSzkaf5fndox1FbV0DTm/c+cs8TrnfQQsIQiYerh7iKjvhcIq1Air8GXynVwX
         XZbXpixgNRbLPa0fnL4A56KrDpIzluGsbVpiDWEznoeeQNqkjAqcyqhRaTu8bo505NJi
         rl1yAnvLKOC4ll4fUJiuJNa5nB/F5VMdzRAfQDa5fQ6FFLdS/EsXad4OJHBXDi/BZa06
         Bokw==
X-Forwarded-Encrypted: i=1; AJvYcCVAQ9m4EJ25IBHvbDg9qZTqQny03RDZnU3bsG0CD74TK0JFVh05jnrvYE9ATA8wYgLmaOXsYkfpYDtW9QVJJhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG97V+NDewsjfQq7b3RvYaLZd0hi81hFlPNv00Nzp5+6ZyRqKz
	A54gJIRbSyWt5gBYlYYlQWpKKfhhCdk3rZDpcEUq3fwzPVdPc6T3OLAFZYrHnz3SpwYIXUx1pxr
	lMv1uTo5UZpThIt+f39MH3rEzO4B4Z3vKTqqt
X-Gm-Gg: ASbGncud4OTK481gOS6SvXFdg/GbSpW+RIEhzr0AhU0YfOusFLdid1AxW3KTurj93gd
	2uhgbNp8hFA2Ye6mOpo0FgRYd+A59VM+vC3ebR3NnyA9akoDi
X-Google-Smtp-Source: AGHT+IHl/Af4JTdhFWW2PM+Z6WRkSU8IpaB5lz6jO7IT0H4wqoewjfMyn/Pr32wE6HlqHKUDuD8BMPoPIOCBzAP7pAY=
X-Received: by 2002:a05:6214:5004:b0:6d8:97ea:4362 with SMTP id
 6a1803df08f44-6e1b2236450mr399170996d6.38.1737584997118; Wed, 22 Jan 2025
 14:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local> <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local> <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
 <ocstrhpyoyxzurvvxbrbnlzfqzo6hiqt7dxj7vu45ipj4min6z@ffnpao72slda>
 <CAJgzZopv+jKmDncYDJEQTymqQ1oRpy8HNpOsmcoM7Chb=uBJzg@mail.gmail.com> <l7pexkoo7t7p5u6gobgc46lxvpgpe2lywaqwa4b6vjddt3ccnq@mh6x72cxfhyv>
In-Reply-To: <l7pexkoo7t7p5u6gobgc46lxvpgpe2lywaqwa4b6vjddt3ccnq@mh6x72cxfhyv>
From: enh <enh@google.com>
Date: Wed, 22 Jan 2025 17:29:45 -0500
X-Gm-Features: AWEUYZnC1Tss1EargrTlUaRo7LZ2x5xCC0HcfgPRP2MqSe5DS782ycUSvQBO1PM
Message-ID: <CAJgzZopiyhq9Wpu+gxUssoNhQT7tNjiey0JGsKPJAXjraEBRiw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, enh <enh@google.com>, 
	Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Benjamin Berg <benjamin@sipsolutions.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 12:24=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * enh <enh@google.com> [250121 10:38]:
> > On Fri, Jan 17, 2025 at 5:08=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * enh <enh@google.com> [250117 14:35]:
> > > ...
> > >
> > > >
> > > > as a maintainer of a different linux libc, i've long wanted a "tell=
 me
> > > > everything there is to know about this vma" syscall rather than hav=
ing
> > > > to parse /proc/maps...
> > > >
> > >
> > > You mean an ioctl()-based API to query VMAs from /proc/<pid>/maps?
> >
> > i wasn't imagining an ioctl(), no, just a regular syscall, but that
> > would work too.
> >
> > > Andrii had something like that [1], check out ed5d583a88a92 ("fs/proc=
fs:
> > > implement efficient VMA querying API for /proc/<pid>/maps")
> >
> > yeah, that would work for the use cases i've seen too (some of which
> > are similar to the ones mentioned in the patch description, but other
> > ones too).
> >
> > the other motivation we've had that i didn't notice mentioned there is
> > avoiding the awkward /proc/<pid>/maps behavior when you have too many
> > vmas to fit all the output into a page.
>
> We are making changes in this area.  Can you elaborate on the 'awkward'
> part?  The locking or the tearing of data?
>
> The way you state the page, it makes me think it's the tearing that is
> the issue?  I think the ioctl would be worse for the possible tearing of
> data.

there are two main styles of use of the /proc/<pid>/maps data i've
seen in userspace:

1. i need to know about _all_ the vmas, so i'm reading the whole file
and stitching it together.
2. i need to know about the vma containing a specific address, so i'm
reading line-by-line looking for a match.

the former is typically just for humans anyway (to be added to a crash
report) -- so the ability to sendfile() or whatever would be something
we could use there (though i've no idea whether that actually solves
the tearing issue) -- so those use cases mostly tend to ignore (or not
notice) the problem.

for the latter, tearing is a bigger problem because what does "not
found" mean? do we try again? how many times do we try? so i think the
ioctl() would solve those problems. plus it would be a lot cheaper,
and in particular not require [or at least "strongly benefit from"]
dynamic memory allocation like parsing a text file does.

> Thanks,
> Liam
>
>
