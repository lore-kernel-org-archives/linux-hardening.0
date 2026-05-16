Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC826ED59;
	Sat, 16 May 2026 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778904757; cv=none; b=a7S0ALuLy12GhXbJbWXi2GNrPAqp4fKx4IV6ZqxmGOJLqZAoW+psQNN6SCp77RcFq6tosp6BucBTT9r4yhxciwaMHPLnpNM4auBuCNuCtN16KM7D03olQfni7agXT//ME/8Cu7x4ri4ScYALCAbhKbEJNDn+to3Q8FjGpmHnBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778904757; c=relaxed/simple;
	bh=gjtWVLAvEwin8gWA6re5ww9JQc1JjXmSu0dbVplFHks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oxvfQ6dzfuiqKuAkHMVE4qMUrqZlybpw4R6xqCG6tBXexopKe9/21zOOSYuWGRy9uIUrn6APonQ5SuWfqSqrZvUophfXk6wdcmV1gAT6MejWqelMPe1/haQSXU9vLIzWwrIUR9mef23KH+k79reeyaFL+cKGGAVxOZngFiik+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFlTOMbT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFlTOMbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FC5C2BCB7;
	Sat, 16 May 2026 04:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778904757;
	bh=gjtWVLAvEwin8gWA6re5ww9JQc1JjXmSu0dbVplFHks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JFlTOMbTSQnTd/e+kxPeonpjgxhEAkldtojeu71U8IKMOY61Qo3TORLAvh7M0ZuRt
	 SY9MzVJBInHHoSCVb+pxgPBjipwvMya2S9QumuzwE/awHd2Q4BJMmK6aLmfNZGcJm3
	 rjYNk7w4dP8yDn1+ZVF+UEgSvpwyZ2uDXjCM4gta1TH2bJN4pytY5GWOCgjRVyMzb0
	 +xfqlWaBTjm1v3GNxkc78hFY8xuxY9IUS5a/qRD965Wi21yWn3TyOJmT/4RwzvMDJe
	 4e2obGHbBthQELOyP5RGtX6KOyrSbsv3oVeYcdyTMoenBxW5kwfFfBknVjyLN7QvPP
	 GZDhbgwdWyO2g==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260511230351.28868-1-rosenp@gmail.com>
References: <20260511230351.28868-1-rosenp@gmail.com>
Subject: Re: [PATCH] ASoC: sigmadsp: Use flexible array for control cache
Message-Id: <177889869075.1174745.4723404470798444170.b4-ty@b4>
Date: Sat, 16 May 2026 11:31:30 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gjtWVLAvEwin8gWA6re5ww9JQc1JjXmSu0dbVplFHks=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqB+6wh6BAZCaw6ZFJAOqYc74nMmsss7QwAQiAo
 mTKi9YrRpGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagfusAAKCRAk1otyXVSH
 0HYtB/4yKXGOVDEFhYYccP4d+KAveA1taC9LOVLdhdmtPNg6LDvGGyaSTNg8E0iD/JY6urb1WrI
 ak5MxDncgJujfgybGgY9pNzbblGuS8oVIRbzHHWUZUIOevQbA8yggXEHJrfd/GK7TR093QvLDo4
 zaGEaTDA+dsQAWVyeBjskM41ApsxnQkDjW0kyI83GZ8imw1AEIccMEfDOP5zzFDMJEJUr4FFW5i
 zHcdLODrMbBfIkiwqwjtBjnQ4Svk5ua9BWsPw7t5ghs+HZEx4CuoFVKOGI7841wstruxXi6ZtDh
 Npdf4AM8OvvEoUpKaHXbbjg7/fTXlkjhjXpNicoh5v20bf0o
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 11 May 2026 16:03:51 -0700, Rosen Penev wrote:
> ASoC: sigmadsp: Use flexible array for control cache

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: sigmadsp: Use flexible array for control cache
      https://git.kernel.org/broonie/sound/c/e0014849e9af

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

