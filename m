Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17914A80;
	Wed, 11 Oct 2023 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN08u+FL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFA2C433C8;
	Wed, 11 Oct 2023 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697035849;
	bh=D9pqkQn2GvEbB4YXfJmtr5GvHtbWhi/1v/+iPM/ovgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JN08u+FLFxwWnU8bT3fDcRyo3s1NXX6saj27sklrkikmLG2f9Z784B2ct04hXVHq3
	 iLlihkOfMnRavREw4HenZDpIl30bVTkzL4V9RmPhUK6N9tM4yNZUe50c8at8P9kdVu
	 m4xE5wYBIfCt2hgmUoIxQuj4vxQa3ctkbMmBBzOHCTZiYFBvML16bEW9JuWthpyIpi
	 tycQCXcEfujepVAFc4nCYxT+hhJgwFmxnBAd1PGkw1hFLG8NYsQ/r7scjYEfPLUDXe
	 97gsHU7XETucf29kiLW4h8t+LBhaWYa7vRBIyJMQVnWMbYGaUIfX4M8C1qJDqDPVSR
	 6l+B0Yhrj3arg==
From: Mark Brown <broonie@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Kees Cook <keescook@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20230922175207.work.576-kees@kernel.org>
References: <20230922175207.work.576-kees@kernel.org>
Subject: Re: [PATCH] regulator: da9063: Annotate struct da9063_regulators
 with __counted_by
Message-Id: <169703584111.51285.14211447144066955668.b4-ty@kernel.org>
Date: Wed, 11 Oct 2023 15:50:41 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 22 Sep 2023 10:52:07 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct da9063_regulators.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9063: Annotate struct da9063_regulators with __counted_by
      commit: 1096f9fa2be18a1340d1299b4c4329af211076e7

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

