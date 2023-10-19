Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F93550A
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5170EC433C8;
	Thu, 19 Oct 2023 21:14:41 +0000 (UTC)
Date: Thu, 19 Oct 2023 17:14:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
 Justin Stitt <justinstitt@google.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>,
 Petr Mladek <pmladek@suse.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 0/1] Put seq_buf on a diet
Message-ID: <20231019171439.1c50a16e@gandalf.local.home>
In-Reply-To: <20231019194514.2115506-1-willy@infradead.org>
References: <20231019194514.2115506-1-willy@infradead.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 20:45:13 +0100
"Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Prompted by the recent mails on ksummit, let's actually try to make this
> work this time.  We need a container for manipulating strings easily,
> and seq_buf is the closest thing we have to it.  The only problem I have
> with it is the readpos that is only useful for the tracing code today.
> So move it from the seq_buf to the tracing code.
> 
> We should go further with this patch series, including using seq_buf
> within vsprintf, but if we can't get over this hurdle first, I'm not
> going to waste my time on this again.
> 
> Matthew Wilcox (Oracle) (1):
>   trace: Move readpos from seq_buf to trace_seq
> 
>  include/linux/seq_buf.h   |  5 +----
>  include/linux/trace_seq.h |  2 ++
>  kernel/trace/trace.c      | 10 +++++-----
>  kernel/trace/trace_seq.c  |  6 +++++-
>  lib/seq_buf.c             | 13 +++++--------
>  5 files changed, 18 insertions(+), 18 deletions(-)
> 

Thanks Matthew, I'll pull this in and add it to my for-next queue (after
testing)

-- Steve
