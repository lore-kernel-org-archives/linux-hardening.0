Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6F28DAB
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwQ2Blf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC103C433C8;
	Mon, 16 Oct 2023 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697470404;
	bh=ReLBlkdX/Ih5s92nu5iD07eefwL3bPoRMnTYOk9amZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YwQ2Blf0JX3WRi+CsGYYqK+p3IfDkg4CRhEaIuGeSvR0S14R+Y7SJHvYyk+IkTFHt
	 m+Wz7pA8uSrYinvoDUimMJFSZxk4EeWM5vniF9VnzEypA16j8ardzeW5wL/5b51eSU
	 rfPVeuWw31RPYENCGvCBtcE7DVaddwsopMBWfC/a7PGQl93l2aM3t6r5txboT/dudS
	 xzwp2QpqBZR+6ddwDT+0nFyHY/2fvOugNvOL20249udCTifgyc6L3uvTuL1pd2MYhN
	 a9V8BV6QyNQmb8XaZnCRdUzerR4gebGzGpikomjLjVVCGbYvzF1RE+ZsxULK9MwpJh
	 D9TCFXwWaXhKw==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <ZSRvh1j2MVVhuOUv@work>
References: <ZSRvh1j2MVVhuOUv@work>
Subject: Re: [PATCH][next] ASoC: sigmadsp: Add __counted_by for struct
 sigmadsp_data and use struct_size()
Message-Id: <169747040242.42352.2081584730958275030.b4-ty@kernel.org>
Date: Mon, 16 Oct 2023 16:33:22 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Mon, 09 Oct 2023 15:24:23 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() and size_sub() helpers, instead of the
> open-coded version, to calculate the size for the allocation of the
> whole flexible structure, including of course, the flexible-array
> member.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sigmadsp: Add __counted_by for struct sigmadsp_data and use struct_size()
      commit: 4f88c72b2479cca4a0d4de89b4cbb6f1b37ee96d

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

