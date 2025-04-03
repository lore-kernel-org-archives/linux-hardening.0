Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711233993;
	Thu,  3 Apr 2025 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659786; cv=none; b=V9tP1ulbQpDhHPnJFGVDL5ZTGeixmaf0clBnG8IW+AHR+cQEVIvi53GIeYXnTGBVYtlJ5kyN+EKW82EVdad73du1qy7Z6PXORxM7Hq335RfXpxQKyB0cWP9BFbWObKm3otatp70a1iPD53IQwCRCfVYbEFOIuPtZxJDP2zAbgUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659786; c=relaxed/simple;
	bh=e+hB6TfsNEWsOBfPe7+0Du59DxYe84XYO03aEf1oq2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NkUKydCDz8y2PS//QGU1yGnHdM9lES9B2qunYT6WPN9lN7GYYffPVPjEp/KulGj12osIvJTyLNsm0Wq4k0+60lyT/frkTpD0miIuqTtg14nq2mlSrYrBr9IlEg6FUrxjPUtaFUrhKn58E9H35+ldNqOlYgFWPK660OEQebI6h4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YeCqwMTk; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YeCqwMTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1743659775;
	bh=e+hB6TfsNEWsOBfPe7+0Du59DxYe84XYO03aEf1oq2w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YeCqwMTkAaEXEzG3fK/V5nJFzmxl3eQwO96YkjdDajs7/4XBWpWWkpkVQreFkpou1
	 nVMQFT9n7e2USYGg8wPzyjE3Z6I+DQ67V6uubhy/NZ1HPGIEvUJ3e2trugUKOj0z+J
	 SbR4yaIks8jZJI7qZ4qENCQG1aLlcO/Jug21dgd/emU8StBtjUuCeRcj6N38rqK4EQ
	 7BOPvqng/pk6T5qmR3zdUTwCuSdj330tEgtjfGzM/ajK02F+g615g7YpTVMG3jP9Sd
	 HB40N5nrMRjJM21CtMtB0gdfFlpL7fYPvP13O0kKRL8B4X/aILvW8g+iqpeJG+yzm+
	 GofwYelTCS5NQ==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 60B3C7B352;
	Thu,  3 Apr 2025 13:56:12 +0800 (AWST)
Message-ID: <ca1f5dc3d0dd53dfe6abd9d6bea98838980f0840.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Nvidia's GB200NVL
 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Willie Thai <wthai@nvidia.com>, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	kees@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, openbmc@lists.ozlabs.org
Cc: leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com, Mars Yang
	 <maryang@nvidia.com>
Date: Thu, 03 Apr 2025 16:26:11 +1030
In-Reply-To: <f563b33e-f552-4a3c-bb45-6b7add876fdd@kernel.org>
References: <20250401153955.314860-1-wthai@nvidia.com>
	 <20250401153955.314860-2-wthai@nvidia.com>
	 <f563b33e-f552-4a3c-bb45-6b7add876fdd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-01 at 17:51 +0200, Krzysztof Kozlowski wrote:
> On 01/04/2025 17:39, Willie Thai wrote:
> > Add Nvidia's=C2=A0 GB200NVL BMC board compatible.
> >=20
> > Co-developed-by: Mars Yang <maryang@nvidia.com>
> > Signed-off-by: Mars Yang <maryang@nvidia.com>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> Why are you faking tags/email addresses? Read carefully submitting
> patches. I really suggest using b4 instead of manually editing
> things.
> And if you decide for manual way, you must never, *never* edit
> people's
> tag. You can only copy and paste it.

I've applied the series, fixing the tag in the process, along with the
line-wrapping of the commit message in the second patch.

Willie: scripts/checkpatch.pl warns of some of these things. Please
make sure to use it in the future, or if you adopt b4 as Krzysztof
suggests, use `b4 prep --check`.

Andrew
