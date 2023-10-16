Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B543374D2;
	Mon, 16 Oct 2023 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVPML+mH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7281C433CA;
	Mon, 16 Oct 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697498422;
	bh=SFVf1dut2cr8mYKcCmXD6aj+47GLfeCnx0HqaDEXnu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SVPML+mHlskrz/hcDe6t9755ktQU+hgAG2RiODOuou49uaHEw/7FeotV5ofrFEuoM
	 GmEuYREFSeg+YexJ1YC5kpD/V8Ynm4LBxkRhaA83ViNxq5RE6p7qjJHz0yjeSWomKH
	 b6yX8BDRHhT2bf0iGElPdNQRvYALnoy5rXK3+P+OF5Nw2HzHtXYC8rlETzjoOT6rV+
	 L/qQIt+ZJVgQ1S1Cem6Du7i7R0hsTDkXve1VrF1Ih0uRsGj+QnZqUVEOpjYhHKPKXk
	 6NkkzOlie8dToXSWmZMVTBoOtUTCwX9omTdq42Nr6bltDTNZpvZWQ6HxGhXSLdwLYC
	 rb8oxSsRLihng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBA1FC43170;
	Mon, 16 Oct 2023 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: netcp: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169749842182.17995.788376629952172297.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 23:20:21 +0000
References: <20231012-strncpy-drivers-net-ethernet-ti-netcp_ethss-c-v1-1-93142e620864@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-ti-netcp_ethss-c-v1-1-93142e620864@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 21:05:40 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> [...]

Here is the summary with links:
  - net: netcp: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/eb7fa2eb9689

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


