Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB55212D6A;
	Tue, 18 Mar 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315343; cv=none; b=Y+/Et7Uvp/MkOqRIbZkdHO+OBZKk+7iEYiUv+IIePPMRYlKc2+P/fIyUHSDenOOA9vqxT2IJ+0bryUfTyHcvyVbft9kEJs2NRuGVxrG8iWBGtHmdNC8dN7DJZZccUggkIZPWhCvw3xqHBusXm3dwjDYGYe0jLjw0/HML3yL7ruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315343; c=relaxed/simple;
	bh=5Jml5c4VhYCK9bsIj128Ieb0yao7Oc8nLd57R5iqpS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YQXTmxy9G2ZzFkarLAG0MbXvNsMtjULXkeKmrKkeOer7BGU7yRyxr9p5mV6DnOk/w+kzrW/mAqHKo6EjTACTfjFKCCBwuVAx3haaRoujWRicJ+4FVzOBWSjHf5hdnuUiQYQ89shwkB2kSOfGISCVvNa8OX+TSc3jCjv8FvrbxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZn0QwCK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZn0QwCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37D7C4CEE9;
	Tue, 18 Mar 2025 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742315342;
	bh=5Jml5c4VhYCK9bsIj128Ieb0yao7Oc8nLd57R5iqpS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DZn0QwCKmzootjfnvX8YvEl3sCNcddZXVf2WwOmHsCMJS2xIhRWqgf9CQ4H+x+a9R
	 M0qEeOo2nzJml14Ela4LPipnKAxRo232IVXRvdubYRTRD6/FuKdtcyY2eM+sBPoCJg
	 vM53YxSPgrKoMPoYIu3Hk9+ABYjJH0+rAv5JFdSQyYnvdY2iA0g9+D1GGsx4xTpycR
	 +l2zRlTlrwAZ40QW0aiqdJAtF3GjBQCm0DADncr4j4DKyQmkz6uHA9FC6il+9rfYz7
	 DZ92lmHszFUMn7KVQlv0siolYHPhDB7lWOb9vGVmELBYWvY+Db0Pf3qnwGJLdH1GAh
	 CkoshxFFDrIYg==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: gustavoars@kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250317-sound-avs-kcalloc-v2-0-20e2a132b18f@ethancedwards.com>
References: <20250317-sound-avs-kcalloc-v2-0-20e2a132b18f@ethancedwards.com>
Subject: Re: [PATCH v2 0/4] ASoC: Intel: avs: Replace devm_kzalloc() with
 devm_kcalloc()
Message-Id: <174231533973.179247.5473589269509240114.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 16:28:59 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 17 Mar 2025 08:21:55 -0400, Ethan Carter Edwards wrote:
> Open coded arithmetic in allocator arguments is discouraged. Helper
> functions like kcalloc or, in this case, devm_kcalloc are preferred. Not
> only for readability purposes but safety purposes.
> 
> The changes move `devm_kzalloc(dev, sizeof(var) * n, GFP_KERNEL)` to
> the helper function `devm_kcalloc(dev, n, sizeof(var), GFP_KERNEL)`.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: Intel: avs: Replace devm_kzalloc() with devm_kcalloc()
      commit: 6d9d66626c58bcd9b949574aca7d47149b8ad9e1
[2/4] ASoC: Intel: avs: ssm4567: Replace devm_kzalloc() with devm_kcalloc()
      commit: 61b1a1bddf7d166946d7ca7054b6cbced29b72f5
[3/4] ASoC: Intel: avs: max98373: Replace devm_kzalloc() with devm_kcalloc()
      commit: bde479694a7da7c127bb5bba98e2e4773f1d7951
[4/4] ASoC: Intel: avs: max98927: Replace devm_kzalloc() with devm_kcalloc()
      commit: 3602571baf9a6864bde89422d179e422a3ea4d8d

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

