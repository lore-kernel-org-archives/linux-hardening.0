Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252432;
	b=FDrMMstZHJHy5bqNa/JTFRtv/x9zTDCuax6S/bZI5WUrzbaVxME4GWkkhl1GO4RQTNWU
	 FPglwUfASut8NRKm/zejRvFmEDSrugZ/cugNzidyQ4t236henL5BpU6JnvVKiaDeWFkGj
	 bXoGFkRbQBaj/lHD7305Wat2IzAhlX5t/x8nwoYHIEKWTlofmNM0qXmGWmtJkyHEUWYCV
	 eu3sr2ZscDGARILtfNqWUvaz/sh2Eci7Hhb0VRO+bLARz6rYob3g9m4XfOOqz7xeGkyPy
	 JTlLgC6wVHZgdMywBeWs7H2mcqF8ZE146qSCPYd/rWKaFFLj6LhWVqmutXotLES4qKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252432;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R+tOXrTvvuf/l6pDacnlsvDL8MUGfsR5981h/f7U3eA=;
	b=knsnUQ5/b/v8lHKF+7ugT4HQalBWV500HFod5LacJbE+0K+MrgCeWcLKzLKtK6SlgERL
	 6lLCxGzFURs36h7MiFQv+N9mufZpjCMB7WGCUKjF5I92nnjTyzoLS9476CDDo8bUbEFz4
	 3irCMHCDebI3ldRXLFbXrCnzvw/Tv08V9fRqJTLyQDVRjyAmQV/3Z8T2MFf561+EtTM1h
	 ecWaO92hoe8Z4B0VuIATDfJ8EwtOkr9+yp1fGxyrljlBB0x++w3zT3SVIgfBoWC4mGy1D
	 wc5TVZ3gvYJv7yHMLek8i25TJ5RvxLEgiTGrD/tG4RzobOQx3RL132e9lsbkX+DHwdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gb8kGgbQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F48606A321;
	Mon,  9 Nov 2026 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gb8kGgbQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36F01F0089F;
	Mon,  9 Nov 2026 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252431;
	bh=R+tOXrTvvuf/l6pDacnlsvDL8MUGfsR5981h/f7U3eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gb8kGgbQZR8b7EU+UyEn4QSAeEhTPPDlmUw/Bl4dj6kIwwsZpvn2R+2KcW5qNYSap
	 kWd6h0uY1xMts+iEbfX+ovy/lcK+37tOIQLOeGi70MnFUtaGMGj2HxRdlQvauxeydE
	 bR2F+53DZX3OAzU/BnCjqiwmu5K/6pX7zTaF13c8m4mejs6RRoAnOi+pbhwmOQKz7R
	 +jHCopNPBLpPlwRWS/3XquqKNiV1OqgwVqeVKmWGgiLbiVciVR7JlmwqWLSJfRzA/M
	 xJa6SGEeSUYTl1dKEZMzRMHCw0r9L4c7EVq/KI+z4ncveZR9iTK775rOjxRN5Fi1vb
	 BvZ0oqVzb2XjQ==
Date: Mon, 9 Nov 2026 19:27:05 +0000
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
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Arun Kumar Prakash <ArunKumar.Prakash@amd.com>,
	Eric Joyner <eric.joyner@amd.com>
Subject: Re: [PATCH net-next 2/4] ionic: add device interface definitions for
 hardware monitoring
Message-ID: <20261109192705.GZ18859@horms.kernel.org>
References: <20261103-pr46-b4-v1-0-850ab7fbec19@amd.com>
 <20261103-pr46-b4-v1-2-850ab7fbec19@amd.com>
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
In-Reply-To: <20261103-pr46-b4-v1-2-850ab7fbec19@amd.com>

On Tue, Nov 03, 2026 at 06:14:47PM +0000, Nikhil P. Rao wrote:
> From: Arun Kumar Prakash <ArunKumar.Prakash@amd.com>
> 
> Add the admin queue commands the device uses to describe and report its
> sensors: IONIC_CMD_HWMON_GETCAPS returns a buffer enumerating the sensor
> types, their channel counts and per-channel attribute capabilities, and
> IONIC_CMD_HWMON_GETATTR reads a single attribute of a single channel.
> 
> The capability buffer has a variable layout that depends on the number
> of sensor types the firmware supports, so it cannot be expressed as a C
> struct and its format is documented in a comment instead.
> 
> The sensor types, attribute IDs and capability buffer layout go in a
> new public header, include/linux/ionic/ionic_hwmon.h, because the hwmon
> driver that parses the buffer lives outside the ionic directory.
> 
> Signed-off-by: Arun Kumar Prakash <ArunKumar.Prakash@amd.com>
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Co-developed-by: Nikhil P. Rao <nikhil.rao@amd.com>
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>

