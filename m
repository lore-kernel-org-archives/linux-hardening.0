Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9EB34B41C;
	Tue, 23 Dec 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511916; cv=none; b=JglMRDgoFVrP3DmcdVtkfP/Do20greHCqujjb6rt6GUJVFRUlHw8+PfQJQ1z9RsltprZuMBh2l79revps+/2chAXhaQVJVrtO7AO2e0EJ6V95LVdNF5GFIkFY5GA7whzbrRi9gmeLtaDIlHdKoZQb8zhDPZMH0k8l0OW4t3pfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511916; c=relaxed/simple;
	bh=IREpsCbPDjPXBUeM3hVpkzTdgens1z8F0+oisTuZVws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OvdyXOJY80Riiq/uzyyPl7dJ2K3sxVvQ4xLnUjM6P0DFfi6SZesRyOLrsXOqm8P/SwSb4R7mv/gjzkhC6wn9iT88daW9IR4/328P4TyF0459JRBy9Oy28X59ow5cxp9V0QEhvji3iLL7ZW8WBQTa+2mxTrQJ5ahNUm1/B2HUml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3x4O61l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3x4O61l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5D7C113D0;
	Tue, 23 Dec 2025 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511916;
	bh=IREpsCbPDjPXBUeM3hVpkzTdgens1z8F0+oisTuZVws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s3x4O61lW7g72WQyjOgA0jnBkV5RQhLAD5XHp8bwr9tmAIpAE1UGIxrfc5/+v6jlG
	 4aNHfOiPZf5XqAtci5PZLnaZQkMQRYtdi7dvd1mSn1wiPTXw/CDxq4IPl5wWR0iM1n
	 j0SIw6vABuVJ9X46iiSTEmLe0Rlvx/zhVRr9OvS3F5IAUHpC9A/MkSlG9w2j+Xtp36
	 QGOMfkcPkVifbVoVa60ppQ/yNNg483VPERAIgKEmRygWWyM9TbaUfu9LOeFH0jSrAI
	 vrzi52ZmBIxKhIVeq8UYtuswy5ojifLhrSpyf+9PUNs7AEdc4qRHbYfxNuzQCbxWNV
	 gtQfC+pUwHzfg==
From: Vinod Koul <vkoul@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Sven Peter <sven@kernel.org>
Cc: linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>
In-Reply-To: <20251214-b4-atcphy-v3-0-ba82b20e9459@kernel.org>
References: <20251214-b4-atcphy-v3-0-ba82b20e9459@kernel.org>
Subject: Re: [PATCH v3 0/3] Apple Silicon Type-C PHY
Message-Id: <176651191159.759340.7918107926279417342.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:15:11 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 14 Dec 2025 11:51:33 +0000, Sven Peter wrote:
> This series adds support for the combined Type-C PHY found in Apple
> Silicon machines and required for USB3, DP-AltMode, and Thunderbolt/USB4
> support. As in the previous versions, this is limited to USB3 support so
> far since the other modes need further work in different subsystems.
> With the dwc3 glue driver being upstream this is however the last part
> required for upstream USB3 support.
> 
> [...]

Applied, thanks!

[1/3] soc: apple: Add hardware tunable support
      commit: a722de305eacb382a5d306f9f8e502f81bab682d
[2/3] dt-bindings: phy: Add Apple Type-C PHY
      commit: c1538b87caef6b2783502c820457be092a7266be
[3/3] phy: apple: Add Apple Type-C PHY
      commit: 8e98ca1e74db2ae051c9b545d42b879efa5a2f6c

Best regards,
-- 
~Vinod


