Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977A2E3371;
	Tue,  1 Apr 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743469241; cv=none; b=qgqTzyM5UuwalbAknnxp8SL3ZH0fbyn/+OmlBI2nCsojEXYRBAYZuVFYYJdzvQFKtmrqoEuAzNCq0fNvSh9RRiczpJuXGcQEQZ3BTX9VcZh4lTCMGLeuBgVubP8DZOpsPKfb9RhrgpVrPdO5pxvBFwlUvK1Jnvv4a90Lyz4tEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743469241; c=relaxed/simple;
	bh=OPokjJS6bZ7xjIKgUxLbF7tf4xmoAmvSOaiF5AsgPL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwvozIhpJ1y/CXNlSnXzLKIl7KAFQ53RvGued5oqzXlvR72xAP33Q9iHLiDS9CSsdPRfDaaiQ+v+MTe33J1t0glPtGqpgoWAs9aJ9LHdDf4WIS4g/e++5BqiJzltdHTPznGqkX00eMum1MxiGSt4g60MyyEWyoPFas0Ha08Shjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VYP9JKfS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VYP9JKfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1743468742;
	bh=OPokjJS6bZ7xjIKgUxLbF7tf4xmoAmvSOaiF5AsgPL0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VYP9JKfSVsK0aTMb6gR6csBopMOB3E6gwP/2VmBe4u9RQtCP7zmZHRTuTdCaDmlQH
	 t+MqgtQ8BTdWA4q4jZ6YB6kshqUgxEm/2jhkzlP9hMks0L8Ou2M7bjD80yFr5TMAuN
	 7dizjuCPdQINe6S+n1PPNXRHYCQeo1wbclTNplI5V8gGP74E35M++R5MSi+jxc3Jis
	 wseiy4ScWjvzxMwYtbLDyIWAD3f0Rn+1w1enAOZQDP63cYf70T6nSMRWU8szPeGgrV
	 dhsXkkCQxX448xBVMuA75/eIYz6TX+2E+lzWEDjme+2VUNwQR9vR7K7+5pL/9fKka1
	 tmdtsOu8sXuEg==
Received: from [10.194.67.88] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8BB8E7BFD0;
	Tue,  1 Apr 2025 08:52:17 +0800 (AWST)
Message-ID: <71bced05e26ae1a5f15a7335928f3f71bde143f1.camel@codeconstruct.com.au>
Subject: Re: Re: [PATCH v4 2/3] dt-bindings: pinctrl: aspeed,ast2600-pinctrl
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Willie Thai <wthai@nvidia.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dkodihalli@nvidia.com, 
	gpiccoli@igalia.com, joel@jms.id.au, kees@kernel.org, krzk+dt@kernel.org, 
	leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, robh@kernel.org, 
	tingkaic@nvidia.com, tony.luck@intel.com, harrys@nvidia.com
Date: Tue, 01 Apr 2025 11:22:16 +1030
In-Reply-To: <20250331171857.262649-1-wthai@nvidia.com>
References: 
	<d0f7003c22e19c8fc7617610043edc7be925a180.camel@codeconstruct.com.au>
	 <20250331171857.262649-1-wthai@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Willie,

On Mon, 2025-03-31 at 17:18 +0000, Willie Thai wrote:
> > > Add EMMCG5 enum to compatible list of pinctrl binding for emmc
> > > enabling.
> > >=20
> > > Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > Signed-off-by: Willie Thai <wthai@nvidia.com>
> > > ---
> > > =C2=A0.../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > | 1
> > > +
> > > =C2=A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> > > pinctrl.yaml
> > > b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> > > pinctrl.yaml
> > > index 80974c46f3ef..cb75e979f5e0 100644
> > > --- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> > > pinctrl.yaml
> > > +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> > > pinctrl.yaml
> > > @@ -276,6 +276,7 @@ additionalProperties:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - BMCINT
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG1
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG4
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG5
> >=20
> > What pin configuration does this correspond to for the eMMC
> > controller?
> > These groups aren't arbitrary, they correspond to the 1, 4 and 8-
> > bit
> > bus modes.
> >=20
> > You may have added this squash a warning, but I suspect the pinctrl
> > configuration in your devicetree is incorrect.
> >=20
> > Andrew
> >=20
>=20
> Thanks for your feedback !
> We want to exclude AC5 pin in the default EMMCG4 pin group, because
> that pin is used for other purpose.

Okay, sure.

> We define a new group called EMMCG5 as:
> GROUP_DECL(EMMCG5, AB4, AA4, AC4, AA5, Y5, AB5, AB6)
> The bus mode is still 4-bit mode.
> Could you please advise if we can use the name "EMMCG5" ?

Why is EMMCG5 an intuitive name? It doesn't make sense to me for what
you're trying to achieve. It's probably better if we rethink the
functions and groups to make them a little more fine-grained, perhaps

- EMMCDAT1
- EMMCDAT4
- EMMCDAT8
- EMMCWP
- EMMCCD

and then you request what's appropriate, rather than create groups that
exclude a specific function/pin (such as card detect).

Maybe you should drop the eMMC node from your devicetree for now, and
add it back once we've sorted out the pinctrl side of things in a
separate series.

Andrew
