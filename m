Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3635506;
	Wed, 11 Oct 2023 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7vdqLtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3F8C433C7;
	Wed, 11 Oct 2023 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697024089;
	bh=T77Zw4Ow+fGootlr3AzajNul/Y31eLQDixkQ42a4Eco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W7vdqLtxGJGwwnSXxh3fxZies3A93UQ3lYTZM+wU7N7228PCEfJGYy2ELwzOLOc2a
	 EDSCKOpzaQ2JU7gQhdxNXqDqTrHP768IGb+VN2n5eTojP87zFqflHI+VnsFQkDKpiC
	 jwgl9+HUi0uBT59x/heygfMxV3+hM/L8FXixl4B+Hk40JNRcwAv0kQjdQM4KEul5YM
	 LKY3icUnaKUsQixaXvS+ldrXHf/M9oY/mq5w2Dn2ZIbIF4WIbS9zChvPv+PddmErve
	 yuwwsT5N9+X2N6pUEf7UOc70fjj7QCj3ADZdBpE+ybZ6iIZJTxjOeQPIT3H6FzZ9EL
	 40KFZpnvC53bA==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Kees Cook <keescook@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
 alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20230922175050.work.819-kees@kernel.org>
References: <20230922175050.work.819-kees@kernel.org>
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-Id: <169702408624.29318.955313379054643924.b4-ty@kernel.org>
Date: Wed, 11 Oct 2023 12:34:46 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 22 Sep 2023 10:50:50 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mca_data.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: apple: mca: Annotate struct mca_data with __counted_by
      commit: 59825951707eccf92782e109c04772d34fc07eb6

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

