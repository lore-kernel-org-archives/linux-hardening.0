Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E8EADC;
	Tue,  6 Aug 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722918347; cv=none; b=sT8xPM/J6GOTLTQtp+DuUboZU3ex/ZtNQ4bxxLsuDOGBOIK1hcTffJ41Y4qXJch0QFfD9dYAGjOtaivqRuo//V/vl8Tnax8/xBUs02ZLGMLyUEViB21kptcV3yxSjB7V19kAk6ggaJ1m4BrykgR4fV+rhpDrZmbohpiogieVXXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722918347; c=relaxed/simple;
	bh=QeaQwtTB7a9JnjAXEkn+Bx7klIr5PDhTwHeCV4i+mJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnZ6/gJfZn3GpCcRPCJV0M50fWkcUzJgirDyr1Yg5bxWx/yWMOpjB466YFUcllVNEByeb6V7ahMyEnOmOT7RgcUyHk9Uy2iBi1MgVnqU/0RNXFX/eelS6Q/CJMYJ9Ux9irmlFO1jV1EXfOCftxSYwFXz99iG6zDs5hDdP/o1XcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCNIdKy6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCNIdKy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5970C32786;
	Tue,  6 Aug 2024 04:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722918346;
	bh=QeaQwtTB7a9JnjAXEkn+Bx7klIr5PDhTwHeCV4i+mJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCNIdKy66bliwZZ4yJaswWsFzhir14J1fWrdG5g3pWdEfmaQkymhuCxI3f5txxx/B
	 6d5eecZdgGdKdcMmlHPayA4aMW+Tq+HuyC3ceUK83QEI1XupDMyBdFEbAh5G9FbZRf
	 S7IoS0S60g5zubBOJ5moq2SSTbQtYZ39ND7nXToE2P8m3xrnY7SH5lvEShcGok9e2w
	 /KtC8dRoqui+UAY218fm6w0Tjbjv6wrYD2zf88Q+66AjvXW9OtzAy+YgdgGR4HwF50
	 vRedK4h1aqbOuBCF34sf+R3kmJEgogEpfy2OOsV5CG+VXi7zPtgGcGQirP2VcHNaet
	 u7UYb2QR13Gvg==
From: Kees Cook <kees@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 0/3] fortify: fix various issues in test_fortify Makefile
Date: Mon,  5 Aug 2024 21:25:41 -0700
Message-Id: <172291833913.3365241.1557417143670946391.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240727150302.1823750-1-masahiroy@kernel.org>
References: <20240727150302.1823750-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 28 Jul 2024 00:02:35 +0900, Masahiro Yamada wrote:
> This version fixes new warnings for GCC <= 7, which were reported
> by 0 day bot.
> 
> I changed the patch order, as 3/3 is the most controvertial.
> I am confident with 1/3 and 2/3.
> 3/3 drops the test coverage for GCC <= 7.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/3] fortify: refactor test_fortify Makefile to fix some build problems
      https://git.kernel.org/kees/c/61b317f70aa7
[2/3] fortify: move test_fortify.sh to lib/test_fortify/
      https://git.kernel.org/kees/c/728dc04bc4e3
[3/3] fortify: use if_changed_dep to record header dependency in *.cmd files
      https://git.kernel.org/kees/c/634a52a98f04

Take care,

-- 
Kees Cook

