Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335436;
	b=YUedTYxLYye1r0U1RXb2gbuDdGQwtVqZBcGYeXwMmZOdvVN5fYJdD+ACMlmlBLyRubBD
	 KEd4Gvh6H75Dv5wvr+qNTAbR6EUk0bdLSHbYMDiyz99Y/3QcHf/jQUVDeB+A/1lq1+pLq
	 hASTg94UVppVq+jrIjHPuKOH2GKskhjH25J1GLSZJjTiaLMlE4x/vPgjNGux5UlnSEr5Y
	 9P7jIhRlzOWNW9B2975unkUYrigqjJEN/jvoL4UYgbR/grAyvc/GsMnRSLgcJ5e1/9HOa
	 unESvCmOzZ+jNt3dY0rKDi7OjeRvKRPTOlzTzoSl6k5M48TWwfRkDnFs+Odre84rLow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335436;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=s6BKUa7u4FDMuG4jud5vphMkBSBkv24ieHFnZ2nquQM=;
	b=TWVPE3/Cg5H9jPY7cASeQqhz3nsNrNcc5bVHUexCdXZ7X6UBUU9gm/xtFzyGvnLeN0Xp
	 OuOBhCuXSoMGv2Dyi7eqkSbbSYbFPxFv3vkKNfr5ivYEofBZqFDnCgenfs+3X+kNgB6EP
	 6Lw45nXIPA5MzRJODB45K1DVfNBFlSnoboaMF1JLMwF+F1rqYfPf4UTXLBTSlC9LzCQWR
	 4hEO8O4fzTrfgNx90k1CEJQymqVNGzHKtzly8q4tAI2HE0IqIBjOQ8cyuyo3gGD22EbpT
	 /p1GXZLn+RtFUWtiCswUdulOpfISTGiraCwVgfSySd0QpDXJoZSXhF9v7Vrv3Tt4XoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nmn6jdKu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75CC606A31C;
	Tue, 10 Nov 2026 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nmn6jdKu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5664F1F0089F;
	Tue, 10 Nov 2026 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335435;
	bh=s6BKUa7u4FDMuG4jud5vphMkBSBkv24ieHFnZ2nquQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nmn6jdKu/g7Q54jYIu3uLMRQCPjdKbdcCsMnvk7mnnEeUahUZQ1lsJ7SfIQCJgtB3
	 b8Yv5m6q3sWWeOe0OaAB3zCZaGiov0PCBNo+PuW/JkxXZtIwVAXLnVDlHGVf5L9tps
	 B9vFh7OHoYDGeB3K9sgQ1Mo7eNpQKnzebQoHU/xJGX8U2FjLJpgTI9LmSr01Q72COd
	 c6m43VOOFdS/GD+NwLK2Yfpk3muyw0jrIKU+LTbpjaKlmWxsQ4VXVS9VH2QjKD93ub
	 WTSycRnUHCU1CD0ZcnzhHUYpLUNx3d9on+9g6y7O8A564aAD9gnCDBFB1v3GMSsZDn
	 roI7lxHysPcfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4AA6F39D608B;
	Tue, 10 Nov 2026 18:30:35 +0000 (UTC)
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
Subject: Re: [PATCH net-next 0/4] ionic: report on-board sensors through an
 hwmon auxiliary driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433543409.4180948.5401934262378267297.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:30:34 +0000
References: <20261103-pr46-b4-v1-0-850ab7fbec19@amd.com>
In-Reply-To: <20261103-pr46-b4-v1-0-850ab7fbec19@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, linux@roeck-us.net,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 abhijit.gangurde@amd.com, ArunKumar.Prakash@amd.com, eric.joyner@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Nov 2026 18:14:45 +0000 you wrote:
> AMD Pensando adapters can report board and ASIC sensors (temperature,
> voltage and power) through the device firmware. This series exposes
> them through hwmon.
> 
> Following the discussion in [1], ionic creates an "ionic.hwmon"
> auxiliary device and a new driver in drivers/hwmon/ binds to it.
> Guenter suggested taking the series through net-next with his Ack on
> the hwmon driver, and agreed to his off-list reply being quoted here:
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] ionic: register auxiliary devices from a table of device types
    https://git.kernel.org/netdev/net-next/c/ead2c8476c46
  - [net-next,2/4] ionic: add device interface definitions for hardware monitoring
    https://git.kernel.org/netdev/net-next/c/5794c810b920
  - [net-next,3/4] ionic: add an auxiliary device for hardware monitoring
    https://git.kernel.org/netdev/net-next/c/ae5d56bb947e
  - [net-next,4/4] hwmon: add AMD Pensando ionic sensor driver
    https://git.kernel.org/netdev/net-next/c/007548a7238d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


