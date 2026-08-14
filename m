Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0D3B637C;
	Fri, 14 Aug 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703699; cv=none; b=Yfb2KrGlaUb1t9WGegOxU7cvMvzhH2nzWgvpfKtbm9JxWo/LKZe5zHhirLfO8vo1HKzUieVuIsnRlDyQN5RWowWqAyOfkasy7qcPz0H/l8va5XkyBSoaH5Jwt/fzAYbNOgxmFBNqKi8aGkEPBijPH/IL0HRvNmWQzxp1chJr50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703699; c=relaxed/simple;
	bh=jSgH07T1T1GPvz2qg7Pd/HQPLo9H1ZT4I3dPszGWKXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+dsY+tyyWYQzODRn5xZ84UArYurMH3NoGTsLLe0GfrmWqCz0ZBain/zsCZlMif0XiC1QVxeR7+lpa4Y3CVYXijZNEPkLSOrPsE1Mxb9iaBqOWT47EH0q9UBs9PqVbzI0Q/MdqvDs/5wJACprSn93TLwBZpuUZY4xCj8s7kn+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMkKl8fZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMkKl8fZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0F01F000E9;
	Fri, 14 Aug 2026 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786703687;
	bh=4RIu9UZ9bVZVLDk/aNoSWVU7vQlBGpgluA294lEBvNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cMkKl8fZHQbHiyJDHDx4ntZfVQJyqXZK+F1XzupY/GgrJ6MJ+7aldgS0kpe2m5a97
	 BYvYvE+yZY6NlBMItJHc4rfWyOESUjWcBOb9ouW9F9Upmsl+FuE6Icdp6QTK8kOqAj
	 /unLnKbbAzTKR++n5TolvbAXuUMphKjU/zxpAei/XMzEA2VNLBtjxDS4356Rw0F7K/
	 1KUix4Z8OiDC3jN+njAgEiBh4kYvWs8Vi1ztG6u5Ke0AmPwbfOneuoZkA/xLYgEthu
	 BQpjuHE2WwjPSp5P3uzBaE5pWqZfz4GrHJsTS3GPihJqz732eW38Ocwr7X2S2J87WM
	 Ev7wbmP612BIw==
Date: Fri, 14 Aug 2026 12:34:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: arm: qcom: Document Xiaomi Redmi 9T
Message-ID: <20260814-amazing-flying-tarsier-9e78ca@quoll>
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
 <20260810-next-patches-v1-6-79a779d76173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-next-patches-v1-6-79a779d76173@gmail.com>

On Mon, Aug 10, 2026 at 06:55:39PM +0200, Adam Skladowski wrote:
> Add compatible for Xiaomi Redmi 9T NFC codename lemon which is one
> of variants of Xiaomi Citrus lineup based on Snapdragon 662 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

