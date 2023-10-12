Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272128E16;
	Thu, 12 Oct 2023 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy5DEFk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC183C433C7;
	Thu, 12 Oct 2023 19:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140420;
	bh=vdUo+JTbMkvfRT17jgp9PVZf+MEVNsEg2boEzxqpBtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iy5DEFk8QIFNrmfI/9jIySRWAZdZAZ04JHrcirtkERRTrrZ6hWC+R6d5razVm5GQB
	 asuHH8KFcZ12edeYbOC9HkW9j2CAaNfBDyr0ISycf6044uqcB/1sYVhv6f6SGi9DGs
	 ym6PFNcNY+EdV1Y538xCY/gPjqAnFgZE1OTR3iye2NB5abyYX5GCyXq41skvxzd0rG
	 22Qc3npVSgg21KkBhTCVLJP4/tgwE+4F5BOjqdt0iqp1hhDDIG7WYNVgGsCYe/tnLb
	 mNuQR1LvWVB6If8Rc/AFHCgoIJ9iXHE1vjC4Eo0CQRj45vE5+uQ+BfQiSFLbh/tuqt
	 +JFHs+rcug05A==
Received: (nullmailer pid 1580600 invoked by uid 1000);
	Thu, 12 Oct 2023 19:53:37 -0000
Date: Thu, 12 Oct 2023 14:53:37 -0500
From: Rob Herring <robh@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/9] dt-bindings: pinctrl: pinctrl-single: add
 marvell,pxa1908-padconf compatible
Message-ID: <20231012195337.GA1579632-robh@kernel.org>
References: <20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr>
 <20231010-pxa1908-lkml-v6-2-b2fe09240cf8@skole.hr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010-pxa1908-lkml-v6-2-b2fe09240cf8@skole.hr>

On Tue, Oct 10, 2023 at 07:27:19PM +0200, Duje Mihanović wrote:
> Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
> separate pinctrl driver later.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> index 45a307d3ce16..0f7e16a28990 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> @@ -32,6 +32,10 @@ properties:
>                - ti,omap4-padconf
>                - ti,omap5-padconf
>            - const: pinctrl-single
> +      - items:
> +          - enum:
> +              - marvell,pxa1908-padconf

Just add this to the existing enum above.

Rob
