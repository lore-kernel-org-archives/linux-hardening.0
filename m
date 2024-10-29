Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234320494C;
	Tue, 29 Oct 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205982; cv=none; b=nejcujJ4Ac3BEdq6ZkFiffgNScQ43iPl6Kq5ziYt3AWXICwX4+Ke9tp85myhK1YCfeyUsF9K5yZ+l1Tk2TwhYhyak4ZZ/rvZ2ASDsb0GRJ17d1nILZPAaEMMM8QV2xJdQqmEScr7NolAI+rgUAxo7h0wNTJVxioMorrXnyq5VRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205982; c=relaxed/simple;
	bh=uAj+8t0xewdfbCSl3OHFX3wOboNaulolhytV/WDj0mY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=idmSKrtxktipmToCZoIi8rylBvNKg5YDQjRtRDzz8W+LAmLdbu70Hnb5yhZ7kdVAUbX3Q8/cGDi4XXIVxzEKJROQYP+uADpOxFlq4uFZKyVDj3yVLmmmzkArjb0HOwW/Ad7lflL9RUPLnjgAxQmyU0JybSaB/8iXNnOPnl/jqDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHaQFc45; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHaQFc45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDB0C4CECD;
	Tue, 29 Oct 2024 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730205982;
	bh=uAj+8t0xewdfbCSl3OHFX3wOboNaulolhytV/WDj0mY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PHaQFc45OGT5Ec5I7CSrcxGZC9E3sGVaLjO98aOISj48Bres9uVLnop/zcqOAJTd+
	 bz1zMTepxxB5TEGc3cTRIUSW3bGdEQNFrppJbrzTg6cGPK+ikNkt367hSqqU00og+Z
	 MpeRDXZpd6x85oQlw8rKKVrth0weQJgu0eTR5ctHEl7vlsT3qSYfGRAi4CPHymgVGR
	 250eE7VP1mvj1Q8RH/zSWpaougW2S6Ke8Ctcscga0vDKIpqPguSBQd2OLoTUZsLlB/
	 gm7S2vFX6T6jvtAywSTc320AUpCqkgHcapB6YiCIivhyslvU0X5ho/BVvlLQB2/fDl
	 Mce1wEsJ1EFMw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Aleksei Vetrov <vvvvvv@google.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
Message-Id: <173020598004.42950.8042237651169849553.b4-ty@kernel.org>
Date: Tue, 29 Oct 2024 12:46:20 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 28 Oct 2024 22:50:30 +0000, Aleksei Vetrov wrote:
> The widgets array in the snd_soc_dapm_widget_list has a __counted_by
> attribute attached to it, which points to the num_widgets variable. This
> attribute is used in bounds checking, and if it is not set before the
> array is filled, then the bounds sanitizer will issue a warning or a
> kernel panic if CONFIG_UBSAN_TRAP is set.
> 
> This patch sets the size of the widgets list calculated with
> list_for_each as the initial value for num_widgets as it is used for
> allocating memory for the array. It is updated with the actual number of
> added elements after the array is filled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dapm: fix bounds checker error in dapm_widget_list_create
      commit: 2ef9439f7a19fd3d43b288d38b1c6e55b668a4fe

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

