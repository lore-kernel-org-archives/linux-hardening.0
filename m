Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6E4CDA0E;
	Mon,  5 Oct 2026 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214990; cv=none; b=K10X2GhDv4sGiy4+fEWwX8+480eC3fKQ81PS0q+dPzFESRdpcC/bT+EDusDW5xYGaij8JTEF5vmxo7qQHOMyP9NjxLFJ3DVRCAq5cwoHqRb77BkPjYtadXhHMm1huE3mEoChvW07aBNLiSVwBTaVYOqgl+8XYZEh/fY5Hlj/X7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214990; c=relaxed/simple;
	bh=TZ37uppsEKT6O/lt70QLZZW1s9HfosgORGRDGdRokKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=daOaDNgnYd+gFWUV0aTiVZtu7NBd7sniSG0LS2Zm4HQZ+InDq6Im4WU2mCYLBtfatWKogq7065nIJcVPtiNUJnorA7lxqieWSoyDkq2QDfOmUeCK75rJ3btcbBdMNPzVcznFVFbvt9zGovDMUDxdfIg3chbKDyBBAlDSCVopC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ8VS3Dl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ8VS3Dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F076F1F00899;
	Mon,  5 Oct 2026 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214988;
	bh=Q1Vfx7NrxHZYYW5wQYD7P1oRNFAFAgPBJklq3qG+Db8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QZ8VS3DlM0nG+JWTLc1DKFMUZcfUCJzceZk2H1N9tb5uP4m/xH6GS1DKTl/6q+0Xw
	 Rsdc3xKVZnMgeMbB+iCO1HnRnhRX/zFf7H3cC2TJB/s5sPJ3Rs9qt4cefXKoKIIlsA
	 ev7ZcFrqmwtmjyHnlVO7rDhJsuul/aI+oOoQtCVC6ifhFg9NtPOmtRFXAF7ZPDIQUC
	 fJ4kQam4r4tRpn7mOJz45gDnkFVpEIc+KAbBlN32G1QlPJgClFjzeZM0RSh2pnCcXz
	 Zd47isaxvvS92HMx2+x1A53HJFtmn4oPkimxfHPPxBK5MGqSU1pwNZ0XcA0hJ8UilY
	 mYFyRGyTc4ZIA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260903-amlogic-dma-v12-0-f769bc344056@amlogic.com>
References: <20260903-amlogic-dma-v12-0-f769bc344056@amlogic.com>
Subject: Re: [PATCH v12 0/3] Add Amlogic general DMA
Message-Id: <179121498561.358863.6559293781501344071.b4-ty@kernel.org>
Date: Mon, 05 Oct 2026 17:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 03 Sep 2026 07:38:27 +0000, Xianwei Zhao wrote:
> Add DMA driver and bindigns for the Amlogic SoCs.
> 
> 

Applied, thanks!

[1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
      commit: 9d79e5efaf7b908fd3eea1a6afb34fc06dfa1d7e
[2/3] dmaengine: amlogic: Add general DMA driver for A9
      commit: b84b5197e344e2d378a9edf5d782b6fbddff8d06
[3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
      commit: a5b2763df36b5c8ca0927f24ee97d9617e4eb6eb

Best regards,
-- 
~Vinod


