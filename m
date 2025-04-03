Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890642A96;
	Thu,  3 Apr 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700702; cv=none; b=P9td5ZdsGDX7Zl55AOlNQy8MSG1quhlX9x7nVj/nDxkVRC71LXFD92wMI/+l0vtyIoPnEj2HKNEtCK6ufiKZiNE/JEyfkOMDT/WSQUYEyt/0uwgd8z6oKZ2snX3qcPR3HoQWNX4pV9m1xLTcOleHH6XSk8/MlmqvO/irh0l9bTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700702; c=relaxed/simple;
	bh=u551p3B+/Q3SCBeCyz8ZTx/D2fPm83fLdwGtclyn2aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqR/y/6jM1Ou1oLD7ZL1kn0ojUZFOrWy92PPnq22m7EFA1RbSxZr3VpzAT67WXbZO66PBsp4rrRiH1ucv4zsEj1/L9TtJhtyZsdUQEuXzEmtz8rpwMlyGBFyjU1QvW/bNlNbCMpaOW9xdvLL8YM5ZwbmMjOJHqhfXN/pGHZ7VQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftnlgzhM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftnlgzhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E2DC4CEE3;
	Thu,  3 Apr 2025 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743700702;
	bh=u551p3B+/Q3SCBeCyz8ZTx/D2fPm83fLdwGtclyn2aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftnlgzhM3Kt73GSmeiFHlwJV2AJ71i5QQGU1OzzZk1lZUZpig7xhso9VxayMvdHX2
	 gXa9mz21aZrMy9F7waLwDRNdFouifTxkXev7EmFYJC2Hsx7gLiMDnxUH6wDcdVqfsT
	 EuriO+gl2FKL7aKJ3gsDCxSi55X3dZYWwqsU5bl+Aj9Rb8Xdvf/Z9Lht29qN2uD9vK
	 tBYT/1APzVKJ9d8EDoY5uNJVUdesJ6xAINqO9JZr5fP8nyqraaclBNNaHisK/lh+ET
	 240+u4oN1h3+MFverWqhcInheD2cmWJNTmPAhMvNTmsJPaiOCTgGF7dd9uFMZqJF+8
	 9AgYmpVwHo4pA==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add wcslen()
Date: Thu,  3 Apr 2025 10:18:17 -0700
Message-Id: <174370069511.3176651.13164537009477685490.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328-string-add-wcslen-for-llvm-opt-v3-0-a180b4c0c1c4@kernel.org>
References: <20250328-string-add-wcslen-for-llvm-opt-v3-0-a180b4c0c1c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 28 Mar 2025 12:26:30 -0700, Nathan Chancellor wrote:
> A recent LLVM change [1] introduces a call to wcslen() in
> fs/smb/client/smb2pdu.c through UniStrcat() via
> alloc_path_with_tree_prefix(). Similar to the bcmp() and stpcpy()
> additions that happened in 5f074f3e192f and 1e1b6d63d634, add wcslen()
> to fix the linkage failure.
> 
> [1]: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] include: Move typedefs in nls.h to their own header
      https://git.kernel.org/kees/c/21592017d384
[2/2] lib/string.c: Add wcslen()
      https://git.kernel.org/kees/c/61df817d1d1b

Take care,

-- 
Kees Cook

