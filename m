Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C784144D0A;
	Fri,  4 Oct 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032999; cv=none; b=d4YHQOrzr9ZCiyRGNndGOF+wuF5emZKdQx7E/jAVeOraEUTE/Yw8vpYTAGIFJaRZayEPL6kn2V0HlmKr2C4yWPAh7oaoH0GZOeY+qLuctjm0vbiYaiaPEE4q+0MzWm7W8G1W0ByK6XN3K2ngzxokrob1tKqcNyuIM2cF4EhoSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032999; c=relaxed/simple;
	bh=I6EOtZmocQBHs2WHd3nFypMs+4MVUIXOwypT6t1NWXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIvueMi9Amdq+q9RaRKYJVlnQtgoW49iO5o1qcgEQGYKZ91focmys1dLxCyi61dBslPU+Cz+J0tOc9rN8pPQtyht2iccH5zRdrlafrF/C8Jd0S17rQAC0ppyFlNQuVhGGT/gBlYcb6td1P477BaRs/cgkLct9+08AhWXoi5Hcxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BRE1pX97; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BRE1pX97"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zppxy3hAjcFadbhorn8LmHeB5MeFnmyS+d2upsi3xw4=; b=BRE1pX979nhXBK8ettm5asQ1nG
	sbG57b2E0uijsJqlg0/cXtw7kHYIuu9JSpJY/hJDfuTFo2PTUkyLZ/P7dqEz2fEHAs2QBMUNOCOyb
	80F8KJkYu9Fkrw+NuVurz/V8w0nSI9DjB5ZN/jAju7oZOm9bxtg1uKcV03NoHShSzQRsa503lIswi
	WWRidyU+e2KagtafsT99kUXGTRZSl4nr2Xr2PpMYvoSq6OQmAearnLmfSHiiOXdq7wU3yIVatUbno
	ySihYnAZstazM4hQbRkR28KUz+GX/PgXAnwVM8sQ+kC6qb1TFO2mvMnRChZy7uiudyLSVVZxbX9rL
	eoM8tgkw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54774)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sweJs-0001ar-2T;
	Fri, 04 Oct 2024 10:09:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sweJr-00013s-07;
	Fri, 04 Oct 2024 10:09:51 +0100
Date: Fri, 4 Oct 2024 10:09:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [next] ARM: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <Zv-w3rXt1OLnAbX6@shell.armlinux.org.uk>
References: <Zv9aEoDo1k36Hg3H@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv9aEoDo1k36Hg3H@mail.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 04, 2024 at 03:59:30PM +1300, Paulo Miguel Almeida wrote:
> There is a general misunderstanding amongst engineers that {v}snprintf()
> returns the length of the data *actually* encoded into the destination
> array.  However, as per the C99 standard {v}snprintf() really returns
> the length of the data that *would have been* written if there were
> enough space for it.  This misunderstanding has led to buffer-overruns
> in the past.  It's generally considered safer to use the {v}scnprintf()
> variants in their place (or even sprintf() in simple cases).

So, basically, it's unsafe to use the result of (v)snprintf(). So why
do we need to change locations that do not use the result?

This patch is mere noise. Sorry, I won't be applying it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
