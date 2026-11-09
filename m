Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252407;
	b=GZluySiFqcb5cgY4F/8XCF/aCz62uTeiYAJIWraJBBsHEvri7FjsYNRInfRCVubTLMcs
	 OrK7Vjoe78nEP2Rsp1akxLXlL7sCQQP1ghAqCqMy8Dcwk8DiDsrfZAd2V973rX6WFNkv7
	 CctJ++e51K145iiAhvmvoMECZnyu4SimJc0I26K9duYmYVC/P2qiisRj9Ljh2WM1/SrW2
	 6tzX6CjTu2f/mEEIOdrPvcpJfN3GDX8SYMiOrUG+bAk9SKYkFeBfFvZ3O2HlUo6jbbxvE
	 QzGaEQCjgQClwIUHV45DUnRm9qgAYr5Xl5KTIonwublMZUM2tVymZKPa/D9Ocp8Ac7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252407;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/Pz0QJsGyF46AMKpnv6hARwS0Ub2uVinIASUcKJnbvc=;
	b=LHnJGZ3H/IQVex3MUJ1X9M6XyEW21HEm1dpy666KHJ8JhoNUUMqQYrUgttxePHHlkqz7
	 Iwr2ZbLl8oEoPZZkAPcyYkLrh5cyQ/KizrTCga6ZxTOSmcEiLZ7LQ3Bdx77lH73q4BXMf
	 vPnz6Ay2q2vrG6qCwCLSSO8TccP6YBPFgMf3KNfvDX2ZGSMrMefyQ24i0+YnRIel5vXk7
	 2TYAvzBRuLHMrHnOtfV9WgWU4s1XZGBdAVkm9+9C0EXuf3e0Cm5ctLHKEcbCNCOKsAYaA
	 ggEMeZvWkR1tOM0eC3RtHhl6FFHA5RA/+YEQQCBzFWbgkeecWaQNIiSZAYEsw1AnNiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mf0Od3Df;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478DB606A321;
	Mon,  9 Nov 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mf0Od3Df
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867231F0089F;
	Mon,  9 Nov 2026 19:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252406;
	bh=/Pz0QJsGyF46AMKpnv6hARwS0Ub2uVinIASUcKJnbvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mf0Od3Dfe2svPzWE8FAUtPyupulDlVtW1/UTl3RcPRf+sZsz+2avMJPoQK8PyC1E8
	 gl4cNX6Q40i6U61+D3lrPw8t1jprIkd2Lg033zMqymaSKp6U3MKEANf9h/QEkx9lsb
	 ecSPn4JcMWhohZlp4Dl8d1UIusVPzA6YI2GR9OdnV5OJzEUoYMPck9qVpl4Ott6cQC
	 gMLd9QjewjyyPmaHYgAtXgW5rtJb/pe43eJnv2PeYU2YHtFGSAE7YvVDSi9drDEJwd
	 G273k+4NymvyetFQp1In+vSR5258PeLDWA+0GRtAA51/b2onBAElUcqVg4kPKRT9C3
	 B6SX7uwWkCnfQ==
Date: Mon, 9 Nov 2026 19:26:41 +0000
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
Subject: Re: [PATCH net-next 1/4] ionic: register auxiliary devices from a
 table of device types
Message-ID: <20261109192641.GY18859@horms.kernel.org>
References: <20261103-pr46-b4-v1-0-850ab7fbec19@amd.com>
 <20261103-pr46-b4-v1-1-850ab7fbec19@amd.com>
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
In-Reply-To: <20261103-pr46-b4-v1-1-850ab7fbec19@amd.com>

On Tue, Nov 03, 2026 at 06:14:46PM +0000, Nikhil P. Rao wrote:
> A later patch adds a hardware monitoring auxiliary device alongside the
> rdma one. Describe the auxiliary device types in a table, so that adding
> one takes an enum value and a table entry.
> 
> Allocate the auxiliary device id once per ionic device instead of on
> every add, so all of a device's auxiliary devices share one id, for
> example ionic.rdma.0 and ionic.hwmon.0.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>
