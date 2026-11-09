Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.137.112.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262803;
	b=TW3sMu2ELdXq8DGIgvHJZi3m1EU4IzYBiJirufajgtpa+OqMySZ6S8GswlMY5I5tJrkN
	 eE9GM5dEtcERGxMRE26sGGrP4cG4Qjv+laSpbE63VUnuEv7me+9cXHG7BY+teZHBOEi01
	 SPGbd7cXnLy0TTq8Un7O10uaMzrOr3Pf4NWoHvS0xjm1zCBbUgg+fx5/K+cqr4DLzlCEs
	 4/mVziemvySaHHisX12R3/T6pQne5xaGe8gz9vIpkTWE1kxM56vyLlurvDMqnKokCVKIL
	 n2OqDAiU9dnpAxb0fHZ1BLZo2azsiBio9gBDLTdAMXk7j36BYzob7aZnJwEpnOAa2GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262803;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=45dSDyWU6oJWDa4SvOAf6tvnwdr0UZNbBCj99nM+X90=;
	b=E1AA/79LTxNyWSaqJ0VPQk8e+27MKEhqBc80OvhS0OdGyo/GH5xyWZGd7Ac/P71FyqdS
	 utiGF9dI6qsfbJpmOASuLqmwY7pdSdVffmnjWMa5qwMcvUU9jX6JvLCiZEz+P30j5frRo
	 53D4yABUZ16ogcspCB6lSyMQbv3yidWr+9FzHqBiHPBzRlk7WPCGcY8mot/sa/O0TDyKJ
	 5+acJ5QGicU8w+i1J4DRwOImMpkmHQNqzX5cV7A1z89u+z/sTeWZXHo75GwvV0uKZPZIo
	 vzEcWGchWtJYKkqi+hQuUqLb4PQ0q4Q8vapJIbYjhmrGZkfvUOrlJFRoBGHbnzbUXWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vicb.net;
	spf=pass smtp.mailfrom=vicb.net;
	dkim=pass header.d=vicb.net header.i=@vicb.net header.a=rsa-sha256 header.s=f747d04263f05989 header.b="J/nrTRAr";
	arc=none smtp.remote-ip=203.137.112.168
Received: from mx0.gmx.wtf (mx0.gmx.wtf [203.137.112.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F951606A326;
	Mon,  9 Nov 2026 22:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F951606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vicb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vicb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vicb.net header.i=@vicb.net header.a=rsa-sha256 header.s=f747d04263f05989 header.b=J/nrTRAr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vicb.net;
	s=f747d04263f05989; t=1794262795;
	bh=45dSDyWU6oJWDa4SvOAf6tvnwdr0UZNbBCj99nM+X90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/nrTRAranCDcMTNL8ndowBIVo+hhiMGmSKoMA0owL62fgozgFtHSAn0M9P2htGhX
	 yV30084sAv4LslsPKAz2BwLsFL5RH4E+DFhGfgxaO/KFASMwkY2S88GTCx4Wy7aZvR
	 G2F6mEGg+5S7HOFAOsGx0l8CZANJHUBGjkyRNMWQLYpI8P36L9/YGx7A3ci2s/S9qZ
	 droK7F74brLIePqPF5ViJlt2bePipnrjNtyLcxGvRaERXIBuuV1vnX1RSnTHiwl/d3
	 FarfZH/ota3PL9FUQO+j8m4sbEfLoQEJF8seWIdhAuVl3y2M5UhqQdCZrzxCtTzbdm
	 LzvdFrhgKRC5g==
Date: Mon, 9 Nov 2026 23:19:52 +0100
From: Vic B <linux@vicb.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] security: Restrict unprivileged access to /proc/config.gz
Message-ID: <avJHCL9Uu1Ud3GCT@vicb.net>
References: <avCF9zEHV48EHjgG@vicb.net>
 <2026110958-outlying-dreamy-b249@gregkh>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026110958-outlying-dreamy-b249@gregkh>

On Mon, Nov 09, 2026 at 03:38:16PM -0500, Greg KH wrote:
> On Sun, Nov 08, 2026 at 03:23:51PM +0100, Vic B wrote:
> > When using CONFIG_IKCONFIG_PROC, the built-in configuration is
> > world-readable through /proc/config.gz, which somewhat weakens existing
> > address hiding defences, as it allows an unprivileged user to simply
> > read built-in config from the running kernel and build their own copy
> > with identical System.map.
> > 
> > This patch adds a configuration option to restrict access to
> > /proc/config.gz to superuser only.
> > 
> > Signed-off-by: Vic B <linux@vicb.net>
> 
> Full name please.
> 
> But really, a .config file is not a secret, this isn't needed, sorry.

On all my systems (Debian + mainline kernel) the .config file actually
reveals System.map - all that's needed to get matching (fully identical)
System.map is to grab the config and build mainline kernel sources of
the running version under highly predictable build environment (i.e.,
under same distro, which is also strongly indicated by the fact
that the running kernels are installed as deb packages).

So the goal of hiding .config is to hide System.map, for same resons why
there's kptr_restrict in /proc/sys/kernel.

In particular, the problem I'm trying to avoid is that if an attacker
learns even one runtime address, with matching System.map (or just
.config in my case), they may calculate KASLR offset and derive
addresses of other symbols (more precisely, as I don't use
CONFIG_MODULES, all other symbols).

If access restrictitions on /proc/config.gz aren't needed, the only
solution probably is to disable CONFIG_IKCONFIG_PROC (which
actually is kind of access restriction anyway). May be feasible,
but I'm gonna miss /proc/config.gz...

Vic

> greg k-h
> 
