Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715840;
	b=PYnhTSy4T5CNLXFN8XEF+5AQBof6kFUh8rIpSYL80o7b0WMB5XLCWDUqVMv0BrMEhUG/
	 3/8+B/wpvNlOx40r+4jHzTkd5/cMeIey0GyQ180WPxDJuXCAPZPFM7j0WEmFX4RgX9U09
	 n7zLsJjcnFp/HydjKpy8tM5ofmJm9JysUn3vBGLTK5CHmyklkbUgY0pbB6sEktmGT/K+4
	 RmuE24fWHh7Z9evRpguczmdQssZI30lXO9b81m2dhCR64Hu5ntQ5M1oWJi6DwIznN+YfH
	 89c4kMDZ9AjyGRZAN698F6Sw1cEUSDKhq3KkhLTgiGQKFpxrbYz1Uoxu8zLpAHfyc1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715840;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=axXiTUjtvwMFRrIO/ly38Bs5w5xgTTTJQ7iKGaFvt4c=;
	b=BTo/151nW/swcSj9UV/nR49Oe1pVgl+zRS9r0uHoJI2ZJCUDw4B32+rqi72iBU3PQJ89
	 xICfAVZslAdv5EBmYj0zDQlx2PSpg4LnilS8YFxFDNUEfbAfyZAY1JmvC7ETJ+v35/QAP
	 RMxt1zpo+T17VFfG5kGQ0kuKrzD7097YbL6h7LrquWmjyccsjQ/ofDxsbIG/2/dz5WBan
	 34UX5Sou1qpyoQz0WpfQBobSWakiaHgLQ9qyvupTEyikmtqFwsSNwVqD7c/fA7yp4tw6X
	 AYeTksSKW2VEBm4vqmA0SNiMx6eVSL2zXWngIRDTZ7ASAc1/to3UWSWbgAAGkvPQXXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=NJAieMiG;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314F606A31D;
	Fri, 23 Oct 2026 00:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2314F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=NJAieMiG
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 67EA54034C;
	Fri, 23 Oct 2026 00:37:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id EC75C2002C;
	Fri, 23 Oct 2026 00:37:14 +0000 (UTC)
Date: Thu, 22 Oct 2026 20:37:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr
 Mladek <pmladek@suse.com>, Shuvam Pandey <shuvampandey1@gmail.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <20261022203713.1adce485@fedora>
In-Reply-To: <atp4vVMyX65qYcAt@debian>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-6-kees@kernel.org>
	<20261016145928.16eddc9a@gandalf.local.home>
	<202610221058.C5626C5172@keescook>
	<atpmAQ932J3_8IvJ@debian>
	<20261022155726.7f20c4cb@gandalf.local.home>
	<atptYsHyS6YGtzPV@debian>
	<20261022162000.18aa4162@gandalf.local.home>
	<atpyCU3fDyU95hbY@debian>
	<20261022165336.3100a5be@gandalf.local.home>
	<atp4vVMyX65qYcAt@debian>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Stat-Signature: 4hdp6ykrbqhmh6fh37tmjh3b6cr3fcuy
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: EC75C2002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jZHCAHt0bGbMwk6BQ39qd8dVWDXz4emw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=axXiTUjtvwMFRrIO/ly38Bs5w5xgTTTJQ7iKGaFvt4c=; b=NJAieMiGRemya9h0G6J0k9xdE0tqsZ88GSAS1JsV9P0ETKlN1JapzL2+psbnwxZSzRxVIpqQkoaIosfhnS9twO/gq8RmwDtgWlHqJkUap3Xryvk1KCpHFh9YVegQ3xsJOxqVz4GNUqk0gIM/SXvBcdeAcP5TnKWKDSPYQDTdNQA=
X-HE-Tag: 1792715834-340845
X-HE-Meta: U2FsdGVkX1+QXw1era8vos6X1aEaQNEyg3QofqQx7S0O/Qs7e60GjAIKiF2yl5nJMSiECwu+0BuzPpD5+S5sTXMDy9hDaJNSBSHTSe6bRF0ocypxUPGr0Q3h/KiQBt2DIHxsOCl7qsMPm0rco/dppq80GA72PP9IQY8oegAlZXwzDqf58AL+5trxpMgCx07QFD/5z658BG6+KfBBCJB0u4MmoIKRjJ/D8ijstepXDb5tUGm8t+Wl7/tiqmJGN3kccW185TP6/HWz3I7i6fcZD0Hrq1m8zRGmQ3vQMweWdG3rF+d5e3JqrfLJW6XIV16QtWJW5o/zsM5EUzyne/RlDqnmW4nfnM+q

On Thu, 22 Oct 2026 23:02:36 +0200
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> > 
> > I rather not increase its size. It is embedded in the trace_seq.  
> 
> The size shouldn't change:
> 
> 	alx@debian:~/tmp$ cat seq_buf_size_comparison.c 
> 	#include <stddef.h>
> 	#include <stdio.h>
> 
> 	struct seq_buf {
> 		char    *buffer;
> 		size_t  size;
> 		size_t  len;
> 	};
> 
> 	struct alx_seq_buf {
> 		char  *buffer;
> 		char  *p;
> 		char  *end;
> 	};

OK, I was thinking you were adding another pointer.

> 
> 	int
> 	main(void)
> 	{
> 		printf("%zu\n", sizeof(struct seq_buf));
> 		printf("%zu\n", sizeof(struct alx_seq_buf));
> 	}
> 	alx@debian:~/tmp$ gcc -Wall -Wextra seq_buf_size_comparison.c 
> 	alx@debian:~/tmp$ ./a.out 
> 	24
> 	24
> 
> size_t and pointers should always have the same size, so this doesn't
> change the size.
> 
> Am I missing something?
> 
> 
> Cheers,
> Alex
> 
> > Yes the seq_buf code can be complex, but it's in one location where it can
> > be highly tested and verified. The point of seq_buf is to do the complexity
> > so that other places in the kernel doesn't need to.

We could look into updating it to pointers later, but right now I
rather keep what we have. Let's focus first on the new stuff. It's not
that hard to validate.

-- Steve
