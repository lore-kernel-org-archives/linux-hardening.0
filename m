Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63601345749;
	Tue, 22 Sep 2026 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038278; cv=none; b=u6SYR7RsfFNgrMSaXQ4rbWDTruEOUMjzBT0hUVZMl5Lk2hx7Ol0tFFhLzBXRq6jENgYgRfNqwwF7Tye4T07SEp6eX74X+BQmAbUboM17oH8RQEarNUJj4tzzNtGRqi0pyP2zdwN5O51jxpQfRbIXCpPOIlouqCQbwGomIMJzgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038278; c=relaxed/simple;
	bh=XzSxJZHvsyIPqzISR94IT14t1Csx4W3nShPhnVoJAfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iZ1FX47Y8rbHx/hG7lsRcmukatlzqQsWhWwd3wR6/omj6qmmHw0yHMRmetUo6omfl/gYLtL0FMRHUhrVZH94a2A8DT+evP0a/j/c/xNUP/8kjzD7ARrA4OSDrN5EKF2FgOZ9p3bAakCmnHCoTPhA9XV5GWlW96vijd8lILq+/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7ojIg1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7ojIg1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045701F00893;
	Tue, 22 Sep 2026 00:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038277;
	bh=r5VfZtULYvjtTsmEkLHPYALq8ZHkpgK9hA2tzSsU4y4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J7ojIg1KXNJlHgPdH7Na58GWYoC79hvj7lnPSOieXouGEhlDaEXgWuiDUsUcLDJj3
	 IaePqp5sNCUZzCzDn+jKjyZqr/0IQKUK8Ox1du9KbfJN/gwuCkUrWA7ns+hlrShdIG
	 XIxH9VO6pI6GHGp396ePI97PRFnANeqyxiFh0oRKpVhAx/erwA8yzeLpmmD0d5n6zi
	 jWSrJgxalqzdgNtca5mKEmqILu53h9XMS35VldlHFj3aDGn5TMTqerfK7fVA7I2AdH
	 BUHOzR1IM7Q7LrIFu6Zrb3Hn8G+b16LQwwZaPGmFW1EpM9+naLcrzsLnWIAXSv/z28
	 2HHAFkagSuKeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939D03930205;
	Tue, 22 Sep 2026 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: Allocate ikpu2 with ARRAY_SIZE()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003820839.3312649.8281570164450619397.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:50:08 +0000
References: <20260917211409.i.425-kees@kernel.org>
In-Reply-To: <20260917211409.i.425-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: sgoutham@marvell.com, kees+treewide@kernel.org, rkannoth@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 14:14:10 -0700 you wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Allocate ikpu2 with ARRAY_SIZE()
    https://git.kernel.org/netdev/net-next/c/bfc9df9e40c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


