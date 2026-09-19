Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF5175A62;
	Sat, 19 Sep 2026 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782856; cv=none; b=Vd7PenWPOGo68za6MzKo/WIwI4Q6EZ9pitQJXzdGNL+0vsYv1LTHpryjkLLL4Mnh4AEkuBKKc5AlMfULXwBIuyY4h2I4JXakL6UCkG3XcsklMTZH0EVn18wDqN+UpLrXTm2szQ1TFURo1fVnnjpN4mnDyjZXKzKH3baE+fLnkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782856; c=relaxed/simple;
	bh=XXFTJNzgjE8QEiteFx7dAHw0+oJlD4NKJQ4hDNMVcaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKyRjuU6c+iZxf+311TQhAE/IzzFldDJPAMgIQV2d7815tEHF0uhbWT3kR5QHbS1qITyL+fvOCnZSvjN42juyE8zAfg4UWqVnvhrzXt+hRbkE5m2HR2/YZ83Qejd00YxhRvaYe+nkN3ATYuuJykuvk+0N2qvX8EmYUQ+4MQIZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JmE7Sz/I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JmE7Sz/I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ukPoAa7Sd+4obDEOdcgJlnjsn89RPHdhafZAiE+Afqc=; b=JmE7Sz/IAxIAkQigaiBzirpZ19
	7iWXFTBthgq62bTQGlC6AEvVDAveqSX5HnAISWjKH/UqiCgrQbyxSyuFRmCcCLV39Sd4pQzXs3J3R
	1vXD6XMW/qiQAnRZCwnJgK6xgoNlQlGTqrzEX9Ki2gIfbWEfmSIEMHsU6i5efsAaTPSQbhkJmI906
	S4FQ0Go05Ie0mkca5McFeEBHCUuN8czin1tku00Lz71wxEdphbi9ZbGAqoTZnEdHavxLdKl4bvC5s
	Ihpr38edzTMPPUNWOaidRw5utrH+bOX7EWC691B1wGmRkZ2ve9LlHIpA/29EAa6olYmPmkkYfF/e0
	na1qahjw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7kHG-0000000FrMW-2RKh;
	Sat, 19 Sep 2026 01:54:06 +0000
Message-ID: <187dff38-1235-4478-8b31-d4894c90969d@infradead.org>
Date: Fri, 18 Sep 2026 18:54:05 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] docs: core-api: Document the seq_buf API
To: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Petr Mladek <pmladek@suse.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260919002658.stay.929-kees@kernel.org>
 <20260919002714.4060307-9-kees@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260919002714.4060307-9-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/26 5:27 PM, Kees Cook wrote:
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
> Signed-off-by: Kees Cook <kees@kernel.org>

Looks good. Thanks.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: <linux-doc@vger.kernel.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  Documentation/core-api/kernel-api.rst |  9 +++++++++
>  include/linux/seq_buf.h               | 12 ++++++++++++
>  lib/seq_buf.c                         | 13 +++++++------
>  3 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 4c4a57c1c094..f5a0aedbbb48 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -96,6 +96,15 @@ Error Pointers
>  .. kernel-doc:: include/linux/err.h
>     :internal:
>  
> +Sequence Buffers
> +----------------
> +
> +.. kernel-doc:: include/linux/seq_buf.h
> +   :internal:
> +
> +.. kernel-doc:: lib/seq_buf.c
> +   :no-identifiers: seq_buf_can_fit
> +
>  Sorting
>  -------
>  
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 89d847d40626..416a8b67b9ad 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -31,6 +31,10 @@ struct seq_buf {
>  		.size = SIZE,				\
>  	}
>  
> +/**
> + * seq_buf_clear - reset the seq_buf to be read / appended from the beginning
> + * @s: the seq_buf handle
> + */
>  static inline void seq_buf_clear(struct seq_buf *s)
>  {
>  	s->len = 0;
> @@ -38,6 +42,14 @@ static inline void seq_buf_clear(struct seq_buf *s)
>  		s->buffer[0] = '\0';
>  }
>  
> +/**
> + * seq_buf_init - initialize a seq_buf
> + * @s: the seq_buf handle
> + * @buf: pointer to the buffer
> + * @size: total size of @buf
> + *
> + * The contents of the buffer are ignored.
> + */
>  static inline void
>  seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
>  {
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 7e3bf837da01..1c86eae9e188 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -407,12 +407,13 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
>   *
>   * Function is an analogue of print_hex_dump() and thus has similar interface.
>   *
> - * linebuf size is maximal length for one line.
> - * 32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
> - *	separating space
> - * 2 - spaces separating hex dump and ASCII representation
> - * 32 - ASCII representation
> - * 1 - terminating '\0'
> + * linebuf size is maximal length for one line::
> + *
> + *	32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
> + *		 separating space
> + *	2 - spaces separating hex dump and ASCII representation
> + *	32 - ASCII representation
> + *	1 - terminating '\0'
>   *
>   * Returns: zero on success, -1 on overflow.
>   */

-- 
~Randy
