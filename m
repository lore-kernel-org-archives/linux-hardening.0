Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD1351C3A;
	Fri,  8 May 2026 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222821; cv=none; b=UkFJfEYvOoQvgQu9dJs8mvv64wAHwwRx/LkbcrCr9iiuG/p1vJZCfManrdXtDC57aYmQchFB2o76f7RKa4jiNdePk7TnLmHRVcMR7voqD+kkY8r1RRj+HJpr2L1C41IQgzEfVYlHrda3ry7OCUKz+ZowJdv7gV2EZbj1tfsDvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222821; c=relaxed/simple;
	bh=uKAOXdr7KoyoLXoWkvIiwhu5inN82Hrcf71gx2FwTL4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=MEfS9wsiwyGjE1iGLbDDqpZpoyA4+QxUw092v6mZPmJIUzhO1K+DDAVBtUyZzWcisvEDO6BQ/rtgazl18ZrcIyGBgM82AHEfnnF6KqbiWJlGMFhisWP7RRy3ippIyvn+ZKsBgR/5XkP3UKSnK+fcaaZucBzib++oVdRa1TrIPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBoM+uOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBoM+uOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193EBC2BCB0;
	Fri,  8 May 2026 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778222819;
	bh=uKAOXdr7KoyoLXoWkvIiwhu5inN82Hrcf71gx2FwTL4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rBoM+uOJQYB0NFff7uB2cgpANz0ma7Q2Xa2GtuDlwToO8Z4hyJ3vsgSr7JHXCc+be
	 OLHKrccw0DSFGpeId3LHUKMk/Gwl4tqOqp/07IIW6u2cFxfyoOHuYWbFh23r7xTIOi
	 hL5WDRxzrIV6p6YckB/PmvwN7uPvaMY8cQ1rsoojo2qL3raam0Hmw0Tuc77TuWcpRj
	 ELQNf3ajnJ7t3nB+K+LQqKtJE3QjgxbH6e7bFggdFLT3FlZJUNU6lYITqPEd/6fQbx
	 uGYvmGl+oQd65vop7dQbVH+vVgJK7uUkiBh1CJlNu5DjaXsiG5N/gfY+Q0WIG2/kWu
	 FXza7gN5NuWLw==
Date: Fri, 08 May 2026 01:46:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-hardening@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Hal Feng <hal.feng@starfivetech.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, 
 netdev@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 linux-clk@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20260508053632.818548-18-changhuang.liang@starfivetech.com>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
 <20260508053632.818548-18-changhuang.liang@starfivetech.com>
Message-Id: <177822281712.4161155.7993611746550690786.robh@kernel.org>
Subject: Re: [PATCH v2 17/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-2 clock and reset generator


On Thu, 07 May 2026 22:36:27 -0700, Changhuang Liang wrote:
> Add bindings for the Peripheral-2 clock and reset generator (PER2CRG)
> on the JHB100 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../clock/starfive,jhb100-per2crg.yaml        | 76 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 57 ++++++++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   | 17 +++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/renesas,ether.example.dtb: ethernet-phy@1 (ethernet-phy-id0022.1537): compatible: ['ethernet-phy-id0022.1537', 'ethernet-phy-ieee802.3-c22'] is too long
	from schema $id: http://devicetree.org/schemas/net/micrel.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260508053632.818548-18-changhuang.liang@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

