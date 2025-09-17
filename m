Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7B2FB627;
	Wed, 17 Sep 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126628; cv=none; b=T76a6YhCvlbKQepjDm2odIhkl3FOQ6qvi5t04O7iFgm+rJfF1ovUZnC6X5HbkR+7kX1v/UcHDxPpa+L21wp2aGgKS+nEu0goxZDqjOqOKHCksQmKXBr2sw/ToES/8MPCXc+Y9EqDXKxOiCKnAfoFc/a4Zclz+YosPex6y3oBp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126628; c=relaxed/simple;
	bh=ZWwQyBopwPTMbQxO/rgmSn92HEKjVI2D5O9LVtdSBHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUA3QPy3Z6m2NFFYHWv9R1RhIGSPGpFzlAF1tkAbKI57PAjihZWX221OxTWesRugdTe6l8D1ZSuWZgEVEjTJY8cfQztD/4zYT2rJIeyL9nc/FgiQACN5F6ki/4XYHUwpT/qaPPINVbrMH5HVocOrT6aaLWnq6YMLDy8HNvXRgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaXgI/ps; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaXgI/ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094E4C4CEF7;
	Wed, 17 Sep 2025 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758126628;
	bh=ZWwQyBopwPTMbQxO/rgmSn92HEKjVI2D5O9LVtdSBHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaXgI/psTG7KzoP2VoJngsNyPRnjDDbiFJxvnHy2kt7pJohJCDydIblZ1JpbmxDi7
	 AYxvJdydjrjqSoCNSfRbfRGhUCPBpCXVq5JEsVTwtKoxy52xSZXCWbcBgyt3k+UHXB
	 FLe+qGgmATWRTmutha/ChzVILk5JwS1sk2oGYDcJpZlhS4NvONuffFb2wxEI1mO5eB
	 K3xcER6V8Yhwza46WwkHkLkISwTkOkPpuxVwH3be5Z52e4PT9nL07LUUgCwIjLeFbp
	 yYZeL5zSlO9MDEMpvS7RS8smwdVpiAxC57gB97Ne2uSvSq4/G36JfkhJoIK1wJYUWs
	 MICf5oEo1kuAA==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][next] Expand TRAILING_OVERLAP() capabilities
Date: Wed, 17 Sep 2025 09:30:25 -0700
Message-Id: <175812661801.142344.7461330093335850851.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1758115257.git.gustavoars@kernel.org>
References: <cover.1758115257.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 17 Sep 2025 15:25:44 +0200, Gustavo A. R. Silva wrote:
> Small series aimed at expanding TRAILING_OVERLAP() capabilities.
> 
> Gustavo A. R. Silva (2):
>   stddef: Remove token-pasting in TRAILING_OVERLAP()
>   stddef: Introduce __TRAILING_OVERLAP()
> 
> include/linux/stddef.h | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] stddef: Remove token-pasting in TRAILING_OVERLAP()
      https://git.kernel.org/kees/c/413187f79062
[2/2] stddef: Introduce __TRAILING_OVERLAP()
      https://git.kernel.org/kees/c/2bbdcf02c3f3

Take care,

-- 
Kees Cook

