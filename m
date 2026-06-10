Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AF21CA02;
	Wed, 10 Jun 2026 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053205; cv=none; b=hozShO+rrH/duMs4fcSEkQiUwJ8FWr4ONxxdUHttqTKOWmPZ+C0U7HRA0KO/rwpc+mBRhV4ZMCGeokOln2JI1T2rRD2wAVZrT+Xa9na7g6+P8n9ffwynDn0C5VDKn661Wv9yH/yoE5BL8PMePYrlVq0tRxGwIgdUKlW6RAAGdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053205; c=relaxed/simple;
	bh=NY79jDaWT1YxXpLnGOEwpu5chz+h3gqwpbGSNXUahRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSFlWqwNTtJ6/JCD9OEzOpMJdCZ6ppPVx0jRrrgne3rKJx07x/Q6+8Uj3GzmhxdXVI+ZYMqcy0LWY/JncYABfYGIvc4Ce40qq1gqAvZjip8mIFWettQBPCVqPouAXxOHmXMq3OzMbEb0Nuicn5kwXk60N26yTgANtjrg+Qxc2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiOdeOtX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiOdeOtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D0E1F00893;
	Wed, 10 Jun 2026 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053204;
	bh=dPkJYjzY5JPEmIZXonT3vNfcky0zjFEpdKWA2TGjF34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CiOdeOtXG/6zAlje9jVifaIYaoEePDRHvEZOF4mUquIi/dng7Fq+KTmEvAFQp6rGp
	 nHF5Py4OFrzi/jmziWozozsxv0D3I0NMH1P5BpGAYJ23rQfGsqatBsSlXPNXsOWCRx
	 KU2HaaW6edJzRIFXDkiWLPxLg4qNcnRcjTdSPbShWRBJyfMLk9cvux7Nse3zbDhMvM
	 q/BlM7HxXEI6L+0YEOwT0vo6LscT0ySO+FTqBrkODlpCv4A3nCPsYI3a8zkrZJ9t0V
	 bXXg6nQypuQ56BWvfifTDg9prMkYKBC7VWTQLe1yrhP9DAY7e4BW1a64AmxuYxFQfQ
	 OXJUIQ/fqIsFA==
Date: Tue, 9 Jun 2026 18:00:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ido Schimmel <idosch@nvidia.com>, Paolo
 Abeni <pabeni@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net-next] net/ipv6/ip6_vti: Use strscpy() to copy device
 name
Message-ID: <20260609180003.31cf7ab0@kernel.org>
In-Reply-To: <20260606202633.5018-29-david.laight.linux@gmail.com>
References: <20260606202633.5018-29-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jun 2026 21:26:23 +0100 david.laight.linux@gmail.com wrote:
> Subject: [PATCH net-next] net/ipv6/ip6_vti: Use strscpy() to copy device name

Same comment as on the bonding patch goes for all the patches which
copy from dev->name. If dev->name is not properly terminated we have
more serious problems that this copy
