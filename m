Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF46128;
	Wed,  4 Oct 2023 17:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E09C433C7;
	Wed,  4 Oct 2023 17:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696439690;
	bh=OChQRgMpKKiJhEsPPPkrmvB+lR0zGT+Qobq2Mq6I6Qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FYabR7fWF3KDMfynzlv3jmlC69I/uZx0XOiLkUQk5nHGGn619LXB5sbiZmxdihmoz
	 xCUOowb4epg7Jab4A51ETsR7II1grYC5bEqpPcwq8WrM0bWrjbhl9Fsx0HSEyqNXxU
	 1A4YjYBHqxv08D8H1/8FZNozVgEwYyKyp521Epnp6x1WR5GattIBBKJo/MZOTCEvQY
	 51ei3kx8p0LV7Jq7ToHDoMZK7wmic31cGHdngCqtOG8LfW2QLsMinNSu7FtRrcFPXR
	 hFWmk2VVnqbH6Z1Z0viqW0pKrGvgpy3TlQZJz95ZxhXslQ0jq/ATMtwdK3wzzvwet2
	 x921jJ8fdQjjQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, alsa-devel@alsa-project.org, 
 linux-hardening@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20231003232852.work.257-kees@kernel.org>
References: <20231003232852.work.257-kees@kernel.org>
Subject: Re: [PATCH] ASoC: soc-dapm: Annotate struct
 snd_soc_dapm_widget_list with __counted_by
Message-Id: <169643968801.45803.5943161279278436256.b4-ty@kernel.org>
Date: Wed, 04 Oct 2023 18:14:48 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Tue, 03 Oct 2023 16:28:53 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct snd_soc_dapm_widget_list.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list with __counted_by
      commit: 80e698e2df5ba2124bdeca37f1e589de58a4d514

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

