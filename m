Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DE6FCF;
	Wed,  4 Oct 2023 14:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD873C433C7;
	Wed,  4 Oct 2023 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696429742;
	bh=KqRNpiCtCs4Rwv/M9eIf6xD9i4BgOO2QeVweWjAAAZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cWrHN6hpB2LZY+61r8q4V1LqAN7/v6kGoq8Qp6h5JysXarQaoIZ5Dlz8fvA36m9t7
	 uY+QJUGrEUZYYgVHwTaSTzG1crp/fXYdlocOnB8U5rbH7T5xFIMeSjH8U60kE87M7Q
	 ysSMIIWIjFA/U2AJYsXuZKabaNidhY+rIUVwt1h7F1sXuWESsDen8/PHEsN7JByoXN
	 s/mpsCCn404zKlJWnv7YUNV9fnaPAcwDPv5UwvAT/rbNalFQnTC/OLv1eW0Vtsx371
	 l+at/pOIM5TeuRx0k2mCmPN6tPsoLQ9LHBJGE5vvziQVAKJlxK8gplKE+xeQN7aGAJ
	 qbP3fa7rQzSpg==
From: Vinod Koul <vkoul@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: dmaengine@vger.kernel.org, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20231003232704.work.596-kees@kernel.org>
References: <20231003232704.work.596-kees@kernel.org>
Subject: Re: [PATCH] dmaengine: fsl-edma: Annotate struct struct
 fsl_edma_engine with __counted_by
Message-Id: <169642973944.440009.1499623916729788051.b4-ty@kernel.org>
Date: Wed, 04 Oct 2023 19:58:59 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 03 Oct 2023 16:27:56 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct struct fsl_edma_engine.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: Annotate struct struct fsl_edma_engine with __counted_by
      commit: c223bafdcbd51506df00509088efc62e08ef6c3f

Best regards,
-- 
~Vinod


