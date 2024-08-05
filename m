Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A215F30D;
	Mon,  5 Aug 2024 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879467; cv=none; b=C4Iv2VAaFlHAhIwhCPE3DxfXNv1dXUcWh8ifyhv3sUstek4TvwEHcplo9HGkLVGl7odiWc3EKQmXOP1XfSEskjrusGzC9lfa80fqAkW/QK24IWvXsD2B3Vj5+fF1e4UyDxMcEiy6c4BaDpqgclh3iHpWtGEvdx6Oy/zVgSgDvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879467; c=relaxed/simple;
	bh=JIGgOS2dCgTDrX3lTsYGuJfpVwJU61RQ1OJxNXDBCYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i+ZlNuMw+9v2/crO+HTpOzITec9dl5tZgFnM2aM0xClpit3m+c7W/NzjkZMp/v1ZhBrqap51JACfCgVt0eVlM3rH0RI8jbIYkA38xanU9bgWEIjR8vJ9m1Qfpp4Mq0sXc303BPr4AT/opHquAZqTucqrLY4d2+abYPCmiMv7L1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vvivqelm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvivqelm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0263C4AF0E;
	Mon,  5 Aug 2024 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722879465;
	bh=JIGgOS2dCgTDrX3lTsYGuJfpVwJU61RQ1OJxNXDBCYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Vvivqelms7v+wTRT/e57tNZXSagGa2ZZBLXLYVZEy5f7k+onoJOPxiy1A2tCz2P17
	 Sqd5bATwstmvw16c4hn4ffAx+GlnmC55UIvtqmiM7uuo5+cLWZMCvV4lOkjcIVhMfw
	 D5SVNWigi5owMO1ZuQuQi0Ak4CLfKbdWEX9k3UoA5rbUzsnjNnUy5y1SDPQjd2F1eM
	 wqBOfPgV2D6tmoaJkfzURtur14sqJut3eRlDFx9HDMUo3IIW7p1gCVF6NFFsbQmROB
	 XeHpkmcz8uZcycHZRNEuDQkcbsn1K/8b+nrWuIAnFWgvQ4QVhKAwxwd3Fxi8qwXGfk
	 qraozYsu5cpBw==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
 Kees Cook <kees@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, dmaengine@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20240716213830.work.951-kees@kernel.org>
References: <20240716213830.work.951-kees@kernel.org>
Subject: Re: [PATCH] dmaengine: stm32-dma3: Set lli_size after allocation
Message-Id: <172287946248.489034.17199555217262087392.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 23:07:42 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 16 Jul 2024 14:38:33 -0700, Kees Cook wrote:
> With the new __counted_by annotation, the "lli_size" variable needs to
> valid for accesses to the "lli" array. This requirement is not met in
> stm32_dma3_chan_desc_alloc(), since "lli_size" starts at "0", so "lli"
> index "0" will not be considered valid during the initialization for loop.
> 
> Fix this by setting lli_size immediately after allocation (similar to
> how this is handled in stm32_mdma_alloc_desc() for the node/count
> relationship).
> 
> [...]

Applied, thanks!

[1/1] dmaengine: stm32-dma3: Set lli_size after allocation
      commit: b53b831919a0dc4e6631ebe0497ab2a4d8bef014

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>

