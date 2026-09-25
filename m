Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF93B27E8;
	Fri, 25 Sep 2026 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369569; cv=none; b=BxQhzsRy3o46gZFbfV9vke4SMNjq5TX1+kZS2lNLhl67m5QlFDmPRlIu0sOtwqm0a5/L6lblzqTvUUEJIPyDw8aW7n9FL3QnxrVobcE7FTl3VXNvfpU+FgpoLRh+2j7rTgB7N3o0WBCqrHhWLForD+MUJKk9lgGq3SurcNa7K5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369569; c=relaxed/simple;
	bh=GbBEwZ71Nx4qmi9x/geU1QBpZdcJAowaHP/xg13qj0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwzIKL+cUVgpdG7hfSiYDLyM/3fPyjEv02mLWEO1ztsfdcsCAlxmpZd8Ih8GFAFCZYgiCnyw7Iyo7GUFVgvv6ZKZMt0eEgn4hw6TY8DG31m2VwqYolAmBbwvzQ3W4DzCCOb3xYvmXL9jvP1UwHJvxtefSAES37gPQnkMhf6xqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFBkDi7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFBkDi7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCEC1F0089A;
	Fri, 25 Sep 2026 20:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790369568;
	bh=CINb21FHNDqAcZD7h5o04wTNGz/rij6VPupLcMh8jVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VFBkDi7sGpbcdRWpt/EaJMX1w+6+/F7mur3qgxL0rLxDqlZH6S1e7fcu50A/adP6z
	 bpHwwXFS85WSpmYyKrDXyOBQmQSv/Uvb9Rd7rTcDLTkchr6eja5nZwE8hj3ydp/HgQ
	 VhgAv2LKynAt6LB7ag0xsyZCSFPP2ePY4YsoL20qmxykaBI05XhJ5ob7jf1Y1TYuCF
	 K4dY34LnJmOvLR7ZwS86Wy3jMPJdUsbXiP/dpSVbQlLFRfMosNj28YfRaJeNJAoad9
	 gfvjtcFck6mBNhi3mqkAWeUycsbn1LhM7xIL8vHwqo4J+V5l/RK7CTDx5zHw1ZAJ+r
	 +9PekamUf9Uew==
Date: Fri, 25 Sep 2026 21:52:44 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: iav@iav.lv
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH] fortify: Disable colored diagnostics in test_fortify.sh
Message-ID: <20260925205244.GA1518255@ax162>
References: <20260924-fortify-test-color-v1-1-37f6d50e31ec@iav.lv>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-fortify-test-color-v1-1-37f6d50e31ec@iav.lv>

On Thu, Sep 24, 2026 at 11:34:29PM +0300, Igor Velkov via B4 Relay wrote:
> From: Igor Velkov <iav@iav.lv>
> 
> When the build forces colored diagnostics, e.g. with
> KCFLAGS=-fdiagnostics-color=always, the compiler wraps the expected
> error in ANSI escape sequences and the grep does not match it. Every
> test then reports "lacked '__write_overflow' warning" although FORTIFY
> caught the overflow, and a real FORTIFY regression looks the same.
> 
>   warning: unsafe strcpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-strcpy.c
> 
> Pass -fdiagnostics-color=never after the caller's flags so that the
> test compile always emits plain text.
> 
> Fixes: be58f7103700 ("fortify: Add compile-time FORTIFY_SOURCE tests")
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Found in Armbian kernel builds, which pass -fdiagnostics-color=always
> in KCFLAGS: all 18 tests reported "lacked".

Hmmm, interesting default...

That said, seems reasonable to me. Presumably it is more complicated to
handle this in the regex.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> Tested on arm64, 7.2.y, KCFLAGS=-fdiagnostics-color=always,
> building lib/test_fortify/ (tests ok out of 18):
> 
>                  before   after   after, -D__NO_FORTIFY
>   GCC 14.2          0       18        0
>   clang 19.1.7      0       18        0
> 
> An LLM assistant found the cause, wrote the fix and the changelog,
> and ran the tests; I reviewed all of it.
> ---
>  lib/test_fortify/test_fortify.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_fortify/test_fortify.sh b/lib/test_fortify/test_fortify.sh
> index ad6dd44fa31c..c07eb3302c9d 100644
> --- a/lib/test_fortify/test_fortify.sh
> +++ b/lib/test_fortify/test_fortify.sh
> @@ -37,7 +37,8 @@ export LANG=C
>  
>  status=
>  # Attempt to build a source that is expected to fail with a specific warning.
> -if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then
> +# Disable colors so that the grep below can match the warning.
> +if "$@" -Werror -fdiagnostics-color=never -c "$IN" -o "$OUT".o 2> "$TMP" ; then
>  	# If the build succeeds, either the test has failed or the
>  	# warning may only happen at link time (Clang). In that case,
>  	# make sure the expected symbol is unresolved in the symbol list.
> 
> ---
> base-commit: 760f96b7f54beb8dc6f85d97ac7854fddba86835
> change-id: 20260924-fortify-test-color-f34a31b56bcc
> 
> Best regards,
> -- 
> Igor Velkov <iav@iav.lv>
> 
> 

-- 
Cheers,
Nathan
