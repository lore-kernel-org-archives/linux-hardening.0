Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93392BE656;
	Thu, 17 Jul 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755397; cv=none; b=JKlcC9RinG8Vrk6Qb4vQlDIlfyLShoyNqersUoEnG1B7GlinLWYaMLXPIlTFMejaefT9H+aeoKoD1JFY1gruf69bjl4bqsg5GZwFsVuwbdadCgRwPdfQzqYhY4Wi8oCwt0G2Wi6R8G5ncIDJQ2F/rMnMsc5rHT+mCW0+/kDt6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755397; c=relaxed/simple;
	bh=48kSKcB2hnSyDzNIJj0i5QAlMxNjsdNNvCXuAgKehwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIvmD4p/WhtjmseKrq7bxMdXPqBCbdnOvE2de8+MGpV1NvAL51zVGbkfD9U5cDtFShmb/JWbCXIohYgyi5dWVVvxGfEBK0VjX00u0DISBDBdgnv7eHlxbxl2IUp7xUzAud8YeNkm5D38NSsS5CM45oEaSkyu+Csq1WOvTsgag6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id EA74A1DAD69;
	Thu, 17 Jul 2025 12:29:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 8CFD720027;
	Thu, 17 Jul 2025 12:29:51 +0000 (UTC)
Date: Thu, 17 Jul 2025 08:30:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Tamir
 Duberstein <tamird@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Petr Mladek
 <pmladek@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Luis
 Chamberlain <mcgrof@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Introduce KUnit tests
Message-ID: <20250717083012.7fea6aba@gandalf.local.home>
In-Reply-To: <20250717085156.work.363-kees@kernel.org>
References: <20250717085156.work.363-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7xkbp994kihwtej9kyy8bjwoyaffxjhh
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8CFD720027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19R7HG1UvXViNKqeoLNnHqLt9FvIKKsSUU=
X-HE-Tag: 1752755391-728039
X-HE-Meta: U2FsdGVkX18SKojBekyEXxUY3SLzqhD9e4wgcxFvNSqpZxiMGZjZJuUTX/1dyr/8Vc34UYYp1unSs1L3Vf17SUpIW2FTqkQzGSrkwnQckMXZ9dCNVS6TWOgw0oex9KtybEWKirvkUlw7LuvLFzjHQrA7mD+NubhtvLrDYJNWFRb2oR+2zbjJpJvNzvL0L4Mo5AviwtjtG+AjgMYB1qFkf6KWw5iFkzWrO7Z4aQM5rc1eN6e+lxdSyqA+JqxobbIg1N0d9syDIwWgIDMZmL9M/3si3y7bQB8hNTEHj8BzWLlTNKXfqEm2Fl8e8FGY3UP4gSQCDYg5CGSBdrSfZITMjpJ9/R/CPGDBHWj6Jq+Qn29W/cjNYgo0hg==

On Thu, 17 Jul 2025 01:52:12 -0700
Kees Cook <kees@kernel.org> wrote:

> I used an LLM to produce this; it did pretty well, but I had to help it
> get the Kconfig and make targets in the right places, and I tweaked some
> of the edge cases and added a bit more (perhaps redundant) state checking.

This is actually something I think LLMs are good for.

-- Steve
