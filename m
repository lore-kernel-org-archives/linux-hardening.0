Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F562E92B4
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161949; cv=none; b=eaKjFaIbvr9+xqfXzYfU6YpYPyORWoxx7rKGVrxuEpfQRVq7NmQTtsAGULurS7LvnsQ0oy3DCdu2RlHSA52nkosNN5lEWFdXw4vz12RgcSay1ZfijS0qflkFlz52xtZ4lFLRkMOeEnamgKfC7T8L03MSw4VCY4/270iKjDsUwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161949; c=relaxed/simple;
	bh=k7930PWVZrp71mXwwvk57VkUxiKt/Q9kRgvtbnYLCik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHFStbr6AQ1Zc73MNjpdwSL697svTysZnXjZswcMFkRmRbf9LvM6YJzUJrWEvNtCokwarInWHEM5nGBzrIfNVfkkk5a8m41EIMZYqD+F+JqvXe/SjtfgpicFQHgCZwP9QABL/+WRDMmpV0AVeByrCy5lTTH+Y2hMA2uQmY06yhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD0CzHRj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD0CzHRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93520C4CEE7;
	Wed, 22 Oct 2025 19:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761161948;
	bh=k7930PWVZrp71mXwwvk57VkUxiKt/Q9kRgvtbnYLCik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vD0CzHRjRzB/4iuBNGZLrQkRzqNu6TFknh3AAaTSZ6VppxJbX8uHzq3MDxHBAzDZm
	 rrrr+Q9XgRUrMZ+R7q3IbEpubksBUvFewtPWeGH6DZQ/Q5N5yLK74q2UGyMDXf36FH
	 9njy9CF5ML7Xr6OdCYXm69EttP48XunkoBnN7EL3OU//EImAsd42YTwt1VTGx0p4MI
	 1Q9iFoEngirBmF3vNEBICv/Ttly80paf/ADLGXsG/LH2so9mokFKN9vEDvw7SJBqOb
	 IWCA92VrA3x/l2rBLpzCIMGUCeKSU5GmmNqXrgMXWEb4+rLszlhw3R2XXSkXhUNMrL
	 +qcLnZDfRz04w==
Date: Wed, 22 Oct 2025 12:39:08 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 5/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
Message-ID: <202510221238.F35859A@keescook>
References: <20251022181345.do.256-kees@kernel.org>
 <20251022182243.72085-5-kees@kernel.org>
 <CALvbMcA-MwhBd4y0+im5+xw8_sw3ut68fudwLoY6-nX5gmh0WA@mail.gmail.com>
 <202510221216.EA5EBB1@keescook>
 <CALvbMcAjVAW-YxLE+qcFLNXVKy0neDop0b1bi=_YfB=8JqBNDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcAjVAW-YxLE+qcFLNXVKy0neDop0b1bi=_YfB=8JqBNDA@mail.gmail.com>

On Wed, Oct 22, 2025 at 12:27:53PM -0700, Andrew Pinski wrote:
> On Wed, Oct 22, 2025 at 12:21 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Wed, Oct 22, 2025 at 12:14:32PM -0700, Andrew Pinski wrote:
> > > On Wed, Oct 22, 2025 at 11:27 AM Kees Cook <kees@kernel.org> wrote:
> > > >
> > > > Implement AArch64-specific KCFI backend.
> > > >
> > > > - Trap debugging through ESR (Exception Syndrome Register) encoding
> > > >   in BRK instruction immediate values.
> > > >
> > > > - Scratch register allocation using w16/w17 (x16/x17) following
> > > >   AArch64 procedure call standard for intra-procedure-call registers,
> > > >   which already makes x16/x17 available through existing clobbers.
> > > >
> > > > - Incompatible with -ffixed-x16 or -ffixed-x17.
> > >
> > > Can you explain why?
> > > The documentation for `-ffixed-` says this:
> > > ```
> > > -ffixed-reg
> > > Treat the register named reg as a fixed register; generated code
> > > should never refer to it (except perhaps as a stack pointer, frame
> > > pointer or in some other fixed role).
> > > ```
> > > In this case it is a `in some other fixed role`. Or is the problem you
> > > are using the allocator to figure out which is free?
> > > In the case of indirect tail calls, x17/x16 is always used for the
> > > pointer (since r9-5291-g901e66e03e1cd8).
> > > Which is the register class TAILCALL_ADDR_REGS.
> > > I think it is compatible with doing -ffixed-x17 (or -ffixed-x16)
> > > because it is a "fixed role" at this point.
> > > Though If both are supplied GCC will fall over anyways (will file a
> > > bug about that in a few minutes).
> >
> > This was done based on feedback from the riscv patch in v2:
> > https://lore.kernel.org/linux-hardening/dbf9a593-e19d-4f53-96d0-d067868f40b5@gmail.com/
> >
> > Jeff's interpretation of -ffixed-reg seemed to imply "GCC should not touch
> > this register", which seemed sensible to me from the perspective of the
> > "generated code should never refer to it" bit. How that interacts with
> > the "except perhaps as ... some other fixed role" is totally unclear to
> > me.
> >
> > Shall I drop all of the -ffixed-reg logic for all backends?
> 
> I cannot comment on other targets; they might still want it. For
> aarch64, it does not make sense to check x16/x17 being fixed when
> using KFCI. For aarch64, I suspect the check will be a generic check
> that is not connected to KFCI for the reasons why I mentioned about.

Okay, so for aarch64 KCFI, I should drop the -ffixed-reg conflict
checking logic?

-- 
Kees Cook
