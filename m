Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F094749CA;
	Tue,  1 Sep 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269401; cv=none; b=GN/KwCM/ulC7QE/mqJVFuPU5UTdqSuBXETrbr4S6my8pf6EtKc34XM6zRCllKFPe/pwH97VDx9K/bThlZVNy12YuRigkpJb1Aj+4T8SSNVTEPcDJDFuHJODoDKQ5UN5jZEUa4/vm8WYBIj4QNKD7Bc1Z/f96Bk734E7MEFQ5cH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269401; c=relaxed/simple;
	bh=usUjDosYvvSUEZPW3UYd2xxo/lHyzE5qHlinKDgdaUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rg+YDIDcL9uFtn6tEQ8K4ggVbQHi6nlSxlpg/deukMUdRCZd6XMGbfE8WRBKD02giBSFX+cUqM9vaXOfttZBh3TolMt655A2waLcC+FuWirO3HT9bM1SJo/CNdWCCN820I9kSkQDNj5gl4LZYVTQwkqQDn7jF0a8Trv1AAAxveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=V5iJIVH0; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="V5iJIVH0"
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D2A7C80403;
	Tue,  1 Sep 2026 13:29:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 2C25B20025;
	Tue,  1 Sep 2026 13:29:53 +0000 (UTC)
Date: Tue, 1 Sep 2026 09:30:51 -0400
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
Message-ID: <20260901093051.51d23697@gandalf.local.home>
In-Reply-To: <20260901080142.CMTCw6vE@linutronix.de>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
	<20260821152614.2202196-3-bigeasy@linutronix.de>
	<ao8SeCCG65uwH-Tk@pathway.suse.cz>
	<20260827102411.NsziRXyJ@linutronix.de>
	<20260831133729.p5ylO7O6@linutronix.de>
	<20260831124928.22e163ab@gandalf.local.home>
	<apZ9ea1on8A7o6kk@pathway.suse.cz>
	<20260901080142.CMTCw6vE@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jum7gf11hbcim1eebyd8qqtt97xecbpm
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2C25B20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19P8OiZjvSjTxJbF2y/AZkQEsJDoSOsk4k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=dcB7zO5lZNNyXZ+fOv0aRdNG78sajV/ilKg2jlXvRzg=; b=V5iJIVH0OWToxJTf3x4oAww5E2BQ39Silo2wt7W1TDtoyXQr25M5LsxnQQO9qm1P9Wlo4vyBqZZ0lJht/9SWEWVdUS/BKKr/Inx+LvEI0kbNDlwh3MKqi4fxZ1wKy0O+zrllG2Fwgiid3AncgcVdYyIdhXZLu39myRxA0T+KUmY=
X-HE-Tag: 1788269393-235803
X-HE-Meta: U2FsdGVkX1/3FYWLsjV6G+uwVcd5ovLTgMEUh86EsoKHj9SCx/Lg/RLOuaiz7Vat1p+r5sJ0Bq1jdjPxW6kL0Q7JAovISWeMsXqiaN1HiBEixEKoiNJ96mRiYeH9lKu7ExOy3GcliW3ex6JeycQuUFYu/e+YfkRGChwUN8wCV8dnnFLD5GSk5MH+9LFsn+Z1dUiEbbkKnIEd/AWs2wlc8WI/CQi2w2Yl/K1Oz3MGix1xPPwfryzjPhGk6TesGnVgt3wrF+jfjqFJTUk1xdFYZdN2IzqqLihh9R+RqRMfxRuZrpZoPCFIpkapNajdP3Cj

On Tue, 1 Sep 2026 10:01:42 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> >  [    1.498171]  <TASK>
> >  [    1.498172]  h0000000cb9bc262
> >  [    1.498174]  ? h0000000eb5021dd
> >  [    1.498176]  h0000000ed1a9938
> >  [    1.498178]  </TASK>
> > 
> > But 'h' is not a valid number number so it might confuse parsers as
> > well. And it is not that user friedly either.
> > 
> > So, I still like more Steven's variant with [hash].  
> 
> While it does make sense to add [hash] to make it obvious it breaks
> formatting for some of the %p users where %p is expected to have a fixed
> length depending on 32/64 bit. Here, it is a %pS so adding extra it
> wouldn't break anything but I don't think it should be different between
> %p and %pS assuming we do print the hash instead 'unknown'.

Since the hash value is usually less than a normal pointer length, we could
have it be:

  h:XXXXXX on 32bit and h:XXXXXXXXXXXXXX on 64 bit, where it will not take
  up more than the size expected.

 [    1.498171]  <TASK>
 [    1.498172]  h:000000cb9bc262
 [    1.498174]  ? h:000000eb5021dd
 [    1.498176]  h:000000ed1a9938
 [    1.498178]  </TASK>

-- Steve
