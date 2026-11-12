Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488547;
	b=w/lcX1mQDWFsr3R5P4YzRAh3yS7msKwNlQ43k3x7NhT9iF4O3lOxvBdtMChSOq4AyFkP
	 nBkd+fAORMx3KMOdotaWJu+n4HJyISxtyEiKYHVS+/k0lLvtyMne7kneRgrhpxh6pALY3
	 ucylEUQMICSVyxv6mXMO6rEWrGBiCLD3OxFAp9jUy8YrrSBOFQGVYoiB1Ns9hDXCegGFq
	 t5idlya/JiykBNSUnjAGHdQHE08GgL9OXs/BFkoSswElsUACfnTYADqQ+l/InUJFocU1m
	 pqEtPFN8vUpsBvWbf0QMp7+ENMzRw/LgiLagYmq8FB8uKWRo3tqwRCha+XR3BOZcSgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488547;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=sDb3YBsZt3PeUijZoHvx7wyb02CrjviLOfxg4rIAk+M=;
	b=e3uSHlVmo506ngZVtwQqYVaUcugRMcv1hEEGYtrYK3dZl4x26oe+VxmRmecpHz3AnQi3
	 GGf/FB5R08eBV3ue9gCJ5bdmkWCRIJrWdh7JnSiIQvbEB3hb2IsRwrZEbDS4zuOAuj9Oo
	 0wp/skT/OQW0yhogvJ3N5SnesfbvE53VxlOPvdeZV37XYKEfkVm4sK3BdQqRdjP8hYtVq
	 twgarH3STtR6EJT511hXZHi8HN0sZcDqR5Ph9SH5MHkgtDQ42dlba94fGeNbfrNAPLDWo
	 HhWpy799n7hwMg0CM/2ImCajr8II56LsSF9pUUQ33Tw7YJfsCGvM+VtdfCRnyDzT14Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFJiTkr5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980E606A31C;
	Thu, 12 Nov 2026 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFJiTkr5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B481F00A05;
	Thu, 12 Nov 2026 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794488546;
	bh=sDb3YBsZt3PeUijZoHvx7wyb02CrjviLOfxg4rIAk+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oFJiTkr5drh1BtvY5o2xG9SbtFrLSayp52k7g32cCv+YRR0CLSNTOytMe5y6YJZnD
	 A3Ec3SnjYHkRM/LfaaukZbYC7tXR29Arwqny4tsBwitscyYNqHj6soAludR/zpNRif
	 DTiz3inDd+WROyNFUdmA5E/uaYVc7VwJDdOuLDXmIQ3H7eDF1lgEJrN96CaOYBGel9
	 EYjdlzRxDQUVciApvre1figz9FCSbNB8aMk3jNw/oilISn8V4z0fPwZwbhNFzYVovW
	 GME7WFgessJHRG2CJVDzRzDQ0wA4ZPHRpyzgBPxy5p72SUEQMcte6E2VW0TR3s7QLu
	 Lo3ciWbsVJivw==
Date: Thu, 12 Nov 2026 13:02:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-hardening@vger.kernel.org,
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
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH RFC v10 07/22] arm64: Initialize POR_EL1 register on
 cpu_resume()
Message-ID: <6808f3a6-1c12-4cb2-a109-30704d812490@sirena.org.uk>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-7-aa6c4d9603bc@arm.com>
 <be361be8-c5ad-4ff7-a6db-7b0815bfe1d0@sirena.org.uk>
 <avNH_AdvK9AqvfF7@e129823.arm.com>
 <7b92f7c8-1543-447e-8ef3-aba608141699@arm.com>
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
	protocol="application/pgp-signature"; boundary="SwoWk60SP+6OH4EA"
Content-Disposition: inline
In-Reply-To: <7b92f7c8-1543-447e-8ef3-aba608141699@arm.com>
X-Cookie: Baby On Board.


--SwoWk60SP+6OH4EA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2026 at 01:38:13PM +0100, Kevin Brodsky wrote:
> On 10/11/2026 17:36, Yeoreum Yun wrote:

> > Thanks. seems required to isb() after initialising SYS_POR_EL1.

> Agreed (as Sashiko reported as well). Presumably that means we also need
> an ISB after writing to POR_EL1 in cpu_enable_poe(), as that's basically
> the same situation.

Possibly just have one before writing TCR2_EL1 rather than for each of
the indvididual features, that's harder to mess up?

--SwoWk60SP+6OH4EA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr1uNgACgkQJNaLcl1U
h9CFagf/dbYYRxn1/SN8z0WGZlRKk0wplm+k3WdNb1XSdkf94D/1Qwvea+KXPDBW
GBfJo6UQx6bw0YLzuPp5KpPUHoNAS+NeabpCnFuiRKzWyRx26u7UtnSL5YTrQTXm
vcLPYfriMKpV2LSRfnOUqXjGkqN6ZmYDMiKn7oiklsMj4ajpPzU8/UJwjLd9DCTn
T6Wjdg7dHsxFLQ1CD5JY1aR6yFcEAwaSmbHWfAvqPAVAt0xPZPz4Jik4lFDjIkPD
vWG8oBS/TsJX7GhichxRZvfHllePuI7Q/4Ys/hf72gAofgR8K5Poy/9URdY/ctF5
2pyEuJxKkykegWsIvwnCxKgzSjEJAA==
=PoHK
-----END PGP SIGNATURE-----

--SwoWk60SP+6OH4EA--
