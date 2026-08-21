Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9813242AB;
	Fri, 21 Aug 2026 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339227; cv=none; b=mCWxdr/XSJw319Uyk+5AwtNjGxuarVHE7EZCefDXMNII6nmajBxerYTeK2tii4j9FYFrvw4qNqwLXZJdkUGw7k6nKCb+5QyPceSqdJkJwR4P7ZcFetXi3zLJjP3EZfzV8bwaPl/Cu4jqUqcCyc3C6r8vBx03M8Usm+/g3wC3kJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339227; c=relaxed/simple;
	bh=VSqvKc2WPPRbtApAoHbxG++57/FZsHsWBHPJCNpFYLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=larVodyT5fmTX5I7xP1W1JAm3vkDBvjODKK5H9JzVTgS8qL34QWk+adoY9e8NiZl+OUtovqf4VNwBfJz0vna3lXQc+mPEhbIJalm89Q4bFww64l+OhgWSxtRHyKcKC+3bFl+0Mi3/5V/5IUezMBAaFFfKpb1ywWNmUDeSBfG1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDzGXnBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDzGXnBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283FE1F000E9;
	Fri, 21 Aug 2026 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787339225;
	bh=d5uY24HpEOnJTtHy9aG87aWZw3ykd7JD2snifpWtVAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iDzGXnBux4fDqK5T5j9/qSX4bQqrh/DW1NDNRuxHmPB0zyEwXQTjFUwLLMqmNHO65
	 kY4Facs8d/IchVTn3AhBJATGnlnFtUwe7taz9QnR6gkJwZ9lt1VvkY6TpFPAcE1Ii9
	 cRy8//8/n72AYW3Ow5pN8RXOsLk85XkUnFNMX+tX2GO5lzwwSJC/Ks1QL1s9UvXp8G
	 XOZUuxXs074tP8QwSmwwMmEKxGr52UOZBDrplQX+SLRkvv3UIn8z1JfTd61OeaJZ06
	 NH0akJ2muipLqTFqCyGjOY7WMv6dZIGKPdh2ztuDVF4cJ9p7T4E+++T+YMM9ppUya1
	 trWIsK3eazFXA==
Date: Fri, 21 Aug 2026 12:07:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ferran Duarri <ferran.duarri@me.com>
Cc: Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: ubsan: skip UBSAN for external modules by default
Message-ID: <20260821190701.GA3030879@ax162>
References: <20260820190200.203185-1-ferran.duarri@me.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820190200.203185-1-ferran.duarri@me.com>

+ Kees and linux-hardening@ for visibility

On Thu, Aug 20, 2026 at 09:01:58PM +0200, Ferran Duarri wrote:
> External modules built with KBUILD_EXTMOD set inherit UBSAN sanitizer
> flags from the kernel's KBUILD_CFLAGS because is-kernel-object is 'y'
> for any obj-m object. This silently breaks third-party modules whose
> source code (e.g. VMware vmnet/vmmon) triggers UBSAN UB checks at
> runtime, causing packet-forwarding failures and VM instability while
> the module itself loads successfully.
> 
> Make UBSAN opt-in for external modules: skip the is-kernel-object 'y'
> fallback when KBUILD_EXTMOD is set. External modules that explicitly
> need UBSAN can still opt in by setting UBSAN_SANITIZE := y.
> 
> In-kernel module builds are not affected.
> Signed-off-by: Ferran Duarri <ferran.duarri@me.com>

I am open to other opinions but I am not inclined to apply this change.
If an external module has issues with these checks, it should either be
fixed or 'UBSAN_SANITIZE := n' can be added to the module's Makefile,
rather than making the default worse for everyone else, especially given
the importance of UBSAN_BOUNDS for avoiding out of bounds accesses and
writes.

-- 
Cheers,
Nathan
