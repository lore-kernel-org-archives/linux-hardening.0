Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379647C7D;
	Fri, 22 Sep 2023 22:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B58C433C7;
	Fri, 22 Sep 2023 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695421630;
	bh=g6ZipImHzWeQiovS+WeBEOUiNBPw8TjA4wZva4vwMxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kQ0ugVXT6IG62g8lFiHVfHvw0avcgkgrYfcfZTfUKrJEE1ykxMJlQmYC3fOnfZvjY
	 Xga9J7ldCfdYasLoOMErX/JMZ++NV5pfbXKUx/t0PoArfawup8tgNuQqcdOxpATaPF
	 k9eJKWsel5ZDs1dxT3VG5xXQ9W5lkuNofD0ySeEZGP3anqvn3S3tfUHijgJx6c0sQv
	 2FByppArjU0RsKG9QM2Eu+TsjgTZdEHktA5EXU2vf3YzFaqK92rRDDYppmRsVF9Akv
	 HzZqA3GJzaShqwBHPHB6CVshCG+OS4JO2qfH3bRqI+jiXxuLk6/gXUolnyXxYx1/9h
	 q8EU8aZhM27Hg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20230922175402.work.819-kees@kernel.org>
References: <20230922175402.work.819-kees@kernel.org>
Subject: Re: [PATCH] regulator: mc13xxx: Annotate struct
 mc13xxx_regulator_priv with __counted_by
Message-Id: <169542162748.66572.1754159074793629269.b4-ty@kernel.org>
Date: Fri, 22 Sep 2023 23:27:07 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 22 Sep 2023 10:54:02 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mc13xxx_regulator_priv.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mc13xxx: Annotate struct mc13xxx_regulator_priv with __counted_by
      commit: 6e6891ccf0c7e70f13bc1d5ce5a7edee2b5de045

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

