Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492562;
	b=DmjzNXfZP3gIa4/a2cCDPT7a0JGXt/V+ub2bpSB4I9NiBcSXs7XkzvWuZa1FLWddRJnX
	 iB8mhWsPI7f6o0YS+7Z618ztDT+2ZTegJGZr7tfgV1S8AdveotNHq3mJrDwm0FVDZljJJ
	 J6Gi31chhaIy+mrGpoHrBLBpjwRFrVzwJG4GLnj/LQiplU3j0mWjKCS3Pb6yijJfk7I8r
	 5zH18NC/pBb3H9rfP6WEMCpB8lGfgYlmVC6UneSNaPZFXNjrFPXtaMicbgIlsQdDC4KNH
	 3xkzcaopNOM7wubulQuoZDULN2pfo49dEVntoMdIZXaa1TO2yF9WxuT/HWc8WlmDR6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492562;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=Bav+dbiKMPv2EGpsaUAhorWs7PAXLzQQGUUajdSwRU8=;
	b=RuQJHgqsMuAFApTbf6iBgNeuE6I/2M1LA5FvQjdCHxb94gvkC9p1Ol+LjWPYYHeboF4o
	 Mw/qiMwkuaN881kFKPInLAKBwskgdUBmKaArW04IvZYme/o5eAODrsx4CqiznQzGmn812
	 Dd1i7Y2pFlgIOX2gLoqhlm08cC0J6TrADuJExhsOn2vcoy1sQkIUM7kMeelkx03kzl/n8
	 nNf9KZReoITHOKL9ySoV/REB+FOPKFtrm2XZQ+V7+MQ4uoiUN17m7MA/J9fDUhOaE9Q02
	 /mYWvAORgIkEENJJpC3QuqiqvuD4mHI7VXS8ehh4yqDeM0uzj0UaJaxhOciw6XA1Ggw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsBDW7jk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD00606A323;
	Thu, 12 Nov 2026 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsBDW7jk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193031F00A06;
	Thu, 12 Nov 2026 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492562;
	bh=Bav+dbiKMPv2EGpsaUAhorWs7PAXLzQQGUUajdSwRU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GsBDW7jkZwGolei5OwviUP8YfwzZAxvq7dLne75yiI+QNaAhKCVLTXjTeGCmLawTS
	 A4BuUY4qYFLZc2UIeSe8ZibVZ3raDK3EiWH0ycSOieOQTKZd30GUVthpaI/jPpKmXE
	 Wgdc472S+8VsrgWtji6ZeAe/RPaxWsIfJC1/82UEevEwPBEUaYMPTiEiW5p8w08tj2
	 diQPmi5mPkydDsKrDYWdqNWZDO7b/pxth0rRA8iVyDuFGcZrrKai3IajCA/yKybHQE
	 h7ADR80unMaw3b73T/FJVgDl0hFOgO/3OgxibHF0Y6GLz2r/F3ctMavaZesf2EYRqR
	 mKlHk5hT9HB9w==
Date: Thu, 12 Nov 2026 14:09:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org,
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
Message-ID: <0d12b173-ba74-4d5d-b1d9-bd441033ba6d@sirena.org.uk>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-7-aa6c4d9603bc@arm.com>
 <be361be8-c5ad-4ff7-a6db-7b0815bfe1d0@sirena.org.uk>
 <avNH_AdvK9AqvfF7@e129823.arm.com>
 <7b92f7c8-1543-447e-8ef3-aba608141699@arm.com>
 <6808f3a6-1c12-4cb2-a109-30704d812490@sirena.org.uk>
 <avW7mVh-s90SdUYN@e129823.arm.com>
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
	protocol="application/pgp-signature"; boundary="ORVk8nI4MBGvkiv/"
Content-Disposition: inline
In-Reply-To: <avW7mVh-s90SdUYN@e129823.arm.com>
X-Cookie: Baby On Board.


--ORVk8nI4MBGvkiv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2026 at 01:14:01PM +0000, Yeoreum Yun wrote:
> On Thu, Nov 12, 2026 at 01:02:16PM +0000, Mark Brown wrote:

> > Possibly just have one before writing TCR2_EL1 rather than for each of
> > the indvididual features, that's harder to mess up?

> I'm not sure that's necessarily better, as we'd end up executing an isb()
> even when POE or other features aren't enabled.
> Wouldn't it be better to execute an isb() only when needed?

OTOH it seemed like we'd repeatedly omitted them where we needed them,
and we'd end up issuing multiple barriers this way.  But Kevin pointed
out that the second one needs to be where it is anyway so it doesn't
matter.

--ORVk8nI4MBGvkiv/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr1yIgACgkQJNaLcl1U
h9AwXwf+NHY6AAbg8csFjXrZMuDQdUMboaJkVfC+Hn1q5Gsm/gt8SqmjIwUM0/R3
MBiR8arflazFuvWDuOyqikdvaaggIetDiefUXzhSqBmVdUZSP5znX/cGchB3ATHU
r9jz5IaIKvtxnWr+m3uCzKwQgjqCSsq5uDNirluS7voueb/fqJG9Ff99KsgujR99
ush3ACE4LSyOZc7fOAr2h73OsMxJE9HG2pT4Qn45Bngd3yW4+kKaB4q8oWwin8nj
Pc2uX+vfLnh8hRLAbDxc1EOt5vLd+ws+QGxlneaX8NBf56pZWPWra4vvfJIVIqID
Fv8s1/jFofx3Fe/o4LjSia4hffneCg==
=1AlE
-----END PGP SIGNATURE-----

--ORVk8nI4MBGvkiv/--
