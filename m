Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C21396
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tmm1ZAgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB47C433C8;
	Tue, 24 Oct 2023 02:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698115248;
	bh=xBi8xJGeIr7MpNZHvPfghCXHG6kcf7qjVXlL1QxMANU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Tmm1ZAgmtWpxN3sRD4oPTnmVt96qfDdMkI3qHOewa+2GCFhpSXTjXqJ0DGKEq+IqF
	 E6538VhqanEpM4YJYOqqH15HDc567oICj6f4WkdIiH1npBu//o7xlEzWUTr0GF59kJ
	 Mp7SBHWf9sXIYCXQtCv33cdCfDavYPV0vOLQj6FYs/PW3fahgWTie/fCi6ymvaesiL
	 cVKifM0lhnTi6EuiXh7GgpQr3uxcoL+PIu7qM1M/Uvfhvvb+kMSG/IrFJ39dtkkCc/
	 XlUFAgg7LsUheqDg9rBIkOEGw4/YU0UjEy3JBhQDMOW2QAI0dlbjmRQbG0uPyJoQw5
	 +nANMmcfZCPTw==
Message-ID: <9ebe2372491a76253e5597086d059b1d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <57a831d94ee2b3889b11525d4ad500356f89576f.1697492890.git.gustavoars@kernel.org>
References: <cover.1697492890.git.gustavoars@kernel.org> <57a831d94ee2b3889b11525d4ad500356f89576f.1697492890.git.gustavoars@kernel.org>
Subject: Re: [PATCH v2 1/2][next] clk: visconti: Fix undefined behavior bug in struct visconti_pll_provider
From: Stephen Boyd <sboyd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gustavo A. R. Silva <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
To: Gustavo A. R. Silva <gustavoars@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Date: Mon, 23 Oct 2023 19:40:46 -0700
User-Agent: alot/0.10

Quoting Gustavo A. R. Silva (2023-10-16 15:05:27)
> `struct clk_hw_onecell_data` is a flexible structure, which means that
> it contains flexible-array member at the bottom, in this case array
> `hws`:
>=20
> include/linux/clk-provider.h:
> 1380 struct clk_hw_onecell_data {
> 1381         unsigned int num;
> 1382         struct clk_hw *hws[] __counted_by(num);
> 1383 };
>=20
> This could potentially lead to an overwrite of the objects following
> `clk_data` in `struct visconti_pll_provider`, in this case
> `struct device_node *node;`, at run-time:
>=20
> drivers/clk/visconti/pll.h:
>  16 struct visconti_pll_provider {
>  17         void __iomem *reg_base;
>  18         struct clk_hw_onecell_data clk_data;
>  19         struct device_node *node;
>  20 };
>=20
> Notice that a total of 56 bytes are allocated for flexible-array `hws`
> at line 328. See below:
>=20
> include/dt-bindings/clock/toshiba,tmpv770x.h:
>  14 #define TMPV770X_NR_PLL             7
>=20
> drivers/clk/visconti/pll-tmpv770x.c:
>  69 ctx =3D visconti_init_pll(np, reg_base, TMPV770X_NR_PLL);
>=20
> drivers/clk/visconti/pll.c:
> 321 struct visconti_pll_provider * __init visconti_init_pll(struct device=
_node *np,
> 322                                                         void __iomem =
*base,
> 323                                                         unsigned long=
 nr_plls)
> 324 {
> 325         struct visconti_pll_provider *ctx;
> ...
> 328         ctx =3D kzalloc(struct_size(ctx, clk_data.hws, nr_plls), GFP_=
KERNEL);
>=20
> `struct_size(ctx, clk_data.hws, nr_plls)` above translates to
> sizeof(struct visconti_pll_provider) + sizeof(struct clk_hw *) * 7 =3D=3D
> 24 + 8 * 7 =3D=3D 24 + 56
>                   ^^^^
>                    |
>         allocated bytes for flex array `hws`
>=20
> $ pahole -C visconti_pll_provider drivers/clk/visconti/pll.o
> struct visconti_pll_provider {
>         void *                     reg_base;             /*     0     8 */
>         struct clk_hw_onecell_data clk_data;             /*     8     8 */
>         struct device_node *       node;                 /*    16     8 */
>=20
>         /* size: 24, cachelines: 1, members: 3 */
>         /* last cacheline: 24 bytes */
> };
>=20
> And then, after the allocation, some data is written into all members
> of `struct visconti_pll_provider`:
>=20
> 332         for (i =3D 0; i < nr_plls; ++i)
> 333                 ctx->clk_data.hws[i] =3D ERR_PTR(-ENOENT);
> 334
> 335         ctx->node =3D np;
> 336         ctx->reg_base =3D base;
> 337         ctx->clk_data.num =3D nr_plls;
>=20
> Fix all these by placing the declaration of object `clk_data` at the
> end of `struct visconti_pll_provider`. Also, add a comment to make it
> clear that this object must always be last in the structure, and
> prevent this bug from being introduced again in the future.
>=20
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
>=20
> Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and =
reset driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

Applied to clk-next
