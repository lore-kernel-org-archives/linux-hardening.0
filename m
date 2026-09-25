Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133413E00B4;
	Fri, 25 Sep 2026 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363177; cv=none; b=GJIyijyEoRYlrNdM8/E+s+M2eIo51NgbaK4HxGRZeJgzzBVfoSMn4530aht3GkCbjSI0ZT/8XPaHr7/noBw5WjR3Pq38nE/qVq6OsX6O6IIDD0wVG/yHP43qyQb/8OvFHpXuOpVPeL/BucnZAPoX9Zpq9fVyC8ufJWNK7c1kHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363177; c=relaxed/simple;
	bh=4lQL8gvWv/CFv31QtGZeKfHoIiCncwG4xwXyGmUI0rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plUhzbGEuSpUZ4cXfW648C3OFRwEfmjVxF7A00EU2TnaDdoIL14VpCgZPHYmsXXYwZzos82phGOfKaGBp3AmfLZzWY4KzVtPSDvm8mbKzDx9b2t6a8YPL4/LBqBgCCNG07t9N+NNOA4lKkfqXAN1QO0YwOC7Txy8mtIbINlplbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsFiR1YG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsFiR1YG"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2BC441F000FF;
	Fri, 25 Sep 2026 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363175;
	bh=VrjegtRrcpHSSr45DJrYT3eYx+8WnvK+ZO8tTcjuv4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SsFiR1YGFJy5AdhnxNWv5YhA82om7Bft1hdAbO06IyE4VjaAOVVJlpSlU+2sugNMG
	 fIQqXfx8svme6i88RRuuqYbEV2/nF72+E9aih7GqJ2p9DbmdQI7iOUGnzpuBbxBzpD
	 DvqNRPKbaLpyulbLRn/m0Nz6AmIp2E2e0ItJKPr5D2g/vBl1RiVGNFPlIrjxmfg3yS
	 ck+TGuZgjiemPHHYiCTX5cZsYi9FnjNyfLPQ6SAT4f/wSyEazJ3mCv00ac30x66/Uu
	 HLF/nYcrxpRSDz/cDo93W4i3DibTEuZIyRUl2wnbsdnQqkP+XjU2UD1u5SNCWIuzKQ
	 pHEPBSZqXJ7YA==
Date: Fri, 25 Sep 2026 20:58:47 +0200
From: Nicolas Schier <nsc@kernel.org>
To: iav@iav.lv
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] fortify: Disable colored diagnostics in test_fortify.sh
Message-ID: <arbEZ5YW_sF4yMjp@levanger>
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
> 
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

Tested-by: Nicolas Schier <nsc@kernel.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>

-- 
Nicolas
