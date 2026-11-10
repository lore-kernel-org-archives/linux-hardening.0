Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309877;
	b=c9tQ1p4DGJN77DywMS9d1nCNCkboQHIWJt2VSCfkBUqqY2TgfTbYj5pf4BKJORY6htmY
	 cdI1xsY9FLBPdSvkDD1jOgUR3xCPSjsyTY+Z8LlVnZF5TtKUpqNMbfpCHU0zWuDsG0sTa
	 UWfQ6FUKNzDs81HNT5HnUHr8qGKUjElqONEb263KzkwVFnPC6BzspZKgoaKP7erqHhW4I
	 uc22LA4cm8fgf7c4HkAtjDbiCdekbnyWHqPIJJL7DbJtJftqDGYgOyMjxBF7RAUR6XbnH
	 /hAXxK5iUhs3Wp53K6NCXkvVLwqquqQC0o9uynb7jlrMI+Ef+q+XChkWbQ/8KIae8hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309877;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=gtytf2wOlGKlE0TlreFVP+6q1oQ0wXhrbpcwMFr2kqE=;
	b=1p4RcnxPcLAx4xaAecC9dpL5QBv6QfsMpXRO1ssLy67sw0Vjo+Z031rxKc1bAGyeunp9
	 M4xBwIsKITkPbzyG4dC6/JdSwYwfaGZFUxZTMSeulV4qW23n8dvzHVMz9MpiTh/xl6aS+
	 69fMWg+mZyKqDZ7JWPWV0kThr/b9JaFyiVIabY4osmlUaOEX4/Vkxtosk5QoRQ6prxZ01
	 CsdE15UaBfj7Pt3NIRFRJ1P8UtSX8vulTwKnHDssa5LpkRlZMdA+YJ1i2lWSdYIpUp9XP
	 ymw1fNEeUv1lcyqsHO3Hvrkzxjn84Bv6whs3+6cRWp1SByL1sTlRy21HkCdGP6tRjGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWIygTuW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0160A2628;
	Tue, 10 Nov 2026 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWIygTuW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADD91F008A3;
	Tue, 10 Nov 2026 11:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309876;
	bh=gtytf2wOlGKlE0TlreFVP+6q1oQ0wXhrbpcwMFr2kqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZWIygTuWyMwrCCyWkgY7RsSrCDlQmRHjE9kDJJY9fgSKkW2X7Pzbdk/3g7E0JGGJj
	 mqde4QNo0dOhsy/Gn071pmagJMcFwkMHNEXlNvvPDwwp10eksS4IhEBAyNpcUUHNdg
	 03xRBW6p5vKfHW+VjaiwWf0yMYhOG5dztiwt7IvW67IkhnjAYpK1fJnR6QatxQkKpc
	 Z9tzO6sREiDZhnO+fEx9KNcU9tT1MGR+831DZvlJFymsBcBH7mSmiB/bkiRKz0KB+8
	 QOgrK4FV4ntU7mrjA9MLzJxXq9gTVW21ij/97aJSimoh+G1ihBNJeSIJ5pl1uTAFQi
	 BezOJm2/uzfMg==
Date: Tue, 10 Nov 2026 11:24:20 +0000
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
Message-ID: <717cccfe-81d6-4e09-a466-5361ae27776f@sirena.org.uk>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-22-aa6c4d9603bc@arm.com>
 <2d13fbb7-b5b4-446e-8709-5b43349ff19a@sirena.org.uk>
 <9e59fd71-97e7-422c-a7dd-bc23c6e6a852@arm.com>
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
	protocol="application/pgp-signature"; boundary="qb3IpGrfHJvhxTh/"
Content-Disposition: inline
In-Reply-To: <9e59fd71-97e7-422c-a7dd-bc23c6e6a852@arm.com>
X-Cookie: You can't take damsel here now.


--qb3IpGrfHJvhxTh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2026 at 10:01:36AM +0100, Kevin Brodsky wrote:

> Do you mean adding the dependency KPKEYS_HARDENED_PGTABLES=y to
> tools/testing/kunit/configs/all_tests.config? Indeed that would only be
> meaningful on arm64 (for now). That said it wouldn't hurt other
> architectures, so happy to add it there if you think that's worth it.

Yes, or something like that - unfortunately KUnit checks to see if the
config options appear in the configuration so something that vanishes on
other architectures causes issues.  Perhaps the default for the config
option ought to depend on KUNIT_ALL_TESTS?

--qb3IpGrfHJvhxTh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmry/tcACgkQJNaLcl1U
h9AxJgf9HO+bESqmb7Zyf8xVpU39o1ESgrk4qSe8omR1YVn15bXCLHubG4BA7k39
BBRjIUd0oKzcXxtFkuIyZLiQ194uaRe6MuOfoI+Ruzd2qjgzTlq18s/CUQYd23um
xjtw1Rb5Vj5ruXGAwkuBosPG2vqzM/kA0ruLkQQ1lknx0wrk4buAsFjcNPjsddup
ZjuRO6lSuXkDYGYG8l64ReC2hWfMTDKifeFbf0EMisifvHZ0dEmDf5Y+uJiG8l0v
fQU+vj+TzA5V1SPmj9DpyTfm2wWwqpbBgxyuE1eOOj5Cj7wZ4Pz+fHhnfcmklIiL
arkt18G1049QM3sfXwdWCKF3B89YVw==
=yf2T
-----END PGP SIGNATURE-----

--qb3IpGrfHJvhxTh/--
