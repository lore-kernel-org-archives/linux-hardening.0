Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD3314B8F;
	Wed, 29 Apr 2026 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434398; cv=none; b=otLZvrh0xN6Lw3kj748s9bc58I7GdkmRYkdD1RWu4f/ZIHO0PP5/wWrW2PsUUMG9eZsbx4Q7D0ZKsEZiFSm9q5Le3Q2eYEKdgQysFJpXFQcuK4H7PZUmr+pBZnwuAB4tmlcRc5IimRIBlJzw7nDjENjskTIehKM8Q2hROvYd/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434398; c=relaxed/simple;
	bh=292LHZ8MuXkk+34QLG/rgUUkkjrV427rrbIkGjKOJ0s=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=HG0R9gcBa7Z+Bs8eLUlUiUDJ17Mdx1kZ03k2L9mDK+zz38IF/NbqP/XmR8YDD30jFtx1ZphB27eZRVZQZUcKVZ228ODDzt0guh0xbw3ZadRJbQSITdxh8l6rEjkH4geoPvMtdRTcYNUaTNvimUXFSpgn8lQX3W1nlpMnhO60Sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGqveUjJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGqveUjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48247C2BCB4;
	Wed, 29 Apr 2026 03:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777434398;
	bh=292LHZ8MuXkk+34QLG/rgUUkkjrV427rrbIkGjKOJ0s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VGqveUjJ4TLUEg95Kz4wgGoJ/PjBa1tfbpS9VpaANuMw2QCYAMVgD7BCrU2zFuEfW
	 eSbOf/Q0IfzzL3olwacKPoYZx2uTaWT7xtOxqwPfKDVD0aEIo5E4GSBnLlyDIpcXJk
	 ssSdmyL3zBXueSzkP/3y/qxefXLkf+xiw3Y+MM+2JibWkGhWGHDFhQ2BaAZunYR0DM
	 C9O6I+wU+ZVCGrqbfPYG5yfvVEq7f0W4acBbW1LinuQOGTb1lnHX15FcAqHIdI3xL8
	 AZnqZBMLK7OCn4EB88kq+BO3wVPtjKbkQ+rmkIIcgk7gmvYI8Nv37gvg53oCUUXrH/
	 aaytrobb2U/XQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260403194701.11902-1-rosenp@gmail.com>
References: <20260403194701.11902-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] clk: mvebu: use kzalloc_flex
From: Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Kees Cook <kees@kernel.org>, Gustavo A. R. Silva <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
To: Rosen Penev <rosenp@gmail.com>, linux-clk@vger.kernel.org
Date: Tue, 28 Apr 2026 18:42:53 -0700
Message-ID: <177742697342.5403.5001572934636787490@localhost.localdomain>
User-Agent: alot/0.12

Quoting Rosen Penev (2026-04-03 12:47:01)
> Use a flexible array member to combine kzalloc and kcalloc in one
> allocation so they can be freed together.
>=20
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment right after allocation as done by kzalloc_flex with GCC >=3D
> 15.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Applied to clk-next
