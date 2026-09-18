Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5724A2058
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717565; cv=none; b=KsPr61qFJj0I0rkw16BeIQzDGOscQsR0/BGpSkav6QHEHc2JilNLnuTiOzUSIRaChRCVZGqdk/ZwQiLCf353OhEyFZvC1xGQNhtZQFBAEiQHlcpHtyeczgqxUXsUEB47Jes8gcAD4gXgYVTJ0OsDFerGhHDkJb18A9/6pgX4L1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717565; c=relaxed/simple;
	bh=azfPEbHIuZ5j4CaVju4U0DVdpte8n8WSl9O3JDhdvQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oH4ojYfiy+pQFL3JvR+ELywv5PHMJnhVOYHu0FvoDSwsxCM/ZVIW5TGom+1sB4/IUmPsG1uw8BaDSFN557w8HzpnXbiz8LDqRmEgPqjcB7HmMkhOT/+Bhn8rQOeAMG8qHF3C0reIOELbqCs/QZEhU0BkxFr2dU2uGNqbZKA3SFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=DmOOotyC; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="DmOOotyC"
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 55FB31605AE;
	Fri, 18 Sep 2026 07:45:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 3764620027;
	Fri, 18 Sep 2026 07:45:50 +0000 (UTC)
Date: Fri, 18 Sep 2026 03:45:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bill Wendling
 <morbo@google.com>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/7] seq_buf: Add seq_buf_strlen()
Message-ID: <20260918034547.659616ca@fedora>
In-Reply-To: <202609171419.F929921@keescook>
References: <20260917002312.i.923-kees@kernel.org>
	<aqviXSO0qnCoioWG@ashevche-desk.local>
	<202609171419.F929921@keescook>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gojfztypddqaonr9tzchyxajyz49mhdx
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3764620027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19miZ1PUQRUBkTnQUd0JG2sXBQKZvNbqfk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=azfPEbHIuZ5j4CaVju4U0DVdpte8n8WSl9O3JDhdvQM=; b=DmOOotyCbvEbltb0HOWx+8JP+XeSCbiuU8GVctNBLX2qw4RWTxZcmSeQGgFKnCkRaq3Atfa0zoWzWsXSQm8PLzDWtn2p9qig8paiMxl/LgxihN76M33NXjuSBGpCvGhoBYy8ZCaYs/5wn1J+hyWV9gDlVfTepW4iLjS8Nd5ERTE=
X-HE-Tag: 1789717550-154998
X-HE-Meta: U2FsdGVkX1/xg/+vy3pR1J0o77ztPIl/E1GZlnO0lrqEE6fEsM7Thm7uBZ2OHo7JAbIzNzOj5PJgFvwlHN0BNqXmbvPn1tf0drW9CZjqGG6y7Xu5KLWrxBOEpLSjZiQFJp6+802qF7FgQJh/4fQNOvrFU6t7PRi7jjBXiR8XaGzeQKu+gRttzMCYs2hVGsFo/m+5qqh84xliDzpiipsp9zXBV52apzbbfDHhgXhTVwO2pkFFXe3odOV7quc6HoI8yVzJzRW+9nDE46KsmJw2a4S92WYUx1WDw7F7w+QaIxRlkZYNlmp2XmA/90pfuwLVyfe6tGHQIrOw/5OIEa+nAZUmdgQs1KO1

On Thu, 17 Sep 2026 14:21:34 -0700
Kees Cook <kees@kernel.org> wrote:

> Thanks! I'm going to spin a v2 with Bill's seq_buf_init_append()[1] (though
> I think I want to call it seq_buf_init_existing()? I'm open to ideas
> here...)

After I finish my slides for Kernel Recipes, I'll take a look at all
this. Probably over the weekend.

-- Steve
