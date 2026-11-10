Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440836;
	b=Cv+0XqL0a9w/AhotdlW0onlRIe+5yJIAZK1idHUApp5SCyWqY40LtXu2VK5lxiSZL5lT
	 ylMhavhYV5v+gfUL76EEoccJnI6FmbRJ48GEib01rrQx15pRLQ5m2hRYDULufIzWEM4n2
	 xzeu1t3eeK2Mh0NxwmeagSi+H5jifmRBFgj2i1+viyHjsFeBvRK9vwxtsv0ng3jVdkT4d
	 nOA+KSijnlyA5RQEaqc/hGfeZSIODJyd3CmnUdBfxjW9Io5n2eZ2d6zEwyFoWNK4scJTo
	 fxBWId9WUltlMLR3hTqeRXl6SYHZ9IPg7MzYmbcHBpLcL36RvhjXupXcvi2QN9pacaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440836;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=xHbyHuioBIGf0RlIQt+BtCTaaBXKA9z4RA+h6F/Zyag=;
	b=QKyxSJ5UNWA2vJOiHRryoQ1QrcSD2EnshdugvAswvDKNYT3IspcwmrZ0fzDX/JEX8QQI
	 SnFLnzYOZ1AfG9Q4ufIAwMuYyLQQgntrMoY6EZzx+kOXySDtTpHLz/sOm6B8GpJyPPe0K
	 OLq0JIopkMah/j4KCxoGqN+iU8zwlvT63nMuqpqpzvlbZOWCZZAIKcCi9imvXXBvlPtPH
	 4P+x+ZV6qD4/C1wTqf6HzssODR7qEeTFXV91WzJ3VsqcJ7kfvr6PNQUdumt0mpPnohjNC
	 YVfP0wERn1cG906jp9CB/Xg1888NBesioSe00anIcg7sFqK9ddY6OTGnFbEt5LBxqug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkKiQyvN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C57606A336;
	Wed, 11 Nov 2026 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkKiQyvN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55FD1F00A05;
	Wed, 11 Nov 2026 23:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440836;
	bh=xHbyHuioBIGf0RlIQt+BtCTaaBXKA9z4RA+h6F/Zyag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mkKiQyvN8ZZCMZfPxFad71oFuPH9BmsyREualtPqwgXmpqEiaqp96ftanjbsr7nw9
	 s1dSL8+wXKzYvc9B7uUIZLGoYOwputC7BWQPI3bnqLdLjuVKEtSUZNIuIiJ4tK/JYs
	 cmrHJks4CG+4uorDPpZb54gQ0pJPtVsqkVaFUPUEboRXhfJxxc7xj4vLxwgQFk3pmB
	 SMkOwBfSHawJyeJbwD6Le9PO3nae2OuxeuIxfEDqiXvxcFGNO8e5Wh7IK0GAXx1XWd
	 K5XkiYUNUtupfSKuQq2hUx+hgXCmQAhE9/TUbFXjnlYP8DaZ8F3QVhtDl41lXdxPhF
	 EPrC6qkBecfBg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 344133180A49;
	Wed, 11 Nov 2026 23:47:13 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH] ASoC: soc-core: reset rtd->num_components after
 allocation
Message-Id: <179433275081.125181.11084186158708006210.b4-ty@b4>
Date: Tue, 10 Nov 2026 17:45:50 +0000
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fcs4qASP8MpkKr3Vxee85rgke2DVVAlTvbo68ARJbc4=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+/Kv6ujjIY2uPUcTD/eInNlSZ+Fhx8C1X/unQtl5kn
 tax2RnBHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIy3sM/+M53tlmtv/ZtWtW
 AZPt55N1MuyXuVeq86meYDR5Kdy8sYXhn7beiykHzSfGK+rHfdjgZyChyGnxwCU8df36Sz47evW
 leAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 09 Nov 2026 11:25:20 +0100, Emanuele Ghidoli wrote:
> ASoC: soc-core: reset rtd->num_components after allocation

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: soc-core: reset rtd->num_components after allocation
      https://git.kernel.org/broonie/sound/c/d00ba321499c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

