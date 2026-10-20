Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531815;
	b=Sxwqq3itGX9GiJKjIRKPVKrtf8MMO3pvNsKFq3hdA+uJBBO2fG0ULNURV+rsErX4tib4
	 LMgqi19XERrvSWlyKYq7MdhW2fR5Ro+X5yw1cJ5tfv7lbYn/jiRmrRW2Cx3rN4lXwl5b7
	 jwL3AIy9x7ofYdrZQtEhBf1MdnomeRoWbenIvnLTXO7yIPBl6D6AsLhs7NJxQIoSS/07q
	 s6sHuBVd3nqsCmK/X9RmDt+n9aJWkjG/20jnYOLPNIMmBNawQe19DB44tmhOFo5BaEsbq
	 mMFFMAl7l1mWa5DQdqDBUr97phXwzjgF+BAYFkAeBKb78v1gNrWePMrRwkZs3IHwdCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531815;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=J52yf6wiclMJabmxnVaoIJf0AuS/MM8eQ4Dlsmc3wb0=;
	b=k1Lq0Dn9O6Dch9XTydDH/qjPRYTSCOqB2egSEgmTN2E1qplFWdG/g2mnTfUF6SAWzd4h
	 QlAhVNopKSnrQ6I07oGbLHXRyFDn/bUOMcwA+GCJ4gDo0hbQ4d2fdUtlwNd0zeQ8xyC/W
	 cZroUNYcUVp8SsEw2j86c8ZGZQ8MVbPIvD6o0LqLGoa38p7J/rKjLxNkjwUrPlRiAVVg0
	 a2VHwG/G/xhFEWLoLfOsjWnV0oJbao3KGOcn2iK7nooOcfaUDQ+hfU0NG01Fb0qQfqFUS
	 5hyyqNTpL9/R64Nzk1x3ffc2EYdS9lYCcRpi4wDz+WlVB5ZAD85HFMOfYQZ9RC1yUhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHQ8yZyY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FC606A31A;
	Tue, 20 Oct 2026 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHQ8yZyY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831311F000CA;
	Tue, 20 Oct 2026 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531814;
	bh=J52yf6wiclMJabmxnVaoIJf0AuS/MM8eQ4Dlsmc3wb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eHQ8yZyY84tatF7KM3DslRXtYQ/9q92pR66szqcqv1y4RuBbaoL/hkQNlQAiAYV3G
	 1/DsF4EMJH0/K2jb7WX6xk2kaCLC26gGRGY8ihRYOYzM3O4t018jieAkR8WaVWS9jh
	 qE2ztadEnGw3u0vR7dr6dWUOYGd5bmkljGN5nOFqyPF2SmOkQ7eyiGYsEKHkJGaweH
	 k8g+Ohv5R8CAJK/hhyOOnSJeMeu8ZTaK3nR+CqOCDYt99YgOGUDopLK4wYAjOY9lnz
	 DnYFYV8IT5FlaMZS4RQmTXT+/dqRQVLbSvWu+BX7GtC9t3/y9YovoDWY3K2AmmmW8+
	 DontoGP5WKUBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773E03809A09;
	Tue, 20 Oct 2026 21:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/7] net: mctp: usblib: Increase coverage of
 kunit testing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253181301.220085.14897480542454867780.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:30:13 +0000
References: 
 <20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
In-Reply-To: 
 <20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
To: James Lee <james@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 12:47:30 +0800 you wrote:
> Current usblib tests only check receipt of a limited combination of
> packets lengths.
> 
> Added tests of receiving packets with invalid fields, and more complex
> packet spanning. Also created tests for transmitting packets, covering
> most code, except for mctp_usblib_tx_cancel() and allocation failures.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/7] net: mctp: usblib: Add to parameterized kunit tests.
    https://git.kernel.org/netdev/net-next/c/acfb9c263d70
  - [net-next,v3,2/7] net: mctp: usblib: Add test for splits inside headers
    https://git.kernel.org/netdev/net-next/c/21e1d4515755
  - [net-next,v3,3/7] net: mctp: usblib: Add tests of invalid headers
    https://git.kernel.org/netdev/net-next/c/c0a372f72972
  - [net-next,v3,4/7] net: mctp: usblib: Complete rx tests
    https://git.kernel.org/netdev/net-next/c/40e59c00ae21
  - [net-next,v3,5/7] net: mctp: usblib: Simplify allocation logic in mctp_usblib_test_rx_init
    https://git.kernel.org/netdev/net-next/c/77cb5c6b3464
  - [net-next,v3,6/7] net: mctp: usblib: Add initial kunit tx tests
    https://git.kernel.org/netdev/net-next/c/1e12f734afc1
  - [net-next,v3,7/7] net: mctp: usblib: Add test for failing append
    https://git.kernel.org/netdev/net-next/c/9e061caa3bdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


