Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54852D8DAA
	for <linux-hardening@vger.kernel.org>; Wed, 30 Jul 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887256; cv=none; b=MG1F/sYKVqHvcMPLGXFk3Olf9toFC09UneNaMpnPM6pXPl/aIkel+z0+RbG87SRlKyjYda4s4rvf2eMnW5SURG/Z4yYoYqRLH70ZCy/XWv09pDhWntk06vQO1XKVyJEBdGpOOdCORZGbbji1QCyJAMDcw/ChJxzvZ/7SIM3fv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887256; c=relaxed/simple;
	bh=ie+RIG1rJYm4GmXC8JjeZKFDJPovwpXR3vjbC4sifHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1AxJgFOvdES2u5sftjG/Aro8KYtlTFyXvBeD7xH7jhzq7lsEW/LU4u4rAmozcbiwK4YMkckDqVOol8Yb3muuwfGWd/ISSNGZDWx4MwDoc36/yjr9g1zvjRs0DaXOC4aL6cH+6qyLKGkqM46tcynwxP2nM7zjjV3peVHYt8hIRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=k3/IZMwH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="k3/IZMwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ie+R
	IG1rJYm4GmXC8JjeZKFDJPovwpXR3vjbC4sifHU=; b=k3/IZMwHuOeVahgnAUu3
	vKGJIsEkUiEf2hNu18PmR2tKdfNsrxv1TcfC/S69NHlxnqJvQo5If+rPkfAaloRJ
	8172ZavzDWHQ0k4uKjZ8xIAV8wCem4OvcEtcSwqaKL2oUpfwDmYUQKaXb6M7noGE
	lTiDjcE1xynJGkZ31TNCfeUnyCZjIgtaFrZ4T7bKch6YzoT+Q0yYXDj4O7uAdyzj
	+spw4hAnmtm+POL/tA0fc08wRD2rwb/Yio59fyX+WbzLI9NHEenPQBb0vVAYx7zd
	Jvc7FbKdKjFzgJbHG5yibH4TS8OZIXd0J/ZLIq49LWD+RBuXMT1xUoWvzD9Zb5Cp
	FA==
Received: (qmail 19156 invoked from network); 30 Jul 2025 16:54:09 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jul 2025 16:54:09 +0200
X-UD-Smtp-Session: l3s3148p1@M+RwsiY79lBtKPC7
Date: Wed, 30 Jul 2025 16:54:08 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i3c@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 4/4] i3c: master: Add basic driver for the Renesas I3C
 controller
Message-ID: <aIoyEKpB7twvKDGN@shikoro>
References: <20250724094146.6443-1-wsa+renesas@sang-engineering.com>
 <20250724094146.6443-5-wsa+renesas@sang-engineering.com>
 <CAMuHMdX5BfNm1GJ8UyqftcVc07p1aodXuVHxNaYWDYLHaxzXMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX5BfNm1GJ8UyqftcVc07p1aodXuVHxNaYWDYLHaxzXMw@mail.gmail.com>


> Why not use readl() and writel() directly?
> To make it easier to add debug prints during initial development?

Yes. And ultimately, there is a patch in the works converting the driver
to MMIO regmap to get rid of _all_ the helpers. I couldn't make this in
time for the 6.17 mergewindow, though, because of... gory details.

