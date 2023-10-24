Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4F23BB
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 03:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5eAWz5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42F3C433C7;
	Tue, 24 Oct 2023 03:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698118514;
	bh=gEjzgitPwtEM7qPh1XxJevn3rHIvkgMhlroxDGCxJT0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=m5eAWz5fjJpeDClOHeEV9UCBDDhj6SPS1kCs+cep4NRzF3IbQJ7RRKNgxtACzbNMx
	 t2PdvmmThgUtvH76pTODnQ2yXi1tAic1ra6FQCaVM0FZbbJl3axUW3li1jvcHWhGVS
	 0xV2NS6PARouI/7CBGQMucBPRbrNbVz5cCHzq3CsIkLDcAf5XrXm964xGdhoINq4WI
	 2xqLgw8Nb1qp2kxEK678/oilKIKQglYdsPbk5QqdO2xLyXJG8utbDhuAEZM4P89ALS
	 TLBqupAVPsuh6F3yRl8fTF/mQX6RURAY6dXN23HcMLl7Cg5Gj/7ytzc+enTbeNTqUz
	 1P4ENwtwzv8Pg==
Message-ID: <a46cee9468d3f6cb7e33c48e8ab70ca0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <385c516c498e07eb9a521107e16a7efd26e86ea5.1698117815.git.gustavoars@kernel.org>
References: <cover.1698117815.git.gustavoars@kernel.org> <385c516c498e07eb9a521107e16a7efd26e86ea5.1698117815.git.gustavoars@kernel.org>
Subject: Re: [PATCH v3 2/2][next] clk: socfpga: agilex: Add bounds-checking coverage for struct stratix10_clock_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Gustavo A. R. Silva <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, linux-clk@vger.kernel.org
To: Dinh Nguyen <dinguyen@kernel.org>, Gustavo A. R. Silva <gustavoars@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Date: Mon, 23 Oct 2023 20:35:12 -0700
User-Agent: alot/0.10

Quoting Gustavo A. R. Silva (2023-10-23 20:31:42)
> In order to gain the bounds-checking coverage that __counted_by provides
> to flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions),
> we must make sure that the counter member, in this case `num`, is updated
> before the first access to the flex-array member, in this case array `hws=
`.
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
> case in `struct sstratix10_clock_data`:
>=20
> drivers/clk/socfpga/stratix10-clk.h:
>   9 struct stratix10_clock_data {
>  10         void __iomem            *base;
>  11
>  12         /* Must be last */
>  13         struct clk_hw_onecell_data      clk_data;
>  14 };
>=20
> Hence, we need to move the assignments to `clk_data->clk_data.num` after
> allocations for `struct stratix10_clock_data` and before accessing the
> flexible array `clk_data->clk_data.hws`. And, as assignments for both
> `clk_data->clk_data.num` and `clk_data->base` are originally adjacent to
> each other, relocate both assignments together.
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

Applied to clk-next
