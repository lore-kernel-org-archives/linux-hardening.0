Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E257245EF4D;
	Fri, 16 Oct 2026 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178026; cv=none; b=O/IGiy0wKnlSRFKY9ooyPzTTTy4dMy7epi3lGRkoVP1414JS3dop1xhgZ8ucl85lY5mxpV9gPe6hHgIY2EvvtRFUHqoJ4EYQkERIWYxGqOBT+bxH2qj63o9G3ExPNP57Jf+xaMcbfcy2tcL4BPcM4DkgSzQKcmPgPxjZFkasfLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178026; c=relaxed/simple;
	bh=zwm/QEKqYo+ogql6ZscEM/nW2CLcr0werV481LlFNNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckewZ61g8Ra9NVsrYlekWRqDAOC6wTBxsyyGKS1m/D0AM4ejYP8vt2ltxYb9hc1XNBlZ6/NVMR9flIgD68B/eY2ZiFLTZVLEJWmmKtkzQe2/fIdbCP3GNmJGjoRl0f/W5KCOSrLykxX7YS7wCPTuINMY77LPHgihPN/bGqlsTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=kkGIL1bp; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="kkGIL1bp"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id CAB69120585;
	Fri, 16 Oct 2026 19:13:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 78AC62E;
	Fri, 16 Oct 2026 19:13:40 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:13:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Petr Mladek <pmladek@suse.com>, Randy
 Dunlap <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 12/12] docs: core-api: Document the seq_buf API
Message-ID: <20261016151339.79339dc9@gandalf.local.home>
In-Reply-To: <20261005155708.1471260-12-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-12-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: z7e3ficsbp6gu6r1yoyu94rqxa56npzt
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 78AC62E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18PGHpWT8N1m2wPlqH0k89uYtXhHRXQ8xE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=/iMMTjSKlkO+qTb76qEyDS5V8nAb2S0TVGmoe4hOGI0=; b=kkGIL1bp+K/1lvgyPHFjFIwQTHMTMcujQx+wpTQ0EfZHIBXMpGNC4yi/Lup3zPLhZwUnDxSYG5fx05sho+3sBVhzxB2WYOKdKDerN1L3fKEvcOge9Ei/3A4efnuBp6DXTECbMwUodrWUgu5a4PozzLb8oyB8XJxTGWIg/LYm2z8=
X-HE-Tag: 1792178020-794876
X-HE-Meta: U2FsdGVkX1+x00LDw52Wlg8pFsmZ9wMCPnZfM4z9uxdMSwdHSHby5RMsBT4eRdaZdO8+qoUETuvUSK1cA158P1auMmdv1YglFia0GckAHEtaH60+0aLfEtdZsvb5n1sBygURYC+k/2FFzYgwbr3ktGASb4KqQsEdv/u/YJyg+dkHEkW5nRZtTl/DZiwWqGT3QfcuvAtmJrI+ze4Dz88y0mtuiMPw7bcXsgxWRXqgh2GPontVr4GMX832UqPWaHSSj+GOiYyulJ1CfmFraugSfpyFqBDXi50CmlklgWmQDaygn2X+EqkIPrDlXGR3sOdb3KNW70EyWDuIwtZfDZhA5lv7O/3eCVT/4UsHDoYjsd+03feGYEBhKV8GA5ha7gmFO9P1AJMHgr/U4R20IEZFrZd/aE8yZ5yxeRh+SGitANqF6BUA0/M9RpQgp+AfQ8gj6wrLWinyqx7eT2+lTGsFRsfgAyrNOyQcv4YlAkmF3ds=

On Mon,  5 Oct 2026 08:57:02 -0700
Kees Cook <kees@kernel.org> wrote:

> The kernel-doc in include/linux/seq_buf.h and lib/seq_buf.c documents
> the seq_buf interface, but no .rst file pulls either of them in, so none
> of it reaches the generated documentation.
> 
> Add the missing kernel-doc for seq_buf_clear() and seq_buf_init(), and a
> Sequence Buffers section to the kernel API documentation. The static
> internal helper seq_buf_can_fit() is left out. Additionally fix
> seq_buf_hex_dump() indentation to avoid the reported Sphinx error:
> 
>   ERROR: Unexpected indentation.
>   WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Verified with "make SPHINXDIRS=core-api htmldocs", which rendered
> happily into core-api/kernel-api.html.
> 
> Assisted-by: LLM
> Co-developed-by: Bill Wendling <morbo@google.com>
> Signed-off-by: Bill Wendling <morbo@google.com>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

