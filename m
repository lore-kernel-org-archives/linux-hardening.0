Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59823C4FA;
	Sat, 16 May 2026 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778904750; cv=none; b=DE7n6PEXZqdJEtqDpPU3ATMeRf1ed+BzfmejDXqF0tdK18TZBgvt94TQ7djASSoJHYR5owuLz8yGY2KaonrXbkcj4JCKGIadt6Xs5ATXF/c5deqjW+RwEBPHlKAb473phdLX1+neDpsptXNaMw+KG58o/uhVJEkHR8Oge6da8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778904750; c=relaxed/simple;
	bh=AXhQ+sitrlXgnhgMHpBKBRXSmGjsg3bnCGoy9jg6kOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kapj8pEBHxkmi8Yi7OS/cRhYFiKuqs/CHr6I5oki/Rvc1nKzlwZ4xhtFu5ARmSRKgqOoXunObda1kzejl74OMOoKFILXJ6kJOD0KVtGgFcOFf2zbLxmAa0jubavgZkN1L8iIs8J/y0sramiFeo6jxQASDv5GZHqWlcSsZSlDoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf44425/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf44425/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5356C19425;
	Sat, 16 May 2026 04:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778904750;
	bh=AXhQ+sitrlXgnhgMHpBKBRXSmGjsg3bnCGoy9jg6kOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Mf44425/yjGPap+Dg7zUdtUXBiFlBX8p+rri7DkuIaEICQ8pGjDYQVlv+ptk3ynnh
	 rvqqROAKJMbiuIJsAKO5OH3wBAE7s5pP+GW4LqZsd66pXUQZgST+V5ozj1aK+kY7om
	 u61ZvMMb/wuHbk2swlucU+T3YhzegF89XMDfdFn8nnjHTxproLp60VzMDlWpBYnCQg
	 /NWHqaHdpgbZ+JVmegUIu3iE8pPAUW1uQGT65BNoCMw4N6ZPZl259S5YQeKoTcmuY+
	 Ixe9Pbg4hhFKSj/6tToIeVS0tk9jdABP/yxaK3Ux5E8Tg1sTFkhzrBhCqRBJiNE5aw
	 MlGnyPcXZ+akw==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260511231313.31929-1-rosenp@gmail.com>
References: <20260511231313.31929-1-rosenp@gmail.com>
Subject: Re: [PATCH] ASoC: pcm6240: Use flexible array for config blocks
Message-Id: <177889857877.1174745.12518268346134394815.b4-ty@b4>
Date: Sat, 16 May 2026 11:29:38 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AXhQ+sitrlXgnhgMHpBKBRXSmGjsg3bnCGoy9jg6kOM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqB+6pu4JuSuTU3CR4tL/PbTET4LQMj5e075Glx
 r4w1MPkiL2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagfuqQAKCRAk1otyXVSH
 0MjoB/9wHwhloXUXKq/2BdHV+vdrrGH/O6EP+SbyA3E93rWTsID2URYgMVH/3ShGTidA/X0nnP9
 YzHusJx1kuKpIEbttNXRLx2vxjnu0PqS9tI5x4NhTdctuivzqpAqWqnAJUf5ABvJ/+Cin0M+uuE
 51AZwFkUgW5Xz6kmilb7c1TnwSUdcHsW6g9Yc8EtgxpJPTYScXCJRzpo6oo8AkjNP21i2ltrEAC
 wIND8x7S+8jG3Iy6V5co8Mk8PA9aT/uBjp5bXM7vdniPFExuNRhX75gM4AWXHPfBvPDD3SDqkO7
 tjsfm7irM5EF/B4bvS/C12xABeukZBtGzkY6xs1sTc1JYxE1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 11 May 2026 16:13:13 -0700, Rosen Penev wrote:
> ASoC: pcm6240: Use flexible array for config blocks

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: pcm6240: Use flexible array for config blocks
      https://git.kernel.org/broonie/sound/c/fea3df9eab74

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

