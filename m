Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E42701D9;
	Thu,  9 Jul 2026 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583334; cv=none; b=nqmAFsMGCJxEOHRgxtgFhdvEtThBVrwdOGfuqbBpjfXckJPyTyJQHlqZeTlnTnDa5BLPNQCcHaXfSBqQ2v6uHLTNcvuHYdGafbWqQUdH1ger1bojuX689A0bP1XAyDcWXr3kBYkx1Rhz6NW6NphPg8pyduJQ/j1YC8wEyXjnV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583334; c=relaxed/simple;
	bh=p5tAdBj63DJ1E1YfIJZdF3ksO1rK12DML396muyqx98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3uOs8uoPF0ej7qfdXXaJLxvhkUVuJ7ZVBx5rAgpprOI2DiCJsuvEcqfi9uf1DG+xYYD3M9DTe0c5zUqwoybp3dg15vinEEm8eCAtewXj+jerByngHhNP0/JAd0r+UdHAyH7S8wSNK/nYYToOktki9AqhbfUboaJP5pN2sr+FZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF325UGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF325UGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F991F000E9;
	Thu,  9 Jul 2026 07:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783583332;
	bh=4lU6Z4yrgGwxsrc13XDMGNKlMordxGxnjKrbugW39uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OF325UGhnPDUmO1eAN753pvZDQj0osuqNN1QCdQVrVrAFK4di3CRE3aZ2A4aXW/UD
	 ryZgxry8pmMZ5zV7ofzMT1PgYAphxAikrw5RgxSdyaRFC9Qziagq3Z9mxbGDuKftm4
	 1cRX+e9tC2w5n6X+1IswmPID4Uu5xqH5ddn8KQdMPVsMlHS5ks5Dhg9RjiIjs23lYI
	 I3lBfNVQZwZv+nnIAlESWVd5R7QpW9UE3ZWHkQS1eujor3zxyNuXLGnzK1UnX5F4rf
	 wx5zvqS9kGCgrTk9RDXdLowWRHuRWAZPaeTRX7DI4y+ZgF09FlnMkuzO6BWVSVK0hY
	 +Q4IoFwdJ8Z2w==
Date: Thu, 9 Jul 2026 09:48:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 1/7] dt-bindings: clock: qcom: Move glymur TCSR to own
 binding
Message-ID: <20260709-inquisitive-debonair-bat-5a114a@quoll>
References: <20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com>
 <20260708-tcsr_qref_0708-v8-1-62c42b5fa269@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708-tcsr_qref_0708-v8-1-62c42b5fa269@oss.qualcomm.com>

On Wed, Jul 08, 2026 at 03:02:38AM -0700, Qiang Yu wrote:
> The QREF block supplies reference clocks to PCIe PHYs and requires
> dedicated LDO supplies to operate. The digital control interface for QREF
> (clkref_en registers) resides in TCSR on glymur. Since QREF has no
> dedicated DT node of its own, these supply properties are placed in the
> TCSR node which acts as the control interface for QREF.
> 
> Add a dedicated binding file for qcom,glymur-tcsr and document the supply
> properties. As this binding will grow to cover more SoCs, mark the
> required supplies per compatible using an allOf/if/then conditional.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

