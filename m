Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48A36D;
	Thu,  6 Mar 2025 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741241163; cv=none; b=JJyq1wG3kQ0gT196LseesgW7e5U0n5Gfh140CCflyeog8H+c5GIhu5K26H8XtAW+jpSEaCFF/BEUJ6ZP1UJzpzKNa/7Ngt6aP0R1TQ62r5NS0tQGqyZkOeMi+H8o8QieapT2URprAX2OHwkC8lyioFQC/k8RpGhrYY81Ha6HliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741241163; c=relaxed/simple;
	bh=6uOFPmnt7OP8LsRu9Ys+3LrGnRW1ssUqbDyHLzu/x80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTf6L8pHWr+WuwoREdQMGMfeYu6t8OYnzTnpvevdxVm1aIeWGhySS9RuCxn49rNKybyV1c0KfnpXYlDhRRapZ4Ouh35ktsJjl8ilc0ZR6TPRTBZoRfwY2WX98fp4iaKr94xwZuIrdGIOiLuriNQbu1/aeMckAa1cAmqq/3mTOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLu20lDQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLu20lDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6609C4CEE4;
	Thu,  6 Mar 2025 06:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741241162;
	bh=6uOFPmnt7OP8LsRu9Ys+3LrGnRW1ssUqbDyHLzu/x80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLu20lDQtAhFn9UCwWfyzAQeIi0tlEcahj+Tkx6ttQUXsiCpPq/XK5Kli6g1xmFy2
	 wycB41/sXMNEVpYH8GiQS8pFAeCNaSs93hrAebYTd/b2pY0o6otFV8IsyOZcI9anRx
	 YBC9vdi/atGq7UtVSuqOUTaDyWKSjeCpLE3hRSVuWTAtaSys/Jf3EFUgRZXoG42GG5
	 e5jVUjqO549F8R+moencmJzNKupWMrmQl935f56oWlCHAjbFOyChrile8YrYNFrhnD
	 9QtuIP9RsFQnaxLCZAvowhYIHzEMXHElVqF/lIpbOUQ2wOr7qAl+QdianssqInTMuS
	 d86I6CW1D+K1Q==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	David Gow <davidgow@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kunit/stackinit: Use fill byte different from Clang i386 pattern
Date: Wed,  5 Mar 2025 22:05:22 -0800
Message-Id: <174124111820.371215.12037584866390434063.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304225606.work.030-kees@kernel.org>
References: <20250304225606.work.030-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 04 Mar 2025 14:56:11 -0800, Kees Cook wrote:
> The byte initialization values used with -ftrivial-auto-var-init=pattern
> (CONFIG_INIT_STACK_ALL_PATTERN=y) depends on the compiler, architecture,
> and byte position relative to struct member types. On i386 with Clang,
> this includes the 0xFF value, which means it looks like nothing changes
> between the leaf byte filling pass and the expected "stack wiping"
> pass of the stackinit test.
> 
> [...]

Applied to for-next/move-kunit-tests.

[1/1] kunit/stackinit: Use fill byte different from Clang i386 pattern
      https://git.kernel.org/kees/c/d985e4399adf

-- 
Kees Cook

