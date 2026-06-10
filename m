Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F21F03D9;
	Wed, 10 Jun 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053810; cv=none; b=o9k1KcjNC07sgmN6KkaG4HelM0GSFEZRGoysPz+KPF1VU0a2pbpGrOS6/jPNogU9IJnCmo/t6wdFqHPO70qbmKW0Fd2UuSXEEYHC5PEo0vCDwcrfgUCcN0oY22ftA7Ptut+nl/skzmj3TsFhg45X1xppjrmwxe+rOMc1r/XhF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053810; c=relaxed/simple;
	bh=8QpLpLzPLvPC4uLMJU5INnQrn45q2AVf9oXFrRl7qac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvmZIfdpXKW3zBRnhT4/aA5KUPtdDXeTkRsqDKB4QMndYXxEU/ShROzfoC+BUVoZHw04yaAxc7O1yWRhwljhkvMuiPFq3HnHVF178QSqJJOZkzQ9s9VEuvQBYWZYV2PCcy5I2cz0+51zRnh72A5RQ+9r6kqpNdYjqg8tTzpFwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCdqTK0X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCdqTK0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3776E1F00893;
	Wed, 10 Jun 2026 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053809;
	bh=60SZMLMgoA0QP7uKvpMFPOc2ECgoH/8TsShvrqanNGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dCdqTK0XX8PP4u4ozb579TcFiR9xL4/+aUMGW/xNJCfPSBcLDR7aW09sg3UbYTw4Q
	 UslV7lMlCZw+UO/TMeSlza3fc22f7tsPYJezjfPv3x+Vr/4XbKX3Id0wss9VnFf/69
	 jTt9b6Fhgj91qVg3vFM77876vyWXPTxgThlssbwep4VbY5yn7m4otAXv+yKhqO9cvj
	 U+Vz0AoxBHxPSlxR8frnbaTwOrU9pT6oTn7PhcdnbKbdx68msiWurz6rIlD5FjP/gS
	 Zh7g2T+Pm30v0r/8nfN9qRk6XszMLx+GGbVuiDx0yr7/V+3Q3FKeLgPjj4MUequwFs
	 +VoXbUmk5J1Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C73930A12;
	Wed, 10 Jun 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] drivers/net/ethernet/emulex/benet: Use strscpy()
 to
 copy strings into arrays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105380714.2776665.4095184805807613136.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:10:07 +0000
References: <20260608095500.2567-4-david.laight.linux@gmail.com>
In-Reply-To: <20260608095500.2567-4-david.laight.linux@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, arnd@kernel.org,
 ajit.khaparde@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sriharsha.basavapatna@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 10:54:59 +0100 you wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] drivers/net/ethernet/emulex/benet: Use strscpy() to copy strings into arrays
    https://git.kernel.org/netdev/net-next/c/9f9fdd88e9f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


