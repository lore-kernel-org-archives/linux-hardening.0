Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9652F30
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014375; cv=none; b=ffwd3ozGp8sNasfbsU70RINg//HZrGgZ4Jj1z8nBC5fm7IRKedWaAvUy6GShk18xT49QHV7nD+0UzrXizF7V0pGoCIRpIwYsAqZBWagSwi6ZzFJXxLS3RLGatmN3hOVjWj9D1jnYEcZGIBcAZG6OUiA6Lz4Bg41i8AegrRVTd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014375; c=relaxed/simple;
	bh=fdRZz3fSGogavw9XdqwzRbJxXyg4vhX9XzftvBciH7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=envDzLYrGsWFVlf53RRCkySdipGakB+Hev8V9XBXyBzfEsmiKfZzkTn1ldI3Te7FSJe/LF53UCfm+lcofsNBB8QR1jbMqs+F8T20tst9EVoe1EkrdDUrFcjWqaFWsyYLXOY3Ctuw+4/SHEt5VoecMKkKABQmkrJJG2iAPSOPRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWR1HBbw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWR1HBbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE8C4CEC3;
	Wed, 11 Sep 2024 00:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726014374;
	bh=fdRZz3fSGogavw9XdqwzRbJxXyg4vhX9XzftvBciH7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWR1HBbw7xkRU8MbS1GvekBf+ZtR3CkUBY6d3UDFpbbNt7K7WpSOQUNhYJMPPRe0w
	 z3yffn4k/4KTLduGVVnBtgPPqoXbpZtnyl69n1a7OMXs4A80EC2BAMYzpy2hdWTR0+
	 i29LbjXK29ZAadKOVXSY9z5fO9EuVZVTgxqDdLgQw5gfn18OAb80O05v3U3gw9/ifZ
	 4EuiDzByTwl3zxYZyZFDQudS8pcoZUqkFcGV0zE76RGUGdnFmCo9NRJxYcKCG34YaZ
	 XRa0zGzBzzpNM0juGM9muFFj7g8dIOc2xb/Ag/X4ST/j7P+Jn6R3mWPt49av8H+ikO
	 5GyDdzlLlLydg==
Date: Tue, 10 Sep 2024 17:26:14 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: -Wformat-trunctation with `make W=1`
Message-ID: <202409101722.C8E47DF@keescook>
References: <Zt73a3t8Y8uH5MHG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt73a3t8Y8uH5MHG@smile.fi.intel.com>

On Mon, Sep 09, 2024 at 04:26:03PM +0300, Andy Shevchenko wrote:
> Recently I'm trying to compile my (almost) x86_64_defconfig based kernel with
> `make W=1` while having CONFIG_WERROR=y. With a handful of patches I was able
> to achieve that with clang-18, however GCC 14.2.0 issues a lot of additional
> warnings that are mostly related to -Wformat-truncation [1]. Any suggestions,
> plans, comments on how to address them?
> 
> [1]: https://paste.debian.net/hidden/46106f2a/

Since it's behind W=1, fixing those issues hasn't been a very high
priority. That said, I would love to see it done. Patches have slowly
been landing for various W=1 things related to the -Wstringop-... and
-Wformat... options, though. But I don't think there has been a
concerted effort to wipe them out completely. And at least sometimes
these warnings are effectively false positives, related to unexpected
behaviors in GCC's value range tracking, though that has mostly been an
issue for getting -Warray-bounds to build cleanly.

As for fixing them, I think one will need to just look at each instance
one at a time to figure out the best solution.

-Kees

-- 
Kees Cook
