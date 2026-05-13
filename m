Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F754C77A9;
	Wed, 13 May 2026 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692544; cv=none; b=qnA3Aays/iBQXvTKa1fZRT+uetWP5XD1QeEwNpH9iEgU7sIt980CKLvzFsh9NbRdJwobAACFTA7USxa7oOQCYRPnsJPEyGAne0WLc+zjoQclql4kiWmFzYWQYmhcv5aaOJvyRz4MzIIeiNsAfHO5zU0NLOUXhkyGXR2W7ZfQEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692544; c=relaxed/simple;
	bh=kPOSiguCfi1qAZCt81dWiD+RpewTP+Z7nw2WWhtlASg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaAPZsWEMYwZ4Ktdhd807TGxHKvtgXYNg9XnjDRF44FkcdtYvx7tMCPaNtuj7Ym5mP53sSZf9GfhBLf+uhBzRNygxz0Lfi8q+gUriii1VW2JLLp9TKcH9Il7zhbwE+XZ593sXXTfFxCjKGgTG7UEtsaa2CwgmBA7C0o6Za6BTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqpjjuoE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqpjjuoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D967C19425;
	Wed, 13 May 2026 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778692544;
	bh=kPOSiguCfi1qAZCt81dWiD+RpewTP+Z7nw2WWhtlASg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqpjjuoEqPO7gr0YPwgf44u8km9pDg37VUySHKamIIynUnxQbCGDwBLQUs1vkSzia
	 OQI6QD4INxnj0/Wz5GTGKbaYuIx5aYiKAk/p0lESEEPU0H0nulj+gRbgOEknahVXoi
	 sTI13PFVJwHHPsGjaUAAFQX4935zruWqEC7+ZpxvW4LtTm84o0OjoICzB6wWrAp6ux
	 ueDZZ6c53DcGfIdvwfPDPvLZGx7FN5jXpwVuO8yLYKOuELSOZn02xbUXGmcqbJLTBM
	 tKDu1bcWaG27h+BOSWdqNSaRC8UVDo/0Z1XQx0vWqqD8+RfLvDJlt2TRtZEdOl6myA
	 BCavDRLRHdQYQ==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add kernel hardening keyword __counted_by_ptr
Date: Wed, 13 May 2026 10:15:41 -0700
Message-Id: <177869253950.440464.9395270876409290297.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414130926.312094-3-thorsten.blum@linux.dev>
References: <20260414130926.312094-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Apr 2026 15:09:28 +0200, Thorsten Blum wrote:
> In addition to __counted_by, __counted_by_le, and __counted_by_be, also
> match the keyword __counted_by_ptr.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] MAINTAINERS: add kernel hardening keyword __counted_by_ptr
      https://git.kernel.org/kees/c/e0251b5e07f3

Take care,

-- 
Kees Cook

