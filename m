Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56C2E8E09;
	Wed, 12 Aug 2026 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493869; cv=none; b=XCAQO7Im2flH/mIepoe/E95fCT9ZKgbtPwn7szwp79JJyHbVfnvAf0aFgsS9a9hMfHkoaS0GOFZLOuAP//y9of4XnAHJTxs+ll7f/7p//pmGlJfjWdD6vP9J1z20HiBw/shnv4Ki6DrdgjcSqJ5cVy5kxfBB/k5rixvXHLe72r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493869; c=relaxed/simple;
	bh=ha1cQzHmeAmgOC+MpY19CCwpCTIA2rRwWnQl2ETVZNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGMY5rBJeiR3nAKVrUd1KGMnXhPh+4BU95mGM+plIzHmgdJOn5HTjWj/I+0vKXmwcQYv/5ktfhzuXHIG4L51qGy9kwHBAKKMBfzFI1rGPrl9duKpUNM0w9tNgTIJ8wWCew8UKbVpnyfS7l/3dn64mAutrRljPNfLFoOYpJOJHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM0nOym2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM0nOym2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11791F00A3A;
	Wed, 12 Aug 2026 00:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493868;
	bh=glKqfK+8vzTCcTVl+aipxjInjbAI8DgcIFu3nly0kUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eM0nOym2AGLDqOZx4l707CB6YZfsavdmW4jozp1YGS6OTk9ElQ+5pMP3jZdH25VN9
	 h4SilSashnxag0aWqDrMETcxkHsUhK83w6jubzXHtiBquUKc1XowcYtE8Czk4Q5wVS
	 l3kGCRBF1DcRfad+neGD/cpPRDKdVAS/9nt7dW+ehAWVzu4kwOKQImVGZJCrQDK5Ku
	 +nL3kbap8HBJQU4gyrOb2p7sYQTnIwpC0PbaaWdaVQX6yzD/K0wdSjGZYPgtUO/OF5
	 hFKTAK5J1NYf9lBnglBI7NU1+yyeA8u3+9J0j2QRj/vLC3OnVFm+YYSD1GWnd5apMW
	 Jg9jUpLStmBmA==
Date: Tue, 11 Aug 2026 17:17:48 -0700
From: Kees Cook <kees@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/3] slab: check for ZERO_SIZE_PTR by exact match
Message-ID: <202608111716.0FA9DB17@keescook>
References: <20260811141240.62519-1-kmehltretter@gmail.com>
 <20260811141240.62519-3-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811141240.62519-3-kmehltretter@gmail.com>

On Tue, Aug 11, 2026 at 04:12:39PM +0200, Karl Mehltretter wrote:
> ZERO_OR_NULL_PTR() returns true for every value less than or equal to
> ZERO_SIZE_PTR. With the sentinel raised to ARCH_KMALLOC_MINALIGN, up
> to 128 on some architectures, the helper matches additional values
> that are neither NULL nor the sentinel.
> 
> Compare explicitly against NULL and ZERO_SIZE_PTR. Store the argument
> in an unsigned long temporary to support both pointer and integer
> address arguments while evaluating it only once.

Can we move ZERO_SIZE_PTR to cover the ERR_PTR range too? See this issue:
https://github.com/KSPP/linux/issues/93

> This also changes check_bogus_address() in hardened usercopy: nonzero
> addresses below ZERO_SIZE_PTR no longer cause its null-address abort.

And then check_bogus_address would also catch ERR_PTR.

-Kees

-- 
Kees Cook
