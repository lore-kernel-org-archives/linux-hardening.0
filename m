Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73933B6F3;
	Mon, 23 Feb 2026 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885694; cv=none; b=uc9zTv6aAQMA53pZx7Vs1c4pRor7hQ1fHG7WXEloxR/djRosINQcLnZUZgteZNbWgJhv/tYawHTRQkHAFp18T7cKrNkVT/F7zrgjRycIexG+aCucwPGqJ2I3kwIjLa2Lluq05XQmGjih12Xtr5BfGH9nTaQphDtMEM/NTuVy+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885694; c=relaxed/simple;
	bh=287aDHfFTNxKKXzxvsvWSRGQ7MceXfi9FELksZ/s8gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELFI/Na++/gWJOWDT22EAwlNqdiqOHhA0QyGO0e5n6dfYar00kDoqZIPMry/tTnQdSGqf5CQ77tKWgClub58Yb6DqLmkeJ+SPebfs3K+KPXqpJo3gUQ2o5/tqwYp/+khkHp9WoNB41TxcCwQ1bCPD9p/sYFEKrSZ4iQonv+E5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHSmuHZm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHSmuHZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DD4C116C6;
	Mon, 23 Feb 2026 22:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771885693;
	bh=287aDHfFTNxKKXzxvsvWSRGQ7MceXfi9FELksZ/s8gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHSmuHZmD143C6fEOcUWopj7Fv/hrL/xakQk9NjM35vQqDfVMnMY2v28sdmUDGcG+
	 Vl0jnLd0KGIX4B82DqP1B68mQ6M535tSlrSkgCPwjkseOY69MzGimoWGybL6z0l8qo
	 lQO7uYodarPjpNi3qWlKos3LZKdzJMBUXZm5R7d+2Zpv0Zs9X+5srPqfUpH3UmjBWE
	 mlviugKSUEFAafk0WsHUc1qRLkLCdp5dZXGTN+rxx1OOaTAu0ouF0PdqEZ3Z4F5zPj
	 NINvPLriKAD4Pae324i0Qtfo/ASrB2HgRpYEVHPHssMPIEuRyPTz1vjC2J9iYLTb8x
	 cC7a7cqCb/GXw==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] init/Kconfig: Adjust fixed clang version for __builtin_counted_by_ref
Date: Mon, 23 Feb 2026 14:28:09 -0800
Message-Id: <177188568476.2083280.10220783288827464439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223-fix-clang-version-builtin-counted-by-ref-v1-1-3ea478a24f0a@kernel.org>
References: <20260223-fix-clang-version-builtin-counted-by-ref-v1-1-3ea478a24f0a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 23 Feb 2026 11:23:12 -0700, Nathan Chancellor wrote:
> Commit d39a1d7486d9 ("compiler_types: Disable __builtin_counted_by_ref
> for Clang") used 22.0.0 as the fixed version for a compiler crash but
> the fix was only merged in main (23.0.0) and release/22.x (22.1.0). With
> the current fixed version number, prerelease or Android LLVM 22 builds
> will still be able to hit the compiler crash when building the kernel.
> This can be particularly disruptive when bisecting LLVM.
> 
> [...]

Applied to for-next/kmalloc_obj, thanks!

[1/1] init/Kconfig: Adjust fixed clang version for __builtin_counted_by_ref
      https://git.kernel.org/kees/c/8e795ac93b64

Take care,

-- 
Kees Cook

