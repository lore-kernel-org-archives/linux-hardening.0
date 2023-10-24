Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41E1863
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUUUrFFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89C0C433C8;
	Tue, 24 Oct 2023 02:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698115928;
	bh=DYP4bvnubmy1D2tjb8pqBIWG0iAEU82XRCwWOXLif2U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZUUUrFFhs0LXM5cjmFaLZh0y8plQ+L9cWP1Fw0ekgcFZC122BGrtrJ+v982ycjU+3
	 jWSem+N0PnxBXWOXhyBtMLBLPyJuptEnzxL1B5zlfqEZmMARLZzl19nUhmfFiZSjAa
	 fPZmcgpJmpodDg7JtwLq+zGks4MHXyU41sr31Ro05dCeDZb6D1MUa/ebh5TJsNaVO7
	 WR9mf/kvCrnZXl67twoKSOEqaoNILLxXQPd4o2LvQ53kpnWyFNb63MXdb8BlJS1U+9
	 Cv2fmGsM8EQljiq6bw4NcD4SsPYxkBXc5w1ISHvVnaKAYqb144N60z2dv43tNsSaE6
	 BIrPSXJp5xYvw==
Message-ID: <71ed1d939ef6c97f5a6e1004ef8545bf.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <21b1ebbe-2bef-4f56-a4d6-3ed898a1e953@embeddedor.com>
References: <cover.1697492890.git.gustavoars@kernel.org> <57a831d94ee2b3889b11525d4ad500356f89576f.1697492890.git.gustavoars@kernel.org> <9ebe2372491a76253e5597086d059b1d.sboyd@kernel.org> <21b1ebbe-2bef-4f56-a4d6-3ed898a1e953@embeddedor.com>
Subject: Re: [PATCH v2 1/2][next] clk: visconti: Fix undefined behavior bug in struct visconti_pll_provider
From: Stephen Boyd <sboyd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
To: Gustavo A. R. Silva <gustavo@embeddedor.com>, Gustavo A. R. Silva <gustavoars@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Date: Mon, 23 Oct 2023 19:52:06 -0700
User-Agent: alot/0.10

Quoting Gustavo A. R. Silva (2023-10-23 19:48:00)
>=20
> >> Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver a=
nd reset driver")
> >> Cc: stable@vger.kernel.org
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> ---
> >=20
> > Applied to clk-next
>=20
> Hi!
>=20
> Here is another similar small series, in case you missed it:
>=20
> https://lore.kernel.org/linux-hardening/cover.1697493574.git.gustavoars@k=
ernel.org/
>=20

Please Cc linux-clk on clk patches.
