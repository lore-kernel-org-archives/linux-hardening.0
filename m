Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D181AF0AA;
	Thu, 14 Nov 2024 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625402; cv=none; b=O+AqinCRDNwWfwJkMc2kIVKT2442K/Ob6tg8i1H+rhbUra8JN3xgNYVnvL2RTzEskohQsQtPJ7aAqidkJ/t2oVgl2blbRWsPkW+JT6p+BcRFmSJsDl++lddGwOmbASPYvrY+yr7f+yLFj2LjT8zH4f+6xbpixoR1yHl7CJWQ3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625402; c=relaxed/simple;
	bh=7YLDk7m+k1pCnW+7dbogxl5nQSG7CCASV+qPKMwwB4U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YWWDg9SZeAckjBtVXiZFUwPANUvQw8wAqXU4ScWfH6KSb1EWw3VNYwmFLYwMdIn6Am/Q54LfkuK1J4L7Hj45tZQ9AMW4pj/ZSENEHrJuQsDPSowa1qhnZhniZnkMabIRjCEHOwCFOgT1oZI+99DZbQY83lERupbVjoP/uSj4C6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxmIQqjC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxmIQqjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE9CC4CECD;
	Thu, 14 Nov 2024 23:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731625401;
	bh=7YLDk7m+k1pCnW+7dbogxl5nQSG7CCASV+qPKMwwB4U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MxmIQqjCqTDZ+RH9+X3QNEqtbJt3rt9Pqc6/UQggVpuupsnLlaRnTW0IQxebwHgBZ
	 90/Rf1J029WWTJqrpFuex/vsffTKmUyF5a89XVDABwHaBb03giNkOC2RZ7PRwpgku5
	 z0EgxskgrP3+IcjoEapDRBDMefj/1+3AKohINAZBJ6Ah6sq9Juaghr4TGbFg+Shttl
	 AomkmrR3g4wiLkID9n1n2UQctR6+KdhOZvVc/KapXFeQAH+vrOyO6N9V5zGqughctN
	 G7KUI05YLwCRs6U3rK24PAr4oBCtXmCNFFWTclQYka+yahkdpZ7JESUJB6cekQ/C7J
	 /k81+sBtqZzfw==
Message-ID: <ddc333ad3a150b1d3cc360bd16cc3459.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZzZ-cd_EFXs6qFaH@kspp>
References: <ZzZ-cd_EFXs6qFaH@kspp>
Subject: Re: [PATCH] clk: clk-loongson2: Fix memory corruption bug in struct loongson2_clk_provider
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Gustavo A. R. Silva <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
To: Binbin Zhou <zhoubinbin@loongson.cn>, Gustavo A. R. Silva <gustavoars@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Thu, 14 Nov 2024 15:03:19 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Gustavo A. R. Silva (2024-11-14 14:49:21)
> Some heap space is allocated for the flexible structure `struct
> clk_hw_onecell_data` and its flexible-array member `hws` through
> the composite structure `struct loongson2_clk_provider` in function
> `loongson2_clk_probe()`, as shown below:
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
> Then some data is written into the flexible array:
>=20
> 350                 clp->clk_data.hws[p->id] =3D hw;
>=20
> This corrupts `clk_lock`, which is the spinlock variable immediately
> following the `clk_data` member in `struct loongson2_clk_provider`:
>=20
> struct loongson2_clk_provider {
>         void __iomem *base;
>         struct device *dev;
>         struct clk_hw_onecell_data clk_data;
>         spinlock_t clk_lock;    /* protect access to DIV registers */
> };
>=20
> The problem is that the flexible structure is currently placed in the
> middle of `struct loongson2_clk_provider` instead of at the end.
>=20
> Fix this by moving `struct clk_hw_onecell_data clk_data;` to the end of
> `struct loongson2_clk_provider`. Also, add a code comment to help
> prevent this from happening again in case new members are added to the
> structure in the future.
>=20
> This change also fixes the following -Wflex-array-member-not-at-end
> warning:
>=20
> drivers/clk/clk-loongson2.c:32:36: warning: structure containing a flexib=
le array member is not at the end of another structure [-Wflex-array-member=
-not-at-end]
>=20
> Fixes: 9796ec0bd04b ("clk: clk-loongson2: Refactor driver for adding new =
platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

Applied to clk-next
