Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93140222564;
	Mon,  4 Aug 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322259; cv=none; b=Ba1Bm0D6hANhdSw39nxURfxVXKggB8OjLObbaN8UlRKjA9bsPe6LuGDKZsXfqZ9Wldgi9mD59Cm+XhXYcVaIE1Ke6e1kGu25FDnM39caFRipKOe2X+zAARScPPe7/0tLpIUj7yJoAaLB6ptzEKXijNSNThzuCnWJE6WHUrQHHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322259; c=relaxed/simple;
	bh=TZb/AGt0phruGtgyi0ZQjJo0f5T+3Tv8hlN3/JTd/rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epSht34syNz2LJJCRHTi7Qwep4wwjWAeEYwZGDawZypAxMY8BGu0cKA6x/7cqiCfTqsAG70MT0UezCxgcE2zuwyAplbsiyDTYO6VJonkV3r6KI+jId2RUvWO5myiVUnVALwwoAk/8atZNF/lwLBeodflttu/S7IUBPK4FzfhJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRgx8arL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRgx8arL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB25C4CEE7;
	Mon,  4 Aug 2025 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754322257;
	bh=TZb/AGt0phruGtgyi0ZQjJo0f5T+3Tv8hlN3/JTd/rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRgx8arL3cBJtqj4FaQzG3xMQkcfWBel1APTgdYr100zsFtTxqExIBRV85iDn9ejV
	 CLvMeDFRaXW2JlrPZWGinBypBkzJZWekxI961v7206vxSmMNpFf4+zV4M1v18DHJoF
	 cfKlqmVJ876FAtn9TlkY+4Phhw2iT/xgy08tmEFVnw02AlUfkZB8kVTMtdLhy0FB/J
	 gT4fbXHQZdE1UrhIWPpX5M9ZQNZcLuyvGx4+Lbxpp0J6dmwF6EpsNSWeqMIGifUQge
	 6OvGt8OMR7/5EnrNHixz5gTx8ox9YqqO09ZJ0ulJiro3CFch9Q6beY0OmnOeluJjLL
	 7Kk4f0L7gu6uQ==
Date: Mon, 4 Aug 2025 08:44:16 -0700
From: Kees Cook <kees@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: clang-built-linux <llvm@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250804: clang-nightly hardening.config boot failed on
 arm64 rock-pi-4b
Message-ID: <202508040843.CCEFEF9ED@keescook>
References: <CA+G9fYuDtzPpJOX7wdWAf2QmHyc-5v0cZ2Wood8cRwCttuyRmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuDtzPpJOX7wdWAf2QmHyc-5v0cZ2Wood8cRwCttuyRmA@mail.gmail.com>

On Mon, Aug 04, 2025 at 03:41:51PM +0530, Naresh Kamboju wrote:
> Regressions found while booting the Linux next-20250804 on the
> qemu-arm64, dragonboard-410c, rock-pi-4b due to following kernel log.
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? yes
> 
> First seen on the next-20250804
> Good: next-20250801
> Bad: next-20250804

Are you able to bisect this by any chance?

-- 
Kees Cook
