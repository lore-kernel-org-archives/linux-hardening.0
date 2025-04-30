Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6C3F9D2;
	Wed, 30 Apr 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038984; cv=none; b=WEtQt05d9ey7uZtkkfPDoyqhfq5WWcQDFfQjBjE+DmrCnynF4PCluk2aOMlxeEedDbHBvYwEZnZR2mfZ/tV9HR4SyWioxWweHqvqPzmGITcTmeF51Z1yMM1bRfTZD6dJ/B9FW8KBnfwofGSwkXPyFgVG5RBNzFVq1Xfab0ILlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038984; c=relaxed/simple;
	bh=gYZVW37oaaEysM8J5GVPaK3yFVPSginf17/UT7X3Amw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZ8BJIzh+ivypAC9gjxr6p5vOV6FRyb53eD696kbwlL/W/eCHhuyqWId8K4TNCJuBRuC/wlyjwGFIfsZ850pCQw9bVC/QgTaNtpQLHNNvkZqAOBWVvmPJBca1MjgylVyf08EJwZEMYP/iAExoQxTnYXzqMYSclcdMDYvmAR9uPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAVU8ANe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAVU8ANe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7E5C4CEE7;
	Wed, 30 Apr 2025 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746038983;
	bh=gYZVW37oaaEysM8J5GVPaK3yFVPSginf17/UT7X3Amw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAVU8ANeTgPCkRc8OzbcCSZXoZgBTCPi19FYuHzaH2WrROONh8rhwJ4ENdj8gdudT
	 tqK3N6cvgZNSyQp3jVAFVSglU58oF260aT8vCGnYueJBmyp7zDp/G9TCWItgf5NRxn
	 TaPPjHfKru184r2y/9Ew0ifcYQyzCrjdJ0kbCRlQKuUUrW+2nrkRuBo4Qr9KNcf+15
	 yViMtsTK9FuP6oNbJ3DWpJgxo8J6YbvFIzUQqg7/xLmpSVxeUE8JQZn30QwQkPJ1Zk
	 LbCnE2rYKPRoczQ64tETzSGaM5BMvTBXxiTAIlR6k26qV4w3pqCVVWUj61qhhkevMa
	 1jG1SWnkoojVw==
From: Kees Cook <kees@kernel.org>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: Re: [PATCH 1/1] hardening: simplify CONFIG_CC_HAS_COUNTED_BY
Date: Wed, 30 Apr 2025 11:49:38 -0700
Message-Id: <174603897563.2038935.1424040118974988068.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430184231.671365-2-kernel@jfarr.cc>
References: <20250430184231.671365-1-kernel@jfarr.cc> <20250430184231.671365-2-kernel@jfarr.cc>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 30 Apr 2025 20:42:31 +0200, Jan Hendrik Farr wrote:
> Simplifies CONFIG_CC_HAS_COUNTED_BY by removing the build test and
> relying solely on gcc/clang version numbering (GCC_VERSION >= 150100 and
> CLANG_VERSION >= 190103).
> 
> The build test was used to allow unreleased gcc 15.0 builds to use the
> __counted_by attribute. Now that gcc 15.1.0 has been released, this is
> not needed anymore. Note: This will disable __counted_by on unreleased
> gcc 15.0 builds.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] hardening: simplify CONFIG_CC_HAS_COUNTED_BY
      https://git.kernel.org/kees/c/788d882e609f

Take care,

-- 
Kees Cook

