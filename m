Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9D22C356;
	Wed, 30 Apr 2025 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053515; cv=none; b=uYLeyBNz+KHMAR2lCVb1zrMS/w0XoS3743u00uFR1oCawnm2fhRiSZ0d+fjnd7SqDRbpdkwHdS8IzkW4Q0ufjzb9W1BdYeycCWfhbjYkYcd1e8QZN7dw2QG12NUviyLf77Bx9G3y18nu/GVd5Z+ngUnj3iAfQymx1IOnobCM8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053515; c=relaxed/simple;
	bh=UM9tECXXlOEx4/fE0WtX2yt561V2boOHKx8HttqBlCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RIiFfhypfUM7nVBcnB7qzGca7JlAPI7pVkBI5VhDt5XS8f7HIu/be09wqYZ7ZOw4t/MgApG1uhAVNMIi38oqkkFV8LCgbigqb/u0cpDXMT0w29H7yuOErqKzpfnI8ryhGsRv3qMmxioLvu7k6wWpWzT92h8TzOTVhhyKYbuJ/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNYZkTr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNYZkTr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF2BC4CEE7;
	Wed, 30 Apr 2025 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746053514;
	bh=UM9tECXXlOEx4/fE0WtX2yt561V2boOHKx8HttqBlCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KNYZkTr0f91ihxdkqoegutPC90oJb6FeUpD/RdqJUDbm3ysW8viEhw/bfWsizcKcv
	 /7GHmx7fpPEaMFhV86ASoBW2BL0ed+qkgbKd06N1gXP7ZZowsYcGy9ZH5TFGwxsyu/
	 8bcTI7xff6WpkehU2+8rd0GIlzhFsvTB/Th1Lu8ckIHxAyvdCvqMiS2j1db3btHXmb
	 NSJjGceiGLEa2BckBQB1XntoDcBLviz1O7oY0pltlLwMEEv7cXez/J6UQ+nZvAzl58
	 Pan+lbQ5Uyd1bLFqoNFzQvJgmGYaBIMYJHiz97dRsBcV+t47dhPlmvUjzTby6q+GVe
	 3kK+s80YrVWrA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250426062511.work.859-kees@kernel.org>
References: <20250426062511.work.859-kees@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: ipc4-pcm: Adjust pipeline_list->pipelines
 allocation type
Message-Id: <174605351049.3987837.5254876941350949279.b4-ty@kernel.org>
Date: Thu, 01 May 2025 07:51:50 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 25 Apr 2025 23:25:12 -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct snd_sof_pipeline **", but the returned type
> will be "struct snd_sof_widget **". These are the same size allocation
> (pointer size) but the types don't match. Adjust the allocation type to
> match the assignment.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-pcm: Adjust pipeline_list->pipelines allocation type
      commit: 00a371adbbfb46db561db85a9d7b53b2363880a1

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

