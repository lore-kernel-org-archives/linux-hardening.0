Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A8184F;
	Fri, 21 Mar 2025 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742519221; cv=none; b=K6xUBIDHiTcjtlNz1iFYhV+e70K6hvWzNA9u8+0XNmpB5avQQIv1E+HtzPkZl0aTLvQKbbQYp9A7Yk64HEG/wHxzvy/3Lp89eKSG7o8L/1XK3UEs2as97n6fHO6rJaWn2P3k7iyEvSft9VNp/SkUzfaC2Al+Np+V2gZ8Tr+ujTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742519221; c=relaxed/simple;
	bh=pIdTixZuNmStjtltpSgBZZbYtUoRIdqSvZd1TvixVG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKHC8fK0cxsgXg1OludzjpmTaYnuFZyqTSrNNLhXSg+BGwvklEyFvut0Sg3uyQBX3sKlwuCZ+Jo5+RG0ZGFHmo5InHWRkOfm4MJdI7ip8UBHcZPud1Lhn2Ueay5cSqpK8K9N5LRQAIs5LorFNg31Ogy//CsIdl0NpCmbj40Sdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=STmLaeeb; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="STmLaeeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742519215;
	bh=pIdTixZuNmStjtltpSgBZZbYtUoRIdqSvZd1TvixVG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=STmLaeeb8JgIPPtTQkTrSNDqYPUrllXY1O8adMuBZaHXPzg3r7xposNnDqGupfi5X
	 99Zta++gSDDl1g6lvrC8XT0hnuAKg1r3RC4z8Zo/QyDKqSgnfrSyFA2MJrdT4WBFl1
	 RUmt/OZ6TxN7GeAG3cVCmiMKGwUSnxBv5Lv4WOi5kgsXZNcVhEykb5ll2kTsc+9Pa6
	 BaiCS7bfJfQEDURlCP4T+9JpGc1mpUmY46UGjImGTinlAXe91pWEhhzlW3nyExDQS9
	 gfDVgpD1XzfZxWWDXw/j4WUCiQMImKu63heMsVU2ep4csPM121OpZcNW44Zwo3oG/U
	 7WLh87jddaPNg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6DB127AF35;
	Fri, 21 Mar 2025 09:06:54 +0800 (AWST)
Message-ID: <585c2b050a44f4009b3a61cab69f800c88a0cf5e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: aspeed: add Nvidia's GB200NVL
 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Willie Thai <wthai@nvidia.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, kees@kernel.org, tony.luck@intel.com, 
	gpiccoli@igalia.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Cc: leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com, Mars Yang
	 <maryang@nvidia.com>
Date: Fri, 21 Mar 2025 11:36:53 +1030
In-Reply-To: <20250320164633.101331-3-wthai@nvidia.com>
References: <20250320164633.101331-1-wthai@nvidia.com>
	 <20250320164633.101331-3-wthai@nvidia.com>
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

On Thu, 2025-03-20 at 16:46 +0000, Willie Thai wrote:
> This patch adds a binding for GB200NVL BMC.
>=20
> The GB200NVL BMC is an Aspeed Ast2600 based BMC for Nvidia Blackwell
> GB200NVL platform.
> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].
>=20
> Co-developed-by: Mars Yang <maryang@nvidia.com>
> Signed-off-by: Mars Yang <maryang@nvidia.com>
> Link: https://www.aspeedtech.com/server_ast2600/=C2=A0[1]
> Link:
> https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703=C2=A0[2]
> Signed-off-by: Willie Thai <wthai@nvidia.com>
> ---
> =C2=A0Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 01333ac111fb..a3736f134130 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -98,6 +98,7 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - inventec,starscream-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - inventec,transformer-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - jabil,rbp-bmc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - nvidia,gb200nvl-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - qcom,dc-scm-v1-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - quanta,s6q-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - ufispace,ncplite-bmc

Please order this patch first in your series, before the devicetree.

Andrew
