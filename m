Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523462D052;
	Wed, 24 Sep 2025 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672036; cv=none; b=ciVdroBTLMvGIM4JWDzf6vpPS2BXvdNsPu2mzguAQ80weX0VcCOC5et+F2npYd/mO+d8NormHRzEeDSH6yXLTzQgmYLFnV6eI1azUZ7FtL8ZzSuTEzaaLO+W5ICyKdGBCOUzDq6PdNwfJTz4idEjcHS0rzjCkEQJRwuBArNPJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672036; c=relaxed/simple;
	bh=XQ5387VeiqYIFOjg5vsVPE0sAGAoAH+TzEKOi3G8ozg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ExEOp+uLV28Ze/h2NXHscOtWPXGfZiXuAhubb4FuZtRJWYeKL/VKsR56oe7UitjyeLNvkAbDe1yotI4X0oDfK5HzDkOauRp71KibRugt22z96OOhwgoMHZrxDMOAqD4XMpRCvM2sYlNYtKyKBmmVL9V+UY+2Evb11pDb2Q7GLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MECXLCPM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MECXLCPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D800DC4CEF5;
	Wed, 24 Sep 2025 00:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758672035;
	bh=XQ5387VeiqYIFOjg5vsVPE0sAGAoAH+TzEKOi3G8ozg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MECXLCPMCnMxpgLiTlcLvDpbfa0px1tjSHHTSFplWTRDBWeU3XsNU+1tF+K8mfjpq
	 C+bbjQ/6Ui6sHDgbF9BoZQLSeo/VWyapteTvT7tZRW4VqfFyKw+0N/v8TaRkAZD3va
	 DMHUfsP/3d36twR6tNdPWkt5nom+bnJZzZzyQHJJ4BQ084sGl/f+T074bpWv4DUSeP
	 uOebdP6LYrC1RidXi6rVw7ZL9aRMyDgDPwKWeU4yk+JHOixHw7QK9OitEPV0+vEvkK
	 PnEbiqpPOFDFl96zBshZtq+Fq3hYr6m81CEiwnN+l9CQvKGsDJsm7LGFGCR+nC9Qnj
	 czB9EeMXWLMnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16839D0C20;
	Wed, 24 Sep 2025 00:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: airoha: Avoid -Wflex-array-member-not-at-end
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867203251.1967235.16855989267443539182.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:00:32 +0000
References: <aNFYVYLXQDqm4yxb@kspp>
In-Reply-To: <aNFYVYLXQDqm4yxb@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 16:08:21 +0200 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that `struct airoha_foe_entry` is a flexible
> structure, this is a structure that contains a flexible-array
> member.
> 
> [...]

Here is the summary with links:
  - [next] net: airoha: Avoid -Wflex-array-member-not-at-end warning
    https://git.kernel.org/netdev/net-next/c/09630ab91d84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


