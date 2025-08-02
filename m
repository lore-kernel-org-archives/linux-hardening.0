Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF912E5B;
	Sat,  2 Aug 2025 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754095401; cv=none; b=MvtM/seJRywG2rsQ7GomppZ16Z7euLvdd/ZZQduMoFwsMKhPui6udav72dstra3TUMUmiueqPjuK5AB3voMgPT3d49IOXjPXnH+eg+PQpxhnyp4LlOwzwgJgblK8APcw8eWVaoENk/LfpXkp8yNWYpgBATys9ZU5ZlqoJtLTRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754095401; c=relaxed/simple;
	bh=ZATFfLLKt+2VPYdNFgm2YjLw4ctpwjtE2yaOzH6dp3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbuMntxY7KoEgnRWBaxymH5LN4OU4kKgqGnjEqM2HNtazBJ6nSKuyRM738ULEx36mwFR9SwneoOqraMSsK4rgejLiRlh0bS0aRi4BP4x0TJYEjXMvtTkj9HdkGd4RTswOtHE97Y0h90j7TF/5YEi26W36fz/CG8gC2QZpngRbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz2SFX0O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz2SFX0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D85EC4CEF8;
	Sat,  2 Aug 2025 00:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754095401;
	bh=ZATFfLLKt+2VPYdNFgm2YjLw4ctpwjtE2yaOzH6dp3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dz2SFX0OfKrNKQJMXT30s9CG/H5LEJltZ4OAaWx+C1AulKHrVgw/FXjnPSaOZUOcJ
	 EICwmwDGBhlU+DUA0GSRio2HamwLahMj6tsxUJ1bW31f4zdbVCYz8yE7VSQ57+gOqp
	 5x1cNpfN9fdcdL7KCtedNZKD46orEhhqaDq2ezUAaJlvyHwXBrRs91SQIdWDl41uOQ
	 lWRppQdEDNlxe9xPx+0LOPv0na2YmBInOo/JlNG/N7hghTq/0z2VD7CuOd3XqCdes1
	 NNohz/ZFTc3xzIwnB2/Xf15bT5Td3XTU/aiWLigyT0lpmDxnm0m7UhiVESlV9zQ2vU
	 0RJVSJ7YPoO7w==
Date: Fri, 1 Aug 2025 17:43:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	linux-kbuild@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: Re-enable -Wunterminated-string-initialization
Message-ID: <20250802004316.GA3910513@ax162>
References: <20250802002733.work.941-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802002733.work.941-kees@kernel.org>

On Fri, Aug 01, 2025 at 05:27:40PM -0700, Kees Cook wrote:
> With the few remaining fixes now landed, we can re-enable the option
> -Wunterminated-string-initialization for GCC. (Clang does not yet fully
> understand the "nonstring" attribute.)
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

What else does Clang need? Are bugs filed? I had requested support for
multidimensional arrays, which Aaron implemented pretty quickly (and the
tests seem pretty expansive):

https://github.com/llvm/llvm-project/commit/e8ae77947154e10dbc05cbb95ec9e10d3b0be13e

> ---
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas.schier@linux.dev>
> Cc: <linux-kbuild@vger.kernel.org>
> ---
>  scripts/Makefile.extrawarn | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index dca175fffcab..7ab8549485a4 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -78,8 +78,10 @@ KBUILD_CFLAGS += $(call cc-option, -Wcast-function-type)
>  KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) += $(call cc-option, -Wno-stringop-overflow)
>  KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) += $(call cc-option, -Wstringop-overflow)
>  
> +ifdef CONFIG_CC_IS_CLANG
>  # Currently, disable -Wunterminated-string-initialization as broken
>  KBUILD_CFLAGS += $(call cc-option, -Wno-unterminated-string-initialization)
> +endif
>  
>  # The allocators already balk at large sizes, so silence the compiler
>  # warnings for bounds checks involving those possible values. While
> -- 
> 2.34.1
> 
