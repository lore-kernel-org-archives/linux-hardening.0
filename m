Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0378635D;
	Wed,  5 Mar 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187577; cv=none; b=g99hbq/n6SUEvIOD0K0G1w4ZpTgvxwnBE7XnBiYhOcJqj4tkJyKRSQ7EimPYVbJgAtWTu85fHUmlplG6QiVp3TGmbG0358gbnPJuilEof891iWj968nQAEbNH9wvsZyeA/C12DhvFvSv3va9BF6Gnau33a/rbi3th0ANwn9WcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187577; c=relaxed/simple;
	bh=4zHaL04CB0Fya4HCFRotOuAVke6Rb0AyD3EyARxmoZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MURhALZuqJgHXPLn58NIj2hWCLV8Fa+LsqLSHLa8mSlLPUZQB/uu8J7cLU8ji18bvJg6GQ1Nj3w0YTjRhJxxWsu4WuxiMe+wQN0gCIQTcLD0M4sFKdnKF6r2E/QusQ+Q/sdyeHjzKMQIivul+a6xGXtN6dGfSfvFXkZfRVj+uHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/fiRUVw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/fiRUVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858D5C4CED1;
	Wed,  5 Mar 2025 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741187576;
	bh=4zHaL04CB0Fya4HCFRotOuAVke6Rb0AyD3EyARxmoZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/fiRUVwGRsFHKTa7NN3r6GwkLo1RlvTiHhJlIKJdwnkqsjdGIUwSwR8Mr8k6Xkxy
	 wbl+IxpLDDKH24bvfRPfh2YO6TddwmUJHjWy1d++9vByaZtWgHZRG2yae7kj2zq4RV
	 gY6NqLyXTZpyPrZUqon0DgXHM5/VxY6433iWU23qNBbttiMozpGlmGhBEcNQeVi4Y9
	 TijtoFVKRBs3KRq+ALxYAdtm2uinBvBvcDvL1ez96H7wtXPETjPSS+CwVLLqVG3oyH
	 uFjd5MdSiXGxMEW0x1Z2AnPr5cYlwadRZJ0dtBK9ujqfDfdhHB9h8NajCHQ0/rzwtI
	 woXWbl7OHqSDA==
Date: Wed, 5 Mar 2025 16:12:51 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev, Geert Uytterhoeven <geert+renesas@glider.be>,
	David Gow <davidgow@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kunit/stackinit: Use fill byte different from Clang i386
 pattern
Message-ID: <20250305151251.GA1538566@ax162>
References: <20250304225606.work.030-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304225606.work.030-kees@kernel.org>

On Tue, Mar 04, 2025 at 02:56:11PM -0800, Kees Cook wrote:
> The byte initialization values used with -ftrivial-auto-var-init=pattern
> (CONFIG_INIT_STACK_ALL_PATTERN=y) depends on the compiler, architecture,
> and byte position relative to struct member types. On i386 with Clang,
> this includes the 0xFF value, which means it looks like nothing changes
> between the leaf byte filling pass and the expected "stack wiping"
> pass of the stackinit test.
> 
> Use the byte fill value of 0x99 instead, fixing the test for i386 Clang
> builds.
> 
> Reported-by: ernsteiswuerfel
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2071
> Fixes: 8c30d32b1a32 ("lib/test_stackinit: Handle Clang auto-initialization pattern")
> Signed-off-by: Kees Cook <kees@kernel.org>

stackinit passes with arm, arm64, i386, and x86_64 when using
LLVM 20.1.0-rc3. Hopefully they do not change the init pattern :)

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: llvm@lists.linux.dev
> ---
>  lib/tests/stackinit_kunit.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/tests/stackinit_kunit.c b/lib/tests/stackinit_kunit.c
> index 135322592faf..63aa78e6f5c1 100644
> --- a/lib/tests/stackinit_kunit.c
> +++ b/lib/tests/stackinit_kunit.c
> @@ -184,6 +184,15 @@ static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
>  #define INIT_UNION_assigned_copy(var_type)		\
>  	INIT_STRUCT_assigned_copy(var_type)
>  
> +/*
> + * The "did we actually fill the stack?" check value needs
> + * to be neither 0 nor any of the "pattern" bytes. The
> + * pattern bytes are compiler, architecture, and type based,
> + * so we have to pick a value that never appears for those
> + * combinations. Use 0x99 which is not 0xFF, 0xFE, nor 0xAA.
> + */
> +#define FILL_BYTE	0x99
> +
>  /*
>   * @name: unique string name for the test
>   * @var_type: type to be tested for zeroing initialization
> @@ -206,12 +215,12 @@ static noinline void test_ ## name (struct kunit *test)		\
>  	ZERO_CLONE_ ## which(zero);				\
>  	/* Clear entire check buffer for 0xFF overlap test. */	\
>  	memset(check_buf, 0x00, sizeof(check_buf));		\
> -	/* Fill stack with 0xFF. */				\
> +	/* Fill stack with FILL_BYTE. */			\
>  	ignored = leaf_ ##name((unsigned long)&ignored, 1,	\
>  				FETCH_ARG_ ## which(zero));	\
> -	/* Verify all bytes overwritten with 0xFF. */		\
> +	/* Verify all bytes overwritten with FILL_BYTE. */	\
>  	for (sum = 0, i = 0; i < target_size; i++)		\
> -		sum += (check_buf[i] != 0xFF);			\
> +		sum += (check_buf[i] != FILL_BYTE);		\
>  	/* Clear entire check buffer for later bit tests. */	\
>  	memset(check_buf, 0x00, sizeof(check_buf));		\
>  	/* Extract stack-defined variable contents. */		\
> @@ -222,7 +231,8 @@ static noinline void test_ ## name (struct kunit *test)		\
>  	 * possible between the two leaf function calls.	\
>  	 */							\
>  	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
> -			    "leaf fill was not 0xFF!?\n");	\
> +			    "leaf fill was not 0x%02X!?\n",	\
> +			    FILL_BYTE);				\
>  								\
>  	/* Validate that compiler lined up fill and target. */	\
>  	KUNIT_ASSERT_TRUE_MSG(test,				\
> @@ -234,9 +244,9 @@ static noinline void test_ ## name (struct kunit *test)		\
>  		(int)((ssize_t)(uintptr_t)fill_start -		\
>  		      (ssize_t)(uintptr_t)target_start));	\
>  								\
> -	/* Look for any bytes still 0xFF in check region. */	\
> +	/* Validate check region has no FILL_BYTE bytes. */	\
>  	for (sum = 0, i = 0; i < target_size; i++)		\
> -		sum += (check_buf[i] == 0xFF);			\
> +		sum += (check_buf[i] == FILL_BYTE);		\
>  								\
>  	if (sum != 0 && xfail)					\
>  		kunit_skip(test,				\
> @@ -271,12 +281,12 @@ static noinline int leaf_ ## name(unsigned long sp, bool fill,	\
>  	 * stack frame of SOME kind...				\
>  	 */							\
>  	memset(buf, (char)(sp & 0xff), sizeof(buf));		\
> -	/* Fill variable with 0xFF. */				\
> +	/* Fill variable with FILL_BYTE. */			\
>  	if (fill) {						\
>  		fill_start = &var;				\
>  		fill_size = sizeof(var);			\
>  		memset(fill_start,				\
> -		       (char)((sp & 0xff) | forced_mask),	\
> +		       FILL_BYTE & forced_mask,			\
>  		       fill_size);				\
>  	}							\
>  								\
> @@ -469,7 +479,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
>  			fill_start = &var;
>  			fill_size = sizeof(var);
>  
> -			memset(fill_start, forced_mask | 0x55, fill_size);
> +			memset(fill_start, (forced_mask | 0x55) & FILL_BYTE, fill_size);
>  		}
>  		memcpy(check_buf, target_start, target_size);
>  		break;
> @@ -480,7 +490,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
>  			fill_start = &var;
>  			fill_size = sizeof(var);
>  
> -			memset(fill_start, forced_mask | 0xaa, fill_size);
> +			memset(fill_start, (forced_mask | 0xaa) & FILL_BYTE, fill_size);
>  		}
>  		memcpy(check_buf, target_start, target_size);
>  		break;
> -- 
> 2.34.1
> 
