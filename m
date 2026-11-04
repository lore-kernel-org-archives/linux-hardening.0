Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799661;
	b=FNloOW1oi8UApoHO2AstxEem/zOKve6MA2GEPqK44KAUMpSQ+5gyiIGe3/byG/l82/p5
	 hyMgYgpJPWfiL4wgN0+wc8dtGCzYo3lH5gJEcwginfyPGJDXByN2ysppnsHPZRtz9UKG6
	 p84dCXJt0xWRX4qJYzsyf4h8j9h5W8BPaCvx57tE+/05y7YBHYbnj0CKX5Ld+1wI1hyvH
	 DOQXj5JRO4YA9hx9W7ib5RyygiUX8vN2DMkLfG+KNs/E1U3EIjzx8q4G77B/ucaSqHHI/
	 vQmqVV6aFnD0oEqb+glAqs4xwttVtnLpbToZwJbeXRHlH1N1Fvg67O+03dlU6O3uUZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799661;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=P81IHL03zQBoiogTU8xh359b7GRLBvWNln5bYsL7/pk=;
	b=kLo0tmFZluathbIDb3uhR9jgpYLh8XrCcCmtSeSsWiOTTaL0y9pv8xfGzuEH/mH9FfMX
	 ecfbW4q0KSTZHXW1qZiFvoHDwL665DvKaxcT6LrghT3Fx3IFQpxrmtmikYh6MzkLeZHfW
	 Yt1oIQWFipHGQMDSBrVNS1H9qV1rfCEVIJ3zsvhyX1WDosu/65OOuM8QpI0/6WIHfJ1M3
	 8PwZGxPX+pDpbo6bMddGL4Me4Nrhd2I6wurys+q2nBQvcQ8ndzHsd/LGW9cb2QRXm+RTW
	 uaY1bHXEKnQ/a3yp6AGoKYavNQoNB1TxIGpPoJtF4WwCZH1F3jqigARlgAvY2QAvO4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=UZ3E2Onu;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10631606A31B;
	Wed,  4 Nov 2026 13:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10631606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=UZ3E2Onu
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 16A7CA7F86;
	Wed,  4 Nov 2026 13:40:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id D7D1C20010;
	Wed,  4 Nov 2026 13:40:55 +0000 (UTC)
Date: Wed, 4 Nov 2026 08:40:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr
 Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Shuvam
 Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <20261104084054.2dae0ebe@gandalf.local.home>
In-Reply-To: <20261104033110.out.418-kees@kernel.org>
References: <20261104033110.out.418-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: r9hg4jjpeo15d5xnaagkqts5deiecyoo
X-Rspamd-Queue-Id: D7D1C20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/FW9BZLaREI7WKqsf4x4YXZ8T3wBZNAwM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=P81IHL03zQBoiogTU8xh359b7GRLBvWNln5bYsL7/pk=; b=UZ3E2OnumBjP5rBXiqSC8RbwQASWwcI9yazjENzZJyVQnNIHIysW6a0A/uCraumAlk8P5c16wnUzTECnrWN+IP6dPMZxv5lLlKnHGbpu1LGrfpRyTflyYU8atNw8xZ4Ful4uYVCnMAn9t4AIvZGhLVTsnTwmD4d4khpx75NdT4k=
X-HE-Tag: 1793799655-402340
X-HE-Meta: U2FsdGVkX18Mw1zi6lqmlRMCwlPzaJfH+5lNI9ESrsdqOmzUryGAExY+ZDLVSfpxdK6dBBEkppyVwCR4paFzw58qcoX1loy4T9YrqF7PiV7sqam7zXV9KjFUzLdu/dd/MUBzdaVaqP77TvHtDi7Mk4dttKRrGPYE3dqA65bFkFQH8u6gm/pGoT/3Fq7OiDa5VY919sTixST+akU6VooA++rCQivX3xq7HzyrhkETfNzAYEE/BqNLPL6M//5jex0YDb+0jLXQ6pHDYdO9nr8H8Gfog1FEmWLo4/ZJq4KwFvk+hB6sXLkjmlAu82oOnPmP0fExJs91zb8/oDn+bj61LQymK4hQR+gZWKMiSp9RXZUEKElU4NmlkWkXQPanPL3pJaWiUEnT0OsyHrVqTVODPA==

On Tue,  3 Nov 2026 19:31:13 -0800
Kees Cook <kees@kernel.org> wrote:

> When there is no room after the data for a NUL, __seq_buf_terminate()
> writes the NUL over the last byte of the buffer. An overflowed seq_buf
> has already lost data, but one that is exactly full, as seq_buf_putc(),
> seq_buf_putmem(), and seq_buf_commit() can leave it, has not: the NUL
> replaces the last byte written, and the seq_buf still does not report an
> overflow. seq_buf_str(), seq_buf_strlen(), and seq_buf_terminate() all
> go through it, so each of them can silently truncate what was written,
> and seq_buf_pop() then returns the NUL in place of the byte it replaced.
> 
> Mark the seq_buf overflowed in that case with seq_buf_set_overflow().
> Nothing is left between "len" and "size" for it to clear there, and
> seq_buf_used() still counts the lost byte. Data that already ends in a
> NUL is left as is.
> 
> No current caller checks for overflow after terminating a seq_buf that
> can be left exactly full, so none of them behaves differently.
> 
> Add a test that fills a seq_buf exactly and checks that each of the
> three accessors marks it overflowed, that seq_buf_pop() then returns
> -1, and that a seq_buf with room for the NUL is not marked, and another
> that checks the same accessors on data ending in its own NUL. Update the
> existing tests that terminate an exactly full seq_buf to expect it, and
> move the length check in the seq_buf_do_printk() test after the run,
> so that the buffer still reaches seq_buf_do_printk() exactly full.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0, and the new
> tests fail with the fix reverted.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20261016145928.16eddc9a@gandalf.local.home/
> Fixes: f2616c772c768 ("seq_buf: Add seq_buf_terminate() API")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
