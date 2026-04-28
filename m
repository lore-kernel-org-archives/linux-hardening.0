Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF96175A72;
	Tue, 28 Apr 2026 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777357867; cv=none; b=FrnbTtcyVUvdSTWblo5wSNlPTX9V2S9Ec5n7ObvZ+da0cg3hEWeFs+E04y7iyZhmemYaXMOOaLgaSCb/vs22rSFt8H9rIr92h50zn5uTlRSRl4V1vuI3DJlgeFshrg8XAp+E+iKwwARLV1PChmrQIA1zPJ7IhTA2vzrB4WwHLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777357867; c=relaxed/simple;
	bh=U5IVN05soJ83Vg4XNyOOzGVtO4/MTt4s8SsWskmBq80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7Nzy37ue+/jzAYG4xdKRHuHnqZb63m2AosoJhj49hyeZ4tWhleR3TJuYWn8Rqo7y1O9EcIx5iWf/NQKZr3gq9bnV6tPt+3oZ+p5p4kujTZzBTFS5g/f5mqUHhWfJrv47VaWk00f5DKe5wRULBvRI2Ky8nIgA1C8H5lC6IxZjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4gAHyOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4gAHyOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64195C2BCAF;
	Tue, 28 Apr 2026 06:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777357867;
	bh=U5IVN05soJ83Vg4XNyOOzGVtO4/MTt4s8SsWskmBq80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4gAHyOzAAv5vm/OTSjxgojsjYKK2OZRVd2/oz2iA+9gvH5HTIFQokDS57f0D/pjY
	 ME7/VLU9HC8LWEM5ZgjZcMxWyOfO2CJ7Kaz6Dk17RvLuHnv2xSTg4M9ZyKd6pM58T9
	 nanA+QQ/rHPtehp2xErbKVbN/KdhWjD5dWMggqUkJtWTrCvyRJZCcH9s7+b2QoskGD
	 4+/lFWbkwKkUUGIurM99qQygQryf6Uwpp2c1xve7MzKMMwJAxcus5LxQ5wl/vg39HP
	 Y1XFSLMFPkzhV9Q55fG1g5lzmFAShqe2MuWnbu8li9T0UFtBnD3Nj/W36IDnMqpvvI
	 EZctDOxPbfnRA==
Date: Tue, 28 Apr 2026 08:31:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com, 
	kieran.bingham@ideasonboard.com
Subject: Re: [PATCH v2 10/14] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
Message-ID: <20260428-merry-visionary-aardwolf-bec81f@quoll>
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-10-f430e7485009@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427-camss-isp-ope-v2-10-f430e7485009@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 02:43:37PM +0200, Loic Poulain wrote:
> Add Devicetree binding documentation for the Qualcomm Camera Subsystem
> Offline Processing Engine (OPE) found on platforms such as Agatti.
> The OPE is a memory-to-memory image processing block which operates
> on frames read from and written back to system memory.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,qcm2290-camss-ope.yaml     | 131 +++++++++++++++++++++
>  1 file changed, 131 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

