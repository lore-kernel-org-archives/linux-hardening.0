Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2491EA7A
	for <linux-hardening@vger.kernel.org>; Fri, 17 Nov 2023 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2016DC433C7;
	Fri, 17 Nov 2023 13:33:34 +0000 (UTC)
Date: Fri, 17 Nov 2023 08:33:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, Geliang Tang
 <geliang.tang@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Thomas Gleixner
 <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] samples: Replace strlcpy() with strscpy()
Message-ID: <20231117083331.06f49852@rorschach.local.home>
In-Reply-To: <20231116191510.work.550-kees@kernel.org>
References: <20231116191510.work.550-kees@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 11:15:10 -0800
Kees Cook <keescook@chromium.org> wrote:

> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 1c6b843b8c4e..23f923ccd529 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -305,7 +305,7 @@ TRACE_EVENT(foo_bar,
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->foo, foo, 10);
> +		strscpy(__entry->foo, foo, 10);
>  		__entry->bar	= bar;
>  		memcpy(__get_dynamic_array(list), lst,
>  		       __length_of(lst) * sizeof(int));

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
