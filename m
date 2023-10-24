Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537B23BB
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmjve4TI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EF3C433C8;
	Tue, 24 Oct 2023 03:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698118502;
	bh=CytMuZ+Vr6NdPnm8B1Vu0OTHHpXCEToypeT9jFTf6JM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Wmjve4TIEHx8jGCPQc+soxMpQvemh3O+L16jZqfsyqGnNJAmJWUYHmz22bNnHxkwP
	 72z9ShHplMkq4zbXAKyz0JOWrBAXAfDunGENiyvZpC37jRT2ZR3Y2TO2iRg2az5VND
	 xvASvSeCxBQZFRCH4gxOMLzQPjR9Wix37l2Hw+ErAEUHNXYtBtZgYIZIUB5Z+JMtb0
	 UIFZZqoQo7R0kXIrs5ggNMgTitf3CBKRQzleW0DQ7JbC8MJjqOVZ47HPNYdWmbu2Ch
	 ZjGFtsyEuqRSRoxuYuLojKxueFkOKMIZ23QFJPA3pn+atISrLNezl5FI4RWXJa/cdU
	 mJ4m14aKr7GAQ==
Message-ID: <32163b79b282f9de0ae6e7ed1e1540ee.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1da736106d8e0806aeafa6e471a13ced490eae22.1698117815.git.gustavoars@kernel.org>
References: <cover.1698117815.git.gustavoars@kernel.org> <1da736106d8e0806aeafa6e471a13ced490eae22.1698117815.git.gustavoars@kernel.org>
Subject: Re: [PATCH v3 1/2][next] clk: socfpga: Fix undefined behavior bug in struct stratix10_clock_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Gustavo A. R. Silva <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, linux-clk@vger.kernel.org
To: Dinh Nguyen <dinguyen@kernel.org>, Gustavo A. R. Silva <gustavoars@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Date: Mon, 23 Oct 2023 20:35:00 -0700
User-Agent: alot/0.10

Quoting Gustavo A. R. Silva (2023-10-23 20:30:52)
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
> `clk_data` in `struct stratix10_clock_data`, in this case
> `void __iomem *base;` at run-time:
>=20
> drivers/clk/socfpga/stratix10-clk.h:
>   9 struct stratix10_clock_data {
>  10         struct clk_hw_onecell_data      clk_data;
>  11         void __iomem            *base;
>  12 };
>=20
> There are currently three different places where memory is allocated for
> `struct stratix10_clock_data`, including the flex-array `hws` in
> `struct clk_hw_onecell_data`:
>=20
> drivers/clk/socfpga/clk-agilex.c:
> 469         clk_data =3D devm_kzalloc(dev, struct_size(clk_data, clk_data=
.hws,
> 470                                 num_clks), GFP_KERNEL);
>=20
> drivers/clk/socfpga/clk-agilex.c:
> 509         clk_data =3D devm_kzalloc(dev, struct_size(clk_data, clk_data=
.hws,
> 510                                 num_clks), GFP_KERNEL);
>=20
> drivers/clk/socfpga/clk-s10.c:
> 400         clk_data =3D devm_kzalloc(dev, struct_size(clk_data, clk_data=
.hws,
> 401                                                  num_clks), GFP_KERNE=
L);
>=20
> I'll use just one of them to describe the issue. See below.
>=20
> Notice that a total of 440 bytes are allocated for flexible-array member
> `hws` at line 469:
>=20
> include/dt-bindings/clock/agilex-clock.h:
>  70 #define AGILEX_NUM_CLKS     55
>=20
> drivers/clk/socfpga/clk-agilex.c:
> 459         struct stratix10_clock_data *clk_data;
> 460         void __iomem *base;
> ...
> 466
> 467         num_clks =3D AGILEX_NUM_CLKS;
> 468
> 469         clk_data =3D devm_kzalloc(dev, struct_size(clk_data, clk_data=
.hws,
> 470                                 num_clks), GFP_KERNEL);
>=20
> `struct_size(clk_data, clk_data.hws, num_clks)` above translates to
> sizeof(struct stratix10_clock_data) + sizeof(struct clk_hw *) * 55 =3D=3D
> 16 + 8 * 55 =3D=3D 16 + 440
>                     ^^^
>                      |
>         allocated bytes for flex-array `hws`
>=20
> 474         for (i =3D 0; i < num_clks; i++)
> 475                 clk_data->clk_data.hws[i] =3D ERR_PTR(-ENOENT);
> 476
> 477         clk_data->base =3D base;
>=20
> and then some data is written into both `hws` and `base` objects.
>=20
> Fix this by placing the declaration of object `clk_data` at the end of
> `struct stratix10_clock_data`. Also, add a comment to make it clear
> that this object must always be last in the structure.
>=20
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
>=20
> Fixes: ba7e258425ac ("clk: socfpga: Convert to s10/agilex/n5x to use clk_=
hw")
> Cc: stable@vger.kernel.org
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

Applied to clk-next
