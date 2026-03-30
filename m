Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573E3EC2F8;
	Mon, 30 Mar 2026 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910552; cv=none; b=k6w8CmG9rgpnm8c9GupQFHSOph/yGfWI+Ejpl4tJ8RnYkZu7ke4VPqjC6p2K/EmcHXL8Wl2OqvoS9+dZF878+K7+6TZxC45afN/npQ/zrh+ETk8bDA2veG3zsoGAk14GHdph4JnEOeByviitdT3tYp1qyLQi2iaGLEqJPFK1bno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910552; c=relaxed/simple;
	bh=V9lVea5HpUKO/Cr6B805fKYQpU4Kqye/hhllmjbj1lE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KGYcpZL/3xOXJ5AqdLxuVETrRBMnEOjNW5IKVUHn20BA1PJfS1T3RAOKzxQPBs/n1h9dh6dxzR6dHxpU2UFZldLrYNxPBLtzMAm98lpeVHHs+JfMxL7nkYeapobMg0A+4kEsaU3rgSDhn8CzqueANxi/D6t8302b08VFicagRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7y3ltqp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7y3ltqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AD3C2BCB1;
	Mon, 30 Mar 2026 22:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910552;
	bh=V9lVea5HpUKO/Cr6B805fKYQpU4Kqye/hhllmjbj1lE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q7y3ltqphwEflxX3mJBV7UZNJfL1BggiZwzu2LH7ZYc/vOU0Qn+C6DWIhu727lzIg
	 Oge8UjVSPDkOG25mwgcEMV6vJTlCXK/9ekT85xopNThFb5rnn8QC8HAfncA/ssiCjS
	 IcsIx0CTY4sQZapVYKk7wIRgMidY6uTV3vjFwz2yYfCkXGzomEGy2JpQyaVQQ8GtJq
	 /mATvRar+TmM/bQicDv2BVCjiDddPgKCTyD5Hlz5dSOHnGfWZ2yC0/Acpl2ZFDn/Fn
	 3u7/TD3sFyVHh3twynzHy94aWQrQRLRbS+AWrXEXzGkln4v+mRLA/9rNBZdur9bWVT
	 Qll05DBruZIsA==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260326023053.53493-1-rosenp@gmail.com>
References: <20260326023053.53493-1-rosenp@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: topology: use kzalloc_flex
Message-Id: <177489791033.241608.2454580256127378749.b4-ty@b4>
Date: Mon, 30 Mar 2026 20:11:50 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-3ac6c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=broonie@kernel.org;
 h=from:subject:message-id; bh=V9lVea5HpUKO/Cr6B805fKYQpU4Kqye/hhllmjbj1lE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpyvxUxujB0/aH2zlP7Cx3mRJsLIkdw20wII804
 7vgjMa0l0yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacr8VAAKCRAk1otyXVSH
 0AjrB/sF2whXH2Cl+PVEh5oOykLJIoKy3ESJ+nmNhvaSocTUEVdfA+3IWpTWzIislBxXL06tLU0
 qcIijZf2fC+ceNVMTT1InzV91nv+FMWXECtOCEy1nG/mHFqxTetPUdMf+uEGSbaxiIsHZoxNUS+
 DDGXJze74C/ViBbpipG0Z0J/C+0dkMH9xOM3T6D4939IuML+EWWugtvfpUza2zmgBkFNaUi1iy7
 baCIkNU0mbIp8rgp6guw4lU/Q6AqCpYUQG0Sw6Y5ID/SC+Td4OLhhCaBl2F1zumxOc3a6wG9JJE
 wEQfAWdH8M+WLUMD1CDzpwVUmjdxEUnRqmxlrewoVKNLyfXb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 25 Mar 2026 19:30:53 -0700, Rosen Penev wrote:
> ASoC: SOF: topology: use kzalloc_flex

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: SOF: topology: use kzalloc_flex
      https://git.kernel.org/broonie/sound/c/d3d75c767680

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

