Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF693D88F2;
	Mon, 10 Aug 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368438; cv=none; b=UypZK3d0lHxi7MoVPxDF1S2qxuNItWz09igbpeTIyFYEtLFXENFMf6uqu0rn/BoXwVBR3ZFCIiraq52SuspsdFDk6QJC1k/k1YymNLsMa3I1rHq+ZPGjRgaQL+c/EwKlhg1egOuvdQTf2MeJcWWQIMiwRrvXdKfLE0K2k///vJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368438; c=relaxed/simple;
	bh=4SXDVKUl4nf4BExyv+DEu60YpjIXwH7VV1lbim4RS6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfojFUEg7OMMuC5ZnFa2KcCcsbLv9QQJegvpO6JgK2pkBymVbfZQcuFvoecwpvmdKakyYpW5NnogAk3LbDikts47K/0jZ5GzrOA8UonQzs3agGZD4QPNfwGHAJiGhzjbwfwLEj3Zx8+ISHBHTfTpI+Df4R4bjzadp1bgknSyyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFXDtUhT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFXDtUhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C151F00A3A;
	Mon, 10 Aug 2026 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368437;
	bh=rnGAYO568aUtRSnWq8DCGbvB+V20cHJllRKUg7bQQPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fFXDtUhT9Wo2lB56/s3BuG2z+i0oHaJhPxWBz3Z7egmPbZCFkRQmzOBtgZyejTCTX
	 jnLHo2NOeE3DaSEC3SGy2YSkEEJCZjmi6nbqsK3DkJa1mTCkpN9iH0jixKSFw7JdgA
	 4/uzhMZ+aGpqNzmeh3+L5bA/z6PtY2en1TW23VgzK/KlXqAj2ogmZW8NlBC5I82B2x
	 jFo6iEbG1bXJj7YL6FJMPDr+W8wdzsyWUIseO71IoIy++15WK+8IywJqq43CUGTnqE
	 70mQFWdSLycHKKj1VvmxtCB/fOEtXw2IGrvZJKG4ME1c8niZkugA4QN5gO6pGaPgKK
	 gyTpVRTqzzT8A==
Date: Mon, 10 Aug 2026 15:27:12 +0200
From: Robert Richter <rric@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Ian Bridges <icb@fastmail.org>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EDAC/thunderx: Replace strlcat() with snprintf() and
 seq_buf
Message-ID: <annRsN6UBDPsFLr2@rric.localdomain>
References: <akYJUdY1hVABUQH6@dev>
 <amppKvK6mIJRmoL8@dev>
 <20260729230035.GDamqGE9bKD5ncU6ZV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729230035.GDamqGE9bKD5ncU6ZV@fat_crate.local>

On 29.07.26 16:00:35, Borislav Petkov wrote:
> On Wed, Jul 29, 2026 at 03:57:14PM -0500, Ian Bridges wrote:
> > On Thu, Jul 02, 2026 at 01:46:45AM -0500, Ian Bridges wrote:
> > Gentle ping. This patch has had no response since it was posted on
> > July 2. The code it converts is unchanged on ras.git edac-for-next
> > as of this week, and the patch still applies cleanly. Happy to
> > resend if that is easier.
> 
> Are you in a hurry with this or is there anything that needs immediate
> handling?
> 
> And I obviously can't apply untested patches.
> 
> Also, I see you've CCed the maintainer of that driver so he should probably
> take a look.
> 
> And talking about maintainers, Sashiko points out a bunch of previous issues
> with this driver:
> 
> https://sashiko.dev/#/patchset/akYJUdY1hVABUQH6%40dev
> 
> so, Robert, what's the story here, are we still caring for this or can I mark
> it obsolete and drop it?

The driver issues found by Sashiko are valid, the return parameter of
snprintf is wrongly used and may cause buffer overflows.

Regarding the mem barrier: On a first glance, it might not be needed
here as this runs in the irq handler. That is, there is no concurrent
handler and code will not be rescheduled to another cpu. But still,
that should be checked in detail.

However, the driver has several issues. I asked Marvell a while ago to
take over maintainership, but never got a response. I don't have
hardware to test changes. If you mean to mark the driver obsolete, I
am good with it. On the other hand, the issues found may not actually
trigger and only affect a single system. If we can live with it, we
could leave it as is.

Thanks,

-Robert
