Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CA52B1FB;
	Fri, 18 Sep 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765480; cv=none; b=k7ZPEBUeiHkhbF3oXqKz8ZALKyxbpxj+pXu1H3hJl7RbA9pEiiZp72kxj1RMujYGMtFrP0KnMbw0vG4CMZiKho3ThXgK1OYNv5kXnGUeVjBSQPgStIE7bUtRpPNGPK3tdLjQrqI17S042e+W/iM9nQucZ61vALHLp0gM323+bSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765480; c=relaxed/simple;
	bh=GFHRyf2jIdAfF7MP/qTWqHFwkn2oRho9x+IOTWdtN/w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Roy7zUM52gMqjEe1R+jVAtuPZvMdn05A6yrEfV9GFAlPLy5hv16oDNLCRKyUoXpLR91a1ebZM689pgxlXm72IwCIIPlW0lh+4wYLNuHpFoKa/nwWWo6cOG88/LldtqZLZ48Ds0vt8J9H7C6tcGsAXYZ8NIEp6Fp41dkzS/ddhl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eScX0Tvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eScX0Tvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E7E1F000FF;
	Fri, 18 Sep 2026 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765479;
	bh=lY59RKj1ZloY8qxaipt/kf80DvellTJaVh3BsKjOf2Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eScX0Tvksqz3kkuQ0uEoO8sjqVyDJVuqA/j63LYAI4/chjh3Aw+460ETvLM7I3Wft
	 0pzlNKWgUpqYzuLVBY6W1Fq+bVgCr95sLuz+SA25MtIPgO+ZlJp2EF4zfYgQWHnRU3
	 jP1Vj4WgyNExj45hnFvtp27L2l1bY2OukCjVQh9XvxNkhUO5qgth7rSlBQBKQA5BfZ
	 boXQUyKj/PudEupD53QppdkJJc48Onxw681AL0upvQ9iieZdhLvDNifTcS9SiwXXAU
	 zo+IbXv061H2CwsHy/s4jWyzmsc2ksXQ54ANxQdOkeGnPWrMH/sXHdP/ENIxbT756n
	 6GkPoA+lVyKUw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Cezary Rojewski <cezary.rojewski@intel.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 bui duc phuc <phucduc.bui@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260917211102.i.029-kees@kernel.org>
References: <20260917211102.i.029-kees@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: wm8958: Add const to enum texts
 allocation types
Message-Id: <178975027491.1717936.237839412558346234.b4-ty@b4>
Date: Fri, 18 Sep 2026 17:51:14 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GFHRyf2jIdAfF7MP/qTWqHFwkn2oRho9x+IOTWdtN/w=;
 b=kA0DAAoBJNaLcl1Uh9AByyZiAGqtp2LISafV6nciGeW7a43T/5ebxoaSQAHvwBWFmmGI9x2cI
 okBMwQAAQoAHRYhBK3maKpnVxi1n+Kf6iTWi3JdVIfQBQJqradiAAoJECTWi3JdVIfQDhIH/A4w
 5lI6TtmVfLRXySvtlYZ1tC+Wux4S3EMsSUO+XspZpeIZC+f73N//9I7HEudFZwjibuRq59Au1rH
 m24vRfb9bjvdc0pRizaWvQW/wd+A+QpbLU6jbNNADCl3A+ky5fmDrra900XDcFtxNMXaUZWMhn6
 0huxC6d8xqOIITgJDP/GecRJPFO1pHskpQDFuOk86Wd7zaeZyNlhgbggwi5v1Pv4x9B5C2cgVpW
 1eHqbLWu/L0hb7eAJzDLEBOu4jK1ui/OWJa7sdEJPQDRvgtHcQoT0nERi0eI26/AFLiKMQ7yXxg
 WXfsXulfaUkbFNtV/o6y/FNxFdCI+6qUDRO286A=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 14:11:03 -0700, Kees Cook wrote:
> ASoC: codecs: wm8958: Add const to enum texts allocation types

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: codecs: wm8958: Add const to enum texts allocation types
      https://git.kernel.org/broonie/sound/c/d0d2b9576f44

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

