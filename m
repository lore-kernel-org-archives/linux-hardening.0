Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3E52BE57;
	Fri, 18 Sep 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765505; cv=none; b=Q3tYFmP80FXZIv4HPv3/O7xjnnB1GUTN6qBBKKboghjLUO2tZxUMJgeqgfTqtDrC+/RsE3EXh4WY+3BzoexAmw4JBlfdbAqxfINlaZZOaA89uV72G5MLvd5aFAa8GJxA+OKE90YJRPVJYcBvH1ArlF2dFKWPYse/n0Hef8GhAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765505; c=relaxed/simple;
	bh=2dVHdw9v6uC4AW+LdKniul1dWeZmy/hTW0OFgjwdTJg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eH8lrVbuzQK53ScRac3HsNzRFh7ohqIBUlNJ7vcCpDvowzgw9oLIS3FMyQVpkaNGGVnlgEGOTyfh15QFMlCJvxRJZ7H1g7eUHbMYI55gWDRgjBIPc3e/FjoyKOiIzP2TToUdnxutOIYCfEPz/K0x4qljtNd/ugKl2uxCdZvelFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI8CfkBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI8CfkBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53301F000FF;
	Fri, 18 Sep 2026 21:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765504;
	bh=KoYkSQgfzMxkDlBWshJkd2YJ9rgIG9ls+ThGZAmQ32Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lI8CfkBcEWNcdceERGZFVBIT4VzM6wcn7aywCLA9qOMXQ76tu9CqYws8CIwV+i0S1
	 M4iTBfowle2G02QD+yBcrmnMgHMHavXne0+2SJJdEQThuiinz3vffFHry04/3K/Lj/
	 SBwuV/faXYW74bGDCDZiuwyFRvT4gHLje/tECtnmodeZKPgB36+JxlLd33Of0i9MXZ
	 HK4LfvE5WeULvAZbBZozqMXBlvQPrzAifEuxJ+gpC9yJmfDhrhBsxkOwlYYNgMz79u
	 g0EvPAoWoEJbzkacM628oePNH60nlCCOLeUt9BMpIDISaEGtYGgBjR/i8b/1EiqOvM
	 c/n7CExxtFK7Q==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260917211315.i.973-kees@kernel.org>
References: <20260917211315.i.973-kees@kernel.org>
Subject: Re: [PATCH] regulator: axp20x: Remove const from new_desc
 allocation types
Message-Id: <178975075379.1812520.6114959226544659111.b4-ty@b4>
Date: Fri, 18 Sep 2026 17:59:13 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2dVHdw9v6uC4AW+LdKniul1dWeZmy/hTW0OFgjwdTJg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrad6M4RCXwGh/6O1I5wN0TSeAhZstViBbHgfH
 KKDHTrp0yeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq2negAKCRAk1otyXVSH
 0CgVB/9iPUG7qiZkGgx7K+2e8BOb0W4vPg+yU7ns0YMa9qBNBNVORuM4isfRcij/4fNdrOC0/8E
 //AC9ARBCTK+0zSp39kmJzQTrgDqlX+TwP01A3wdN5SDwZ31q0y1z2F0rozz3sx+P3zBgwsWwYt
 4vWoE4h8aWUYs+fDglBBkHAZVwTEwEhuXSn3WzTIK2Eyz2+c8JIPIaupl40JCKVPcEyQ+HvYBUn
 EhrPbYvJjsm9efcDdgWnsHtAtkU6kAzaRiO6tmqLhUdrKcN9jCXATrVvLemxZiFSXGSjCvMvGwu
 22g/RZRqCUMhgMzXhK22WVPwNyJF8y4jKvLRgalxDfl4qbBb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 14:13:16 -0700, Kees Cook wrote:
> regulator: axp20x: Remove const from new_desc allocation types

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.4

Thanks!

[1/1] regulator: axp20x: Remove const from new_desc allocation types
      https://git.kernel.org/broonie/regulator/c/b53a09c957b6

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

