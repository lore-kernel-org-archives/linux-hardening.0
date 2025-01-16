Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFCB45009;
	Thu, 16 Jan 2025 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014189; cv=none; b=VN1QgDU8ALH0ACQAUzba6uecMRFmZ8dcYuthJCFSvu++yiTKosFf/BO+5DFN+pj2DTQRQGSP4AwoZ+1OSzw27T0fGnZWVKq41L1QU8A8w9at0fZ4eq97nrVIctCknWMDgYuNX55xKF6m+RJcp0RPcutLuHN55LdZHKSlcuyClZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014189; c=relaxed/simple;
	bh=4+3nAGVh/uPX2+IHp5ayZL30DSWxzNqR/sh4yXvJYk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6b2xMpNwIK44J1n0Rrw661Nfq5vZRqiuDy1YUNizLja3nRFZHKiU7uX92r+hnugdGU5Sop4TWqna2+ePEnOmWq4dX/5ypnsZ4xboaipHdIrV+3FPb5g9djWDky4ZI6IXCkjmVmsVqhCld/qM383lwyz6+6FsoGqpAleISb1Pxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ4o7ap5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ4o7ap5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732A0C4CED6;
	Thu, 16 Jan 2025 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737014188;
	bh=4+3nAGVh/uPX2+IHp5ayZL30DSWxzNqR/sh4yXvJYk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJ4o7ap5LJxVK8XrbEFOmAjINzZFM8vE1o182z6WXu8uEcZxGaeGzPyTvjKmo2Xsy
	 ssthYPGwkfbrlNXXMCegfzMZ/Z5yGspiYIeRd/2X9WTBKOHV8jDWeGslyIDZ7T9ml3
	 tuYWHQoC6K1QvRgG/xglyewFP0RTBH1ziLabZW6bIKGtvwMy3FE1w8KerW+E593gCb
	 LpeE+dn1OlViMVZNsib18UHdcsKUsAW5uERjEr7ldnWTccqyATsZg8tB3X1WZmDF+O
	 42Zr0dkDqjJzx3FXqN3AoC1tFB9poYZMtjHAndPzVGKdjVmztJUCvSrJIE0qfXYVhs
	 EhekIY6+Jk+Dw==
Date: Thu, 16 Jan 2025 08:56:24 +0100
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
Subject: Re: [PATCH v14 4/4] MAINTAINERS: add myself as Marvell PXA1908
 maintainer
Message-ID: <oapsqjdop3szi7zfwiyy65ty65gz3uid6cc4lfao22o4d6amjd@bmfkt2wnmlom>
References: <20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr>
 <20250115-pxa1908-lkml-v14-4-847d24f3665a@skole.hr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250115-pxa1908-lkml-v14-4-847d24f3665a@skole.hr>

On Wed, Jan 15, 2025 at 09:35:57PM +0100, Duje Mihanovi=C4=87 wrote:
> Add myself as the maintainer for Marvell PXA1908 SoC support.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a87ddad78e26f28ffd0f3433560d6db1518f9f95..caa5f6b96251a3da0f3f9d2f7=
60b38288eb23ab3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2624,6 +2624,15 @@ F:	drivers/irqchip/irq-mvebu-*
>  F:	drivers/pinctrl/mvebu/
>  F:	drivers/rtc/rtc-armada38x.c
> =20
> +ARM/Marvell PXA1908 SOC support
> +M:	Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +T:	git https://gitlab.com/LegoLivesMatter/linux

Not sure if this was mentioned ever (it is v14, so it is likely) but if
that was not clear:

Pull requests from non-kernel.org repos must be signed and your key must
be in kernel.org keyring. Please get your key signed
(meetups/conferences/keysigning map/video confcalls) and submitted to
the keyring.

Patchset should be sent to soc@, as expressed in soc@ maintainer
profile.

Unless this is not going to be merged by soc@, but someone from Marvell
maintainers, but then please drop the repo. Git repos here are for
managing patches.

Best regards,
Krzysztof

