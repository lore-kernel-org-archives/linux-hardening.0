Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDB3A3E67;
	Tue, 29 Sep 2026 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669685; cv=none; b=C1dHLSYXWTLTa1V/VhX/76JgR03JU4wpvwxb9xvBzjEm0UdaNJ1GBydOv7VgVu0TXC2Na0+6JlbzrqVjV2XiGHCW1YEzy3KVJ1PuXrp0hBXWiugjmNi2PsqWKqXaJkO0t+DzgCz/PhM0DRFBS2pmtu52axm6UNr3zxnRQ0MF3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669685; c=relaxed/simple;
	bh=S/BLnJC4zG1prZb2sW1iulsEd17k5Du8f0opRtXOHU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t18XVS8C0s9CNaBQBcqR0sXbFwPHZEDuQMTQlZOKIe7wA8z+WS8SqgLYffTZrncP7rGogpJ80Ca/qQsuuqHI/oyT1aNQujrbcEPZ+VpoWEP4BO7Xy/ZdrB7f9AhA06T3OnmA6efhki4AgkXUWHpfH9lFd7rCxT0Q5AnAvjsQODU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKMItGvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKMItGvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744811F000FF;
	Tue, 29 Sep 2026 08:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669684;
	bh=W0YuZxNNaXvKtFw9LoESqvCuluRkE/s0gJlxTCFjWfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eKMItGvcWxI8fwb0eLu8L3uskG4kuDnMRkRT57BQB3GyxO3qrZn3xyHswq9LVrMwM
	 rK+JzjYsq6iLfqqaz1qF4/CmWPN2di+9hN0AoWr4iS4dqshDu2l2YYQhFlEs3OpMuH
	 fJe2bHaQK+WmmMMEbpyy40wgLdXbRRNTL9v0HiMhpY8uz6tvApn0GjotCOMtfCtRI7
	 k0/WQc4Dh0j2eglgoQk2tcWE5ZLz9qGJ9QwkMIyIaked7o9950Jqw6n/1GPhU3ZTeX
	 wTNckWVNh03PIiIqxUqnWIDhQYN7P+pc0SFL1BO3gb1QvfdGaixrPv8y0T4PPA3vys
	 3lvw8V0aKqBOA==
Date: Tue, 29 Sep 2026 10:14:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v10 3/9] dt-bindings: media: qcom,qcm2290-camss-ope:
 Document shikra compatible
Message-ID: <20260929-overjoyed-boar-of-success-6df19f@quoll>
References: <20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com>
 <20260925-camss-isp-ope-v10-3-2622411034cb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-camss-isp-ope-v10-3-2622411034cb@oss.qualcomm.com>

On Fri, Sep 25, 2026 at 11:09:50AM +0200, Loic Poulain wrote:
> From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> 
> Shikra uses the same Offline Processing Engine hardware as QCM2290,
> add qcom,shikra-camss-ope compatible string with qcom,qcm2290-camss-ope
> as the fallback.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

