Received: from mail18.out.titan.email (mail18.out.titan.email [3.64.226.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AE381AF
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jan 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632948; cv=none; b=Vp8GrkAxLXomObOi+r1NaB/ILUk0GumEZVMZ2GChztodqy/caDDtqPK4ayBONfq92JEafUVTOmomPhjbYgjNzPIrdnLdWYoeKs/OQJaAK6pQB4szkxsdFXCDdqoexB3/5IEW7qmGelRg+EtAG8fa6y1/LroM+y9itQSSY4LVTI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632948; c=relaxed/simple;
	bh=q6Ce8a8ia9M08AhZl4src3xmI/3FgOzW9RTWMSokC4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP6x7gCzVmQWBlJTn9GYWs2Gy1ktlBChQIX9+96xrk45yFy1ChXDyUHf8Ma1FAZ3On//68LGJ+MH9Z5EabOsvdK/rWqtFvP+VeZ7a7qcDjLI8qH6XTJiXOSnQLZEzbSDQ9l+NRWaXLkhnXr3o8tF3Kn4GN4AmYLlviHGfhQdazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=Fc2Fd8EV; arc=none smtp.client-ip=3.64.226.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="Fc2Fd8EV"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 74D23A009B;
	Thu, 23 Jan 2025 11:49:05 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=ca3oy/MkgvP9nayGTQfoqVybrGtRIU8AWKZ9G4JDDNk=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=from:subject:mime-version:date:cc:message-id:in-reply-to:references:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737632945; v=1;
	b=Fc2Fd8EVVLUyGIxG4zcGYUeUT7INXNhnDCA+AvneGXRj5Z1xXWu1/Slx2kMJ2y2p5BhonEv+
	MO4xW9Qhqlc0iypnpwldr9C5I8FtDRC5LvYVKG5SzcJ1MiOowhcw8QH/zqV3ttOHI1M5hpGwEuI
	R8gu9uHJMwiXVKnZPxCawb/k=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 06995A004B;
	Thu, 23 Jan 2025 11:49:04 +0000 (UTC)
Date: Thu, 23 Jan 2025 11:49:04 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Allow default HARDENED_USERCOPY to be set at
 compile time
Message-ID: <ztewg4ohtq7iojoilwcuq2ozczfxv5gi2r3svh3l5n6fv6kvfl@etevudcdw7un>
References: <20250122171925.25472-1-mgorman@techsingularity.net>
 <202501221701.61D4E17@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <202501221701.61D4E17@keescook>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737632945357488593.9138.4954938538875649607@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=67922cb1
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=vcvqyVX0pnVXJpUJokUA:9
	a=PUjeQqilurYA:10
X-Virus-Scanned: ClamAV using ClamSMTP

On Wed, Jan 22, 2025 at 05:02:29PM -0800, Kees Cook wrote:
> On Wed, Jan 22, 2025 at 05:19:21PM +0000, Mel Gorman wrote:
> > on the exact CPU. While the benchmarks are somewhat synthetic, the overhead
> > IO-intensive and network-intensive is easily detectable but the root cause
> > may not be obvious (e.g. 2-14% overhead for netperf TCP_STREAM running
> > over localhost with different ranges depending on the CPU).
> 
> I would be curious to see where this overhead is coming from. That seems
> extraordinarily high, and makes me think there is something more we
> should be fixing. :)
> 

Almost certainly yes, it could be anything really but the results are
consistent. It'll be somewhat tricky to narrow down given that it's
somewhat specific to the CPU. It was outside the scope of the series to
investigate. The primary aim was to provide the option to have hardened
usercopy available, but not surprising from a performance perspective,
via a single kernel binary.

-- 
Mel Gorman
SUSE Labs
