Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413738;
	b=oTfs1yQS94PqXswTTEayi/G/ICMzbI9KNlvVxMAUj54db4ssE/eS+JViqrdG9O+wnUTX
	 Jxaq0GaQw7WJ2duyiwOhKBp3M9zsJ/sPYShIQek9yw4hn4WFbKqYehrf7vX7rWUqhoXVg
	 KUkPipY9dH/68VXgyJlgbMZcFtevxvdigkG2IDhyjLcZ4MSStKFvRuzzGXMQDgPrRvZva
	 bGtoRnhIP2IXfbdvTdhNZrQdiqofFSg/krx9kR9oI3Aoye0foQl7xQgvQU0u/c6gdS677
	 BhnwPfLMd+wxQjc1MCwBcXPpAPV2AfIJFfMsTbNqjP9u5M+6pHnZshh034wsu/o6fpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413738;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=6VIZ3PtCdrmMEOv2W4/v/h0FEesRkpl7sdLewNtxWW4=;
	b=X4MHKYNyUuK1R22OVtXQ8XdqjxfwhkJA10fxI6WFBhLb0btZY3bf4IEmD0NIGqayz33p
	 OfQvUdV3x62zYmzNEQowek1hhyTA1BownQmMiBtk3Witz/fjRbtKrl2klOAxpqwdBIQK9
	 pFNwv4aJROtN0k4dI5zfq9fPp8i/stW7r0y3aUMTUPPSVT/WSPpax/7/mG3hnqfjwJwAY
	 HIKUA3EmbKC5Wkbqx5NZJRp1b/LlxdXSHemARAmrRE/zqzTS4HtySp+Xh41cepm4zTF6Y
	 1MLUJgqyN6q2aY7kRVSOajhAiIfGi7PpeEnTNRZ3sFJlhYW3zWqeeyhS+F7gdsQvDNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXRFtoMu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7597606A333;
	Wed, 11 Nov 2026 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXRFtoMu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE261F00A05;
	Wed, 11 Nov 2026 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413738;
	bh=6VIZ3PtCdrmMEOv2W4/v/h0FEesRkpl7sdLewNtxWW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MXRFtoMupiT3qJYgXy2sB5augkLgLy01qRPMNW45hSF9TkcmcmWYGEuV1Vz8rWyW6
	 0ooJ3PmsQeytlwlshiRdctOVUiFAzHmpWyxKu9nbUHJdynm5l0dpxSF3+fMGPvTAtl
	 h5Wrl2+XF/DcnC0+tpUiX1ybjfuL2oM7cFwCwZpi+3ORaDY+l4Ad0P+yIjIazHFrIA
	 YKx6+GKltenDm8orj9uCHBo4Wv2y5lbssOY/NWJ+aLstSRAD6AtSBoYHk9V08IH3J8
	 /HJ0P69c8aNYZzrVMV0lGp4+KJ7N/z8bUp+urrmmHsLr3Ll0KkVI476EDVM0DHH0/9
	 +L8aD2xMGC3+A==
Date: Wed, 11 Nov 2026 16:15:28 +0000
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
Message-ID: <9deffbb1-75fd-407e-90cc-59bf4c2fa1a6@sirena.org.uk>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-22-aa6c4d9603bc@arm.com>
 <2d13fbb7-b5b4-446e-8709-5b43349ff19a@sirena.org.uk>
 <9e59fd71-97e7-422c-a7dd-bc23c6e6a852@arm.com>
 <717cccfe-81d6-4e09-a466-5361ae27776f@sirena.org.uk>
 <0b29393f-bb84-4df1-a699-f7afcb50f2e8@arm.com>
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
	protocol="application/pgp-signature"; boundary="OedQK9JKFipfKU6l"
Content-Disposition: inline
In-Reply-To: <0b29393f-bb84-4df1-a699-f7afcb50f2e8@arm.com>
X-Cookie: Do not pick the flowers.


--OedQK9JKFipfKU6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 04:29:02PM +0100, Kevin Brodsky wrote:
> On 10/11/2026 12:24, Mark Brown wrote:
> > On Tue, Nov 10, 2026 at 10:01:36AM +0100, Kevin Brodsky wrote:

> >> Do you mean adding the dependency KPKEYS_HARDENED_PGTABLES=y to

> > Yes, or something like that - unfortunately KUnit checks to see if the
> > config options appear in the configuration so something that vanishes on
> > other architectures causes issues.

> Alright, I guess there's not much we can do then, short of creating
> arch-specific fragments.

Or my suggestion below, or come up with some generic option that could
always be there and would in turn select hardening things.  There's
probably a case for having something given that the hardening features
will tend to catch some kinds of test error but that feels more config
fragment like.  Another idea would be to teach KUnit about the idea that
it should try turning on some config options but not worry if they're
not selected.

> > Perhaps the default for the config
> > option ought to depend on KUNIT_ALL_TESTS?

> Not sure I'm following, the config already has default KUNIT_ALL_TESTS?

The config for the test does, but KPKEYS_HARDENED_PGTABLES which the
test depends on does not so unless the underlying defconfig turns that
on the test won't be enabled.  I was suggesting also adding a default
for testing.

--OedQK9JKFipfKU6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr0lJ8ACgkQJNaLcl1U
h9Dq7gf/ZN2+f02DNQ9bdbwTMYXtyyu+7wCmjXUlHCsNgO5GlbWut9+uS4GmuCc9
WunBOQc+J/oUb1xLrMkgaxOW8h2KAztK6MPg8BzPufhwZctxuJ0HsBbUgTgnmHpc
uoZtu7URTziUz+kLkGEIB4+6a34aEQiW4SYdu5Z22jWqmT4vxb9JIQDA0e5V/Roc
hg2/qulDP5GDSotg3oHcwqqbXrxt4zvb6Z2fKdAZUJz3zc8gon/WHyqUXgJHRVOn
bFcpqtPEyz0j7rRAyFagwJ42Sq2SRDsU/qjaHb8Hne1OK9cK0DSMMlCJ3Lf/+sx3
Dk0E+Do8vqDs8wBZ0lCJuKqAtRjyng==
=+B7J
-----END PGP SIGNATURE-----

--OedQK9JKFipfKU6l--
