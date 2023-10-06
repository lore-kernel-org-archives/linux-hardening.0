Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47415BE;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US1ViA3L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20FDFC433C8;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696556426;
	bh=ZHhwy/QHQKjO8JjOgoHcu01ousohyctGzcyeY+52kKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=US1ViA3LzYovQRX1B7arGfXz3AFtGzwIzhCB927yLRcRgfTuJO2iPk/BU48BhV0Gm
	 xWUN92DpslOGJE2jwVnc0H/YeZiLj1YziEEg7UyZBTppTeNTcmAQaadHscBs9vZ7no
	 Z5J9lQ4nl92zCCFT6CsWKJ7xEoxFC7TnS+tiD0gU823lGBIQM4kTSbrc+5ZKD7Zyxw
	 HR/2p+irzqQboK4Y69UvYNfRCW1MfW8MdJCFD8lrywZOiPg2+pPTwKBvxP5v0dsTp9
	 Tmf50jTjUqAwoO+wBsK9yIOt2rR7hEcgoMtoC2sK44FlrY2gNS973ZZxzYl5dO+sKO
	 jWL7veN/QmMJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 038BEE11F50;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nexthop: Annotate struct nh_res_table with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169655642600.20160.10641329259797936886.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 01:40:26 +0000
References: <20231003231813.work.042-kees@kernel.org>
In-Reply-To: <20231003231813.work.042-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 trix@redhat.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Oct 2023 16:18:13 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nh_res_table.
> 
> [...]

Here is the summary with links:
  - nexthop: Annotate struct nh_res_table with __counted_by
    https://git.kernel.org/netdev/net-next/c/2253bb3ff242

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


