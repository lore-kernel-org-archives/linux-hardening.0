Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDC2CA7;
	Sat, 23 Sep 2023 08:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE79BC433C7;
	Sat, 23 Sep 2023 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695459319;
	bh=lseakF6M2dlhTAVWNVK3bOAsavTxJDpelRRD6WFVyqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuhpNCZ9pA/PjelUbm7C5AC7eEHLWgQTWDcs6fnqF8fSTroxBm2WuVxfByP7lIgEI
	 W31HIc3p60iYfcgSz6Noo3GWdnDE7R6SpRKw0zb/Rj7Ds4Rrny6OEnTeOIi6W0i8Xf
	 w7pO4haVIbSFNVEq93YgfQJ2mVC/wAAyS0tw4QSeiAp3fGogE8Yrw+b8EGoVqqCGKu
	 BRzwRmQR7qchrGZC4jIMQOZmxDKvMKJu2+0i4QgQSZeNPOlBTYFhLGmp1DcLr1xp2c
	 SPG6XyJtctIOxt5YmDQgsr6/1uYCXQs+Sj19/m2XKeaYa7Wi/h0DfmPzlCPBnlLwHJ
	 tk7pZhocEtXXA==
Date: Sat, 23 Sep 2023 10:56:21 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, platform-driver-x86@vger.kernel.org,
	llvm@lists.linux.dev,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Annotate struct bios_args with
 __counted_by
Message-ID: <ZQ8YtbxQnkDN1nc0@work>
References: <20230922175420.work.701-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175420.work.701-kees@kernel.org>

On Fri, Sep 22, 2023 at 10:54:21AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct bios_args.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Jorge Lopez <jorge.lopez2@hp.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> index dea54f35b8b5..4da99cb7218d 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> @@ -19,7 +19,7 @@ struct bios_args {
>  	u32 command;
>  	u32 commandtype;
>  	u32 datasize;
> -	u8 data[];
> +	u8 data[] __counted_by(datasize);
>  };
>  
>  /**
> -- 
> 2.34.1
> 
> 
