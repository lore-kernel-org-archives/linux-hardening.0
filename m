Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320385;
	b=zGj8IHlTmadp8VL6NTfkh2FXRDEl9xgI6v2vGEmppZJz3a0ObGblacbjbQ13qMTKiG1+
	 MJ+/bWyks3HYUyyB+LiKI+pcFoBooR3v2BS62a9UxYj1KMAo09lmX0Nk1exa4HEC7ptSp
	 5Bd2ErVtFF/J9H9K73g4rsHo9LUjXciHOgdwMIgebyujmG0+DEHdS6vZKrv88uOPUwBHT
	 fGlUMHjNSsJouu0/HkdlLxwwuqst5lVVlcU8Efi+BPFMjTtSeW48tCLwEn1MLVglSjdUS
	 BdG66grMLKpOTP/hTD2xu/r6QNN9chOM/KISlwyV++tzgbDXvpVErlMBmT+IZw6I22g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320385;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=POoseU5QwHuTaUUqTtUaCKWgFktdvvSiU7J4FyrRut8=;
	b=j3lr79FWEA0WbUb1yxhcCxlPogf3hOQptiK0BgZF8AhAjCI/nNjSRzGVi4iTg5Soxn9Z
	 RytEzaz20DrcwSuGUM1OdOp8FgOhP1O6h3fdC5TID1GDuqfbMnFgfSoFIG9FrUFjzDxnp
	 zDR9wXe0kjgR7fsEfPg3IgfMwA/4yx3qiDZ3wvdEFUylQUPamylebYVeTHNq6Byfdj4DY
	 Kw4jLp0XgNSy6y1JF4/1xAqEQnxMLqgQ2zFSagTWr+9iArnjeNicPTsoeUixjPJqgs1Ll
	 B2zuFxSFYe4++/Cab6A4XsCCP1V+epSDfx0HA4fDhyZyzc6Mh5g3QUhOmUi4nUgXXsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDsH2EnX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF960A383E;
	Tue, 10 Nov 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDsH2EnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E481F008A1;
	Tue, 10 Nov 2026 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320384;
	bh=POoseU5QwHuTaUUqTtUaCKWgFktdvvSiU7J4FyrRut8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fDsH2EnXolC6lBYjERa8+hrs1OrXDOSShrHiB+D5vBvoOB+AmgDD7+mim8cvKWcNA
	 P6FgjtHvNXdz94wvEwC7NmaRIqO9GF2L2EY/FyN1xYiUWoc+xElEwJ/Rz4CwYcGs60
	 oqcqT4onDDt4km7S3u7oUc4+j5eLWjyXJ7wF7kmVfJ4BQHhgJ/1/Uzo3OPkFRX4y82
	 HhgI46xJX924YQhRzwrbBtcrFiybbUwONnsO9jYz77F8/RNV0ngWY6Bg+ZA5f+E3O8
	 CBghcxfkhqxr3u1DK77peWiRAaYph38WxyserAtZBNTNOZRRskHbOaWAAsggrsgIJu
	 dT/j4gTYagZwQ==
Date: Tue, 10 Nov 2026 14:19:35 +0000
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
Subject: Re: [PATCH RFC v10 04/22] arm64: Implement asm/kpkeys.h using POE
Message-ID: <07b55bf9-e116-4731-9f84-49cd1b55fa50@sirena.org.uk>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-4-aa6c4d9603bc@arm.com>
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
	protocol="application/pgp-signature"; boundary="gYHulBH5cftCD4rh"
Content-Disposition: inline
In-Reply-To: <20261109-kpkeys-v10-4-aa6c4d9603bc@arm.com>
X-Cookie: You can't take damsel here now.


--gYHulBH5cftCD4rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2026 at 03:58:29PM +0000, Kevin Brodsky wrote:

> +#define POR_EL1_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
> +
> +#ifndef __ASSEMBLY__

Everything else in arch/arm64 was converted to __ASSEMBLER__.

--gYHulBH5cftCD4rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzJ/YACgkQJNaLcl1U
h9DrHgf+Ntv2EG47dQBJVo2dflFo9Lt9TsvYKLCqzm33JoYC/P26mYi/8633hQW0
w2L056Uutdlq/ierGicH8Fb1zQIA88/FnTKEh+j872XE9Kz4ZNVl6MpVbWxm5oq+
FFU/2s66n/vbRZUIEfoM1X2ux5jjIHqdDWq4BeaMI0BS5ZpXXqVxkf+xsiESskAa
GCqvb4bLfjyFI005vGSvrjzju9Wd99csPXt8fcqRlDlXZOAPkJC9lwEdFNCxkMcg
LxBzbT062ehMLTyTGLIvAxVbakdWlTWbp6CglbDCrddaKZz1/9gRQ0w6yMYej1vM
O4DSvBecyFNT6MVKzNIRtQqL3QrIRA==
=esSa
-----END PGP SIGNATURE-----

--gYHulBH5cftCD4rh--
