Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF8392C3D;
	Wed, 13 May 2026 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713850; cv=none; b=UbThmli5oE1/E3S8/A4bFZTSpSQlqrS1Eb1A4Q2KWF9bgRs/D40HTi+7J/PWibKDqBO2bp3b+NHnqiLKaQlmT4UHICtP5fPZWG5GRiLaP2nPkiEEdu7K0Nw1J4CpTZzF1PTCGKs9ECHUlNv6MSwqK6FM5MUjwbiC2YStMeCbV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713850; c=relaxed/simple;
	bh=Jk846MFiMF19m2CoB0SBGnaot+k8m6VFTT4plEW0qXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmNgXnAlF0nPKmk11Y6oWrOwMiqeU4EkXDGBctTp2QZyKFX2IHe65kqWVlnwCkrXmGwNlEFJtpWalhJsriOzCZjTjYyGeiqd4UbgsLolxaPYAuVNIDi4OfvlmFgg0q7LzIQWQJaaq5k9F4obreXJmWlJK8OYExSXG5Dkb290oDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhExjy9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhExjy9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3BCC19425;
	Wed, 13 May 2026 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778713850;
	bh=Jk846MFiMF19m2CoB0SBGnaot+k8m6VFTT4plEW0qXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhExjy9di6rnxb1Y3sQJKNj4R08A4HGyIf/500AB0lswPEL17WmGwWGuDsfAEQBVx
	 lqrQzGweduY0XwHxArGVkfKm9K9N3ZF2dgcA9K7/XQdWx6E6Gmh8l+AtetZuaDR0L7
	 OHwEiyUC/8euQTY88pkmlPsSjDAQv+m7qW8IDoz9bJk/sFxeSqNRt37Y7sDDzu5JXa
	 nhOqD9V8Lg4nW1EhLRnfYG+RjT0n5liT/pP4ThG+bhmPWwPE072f9U7h9hHxns6xnX
	 73fJKmWnw6r4fM1dBrEHZN9CkmKYb5l+avrrY9Hox1V7ozKty1n7tu0ECOmk4w0z+V
	 +3eAzlNiey9dw==
Date: Wed, 13 May 2026 18:10:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>, netdev@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-riscv@lists.infradead.org,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-0 clock and reset generator
Message-ID: <177871384136.2280607.13312069951345512196.robh@kernel.org>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
 <20260508053632.818548-12-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508053632.818548-12-changhuang.liang@starfivetech.com>


On Thu, 07 May 2026 22:36:21 -0700, Changhuang Liang wrote:
> Add bindings for the Peripheral-0 clock and reset generator (PER0CRG)
> on the JHB100 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../clock/starfive,jhb100-per0crg.yaml        |  70 +++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 281 ++++++++++++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   |  77 +++++
>  3 files changed, 428 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

