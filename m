Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140AB3FFD;
	Mon,  8 Jun 2026 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953505; cv=none; b=jBjRNiekDJI2Yxf8xHRStlCaR6mpWfC8F12QPmAky8tccRPFVr+cAtIrGTdWqw56HWb+9dtf9fjRb6AadlC79b0mBvfkQMz5sNboJ4sZZtoo3eoe9F2U9ytDK6a1kDpveVBvLUpZOQhi+TCvGDKCAGrLz7Eync4X40E6FPAtkDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953505; c=relaxed/simple;
	bh=CZjoD4QvDN7W36wtYhp7UlURyWnZwVeuTmGnAX24PCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/yQGvaGglVnjdPDg3jM4vZsysdEoq2jgUjYqaCNHtiaYIoHozQbbtWtBvGz4cChzWbZriXJkilYEQBwoB78pa7ZZE2teft4MQbiUUKwDLsfMYcql+qzQh3u2KjzDU0GvqW/Di+/T4PUutxlqq+KZk0l0Zl6GvP7+ruxssmWuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkZJmE9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkZJmE9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A891F00893;
	Mon,  8 Jun 2026 21:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953504;
	bh=q9KITn8LY97lVyq/2NQ6V2vh7bnTXO5W7Y55FYYzJX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mkZJmE9Ai4YMmUro3blrF9H76to56BVEp05lyC04thonNjs6CkIDP4+bKahnUSmjQ
	 BMRYtsjsR3W7VbAdiqrzxl65F+Lt+H0sNbhAwnlELm/s0OGAlQyQxHF8x9OBr2xWYe
	 bPSii+QZGlmWeUu1v0hKgV8ASfRR0AOGEIuFbfrUwtp9eowm97FSLXNEVHuufNuIlE
	 eE2oazZTJqaxeHLy5xfYVBcY+KZ70MvalKgBNEXHN4kRZtJA/bYifLoZKI38lHh/dm
	 FP4PKwUAuRnkqcRPwIGhVidL0VZM2+cQAz9bpK4KJkqcEzy0mKENz2w/FtjNRPXQYz
	 MqqFgv61Z6EDA==
Date: Mon, 8 Jun 2026 14:18:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260608141822.780fb5c5@kernel.org>
In-Reply-To: <20260608220710.7499931d@pumpkin>
References: <20260606202633.5018-13-david.laight.linux@gmail.com>
	<20260608132311.0fb69fed@kernel.org>
	<20260608220710.7499931d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 22:07:10 +0100 David Laight wrote:
> On Mon, 8 Jun 2026 13:23:11 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Sat,  6 Jun 2026 21:26:07 +0100 david.laight.linux@gmail.com wrote:  
> > > From: David Laight <david.laight.linux@gmail.com>    
> > 
> > Could you be so very kind to read the automated message you received
> > when you posted this?  
> 
> Looks like I managed to send two patches for files in the same directory
> that contained equivalent fixes.
> 
> I think I should be able to merge the patch emails into one and send
> as a single V2 patch that contains both changes.

Not what I asked you.

You seem to be following the ML yet you excreted a bunch of incorrectly
formatted and likely useless patches. Read the email. Start with one
or two submissions at a time.
