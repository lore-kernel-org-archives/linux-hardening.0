Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324560;
	b=AcEIWsNyuFjEtjT2AVE2ok6ylaX2jw2eGVMRFEbzjzBBGYxDKmCkF2D40PEpavdAUzQ1
	 kUpvAuNSvypm0YJrXr3yhCzkbCjPqHe6vExQS8qUa7lb1orKvbhNj0h2BXq+RtMRuo0yn
	 NKK+TQ7ODr2lsNPqP8WTdMo9vKc+ZULN+rC8b67e0hxx9cFQHImGyH/57XV9sJCcqtw6J
	 pK3VVaAE8gydf6DALehNkPBLEShCYEzDd6XIw4aIz80I5lJb4M05FpwKYZCWXzODXeSRX
	 8FEAhzfGRRlzxc0Fh6D8PKoCPBiODSoJXcCu62zqjws+5q/4mHJoy2i4Ti8a5eWI5iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324560;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=Bt4p16M4Hn7px1KF+H5JB36BxwFxJbfBsjU1XaPYy7I=;
	b=e+1hgrhluOI3OTHTN75+72tslg+OODuWIr47wsQbCAJCcPBAYrZLB+fdnjvVlUS6FzsV
	 qffp98Y71+5LHTiRjZmXGLCL6NYpGAam1a2eRaTSQehH3lqLs+mcbeoysIpRDvTrUSM6U
	 P3NhR08qvtPL0uMYkBDhHvKY51YC7NQKlxLelnrLhL6JYIjXE8lrBh994BLKTFs26VXNk
	 z2XB71EpVrxhK5F9LC1CtFSAbkGUYep1TdTDZY4GjkZ3cqh2OeTCJ620L3mOGj3W5pEyO
	 IGZ34jEm8OdSW8uee+371qw7oC3g9HiMTv8/3HxbO6OiVErC3H72V/KQw4d+65+/qVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSJs0Dw0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDA60A3827;
	Tue, 10 Nov 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSJs0Dw0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F8D1F00900;
	Tue, 10 Nov 2026 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324560;
	bh=Bt4p16M4Hn7px1KF+H5JB36BxwFxJbfBsjU1XaPYy7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TSJs0Dw0xyOaRnZl088l0F3yIjGw4rU/H2At2c8xdDHdp8SerI4hF6PCuWS3HEruj
	 fQCx/eJIQmjee38K0kl88oaP09m8oPFuWfb0SN2hdJzERKh8HBENPPbNq39MNh2UPZ
	 6LUEoOgWA4i1YTnY9oJO82udks6VcVjN25+VrrtAMglfx6zUadZkKlzvwnivvOYNaB
	 65uMmDKxwsnbXEjB0BONIyAxG3GTaI7iSmzK/z4wlqJSwCXkSd0psBWDyBjr1GYhQD
	 0+xb/kDbfockIG1X6kXknznczMF7Drsf/dASORnmaQY6SbL3ZRlz28lUCakAsVrTFc
	 ordjZse33Ca5g==
Date: Tue, 10 Nov 2026 15:29:10 +0000
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
Subject: Re: [PATCH RFC v10 06/22] arm64: Disable EL2 trapping of POR_EL1
Message-ID: <3500936b-4177-4ba0-a9df-7eb9d9d75b0a@sirena.org.uk>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-6-aa6c4d9603bc@arm.com>
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
	protocol="application/pgp-signature"; boundary="nrZdJCOCfevRaauL"
Content-Disposition: inline
In-Reply-To: <20261109-kpkeys-v10-6-aa6c4d9603bc@arm.com>
X-Cookie: You can't take damsel here now.


--nrZdJCOCfevRaauL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2026 at 03:58:31PM +0000, Kevin Brodsky wrote:

> Make sure EL2 doesn't trap kernel accesses to POR_EL1 by setting the
> nPOR_EL1 bit in HFGRT{R,W}_EL2.

This wants a matching update in booting.rst as well for when the kernel
is booted at EL1.

--nrZdJCOCfevRaauL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzOEUACgkQJNaLcl1U
h9Ag0gf/f9f5XP+mPu/qkq9MsiAddVfTPO5cBvZan8qUxzXzuilhA54mF0WCZWl8
+Fmzl+Q0J4gwxCKcr+yCLoOyMvLGiUCFQVnPcJT7wMBqrZ5DA5f/OW6YWx6uMZyT
ExUsefodnzmOczU+s41SARPFGFuRuJsT756diQQYF/IlO8wq0GJ8mWoBGKf6H3OR
BKFwnc4Cda3sUrlQ5UU1Y5DRXoHpQJe2+dz013uXt14vDmtxE8P0840PIRU+Y/F2
zhXRtj08uReTLuyfCpkD2RuiPx2DKigEDjHND7yPRfuiA/qskHTAtBBtxtRcXoNc
7EjgnbeiJeosuSBYcCi5CS+h/Sh4Jw==
=osnL
-----END PGP SIGNATURE-----

--nrZdJCOCfevRaauL--
