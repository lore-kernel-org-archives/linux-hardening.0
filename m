Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C356CA6C;
	Sat, 23 Sep 2023 08:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D37C433C9;
	Sat, 23 Sep 2023 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695459472;
	bh=lkZTTPkhqLfjkprWT4Ia6kfXgvK3+U2RT5SryrW5fU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNzDdi2ADZy/5iSMNEcMTw6rPJDQxwZ1X0gpCVWzWc0zGB0T1WV5/GusCdWkQLcdU
	 XUnM+6j6Piv3G8J6rmB5QiFtH0juwUwqGasjKeOF1gd+EYg7jak8AHnPnU5V7n1+Od
	 xxyBZhDS9xQb6vntJcYMIvJnE15ktDV3+CQtX6XWABq3sJcKy1ncSM6IMWcUQKTCJg
	 QoT0LWMMWz4tTZGgC7XiojTHDRDzxF9OOWBI5ADB3i4HVmlxBqtvO4juFDoVcZrI0+
	 PGowALpXhR8mJ2rUeR4RVt9BU3xXNj1JXedl+FDXQImOecyzSF0IGpMsQRike1Zq+l
	 55vUUeYL3O13A==
Date: Sat, 23 Sep 2023 10:58:55 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i3c: svc: Annotate struct svc_i3c_xfer with __counted_by
Message-ID: <ZQ8ZTwbg56QgmRTd@work>
References: <20230922175023.work.239-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175023.work.239-kees@kernel.org>

On Fri, Sep 22, 2023 at 10:50:23AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct svc_i3c_xfer.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Conor Culhane <conor.culhane@silvaco.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-i3c@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 8f8295acdadb..32eca2d6caf0 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -143,7 +143,7 @@ struct svc_i3c_xfer {
>  	int ret;
>  	unsigned int type;
>  	unsigned int ncmds;
> -	struct svc_i3c_cmd cmds[];
> +	struct svc_i3c_cmd cmds[] __counted_by(ncmds);
>  };
>  
>  struct svc_i3c_regs_save {
> -- 
> 2.34.1
> 
> 
