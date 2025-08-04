Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED9EEAB;
	Mon,  4 Aug 2025 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330025; cv=none; b=oWeDceUR2Ic9nummd1Va5tbfZeYysNXzGbwWhzWUJmd+SVbPosXrD+wNKZdDIAgz/lSKziMVJW6XMctR94eLyxAj3Ofm/2hk048Ae1zEEgsAlkvD/IKuBsQWVQSiTJzERDeZbJ2C1ERoxRtsDoHAIuv09yDRsJdXrt39y11VDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330025; c=relaxed/simple;
	bh=yjujFdtJVfhRPrbL8qX039W0JOqy6MHmd3vLs93bEWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg30DwZGXU3fiyuzthSx/JbElSbr8h9LvGD4YF9IcyurR0HGgI1GZesr0iKrJpmOSbNAhHztiPF9uC6wwdCyf5SjHssijhyWWqYcAIY6NeZ/gkX7+JZDUvd5nP2nunQOm2vEcS3PZSuHT8Vd9H/QGOO3zh2H6OrTL0Tlggyt3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQZHTNIq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQZHTNIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF190C4CEE7;
	Mon,  4 Aug 2025 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754330024;
	bh=yjujFdtJVfhRPrbL8qX039W0JOqy6MHmd3vLs93bEWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQZHTNIqQrFZPM6PL/wYMLbJZnx65b7K+HVzmB9D5VlY9svB5TYoSKr+6GQyo/H0q
	 sCTGGsNmKncsOqQQc3vBIV6gx4aMC5WDSNESHkJf9qrUt+vNqcVijG3yEyxhhG84/K
	 LwgX8KMBojWV8SzvGVmYq7dv6nK7OLxYYXID2424IkU5TvEpttC5MaIwJO/JoIDU/p
	 v6zg6JVPFgo5lcPlOm7+V2Hx8u7GEKhiOuWlw2rlJZDWlrsfnoUKVDFMsT0wNXxbEb
	 +EZsPJqhVgVGedJxsIBU8PQBl6EXQC3kTa6vWqfHe6TKK6c4HZqB06lG2EXNsaZDjz
	 V5D1ynOEa8dLA==
Date: Mon, 4 Aug 2025 10:53:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250804: clang-nightly hardening.config boot failed on
 arm64 rock-pi-4b
Message-ID: <20250804175338.GA2197404@ax162>
References: <CA+G9fYuDtzPpJOX7wdWAf2QmHyc-5v0cZ2Wood8cRwCttuyRmA@mail.gmail.com>
 <202508040843.CCEFEF9ED@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508040843.CCEFEF9ED@keescook>

On Mon, Aug 04, 2025 at 08:44:16AM -0700, Kees Cook wrote:
> On Mon, Aug 04, 2025 at 03:41:51PM +0530, Naresh Kamboju wrote:
> > Regressions found while booting the Linux next-20250804 on the
> > qemu-arm64, dragonboard-410c, rock-pi-4b due to following kernel log.
> > 
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? yes
> > 
> > First seen on the next-20250804
> > Good: next-20250801
> > Bad: next-20250804
> 
> Are you able to bisect this by any chance?

I think this is the runtime manifestation of
https://github.com/ClangBuiltLinux/linux/issues/2116 when built with a
version of LLVM without assertions (when assertions are enabled, the
build just fails). I can reproduce this with a version of LLVM that
contains the broken change and it is resolved with a version of LLVM
that contains Fangrui's fixes. I assume this should hit LKFT in the next
couple of days via apt.llvm.org.

Cheers,
Nathan
