Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA008185B
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es6/Ztw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFB1C433C8;
	Tue, 24 Oct 2023 02:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698115260;
	bh=FWOFfug8FXGUj/9FvMiIQxHfXn4ZtTpUZJQqYJHKQ9I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Es6/Ztw5L3SOejtLMVVkw7+xqev3YoY70imuHxVvk+s/lcWmqBnFJDIrMayfWvalN
	 SqlnoIxvFHrenuCeTGkgcTwlvj/J2TFQEM3EXtjFJag6zbC0pbd/VYd8yT5+t0bQgp
	 ufSZDBt6BY9/Tx3q5m0v5gtIE7n4xd7CQrY5ePrl8NX8unQWHkNJ8UlFLvf7qc/Wws
	 dquKF3gfEN6y/di9HpJkmCpH1du938WTHbk8lL9oDNufPBClf81yx66R0oRwcVixBV
	 aex5NffKqf7/W7HJXe8m27M0HXadNqAZrsJtCPI2gSWHT/Cgpt/mmMMXV7Ev8dBiTh
	 IudoaiMda+8oA==
Message-ID: <dbc69119aef2899e3776b43ecd6468fa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e3189f3e40e8723b6d794fb2260e2e9ab6b960bd.1697492890.git.gustavoars@kernel.org>
References: <cover.1697492890.git.gustavoars@kernel.org> <e3189f3e40e8723b6d794fb2260e2e9ab6b960bd.1697492890.git.gustavoars@kernel.org>
Subject: Re: [PATCH v2 2/2][next] clk: visconti: Add bounds-checking coverage for struct visconti_pll_provider
From: Stephen Boyd <sboyd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gustavo A. R. Silva <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
To: Gustavo A. R. Silva <gustavoars@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Date: Mon, 23 Oct 2023 19:40:58 -0700
User-Agent: alot/0.10

Quoting Gustavo A. R. Silva (2023-10-16 15:06:16)
> In order to gain the bounds-checking coverage that __counted_by provides
> to flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions),
> we must make sure that the counter member, in this particular case `num`,
> is updated before the first access to the flex-array member, in this
> particular case array `hws`. See below:
>=20
> commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") introduced `__counted_by` for `struct clk_hw_onecell_data`
> together with changes to relocate some of assignments of counter `num`
> before `hws` is accessed:
>=20
> include/linux/clk-provider.h:
> 1380 struct clk_hw_onecell_data {
> 1381         unsigned int num;
> 1382         struct clk_hw *hws[] __counted_by(num);
> 1383 };
>=20
> However, this structure is used as a member in other structs, in this
> case in `struct visconti_pll_provider`:
>=20
> drivers/clk/visconti/pll.h:
>  16 struct visconti_pll_provider {
>  17         void __iomem *reg_base;
>  18         struct device_node *node;
>  19
>  20         /* Must be last */
>  21         struct clk_hw_onecell_data clk_data;
>  22 };
>=20
> Hence, we need to move the assignments to `ctx->clk_data.num` after
> allocation for `struct visconti_pll_provider` and before accessing the
> flexible array `ctx->clk_data.hws`. And, as assignments for all members
> in `struct visconti_pll_provider` are originally adjacent to each other,
> relocate all assignments together, so we don't split up
> `ctx->clk_data.hws =3D nr_plls` from the rest. :)
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

Applied to clk-next
