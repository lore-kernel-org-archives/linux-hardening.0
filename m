Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469B3D3D06;
	Tue,  2 Jun 2026 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402076; cv=none; b=QBvsafi4iu8ixrfNxZ2Oxe3w1IXS0dbthvN/Dlsqx4OEVTK5FtmcU0nExHiVZS6rrbnKLcxxJkQdsq3kDChF5LIkGCM4il77ykNDBnQ9FZI/+4mdhh1vXfZrWz8x1oE5OfAZkglwwpy2OXTq7n2QY6ly69f5Qw77nZ69xc/AETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402076; c=relaxed/simple;
	bh=0IFjW8fU4TKN2E66tUMtvss+f/E4Uhd7V/fPHIrjSNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jQEja/d9zFIvcJPYL97NoH1zdDPScQuGHWcSP+No40X8Yo/VF5V1hEOOtLBcOM/mhGSC1iFNFzDAecTKphl6LOnfVWI3QEu9amx9tfHnVhVqqIqfM3YmcEW23CkL3Em0KugvRyqdX9CqjudHX1QuJtXyAGUXce7xTrNEiwCC2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPjpQeXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPjpQeXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671D41F00899;
	Tue,  2 Jun 2026 12:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402075;
	bh=KCZVPkQQS8aFIQeDo1sCu2bhh1lJyqQriDHmaSVmluM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PPjpQeXmqj9RUemludCWwRtYQaUQhDKzKjrwu9PFyMAh4FugmhftoHZUqzLgt+m9Z
	 yDxOw0Q/CvrSi6RNJjxKUFgCB1QQFBoMWEpExmV7+Dep/KwMUBr5x8lEZizHW7OyVk
	 juwctA+l40auXYH6e3HctzC6LW2SRZJ7exelRH3TnQUsP3+stMy/uaOZS3WjZBLo5H
	 kzZHvJ+712POxuU4ei39BGXp4U9g1LO2uwf2KKx0zftLlMST6sgUd4xTZoRq14KTAt
	 uj2QgVaSPYxFugnHILo+3ZtH+L8Reb42J79j+CGbfc2rU/zh0BTNxubSrpMEglTGY4
	 jHnbSbuLyo2Og==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260523011749.101555-1-rosenp@gmail.com>
References: <20260523011749.101555-1-rosenp@gmail.com>
Subject: Re: [PATCH] ASoC: aw88395: use struct_size() and __counted_by()
 for aw_container
Message-Id: <178032596075.44654.17985175995408252266.b4-ty@b4>
Date: Mon, 01 Jun 2026 15:59:20 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0IFjW8fU4TKN2E66tUMtvss+f/E4Uhd7V/fPHIrjSNQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqHseYkm/gnNSRod1vEZvuprQCbmY0O7Q0RpEkr
 +kBmgz2TmGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCah7HmAAKCRAk1otyXVSH
 0DVGB/9HC2ndar16r3zWqp81JxVm2+vDcHIyLW0oiVXnoXWm0xVdsR8dn0I6kQAm1HZxa8ja4DZ
 5hUu8SJCPGeciXlRh1ColQJeqtCjkaog1I7Xj74McUuy9gw8+YxU/BatBdvTxCIYNPdkcjcPDcF
 QhfAijasxtZQrMjAL4N4cv9JcwK7KZmPBOvBZQrHczevJaFAFPKOnAyV5QEmSlfbmHM5UqAPORY
 ACmGqMbKrXRq9+QZoMRLvnsmJSgbFWKyalqAF2MUhpNLeJuJ3sPj3ccbhcGwCXVD3Jb4TmSUldT
 hPEMijme/cqgkWcxQseCyoD8XXAX37IU6TxFI/bV61d0LRUu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 22 May 2026 18:17:49 -0700, Rosen Penev wrote:
> ASoC: aw88395: use struct_size() and __counted_by() for aw_container

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: aw88395: use struct_size() and __counted_by() for aw_container
      https://git.kernel.org/broonie/sound/c/36cf16513f9d

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

