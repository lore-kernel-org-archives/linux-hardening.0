Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679237D120;
	Wed, 29 Apr 2026 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434402; cv=none; b=Tfq9HQCz+NCRV8aXXy4epvQCFyqso2Ok36z+yqEPi5EkQZAyD8dVbGt0NpuDRQ29HmcSw5EtZpGiPkoxKjgPQ2+uNw1kz2hplg8ZZ3jvH3YMq3TgcVQD2qvttme3Q1UV/GjshCxk10KoWXrRiU4WHX1WOmVDOgShNjkWxYfoLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434402; c=relaxed/simple;
	bh=IdIfEWX7olz0iURPKOWIl8AkzSfMwzCnL9O27sqheew=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=DKRV8wyeemxM5EQ2KmtuGlrW3X1Gd2LPhxW4pTmfJYwps5BRUhcMUmfDVv1jbNRWgLlnaqGicNN3yfxnns+h/DUN1kaf+LfvsaVTNCwPvwHHHpnQiM4gCvK8ByaM305eVM3srbuiJpaTqrKGnxpv3P0HFLr5s0Bi6HwLuomUqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8Eotjvg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8Eotjvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246A7C19425;
	Wed, 29 Apr 2026 03:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777434402;
	bh=IdIfEWX7olz0iURPKOWIl8AkzSfMwzCnL9O27sqheew=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=U8EotjvgksxUWKR1QYatGEcKuoigOQX7KNn2Fnd7V+M+UL/g9OqoKgCFZD4mlBPWH
	 GOvtPEVQR9ePk4EH1FgJI6dPPc/CQpA1z1PuvFjxF3k7ADaeebyDDgPLPyXdkk2yG1
	 9weVVekbjvfKJGMUA7A7nRXHCCW5N5qhIYTg5xT4m7CTDJb0lUO9w2vTQcnGEr+HxA
	 L0oyamiGiWikQVrFwGMQR6GCBTcV/FNzavXgRoaQMyJJHRi28+qs32lhxAiozUCLdR
	 LmUwq8FDBmeYOy50z8AS6CQzWflirDk1+Ib6TVeyV3dDNNtYmNgV7M0vl1/ZpUdR3Y
	 m8QSAyMYbN1ww==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260326052847.335089-1-rosenp@gmail.com>
References: <20260326052847.335089-1-rosenp@gmail.com>
Subject: Re: [PATCH] clk: clk-max77686: kzalloc + kcalloc to kzalloc
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Kees Cook <kees@kernel.org>, Gustavo A. R. Silva <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
To: Rosen Penev <rosenp@gmail.com>, linux-clk@vger.kernel.org
Date: Tue, 28 Apr 2026 18:44:43 -0700
Message-ID: <177742708384.5403.17744131008877382744@localhost.localdomain>
User-Agent: alot/0.12

Quoting Rosen Penev (2026-03-25 22:28:47)
> Simplify allocation by using a flexible array member to combine
> allocations. Use struct_size to calculate size properly.
>=20
> Use __counted_by to get extra runtime analysis. Assign counting variable
> right after allocation as required by __counted_by.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Applied to clk-next
