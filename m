Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31F4418F0
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573636; cv=none; b=P2qVkv6XplGzyjeMNcS7A4ueH6421ITLLvXbCL23dF2VN1SvFsjo6OOpJxbmwVmG6Uci3z2avraXiBDXhJjnKbRlHyhBzVFBdDA0K5og8JAooNuV5Vg4jq4TCNjnHP9+alSXQ0kHsdtaqbcdygDh2o9gt3nBRcNYqDg31ioT3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573636; c=relaxed/simple;
	bh=+J3JOyrEnwGNp78Rstl+74hso3UiBGZZumKucbSWJJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJKTwNZtMghhUK35k1eJrJE9jSRJZRGhduiiwbuFS/3/HUj8MQ450pghjqHELYGaZvQ5RC8+escHuBtNwNpDtcmNC9ajMVi9vEFJaOo5Efb6e6h4q87y9x/12B6kchb0yeA11bCNNFO5W+enAa9UhbfI0Ls9LG5/u0Bt/osPWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=kahkg4Ko; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="kahkg4Ko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1778573624;
	bh=+J3JOyrEnwGNp78Rstl+74hso3UiBGZZumKucbSWJJ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kahkg4KoZkYwlKF2I9bNr/9X4a4ckbTjp7EfuXL4/sqD9U5/Bdai9Zq7EL/LAdxTE
	 FUxPSeE1d7zDYJGH9VKy1vFlVfeSwTTH/vP20L0tY/x6+iaw0sz+yRyvu+rX7v2dzV
	 Qwz4WSe9nvmjMhxDE9yWV5IEwi7WXhhu0Dk9DHhU=
Received: from fbmtpc21.tugraz.at (fbmtpc21.tugraz.at [129.27.144.40])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4gF8Vt5lyHz9s0h;
	Tue, 12 May 2026 10:13:42 +0200 (CEST)
Message-ID: <e367e0ceadbaabcbdeed786db2cbc3c946e7d639.camel@tugraz.at>
Subject: Re: [PATCH v11 1/7] typeinfo: Introduce KCFI typeinfo mangling API
From: Martin Uecker <uecker@tugraz.at>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>, Uros Bizjak	
 <ubizjak@gmail.com>, Joseph Myers <josmyers@redhat.com>, Richard Biener	
 <rguenther@suse.de>, Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski	
 <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>, Peter Zijlstra	
 <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka	
 <hubicka@ucw.cz>, Richard Earnshaw <richard.earnshaw@arm.com>, Richard
 Sandiford <richard.sandiford@arm.com>, Marcus Shawcroft
 <marcus.shawcroft@arm.com>, Kyrylo Tkachov	 <kyrylo.tkachov@arm.com>, Kito
 Cheng <kito.cheng@gmail.com>, Palmer Dabbelt	 <palmer@dabbelt.com>, Andrew
 Waterman <andrew@sifive.com>, Jim Wilson	 <jim.wilson.gcc@gmail.com>, Dan
 Li <ashimida.1990@gmail.com>, Sami Tolvanen	 <samitolvanen@google.com>,
 Ramon de C Valle <rcvalle@google.com>, Joao Moreira	
 <joao@overdrivepizza.com>, Nathan Chancellor <nathan@kernel.org>, Bill
 Wendling	 <morbo@google.com>, "Osterlund, Sebastian"
 <sebastian.osterlund@intel.com>,  "Constable, Scott D"
 <scott.d.constable@intel.com>, gcc-patches@gcc.gnu.org,
 linux-hardening@vger.kernel.org
Date: Tue, 12 May 2026 10:13:42 +0200
In-Reply-To: <202605111337.62C81472F5@keescook>
References: <20260511194847.faster.180-kees@kernel.org>
	 <20260511194902.701280-1-kees@kernel.org>
	 <62bf9b04fa4eaac6912a0ffd1c4a5114afb5df7d.camel@tugraz.at>
	 <202605111337.62C81472F5@keescook>
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

Am Montag, dem 11.05.2026 um 13:41 -0700 schrieb Kees Cook:
> On Mon, May 11, 2026 at 10:08:06PM +0200, Martin Uecker wrote:
> > Am Montag, dem 11.05.2026 um 12:48 -0700 schrieb Kees Cook:
> > > To support the KCFI typeid and future type-based allocators, which ne=
ed
> > > to convert unique types into unique 32-bit values, add a mangling sys=
tem
> > > based on the Itanium C++ mangling ABI, adapted for C types. Introduce
> > > __builtin_typeinfo_hash for the hash, and __builtin_typeinfo_name for
> > > testing and debugging (to see the human-readable mangling form). Add
> > > tests for typeinfo validation and error handling.
> > >=20
> > > This ABI needs to match what is used by LLVM Rust (which matches the =
Clang
> > > ABI) so that KCFI can work on mixed GCC with LLVM-Rust kernel builds.
> > > Instead of inventing a new ABI, all use the existing Itanium C++ mang=
ling
> > > which matches KCFI's needs.
> > >=20
> > > An important aspect of the C++ typeinfo behavior that is retained her=
e
> > > is that typedefs are treated as pass-through except when the underlyi=
ng
> > > type lacks a tag (i.e. anonymous struct, union, or enum). This provid=
es a
> > > distinction between those typedefs and typedefs used to provide _alia=
ses_
> > > (u8, uint16_t).
> > >=20
> > > In the future, an additional "strict mode" builtin helper pair could
> > > also be added to follow strict ISO C type equivalency instead of the
> > > existing typeinfo used here, but that is out of scope for this patch.
> >=20
> > Note that ISO C would require *less* strict rules, so the current
> > mangling would reject compliant code.
> >=20
> > These ABI issues were recently discussed also on the rust side.
> >=20
> > I now worry that it might actually be a mistake to enshrine
> > the wrong rules into the ABI, creating language interoperability
> > issues which might then plague us for years.
>=20
> Well, this matches what we've already created (and have been using for
> years) on the Clang side. I'm happy to rename this to whatever you want
> to avoid confusion, but I don't really want to change the rules of this
> ABI. I'd rather get it working as-is, and then if we want to make
> mangling changes, do that simultaneously between GCC and Clang.
>=20
> And this is totally do-able, e.g. I've already created the transition
> path on the Clang side for changing the hashing algo. For KCFI, we don't
> need to worry about cross-ABI-version compatibility: the kernel is built
> as one binary, effectively. We just need to worry about GCC/Clang
> compatibilities given the Rust side of things.

I think with the generic names (__builtin_typeinfo_hash) users would
start to use this for all kinds of things (because it is useful more
genrally!) and then run quickly into trouble.

So I think one should either have less generic names, or probably better,
some kind of ABI argument. An ideally, we would then provide a
standard-compliant and future-proof mode out-of-the-box (I can help
with this). If the kernel then opts into a stricter mode this would
not be problematic.

Martin
