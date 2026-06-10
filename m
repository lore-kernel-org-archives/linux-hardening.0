Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A741C5D59;
	Wed, 10 Jun 2026 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053427; cv=none; b=rIV/bM/4G2KR5XeOea/tFSSeXDce7qHTcR1VSohDlc2ENXdwbCM2Lx+2CDNtMctGDN5euOzLeivVsmcyVDBZp+0R7zy+nYWBJDsAQsdx+LfXCfHMPmoFBzwLX9FBeNgNIQ4BXXKnYY+07Zn+M281S/zdfmWb1Qhy5XZIVyoCJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053427; c=relaxed/simple;
	bh=fZBEKuDVT12AWDpvKEuztfeKBJqN88ZgmqcJ2ftIf3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJBD9WlV1+MqjAFWJiWGeKlc/iKmEyUbaJZclZj4xDXlRUC1x0WagYNFFJvayG8pckomt4ORAOLBMMI5MpBUyuuSb/mwTDA9hquW6NVRbg320ZPHaE1pOrTjFjU1U22kp9CBYCUEo11uIJ6y1QGTdH4OHtpvgFM92f0kWjSi+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6eie08k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6eie08k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66511F00893;
	Wed, 10 Jun 2026 01:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053426;
	bh=Mz4zABv2K+JZzneh/w8kTCcXsSuy5cWoOaYAkzYhTK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I6eie08kCH3ikrsn57Lm0Xmk5XYoLSXCRCVrAW+KhlcZTUViDdqSdwDUV/qBTUeH6
	 O31N5zNlgURhRCx18ceHy4cMCdQ+qgHkhXa0aiUALKEOYQDmbkHFQPkedN0/OOuY5S
	 rmN54C15JN8B7YQ5mFFG6gRe7apIj54MfqyWE5p9QuGCpw2YaeytC3bPuxwnykZF99
	 4+jblE8T2oYrbN6hk0J9SNnUKSdeVoxkTGtxIOAZSiLFfQt0cRjXggoIZcYXNBWsGe
	 Dey9LkzQGAvBtY1YEB4mRakKAfTMreULlJrYCcxwOah/ZtQgNvmLeYYzPj15lVnLQf
	 vd0Smwv9+0HUA==
Date: Tue, 9 Jun 2026 18:03:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
 netdev@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Edward
 Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/ethernet/sfc/falcon/ethtool: Use
 strscpy() to copy strings into arrays
Message-ID: <20260609180345.6650f2b4@kernel.org>
In-Reply-To: <20260608095523.2606-1-david.laight.linux@gmail.com>
References: <20260608095523.2606-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 10:54:45 +0100 david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.

all unit_formats are (obviously) compile time constants here
-- 
pw-bot: reject
