Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AA360EC4;
	Wed, 30 Sep 2026 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735474; cv=none; b=VvMkcKSxt4eBl3Ky5NaT7855hMcxeZm+/DIVCoWILKXozncuU8swfv9lUItBs27zd31Fk8qd/aGffXb2ezGvP5OBCdeU1HWryxeJbwdGOz1x829hADnbWtzfvuE5f0G2MGG3bgSKJllGLwc64TNvGYV5Tp3OAGJNh80jIdgBaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735474; c=relaxed/simple;
	bh=H62I6KIpA9U7Fbpfh2yGjSH0KVZfr3UuAurxLtxZBNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIiarAE5LaPYUjsV4bDO5jJj6Ob9vGZH4QHSF97uR+KYlD9wb+IUWhRoOUom6dIzdYWszaBVjJFOqT1noH+3sw6+yZpIIupThDpgjqq7KzA0OFFuIQ1Crjbc4YP6dsu1Y25Q1a0r/1iZNtI7dOB/QCcY96RpytBz6XZjOFFXP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5r/QPYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5r/QPYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB13A1F000FF;
	Wed, 30 Sep 2026 02:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735472;
	bh=QdtB6uKc1phMOQl8bCpWuOQTqG0j67fSURyvwX2rcWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X5r/QPYK+ewhk/4T2BASazotMYOuTjf28SzBSkUelY4zP3ENfPzyvR0bGBEfcPNs8
	 roItMhREQAQ15blUM7rTyRm6PhPuwP1+mkDs5oZIingTihME1L4jIEZHqSdywY7q9V
	 TCYaO3LDsh6v9pQRj1OeaULbTvQeDxbgg5bdIleAQHHSvqfdepBf0cAiTMK1mlQEXG
	 QUf9cGogJZj209sGhln47/Z33lZLF5TncUHTQKaK9q6xTNL6fCF8Zfc9Ny9SI1v8qc
	 48/1EJG4TnLabycaIaGdXaPrL56zGpdyYQLm3PLpYRujEEHjTDc26JRyhA1XOUdPBR
	 j5ogt5ULgQqRw==
Date: Tue, 29 Sep 2026 19:31:12 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bill Wendling <morbo@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>, nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 5/9] seq_buf: Add seq_buf_strlen()
Message-ID: <202609291929.EF68AA59@keescook>
References: <20260919002658.stay.929-kees@kernel.org>
 <20260919002714.4060307-5-kees@kernel.org>
 <20260921054647.3895bbb8@fedora>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921054647.3895bbb8@fedora>

On Mon, Sep 21, 2026 at 05:46:47AM -0400, Steven Rostedt wrote:
> That is, make this a separate patch to introduce a
> "seq_buf_terminate()" function as there's several places in the kernel
> that could replace seq_buf_str() with it.

My first reaction was that this would be redundant, since both
seq_buf_str() and seq_buf_strlen() terminate as a side effect and either
can be called for that alone. Then I went looking for the call sites
you meant, and yeah, it's pretty clear it's needed. Otherwise we're
depending on a side-effect and throwing away a return value:

        /* Terminate synthetic_name with a NUL. */
        seq_buf_str(&s);

And various other examples...

  kernel/trace/trace_events_hist.c:2992
  kernel/trace/trace_events_hist.c:3110
  kernel/trace/trace_events.c:4909
  kernel/trace/trace_events.c:4938
  kernel/bpf/diagnostics.c:354
  kernel/bpf/diagnostics.c:634
  kernel/bpf/diagnostics.c:638

I'll add it for v3.

-Kees

-- 
Kees Cook
