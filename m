Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E68D2E5;
	Sat, 23 Sep 2023 08:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DD3C433C9;
	Sat, 23 Sep 2023 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695459406;
	bh=j34XWsRtTEQvDT8yovbT5KAH8v3D0pMnExUnWFgILrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2YDs08UwYjWsRIIMNaAGfvG3tdOpu+9bTHEAg95idaYKlyqUX9yDMZZqX6eQlT2K
	 nKXw0Ndwku3LoOTSS3AJXXnoVQY7jz7TjSzlHykwqQs7jMWu1yKlOHXMkU5xUBSKDq
	 21PmLUMcz+D6gvKD8bTZkccUvW1VvnxdqvqbSSq7tbon0qV+L26ywHwSRyT7ShQcvl
	 r8sLgAwxc5Cac8zzm3J1SOovzMLUlaC4TvmWoYicjswSVJZIdxrW5CcR2kPrUrjM96
	 rsSQac5U7YsTlC+xIsriw/hNbwvBsmh8cZ+lkayBXtcmwptNMKwrHxPRoS9/ntWYYr
	 5uJDhbw8C+8zQ==
Date: Sat, 23 Sep 2023 10:57:47 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] platform/surface: aggregator: Annotate struct ssam_event
 with __counted_by
Message-ID: <ZQ8ZCyoospgceCHv@work>
References: <20230922175436.work.031-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175436.work.031-kees@kernel.org>

On Fri, Sep 22, 2023 at 10:54:37AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ssam_event.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  include/linux/surface_aggregator/controller.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
> index cb7980805920..5b67f0f47d80 100644
> --- a/include/linux/surface_aggregator/controller.h
> +++ b/include/linux/surface_aggregator/controller.h
> @@ -44,7 +44,7 @@ struct ssam_event {
>  	u8 command_id;
>  	u8 instance_id;
>  	u16 length;
> -	u8 data[];
> +	u8 data[] __counted_by(length);
>  };
>  
>  /**
> -- 
> 2.34.1
> 
> 
