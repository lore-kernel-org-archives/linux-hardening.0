Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2501F16B;
	Fri, 15 Nov 2024 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731634544; cv=none; b=YZjZnn+lPUinby1wo2t+eZvFj4tko+gCz1uhCYfW0MlnJCr5lXW4b1HShprVoP1JabToEPubrt9sb9cdU6uXaeRM092WHs8wXP5R8Ez4Y2nrwCgusg5z+3K3KDE5hTuYkO2OFRqNY2EkfQPuLX8vQKyjmtY4QHs6rYo+y96+5Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731634544; c=relaxed/simple;
	bh=JJ/kewMp8upR6rZT/kzkvlK/w6yzgPT8ZVjC7mDhuPI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=n6KAp+uMi9DpIvYqZfS+sz79Ov3Mh7C+0guLygpaBCFmZ6RHsSZAPQJWBUz8kZ++Furw/7GDz584L4w7E+xdzI0a7WLTnO4m6KV+2K5h2PDx9w7sEwScetSzwAwhpzMUUoxPg7Q/f6VDlD8FIhX2n+Zx3ZgmPyN765dZhmAqxqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdH7WIlm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdH7WIlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8C0C4CECD;
	Fri, 15 Nov 2024 01:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731634543;
	bh=JJ/kewMp8upR6rZT/kzkvlK/w6yzgPT8ZVjC7mDhuPI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jdH7WIlmxQ2XEYkMdDpldYPLCga7771epPsGCghAVaGgqLlM7btaLczRg+QTifQYX
	 9ENRPiV2mMBGqJSPpCIz1olZlM2wBdlmsMOzyWylYeT0SPn1fA6dnSn34uyD+qjCWK
	 UY7i2/VGusKJLD5zGndLqokZlSBqgkn1ckrXVDowXF8OeYimPE4IpMb6RXw4eTjxkv
	 aL8K7cNz5QWCMTWWqY057g+q1ddmxaSXzdtdCDCTP/BUsz9hsBs17iehszKuGAZr6E
	 FalcdToXrZLg0iVNrHdw8F5vYNwkITxLOdovUmBQhYH5OBBbw/ztTURuyzEiZDc8WX
	 ppiAK4vHFY/rg==
Message-ID: <ed2e1be4be4716b2c436a163ae40ef07.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZzaN5MpmMr0hwHw9@kspp>
References: <ZzaN5MpmMr0hwHw9@kspp>
Subject: Re: [PATCH] clk: clk-loongson2: Fix potential buffer overflow in flexible-array member access
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Gustavo A. R. Silva <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
To: Binbin Zhou <zhoubinbin@loongson.cn>, Gustavo A. R. Silva <gustavoars@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Thu, 14 Nov 2024 17:35:41 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Gustavo A. R. Silva (2024-11-14 15:55:16)
> Flexible-array member `hws` in `struct clk_hw_onecell_data` is annotated
> with the `counted_by()` attribute. This means that when memory is
> allocated for this array, the _counter_, which in this case is member
> `num` in the flexible structure, should be set to the maximum number of
> elements the flexible array can contain, or fewer.
>=20
> In this case, the total number of elements for the flexible array is
> determined by variable `clks_num` when allocating heap space via
> `devm_kzalloc()`, as shown below:
>=20
> 289         struct loongson2_clk_provider *clp;
>         ...
> 296         for (p =3D data; p->name; p++)
> 297                 clks_num++;
> 298
> 299         clp =3D devm_kzalloc(dev, struct_size(clp, clk_data.hws, clks=
_num),
> 300                            GFP_KERNEL);
>=20
> So, `clp->clk_data.num` should be set to `clks_num` or less, and not
> exceed `clks_num`, as is currently the case. Otherwise, if data is
> written into `clp->clk_data.hws[clks_num]`, the instrumentation
> provided by the compiler won't detect the overflow, leading to a
> memory corruption bug at runtime.
>=20
> Fix this issue by setting `clp->clk_data.num` to `clks_num`.
>=20
> Fixes: 9796ec0bd04b ("clk: clk-loongson2: Refactor driver for adding new =
platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

Applied to clk-next
