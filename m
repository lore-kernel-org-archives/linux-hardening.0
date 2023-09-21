Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8A64F;
	Thu, 21 Sep 2023 06:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B06C433D9;
	Thu, 21 Sep 2023 06:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695277858;
	bh=T+AarZU1OTWE4tfG5KCNEN7xu+9uCv63xpcrlLBPzs4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=F8spp6f20lSgSPHJDALIiU808mf39UoqBTNdF7qImjbNCJwTFAC3eIT2dM1d9jnJx
	 Hz7Ek/XGl4FJw8IyEj87AlnDMKzuVWv2Jyn50UdvQz54g8Pda4wteEZiOpW/e606MW
	 aiQ+wR1I9Zzr5RI1fXHVsD6oki6FitbWIfn8AMbAIz0iwUpoQh+fREph4mexqnHQm+
	 CDt8pTl83zrSp3k8q50qdg3OsV+ag3dJcCuF0cxmfBx6cbMdcYsav3J3rKJrbW62TD
	 ucDYT+V8I9UpkPPQPbR3w1onrFv9hIr47UeFE3OL8c05hPDHSDmJ+be9gmwtjb4mH/
	 0Tlelv86F33bQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ipw2x00: Annotate struct libipw_txb with
 __counted_by
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230915200602.never.582-kees@kernel.org>
References: <20230915200602.never.582-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>,
 Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169527785383.1469888.6111719451945571724.kvalo@kernel.org>
Date: Thu, 21 Sep 2023 06:30:55 +0000 (UTC)

Kees Cook <keescook@chromium.org> wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct libipw_txb.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

357be7ebba38 wifi: ipw2x00: Annotate struct libipw_txb with __counted_by

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230915200602.never.582-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

