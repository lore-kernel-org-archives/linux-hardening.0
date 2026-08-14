Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AFC44BC9A;
	Fri, 14 Aug 2026 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703644; cv=none; b=XiCwlgYGtrqrQmK450/JphAWEwzbv33fhX+RREPsmxmtEi1VJjNf738225E7mbnUnFxUkzXMhJKZDgGJZcP1dam102Dh3IVxWnPb/YXaY7rOEB7t9UucEcuuQv5NllaLurj3y0zs6xCX0DdETjq9mo+BNjLG2hYsC+EkO52Ct/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703644; c=relaxed/simple;
	bh=HCtE+p+lu6ACD9HZh/0kvb3hQPG6ZIXcjRymwX+aD4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdXINWoTQ1lEbdAl7xMovj9Ultxj8WlZHfaCnprX0Q4eokPr7KERckgCbytSKIbhniTFkwTlGFuhKhwQK+R6pP2ofjJRG4bGuGks88m7lt6/CAZ4i/d+fOpkryaBvqtYcYs0eEklZYoIDbZCP5UiXPaYycTIB55Ohd/KXCF9RDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2wTdfVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2wTdfVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4C01F000E9;
	Fri, 14 Aug 2026 10:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786703632;
	bh=tQNCF47eznQAkBp267y4GztnX9MK/aFwBJQmHUcr7Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m2wTdfVPxN2BVnyyjm/nm7phmQOiNJtU30KHf0He1O6NPJ92D6K7Qw3DpTyT0nS6z
	 z65CpfYihbApPdgWstQ7mGioQIV/hxfrbEgMUkr5QqksOyHueBPIgmsWf+pZ4giEzq
	 1SOh6p5F9FeHZMRHJ5GAi7hULg8foN9NH5hDugHB7TOhAz+AaidttdWUyW8jIMwHaz
	 BiDHDsw5bxPbp70AE8vslpk286OhHNSkSwrVbQ+28LRPxrhlZsUB8P1zEKaCRzi2o8
	 LwuuILp7fYC7fs7L3aau3f6MUtM2onVgA+jpbvzcdcfXsjIO9tkKbQ615+BZStMlgj
	 uxrpHtnbVjGpg==
Date: Fri, 14 Aug 2026 12:33:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: arm: qcom: Document Motorola Moto One
Message-ID: <20260814-conscious-ginger-sheep-8b5ab0@quoll>
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
 <20260810-next-patches-v1-2-79a779d76173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-next-patches-v1-2-79a779d76173@gmail.com>

On Mon, Aug 10, 2026 at 06:55:35PM +0200, Adam Skladowski wrote:
> Add compatible for Motorola Moto One(deen) based on Snapdragon 625 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

