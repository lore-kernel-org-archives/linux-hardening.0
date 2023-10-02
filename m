Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D091A721
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 15:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6A7C433C9;
	Mon,  2 Oct 2023 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696259848;
	bh=tBXplhjLBUVmn/j4ZoUk9kfVVHtW2nJRQ5brH7z0kH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LBPnyMGbql6bRxwdrjfUsJuOtPhRl4WUZglBOH7y/JjdWMYw37+xy8QaCfBNLYyjl
	 DpVF8IEBmnDA6GMAWIC9WcNi6B4KmYPZKLcx2/vdQ27HZ3F2lumHq3ors8WV6Wkm4n
	 uVUpEVrrWgHzb3B4DXbaOAqvBGPmrKqj+ooSX/7tXrGeVrHHY+WzLaaf90N3W34kv5
	 ol6OMH14+oTEMk1j4axFNjTpAu88KZHReH2R3+shMuxBfdskOmbJMJNg6bRq9jRyWI
	 BovnntrLB8mZUAM8fPbilce10pbReLOxdOu685/C/B2OfOWsM/nPV14KH/lufK/W59
	 uqxLKIY8njs/w==
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
Cc: sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <ZQSr15AYJpDpipg6@work>
References: <ZQSr15AYJpDpipg6@work>
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Use size_add() in call
 to struct_size()
Message-Id: <169625984488.65718.9772394979337795498.b4-ty@kernel.org>
Date: Mon, 02 Oct 2023 16:17:24 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 15 Sep 2023 13:09:11 -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
      commit: 3746284c233d5cf5f456400e61cd4a46a69c6e8c

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

