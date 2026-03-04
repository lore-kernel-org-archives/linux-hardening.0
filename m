Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C0308F1D;
	Wed,  4 Mar 2026 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609593; cv=none; b=PI3gEb/MXYiRZcWr6hH/u8SCZhobn/ywajfmJSTlKfcxipI+UgwqPE9Bd+fs9XAAl/GEX3k0ZOG6yDVJU0qh+yfxTgJCj8TBvjpEJJ5lr5PxRmwzqQ+9tkGBMbvTm/+Bk6/b35bSOx7tfz9QK3LitlY9dT2Y6dtQWpHzXOoWBpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609593; c=relaxed/simple;
	bh=8l87FG3GfJ8GOGQId/6eYI/ACFLADMHOJZvD/ixFexk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ7yKWnvBX40ruIb2v9K6RUPgPI69OVJIIZmiINwZXY/rJiWDQHCDUPRwLEl7V2stt3keON/j0NcdZYQFSIVCHYZ0kjiNmpQqVRlOQtYFg05Ny+/NibYCFcqwp8404Hv3hdezzO0ybkof3FJy2ZH0JEGLCMBtC6pFSHcHm9SFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOMSWQIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOMSWQIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4817EC19423;
	Wed,  4 Mar 2026 07:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609592;
	bh=8l87FG3GfJ8GOGQId/6eYI/ACFLADMHOJZvD/ixFexk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOMSWQIrUCrYfDhcT1LekIwNg0z7E1jHDc7bo6lVsZ2I8YneR/S/G/tKdCXEXGs0Q
	 XfKKNVNqODC2qSDdytIoSSm98eG3ZlePGTPyNOYbIOZi42mHHw/CJqcmbZ28t6I+pG
	 hajkmVxa969r5CkWKo0YNEKvY2b9xJTL+tAJzvv6WxiR+veQ3fKbn8nJwh74P2UEAK
	 CWSSAjy1aFLISt7ZMQfQHcIRzEmLk9YaPDFtQC+DZPbgtM16IKeb7A6ZzmHpdD4AAZ
	 yShTiebgwMWI753LCzzb/m3a+H7AzAIRrL33TzVFGW2sjxwcoBR97qWEeCTASw/AVW
	 oRjZB4mbAQLLw==
Date: Wed, 4 Mar 2026 08:33:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Message-ID: <20260304-uptight-rugged-badger-c40d0d@quoll>
References: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
 <20260304-amlogic-dma-v5-1-aa453d14fd43@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304-amlogic-dma-v5-1-aa453d14fd43@amlogic.com>

On Wed, Mar 04, 2026 at 06:14:12AM +0000, Xianwei Zhao wrote:
> Add documentation describing the Amlogic A9 SoC DMA. And add
> the properties specific values defines into a new include file.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 65 ++++++++++++++++++++++
>  include/dt-bindings/dma/amlogic,a9-dma.h           |  8 +++
>  2 files changed, 73 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

