Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC582D8767;
	Fri, 30 Jan 2026 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794552; cv=none; b=VvMYipQed0l/SHwyOKBWQZT0dunXwYejbYtWV4VgTWYTY4r4KK5dFuxpuJ3Cvt2EkmBfSu19wHiS5X5wXzZq/R4J7ZE5ZNoA2mIMfU+o4yVppn/Mlm9Q20abXkxxBC0V8P3uwllgi2KNR5d4El3vZB9KMhEL/w9/cTmO92WUxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794552; c=relaxed/simple;
	bh=PNcKOtJEhTtwsqaYMcux4hWhZmy9ojaJIltFMghSNDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0FSiArZhFXgqK9RitsLkO0xS2LNFl5CuvEBF7WpxaOJlDB4UpSt1hw59a1nIQomBDg0wUgSaHZbptuBPoDu2bQsrCD8svYfUnUAKZB0SSXaLnwVrbpmeGoaZE+QI2jdcMNCHOoFFhWM/2laJumuv0YYslGdsnn3dOdu47IVdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiOrk+4K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiOrk+4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB17C4CEF7;
	Fri, 30 Jan 2026 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769794552;
	bh=PNcKOtJEhTtwsqaYMcux4hWhZmy9ojaJIltFMghSNDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BiOrk+4KP4cywSelLRGhpurbFn96EhLXamqAMFYcoCppIXrS0vQniRFgfv1kh7HWp
	 D6R83gevct9t7SCKRg5D1qLFjbIcaV64aktRTSS+S9mNQfngXW5ToszCweShtvHDeq
	 +ztGwNRWMJXZ0WJrsWufigDVB8ivR/1WhKnyyGLKljv+2tpdY7uiJUHFjtD0nSEyL2
	 1oV/pu8hs0oF9IfOg7T1HoSsLt7FNjlvK2JH6OAh11hAhL4FGTBFbxXQ2w2hdyUZQO
	 gtrbLyrlhMCGUYad9xGvHowUho7qJJAAB91U3xujOW0Ii20P0mMr/1/rYgOxRpkgNM
	 kmLK/Au8/6+uA==
Date: Fri, 30 Jan 2026 09:35:52 -0800
From: Kees Cook <kees@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	akpm@linux-foundation.org, andy@kernel.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, herbert@gondor.apana.org.au,
	samuel.holland@sifive.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com, nathan@kernel.org,
	linusw@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 5/8] lib/string_kunit: extend benchmarks to strnlen()
 and chr searches
Message-ID: <202601300935.DF5E50015A@keescook>
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
 <20260130025018.172925-6-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130025018.172925-6-jiangfeng@kylinos.cn>

On Fri, Jan 30, 2026 at 10:50:15AM +0800, Feng Jiang wrote:
> Extend the string benchmarking suite to include strnlen(), strchr(),
> and strrchr().
> 
> For character search functions strchr() and strrchr(), the benchmark
> targets the NUL character. This ensures the entire string is scanned,
> providing a consistent measure of full-length processing efficiency
> comparable to strlen().
> 
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
