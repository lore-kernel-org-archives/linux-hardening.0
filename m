Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3676FCF;
	Wed,  4 Oct 2023 14:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FF3C43395;
	Wed,  4 Oct 2023 14:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696429748;
	bh=dE+wd+fx3bR2fLrXaHnvGq6sU/3A9Au6dn7p+BhL9ac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bMgMmU+zyhSUHroX0vz4Jjl8UKUURxm6XP4DiBC/XoTBMIbCUEg7K/JFcr3xVYDzQ
	 yUJYkdce4INQVwwIX62m/u1ppOYDHv0lg5kPtOAgtGp8ckvJQPb8Rv1oNx2Dr6KmCB
	 CClMgWKkh8caTFbqRuJR2V785guuQVBPJlmKCbeSKjHB/C8xZ9cR6SS4h1YHicOZZY
	 pA9SpLWV8rpKymzh48BRHxXnaBg8h4neFkLcWwlFaYvypLOz3gxiq89ZWd12B2K+sk
	 l+c+1dhFYo46qqh1mY3GS0EeussZPli8Qrcph8dXGFYha3xIT4WaH8k328RrnwEiX4
	 U634wpEed6zWg==
From: Vinod Koul <vkoul@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
 dmaengine@vger.kernel.org, llvm@lists.linux.dev, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20230928234334.work.391-kees@kernel.org>
References: <20230928234334.work.391-kees@kernel.org>
Subject: Re: [PATCH] dmaengine: ep93xx_dma: Annotate struct
 ep93xx_dma_engine with __counted_by
Message-Id: <169642974524.440009.16047886580039006208.b4-ty@kernel.org>
Date: Wed, 04 Oct 2023 19:59:05 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 28 Sep 2023 16:43:42 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ep93xx_dma_engine.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ep93xx_dma: Annotate struct ep93xx_dma_engine with __counted_by
      commit: 74d885711c2f619e92f41ef308691948cc63f224

Best regards,
-- 
~Vinod


