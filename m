Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43512368D56
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609576; cv=none; b=Nx5wi8Of2PBur0m9rlEBs+465IVxprKqtpBEJY7j/WTRIS8b3/9HAA8XEffkU1jlBJJqicuSvzVenjxxlNf9p7gWxDTR9EFGMRikTqqcyY5Kb0feq3SPaqxr2QI/c4ehmWqnk/JPJEeDLE2VevGnx8TJ0ZslmrOG8BL2jNl4evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609576; c=relaxed/simple;
	bh=HyKACt9ipPwAlSRagUzcMggCrWZ+wVqIkcKgzKb8HyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9QcHDo+hCpoCdz7aKzzL/Ghg16voIou8m5O/R1FdQey2g7yMEavozgthxrY4Mh05Gi/pIgzLtjZZ3vPl6NKsgeuJdB+cZaIj7MHuMT29ReGYgyKWvsdy4c8kLkdCPJ/Wr62j6QMldn8yT1MNjnvTRI1G1IAqZPwOlhS/+l9y4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=OhfNflcv; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="OhfNflcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1778609561;
	bh=FA2uo7Eti6JQsAR+pR7IPAdvJPHo6UsnhalieCimSwQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OhfNflcv8NK5lQqeadnJIrDkaijSYuP8jws6hSbhKWld+CBGEP4GLBWh2AzuQqDWY
	 TmiZSSvYja1yh/F0lKd/MQ2LzH+OqqlMhKA7G9dg9eI2c6Cuwlqn/FugzioHFU6PJj
	 pBoNwIQtXVeXtj/0fF5V1dRaqH4eA2gaaShV9GEI=
Received: from vra-171-31.tugraz.at (vra-171-31.tugraz.at [129.27.171.31])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4gFPnz0zZrz2xJW;
	Tue, 12 May 2026 20:12:38 +0200 (CEST)
Message-ID: <9e8299b39d3c62d62a364920b258a87313cede01.camel@tugraz.at>
Subject: Re: [PATCH v11 1/7] typeinfo: Introduce KCFI typeinfo mangling API
From: Martin Uecker <uecker@tugraz.at>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Pinski
 <andrew.pinski@oss.qualcomm.com>,  Uros Bizjak <ubizjak@gmail.com>, Joseph
 Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,  Jeff Law
 <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek
 <jakub@redhat.com>,  Ard Biesheuvel	 <ardb@kernel.org>, Jan Hubicka
 <hubicka@ucw.cz>, Richard Earnshaw	 <richard.earnshaw@arm.com>, Richard
 Sandiford <richard.sandiford@arm.com>,  Marcus Shawcroft
 <marcus.shawcroft@arm.com>, Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito
 Cheng	 <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew
 Waterman	 <andrew@sifive.com>, Jim Wilson <jim.wilson.gcc@gmail.com>, Dan
 Li	 <ashimida.1990@gmail.com>, Sami Tolvanen <samitolvanen@google.com>,
 Ramon de C Valle <rcvalle@google.com>, Joao Moreira
 <joao@overdrivepizza.com>, Nathan Chancellor	 <nathan@kernel.org>, Bill
 Wendling <morbo@google.com>, "Osterlund, Sebastian"	
 <sebastian.osterlund@intel.com>, "Constable, Scott D"	
 <scott.d.constable@intel.com>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org
Date: Tue, 12 May 2026 20:12:38 +0200
In-Reply-To: <20260512083525.GV3126523@noisy.programming.kicks-ass.net>
References: <20260511194847.faster.180-kees@kernel.org>
	 <20260511194902.701280-1-kees@kernel.org>
	 <62bf9b04fa4eaac6912a0ffd1c4a5114afb5df7d.camel@tugraz.at>
	 <202605111337.62C81472F5@keescook>
	 <e367e0ceadbaabcbdeed786db2cbc3c946e7d639.camel@tugraz.at>
	 <20260512083525.GV3126523@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116

Am Dienstag, dem 12.05.2026 um 10:35 +0200 schrieb Peter Zijlstra:
> On Tue, May 12, 2026 at 10:13:42AM +0200, Martin Uecker wrote:
> > Am Montag, dem 11.05.2026 um 13:41 -0700 schrieb Kees Cook:
> > > On Mon, May 11, 2026 at 10:08:06PM +0200, Martin Uecker wrote:
> > > > Am Montag, dem 11.05.2026 um 12:48 -0700 schrieb Kees Cook:
> > > > > To support the KCFI typeid and future type-based allocators, whic=
h need
> > > > > to convert unique types into unique 32-bit values, add a mangling=
 system
> > > > > based on the Itanium C++ mangling ABI, adapted for C types. Intro=
duce
> > > > > __builtin_typeinfo_hash for the hash, and __builtin_typeinfo_name=
 for
> > > > > testing and debugging (to see the human-readable mangling form). =
Add
> > > > > tests for typeinfo validation and error handling.
> > > > >=20
> > > > > This ABI needs to match what is used by LLVM Rust (which matches =
the Clang
> > > > > ABI) so that KCFI can work on mixed GCC with LLVM-Rust kernel bui=
lds.
> > > > > Instead of inventing a new ABI, all use the existing Itanium C++ =
mangling
> > > > > which matches KCFI's needs.
> > > > >=20
> > > > > An important aspect of the C++ typeinfo behavior that is retained=
 here
> > > > > is that typedefs are treated as pass-through except when the unde=
rlying
> > > > > type lacks a tag (i.e. anonymous struct, union, or enum). This pr=
ovides a
> > > > > distinction between those typedefs and typedefs used to provide _=
aliases_
> > > > > (u8, uint16_t).
> > > > >=20
> > > > > In the future, an additional "strict mode" builtin helper pair co=
uld
> > > > > also be added to follow strict ISO C type equivalency instead of =
the
> > > > > existing typeinfo used here, but that is out of scope for this pa=
tch.
> > > >=20
> > > > Note that ISO C would require *less* strict rules, so the current
> > > > mangling would reject compliant code.
> > > >=20
> > > > These ABI issues were recently discussed also on the rust side.
> > > >=20
> > > > I now worry that it might actually be a mistake to enshrine
> > > > the wrong rules into the ABI, creating language interoperability
> > > > issues which might then plague us for years.
> > >=20
> > > Well, this matches what we've already created (and have been using fo=
r
> > > years) on the Clang side. I'm happy to rename this to whatever you wa=
nt
> > > to avoid confusion, but I don't really want to change the rules of th=
is
> > > ABI. I'd rather get it working as-is, and then if we want to make
> > > mangling changes, do that simultaneously between GCC and Clang.
> > >=20
> > > And this is totally do-able, e.g. I've already created the transition
> > > path on the Clang side for changing the hashing algo. For KCFI, we do=
n't
> > > need to worry about cross-ABI-version compatibility: the kernel is bu=
ilt
> > > as one binary, effectively. We just need to worry about GCC/Clang
> > > compatibilities given the Rust side of things.
> >=20
> > I think with the generic names (__builtin_typeinfo_hash) users would
> > start to use this for all kinds of things (because it is useful more
> > genrally!) and then run quickly into trouble.
> >=20
> > So I think one should either have less generic names, or probably bette=
r,
> > some kind of ABI argument. An ideally, we would then provide a
> > standard-compliant and future-proof mode out-of-the-box (I can help
> > with this). If the kernel then opts into a stricter mode this would
> > not be problematic.
>=20
> From the kernel PoV, GCC has been lagging behind horribly on this, and
> the sooner this gets merged the better. If Kees were to rename these
> intrinsics to __builtin_kcfi_*(), to make them really specific and free
> up the namespace for the more generic one that should be good enough,
> no?

From my side, more specific names would be ok, but I can't give
approval anyway.  But if anybody wants to design a hash that is
compatible with C's type system, then I am happy to help.

Martin


