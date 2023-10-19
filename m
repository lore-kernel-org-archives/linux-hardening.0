Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357542909;
	Thu, 19 Oct 2023 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E260AC433C8;
	Thu, 19 Oct 2023 22:09:05 +0000 (UTC)
Date: Thu, 19 Oct 2023 18:09:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 oe-kbuild-all@lists.linux.dev, Kees Cook <keescook@chromium.org>, Christoph
 Hellwig <hch@lst.de>, Justin Stitt <justinstitt@google.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Kent
 Overstreet <kmo@daterainc.com>, Petr Mladek <pmladek@suse.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 1/1] trace: Move readpos from seq_buf to trace_seq
Message-ID: <20231019180904.70e623f1@gandalf.local.home>
In-Reply-To: <202310200523.ggyHvT6w-lkp@intel.com>
References: <20231019194514.2115506-2-willy@infradead.org>
	<202310200523.ggyHvT6w-lkp@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 05:59:36 +0800
kernel test robot <lkp@intel.com> wrote:

> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  323) /**
> 9dbbc3b9d09d6d lib/seq_buf.c          Zhen Lei                 2021-07-07  324   * seq_buf_to_user - copy the sequence buffer to user space
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  325)  * @s: seq_buf descriptor
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  326)  * @ubuf: The userspace memory location to copy to
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  327)  * @cnt: The amount to copy

When you resend, I guess you should add the @start as well.

-- Steve

> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  328)  *
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  329)  * Copies the sequence buffer into the userspace memory pointed to
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  330)  * by @ubuf. It starts from the last read position (@s->readpos)
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  331)  * and writes up to @cnt characters or till it reaches the end of
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  332)  * the content in the buffer (@s->len), which ever comes first.
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  333)  *
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  334)  * On success, it returns a positive number of the number of bytes
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  335)  * it copied.
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  336)  *
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  337)  * On failure it returns -EBUSY if all of the content in the
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  338)  * sequence has been already read, which includes nothing in the
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  339)  * sequence (@s->len == @s->readpos).
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  340)  *
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  341)  * Returns -EFAULT if the copy to userspace fails.
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  342)  */
> 9377093a882be0 lib/seq_buf.c          Matthew Wilcox (Oracle   2023-10-19  343) int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25 @344) {
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  345) 	int len;
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  346) 	int ret;
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  347) 
