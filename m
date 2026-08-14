Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBD3D6CA3;
	Fri, 14 Aug 2026 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703671; cv=none; b=uZNKBwXVQ988fmq3v80sW9Fg+caAAY67Zkq7zhqoUrfcgRu7hf17oyAwNaUM2N7wwD7EHw8rUcAUV7CvRGcfekQdGTSOB4He8ArbVCqUW4Omx4tSzLKip/NtB2r3raNJoU/flTl6/ED5ALK7QDEU1ol9Fw+yi6SLB452p8PIbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703671; c=relaxed/simple;
	bh=NgWLGupja1np27c5LhF6x/ZRkPSUawWG9LgyGraObkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f49QjeUcbY0mC0MwTCRk/MExxdHERVIreZgi7nW7c1tC8pl6Jux9uP44XcTWi0DOZbrCtlNld8jHWeXUY6Qx5gdxO3sMfnSaidYjYr4XrlOiUNvwzmh2/3G8NNoH+ChDX4O1g9uI8YJH7TPF3EMLdpB5vYk0sDcRTe7yJWAOXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A713bNVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A713bNVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EAE1F000E9;
	Fri, 14 Aug 2026 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786703661;
	bh=zLEpjjvjkMci6i0MeafGvpEGe46uOhbCMq2WLnNw7nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A713bNVNI2gHySO/Da51E2uRnVHCzPCxPNtPXF3mK7lipiL7ksDdy1Mo08/W42Djo
	 xJ3RHUFRquqtm/TG0AL6wHaeVL0HjgZ18G7305jlzXJVLaW2uy8KStAC4eFzGCwXXK
	 3L1yoRlstMeTfYDe6ano+RaQAmBTk1P8fT0IZCmm5n+w8XF8bIWZpaE7lh7HuS91xV
	 8rbPbHSOPK3gX8zZAkOm3f4a5z7x8YmPvb4oqp4tw+RUvJMErHj+fZ5rfaBCz19Cil
	 V/6j3eJI29JQDbL7ycYITLlxRz4+SPsGiF1fN2v178ETKyk5OsAOKfe31a53rDE7Ub
	 zrUEAXYgxaWDw==
Date: Fri, 14 Aug 2026 12:34:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: arm: qcom: Document LeEco Le2
Message-ID: <20260814-lively-attentive-narwhal-1beb9a@quoll>
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
 <20260810-next-patches-v1-4-79a779d76173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-next-patches-v1-4-79a779d76173@gmail.com>

On Mon, Aug 10, 2026 at 06:55:37PM +0200, Adam Skladowski wrote:
> Add compatible for LeEco Le2 codename s2 based on Snapdragon 652 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

