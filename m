Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9F525A9B;
	Fri, 18 Sep 2026 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765475; cv=none; b=NFFvpQG6zLBWFJ0dTFPV8WZxxeRktKDItk/TIbsPfrv017v8R5v7d8hZXcv157g4JgRPODxrY1+OeZsYceIdF7EJCGm4RNsMKcEgy7Yt9e6xCnIfP/sPCNYJF9tODHWCCoIppMpRIGoImBRKi8kb2ZnGMuJOQ0vq9WWiYiEmpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765475; c=relaxed/simple;
	bh=nzk5wW7kAA8eerNpYLGvzTJkvarBED5JH9U0irj7+qs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C2Al8FF8cGga622a3magv/Kn5+TIsyiEpVSQX/nVh8jyYrYFjs1H5469sAivGLCvMJEhGdCAJTXpJmkHCvHLHjENQRo0GeCyQZGtsYtfsPTJ/fhBEPL22tj5lCNtrte3+fcRNWcDNSKjJjXjVW1dzF8q2AK+99HLYADVwRMr/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbQxyuAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbQxyuAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41A01F000FF;
	Fri, 18 Sep 2026 21:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765473;
	bh=be10aNrUJkHOHyZrqZpgGWxoT8ul9EcuQqU4OKqbMXc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TbQxyuACBj0trEa5qAbkg/5Fjh5fyI+ovaktgjmPawmL6xAZnNCRkiCx1OCbh4sfA
	 Y0NzLSjOuYIT5kuPDhDwPm99D+0z/ks4iC4+mtYXGGHr5Av56JMVMt7aI2OeyaBtOP
	 9Cz0g5izW6USvcWlnsPlsCjhnSf/P5J+koPy8fXNGPLVPdxZuaypUhOwak7O1Pd2Nr
	 hEyXe64RIr8M/07SU1GRKTZS4gibjq4BABL6u95Cu7N/weaYfyYHqw9GbwXMnciuO+
	 b1+4OBZcQblBl9NJRBZy/LY7Lx+3jqaZQDwlR/6ehOyZdc4AP55kFxdOGlrRltdcOv
	 QncqBsd09G+LA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Andrew Davis <afd@ti.com>, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260917211042.i.810-kees@kernel.org>
References: <20260917211042.i.810-kees@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: wm8904: Add const to drc_texts
 allocation type
Message-Id: <178975015968.1717936.8503596777337073130.b4-ty@b4>
Date: Fri, 18 Sep 2026 17:49:19 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nzk5wW7kAA8eerNpYLGvzTJkvarBED5JH9U0irj7+qs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqradY1oQe6ozA0d+MuW6OcGiiNyAsETgNvImBC
 5c+YhozLdKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq2nWAAKCRAk1otyXVSH
 0BkoB/9R+9qyWZBWC0tJGIya02dt7mEELy1iyCoAi+yDu4kDucUAjrCoCIi3bu1uH8MH7tKprAX
 qiB7scyxB5iV/sywtBrgVCgI6TyFDVgT7cJdvwAxld9QA+IiSArdd3QL2qugn4PS6TXKUvOHOet
 xG8SNCYJGZzN0k/QeGVfIuXLeJEDl4xd/cI4ylN53fJH3ykaAIlaNXCQL0uc3LS4jUsfVDTvbg/
 klTlUrhd7b7Fc+9nSD8rjpkSc+8DQgE57mWjt5WR+ZdecLRHysVR6+L75tp6EeicEzMXr3D+GwX
 1S6ZFvKgoE/I7GswbnfdjoGn2DvIumkrxfjeV2/MANUIck5X
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 14:10:43 -0700, Kees Cook wrote:
> ASoC: codecs: wm8904: Add const to drc_texts allocation type

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: codecs: wm8904: Add const to drc_texts allocation type
      https://git.kernel.org/broonie/sound/c/13b4ab33642b

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

