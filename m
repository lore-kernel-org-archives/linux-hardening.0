Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475874766AD;
	Thu, 20 Aug 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235870; cv=none; b=EFaQtnmihBX5WVA/IgGZQJ5j1TKCRHI3t6es9tyR2ub0Ut/1eERwh9Kh4/jz255eprVbk44lLqY/eMoEkDh4mrd2K6uvpO1S42+sEZ6weurD+YbkMwo0YNJFU2zk8sEtepQR1HtjA7MxQ/ZVC9jIl77OMZ6RcH/k+NPPntgRobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235870; c=relaxed/simple;
	bh=0TN9jm9UUcQJVGCW+C+vo4BGk/h69y1tVZd7BBQI+N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNKRWtBHlx7G6Vzu0duFzBtywCoU769RGYyPC0SGaTsIYk/vY/XlnsQCHg4V8DeVuABW3m3GiEDrK/j+m5hlUg9kzBZed6oiRtXZSdOF90ITTSimMQz5hm83NAK3FndvccuWZbyIpZPgwV5xutKyhDIzVFRNL0/LoqKVjywNJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2V76juf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Flr1VfUh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2V76juf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Flr1VfUh"
Date: Thu, 20 Aug 2026 16:24:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787235867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5MRmzU1C74sqHw8svkd83BiWXWl7wBc0d5DXrGeStUk=;
	b=s2V76jufrihVkXEfXI1xVlPv6tdWpzR/qN1JOlSrnl+PzUTNa9H97TCciaplIq4kVyJLfT
	Z3h3+QjnEiH+kgEHIq4bp9u3atsM0sQkYVLRixSw0NHX9LmpsuY5gV1qAqxn3LUVo9yQ3I
	MlYbVql74KUc7hTQjMI3HMg9ifzUvtulGevStbO+JVyokMXdzrOUV4CH7kL3QeZhyYEYop
	PdqSohxaFyc/x09uvIoMZVij2GQM+v+GJbLG1R6d/dfMLH+kSu0oZcX8IUvIBL5UmXF4sI
	59KDtlD9W+pRJX8X/44h8lTlsXLyrZoyIqo7bk63Nmeq0lYzwMqqV3/htlCXeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787235867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5MRmzU1C74sqHw8svkd83BiWXWl7wBc0d5DXrGeStUk=;
	b=Flr1VfUhqN7frnUQpPSDKr3hlZcGCXmB92M9+y4oWEwelLkenCq1bOdviqx1V0FdAjXH+6
	p11ffakEnlBIsRCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 1/2] vsprintf: Don't leak pointers for %ps without
 KALLSYMS enabled
Message-ID: <20260820142426.Q3y-RHVx@linutronix.de>
References: <20260814144854.746840-1-bigeasy@linutronix.de>
 <20260814144854.746840-2-bigeasy@linutronix.de>
 <aoAqG0kKxvBbed0M@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoAqG0kKxvBbed0M@ashevche-desk.local>

On 2026-08-15 11:58:03 [+0300], Andy Shevchenko wrote:
> On Fri, Aug 14, 2026 at 04:48:53PM +0200, Sebastian Andrzej Siewior wrote:
> > The "%ps" format modifier prints the name of the symbol which is more
> > valuable in terms of debugging and does not leak the actual pointer.
> > 
> > Without KALLSYMS it will leak the pointer which is not intended. The
> > default policy for pointers is to print a hashed value and not to leak
> > the actual pointer.
> > 
> > Print "(unknown)" for any symbol resolution witout KALLSYMS enabled.
> 
> Hmm... I would expect some test cases to be added/modified.

No bot complained so far, so maybe not ;)

Sebastian
