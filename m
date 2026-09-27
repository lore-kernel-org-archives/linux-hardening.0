Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DD23C8AE;
	Sun, 27 Sep 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790530831; cv=none; b=kXp0B24KjpE4q1Gxry+9Yeil3XbntNiyqsQ0D2DxZGuUjfKsK5oc50t9lmlHs/TfKdLYZ1+9qqCOXeH4M42El+3r7WD62j4n+F97QAh6KOeCg4udOtp0S/hEtSKRz5oxZDy1T7+GRXtcvZopECGlASc89cx7BBYjgqQkKsukFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790530831; c=relaxed/simple;
	bh=yEFV3lkIaPKi7zVGKiJPo1Sjy0OlfxaF4BS2U1sBqUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2eMoouuyyu01LLi7IekxFbJulSePyp32L0cELAfWc2Epk2ckLl1D5QZaA9JnTdJ6sH+XBkUh2aqTXYr4NeayURmdG+h3iWII/g/h7HL3Ai+S/IvcyWtby5qxdaevvO8vk7Xdxy3OMBpVVF7prkttAF9r/JL6+PsIUnQG4qraS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1QS/gdz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1QS/gdz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1651F000FF;
	Sun, 27 Sep 2026 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790530829;
	bh=rRicdbRpdSMevJVjz0k9ySyuClDHkZPdx7+N/XrY8Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A1QS/gdz5FrsJEDgePvIQvIDiUwOEyInkviYgzx/9+hBfEeEc8pymb8o+pJY1M8oh
	 8L0mn5VXjz0rWJz5/UwLUUXb/SOl5vHH5zt5WYu/qCbnMy1hN7ZYmhzLxASav1oooc
	 NSaiVY0Hmd3Fkm59yFY62+rHFC+ItPVWukVFAtNZROFPRdjIebaAGK3tCpAzVq2Ltt
	 Tc3WZ+BzimCSWOaWfZBaGrAi+1srwhejw8DkcioK7Jg8VteKRiy/vEC7GBIDRwI3Zv
	 ULcVnZ1fJawAVCzy9KKccZM+cgPp7qHitVH/Le98PXnIaXD1P4Ii525hrYXoh1W58g
	 DucM6bhq1+FWQ==
Date: Sun, 27 Sep 2026 19:40:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Emil Renner Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, netdev@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v4 17/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-2 clock and reset generator
Message-ID: <20260927-wild-modest-goat-b79b3c@quoll>
References: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
 <20260920120044.194901-18-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920120044.194901-18-changhuang.liang@starfivetech.com>

On Sun, Sep 20, 2026 at 05:00:39AM -0700, Changhuang Liang wrote:
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

