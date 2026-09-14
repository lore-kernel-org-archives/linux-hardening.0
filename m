Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F15309EFC;
	Mon, 14 Sep 2026 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355688; cv=none; b=gYRHSmibCMBdLHRWf5r4MPCwo2iVQNRbeB0VP2vhWXYx3Ph064MWivQxI4cLaQYM+GJDjEbZeaE4LdsiwPp1Ku+LskQy0XkAdRdDewCLuU1JkO06Q+Hk6qo2qZAShikZSF/718RbgbhHPcSXSoSwgDW9QTMHHHWP55Ei7pVWty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355688; c=relaxed/simple;
	bh=Kst9H8QAp72Ex0+AcWjLAihT/uAavXuX/eZAymNICMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Msm9dpmrt2D0c0JWaMa5u0TU9qF5gPgU/Ty97X0JO4A7+V6OJowE4FAvMgmQFGRIT1kKEnn40//mY5DIVti1jrRcnsV9iwH7rLVInIzrp7bSASs/v3dndjAqZdjpmE2Qa9nQKwBhB5Be9l8VeqQREC0vYDgr5dVIgvgukN+hqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=L64ogaRq; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="L64ogaRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1789355671;
	bh=Kst9H8QAp72Ex0+AcWjLAihT/uAavXuX/eZAymNICMU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L64ogaRqE3HYOgVFVAkYALz2+YQULd/lKSybxxDG9MHoGqkWeUJsLn6vGpCvWDXwm
	 g7OWsmxAJq0cKTcMkkNkTZdmJUepErYVk1Mq36+g5jUifSR96/wLnrOtW2sJcKmMdL
	 eFogDQ6Ary1EmLhG+ArhXrt4lphTeXsDy7d5knHDHH7GCFEhBM+aFeE+0mch/VkHGd
	 8ezuCSTLQ1SOnCHMny1ssm6Gfe8v+0ESnJ2hU5Av3lpaKRWKu6u/lwS9ovLq9CNkor
	 7fUZiITVov1g3nj1OHnTSRCgOBSYyb5c8lzJ9a6b3G4siEmnUvjh0r2ylJQn8sIPFJ
	 xXxP2rtMAeRAg==
Received: from [192.168.72.170] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B6A2069801;
	Mon, 14 Sep 2026 11:14:29 +0800 (AWST)
Message-ID: <af7cd0fa76d0d32ac4ae34b6db201defd628fd42.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2 2/7] net: mctp: usblib: Add test for splits
 inside headers
From: James Lee <james@codeconstruct.com.au>
To: Simon Horman <horms@kernel.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston	
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 14 Sep 2026 11:14:29 +0800
In-Reply-To: <20260909071217.GG40544@horms.kernel.org>
References: 
	<20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56@codeconstruct.com.au>
	 <20260903-dev-mctp-usb-lib-test-v2-2-313cf15e0b56@codeconstruct.com.au>
	 <20260909071217.GG40544@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-09 at 08:12 +0100, Simon Horman wrote:

...

> Hi James,
>=20
> This is a minor problem and it is addressed in the following patch,
> by removing the line above, but i is declared yet unused=C2=A0 and should
> not be added here.
>=20
> Flagged by W=3D1 builds with GCC 16.2.0 and Clang 22.1.8.

Thanks for the catch, will correct for the version.

...
