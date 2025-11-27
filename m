Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5822AE7A
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238534; cv=none; b=LKc30nlHYi7yrhPUlGsyoIT8dCnqNMFLPSxVNpw0Np0k+R+FUghAeirx+4z0cq57rXNdTEUHJitLtU24bgSCW9haaYZ3kloOb49yw38uccPtvzR1Pp+Vf6Ip9daJAuFSi16Nz+YaamDeqRzkgF6aMhge4S6kftxJ4tGS8hMURvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238534; c=relaxed/simple;
	bh=UJpbinbR1ahKG3Nc/yCahpF1FlBfQ3b445UjgzZUZE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYcNGRwOwV7JkBvAhYLk9ECbFSQhkqNB/GmmQ7QZNAeKeB/83SY2/Ip5dXxxc/EoSRXIcf5Qd2ZMlT9C9jUlLx0fAWOuJ0uSFUeqE/RSkeQrCQ7CjL3LPuOHiwg/GV7pERgisq42kYv+1Zh07aDnqjX+6NauPVqVTCnCOyPFHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlxssgiX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlxssgiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4382C116D0
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764238533;
	bh=UJpbinbR1ahKG3Nc/yCahpF1FlBfQ3b445UjgzZUZE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QlxssgiX69krKHlr74WYp/N6dQHdbNDrQlBr7pgf6YPsFui6/T9bwa28C3q1F70Bs
	 nnaRL6Vom6ecjAqHD88Yv6OjpUC9OUp9GFpm+FXQERqg/ymQJWJ0ZfDJ+bHuhLlEuN
	 v2YVoxzuF2AkaIExu0n49XGlN3X88R0DdJGEHMn6iR14ePRivFEEhK6iVgIgETQORI
	 mEvzVGb/tdo/Eu+pMx9o/b/TK/+1GcEovnsL1Ztqf3bBgwlx9JmA+tASG7V5LCR2hQ
	 aVjlBVOgF6deUzNuXPfHL/VCtU9od73fVtMBm+mL55EZJfl0j+URI7S1RQFvJoyipb
	 G8kjG7awywHgg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a33f49018so5912661fa.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 02:15:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVd46V4cYKRKbZaQ3yPx6rHd5ePjRaOwvwRK/brqMehhbFD26ICPP6YSsrcvIFc4riPch9/JANBuQJ3/NGzFAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhJiAxFtz2StdGlmUVbk6If7SaooEFsu05O7BGXlXRaFUdxj8
	iiIttZmA5EbHE+387H6uGhqeVPhjdRj/iwWBNi25JRXWWYlvJkEUjd1f33bLzLTWnhLRPZ1E0xg
	KH+3Nk+4qpOSkJgy+y9WvaD8+q064lHQ=
X-Google-Smtp-Source: AGHT+IEF/zqxtbTowSSIvVe0VYS+EaAMAqgfM/DJ3DSiONHaZO/ZPYdXLt3/VQD0SUb8pmSNkU+2e+YM2/saEGhdMyA=
X-Received: by 2002:a2e:3c02:0:b0:372:628b:5cb4 with SMTP id
 38308e7fff4ca-37cd929c848mr53322901fa.45.1764238532050; Thu, 27 Nov 2025
 02:15:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <20251127092226.1439196-11-ardb+git@google.com>
 <20251127101129.204c6c5a@pumpkin>
In-Reply-To: <20251127101129.204c6c5a@pumpkin>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Nov 2025 11:15:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXETSPRO9BdUU2=jHn5O=tfB4wvwQE_i332KvEZaeCkTPg@mail.gmail.com>
X-Gm-Features: AWmQ_bkye94Cr_06CBrv4C4KNIVMtxpDibIKjZgz-At4e4NOWOBUacBwwxky0uM
Message-ID: <CAMj1kXETSPRO9BdUU2=jHn5O=tfB4wvwQE_i332KvEZaeCkTPg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 3/6] random: Use u32 to keep track of batched
 entropy generation
To: david laight <david.laight@runbox.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 11:11, david laight <david.laight@runbox.com> wrote:
>
> On Thu, 27 Nov 2025 10:22:30 +0100
> Ard Biesheuvel <ardb+git@google.com> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The batched entropy containers each have a generation field, to keep
> > track of the base_crng generation from which it was last reseeded.
> >
> > This use case does not require all bits of the unsigned long to be
> > stored: storing only 32 bits is sufficient to determine whether or not
> > we're at most 4 billion generations behind, which seems ample.
> >
> > So use an unsigned int instead: this will allow a future patch to treat
> > the generation and position as a single 64-bit quantity, which can be
> > used locklessly in a compare-and-exchange() operation.
>
> Probably best to use a u32.
> While it will always(?) be the same as 'unsigned int' it is more
> descriptive.
>
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/char/random.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index b8b24b6ed3fe..0e04bc60d034 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -507,7 +507,7 @@ struct batch_ ##type {                                                            \
> >        */                                                                     \
> >       type entropy[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(type))];               \
> >       local_lock_t lock;                                                      \
> > -     unsigned long generation;                                               \
> > +     unsigned int generation;                                                \
> >       unsigned int position;                                                  \
> >  };                                                                           \
> >                                                                               \
> > @@ -521,7 +521,7 @@ type get_random_ ##type(void)                                                     \
> >       type ret;                                                               \
> >       unsigned long flags;                                                    \
> >       struct batch_ ##type *batch;                                            \
> > -     unsigned long next_gen;                                                 \
> > +     unsigned int next_gen;                                                  \
> >                                                                               \
> >       warn_unseeded_randomness();                                             \
> >                                                                               \
> > @@ -533,7 +533,7 @@ type get_random_ ##type(void)                                                     \
> >       local_lock_irqsave(&batched_entropy_ ##type.lock, flags);               \
> >       batch = raw_cpu_ptr(&batched_entropy_##type);                           \
> >                                                                               \
> > -     next_gen = READ_ONCE(base_crng.generation);                             \
> > +     next_gen = (unsigned int)READ_ONCE(base_crng.generation);               \
>
> Isn't that cast pointless?
>

Depends on your definition of pointless :-)

We're deliberately truncating here, and the cast makes that explicit.
