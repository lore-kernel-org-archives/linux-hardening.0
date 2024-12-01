Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7BAD2F;
	Sun,  1 Dec 2024 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733021287; cv=none; b=PgQ17+QI6JnOP7Qx9pVXkhKkyYZ7w3fv3SwrJ3kXBQTFtSmZM4tdmpeem19g/bv0KEjG23sXP3SprY2FiSNNvaK3sMC4L6ZjBdkV19YisH91xFi+jKjyRs2L2q3WCqzEiQTfjQbguwA0nmHPRqTHeF1dZhEYNnQc8aH5gJ3Y7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733021287; c=relaxed/simple;
	bh=/VSRMvT6+fhRg3ki/LdQRVg9gMWEYuL4F893ivPkmag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQQq0NID6Op/kzTh6dgqJdQwaXmzxvxgygNM/p/oeDNiJVLNZrdg0P2BnjsTJW9Zr5ksZamT0QJHzC47B/GwvSbn4Gt/vbplcBEN1hSk5yBBSjjx/eh2IvJ6k/QK/oXZdUj1q9EuFaNJaEOMNY63NkvUPr5952flNXhSx6vPpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gm7d2env; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gm7d2env"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=0gTfnan2PRic78M2GErX2vsIFTVHvia6IPklfDcQy5M=; b=gm7d2env4uAWWfbO
	6gItubsi7E1dk/nmBoZldCWED4gqeBOgA9AfYk/cF1Q9in7qijg8HK14UzIMdpT+zsPe75qjt35du
	un6HU+xQfztZjzMJGidcbzHqf1dgpLwjbcOcVNegsn98Mq0NT7FiC2/g/YIbtXXhxptBl489NuhdH
	mZ82/i7Se3b5ODvyYri/9AOBy+bnyI/v7BU65gF/tABPIThe5ft/sKc6M2jV5HcB0zFY6Xw3n1wqi
	uzijmk3Z0kel3QlQRxuW32bHq144GdKd/kTw6DYyrqk1AGml8yeah55kWJNOiVJrE++1hOV7KvHdM
	NIB+yzb/8gv/EdPleQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tHZzx-002gpl-32;
	Sun, 01 Dec 2024 02:47:49 +0000
Date: Sun, 1 Dec 2024 02:47:49 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, kees@kernel.org, andy@kernel.org,
	akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printf: Remove unused 'bprintf'
Message-ID: <Z0vOVRcZQir0cjjo@gallifrey>
References: <20241002173147.210107-1-linux@treblig.org>
 <Zv5SLrKeQIpWnhsS@pathway.suse.cz>
 <20241003111346.0654f1ac@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241003111346.0654f1ac@gandalf.local.home>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 02:47:25 up 206 days, 14:01,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Steven Rostedt (rostedt@goodmis.org) wrote:
> On Thu, 3 Oct 2024 10:13:34 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Wed 2024-10-02 18:31:47, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > bprintf() is unused. Remove it. It was added in the commit 4370aa4aa753
> > > ("vsprintf: add binary printf") but as far as I can see was never used,
> > > unlike the other two functions in that patch.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>  
> > 
> > Looks good to me:
> > 
> > Acked-by: Petr Mladek <pmladek@suse.com>
> > 
> > I assume that Sven is going to take it via the ftrace tree as he
> 
>                Steven ;-)
> 
> > suggested at https://lore.kernel.org/r/20241002104807.42b4b64e@gandalf.local.home
> 
> Yeah, since I'm basically the only user of it, it's best it goes through my
> testing.

Hmm, did you pick this one up?

Dave

> Thanks,
> 
> -- Steve
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
