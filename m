Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FC49BB46;
	Fri, 16 Oct 2026 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175377; cv=none; b=Kt59jicQO98y+VHYMsFQ46JhIIOWGbHo8vv4xUe0vBIXbq+n1faWN/ZqnxazS2FPYQSQ9cVsnnqzNklyc7VKMx0O/MjYnkJ2bpVdvutm8hwL5qQ3/nnf123g83+6/yP1mLl3/dN1KLEp2mPxe081gBM4rcC4DSe5kq3I7sjkgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175377; c=relaxed/simple;
	bh=OvY9JfJXJx7ysLM4KxE3BCQ2+Di681auu9mqKTWt088=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdL0d0FH1l6jOiQ8qIN8cZE9zyQexVNLzjCzIm/kuGDTGK7f1Gm8ztQbkNZ2IV2Qp2eReMa2zB644vfin58rDBdQCsg3vgW3lr20zzGGQexC1ogkZAlKPYGKxY1WPWDhWi2BCFKe3COlG2wNYW+z9roQ/EnvULQnR0KfB40cf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=H+nElxXh; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="H+nElxXh"
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 0B4FE12056B;
	Fri, 16 Oct 2026 18:29:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id D2A5E20028;
	Fri, 16 Oct 2026 18:29:30 +0000 (UTC)
Date: Fri, 16 Oct 2026 14:29:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow
 <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, Shuvam Pandey
 <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 04/12] seq_buf: Copy what fits when seq_buf_puts()
 and seq_buf_putmem() overflow
Message-ID: <20261016142929.6a3a4647@gandalf.local.home>
In-Reply-To: <20261005155708.1471260-4-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-4-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D2A5E20028
X-Stat-Signature: bzd53r3r7duxkhzbtqgsbhpqd11i1ogc
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX184ps7NG8ivR2c1viQKuWd3Lp/Y+83dFnU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=lA2AabQv1jbCO9ERORra9sGWXRL+3DyMN9wR+UnfGZw=; b=H+nElxXhe967175ev4GoUuAZOZT2yBlR5KtWgyKutOapEnGvR/wADOafd2NQMuBZYnFyYKxPoIgQVuaLX1vtLQP8yACJ5OJcCi2dIN3gjNQdyqffG+pFGAFX1oGfh8KlTeKfYH35gc+LARXI+9Ji0KXlvJ1VU9lQpeLcM6BnpG8=
X-HE-Tag: 1792175370-234300
X-HE-Meta: U2FsdGVkX199YTStJiheJpKk4BJg8G0rgiujZ7sHrc/+9ilIRvjkFxJ4TGnbIAeCdFeVb7Cph37GtyHpSVsSbhCCMnM7ZkcFzLPFv+1OKv75V3jufpaKFyXVsGNE0EJonspRjpYebbtdccyuEsMSyK3MIAoYMPz8pHT0W553ac4TEumY24IcG9QlVPV+uHulzOcWSgbcsf0cIoWESMxguv8AUtfkZcXDcCX1+wjZnAI8syK8qT8/7FSVkOtw0WaqWfKrt+fqB0U+/k6nJFeMVNclYAuAExuM7lGBt9n+07vHp2Z2RYd2FN12olUcOjmCQwxGr58WbPN6PFXm4GjorUBQcQm/sDzsGkUh7nhe4KawZqYo9z1eZwGC+4fVGju/ahA3kHomJa66S2alFwCivn/BLzIWZB9gZdVnuIf2lvM=

On Mon,  5 Oct 2026 08:56:54 -0700
Kees Cook <kees@kernel.org> wrote:

> When seq_buf_puts() or seq_buf_putmem() is given more than fits, it
> copies nothing and only marks the seq_buf as overflowed. If seq_buf_str()
> is used, it will terminate the buffer in its last byte, so every byte
> between the end of the data and the end of the buffer becomes part of
> the string, though the seq_buf never wrote them.
> 
> seq_buf_printf() does not have this problem, because vsnprintf() writes
> as much of the output as fits, followed by a NUL. Repeat this behavior
> in seq_buf_puts(), using strscpy(), and in seq_buf_putmem(), which also
> covers seq_buf_putmem_hex(). seq_buf_putc() needs no change, as it can
> only overflow when the buffer is already full.
> 
> Each writer now records the buffer as full once it has copied what fits,
> so that what it wrote can be told apart from bytes nothing touched.
> 
> Of the callers that check the return value or test for overflow
> afterward, only lpfc_rx_monitor_report() relied on a string that did not
> fit being left out, and the previous patch has it drop such a record
> itself. The others treat overflow as an error or report it. The callers
> that ignore overflow use whatever the buffer holds, which now ends with
> the part of the string that fit.
> 
> Update seq_buf_putmem_hex_overflow_test, which expected a hex group that
> did not fit whole to be left out entirely, and add tests that overflow
> seq_buf_puts(), seq_buf_putmem() and seq_buf_putmem_hex() with stale
> bytes in the buffer.
> 
> The three partial-overflow tests check the buffer itself rather than
> seq_buf_str(). Neither writer leaves the last byte of the buffer alone:
> seq_buf_putmem() copies raw bytes and writes no NUL, and seq_buf_puts()
> relies on strscpy() to write one. That byte is exactly where
> seq_buf_str() writes its terminator, so asserting only on the string
> would pass whether the copy stopped a byte early or dropped the NUL
> entirely.
> 
> seq_buf_putmem() was not exported, so the test failed to link as a
> module. Export it.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0, and the
> test builds as a module (CONFIG_SEQ_BUF_KUNIT_TEST=m).
> 
> Assisted-by: LLM
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
