Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47093C157
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBlck0m9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61607C433C7;
	Fri,  6 Oct 2023 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696602347;
	bh=OvLqM9XmKRBSlmHs/YJiWIpPmHLm85bUF5Nx8aFphQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gBlck0m9UoIQR2SRna/scVu7GIFlGOiuPdzOse1uoZp54BePFOf2cykcPvnB8SBrf
	 EhkuMlOixmsRUkCax6I5+o86/ZszPC6SJHqJ0OZW+g4HOSSIcKJcb4xpjofOLgBAyq
	 2d2M6Y6Rrc1n9UzSVRw/KZhypZzJrXD2VaH7sKPKCL47sImv64Yq4M1gafhFnNR00u
	 oyPVPPVY1qI1lOJ4gcaO3ExBwefnOBZYGb54NJggeyo1sOP1Z59kk/nE/J5+LfV75u
	 R53Wwcbo4lU3cn1w54+y/STcXx7Or9076OBmVESvmvDloMKXkbmfObeb3Q0nQoPSvM
	 tG/+B7j0Exdaw==
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20231005025618.work.355-kees@kernel.org>
References: <20231005025618.work.355-kees@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Include sof headers under ASoC
Message-Id: <169660234611.30982.7753004263104446247.b4-ty@kernel.org>
Date: Fri, 06 Oct 2023 15:25:46 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 04 Oct 2023 19:56:21 -0700, Kees Cook wrote:
> Add missing sof header files for ASoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Include sof headers under ASoC
      commit: 4b226f15421d160cc07ff497179547f5590ce758

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

