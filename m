Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474269;
	b=IdoojsoHRFQm53Q4+mTN0ezbK0BphOUG9qz7/0K9pKDXNcrGjSi/+yHT4smo8Qmi9BO6
	 WBUUbjy5eUyALqhYK5W4JiYgFsTo3wq2jB0hPTqAZIqpVAfKhf1rc/QiQrevJRr9ng4vE
	 axeY9oxuQXam0JYMV3ORDy3rScshFFxOkjucE215lo3+RCFsUu38gMFvTyOEIAe0lRKZX
	 47psU5ks33QKt/MoS88eEQzffInB9fRY7HwfthF7nhg7Sv1XLqDb7WgkEmRTCZMGjYvQf
	 bF4ggpTqxWhyFU0xtKZKMLaQmTBc3LsUqnIX3jIrPmND2LFJq+pgPMecKDCX2YENmgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474269;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=5uJWM6hL0OFVMz1J4hGBkjZHthmHVX/mwHx5mjdhReg=;
	b=h0qQ9VFv0cDtBbxla4QOmihB7GFcW+Ml8RbPOU5d8x9uBDsxYpCxs1e9OWmIziIOAZ+R
	 IgfbmbLF4JEalpkZ8FBEnqEcGqB7RFeLuz63LetEZMNxD00yBS3eTA+q+T7kcsqFsPQq+
	 kve+sx3PrENvfjCi/EznAY5u18NY1B1i3bPlfuzoNvgn7OxWaXR7ZNbkzAIyZQMhl+wk0
	 +XQziMwl+46/4Av4ckEMZoRZpQXPZ9ReKM/IyHiLWEx0QGNwraSdFykz+g3/YhYEjsKDH
	 1n7nA/+F8zxT20LgO8IlXp+advy4ikOylamYDeExHIXQtPJO7b0nIePeUAiTC8o0Faw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdD3hLZD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61D606A327;
	Thu, 12 Nov 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdD3hLZD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270851F00A05;
	Thu, 12 Nov 2026 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474268;
	bh=5uJWM6hL0OFVMz1J4hGBkjZHthmHVX/mwHx5mjdhReg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VdD3hLZDUMoBrhfsRugQXHfVgOiCbalLv3tWkvQDodrYpDyue2qM5h0ZgomI4+U1k
	 clUBAob+tgORvjhg7FTTNzNogOIfDTD0TotNdWVkAYPHjxWVFaXuq9IWOPmvpm1TkM
	 JCkzbKBZYkcbyXno15REeEs/Dd5oT0jFBqevwXNJwlEPg1X3IE/vtDKUThzB18GiPF
	 a6q7DfuhcPkMwIrDrYBVKU77IYO1HOOoIF/i6NWFPWaNftO68kzhaztHhgc9wgOc73
	 1W+2+xltmPKGGZ7e74qM2jih9dyVBUAB4pjGi4eQWKQfep5wddtnk86T3EDavPBFhR
	 1EI0fkSAj/Epg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, Rosen Penev <rosenp@gmail.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20261012173402.24568-1-rosenp@gmail.com>
References: <20261012173402.24568-1-rosenp@gmail.com>
Subject: Re: [PATCH v3] phy: mediatek: tphy: simplify main allocation
Message-Id: <179447426479.428303.7583249997534314852.b4-ty@kernel.org>
Date: Thu, 12 Nov 2026 14:34:24 +0530
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 12 Oct 2026 10:34:02 -0700, Rosen Penev wrote:
> Use a flexible array member to replace kzalloc + kcalloc with a single
> kzalloc.
> 
> Shuffled some code around as __counted_by requires the counting variable
> to be assigned before any array access.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: mediatek: tphy: simplify main allocation
      commit: 90ebdb0cbfa1cc1d23fa275ef96897d42b29503b

Best regards,
-- 
~Vinod


