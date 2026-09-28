Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F154D1793;
	Mon, 28 Sep 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607184; cv=none; b=XOuKZGchFN6WZItd7u+CwjoDo4HcpVFgbpRwCGBy1jUw8recWUO1G9Smn/Jtzr/TyoZH2YZfHwjvKiH9IcR1H0khzUJexSdL+JD1JOaktYusjcRP5OPekavaaxHmiQ8FP0V6tp4gGcZyTG3dNIeWCrlnqOfSixQXTsX9fb/8tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607184; c=relaxed/simple;
	bh=a/jsc/xq5Agts61sHn5pJxm1EPhrLCwXq8yATvBL2zs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZQ8+Jja/6rZ0eQsmNjQmcQoNGCp0cDe1NaXRnUh0sPKY7BhReMeQgOJ3zjYoqcuQURHwyeAtPxhzh5Cc+WB1e9p4cH7CJksizkWNb8vOFZF+u+apaTxYToqrxNlloKCBOSMq+EFKf0nKvkPWjUDO+Sr+dj6N4eTH/rBNYicsuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdXRz2DE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdXRz2DE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C22D1F000FF;
	Mon, 28 Sep 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790607183;
	bh=QR6GezIDvFHdYOKISOF8W1B781j0J/OKViYYdAjnthI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QdXRz2DEElDzT260hgGcl9iIljs7rS6VJp8/JaXbUgDahUBpuagGDm1c6XtlilAHY
	 A+MsZWKOrR2J2HImbAm22KmB3s1pq6fuR2fQ/abbKmlt4xlZIUF0CqIaeDVohruoBO
	 gQfM2bnGvzr4HkvDuZZpxtRmnNfMgoQaxyTphNXfKh/ztUkeV8geK/u0WbqDnXbt5e
	 jEoqz6bzqlpATcFyZbmL4EdG8FAMcYjbZijhdQ+vVY7u3naGeZ2Xm/IWY60ouzlie3
	 9TvWyAkBpqzYNz00ODjpnr+kTeLcm8xkdPWAkIADXRybcBXan+cVofQSy6IkhkJnCQ
	 l/bf+SxgpQoRQ==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
In-Reply-To: <20260928044513.1330392-1-morbo@google.com>
References: <20260928044513.1330392-1-morbo@google.com>
Subject: Re: [PATCH] firmware: cs_dsp: Annotate struct cs_dsp_coeff_ctl
 with __counted_by_ptr
Message-Id: <179059773213.139547.5313569313368617305.b4-ty@b4>
Date: Mon, 28 Sep 2026 13:15:32 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a/jsc/xq5Agts61sHn5pJxm1EPhrLCwXq8yATvBL2zs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqun9K5Ac+W6gjLRpcJh4WH83SIltzARzPQZJ0x
 Mh/0e9K472JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarp/SgAKCRAk1otyXVSH
 0OpUB/kBYlWtHF89wsfc/QisM8KWxBCBflMFaoPP3i28byPb0GvIWlzOhEv9Z4XM5WeXMKDhMPq
 sPCALgXaJo0IPIGgr3Pp12LNnuQGDd2UtZX3hyWWXhRH1ayxbwNq/hqxmYZQmi5wAh11rH96Iu+
 YyrNtqX2PfZKnu5F5BehXXw7P4fb8yhwXANbaFXRHDaqOeXQ+LyYeRO97z4nsrlpqT09vagyg01
 Q6fpuZivxOXzSkqHyOE/LOPm5WdQnpgJQFH+quZfIygywhSWlud0wSbZdX4yUGwImki3nbpUQhA
 c9jVT85dXmBARmnbKgDJz21GPWbFnpbt0iQDlQzR+F75XFVp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 28 Sep 2026 04:45:13 +0000, Bill Wendling wrote:
> firmware: cs_dsp: Annotate struct cs_dsp_coeff_ctl with __counted_by_ptr

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] firmware: cs_dsp: Annotate struct cs_dsp_coeff_ctl with __counted_by_ptr
      https://git.kernel.org/broonie/sound/c/3e71ea6dca1d

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

