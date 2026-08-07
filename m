Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5643031B;
	Fri,  7 Aug 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107762; cv=none; b=MEz7fOZTG7+VNXIx6bU0z2ha4kDt9kvG1eJ3QWII3zSU1QzwntxGUbjyKDeGbpwm2/OEz6ZjYMUJVnc8qXLosZMPgQzZxhA+gILoaw7eOzQG1H5ukXNmg57V0g38zyPucPB1CJwjCg/PD7FzVjw+RlYeBTfLyR0r9kg7nccxni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107762; c=relaxed/simple;
	bh=FdWE3jLBu1qUiJGqtka5XAGDIfCU188cWO+v/9kTolg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tjuH2lQhNbOH2cHmsxu2iPdKziUF+1iMmvGGTYTyxPd16lXD9YiDxOAVEJ0CuaOQy2gyJRqR0KD2IGc6MlzGBo8mh+f9UyxulB2WoGD2sTLUhKCEC1CzM0kfRwef9drD0fr5UTWEPbWr2UbLnCQtywBsSfPRV6/O2Jfp72o3MEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OecVw22t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OecVw22t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864B01F000E9;
	Fri,  7 Aug 2026 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107752;
	bh=1ojP9lXDTsgxo+kBprRZYnvCdgavnn52UswOqgtr3nc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=OecVw22taBzl2gw5knEc7KAsRSOu+xy7WrSl5VJa24e6O4sz1Y6duJxpWBx4xAj00
	 SxwiVPTLg9TcQZjSpGqD7plpJalJalll0HQP8DDfJWoEbueZPFIiPg4ulIVvdPBonw
	 K1X8wRNrppJpXuxm0HfMG+kJevTJtd/JyRuwnp5mxcbvJgg93Nuadmj++VtZ+0AbFd
	 jmRTVO3RY2Se7UzN4HgipbbPMpcjR4guz+7xvEZF6yXh45P7R89orLAyBaV2ATDDij
	 QVFc4Hma0dAnVVIb//MUH7uVMc8W7eEeLmrohv/eczvy/UyaQI/lMoQYDnxe5b/yuL
	 2puGqJ6IXaEjw==
Date: Fri, 07 Aug 2026 08:02:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Hal Feng <hal.feng@starfivetech.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, 
 linux-hardening@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-clk@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Kees Cook <kees@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org
To: Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20260807112923.191627-16-changhuang.liang@starfivetech.com>
References: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
 <20260807112923.191627-16-changhuang.liang@starfivetech.com>
Message-Id: <178610775180.4069377.7068076405963189133.robh@kernel.org>
Subject: Re: [PATCH v3 15/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-1 clock and reset generator


On Fri, 07 Aug 2026 04:29:16 -0700, Changhuang Liang wrote:
> Add bindings for the Peripheral-1 clock and reset generator (PER1CRG)
> on the JHB100 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../clock/starfive,jhb100-per1crg.yaml        | 70 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 60 ++++++++++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   | 19 +++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-tdshp.example.dtb: tdshp@321e0000 (mediatek,mt8196-disp-tdshp): 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8196-tdshp.yaml
Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.example.dtb: display0: fsl,pcr: b'\xf0\xc8\x80\x80' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260807112923.191627-16-changhuang.liang@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

