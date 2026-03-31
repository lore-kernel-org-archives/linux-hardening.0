Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335831064B;
	Tue, 31 Mar 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977276; cv=none; b=PH7gBLE85RmAevE7qOzzgSYpTHP92e1xAPzgjT6JhTUPvwPQcOI9Ormceuo0nXQ8c8FHpTehRN4tE5ARPgyx50N26fp65VIE73+CbMFOHBLIIAe7sHCnJYJ3ysBxgnLnmrnlbXfyOTw06xS0OEJq6YmGOHAt0baMrCKkvOtZtjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977276; c=relaxed/simple;
	bh=OwFhfSji/gfFT8mZm4GzFhJh9AldTa7w0xtWNsHDbPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvmPiyjV6qDCkORc5KhfBQQMibklf6j5V3TPJv9zuC88CVBUV8OcC3PvUx9YG8lVHkQy3sxevddh8VypSSV2hCY3D503N/3zcJJZQ6kYPp0H3STOowzKS2CTp6h/u4ELjHXoOQ7xzv3rvacSDa+dtjY+ZA8ALfbJ3dZFOKluadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V737HzVR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V737HzVR"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5A48C40E015B;
	Tue, 31 Mar 2026 17:14:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Aa2kWCf-zHsC; Tue, 31 Mar 2026 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774977269; bh=N17qtIsba/PvZH8caIjEEYxc2ntxX/rn5C5/Q4mou/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V737HzVR9Y0eD/zZC3ypjhhqWcGLBH6zifSlFq4eXUEng/mwDFOpTCE7y6WCXQ+qX
	 VtHWIYJjDQcLTqg0TueN0eZceo9uSpFqu91NiCB3+jpPUxBIOPY1TEQr2oQ+dtCMGG
	 gnTkr/O7wyYlEKCCtn2Vo9TpF2tsxvqn/yfltibT2YcUaKy5ZiHdgYakOCnhDxM+nI
	 vmZEt0rzsH+VBjHEsH1SEcXwZ8C6LgqF++mowgrtcpka5adL7qZq0qSf5jAl5SWl4R
	 V74HDHSVs5TnFKEBK8cUVGu4vFh4yuT0tADRskrAu2pV2PDDxy4eGpgx6BUR60SORU
	 gzx85JT9IWBJlv0oiPoG2YGDmMvSm9oWT9WsjOV3e1I5Mru0tVPXOtlZ0lbN7P6wfs
	 J5hKbzkL6GzUSo9XH8BT1mUAn64s8S9NXFj6ZLE+cvyKgqAW7JNok+Zh1jBzQHHXoc
	 38cJ5408LeNIwSLGAR7Hnm64wlSOzF7BtlLb09SLmx2FoIhrCYJHauFKxRM2tbf8BI
	 Fn5DR3hvJ1msWlSJZlkI+6lPTNHptkNczU8prYaF+Xe3iNy3YI9ylWxCNvoaMBCDww
	 sfIsfKoWayt4xexVDZCP3GFrQ17729UCGI081iDpJDGTqCKy/8MYuPYt1BA3faqtP3
	 DxucmaIA6ZDM/Rj7QgsQa4IQ=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D096140E0032;
	Tue, 31 Mar 2026 17:14:20 +0000 (UTC)
Date: Tue, 31 Mar 2026 19:14:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Rosen Penev <rosenp@gmail.com>, linux-edac@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] EDAC/mc: Use kzalloc_flex()
Message-ID: <20260331171414.GGacwA5uu60YGgF87B@fat_crate.local>
References: <20260327024828.7377-1-rosenp@gmail.com>
 <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
 <CAKxU2N8HqFRT+qb5ctCVckC6c=viR7u+xyUaHgm-87C5=yo1ig@mail.gmail.com>
 <20260330211123.GHacrm-03xUU_3yX66@fat_crate.local>
 <CAKxU2N__gE-bWBU6EkJmEK2gR7VE=Va+oN6EB2hpJoHbUiYVxg@mail.gmail.com>
 <20260330223222.GJacr59uiTZzPRYbWX@fat_crate.local>
 <CAKxU2N_H4mvrJh+zgoikY8J9-u3nnWK-1dQwZanDNksoE75hvg@mail.gmail.com>
 <20260331121840.GBacu7oF3AjjkLtcBZ@fat_crate.local>
 <4ce84891-3449-478e-990a-eb77f53a956d@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ce84891-3449-478e-990a-eb77f53a956d@embeddedor.com>

On Tue, Mar 31, 2026 at 09:28:47AM -0600, Gustavo A. R. Silva wrote:
> This is misinformation and should be phrased differently[1]
> 
> -Gustavo
> 
> [1] https://lore.kernel.org/linux-hardening/37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com/

Yah, I was wondering about that but thought there are some other requirements
I don't know about.

Btw, can you do me a favor pls and summarize your very good blog article:

https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attribute-in-c-and-linux

into a text file in Documentation/ so that we have the valid requirements for
using this compiler glue properly, in the kernel?

Thx.

Now lemme zap that line.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
