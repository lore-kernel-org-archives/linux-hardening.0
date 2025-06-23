Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA71F03C9;
	Mon, 23 Jun 2025 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661504; cv=none; b=DRRQEyls0opiaQeP9tFmC6mM55/NOYw9cqOhzhhV/b4raT7LKoVxxGQOCNo7jPLouPxN+4om/rSmUKD38QEuuy7rlw9VxI6Uu+jmU/ZRYWs9sKm5FEc4KBqqDgp7+eGEgFftaIDtONENfLOB246YzEwF4VAi4ytBEJ1CI92WZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661504; c=relaxed/simple;
	bh=ZuaLAdKRfPAdGUHn3NKcVTxk2HUa+m9Hw4T4abrb8EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da4SnbvtXmAk+sN+Pj5OIt7krT31gn2evuQ5qlfQXGkgqWalokBt8Fjkfsdmv+bodCT6PlCg0UsKPbuKWsfDKgHXDBgWOo4EW39ea0ZiWw4LvwApWqTntF7ajgUXVsOhSOnyEhobzrcLhrO5Z4Te8v0iReLx/SC2U01LjbZ+m9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAJB5ud7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAJB5ud7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E22FC4CEED;
	Mon, 23 Jun 2025 06:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750661504;
	bh=ZuaLAdKRfPAdGUHn3NKcVTxk2HUa+m9Hw4T4abrb8EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAJB5ud7df4WHSt3qvvbiMgFs0bU1TsVomAUHTFrZBdRfDtDx2EnPDaWEOu7nONZa
	 3o1z8AOoPn83Wz4sC6+m9IKd+jWakluYHuiQZKu7puKbRaK/kdXdEQ0dCbSD0TeS1F
	 qJwGHJ+vhngq6rMp/K823ekkNr3sj3dhJqz30veTxqEku8VGqpM+bN/E9MursykNbQ
	 CV4KalKsfVQRntrN/eLY5KFze+MWqTiSAHu5G2+fy7qbYu8UGKYRBKd+5041HdO+St
	 +eizmKWYrJN2X/tDNElbR4Dqy+M+T0joPRk4tGI3+Oe1IZhjVhKPhSYC15o+4qQt+c
	 kw8/3TvteTbuQ==
Date: Mon, 23 Jun 2025 06:51:41 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Naoya Tezuka <naoyatezuka@chromium.org>
Cc: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pstore/ram: Validate ECC parameters against
 Reed-Solomon constraint
Message-ID: <aFj5faLZXnKKtyxA@google.com>
References: <20250623062827.133373-1-naoyatezuka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623062827.133373-1-naoyatezuka@chromium.org>

On Mon, Jun 23, 2025 at 03:28:27PM +0900, Naoya Tezuka wrote:
> The Reed-Solomon library enforces the constraint `n <= 2^m - 1` via a
> BUG_ON() [1], where `n` is `block_size + ecc_size` and `m` is `symsize`
> for the pstore RAM backend. A driver providing invalid parameters can
> trigger this, leading to a kernel panic. For more details on the theory
> behind, see [2].
> 
> This issue was discovered during developing chromeos_pstore driver.
> Link: https://lore.kernel.org/lkml/20250610050458.4014083-1-naoyatezuka@chromium.org/

I'd prefer to unify it by using a [3] or at least move the tag to the end of
commit message.

> Add a check to validate this constraint before initializing Reed-Solomon
> codec. On failure, return -EINVAL to prevent the panic.
> 
> [1] https://elixir.bootlin.com/linux/v6.15/source/lib/reed_solomon/decode_rs.c#L43
> [2] https://www.cs.cmu.edu/~guyb/realworld/reedsolomon/reed_solomon_codes.html
> 
> Signed-off-by: Naoya Tezuka <naoyatezuka@chromium.org>

It should preserve my R-b tag as v2 doesn't change too much. Anyway,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
