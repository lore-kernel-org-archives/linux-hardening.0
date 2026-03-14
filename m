Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25EE23D297;
	Mon, 16 Mar 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625135; cv=none; b=e3bEn8m0VWqMpa1sBweJrb7dtn7zL/MZmp1+il4LzaXvNLML/s2e7sKPTu2M5R3nTO3g0ZMkq3WXY0Lrl8np3zt4AW/EB3eH1NhRcjPhPY1wnz4UCzZmCF6Kx+ScfVXo88eIt9ubE4yFwsXAL3NyaxByOQ/wPOn3x6c9aXZMKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625135; c=relaxed/simple;
	bh=OFGfRIVMiEsisV2X4/kOi/w6hmw/hu8eU6E4B7SV46g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lgyKRg0P4XmcONZeUYlA+MqSTKlMfjbGa+TGhGodobKnQkP+of51f5Um/bGdMKUMJ3U/0aqpVNJHm+nFhlodFKuNXa8ZG7yEj1BRq6E7r0/1D5uOtRuF0nvSgaj1G/Cug3do+lw3koqvQia7NOcmMYU6XNohi5mCfglwUQR8RD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHMAtekv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHMAtekv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73780C4CEF7;
	Mon, 16 Mar 2026 01:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625135;
	bh=OFGfRIVMiEsisV2X4/kOi/w6hmw/hu8eU6E4B7SV46g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WHMAtekvUdxHtk36Cz2Zd+2kXvIKPI2TDuwtpnZY5ab2zLTuqm6E+b2tFDhWaP4RR
	 7V99mKDlSSgv3Mv+8/2o+ExN2MlrDXqP0FOnVSmsjxzIMsFURZQINgfUzw6PG6Ko71
	 tnkJVR169+ureOKbaI4VOiRHy8Tz8MHlC61ghczAOlJB+on0HiSsjXXJqjDSv5Gqh5
	 G+yPR31MrA0r62xIV9Ijys1PqpCHAt4Bs3P4E1/HS3JGXqn4FARSa3rG/76vo22m6r
	 rWRzXVPubxgQI3JTkQZHegWR1sTKB7m6kVQF1npDjvXrQwS0WfRMYcP3Y5WwjgJqzY
	 BLjRBdX9ftkNg==
From: Mark Brown <broonie@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260311004159.32374-1-rosenp@gmail.com>
References: <20260311004159.32374-1-rosenp@gmail.com>
Subject: Re: [PATCH] regulator: da9063: kzalloc + kcalloc to kzalloc
Message-Id: <177352551930.149922.7098729946770531902.b4-ty@kernel.org>
Date: Sat, 14 Mar 2026 21:58:39 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OFGfRIVMiEsisV2X4/kOi/w6hmw/hu8eU6E4B7SV46g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt18sJ+fglzKEmC5/AF7/8KWTw+OWuTmgxMXBK
 3UIJx4Fsm2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabdfLAAKCRAk1otyXVSH
 0LFzB/45PfkUq2paazzzIzOUJLh4VwHWmrm8HtbEoAD3gZL3x3+xyRH+UHNw33tPZaCBxYQlIzT
 sshAzuzDlD/DrqRTED8EzgbNFS/POhuVF/xhcB18g7urnDuRCy1oX816p4Ejnbp6ZO3lDi+6Ymc
 6sD3BSWgHnChpqGL3ZhPZQXiSywrgsFV8ART5eLwgqpXchdHncYcJKVJbds16dLQrGO8dOwL79Z
 OuGl6mvmqf78Cdy5/y9GUJlH8euVLTez2PIkIuL4Rva4yFijh7oNI0ucRF9dM6xkWuZyZB+PElk
 mLboeDnlFSs0h3wse+PkQ7t1M9zUwfORyoOkqbxL/THW+Rdj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 10 Mar 2026 17:41:59 -0700, Rosen Penev wrote:
> regulator: da9063: kzalloc + kcalloc to kzalloc

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.1

Thanks!

[1/1] regulator: da9063: kzalloc + kcalloc to kzalloc
      https://git.kernel.org/broonie/misc/c/cf4812898b58

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

