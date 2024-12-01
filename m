Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49E2D638;
	Sun,  1 Dec 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733054298; cv=none; b=E6cGwBthdSSUpSexJnxaPb8lmLgFXIEdfClq/HM6lUcfa9SFaqSmv0a1hY+WEHL98IaMNpUJRjX0ahb/Eodzz3MgN2ntJd0BAEPcbKZUfLChHlVDppPFVkc1lYOFMxgTmOkPF002aEOPOZpzoM1MHLywc1oVtNpQGLd1O0afD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733054298; c=relaxed/simple;
	bh=ptqwHAfCvmbNQG4Rvgv67QkQhCWc7uN0tNgPHMsg2PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHB1Borv2DVBuKinDDsMSWOHnvjdY1snJZUtxh+tKo1uzOPbLWKOFK6i/MabD3DShopiRaBVmzmUrQd/rVR4tAnjYc1ELbuBEc0ycav9WCfV3yQ0YiEiJwTowtyhpncpK1iJ6BiAf97NArTkAEQZH87X3h+FxcI9MnTw4f8y7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Iox82dyu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Iox82dyu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=cqcR/KUWGqQpyf+QG9LZwc5OuV4mYTVRjEADhHm6mas=; b=Iox82dyu0t9vxfBG
	JVTOMUlC5e6kFxaJ3fqWhE2dKyAXvKPTwmCMn/JosjUnpXjX8eJxTWSfnqf2j0M7J++tWRsS1hoeJ
	/2a5mDFfwLRW7Ur2d6QFqjMqqHZ7cfaVUKMEj1y/Abzx07vZIz1igP6iGfPj6HRVEAfJ8D1ceGIBU
	8Et7BClFN0SJfMoWoTzeUAiiN7SWOsMoxjX+86Wa9R7Vh9gJOfZugccKZ1Y5J2k/sj6xm93t6prLA
	D2UDuIJJYb++TCahPwCulpaIBw+sqcmByXCRdMsKiyu5N11IbYnN+FyBvOIkCFrQhM3FyQcg1XBsy
	1ZIQjjKhljX4cmnoKA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tHiaX-002hrS-21;
	Sun, 01 Dec 2024 11:58:09 +0000
Date: Sun, 1 Dec 2024 11:58:09 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, kees@kernel.org, andy@kernel.org,
	akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printf: Remove unused 'bprintf'
Message-ID: <Z0xPUWMps0BzAQKe@gallifrey>
References: <20241002173147.210107-1-linux@treblig.org>
 <Zv5SLrKeQIpWnhsS@pathway.suse.cz>
 <20241003111346.0654f1ac@gandalf.local.home>
 <Z0vOVRcZQir0cjjo@gallifrey>
 <20241130223936.136b2f1c@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241130223936.136b2f1c@rorschach.local.home>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:57:00 up 206 days, 23:11,  1 user,  load average: 0.04, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Steven Rostedt (rostedt@goodmis.org) wrote:
> On Sun, 1 Dec 2024 02:47:49 +0000
> "Dr. David Alan Gilbert" <linux@treblig.org> wrote:
> 
> > > > suggested at https://lore.kernel.org/r/20241002104807.42b4b64e@gandalf.local.home  
> > > 
> > > Yeah, since I'm basically the only user of it, it's best it goes through my
> > > testing.  
> > 
> > Hmm, did you pick this one up?
> 
> Sorry, it wasn't in my patchwork and was missed.

No problem.

> I can add it and Linus
> may even take it after -rc1. Or I'll have it in iinux-next for the next
> merge window.

Please do; no rush.

Dave

> -- Steve
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
