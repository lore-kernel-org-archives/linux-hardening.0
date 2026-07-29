Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5C24DCF6;
	Wed, 29 Jul 2026 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366061; cv=none; b=Y5n/lumOm3nUtzH/uKSMYZd/o18ulepEwCFs3QFJvD9BVFyxpqwDafIwIpGiahbVjY6vdZayOBlYL0vHnqYx8A2dmMeu0i6ax7tNrHH8Njh5/7k67zVpFmGebmqYkzcCUwrprpZk6XYVENhwmNd//T/ftWSp6JRu9ju4t+bweCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366061; c=relaxed/simple;
	bh=Rl7HCT9942elsCU7c/U28VRSChx02dtrUUUW0L8vAQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSj6ffsWOCn2ALkK69IUgQkHnkqbnmk1MNXZK+KbJce3ClJDAK7TiOIMMSNvC2GyVuoCsnaqfwuu6yv1aMBT3VTi1KXkdtqb32IPbqWyTiOa0ARfPSJwh2Te2Lq5ahGh2+MF4hZzJeagWUJdGOH9VGbQ2009jWrtmvLFTWFBxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SKdbD6Z4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SKdbD6Z4"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADA4340E014C;
	Wed, 29 Jul 2026 23:00:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id V5hMOkV5vbEn; Wed, 29 Jul 2026 23:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785366045; bh=JL4x2+5W2lxTogG/LtMTNq8Q5LgXQhsBc4aXZrSLgG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKdbD6Z4Xg0g5YG01dMAy2u3l4C/N0X7UKTJte1Xrng81mwa+ej0R6oi7XJLRhNhx
	 ygj3oErmoGE9VAU/ykKWrT305OJjPmrILrgaAPOyXIALBeu1X3bd6c8w3jgjuYXwjE
	 WnXG9YpNQwF058N0YQuq0dNJEJWWRCaGnUTJDbXAWVY6vP4ptzl7BNii6L1Gh9SjCO
	 MpbBp0y4PovUY1woYT8Lbs7AV4LzAX/GSN6VtJOfuxQ9N2tRn8aHuF4SBImW3q+3kB
	 TOftachAhXrLkMdr97j4e+FsTFL7l/3wVu4cHorBuQwsekFaqf+SHKjRBH76xkq8GC
	 ZEhWSikem9JjoDJ2IvnGGHlBAPqnfZJCt6p60LBiWXI2+ncrRaa/HhkuF9yxolocnA
	 aQdLF+lUxFtTnpfr9cf40iUS7tmcmlgBVemIX84R3hbXGrrXsMsTd2ON4XJxro75Dj
	 z/bS7Ri9CEsVGqY2PHH1Jx1Q6xqlPEFqsq2Z8fYBBypZCRk1s1OqYXC6SaCthJyL1Y
	 mWs9uuGoUhSs02cekVx2Yc+ui3H3aimhxvcl+fgxKSfSnXKd1cUUKkmVc7c35DIkHD
	 IA2r9fMSzyNZsGL+ojlRgbanszx3DAtvBCA1xntodBuK9qGz9o+R0VQ9O8A8lM6s0M
	 15L4vuIDc4SoZO65FeE71eIk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1793A40E00C4;
	Wed, 29 Jul 2026 23:00:38 +0000 (UTC)
Date: Wed, 29 Jul 2026 16:00:35 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ian Bridges <icb@fastmail.org>, Robert Richter <rric@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EDAC/thunderx: Replace strlcat() with snprintf() and
 seq_buf
Message-ID: <20260729230035.GDamqGE9bKD5ncU6ZV@fat_crate.local>
References: <akYJUdY1hVABUQH6@dev>
 <amppKvK6mIJRmoL8@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amppKvK6mIJRmoL8@dev>

On Wed, Jul 29, 2026 at 03:57:14PM -0500, Ian Bridges wrote:
> On Thu, Jul 02, 2026 at 01:46:45AM -0500, Ian Bridges wrote:
> Gentle ping. This patch has had no response since it was posted on
> July 2. The code it converts is unchanged on ras.git edac-for-next
> as of this week, and the patch still applies cleanly. Happy to
> resend if that is easier.

Are you in a hurry with this or is there anything that needs immediate
handling?

And I obviously can't apply untested patches.

Also, I see you've CCed the maintainer of that driver so he should probably
take a look.

And talking about maintainers, Sashiko points out a bunch of previous issues
with this driver:

https://sashiko.dev/#/patchset/akYJUdY1hVABUQH6%40dev

so, Robert, what's the story here, are we still caring for this or can I mark
it obsolete and drop it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
