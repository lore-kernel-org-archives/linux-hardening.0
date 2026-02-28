Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A331C567;
	Sat, 28 Feb 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772297421; cv=none; b=OnUGxTkhSjJux8XovPHd0EVpFo5IM4VI+MGEslmxVl927FtGxQ2i9b4gjvhqG728L7dp+m/pHNNYFTen70cfrhcihsGKTfEnDRKyP9taB+qj+XAVoqAVjUnOl7hOchbaMvKFvef2h4jG0XJLYs2Gbj/EXsx8kyB2XP66RiUZOio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772297421; c=relaxed/simple;
	bh=Jtih1PWOCZ+K1GrOY7kfg+3g2ib/tDptMKiMPPjJByw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ny07fzAkXf+JQ635cHrm+p2OF4X3y2DeeEgfgm1Z13wki2Rxn0N1gQ5KADIm9bAePoM6XinfA5jim76q1DZYeIvb8rwFG5gMHCu5JFb2GQC+TM5rxyMwCdrizb7Qh/BzSMNjxGlvFg+CivcGsF2Z3Mm/unmGMqb+G4WSvBISLeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtgDaAMA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtgDaAMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB74C116D0;
	Sat, 28 Feb 2026 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772297420;
	bh=Jtih1PWOCZ+K1GrOY7kfg+3g2ib/tDptMKiMPPjJByw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gtgDaAMApP3d4DnbVQ66Xee7x6Rp5iHom0jNAlztpDfVWy2NtlkAq48Xtta2DQif3
	 43ZfBuz3jhBM/kvHk9e5MSdRcRofio65opSOjnslGCvBntE5X0qNvvwuLPJARtGmbx
	 cn6WOjiXsqdFxqMfzY3ETxjcNg9kPRMGa9b+yr0sX59yDExZmXAmCUj4AkOB4m8Zo9
	 d5BFugMpo3fggOwhn5I1EXJ6t60xmW9Dkbt6UZzksZPGFwJuROvv6ak835XSfDvVMP
	 4VPfWknqxUi1gApeR1UQ85QhqKQt2tOBpdT13doe4hJZ0OOFP8p9FUNM3Mg3oNIdin
	 nKDB+5uo+Sb2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD439F2022;
	Sat, 28 Feb 2026 16:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] keys,
 dns: Use kmalloc_flex to improve dns_resolver_preparse
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177229742379.3013533.12869991511362125585.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 16:50:23 +0000
References: <20260226214930.785423-3-thorsten.blum@linux.dev>
In-Reply-To: <20260226214930.785423-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 22:49:29 +0100 you wrote:
> Use kmalloc_flex() when allocating a new 'struct user_key_payload' in
> dns_resolver_preparse() to replace the open-coded size arithmetic.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/dns_resolver/dns_key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] keys, dns: Use kmalloc_flex to improve dns_resolver_preparse
    https://git.kernel.org/netdev/net-next/c/a9a13c7379ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


