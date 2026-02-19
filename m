Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBC2DF3F2;
	Thu, 19 Feb 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526406; cv=none; b=Gge5z6yW+HsJvDhFkgKqe4jcjKj5i86NCtjdPYlaALgI3QJjMgflP0uYCKss/4qr6G4BYsbSsqpmwam5o0JvwmBTTiio+YGF5UvypaHeMkPyfzVHsI4Qb+6l1qSwRdmWyYoLnJ2nzV9uKeYDCSxPpUvOHHv7YN3X4Wh4rIcGWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526406; c=relaxed/simple;
	bh=oWkLa/vENBvQ8f2Yjd8PJoU9aRaSd+CV+yBQiwVPns8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTo2kXl28dQK69ubdOA5ufUzClzXT7vmCNLVOlBuzH8epZs1ggPoMGdXjv82IxxBmpOfsgFSSl1Z2BVPPf3lXgTf9lYDrNDHPBphoza0uN0Gfam5MBfxiCg09AjQwselQO3pSU93cz4zta54qQIZas1/YoenZDPX2tnMTAYZlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9CUguWg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9CUguWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192D1C4CEF7;
	Thu, 19 Feb 2026 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771526406;
	bh=oWkLa/vENBvQ8f2Yjd8PJoU9aRaSd+CV+yBQiwVPns8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9CUguWgmujPkeQWJrRPwozs8BSXnaFw414ZoGJPp5A4QZyG2GNEncVKyZGRMbKhk
	 vvQVFzCO6atspgLNBIIeSGg9SfaMXxZTvgsbcmp51fdUZbKCQ/OhnrxuW6iCajEpCd
	 gOUXkePHMYpeESfWugsZtEcghEKlkksUzr2gt3VPNbdCV15LXQyfl/LaND5jmightS
	 E1XRAXeMHlqkI7nobnXk3bK/WulsNu0yFSbt9i5/zYrxYcQsH8fCmI4m0AtuG2++9R
	 Z6W/GVKr8gprh4yPHiGHBhCGdrnrcf+dktObAj0jWZz88yelegfnBFzoAIX7PeJAoo
	 NDU3NyhP2N1Dg==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	tony.luck@intel.com,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net
Subject: Re: [PATCH 0/2] Trivial ramoops fixes
Date: Thu, 19 Feb 2026 10:40:02 -0800
Message-Id: <177152640004.271009.15237659516761248093.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218193940.912143-1-gpiccoli@igalia.com>
References: <20260218193940.912143-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 18 Feb 2026 16:37:30 -0300, Guilherme G. Piccoli wrote:
> A pair of pretty simple fixes to ramoops: unused header I noticed
> by accident and a bogus parameter description (that led modinfo to
> show 2 ECC parameters for ramoops).
> 
> Thanks,
> 
> Guilherme G. Piccoli (2):
>   pstore/ramoops: Remove useless memblock header
>   pstore/ramoops: Fix ECC parameter help text
> 
> [...]

Applied to for-next/pstore, thanks!

[1/2] pstore/ramoops: Remove useless memblock header
      https://git.kernel.org/kees/c/506cb75fdeea
[2/2] pstore/ramoops: Fix ECC parameter help text
      https://git.kernel.org/kees/c/6a9c63d2bb79

Take care,

-- 
Kees Cook

