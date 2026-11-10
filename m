Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326020;
	b=IRPrhJy5N5C2OF7MBCwYRI75NZQWnN9V7ZE1rjDwK5/yzUpScPxLTjqIxsE2fO77R7LT
	 SPFKEHImIGXdn18vMDL4UC5fCqPyw4ciT9nXh4hlQ0VY9xwtAaXp/JGGJ7Vbow/qVM+EZ
	 20c2hLV+iglphD4VVIdeZIJPjbCfGEXFE5ipechlGhF8e6BmMNsAioCFrzuy+vhu7VqBJ
	 OJS2En2ONfX/Jhu27C3O6UnBl7q6x43LpYuSMknVgTaCAT4DcHhrB7rakkBF0XmSLqUHa
	 geeSaETDj218sMjeaBCjokWVa/xSzyTm07QT0p+kZ2Jnb97yl+5HL0uhrhLdN77giyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326020;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=4qaBcoJhuip85HNRKTiRsc6cXmbUnKal0wM/bMhZ1/4=;
	b=n2AL5ggXs4aRilrw4Kjj0CstkIBmYvbSjNGczKYvacj47+W9vY59Kz4kAPHKdPy2YAdS
	 TN3W6KlFxshiT4d9w8TLAF4bb6lzJA1pqHYYx5+7puN+JwnDGwTcWHgJ1U6+8SVOGzq2U
	 xGn/2VNnWlbqBwhjJRt8GTsZEeM2apjUAPRQh28jflGcTJhw7fYHv5DoSNFeU3fJth35z
	 QtzBcLtUFOgo2tezZ0sG1ODDls/0MquPqTTNE9ZEaWKasXbmLJYg6/BOCNhAFbq4S7Z2u
	 gLeZHdy0ziPG4wPw91XzjnE6hIiWMaJMYroPsBLShFaLtKdSW9vxzwS/TzlJRXNMNxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSgH+nQG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD360A260A;
	Tue, 10 Nov 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSgH+nQG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B92A1F008A3;
	Tue, 10 Nov 2026 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326020;
	bh=4qaBcoJhuip85HNRKTiRsc6cXmbUnKal0wM/bMhZ1/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSgH+nQGYPhpecDT9RjX6A/Px+LoAnOuAhiSotnuroSbtWAmzKYW4psaCtAgm3HTu
	 Ud6V+EHkVE3/ElaMQwFldGXubSt6xnnZ/H3lgzIXO1EM8FVi1btcbv6Q58NdTqn5kX
	 VSwm6LEMTkaplsK5V9TVhOGb77Pc7h/AvO0sKyFHmtojeCKTH7meWA2i2lB3xJQORv
	 LLCXQjH6SckaZOufXYpZi4+dMGxI7LRSKGENk099kRFe/hVqBoPU2XdsQ5DcgYensD
	 /N1jMWwlSmjxHjQj70tuBOg1mUKeFDv3uHaSqSd+3wj7rolN0iCh/5JK3PXXFiZxS4
	 +LKdNCB+uEhVw==
Date: Tue, 10 Nov 2026 15:53:30 +0000
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
Subject: Re: [PATCH RFC v10 07/22] arm64: Initialize POR_EL1 register on
 cpu_resume()
Message-ID: <be361be8-c5ad-4ff7-a6db-7b0815bfe1d0@sirena.org.uk>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-7-aa6c4d9603bc@arm.com>
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
	protocol="application/pgp-signature"; boundary="y6i2pjiKjCxCKcN0"
Content-Disposition: inline
In-Reply-To: <20261109-kpkeys-v10-7-aa6c4d9603bc@arm.com>
X-Cookie: You can't take damsel here now.


--y6i2pjiKjCxCKcN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 03:58:32PM +0000, Kevin Brodsky wrote:
> From: Yeoreum Yun <yeoreum.yun@arm.com>
>=20
> The POR_EL1 register is reset to an unknown value after cpu_suspend().
> Since POR_EL1 always holds POR_EL1_INIT when entering cpu_suspend(),
> initialize POR_EL1 with POR_EL1_INIT before cpu_do_resume().

> +#ifdef CONFIG_ARM64_POE
> +alternative_if_not ARM64_HAS_S1POE
> +	b	.Lskip_por_set
> +alternative_else_nop_endif
> +	mov_q	x2, POR_EL1_INIT
> +	msr_s	SYS_POR_EL1, x2
> +	/* isb can be skipped since cpu_do_resume() will do it. */
> +.Lskip_por_set:
> +#endif /* CONFIG_ARM64_POE */

cpu_do_resume() will update TCR2_EL1 to enable POE again, a sufficiently
unhelpful implementation could potentially decide to do that before this
POR_EL1 value takes effect AFAICT given that there's no barriers.

--y6i2pjiKjCxCKcN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzPfoACgkQJNaLcl1U
h9CfMQf+KE7tK9rhq506LXhS8qhdHDevtfZx2qtai6oaI8ROe6CSxZZ/PYZX/AxQ
RB6TsZs/ebSJ8cn//ARFNZTWaspOHI13wG87Laj48QjwPVZuyBAE0MV4dlqlxM8S
SUaN2cQ+xL/+x75htSgmDnA6NBZi/NXn8Ln2hpoiO8FO2oPSFY4l4xT9lMCvlol/
4g9degQsFMatI+eteIErPUBMjUrTr+jpSK6zC65gIHerzlhXvpQmwro7KV4njpMZ
zD2uA/+8YKidz8WAbiX8M9XETgaqWCGaTex5RrzWMqls1c0DvV4mFFlewowBTtEl
CC0tUcjeb2jQhyVBZSQ3m48X0DCWPw==
=ZUNG
-----END PGP SIGNATURE-----

--y6i2pjiKjCxCKcN0--
