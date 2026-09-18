Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9C52BE52;
	Fri, 18 Sep 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765499; cv=none; b=Ph00FxTbHTyZJB5D218DVmbkn+AcKWh9NX6BQhkhrpLO14ddMb1JW659HaDuHOhXNRrCq+azZKX/5VE5rWsotqX0Z+A0M57WKsxNdI2ASTAF+ePw4xx2yJtRYMhJoc4zQihL1YtL2KIswQPKZI7V1ghDW0225ckM06mQC9duFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765499; c=relaxed/simple;
	bh=QdmO6MKGrfgBYMmT03NCTZZpg3n/MvfSL+m6yc4JwCY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mUVvVm6JtLez6eqVhCQgA0GSZtJLQ/AUGj+ZVNcOxRq29cVmSjai95t7Df7vGtWUYe9cNfxjZxyFeijPLVoVI8ZKRbKaDQXpYSvYewc0loFb/YY8pXvDLyYLxjC3rOZ0w0Nq/qOH5eNp6/3wNULFeg5o15DQzuXfmJ8KqVmclc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYrSL0Kv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYrSL0Kv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E221F00899;
	Fri, 18 Sep 2026 21:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765497;
	bh=Jw2BUn4K65JZcEC4ZqmXGdwnscwZ3g5NLuLMdE41rGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gYrSL0Kvl2iPoaahkmGmpGECaw9uAp056k7ejpsY63E4CTR748hxt8JNW7ysSgQDI
	 x6kCp580HWZtJBUpyaDTlwzm3MeEa1Y4goeCKuc/p/3g/Cf8w57z4bSCClDVYNPWqm
	 iHfSQ3epcylm4pSgskPHVzxAv19yTUQL6TMDXWJKLoCI5KmaIlmhkQh2qywwbHPXm0
	 KzGyIPuds6D8dVWqk8Twc8s4pKQq84R4uPUky98rJXqpWKX9r4zuwqK7BmVpL7VdMx
	 ADJs9i6eOpE4KS98iBj0qze2VQaZ+zYOll//Y/rFtAdqhfeUSGq98CDCDVFTPcWPuC
	 1/1naAKxR8pkA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260917211117.i.991-kees@kernel.org>
References: <20260917211117.i.991-kees@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: topology: Add const to tplg_files
 allocation type
Message-Id: <178975043425.1717936.16356331594777063343.b4-ty@b4>
Date: Fri, 18 Sep 2026 17:53:54 +0100
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
 h=from:subject:message-id; bh=QdmO6MKGrfgBYMmT03NCTZZpg3n/MvfSL+m6yc4JwCY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqradzFfY+FkfX07J62vR9xOHF7pFElZPIL5di5
 mCWiPJYf8+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq2ncwAKCRAk1otyXVSH
 0HJYB/9SzinU8RP9xfgmkpK7paYbg6xbSF5LcwhzGxcV3ClWPEP70s0Hrgoh5+DBVqjxlOmXnf4
 QoQJg9ABY6bYImdVNcYtVFODqueT1zaUUGJ8G+nEg+iQbbg0rf/gllxVXXSm6RN8paTMc80qi14
 IfzraivES4Frz1s8IB4/UrTNJCWkFxSAj4TCiMFAuO+XEuqxuVIQHRCYElYeVo3T+1CRvE3f9qB
 lD38oOTzDL1Zu7XACnQ/a9xLwQvcnnR7kBF1HllZIK8a6UjHCOyPkbNE+vfFg0JCUt7JmCHtdKG
 SzWdrqzwAwNLEIEMAeU7v1yjE8pSAIqUS02XQej4HQIqt76H
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 14:11:18 -0700, Kees Cook wrote:
> ASoC: SOF: topology: Add const to tplg_files allocation type

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: SOF: topology: Add const to tplg_files allocation type
      https://git.kernel.org/broonie/sound/c/cbcb58ad7a19

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

