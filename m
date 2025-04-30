Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC21BD9F0;
	Wed, 30 Apr 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746054791; cv=none; b=ISYyOzAXY12Hc7DNtaUugjCVDv33QoK1efVC5bxZcE68Wyxjx4CGMKkgSHtaR/IgkSJxD0CeAao/GfhJIbhWq6ZlmrkGa4W68qaT4fN6dm29vqA65PWxq4Xrkxc5uVYZWxXH8BxLhTwAiqxQW1+CnkiMw5O+V4gwyS8uzvOBczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746054791; c=relaxed/simple;
	bh=6xTUkRpTKfzrPwISqOi/AA76CXWhSy1rPF2+jMsRpPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNtYLz9J92JC3u3jSsO6c4HB4zfndI5BcsjLvCsMeJ6dVUAkP4gDZcLID0QEX1n9jbS1+AIxt3Lscb7fWTWRFgEQTRfdq/nKMGTOm9Rh5Mdqmtv9taueBEVGbU0r46IOXPE6i7Hy5EqmhBc9zWmYMV+7OahQ42fxpsadKW7lWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7weV58x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7weV58x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC4FC4CEE7;
	Wed, 30 Apr 2025 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746054791;
	bh=6xTUkRpTKfzrPwISqOi/AA76CXWhSy1rPF2+jMsRpPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7weV58xBGO8RfEmcQBFhYpSWBCIx/mNXDR/8+Im/1xK0fQnPsdy5OuBESJim2/9o
	 YLsV0MGpJuPKgUy49EgNnXghzHvySjymS3joaYx1EzJAkkBwOMZ5+xDuRobNOe5KU2
	 OeP9Qjnc/ENatkz1sVTHVLIYvKhez2WMJjJuXk5rEsWECeKYyQXV6rT9Czn9k1IyjC
	 +4qz7rJLOyKAsIB+LCuIsVI4c2FMOT8zfgFajkUY7tUPjjk2uEU60pDAdeHpMnlN6n
	 YqJnS+oUmX8WhgKM8iqH5lb1q/3IQ1j7BhKW0gUeYN1/oNyp4UKsd6QBLzPxVH7cxO
	 B5rk2mMCZAdaQ==
Date: Wed, 30 Apr 2025 16:13:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Bill Wendling <morbo@google.com>, thorsten.blum@toblux.com,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hardening: simplify CONFIG_CC_HAS_COUNTED_BY
Message-ID: <20250430231306.GA3715926@ax162>
References: <20250430184231.671365-1-kernel@jfarr.cc>
 <20250430184231.671365-2-kernel@jfarr.cc>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430184231.671365-2-kernel@jfarr.cc>

On Wed, Apr 30, 2025 at 08:42:31PM +0200, Jan Hendrik Farr wrote:
> Simplifies CONFIG_CC_HAS_COUNTED_BY by removing the build test and
> relying solely on gcc/clang version numbering (GCC_VERSION >= 150100 and
> CLANG_VERSION >= 190103).
> 
> The build test was used to allow unreleased gcc 15.0 builds to use the
> __counted_by attribute. Now that gcc 15.1.0 has been released, this is
> not needed anymore. Note: This will disable __counted_by on unreleased
> gcc 15.0 builds.
> 
> clang version support for __counted_by remains unchanged.
> 
> Link: https://lore.kernel.org/all/Zw8iawAF5W2uzGuh@archlinux/T/#m204c09f63c076586a02d194b87dffc7e81b8de7b
> Link: https://lore.kernel.org/r/20241029140036.577804-2-kernel@jfarr.cc
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  init/Kconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 63f5974b9fa6..017fde21d0ba 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -121,13 +121,14 @@ config CC_HAS_NO_PROFILE_FN_ATTR
>  	def_bool $(success,echo '__attribute__((no_profile_instrument_function)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
>  
>  config CC_HAS_COUNTED_BY
> -	# TODO: when gcc 15 is released remove the build test and add
> -	# a gcc version check
> -	def_bool $(success,echo 'struct flex { int count; int array[] __attribute__((__counted_by__(count))); };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
> +	bool
>  	# clang needs to be at least 19.1.3 to avoid __bdos miscalculations
>  	# https://github.com/llvm/llvm-project/pull/110497
>  	# https://github.com/llvm/llvm-project/pull/112636
> -	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
> +	default y if CC_IS_CLANG && CLANG_VERSION >= 190103
> +	# supported since gcc 15.1.0
> +	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> +	default y if CC_IS_GCC && GCC_VERSION >= 150100
>  
>  config CC_HAS_MULTIDIMENSIONAL_NONSTRING
>  	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
> -- 
> 2.49.0
> 
