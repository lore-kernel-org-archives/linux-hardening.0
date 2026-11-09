Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230208;
	b=zrFZNlXTFdJghXCT07O5gixiM3Kdu2zvA1LBADlfZN9KqSdUuVyEoppnqDMStGJON1e8
	 TWySd74q1oam0fGbKCmZTTKultiwRhe4upPvgTzBRucFyITm5p0Dz0+71a3s3YNe6GlEa
	 aV06DfZNUA/Kt8y96J+zoRCOEAi4kxdCRM5VZ4eWhkM9q9ZAfuwT+5kXMFOrRcanytfDH
	 7H6hUmUoovaVIhiEATEeVC9DtWFb1Dhp0hDSHfo5XuskZrw2OajGgpgq4KlHitdciA3p4
	 GUVee+1rFY+/UfvOyZ1rGlEXQY9sp/E5kQL7eP3sif1KIgdTWCmdMB8CibJnXfwpulA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230208;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DJZPcRbincN2Flmn0XzWIYGVCGZ+6GUHIJvSkNagofM=;
	b=RY8rGAhTTvoENTMHqMkm5dB6Y72opD5zn9WO1omb+Z2oj3E1XMSO1F1A8Uqbo98/6aRI
	 NhjIZgL7YPuCJl9A7QEN/mYp2fTkR3TkYvj8sYy0eMLXPk83tktdZe4u6Zy8TvyMjTDrP
	 YWtdy1FnZltY/gK+7CeuI4amrJf8xTkAI0tO1lTnotvvbMD7cz94n/bYPL7Kme7t75m3Y
	 +ckxm02wLP/et0JLjY3n8fbl52bUKlRMJsphbB1pnkuXDML6aRJOqNppCVeLO/z3+ra1s
	 HSAXhZKr/LwF1ipMhdKuwApVlMfV0G/SAmf1g+fCQYJi0z83gTl7p0jUfayQAjZNTBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzFxeMox;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312B606A325;
	Mon,  9 Nov 2026 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzFxeMox
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422911F0089F;
	Mon,  9 Nov 2026 13:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230208;
	bh=DJZPcRbincN2Flmn0XzWIYGVCGZ+6GUHIJvSkNagofM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QzFxeMox9FdkZ2u7XwmZNmFg/6SH/4OkYDiOeM/es4Zkigp73LJCh9RFxWqhkbBwd
	 bOhikqceoK5Teh87RaeaA2h9iKGEUyOIRL4HEtXcUN9yfCIMYn9QlSRdNKMwQQcNMj
	 vtjH9LanRUvxBgWMEKhhmUHnOzo+37FEZF0LDvjN9edS8vTjKnkk8mLNFKpzY9gFKo
	 75rMKNCiMK9plFuUXXycbajy4nHzqPBArHWrb+6CPqqaaOj9bCW+ja3C3r1+v9GwNZ
	 wl1ITNQZGJy8Q509MrXDq0ddk8RCvElmhA7NP69HGoNIloXGOThV+snSyuO4pqgkLd
	 nAvhA9b5Irv7A==
Date: Mon, 9 Nov 2026 14:16:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org, 
	Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: nuvoton,ma35d1-pdma: Document
 MA35D1 PDMA controller
Message-ID: <20261109-petite-imposing-ermine-fbbbcd@quoll>
References: <20261109052900.2960473-1-shanchun1218@gmail.com>
 <20261109052900.2960473-2-shanchun1218@gmail.com>
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
In-Reply-To: <20261109052900.2960473-2-shanchun1218@gmail.com>

On Mon, Nov 09, 2026 at 01:28:59PM +0800, Shan-Chun Hung wrote:
> Add binding for Nuvoton MA35D1 PDMA controller.
> 
> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
> ---
>  .../bindings/dma/nuvoton,ma35d1-pdma.yaml     | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

