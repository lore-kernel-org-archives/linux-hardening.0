Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C937DEBF;
	Mon, 31 Aug 2026 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194926; cv=none; b=CQx09CUIxNIds3zTWGMR4iHsBys3hjo0WyOam20PjcDgPFVKM6XoJSNbIP6dFWiqRxykgFBjwDwPCyrTL4SuQg8fhM8kV0tHBBGxqDs5DvR60xN8zwRFRDez9b7CypuVI5gL0gip1euTEqjk2UcdrgBzWWL05r4qAFusc4/PV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194926; c=relaxed/simple;
	bh=lRUd4QhEQ+Tj2B1hEFCQEBwSYlblCpzjx8QTcT/F/BA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixPe0FKt/AyyZXawC8X8gKC/KXydfDEbGD5jqig5u1nMY/CP7BjfYs4I8cAjAOUsDQXLpng0wgHD23g9ebxQzPDeIOjepusWPG4ySvStIwq8l266YxF2lU9pkd4PmKcEdc9WTwL1rM3RyOB54FkTopVPNy4kJsQzL5bVpmZZO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=fjkoNEou; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="fjkoNEou"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9EB131201B5;
	Mon, 31 Aug 2026 16:48:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 1231480013;
	Mon, 31 Aug 2026 16:48:32 +0000 (UTC)
Date: Mon, 31 Aug 2026 12:49:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook
 <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Tycho Andersen <tycho@tycho.pizza>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] kallsyms: Document why unresolved symbols are
 revealed
Message-ID: <20260831124928.22e163ab@gandalf.local.home>
In-Reply-To: <20260831133729.p5ylO7O6@linutronix.de>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
	<20260821152614.2202196-3-bigeasy@linutronix.de>
	<ao8SeCCG65uwH-Tk@pathway.suse.cz>
	<20260827102411.NsziRXyJ@linutronix.de>
	<20260831133729.p5ylO7O6@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1231480013
X-Stat-Signature: ituq6i7baidazb4su8x6ado1funz1tzm
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ZqRGqxs7puIId+Ef8aZBJDsOIRf12WwY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=WsljotfB7onrjzTjyEtxNzvepuY6gZ4jRtvpx8W7cqM=; b=fjkoNEouMaMDTWCOK4aay+7yuGukaFP9gZHNq15hUjvwkTTTV2X/dwfVEYBYqmxjMUJjcmoT7kqaLahlmYGx9AUehEfUmgDm0XjTxOFSIl2DAS5nKIXVDP94i6nYxDuJcBclYJuDn8a65/0YFZ5OpkJTszwxwC5852K3FU13uL4=
X-HE-Tag: 1788194911-300693
X-HE-Meta: U2FsdGVkX189353ttIQiKGJiTablLs8NIEZkRSyuoaBHovZqSJD/mYcHZe5Gqwy92TuejBV5506vJR6qnmKVnd4YH7QxNQ7uomvA7jlDotKXva6BROYEAiDJzr40JsOCXmRH5mGmZc4ND+YxMRqCFcF3ntInynf3eEyBHS8Chnv4pqSS1th/HqYeHoz9MKqqG1JNsX+LFfX1Yf1efxY6vtDMFCId5ux5aKeLL0/STg87iR90S6li8Fsix9XFff+GhcCp7Tf5WZ/5k38tX49YPL+8x0ETsBHGpGKAi3u5DbOThdVEzZQcS2Ub7X2yQ2UvKmE0AMbtEF7W0xEcU+yV+NTy//9s9HW/

On Mon, 31 Aug 2026 15:37:29 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Could someone yell here, please? I convinced myself that hiding
> unresolved pointers is the good thing to do here since a "wrong" pointer
> would be seen in backtrace anyway.
> 
> Thread starts at
> 	https://lore.kernel.org/all/20260821152614.2202196-1-bigeasy@linutronix.de/

I wonder if we should just tagged hash values as such:

| [    1.498171]  <TASK>
| [    1.498172]  00000000cb9bc262 [hash]
| [    1.498174]  ? 00000000eb5021dd [hash]
| [    1.498176]  00000000ed1a9938 [hash]
| [    1.498178]  </TASK>

So that people will know that the value is just some random hash value and
not a real address.

Although rather useless in call stacks, I like hash values because the same
address will show up the same.

Having '[unknown]' may also be confusing because it doesn't really say
"why" it was unknown. But having a number goes back to what it always did.
Hashing it with a "[hash]" marker will also let people know the value was
hashed.

-- Steve
