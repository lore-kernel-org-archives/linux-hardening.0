Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4DD261;
	Sat, 23 Sep 2023 09:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660B2C433C7;
	Sat, 23 Sep 2023 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695459611;
	bh=YtwQBuQyMXymPxM6ljmzlmpMeRjYV+8uUzyCjUIiWkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwsi1G13a5bMOQADUKA28oYIlcldKinNLMjx+5JBVRUdn3Y+3e0jV9v1PQhkhBBM2
	 ncX3dw88m6RDyvjjahuzmgDiNZ5gcnQEirjNlP0oQQhM7UZb3vR7o/LweiufMsQDn0
	 hmuE+JxSjTLMjtpSdNa1z4n2NIlTaC6+mI5Ad7CfyQXV7C9xBGiNwgbIpfOh17BBAo
	 SEOTqEwo5GtFT/5vnFQ7VSRJNKgzhxOst+DQZBSW/PqsV3yqO/h68UBUuRg4D26Qhz
	 JqwGQ+UyJAHxoN7olNgQXUefkOtAjNIWPStIbUQk3fdXr30zReefPRJcE7CLqUK/Y1
	 S85hWi+T5tAPw==
Date: Sat, 23 Sep 2023 11:01:14 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] spi: mchp-pci1xxxx: Annotate struct pci1xxxx_spi with
 __counted_by
Message-ID: <ZQ8Z2hXuR8F0g/C3@work>
References: <20230922175322.work.170-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175322.work.170-kees@kernel.org>

On Fri, Sep 22, 2023 at 10:53:23AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct pci1xxxx_spi.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/spi/spi-pci1xxxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
> index 3638e974f5d4..5b2d3e4e21b7 100644
> --- a/drivers/spi/spi-pci1xxxx.c
> +++ b/drivers/spi/spi-pci1xxxx.c
> @@ -77,7 +77,7 @@ struct pci1xxxx_spi {
>  	struct pci_dev *dev;
>  	u8 total_hw_instances;
>  	void __iomem *reg_base;
> -	struct pci1xxxx_spi_internal *spi_int[];
> +	struct pci1xxxx_spi_internal *spi_int[] __counted_by(total_hw_instances);
>  };
>  
>  static const struct pci_device_id pci1xxxx_spi_pci_id_table[] = {
> -- 
> 2.34.1
> 
> 
