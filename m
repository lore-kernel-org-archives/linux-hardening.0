Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66E363086;
	Mon, 27 Jul 2026 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147513; cv=none; b=ux/l1lC8K7qo9BGfTv45VfYNn8+7aavmZYH33tKX491NOGX5qjlA6WCGbThGbY53bpVnnAfDvvf1JzOGlTUrJkvU/VkfJQ07OD8KocBIASY+kgUfsu8JooYM6qjONYyyL+BfcbWiGqZwOtyjWJRsTMrdeavfvurrdqMKB+GfQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147513; c=relaxed/simple;
	bh=FJGtBD/HNNTebW4zNpWNTug6kO0z8qBgRCQxShB3QC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFxJTy2fdQ2v0vVGk3fFOaRPk8RIDgBj6DcFzIY3cGRDmaCENbxzMgTDHc57qN7abrle52FY8cqzOMZ0WRex9axm6Ns7C6FFKX1rOUY5BNJMX8o/o2Hvqmiz07jzUWzVIyMfVfAikaviNI6fhjVsSjIjJPkN9Aqex5ruppQxA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT/ip6M7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT/ip6M7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC941F00A3A;
	Mon, 27 Jul 2026 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147511;
	bh=dYQwJyuPm8mudO0A82O+YdFMew2F6X5ocyHqJKJlVts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KT/ip6M7L+3VK1XpOBQn7hYOugi9szjNGfpYyqJ0BoSqVMihiw0Ma0Vp1rmeXkxsw
	 ezt577ls+SXAzVcmlwtmACP0uGuVzXPBKsp6tQrYjts1pROtqXgBJ9YBP2ULo4KWuS
	 GXifjhDzV4srf0ChfpaO7sUBECKTUX2S6YNvByfsz4nTx1a1mwBVHGtwCDGeiItdtw
	 90fSLMz7H5tq2cT5sCkjG6+T4P4vkhGNwxyzQsD2HPoxUbvWN78lty9DOQbBU2Lt/a
	 qsCF9lE2KqhoAQ5rI06208fAY1kH4qDKr++Ez3D3YG7/U41CxejmY83IEqWXFTM105
	 JraMshIDVPGkA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	david.laight.linux@gmail.com
Cc: Christophe Leroy <chleroy@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH next] drivers/bus/fsl-mc: Use strscpy() to copy strings into arrays
Date: Mon, 27 Jul 2026 12:18:00 +0200
Message-ID: <178514745085.65524.5154457607232721554.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608095500.2567-1-david.laight.linux@gmail.com>
References: <20260608095500.2567-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=398; i=chleroy@kernel.org; h=from:subject:message-id; bh=axsqdnFVyozTb7QT2kt9d7xybmK2/K1u7HJn6I4CUT4=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSlGyQ5hnLK1M0VbCy2akn8f4LthAHL5WX+enyzXivzM TZnMXl3lLIwiHExyIopshz/z71rRteX1Pypu/Rh5rAygQxh4OIUgIlc2cbwh3/dbitrpTkSv1ax cF2xt5x8Iq/MMdoy8llDxbcuw3R7MYb/Od4S82bY9GepO0xaeGe9U96utvX78/yWK/7ziazepd3 JDAA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Mon, 08 Jun 2026 10:54:56 +0100, david.laight.linux@gmail.com wrote:
> Replacing strcpy() with strscpy() ensures than overflow of the target
> buffer cannot happen.
> 
> 

Applied, thanks!

[1/1] drivers/bus/fsl-mc: Use strscpy() to copy strings into arrays
      commit: e0bdf39890814b5dd5481c8f9c80c5f8399fa6cb

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>
