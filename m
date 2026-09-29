Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EED25392A;
	Tue, 29 Sep 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687643; cv=none; b=DTBumQf0R0efYerhDjJeupUKTMAUxvtHeLRTXEae6jna9NJCWuRS8tWfwDSoprqFicuJ2xkdJNNCh7OKSxQZdnJS2RAint2Cq9I5AuDngl5Gcg+ZLSad/4N9xTvg8x6zNRT9Wz6AYDRoPHTrwCl0UV7WRu1ZafvLH+yl5esyh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687643; c=relaxed/simple;
	bh=+zwQ1fNOYdUA0AudHfbZPfRHU2Iud9SG1OTHg1x7iSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSWGdLas4pfngUfL6kTYNBZlEVKDCcj/nEiAqahHwsMl42u9CFBkYj+y9j0qn0fxeOsWpINjK8f1bzGp0qbLdiYcJHYKFuzEcDwrn6ZbCKXuRCx4Ml/HLX4XR39VBOXRNcB0nlX2LTW9586Rj3w8QsNlhcHj0W83rMFf/2tasHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/bY9CYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/bY9CYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AAD1F000FF;
	Tue, 29 Sep 2026 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687642;
	bh=f64aLfTdVxWrjtrUwkspl8bIs4OXL/VTzUbYA6bmSkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S/bY9CYl2cWtkcuP3tAjsAizgYmWsOXEKm4h1179aTu0xsjeFDZLNqO88ddeUg+1w
	 c2uwQC/dN55iiuQoJ20B5jzFwvXoTvb8QZa+fyDCe1EZJ7ZiDWGIhM1XU7CZVknMz7
	 mOL/6pzE40vhtSkEs7d9ysgKaXpnJ3FgWCQOGmx/i3FF3UPzigMcDsao5273vzl9ab
	 NzBNboVv9Bp7cFbCm7RYTOsnd/6GPd/P7WVuZQHoGPJO0lj8QmNce6gdPoQUmLRXAj
	 3albEWcLG8FqnMAmEVyAgj01kx/hmHzLMZfVoWIw+BE7WylSIWef7EGqsT4OEOSSvt
	 prLcD7oZvmcJQ==
Date: Tue, 29 Sep 2026 14:13:56 +0100
From: Will Deacon <will@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] refcount: Use CONFIG_BUG_ON_DATA_CORRUPTION for
 UAF-related errors
Message-ID: <aru5lCCF50puV8GM@willie-the-truck>
References: <20260812-refcount-bug-on-data-corruption-v1-1-c6da63566101@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-refcount-bug-on-data-corruption-v1-1-c6da63566101@google.com>

On Wed, Aug 12, 2026 at 08:56:38PM +0200, Jann Horn wrote:
> Some refcount issues are not necessarily associated with memory corruption,
> but REFCOUNT_ADD_UAF suggests that a UAF either just happened or is about
> to happen.
> 
> REFCOUNT_SUB_UAF is also an indicator that reference counting is wrong, and
> suggests (less strongly) that a UAF access might have happened recently.
> 
> In these cases, BUG() is appropriate if CONFIG_BUG_ON_DATA_CORRUPTION is
> set.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> MAINTAINERS specifies no specific maintainer for lib/refcount.c, but it
> does have an entry for include/linux/refcount.h, so I guess I should
> route this patch based on that.
> 
> I decided to send this patch after wondering how exploitable it would be
> to have a refcount_inc() call on an object which has reached refcount 0,
> but is not yet freed because of something like an RCU grace period.
> ---
>  lib/refcount.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/refcount.c b/lib/refcount.c
> index a207a8f22b3c..c0f0dc5296eb 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -10,6 +10,15 @@
>  
>  #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
>  
> +#ifdef CONFIG_BUG_ON_DATA_CORRUPTION
> +#define REFCOUNT_CORRUPTION(str) ({		\
> +	pr_err("refcount_t: " str ".\n");	\
> +	BUG();					\
> +})
> +#else
> +#define REFCOUNT_CORRUPTION(str) REFCOUNT_WARN(str)
> +#endif

Can you use CHECK_DATA_CORRUPTION() here instead of open-coding the BUG()?

Either way:

Acked-by: Will Deacon <will@kernel.org>

Will
