Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252517;
	b=bqH9p35tDQ+cQwS+P26FLKelj0CRv75UwaMLQotucX1W+sLF8ZYcQ74SSz8MEHLFPF8o
	 ZQHrNZZWGABkqyb1jXJfoZ7G1q5p2B4D2YMYN4uhVOPIRmvjGI3HDdxePLCQJhqJaZ235
	 ckGuPgGpzuI9CkCZkWEBu1NrdL4fNfe0anmrgS7D+NA1sokMAtCacHa8ZPwzUyt4XOnew
	 IykK4Zj2zSEJl6mwDmzGkbq4Hc0IrBUrtguJdq1dXqsNU2h7FxO+XKm5McRxp+M1UOVLc
	 HojmexMdJoV1fy9i5IJesGmDIwyzW5KxVt9oTazBVMrS+yTRLpxv3CQQ5axE5QT9KHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252517;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=PvK1FBUlQu92e+3qOO46yvXvWJ6xY3Ch9e+qtHZ8ifM=;
	b=159sSVPtIaoiZ8E4RjihyMN/wscTTScqRSYfMAEkJVc1iKndzX+vGY2V1/RjMdBX2kZ6
	 tKXeCOD8H7qO1oRboegQeYduRHQXtRTKdxa+CBHPc+9Vpahl+zeXDOB2h4wPNUW0IgvFI
	 US3nfiP/iBlDkoD7gcBKbQ6TSaWvCLYQUkVpOGWf7KSHXYTgIEszQ6+hiDdAqr7oRJxkM
	 7CQhKtrHN807b046xDiZaI9I4fB8Y0hAEERvNk9/MdGUEM+RmV3FZ/b/TYH+vjpBfMdHw
	 HvTiffUsmRiylC6YMbUynCDW8IYMWdmdPFTyE835rWEsHqNP5JCDQkzHhmcSkvcWriQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYUVVpaQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99982606A325;
	Mon,  9 Nov 2026 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYUVVpaQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A741F008A2;
	Mon,  9 Nov 2026 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252517;
	bh=PvK1FBUlQu92e+3qOO46yvXvWJ6xY3Ch9e+qtHZ8ifM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IYUVVpaQejpurCnmiYSSdzB7QEEI0r4B85C8K76h9yFnNJIPW8dxlBgo8Gf4RbywF
	 912hcLYLrkWoewMKDW5nvpzv1yqTIW7T1NnukrfgH/RGFu6tU7g49C/aBzA1eoOU2+
	 Xco6d23rGLqJTWskOkobA8dwadTfpbw96TxH97fHifLyMitYEsxHmuiVhiazCf2XGq
	 tvK1Tu9Yy3MzftA4rdouKVLkIgY13lIQdoTva7UujOM3xVVABeA1nHBEtYJelTnwZE
	 m2SKA95aBi7aBeiElZpEqK6RW3yOxjRmRh0thPi4BYk2+J0Xe+HNRJeyQXbyck8mT2
	 a6f6ciRegoZLg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 54E2F2FC6B1B; Mon, 09 Nov 2026 19:28:14 +0000 (GMT)
Date: Mon, 9 Nov 2026 19:28:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb+git@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
	Linu Cherian <linu.cherian@arm.com>,
	Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	=?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH RFC v10 22/22] mm: Add basic tests for
 kpkeys_hardened_pgtables
Message-ID: <2d13fbb7-b5b4-446e-8709-5b43349ff19a@sirena.org.uk>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-22-aa6c4d9603bc@arm.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/fHNA9/ObvvJyqoU"
Content-Disposition: inline
In-Reply-To: <20261109-kpkeys-v10-22-aa6c4d9603bc@arm.com>
X-Cookie: Whoever dies with the most toys wins.


--/fHNA9/ObvvJyqoU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2026 at 03:58:47PM +0000, Kevin Brodsky wrote:

> ---
>  mm/Makefile                               |   1 +
>  mm/tests/kpkeys_hardened_pgtables_kunit.c | 200 ++++++++++++++++++++++++++++++
>  security/Kconfig.hardening                |  12 ++
>  3 files changed, 213 insertions(+)

> +config KPKEYS_HARDENED_PGTABLES_KUNIT_TEST
> +	bool "KUnit tests for kpkeys_hardened_pgtables" if !KUNIT_ALL_TESTS
> +	depends on KPKEYS_HARDENED_PGTABLES
> +	depends on KUNIT=y
> +	default KUNIT_ALL_TESTS

I'd also expect to see this added to one of the KUnit config fragments
somewhere so it gets run as standard, though that's a little awkward
given that KPKEYS_HARDENED_PGTABLES isn't universally available.

--/fHNA9/ObvvJyqoU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavIezQAKCRAv73Ows9A4
ibK2AQCrJzPayeKs4GAc3zkVW3UwqtkA+D8a/edVfuY3OR/2bwD3XTl245dfPaNz
6bNpvbbPF3MhEBTENHBe9r4fl/a7Bw==
=iCAm
-----END PGP SIGNATURE-----

--/fHNA9/ObvvJyqoU--
