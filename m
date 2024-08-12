Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC62B9B7;
	Mon, 12 Aug 2024 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488295; cv=none; b=E45bg8emwjCXE2ndral/zvvb1JKSG8XGdYVAcfKRtuoXOYuRFeS3JAxL8hKCpKJ9F/FoiXXVKb9Kb0jODgEy91h3xGZORkds9mZuWTXaM1DhWnbDSp/mTg+BogfYYNArlDFN6/nA8uMcrY9VopCvsQOBS+fxchJUHvhDddWkYP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488295; c=relaxed/simple;
	bh=6CjZRjGMV+H7c4xj8yV7T75tAXiMAZLCcw27R8ueuVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYVnNU0gUodHLZsiPYozFw5NLDM/ujxTFQhl7gelNzufjePks2UNZdjgK5Vvl/maKWsi61CdVWZHSqLhG8ebbYdeXR1qWZP8+oKvi+y4imx7QWeD81vaMXxb83epnczpKsDGJxnaadyOT3249jJdcCbf9JPisd4OHf16NZ6ChNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au/Xjoz0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au/Xjoz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288BDC32782;
	Mon, 12 Aug 2024 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723488295;
	bh=6CjZRjGMV+H7c4xj8yV7T75tAXiMAZLCcw27R8ueuVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Au/Xjoz0PAdBkeg1dpTgkLGZzsewhYUyGV3sxVxz2WEaoFCKMaidck1YWpQti1QMl
	 auzKa4Z7Y/BHJEhjt90HfNuoKUBslS39A/mYsT7AuaZ63a0XXZ4Tgt3Hnek1A5D7x3
	 yuaieICbgJ2fKrCOltZ8MN/r2IQtagt8dTCpCoLat9/U87pz9trp2xDeUL3skOFpZh
	 iPn1SKzDagSbVWh0JedW3uuc+Nvei3GjSEX+ZlWUum6TZ2mSSBMtCnbSJXdG9B34SC
	 0vdVL9uw23q4FGCBU5utk+0n34PaXG+Ksxmx2bLYrJ/ZRut8j5ruGZR977sR8ukRzP
	 hrjG2BkLzMK4w==
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
Date: Mon, 12 Aug 2024 11:43:20 -0700
Message-Id: <172348819834.2826487.9112203772355447388.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 08 Aug 2024 14:43:56 -0700, Justin Stitt wrote:
> When @size is 0, the desired behavior is to allow unlimited bytes to be
> parsed. Currently, this relies on some intentional arithmetic overflow
> where --size gives us SIZE_MAX when size is 0.
> 
> Explicitly spell out the desired behavior without relying on intentional
> overflow/underflow.
> 
> [...]

Since we can't have allocations larger than INT_MAX, SIZE_MAX is
sufficiently large for this use-case, and the "off by one" introduce
here isn't meaningful. I prefer the improved readability and lack of
wrapping pre-decrement.

Applied to for-next/hardening, thanks!

[1/1] lib/string_helpers: rework overflow-dependent code
      https://git.kernel.org/kees/c/5d6b91b74ccd

Take care,

-- 
Kees Cook

