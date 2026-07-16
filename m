Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A6372ED6;
	Thu, 16 Jul 2026 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223642; cv=none; b=P8U03Yqe19AisNrANgxCN0oJ8MLXmRnPxti6U9zSuGk81eUqlCkjfr9Cr/uoXl2P6Cc14pTrLe4tuy3Fw0nzWBvl66eMNrpo2zGcd8VJ44rdpygbuhPDEvawlKtwErXlsh39vLeUwq5LWq76DP4XUCpNUWO7dza3JlPbhHZF+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223642; c=relaxed/simple;
	bh=6pEYfcebKIYUzF59ekyV9KY8+umqI/8fFDC0ZSAudzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0CLZzpt8EFTI/t/FPCnco1tGECoDjO6/TgwlaC1KEaFY2BusSlhZYoyD0EX5tJUE8pbrPbY/K2oqWt1e/lEvLKLPUNykof5fTXwhydWRNO/SOTTnheRTzBdEN2EyqGbBbiduFi28BYO70GlJBDSsIf+X3yQ1sEeGnzEWjCG7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYV2Nhqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYV2Nhqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16FA1F00A3A;
	Thu, 16 Jul 2026 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784223640;
	bh=JybiWbfiaZr00Rdf/DsbwkKIST2oJ+WNcEjStes2TLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EYV2Nhqsz6SjNvJ+a55nlCvJ5OB+ZB62OoQoNFVTecINTlhj1vvCQeUvcj793xr1h
	 Z5oj/bkzcgAZ6pUHT2qDfZSqIbihkolR22VczBJvwnObxNzH5wfZty1pGDR2S4GHHe
	 yLkGR42MLl6etZa3j1/tY1Ehjon6ylLOY+mnXAVqUjWdskfeRhf5Q/9QfsvUB8950T
	 F5StoQdpduxNz7BIglh6rQfDfr4gJUHi9z9/RWXIljPKeDS0W0W0beRiQ6GKzsMdtv
	 G05iwBRGgqUcRFKv/lSkWJKxUJ5qM5Tpo+R7iLlopHBDGPdK3Gqm4FQac7atyIYYw3
	 4OSgEBdgBCvyA==
Date: Thu, 16 Jul 2026 12:40:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	Ze Huang <huang.ze@linux.dev>, linux-hardening@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>, linux-phy@lists.infradead.org,
	Kees Cook <kees@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Longbin Li <looong.bin@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	Alex Elder <elder@riscstar.com>, Yixun Lan <dlan@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add Spacemit K3 USB3/PCIe comb
 phy support
Message-ID: <178422363982.585904.17467058424948637917.robh@kernel.org>
References: <20260703021024.495433-1-inochiama@gmail.com>
 <20260703021024.495433-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703021024.495433-2-inochiama@gmail.com>


On Fri, 03 Jul 2026 10:10:22 +0800, Inochi Amaoto wrote:
> The USB3/PCIe comb PHY on the K3 is a complex PHY group that
> can provide multiple phy for both PCIe and USB controller.
> Its mux configuration is controlled by the APMU syscon device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/phy/spacemit,k3-combo-phy.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k3-combo-phy.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

