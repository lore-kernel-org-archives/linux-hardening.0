Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D0263C6A
	for <linux-hardening@vger.kernel.org>; Tue, 20 May 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756589; cv=none; b=up/eZO9Oh/xYuNNqOHhv0PzaJ1vmC1Swco3ogUjrRqCaLRxW2uNhCXtaFIDEqN6E1dSl8Y+6Id6kTxw1+zoaEJ3OVyXf6FuvEqE5xD8XjYPNNXvVS/NcAXfkWenPe9j6NzlaCVHvcO9anIKrl4T35KNyZXLGvET6d+47pDXCUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756589; c=relaxed/simple;
	bh=ER3NJ5O3PAzpO1IEIeCsXoWaX/vAGysVFXgbd71q+b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5BrsS3Ps5T2IgJXBQYfZaQE2QmM02nCmezU5lEix2bQs2mlUY193DrUWzHyMOpZrvdji2BsVJLcMoX+Gmj8Hgu761edr1N4FHZCkz3R4F2IPkEUViTMJgAdZCKMHx1DL2cCXeDo9p2q0saNz8+HOZRZhccO+PRN9lyA80EXp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWop25BO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWop25BO"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231f61dc510so782295ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 May 2025 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747756587; x=1748361387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER3NJ5O3PAzpO1IEIeCsXoWaX/vAGysVFXgbd71q+b4=;
        b=TWop25BOFRU5dDKeS9QPoeYFABHBraSn+G7kag80qs/4iEXRJpEPfcnJuTCiGwAeIR
         Qm6+HnqesJaDiS/0z9LMmaE3H0BO+9fKzpqR7kXxoNLw1rRdKhQyPLmiB0UNN1AtvZC1
         kyFfkxRS8mVT1AQQOtaLk7hDnuGKfzhCHC3oNHwGAeaPsYCPW25QHNa9DaV9O7W9zCKz
         YVNaFDlEYva5qIBlB1PpbXlbmcmVBkRk5BpGkZRso+5vQhuCalGQzFL80rrvk6UZ9yJa
         eTYz2D8eVa68gJEGyDanmY3s/ASkBRbM6t8GHb0qCTmbW59jZCIXMTkwXp/GZYQIQCur
         KLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747756587; x=1748361387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER3NJ5O3PAzpO1IEIeCsXoWaX/vAGysVFXgbd71q+b4=;
        b=sVUFlMGdQxe4aBJKAt4jjY5EVC1v6JEmx/oI5+gkW995/2hkkvE+c6FTIez1gkAg+w
         sLJ43Oek8ICWfh5q0M1rgFtgOU4j7NOzDMsNaOXdzhShij7vcO/gq4cI/to6YLjjCu5J
         ld2r1UeSZ17m9050W8Ro+5Gfi/nXWcwH7dWIqpuJ+Vd4/XAHmgDGrvnpZrbtu9sAQg8r
         FxlC/f9pOHbOKdo7zCFD+OCVQg2X+7LCMslALGGOKQv4kusaqpiA2pNS13vhhiEePXJd
         4GyYkkcqvv5bKOs+NRjiFy1lWJUZn3xPGtP9m6FTpw45BrZP0zpcqLJT+yVPw6XIj8+b
         EAHg==
X-Forwarded-Encrypted: i=1; AJvYcCW6ylqRZz/mLELOYHF7dIMgSjvsZuDFbmDzcn0mo8x0TTT28+KJ0qAGZLAlBXJvGGVxDi0u47e3W7zJ8a0JSOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2XD7NOvtJ2WFawYPsUwMPBi7XnY6c34yarZuyMy7MbG8ZEOD
	jPdyg/i1OS5obWkde+v1dPEdnn+/cA6EgA2zKeynLDQZoFhG8o5idM7MSlNd11eTWq4XxZGhbcc
	wx3QzuSB8pFeixLMstYSnIgW6Bi8aplfWuriAwWjf
X-Gm-Gg: ASbGncvPIpAVVDk+nT/Q+drNVkzhFIAgULXwcx+6RxGRs/GpVhBHKRVM46PnLl5SiFm
	XNc4SHwPGwGB9pnUxQVB0vlQncdpMC+be4ap37waZHCHwRwxd3EHvmjEV4kVba6X/XzWe0xjASw
	PGksWRuykk9RqOjvpyvWMNRWG+D//utiod+8n2obN/5Qjpb6njugIQyhpPxGnRxeFfeSBB+g==
X-Google-Smtp-Source: AGHT+IE3UoafRXp4fFTWsfLrSpxZrXhZFQX6aCH6gZeuLrfBVPCauhB9DuTu6AnjgBWc6z7HnULlUjYmKw4eAcPInfc=
X-Received: by 2002:a17:903:11c8:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-231ffd0e31cmr8019275ad.6.1747756586623; Tue, 20 May 2025
 08:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com> <CAH5fLghNJYjxPFUc2E4-2pJpGT5umUr1EJstZvs88ox3MsXDGQ@mail.gmail.com>
 <aCwRZlkBWekRmDg7@Mac.home> <CAH5fLgj1NVodPy-95CFUygGO7WC0siNEKSyEhgLvpX-1zMXErQ@mail.gmail.com>
 <aCx77cCum_b-IR4H@Mac.home> <CAH5fLgjqj7binVaLDh7Pc7SVKDM-XrYDEDj7GYBX_MnjHgufFg@mail.gmail.com>
 <aCyB4z23VP-3Hmor@Mac.home>
In-Reply-To: <aCyB4z23VP-3Hmor@Mac.home>
From: Jann Horn <jannh@google.com>
Date: Tue, 20 May 2025 17:55:47 +0200
X-Gm-Features: AX0GCFs0RrSQrNlKygeYsUjA_mLlWNKtB4CI8gjUfxmH7vR_28jbNDCMVUE1uVM
Message-ID: <CAG48ez32gxwdmQ63XWB8Dz4b5seH7tOhY0yREC=34ubTHZ5VOg@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, 
	Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 3:21=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
> On Tue, May 20, 2025 at 06:05:52AM -0700, Alice Ryhl wrote:
> > On Tue, May 20, 2025 at 5:56=E2=80=AFAM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Tue, May 20, 2025 at 05:42:51AM -0700, Alice Ryhl wrote:
> > > > On Mon, May 19, 2025 at 10:21=E2=80=AFPM Boqun Feng <boqun.feng@gma=
il.com> wrote:
> > > > >
> > > > > On Mon, May 19, 2025 at 08:46:37PM -0700, Alice Ryhl wrote:
> > > > > > On Mon, May 19, 2025 at 4:56=E2=80=AFPM Boqun Feng <boqun.feng@=
gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> > > > > > > > On Mon, May 19, 2025 at 6:20=E2=80=AFPM Burak Emir <bqe@goo=
gle.com> wrote:
> > > > > > > > > This is a port of the Binder data structure introduced in=
 commit
> > > > > > > > > 15d9da3f818c ("binder: use bitmap for faster descriptor l=
ookup") to
> > > > > > > > > Rust.
> > > > > > > >
> > > > > > > > Stupid high-level side comment:
> > > > > > > >
> > > > > > > > That commit looks like it changed a simple linear rbtree sc=
an (which
> > > > > > > > is O(n) with slow steps) into a bitmap thing. A more elegan=
t option
> > > > > > > > might have been to use an augmented rbtree, reducing the O(=
n) rbtree
> > > > > > > > scan to an O(log n) rbtree lookup, just like how finding a =
free area
> > > > > > >
> > > > > > > I think RBTree::cursor_lower_bound() [1] does exactly what yo=
u said
> > > > > >
> > > > > > We need the smallest ID without a value, not the smallest ID in=
 use.
> > > > > >
> > > > >
> > > > > Ok, but it shouldn't be hard to write a Rust function that search=
 that,
> > > > > right? My point was mostly the Rust rbtree binding can do O(log n=
)
> > > > > search. I have no idea about "even so, should we try something li=
ke Jann
> > > > > suggested". And I think your other reply basically says no.
> > > >
> > > > We would need to store additional data in the r/b tree to know whet=
her
> > > > to go left or right, so it would be somewhat tricky. We don't have =
an
> > >
> > > Hmm... I'm confused, I thought you can implement a search like that b=
y
> > > doing what RBTree::raw_entry() does except that when Ordering::Equal =
you
> > > always go left or right (depending on whether you want to get an unus=
ed
> > > ID less or greater than a key value), i.e. you always search until yo=
u
> > > get an Vacant entry. Why do you need store additional data for that?
> > > Maybe I'm missing something here?
> >
> > Let's say you're at the root node of an r/b tree, and you see that the
> > root node has id 17, the left node has id 8, and the right node has id
> > 25. Do you go left or right?
> >
>
> I went to check what commit 15d9da3f818c actually did and I understand
> what you mean now ;-) In your case, the rbtree cannot have nodes with
> the same key. If Jann can provide the O(log n) search that could help in
> this case, I'm happy to learn about it ;-)

Linux has the concept of an "augmented rbtree", where you can stuff
extra information into the rbtree to keep track of things like "how
big is the biggest gap between objects in this subtree". This is how
the MM subsystem used to find free space in the virtual address space
before the maple tree refactor, a complicated example is here:

finding a free region (by looking at vm_area_struct::rb_subtree_gap to
decide whether to go left or right; this is made complicated here
because they have more search constraints):
https://elixir.bootlin.com/linux/v4.19.325/source/mm/mmap.c#L1841

But that requires an "augmented rbtree" where the rbtree code calls
back into callbacks for updating the subtree gap; the MM code has its
gap update here:
https://elixir.bootlin.com/linux/v4.19.325/source/mm/mmap.c#L261

And associates that with VMA trees through this macro magic that would
probably be a terrible fit for Rust code:
https://elixir.bootlin.com/linux/v4.19.325/source/mm/mmap.c#L400

As Alice said, this is probably not a great fit for Rust code. As she
said, an xarray or maple tree would have this kind of gap search
built-in, which would be nicer here. But if you're trying to do
insertions while holding your own outer spinlocks, I think they would
be hard (or impossible?) to use.

If you managed to avoid broad use of spinlocks, that might make it
much easier to use xarrays or maple trees (and that would also allow
you to make the bitmap API much simpler).
