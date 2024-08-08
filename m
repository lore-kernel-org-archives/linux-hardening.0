Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF715ADB2;
	Thu,  8 Aug 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150610; cv=none; b=r6QVW6OwWF1M26dmeFpAaC47eRF2uOb0YFblitsV279fD9n9uj57phfahn3laO1QALex0fM69i59sH0kvvnBgv2pFHmsV49cB1ZE0+6gBzjeDneYTlblcaDFZbBdX7JPc6OVQXOwawPcE1W1R1KdDnIp8uWZDdhNQNBbVyYTMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150610; c=relaxed/simple;
	bh=SoRy9XQ5m595Z06QPPUpBnO7PMvDOx+NC5AOk6JjJdI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JfOzukrapqERi35w0AgUqYDn2EjEY37OoSB4Wmeo15YqKWAU/Qdq2M2YVOnWBafmStAZb8p/Wsl0aVs9hd1uFomWr0+fwyDbuuP+JNH5QJo6HOvxFtaveQ3+JBUm7i+CZaBgYdh15+gQTq0lrYmMKb/hdA1SzU8CBmIijapd/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRuKco/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRuKco/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A606C4AF09;
	Thu,  8 Aug 2024 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723150609;
	bh=SoRy9XQ5m595Z06QPPUpBnO7PMvDOx+NC5AOk6JjJdI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SRuKco/Wi1ZDoBXOSxgbf1U6yURfzzaIuWXzlntBDYCrDBbUgxviwHtOZcv21nGl8
	 Mwq/vB/LnzUbM45cdxUbo3iGkoUJUrwtqy4E/HHc8ZZcXHBUDttLpH6kzkNoDOyHJ3
	 TdC/1FeAQjML0r8hKqy2CQXtvtZVdi2WxNEJjqcbVcndJtWp4YbbG58Z5U7xS7+6oL
	 bHCOPdZcDu9xupWuC+L0goH0Trz/SUQrNip8VG4Y960JS+Iy1c/dnZn6uXWn4aWwOb
	 SO0FOEPZ5L667JFgheF0MByK5kheVywUKB7p2EwXjGIyuV/pUstOhJ7OWj/fOrk9rH
	 1QmIJP2q0WsLw==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <ZrDvt6eyeFyajq6l@cute>
References: <ZrDvt6eyeFyajq6l@cute>
Subject: Re: [PATCH][next] ASoC: SOF: sof-audio: Avoid
 -Wflex-array-member-not-at-end warnings
Message-Id: <172315060254.475406.13914389437714489725.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 21:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 05 Aug 2024 09:28:55 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct snd_sof_pcm` ends in a flexible-array member through
> `struct snd_soc_tplg_pcm` -> `struct snd_soc_tplg_private`.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: sof-audio: Avoid -Wflex-array-member-not-at-end warnings
      commit: 5dde0cd2433dc6ef7b82e04276335137cc4c3105

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

