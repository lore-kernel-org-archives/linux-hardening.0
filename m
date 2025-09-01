Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A719F12A;
	Mon,  1 Sep 2025 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756691720; cv=none; b=hlmZnLcmps92pdHExKqyIj9iPuLSW9a8J9GnU99UdGe4qRAnD6yohh9ydla2S/0Qdby60w6L1n7f4HX9T6MhCcA0ZzYRVyZAk1jEFtkENeGpZvHZq4JxaPdE8aoj17Qfte375LET46oygfGVLSOfzR0+8Q3hI84nCrkimrobbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756691720; c=relaxed/simple;
	bh=y9uUD5rhZqWaFwFllOW9Bnz7ZPvxhH94nppg8HPo8WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mizTcn5Cp1q/9Js4qPpdkn1HQfLK3CihGoNL0wJvwCL8IymI2OrIzLeE/GG42Rqfzbeal4LcrC6vI623NUb7X8SoyIt/pOGQmJa11FfqPhLLCMImDjsoSBkM4rYOIkyf89bfmH6U4s++tcErXYosQwFTGJGbB5xm/hpd/DEqCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuzNmjA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuzNmjA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA76C4CEED;
	Mon,  1 Sep 2025 01:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756691718;
	bh=y9uUD5rhZqWaFwFllOW9Bnz7ZPvxhH94nppg8HPo8WM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JuzNmjA/vCoP7TafQO8Xv9Ns+jfihrA0K3Wh9SzcJbJdwMp77YZE+2O+80JPZ4fHr
	 um7vfZfN1rXqBklwR8YjKwjvJ0I/UIereHZNhyMrRe/1irSBdEjO1ASVe+tgIHYsnJ
	 tiz7Gk7tJP2CsAvBVjxHZNZOWo66lhjX3Mr1OMPAOxX08sVybRgj+OK6ytw66vL1BB
	 8Sh1+Y5KfKQmrgTwe0pQZCJ1Adq75AUaYSrKxEUBUMH7IpfxAEdfPgwpTOHaAPbGkx
	 yCCg70sCBFhfSO1HdxqD3Eh5nU8OozG0yxdo5cjmxkZqm33jIDsgEhKFxEy4HfjR6s
	 2tzcg/78Vnrnw==
Message-ID: <bfad9056-7ae7-4bd8-8600-a603ab8439ca@kernel.org>
Date: Sun, 31 Aug 2025 18:55:16 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arc: Fix __fls() const-foldability via
 __builtin_clzl()
To: Kees Cook <kees@kernel.org>, Yury Norov <yury.norov@gmail.com>
Cc: kernel test robot <lkp@intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vineet Gupta
 <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20250831022352.it.055-kees@kernel.org>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <20250831022352.it.055-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/25 19:23, Kees Cook wrote:
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
>
> For arc architecture with CONFIG_ISA_ARCV2=y, the __fls() function
> uses __builtin_arc_fls() which lacks GCC's const attribute, preventing
> compile-time constant folding, and KUnit testing of ffs/fls fails on
> arc[3]. A patch[2] to GCC to solve this has been sent.
>
> Add a fix for this by handling compile-time constants with the standard
> __builtin_clzl() builtin (which has const attribute) while preserving
> the optimized arc-specific builtin for runtime cases. This has the added
> benefit of skipping runtime calculation of compile-time constant values.
> Even with the GCC bug fixed (which is about "attribute const") this is a
> good change to avoid needless runtime costs, and should be done
> regardless of the state of GCC's bug.
>
> Build tested ARCH=arc allyesconfig with GCC arc-linux 15.2.0.
>
> Link: https://github.com/KSPP/linux/issues/364 [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693273.html
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508031025.doWxtzzc-lkp@intel.com/ [3]
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Vineet Gupta <vgupta@kernel.org>

Phew ! Thanks for taking time to track this down and also submitting the gcc
fix, like a true open source Good Samaritan.
Please let me know if you want me to take it via ARC tree, just be advised it
will be delayed due to slow'ish development.

Cheers,
-Vineet


> ---
>  v2: clarify commit log (we want this patch regardless of GCC being fixed)
>  v1: https://lore.kernel.org/lkml/20250826034354.work.684-kees@kernel.org/
> ---
>  arch/arc/include/asm/bitops.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
> index 5340c2871392..df894235fdbc 100644
> --- a/arch/arc/include/asm/bitops.h
> +++ b/arch/arc/include/asm/bitops.h
> @@ -133,6 +133,8 @@ static inline __attribute__ ((const)) int fls(unsigned int x)
>   */
>  static inline __attribute__ ((const)) unsigned long __fls(unsigned long x)
>  {
> +	if (__builtin_constant_p(x))
> +		return x ? BITS_PER_LONG - 1 - __builtin_clzl(x) : 0;
>  	/* FLS insn has exactly same semantics as the API */
>  	return	__builtin_arc_fls(x);
>  }

