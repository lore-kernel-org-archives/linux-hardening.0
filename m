Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252446;
	b=LtzzD9XFnJxtI3SUD4+zlzs4EonzrjBsSmdM9xn/Vrdo4CCQ+AEF3/kGD69Te/7EmCNk
	 lCrzaOjQdvG8KwDee174ENmxVrX+GES8NJNSrK1TioC7/p/MotRmGuyGQ8f6COnVMfgeK
	 zXSwkDzoKYXBeqYpKj59TXQT0Hy2pQQ1sVKnmg6dT6rGdk5cKqcvxafeaZYzFtNCAa+cu
	 E0wEc9PgFbZdZy3TUMEGGfBmKR3Bf2+PXPH9AZzqK7m5x17cuaOJNz1gwk69synl+eGPu
	 9dvmvis+YLJqwagVUCBx4Hnzn+lWaDOLrqBOxTU24QjI1sSUVH72obGolFJVPUMXybA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252446;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VqI4vEj9I0PE8OdnRFGraF5rg0lsij7ceArvqc84Ggc=;
	b=Ukue1JBu3Q/dYR2Ok+19Ksh/IZ9UCOOkVamlXJpPPO6DEA+OwrExxv9RyoycNnESemHy
	 VjHqUaXmVwCpPYlqxSUmVMQIEl70fQk05S2mp0Bev5SxGlssq2TW2OrypHgJuqv3lYFcp
	 uadi0BQnoSefZdNszOPdTghQ084rSk5IlsVAEy/6An0Ustu+3irGQAQ0bF9RFoqJaDFuS
	 wEASKsoJhbKYAXelU0SaSAAmXFBkJrhR7BLw+AbEJ2I329PILFGnaLWCwnvcxNTR46PNM
	 tnDj6rWmoLzEAbDI5ZLQhXdWYWp3GWkuNHEOIcrI6Uq1LUkP6wrIeCRUl46CtB9xOVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALXmOPih;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF82606A321;
	Mon,  9 Nov 2026 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALXmOPih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9741F0089F;
	Mon,  9 Nov 2026 19:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252445;
	bh=VqI4vEj9I0PE8OdnRFGraF5rg0lsij7ceArvqc84Ggc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ALXmOPihuMxoB5rOy1DtnfFXSpYohLI+nUQJjB4I2A2RzJ6Aj6yhCZ0BqF5gxv7Yo
	 O0WCPpcIRxOSPq5EQhKDAuJ/jqVeFdFvrcKxdH9YfftJMv6LQiU2cPSt52b7zfzJ0w
	 8BLKelnSCcmb4PlRkLw1CVwr6ACGGNja6hlYaWXhv2h5bOPgB27RS5U9RCj87IvJiz
	 63NFE51VHmkwSUvb3kCfiffJKYXpdXH281uLhRmIoGynzY3EAR6Uy82IILhivtoBbz
	 JUmu8UXs+6+iTVqXeXSml5Me6mtfF2Ap6w8mDJg8VG4ucJtNhT3e6gbimIIY9U7kh1
	 vuu6o3M4OESsw==
Date: Mon, 9 Nov 2026 19:27:19 +0000
From: Simon Horman <horms@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: Re: [PATCH net-next 3/4] ionic: add an auxiliary device for hardware
 monitoring
Message-ID: <20261109192719.GA18859@horms.kernel.org>
References: <20261103-pr46-b4-v1-0-850ab7fbec19@amd.com>
 <20261103-pr46-b4-v1-3-850ab7fbec19@amd.com>
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
In-Reply-To: <20261103-pr46-b4-v1-3-850ab7fbec19@amd.com>

On Tue, Nov 03, 2026 at 06:14:48PM +0000, Nikhil P. Rao wrote:
> When the firmware sets IONIC_DEV_CAP_HWMON, create an "hwmon" auxiliary
> device so the adapter's sensors can be exposed by a driver in
> drivers/hwmon/ rather than by the Ethernet driver.
> 
> The GETCAPS response buffer belongs to ionic for the life of the device,
> not to the hwmon driver, so a command abandoned on timeout or unbind can
> only write into that buffer, never into freed memory.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>

