Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF994B048C;
	Thu, 17 Sep 2026 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639063; cv=none; b=mUD5+Sa07sxjeOSxGgtnFmdmmQ4BBDapMHR1BLUoba0BTY2X5KXKidO8XezSF8/jAYsmsajQZBKY+RUbYstCTzaZO0EQo4Yk0iCogXyGTlXPmTLJIzgLiPWtFNreJhzOZzBGXoClhTXgyAxj0l+2vtWyzawTs0C8N2+SKZCj9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639063; c=relaxed/simple;
	bh=PPXAhrphGBXkXO3QqwcKP+Gsm+ljMkF8m6h/0qzzilU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3GHVmZEKrak4tSluh+dGQhLQahjdOpct/aUgyTsAWS89XPLraUxjhNtEalJyUOFozTTfJNhv8JRiyktIvPwcdiaW6lZrgzl3xXdlqIPFrKMpm7WE2zhIUnJ7kJzojg+bc/RhbBHZ8PtqlmZmH/DBUMYFTrYbl0DpJUNQVXv11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIwpftXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIwpftXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5321F000FF;
	Thu, 17 Sep 2026 09:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789639049;
	bh=SyGEDd0vEHpsZvoEaGxGUV1Y4unKkJumKA3uLPfw2Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fIwpftXbIchhFRO7Rag7iujxIrMHAetyiY3vEJUmHFrDyWn+infC/GFvcDn/vr+HL
	 1BHj46ZP7GOcBx/H67gQ66zsLzNjR2tJuLROz/B2kNruQ91stRmRUhUrejNiFt3B72
	 yi6ip/xxDfcLqm1TYJGGVkRo3THGnKZV7Kg0PxBVUzVTrxhxx3iuBuSgJis7iVMHko
	 p46sPnxGDaYLypFsk3yuO0e9lAnW2IVNFKyn1vbtBTBc3bjyhY1Op9tbWzGXmncd/F
	 APHOsrKd4G+nvlfngr6IYrK5TTfsdpw+CVooOFWOBLymAoKegQPFZ7KUcWDI8mVSP7
	 sBqzvFZLLU9uA==
Date: Thu, 17 Sep 2026 11:57:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/9] dt-bindings: media: qcom,qcm2290-camss-ope:
 Document shikra compatible
Message-ID: <20260917-mellow-benevolent-chimera-2c4df3@quoll>
References: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
 <20260915-camss-isp-ope-v7-3-77b13d131d3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-camss-isp-ope-v7-3-77b13d131d3d@oss.qualcomm.com>

On Tue, Sep 15, 2026 at 10:11:06AM +0200, Loic Poulain wrote:
> From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> 
> Shikra uses the same Offline Processing Engine hardware as QCM2290,
> add qcom,shikra-camss-ope compatible string with qcom,qcm2290-camss-ope
> as the fallback.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml          | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
> index f9c31bc88e94b028c241060bbd8e56e0bdc49af5..90b54b9808e5999a4dead404aa2063ab695cdfd6 100644
> --- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
> @@ -19,8 +19,11 @@ description:
>  
>  properties:
>    compatible:
> -    const: qcom,qcm2290-camss-ope
> -

Stray line removal.

Best regards,
Krzysztof

