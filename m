Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915614CA779;
	Wed, 16 Sep 2026 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602433; cv=none; b=fNrY289ejWHwXSmeJcHoP2Exa5ls/rrBZQwj4yT9YAQiyl+wKTtY5ncSUc3nGiUETaMcrLwdFJnVNrojeMw8mTXfQKjzt2WydCcAHTfOkIY1uDYkeZW/NbZNCEbbG4JjzzONfVi+TGB8ahRUYsbMt1EnjP1pAPU0AVBJhUxMpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602433; c=relaxed/simple;
	bh=xcQbuQCTaIGAF6mI1oycUeAihm3WTCyMybedW6aJwno=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cI0QIHaeoxRBX+v/Wu3EVmh7vtw04QtC24/KgmBl3TANhBCaj/DeSTNVM+NtrY4U+dDBMZhMEI8maQ/TWVi4FOsvb8DlNZpluym5U7jUFU9tLJ+qD9dTN3H295zb1OZP5k8V2io06k4vb50grJs/KdXAeaSLjDqwx/Ctmx6A1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cTesvBSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cTesvBSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E841F000FF;
	Wed, 16 Sep 2026 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789602432;
	bh=JKgTt1sQ7/qLPnHBq3FbLcUGRvhwvJNUKeiBPmJN+Ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cTesvBSQV7PoiZUHL+YuH0dtEFipJlShaSzcSUxmXugLOsmVVjeMPjVSvn9Kht7A4
	 BIfo1ZgWJPT3ubOgJ1H9oTysLDKgvaxjvtJRexhWjy8C3BOZSK6XYjREVCQyf+LLEF
	 uv4Zq6oodWPia1eN56kf1JknxzvDEF2JWxHVZeU8=
Date: Wed, 16 Sep 2026 16:47:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_buf: add seq_buf_strlen(),
 seq_buf_init_append(), seq_buf_puts_trunc()
Message-Id: <20260916164711.1cf51b0c3f085639dac5d690@linux-foundation.org>
In-Reply-To: <20260916222125.1259631-1-morbo@google.com>
References: <20260916221528.1256283-1-morbo@google.com>
	<20260916222125.1259631-1-morbo@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 22:21:25 +0000 Bill Wendling <morbo@google.com> wrote:

> Converting some strlcat() call sites seq_buf need behavior seq_buf doesn't
> currently provide, either directly or without introducing subtle bugs:
> 
>  - seq_buf_strlen(): seq_buf_used() reports the full buffer size when the
>    buffer is completely filled, even though seq_buf_str() then overwrites the
>    final byte with a NUL terminator, leaving only size - 1 bytes of
>    actual content. Callers that need the true length of the
>    NUL-terminated string have to fall back to strlen(seq_buf_str(s)).
>    seq_buf_strlen() mirrors seq_buf_str()'s NUL-termination logic but returns
>    the resulting string's length directly.
> 
>  - seq_buf_init_append(): seq_buf_init() always clears the buffer it's given
>    via seq_buf_clear(). Code migrating from strlcat(buf, ...), which
>    appends to whatever @buf already contains, can't use seq_buf_init()
>    without silently discarding that existing content. seq_buf_init_append()
>    preserves it and positions the seq_buf to append after it.
> 
>  - seq_buf_puts_trunc(): seq_buf_puts() (like seq_buf_printf() and friends)
>    writes nothing at all if the string doesn't fully fit, whereas strlcat()
>    always copies as much of the source as there is room for. Converting a
>    strlcat() call site that relied on that partial-copy behavior to
>    plain seq_buf_puts() can silently drop content that used to survive
>    truncated. seq_buf_puts_trunc() keeps the leading bytes of the string
>    that fit.
> 
> ...
>
>  include/linux/seq_buf.h | 60 +++++++++++++++++++++++++++++++++++++++++
>  lib/seq_buf.c           | 35 ++++++++++++++++++++++++
>  2 files changed, 95 insertions(+)

This seems a lot of code for enabling some strlcat removals.  How many
is "some"?  If "3" then perhaps do something different at those
callsites?

Sashiko had a couple of comments:
	https://sashiko.dev/#/patchset/20260916222125.1259631-1-morbo@google.com

Should these new functions be added to lib/tests/seq_buf_kunit.c?
