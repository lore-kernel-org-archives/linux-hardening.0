Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCE142E83;
	Thu, 16 Jan 2025 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013973; cv=none; b=uXa0usrShVZ5DnCXYZA6/9ufo+Buzahpno2HrI9U1cbmQyNYOFBzCfHjwvrUn+iftoOTB00bN6Qw6IhhDTIC6znLmw86+ZlEFnxjz9mEhM5Cf5MoCFrFK/JbUP+lRZGEMJ9GaNedfLA+kOnaD+AR5fbFoT3vTe6Si+9aEPd06ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013973; c=relaxed/simple;
	bh=4X40u6qRvjap3XD5YqCVaB8bLA5Q93cffOs+6tcseV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJFuA7D7JKdoyGGjikbCzsntlxRIIzuRAUKM1RRyyIpyeugIXGHuz4zTFiTg3pFbaB++Xp5meXkq5LZ8LIFcVn7a+JhGu0U0BisB7XIYILN68WDilb0WLR69lIj1hnLVVJPp/1w1eZBAawDUsn14Xix3+ZsuOZ1Bi4hfSMs5TB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+S9lQaw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+S9lQaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DCEC4CED6;
	Thu, 16 Jan 2025 07:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737013973;
	bh=4X40u6qRvjap3XD5YqCVaB8bLA5Q93cffOs+6tcseV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+S9lQawrZhWMcnVcZOGAHYRA5X481BoVpCXBw6XA9Qbf7V3ijp6JEoeFo2VB4YYq
	 2h33/OPovyaF/BBn9t7PPMSlti1rPM5p8+xFLaQBBQM9E2iqK9zhhWNbh2Jbhf64h5
	 MaJy6q0aSIV5idUJPDWvlDMsqGT0f+BiCNbn99gjQQ1EhcillMhGgmaMcYhxgMfg2x
	 QX0NUTe2vhnjibrRK83QX+ywpDi64b4nW8r6gtg3ZrMrIwJ4gZ9fMBnn5rmq6za9X9
	 WipK+LHycoxfTTo52NjpbmBT84qwb6yyys9aFTWdtXeov+jo+e8rHTXSq64w3djH/k
	 OgUGrCeaJf+Tg==
Date: Thu, 16 Jan 2025 08:52:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, David Wronek <david@mainlining.org>, 
	Karel Balej <balejk@matfyz.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v14 2/4] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Message-ID: <fptozdlnt3yfdvqb44l77qhjn6tmdirhnrb6lkeniec2hrmuoq@yoe2w6g6xi3x>
References: <20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr>
 <20250115-pxa1908-lkml-v14-2-847d24f3665a@skole.hr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250115-pxa1908-lkml-v14-2-847d24f3665a@skole.hr>

On Wed, Jan 15, 2025 at 09:35:55PM +0100, Duje Mihanovi=C4=87 wrote:
> Add ARCH_MMP configuration option for Marvell PXA1908 SoC.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  arch/arm64/Kconfig.platforms | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

