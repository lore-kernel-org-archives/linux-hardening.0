Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0894CF48E;
	Fri, 16 Oct 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177799; cv=none; b=nzEbUDbFeamNm40SWTMSUfppwzZMtq6jxiDu/efn7opUVvLel33cpL3pd9YIABn4E9L5Go+JThNJ3YZgmSIoYKCcrzgdM8M1NFLy+YouDT+Eubd2PL43MODRys0ehwhBgnIvdxwo+fHi3H2zjvYXHNIvhKTg5v/ShVPzQuRnIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177799; c=relaxed/simple;
	bh=y/hQ3AYC4dJV/MvJgQu2RPD9fcf8SPJCUDXxigTLiDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIm+gQmUPpssDeVN4kFSKTR9iQ4THgBZoVlVXuk1QIsCq211rFZcp5qcGKLsnat6aFTQpZdkS19frGyp1eGHd8oJ5Ccx0jck7CAA3ZcPl3TF4xKUamOzNOuwRxobggxSKi7v6FQG2CLUbimMdCFfb3ZhyZyT/M9K37a3ROzRKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=5SYJdh9U; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="5SYJdh9U"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D0B61120591;
	Fri, 16 Oct 2026 19:09:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 9FDF320025;
	Fri, 16 Oct 2026 19:09:53 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:09:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow
 <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, Shuvam Pandey
 <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 09/12] seq_buf: Add seq_buf_init_append()
Message-ID: <20261016150952.6cd411ab@gandalf.local.home>
In-Reply-To: <20261005155708.1471260-9-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-9-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ctnsbm6tqwpco3swtkp3xxe5spk1d9z9
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9FDF320025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188WvDMLKABH9CSTRj15ovT9TVVZuW75XM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=fiFKR5Uv0shrDAFREGQwtbu2gRhugzqo5ae4hmcS3DY=; b=5SYJdh9UdRwOZ2agN5JU5ToFatVjavJsWsyzaIe7Kk3EN10b0q2nr/AF4R0S0nxiEJvJhsyCg9Fa1RdqzeFoqrypDG3jCPX13r7enEwzUVOmsIwJ+RD1yLRc3nD8k49gsMIsDfwT9NW2MAz/iFBDChS5YwKsLbCpHmLjDHD8Cj8=
X-HE-Tag: 1792177793-377469
X-HE-Meta: U2FsdGVkX1+lECzkxwBNITOGPUiF7YSwMAqt3PwP9J8lHd8QsI+q32zHdOSy6kyCyLTH1c/3mOXXt5zFwtVXY4H67KsQiU8fn2TO+BbSe4R1NBfBVlbBn2yax7aQoGS97ZHryNXbgEWJP/2ipcfk69FJiwAzbN2aOLD+Mr2uzoC8cicS0DS5tAX3HcOjRFXO9SzcUheUGadffgRJtpXdCLm8ekGF+Xn/xnovjy5cfUp7itV85e/J6IeCwYLQQlMqJjtNyMQK3RnuoupMXIbdMoIs2m2SUMWnfST4ExNtktYwXp2lz5VsFK1gpLSGnTJBkpF1oMZZfDBLsdy3/rRF7ZKyHmAX8WIalXh7tMwoX4Umcx+Z1gMPX4XMw4dwDB04P+bfY+NdgEJIrbuXOdeEBsDqXzbFrXAVrQVWQby6mnO015eSY5n4lXM2m7hGA1FcP0XmZejLS3c=

On Mon,  5 Oct 2026 08:56:59 -0700
Kees Cook <kees@kernel.org> wrote:

> From: Bill Wendling <morbo@google.com>
> 
> Several strlcat() call sites being converted to seq_buf need behavior
> seq_buf doesn't currently provide. The normal seq_buf_init() always
> empties the buffer (sets its "len" to 0) via seq_buf_clear(). Code
> migrating from strlcat(buf, ...), which appends to whatever buf already
> contains, can't use seq_buf_init() without discarding that existing
> content. Add seq_buf_init_append(), which preserves the existing
> contents and positions the seq_buf to append after it. A buffer with
> no NUL within its size starts out overflowed, as strlcat() treats it
> as already truncated. Add KUnit tests for behavior coverage.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0.
> 
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
