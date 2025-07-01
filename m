Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FB2741AF;
	Tue,  1 Jul 2025 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373326; cv=none; b=mEbMNnsF8P12yqNFtZnQgzACDGr70OcVFKmr1WFPbJ4ctFTDfqGT/FHy3iXsfZ6Ac+ma75JdT8hUSnd25mb2BzZV4J+BulRTcUFBxTGWO7t3eb/rqUq1H2THnvo0lPjLgi3563vOtxsBUj/CgVQhTVAH8hxN88zq5Y1vXKOi2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373326; c=relaxed/simple;
	bh=/BnoAq4OFr24v2k5HSgqEKfU5lDzbp8O/O33lrToOFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqCXaLd02WVMTQkyn5KqGWDNyjv/6KkqfCMG0819atkHAcpjKsDjj84qUed+LwKN4ymJ3gYA9uy/M1H45SqGqdMJYEsMMehQ1rFyPPr9bdpN+iIbKQjDzEuiCxGXeUqaT5o3tc2K6rU7eVhgR8lj/3eSRXeK9Rg8lHOsusKrtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD3COvfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD3COvfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D14C4CEEB;
	Tue,  1 Jul 2025 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751373325;
	bh=/BnoAq4OFr24v2k5HSgqEKfU5lDzbp8O/O33lrToOFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uD3COvfKOmIPcQ0R9OjskdC7B1kylfFemuU4kRRrI4oYPX9SI8Dkm/W0PZpzPotQ/
	 QQRoxE75s/TWkB7hCS1q6A7/0ICbhMU6eRFgJ8npaJvZ6p/ztemyJEFlnD1QfLEveW
	 1PVbEUv+AKu1KRcogOfi0F06Cjc/vX7+HHZ4uHg0sN0IHXg7Xwmv43mf3zKCIzAFc1
	 T5JMoKZJp3Mqmi5X1MRY4CFva+Ca8lLs6hvn2VgqvqGjvRWKYB5DAEAU/PoiecwD1D
	 MqevOdP+jtehjTOe6tzsUbskM66zV1CRrHLJQ4keQe2FNVnClx7oiA/zLvEPwBrK0D
	 Qq5pVsxjLXdeg==
Date: Tue, 1 Jul 2025 05:35:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Jannik =?iso-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] kunit/fortify: Add back "volatile" for sizeof() constants
Message-ID: <20250701123521.GA2835771@ax162>
References: <20250628234034.work.800-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250628234034.work.800-kees@kernel.org>

On Sat, Jun 28, 2025 at 04:40:38PM -0700, Kees Cook wrote:
> It seems the Clang can see through OPTIMIZER_HIDE_VAR when the constant
> is coming from sizeof. Adding "volatile" back to these variables solves
> this false positive without reintroducing the issues that originally led
> to switching to OPTIMIZER_HIDE_VAR in the first place[1].
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2075 [1]
> Cc: "Jannik Glückert" <jannik.glueckert@gmail.com>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: 6ee149f61bcc ("kunit/fortify: Replace "volatile" with OPTIMIZER_HIDE_VAR()")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  lib/tests/fortify_kunit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
> index 29ffc62a71e3..fc9c76f026d6 100644
> --- a/lib/tests/fortify_kunit.c
> +++ b/lib/tests/fortify_kunit.c
> @@ -1003,8 +1003,8 @@ static void fortify_test_memcmp(struct kunit *test)
>  {
>  	char one[] = "My mind is going ...";
>  	char two[] = "My mind is going ... I can feel it.";
> -	size_t one_len = sizeof(one) - 1;
> -	size_t two_len = sizeof(two) - 1;
> +	volatile size_t one_len = sizeof(one) - 1;
> +	volatile size_t two_len = sizeof(two) - 1;
>  
>  	OPTIMIZER_HIDE_VAR(one_len);
>  	OPTIMIZER_HIDE_VAR(two_len);
> -- 
> 2.34.1
> 
