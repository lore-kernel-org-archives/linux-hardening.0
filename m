Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219492;
	b=nGuECsdHA1jBuV+MJLyxbgX2cwx4lN2khGyHlZSav7F26JASxN+/bC9Kuz+8/Vk8u2SA
	 mkkZbwtwNyn4NEM0VEDMESpTxO+IQ36x5xTXhNWkKB6p1kiynrnBEW94kT7SifyhMa0fC
	 Mf+iJmUDzD4WodLIqgTA7EE0xi9fUFWEu4gGAjJpfJSU/JJCLEfzhnqiDzRXLpnV+SBwD
	 CtIOGHGJRtG2FCMqDTs5Dia2RAf+kP2Xf63ONNRgUdZP9VP4Ikb9KMF8qTJyOzl9JTgvf
	 JNkFdMLASv+FCfVR7EU2psklC18Y9lFPoHMycpk70io3mli3hYLOLg/0k3Tx8pSW2Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219492;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tS3Xp6G1E7IqjUuDm81uq4tk6Bv4TIsCASJM2TgszDI=;
	b=iuhhkb0fQQ3Xa7qeg+o6HHk7gQFGE8D/V2wTOvtO15hV2Rjw/qaTXU0Trg7PvNCKK8qm
	 oINsSKjrxPkgjbNl0QdlvGXX7pG3MTVCCuTaKh5hsdMiplOql3xDaN98tX3Sm1zbhe8fc
	 S/qkek9dcuWFMGJmB4JsD7dX19Gz7d9ITq+cA36TgQg6jfiW9H+bgghvWzFEGRCS0h2iU
	 sZp+Im5K/YVzR5S3dNhL1UKLb3QVF4ZIGl7W94cbEz6kr8qW7EXe5CMuHGhoJwDG4L0MR
	 HJUbO8EaOuhOqyi2ccjunV8f5Gnw8f9CnXZ5oBspS9hjj0aDomLFQrNfpPmlukBWZxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEmWI7yt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93E606A333;
	Mon,  9 Nov 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEmWI7yt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E381F0089F;
	Mon,  9 Nov 2026 10:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219492;
	bh=tS3Xp6G1E7IqjUuDm81uq4tk6Bv4TIsCASJM2TgszDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YEmWI7yt9mV/agp7VqCcJqXsGHyA8VPAeSfca/TMwVHukr59TpQ3D0Sx6fjzgue/k
	 N6XfpwcJL8NKSsmhxSpGxFAwjSX8RaKkLaHg1bqSfAivlJ9X4SJB7O12YCv9dKAgdQ
	 tyAEknzg7yUmtVFjmNde+h4c43/BpkoHsuHEJmkhfN3OVrWp6uVjCuHbLnauKyHuz1
	 +2Cbh+JSG2cULLJaPVzuFhf4gJkKnNKblPrZJkEjM0PTodbjoeHvZTNGEJH/Xj9RT7
	 VqckqrcV1KvDrjB81F9ZbqdJSssRl8SLaa8VrIqMZxWV2eNZKmFLsfWhaYFvjszK7D
	 JTQ6fa3wa5rfA==
Date: Mon, 9 Nov 2026 11:18:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junyi Zhao <junyi.zhao@amlogic.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev, linux-hardening@vger.kernel.org, 
	xianwei.zhao@amlogic.com, Kelvin.Zhang@amlogic.com
Subject: Re: [PATCH v3 2/2] dt-bindings: i3c: silvaco,i3c-master: Add Amlogic
 A9 support
Message-ID: <20261109-bright-wrasse-of-promotion-50ddae@quoll>
References: <20261106-a9_i3c-v3-0-804b69b9095b@amlogic.com>
 <20261106-a9_i3c-v3-2-804b69b9095b@amlogic.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106-a9_i3c-v3-2-804b69b9095b@amlogic.com>

On Fri, Nov 06, 2026 at 03:13:09PM +0800, Junyi Zhao wrote:
> Amlogic A9 SoCs integrate the Silvaco I3C master IP in two domains:
> the EE-domain instance (amlogic,a9-i3c) takes "pclk" and "fast_clk"
> like the NXP integration, while the AO-domain instance
> (amlogic,a9-ao-i3c) lives in the Always-On domain and generates its
> bus clock from a divider inside the controller's own register space,
> so there is no external fast clock and only "pclk" is exposed.
> 
> The two instances differ from the vanilla Silvaco/NXP integrations in
> clock topology and required init, so the driver matches them by
> dedicated compatibles instead of the "silvaco,i3c-master-v1"
> fallback: a fallback would bind the generic driver data, which
> neither programs the fast clock rate nor handles the AO internal
> divider, and the variant would then fail to work.
> 
> Add both compatibles to the schema without the fallback, following
> nuvoton,npcm845-i3c, and use per-compatible if/then conditionals to
> enforce the clock counts: two clocks for the EE-domain instance and
> one clock for the AO-domain instance.
> 
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> ---
>  .../bindings/i3c/silvaco,i3c-master.yaml           | 26 ++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

