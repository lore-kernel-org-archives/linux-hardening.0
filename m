Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177A3F9FB;
	Fri, 19 Jun 2026 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841311; cv=none; b=JWHTkIe98wvQ2OrNNKX5fz4+xhozzzw+7iXf+iun/ZyeD0x+xOG2u99rC8dT8Q0mD75vLzuhvVvBitItOXqZfHGOo/wv5y9+Hm4BuGPrkT5JzJkksFW/TnYZuWAPRikhoibMeD2ex7rZRdJkfmKvncASi9VL4okGtLLRTbJTb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841311; c=relaxed/simple;
	bh=uvOqysg7g6JFLVWw6F4QCPhukzjY0iW99Eafs66OsuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlaFUXnabFtSe4vrry42uLReLGfAwdcGII0T7hxrObcuq95qKOWj6NMBKHUJVFbKQHkaj6N/YPz3G6suzr0iQ98Z/5pQ0oEYMuWMRbgoQHbBv+lMamgdPnxQJe7cP2NhNP+F9U/UeeT8EZlrN17Kqtb9gxQSbXyZrpUZANRsDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy3w1Pua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy3w1Pua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885DA1F000E9;
	Fri, 19 Jun 2026 03:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781841309;
	bh=ZovNZPfZZp9D3VOEN4ZPHQ9dgkBawa/CynQwV6Ap3A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iy3w1PuaXFgV4WT8LMcQBgx1C3tlmmsNAIk4NK1MVAqGbwRyEfzY9Efj+jeCBYGnB
	 Zh9FhCswGQOFKDmjEk5S648ip1SECr6OfP1rvypKLlgq+q9Q8uNFH6exSj280XCgou
	 AZG4cs30QXFdWrUp/zyeezYFTC2vlWgcyjiRd6DQ1Ff///ftt9vRWmDjs2fhyvSHV/
	 G/4ceAvYqaD7eGl+IzMgvntQqAW46CZCtheiTbh958v2sMYnvfWYl1C8PRG53RrUQG
	 QM77zD3v53OaXtEbcAy3mxnp119jw9NgUsW6fZTceQGu0akwBenPeOfTO4yxHzXgY+
	 TYcbjrSgkHF3A==
Date: Thu, 18 Jun 2026 20:55:09 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KMSAN: fix memset() when using fortify-source, again
Message-ID: <202606182054.A55B6CEE@keescook>
References: <20260618142951.1739694-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618142951.1739694-1-arnd@kernel.org>

On Thu, Jun 18, 2026 at 04:29:43PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Both kmsan and fortify-source replace the memset function. When both
> are enabled at the same time, the kmsan version gets used, which triggers
> a warning about fortify-source being nonfunctional:
> 
> warning: unsafe memset() usage lacked '__write_overflow' symbol in /home/arnd/arm-soc/lib/test_fortify/write_overflow-memset.c
> warning: unsafe memset() usage lacked '__write_overflow_field' symbol in /home/arnd/arm-soc/lib/test_fortify/write_overflow_field-memset.c
> 
> Commit 78a498c3a227 already tried to address this, but this seems
> to only have worked for memcpy() and memmove() but not memset(),
> which is still lacking the macro definition when KMSAN is enabled.
> 
> Remove the incorrect #ifndef check around the memset() macro.

Ah, nice find.

> 
> Fixes: ff901d80fff6 ("x86: kmsan: use __msan_ string functions where possible.")
> Fixes: 78a498c3a227 ("x86: fortify: kmsan: fix KMSAN fortify builds")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The patch passes randconfig builds on x86/arm/arm64/s390 for me,
> but please double-check all the corner cases, as it's still
> possible that the #ifndef is required to work around a runtime
> issue that I did not test.

How about I drop this into -next right after -rc2 and we can see what
falls out of it?

-Kees

-- 
Kees Cook
