Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEAD1AB52B;
	Mon, 11 Nov 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360264; cv=none; b=hDNgx0eD7bpKFsCtPG0RuFxW/3ui4CQd7QB14dX6nZKJGLQYIvfBcEA1LPVyV+0qmPmTQKa/dKVvkwlYNLSOmeR/2f4DEZgEu5Piv3SXMmiVHtwNImFrImNbX5NHk/opyWUTQcybQ4QgDY1VQIkR7pErS/x7IG5sVdweHJ1dmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360264; c=relaxed/simple;
	bh=HB0kuKAWWrMtuX07WkanXAABx99ZqOF5K/K51IvRFXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dz/xNsgKKKesUIrVF8KXYw2NGF1a8QRt8JO02ZqvZR0aYOINPxsltY8XjxYpaoLLXGHdzR2UY/GDUysbjfxHosgjaYxe3n8O/EbjaNgT6g/cNPtA/JZ0eBEWk+wRUHUf9r3tVD99lT3hypyk3Ib7lU/K9aY5i6vHLvU+4u8Zml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2XSLsWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2XSLsWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC7FC4CECF;
	Mon, 11 Nov 2024 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731360263;
	bh=HB0kuKAWWrMtuX07WkanXAABx99ZqOF5K/K51IvRFXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2XSLsWunbbgzyrqIeKSnRWpnnnj2wEztJGI6Hs6ag6JdtphJvDIbem+CxOvUYw0+
	 wnt0eszF8GaRQFSqa0bRfmhnYmYCeB/sDIEmQerakDSzGRcwi3tiTdCxf5OIUpmit5
	 Usp0j07alJ6NIAD0Oq0ky55uROVUtUYs3iwY+I4JsTmYFM221qMbNs8lvVvDNRlQ5P
	 enB45y2icTYwxXHVhq+iK5aenPUZA3Sj8AsvluYr6ScHEfrhBX8ndpbmbRts3eGEa/
	 sjnxMC0SEXxX1ofVmRjxhrooruAiKq0T4KbFL1aaRSOnS5RI8zP0EENhdGZRTCovj+
	 Q/SvU06QCcsNA==
Date: Mon, 11 Nov 2024 15:24:20 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, Hari Nagalla <hnagalla@ti.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>, devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Felipe Balbi <balbi@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: arm: ti: Add compatible for AM625-based
 TQMa62xx SOM family and carrier board
Message-ID: <173136025956.1976607.11893890247843400314.robh@kernel.org>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
 <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>


On Mon, 04 Nov 2024 10:47:25 +0100, Matthias Schiffer wrote:
> The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
> the matching reference/starterkit carrier board.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

