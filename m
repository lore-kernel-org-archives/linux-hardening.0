Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8137C81
	for <linux-hardening@vger.kernel.org>; Fri, 27 Oct 2023 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G9PlaRf1"
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D1BC2
	for <linux-hardening@vger.kernel.org>; Fri, 27 Oct 2023 08:50:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1636715b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Oct 2023 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698421846; x=1699026646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XAYQa3ufeYpImNNDp7qPpU7hHfY982hDiKyd9DINVw=;
        b=G9PlaRf190e9ZoCeBEdFIcQvKCnRCcxb3iXxMOzH7hNkn6yW6sDMMuraO/1+2BP8Cd
         nv54el58uu6RQ0M4gJNHUKP2zUAFtTA1+HhTRsbN6Ok1TbuQDfgaWlhlQCtLwlpKjWqs
         ByTR4qOuW5J5lFsZIxElNvRqwsy2ti76Z7avQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421846; x=1699026646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XAYQa3ufeYpImNNDp7qPpU7hHfY982hDiKyd9DINVw=;
        b=vBw41HbwQ/gnxUlY407U1R/XjONnFLiVCi1HsyW0rEcnDoTvZWnwg8Zv9tDAM8NUV0
         pgBOtczXbWL/2Z1LDHM3jQtv6jQRLMctEj2eL2htzS6aW+ow5gpS5B9nCfxukUFZIR7d
         YimrdCktDYHl2/cTUfWqblr2Rywjlxrpz83s6dgjPbzJAfaq20BkMyGb49uhNl8z0eZI
         M81Vt8RqL1vNkRAa+449OopWGI0xX0zaDCJA4lsEwdorMqJEKZu5+rvCaiaIloscvqC6
         M+7gq5Ny5zq+THmiNO5jWln1MR0NDvJ7+4wia+466l6RsTJ6RoTODt0sRD8dYh1rT+cN
         BDhQ==
X-Gm-Message-State: AOJu0Yxjn+Qo457y4vcSphaghAnFce8gZuxGGAv3D6xI2cbOIpYl1VKC
	BHL6KXfTAnk+lCSIRNq7eji5AQ==
X-Google-Smtp-Source: AGHT+IHLDmn+AjLaF61rtsmuDfAYVnkIvtlWqCwVQhYl6dmEc/RCPXxVQIOdEbbpEEe95zK+/gUeVw==
X-Received: by 2002:a05:6a00:28c9:b0:6b3:80f8:7e91 with SMTP id ci9-20020a056a0028c900b006b380f87e91mr6843699pfb.9.1698421846306;
        Fri, 27 Oct 2023 08:50:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h15-20020a63384f000000b0056c2f1a2f6bsm1249776pgn.41.2023.10.27.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:50:45 -0700 (PDT)
Date: Fri, 27 Oct 2023 08:50:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Justin Stitt <justinstitt@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Yun Zhou <yun.zhou@windriver.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	linux-trace-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
Message-ID: <202310270849.14B83B56D@keescook>
References: <20231026194033.it.702-kees@kernel.org>
 <20231027045451.GA7838@lst.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027045451.GA7838@lst.de>

On Fri, Oct 27, 2023 at 06:54:51AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 26, 2023 at 12:40:37PM -0700, Kees Cook wrote:
> > Solve two ergonomic issues with struct seq_buf;
> > 
> > 1) Too much boilerplate is required to initialize:
> > 
> > 	struct seq_buf s;
> > 	char buf[32];
> > 
> > 	seq_buf_init(s, buf, sizeof(buf));
> > 
> > Instead, we can build this directly on the stack. Provide
> > DECLARE_SEQ_BUF() macro to do this:
> > 
> > 	DECLARE_SEQ_BUF(s, 32);
> 
> DECLARE_SEQ_BUF_ONSTACK maybe?  But otherwise this looks like a good
> concept.

It's usable for globals too... also it's a shorter name as-is. :)

-- 
Kees Cook
