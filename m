Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0ECD2ED;
	Sat, 23 Sep 2023 08:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F15C433C8;
	Sat, 23 Sep 2023 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695459571;
	bh=H52331EVg7A5/+bK/CkdwvyqaImONzevbLINXxNt+x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpEvuWBfhxR/SSWFuXvHoDHil+6oKCVuE8hGCjzOfTPIWbeQ37p/iBHkPx++K+aS/
	 bxkeIKDodmcyqytigm95aEYLKRC219jPm8VfdVuztMAj7pw3InXoRxqT+4k8FnTXbB
	 I8ET3lUevsJrfaX9JEQWhhzGhALZ1+mUjE5ajXVgg9KFUIgcbDeE/QZIRp/+DKnQ8K
	 iZuJC5+xl830vvBtIM/ZeHmUesP2/R4lWT0akhJuSpwPCumVrtmv1hNUk7VHq8KuFd
	 DSNd7s2AtnjuJPQm2SBLPFvXa1WsR6FWkeLxO4v5aK6XcU+65V9JAhKFHIgJfFgH77
	 pC/6S2SVGlhKA==
Date: Sat, 23 Sep 2023 11:00:33 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, linux-i3c@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jack Chen <zenghuchen@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i3c: dw: Annotate struct dw_i3c_xfer with __counted_by
Message-ID: <ZQ8ZsQo4yvBwKn9w@work>
References: <20230922175011.work.800-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175011.work.800-kees@kernel.org>

On Fri, Sep 22, 2023 at 10:50:11AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct dw_i3c_xfer.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: linux-i3c@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/i3c/master/dw-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 9332ae5f6419..ef5751e91cc9 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -233,7 +233,7 @@ struct dw_i3c_xfer {
>  	struct completion comp;
>  	int ret;
>  	unsigned int ncmds;
> -	struct dw_i3c_cmd cmds[];
> +	struct dw_i3c_cmd cmds[] __counted_by(ncmds);
>  };
>  
>  struct dw_i3c_i2c_dev_data {
> -- 
> 2.34.1
> 
> 
