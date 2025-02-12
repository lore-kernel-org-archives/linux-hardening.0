Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC92036F6;
	Wed, 12 Feb 2025 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397912; cv=none; b=CivcJsudJyQBTt4hjlnwzs23q6KoNOP258QOcf627YirXzZrV2R74ng+2Fe/JcAAhmKeVZvGYPLuZtDxTpJfbjMKMCjWAdqq1mF+fJrreUqh5RGkJUHFJv6MS14Nld05Lxd7UcBQ9WYAZLvk0PUNXHXjLfIP7XpiyJjDX63nCj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397912; c=relaxed/simple;
	bh=Y884TGbn38v12x+Fv+o7ctbuzGeY4ETaEIEr0q7aULw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rd9FqvDYQuXKmxWW2RnGA3+CLylyYZ2ADo/tlZKJbOJhhzpSZw56z2J0oplSCzQA2cqVCasTE8w5Gkp9+dj+V6EU2R32ys3W8jsiDWTNoMqf6435sIfapQz/vWoqiYrHVUkmoyqFZKfhg5W2xR3zUuwcwOg3FPbYAMEGWvZ6z1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHalxVGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHalxVGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE1EC4CEDF;
	Wed, 12 Feb 2025 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739397912;
	bh=Y884TGbn38v12x+Fv+o7ctbuzGeY4ETaEIEr0q7aULw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHalxVGCbt3PfQou4OQRbr4DwEpl8QOgU7jwY0/FYRBigeT+XLRZzlOWjg4thCeUv
	 K6Tzruh4gnBDgGNndSep6EUcTu70RTNhqQdL+Pm0U+QTX3oHWU5D21zKcCscSQTvSX
	 vBb8LdcOQ2eYbMZLtoNyP1zsOZHPaskdgsqSt3Bb2G39EdOCXNEn8AT9RPCUKTCeys
	 2pMgMIx3dtCYl32OTbOk45yET5jc4LAd44lQgtaWT8VUgu7Y4G/0JUlm8DAB9T8VBt
	 gSF1DtLQpv3ow4DsQIDF4bZ4CIdfRU4tjAE9D3deFv8rSYay661wuAgmCS0TBOR+N0
	 NjR+X8sKMLTBA==
Date: Wed, 12 Feb 2025 14:05:11 -0800
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
Message-ID: <202502121401.B6EF2D4517@keescook>
References: <20250212032155.1276806-1-jeffxu@google.com>
 <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>

On Wed, Feb 12, 2025 at 11:24:35AM +0000, Lorenzo Stoakes wrote:
> On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > The commit message in the first patch contains the full description of
> > this series.
> 
> Sorry to nit, but it'd be useful to reproduce in the cover letter too! But
> this obviously isn't urgent, just be nice when we un-RFC.

I advised Jeff against this because I've found it can sometimes cause
"thread splitting" in that some people reply to the cover letter, and
some people reply to the first patch, etc. I've tended to try to keep
cover letters very general, with the bulk of the prose in the first
patch.

> It'd be nice to update the documentation to have a list of 'known
> problematic userland software with sealed VDSO' so we make people aware.

I like this idea! Probably in mseal.rst, as the Kconfig help already
points there.

-Kees

-- 
Kees Cook
