Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0E22127B;
	Wed,  7 Jan 2026 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816993; cv=none; b=Uuq4PaGdsChKfrx6t3FUQuu/wt+zX1BYRs25fBE45+hucbzTPhS6HuwoMyuQWgsRsHnlCt+V00xBHWnKybvrPtg/fq5yO23B+hv5d9wWKLvCrstzd+rQ/apS6gImfa2h3jbTxftNPU7XfolV4blR/patYZsQX+fYvl2pCr3Dmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816993; c=relaxed/simple;
	bh=yXE5mW6EU0Dkm7yRJUPHiFhRN1r3a4GwncQdDCSjnBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kg+P2+xMDIKaSWvJRkhuYt5zz7QzKa+PIcyfSBzMLth+JV1DCJT96FF3ikj+hOQhe+VJtxv5o6F+pipetI2MY5BS4R4Mz+1vUQ1g1hC7CdvaKrhJHsFzVcFksT4XIaW2wiZ37ro2KL85jtXPhJmiMjbSNLdZ21YbECkseIF/0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raoxuYrp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raoxuYrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739CCC4CEF1;
	Wed,  7 Jan 2026 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767816991;
	bh=yXE5mW6EU0Dkm7yRJUPHiFhRN1r3a4GwncQdDCSjnBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raoxuYrpsIpxtlJZ8zMpgmhnpALQ6FoZqYiVM4BVUlXNM8xB0crPIT/hFt5lw2tV/
	 BUCi1dzBjWsxM+4RgRYpFuVtCX7+nGPcPg4howVeubk1bCgTykGTuQ91NxyjD8rres
	 /GewoK53bv3hxpLAiBdWp8RE9+SzGbFoW3m0Gi85FMq38LA5SVeXh311pgaYQbVZUl
	 d2FaDrnkjVE0klPFfPGlFPkZB2JoDNU0inQyMkCxr2WSAGvMmO9v/ZEye5/mOYUKLS
	 PwbNKVxeVlMJOFsMVLzRf2a2OUJGmlOcK9BH/MtTBcZDkcrU0Zk7YmPsaxu0AfcLMI
	 RyGaPn6O1K7wQ==
From: Kees Cook <kees@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig.ubsan: Remove CONFIG_UBSAN_REPORT_FULL from documentation
Date: Wed,  7 Jan 2026 12:16:28 -0800
Message-Id: <176781698614.1598418.16480180348554919684.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107114833.2030995-1-stefan.wiehler@nokia.com>
References: <20260107114833.2030995-1-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 07 Jan 2026 12:48:33 +0100, Stefan Wiehler wrote:
> There is no indication in the history that such an option was merged to
> mainline.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] Kconfig.ubsan: Remove CONFIG_UBSAN_REPORT_FULL from documentation
      https://git.kernel.org/kees/c/1d1fd1886912

Take care,

-- 
Kees Cook

