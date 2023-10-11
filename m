Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33507494;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS7Xn5EX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 590DEC433C7;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696993826;
	bh=qYTdkncRzmHOiS9jUcZB43675WSOE6NXjgbzHK4ZwW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DS7Xn5EX8HbO7muP+OSDVFik1rg0yLxtdfDInizQAcFe6x0Q47p9U8D0V6+6U84ts
	 1XOO/jCa9xRtycBb4Gjf2kSUeV+woGctGTHf7AdLBIvfjsU3NgIHb7rTtwmlwbf2Z0
	 dvybZTwTjszQoU2fD5e6mrRvEhr5tUE1w+lE/0EQ0ZhgX5AJcrHazRuFbJqCi8qynH
	 PaIgrJoqrFKWtsjxaFlv4OElQ9kjJPfo2CE4E/RR/l5ewbLUbg/Em/Hkm2Jxt0RU1k
	 TBRNNH7w8JClXVkgFuZ5m5/a+men58tW4C4X35vYnlZdEZS52YSp1Z/EpBA5/7r2L4
	 nwe6pRd3gd8dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40FD8C595C5;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: realtek: replace deprecated strncpy with
 ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169699382626.3301.16765588346169331676.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 03:10:26 +0000
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Oct 2023 22:47:37 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: dsa: realtek: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/b0e4a14f5ba1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


