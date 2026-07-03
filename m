Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D851DDC35;
	Fri,  3 Jul 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098785; cv=none; b=WfGHkgthviNZcPyncH/v4/IHSF+90ExEnrEycnkroe5tFeF1d5QT46hkCIZ5bX8H9+DBr4dGEsIfJee7zZbS1Fc/atWtrfCrJQ/ZpECeiCOkmAJaKQNNzzABq7cch6zoUgaVVxM3jgzHvrs+ZZjehnbooF/4uXUTXwWIbd4ct0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098785; c=relaxed/simple;
	bh=8bv3J3cvbclVP0PN4eTqNx2AlyxAYso72f3TApq8yh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz6xpFFqLZ47I07Jt/QC/I4tcMXRjpndPMew3X24YaZgkXKR/EOUMem8k6w07JSL2HSpKGA2anX9x+7QdyYnCGOsDpOGeX7ZPrK8cieTvnReMaLule6/ZuR+ak7geHsyz02BlTKvZfkbn14+H3t2Y05rC6O9/u2R6qo0SmcduOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=mWPKHCqj; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="mWPKHCqj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=P0tPEngGB69/ViXzlastUZSeIBDc5NlmASuyBxp/sKg=; b=mWPKHCqjQiLOPiIKGP797yKAT2
	k4NTJkDZm2SFKYc6mKLQnly6dnsorUJIepBxEIEw1Z1Q2ApwYgf7rFOnpawAnrQYrA8MRPSFEny9m
	NmEcTuqLlHmD3ySt4/vsjZ56WnWHKMIPCiNN2FNVFm9IDQCnuwud+pzFC0VdyTY8GOJph67Hk/FCy
	krjVKQIT/yMWsNeg1rcTqA6jSq67RyUc7SXIutYqYMa/z0XGlX3QN0OiYongVzKi8ZKZkiULT8mu/
	LYgu9WxEuhWAhKlsh9T3B5Oy+jmoqTE8A6FQwmeC/q13SvB+BQ1kptMeWuWVbHBEQT/9eghYyhEPT
	4KJcE/tQ==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wfhRb-000000008UP-05Pd;
	Fri, 03 Jul 2026 19:12:51 +0200
Date: Fri, 3 Jul 2026 19:12:49 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alex Elder <elder@riscstar.com>, Ze Huang <huang.ze@linux.dev>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 2/2] phy: spacemit: Add USB3/PCIe comb PHY driver for
 Spacemit K3
Message-ID: <akftkeI9Wbr0xL-5@aurel32.net>
Mail-Followup-To: Inochi Amaoto <inochiama@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alex Elder <elder@riscstar.com>, Ze Huang <huang.ze@linux.dev>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20260703021024.495433-1-inochiama@gmail.com>
 <20260703021024.495433-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703021024.495433-3-inochiama@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2026-07-03 10:10, Inochi Amaoto wrote:
> The comb PHY on K3 requires to configure a syscon device for the
> right mux configuration. And it requires calibration before any
> usage.
> 
> Add USB3/PCIe comb PHY driver for Spacemit K3.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/phy/spacemit/Kconfig         |  16 ++
>  drivers/phy/spacemit/Makefile        |   2 +
>  drivers/phy/spacemit/phy-k3-combo.c  | 252 +++++++++++++++++
>  drivers/phy/spacemit/phy-k3-common.c | 391 +++++++++++++++++++++++++++
>  drivers/phy/spacemit/phy-k3-common.h |  27 ++
>  5 files changed, 688 insertions(+)
>  create mode 100644 drivers/phy/spacemit/phy-k3-combo.c
>  create mode 100644 drivers/phy/spacemit/phy-k3-common.c
>  create mode 100644 drivers/phy/spacemit/phy-k3-common.h

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
