Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CAD3101D0;
	Mon, 21 Sep 2026 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984017; cv=none; b=WA0TidQVsZUpdR/TnkjHoBUaYSQvYjzwEHnd1xD6LIHCF8qnY/+40t4aSPHV/hpcGlDl7SPLS+MW7xczIitvi1uzL1Nbcb+hH96LB+0rLLapfT5apdxaosMrdTO0+dxmSN6xIo62zoFlm0wYomn5w0qDGk0atmVFYNPM5e7CgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984017; c=relaxed/simple;
	bh=HBTiPzvCz4ug/UW24QEsYK91W05gquo6aW+Re5JmGP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DImYgau7u7b25O2U6GYnYqS5LZraiudR1Ht8Ci3a9cGGQ35bv35iWDLXI8IavJWDvUR2jRFsugdAF1K1eARk6+gHlvc0QXuJNDUWjHvi9tMzYSd33kPZk3Ng3M5qFJ9/Kmm9izadkZgfDDnK3z6/LydF9XouIV2e9iepuTP2t8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=nCOKXCAW; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="nCOKXCAW"
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C98B81C2BF5;
	Mon, 21 Sep 2026 09:46:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 79BB46000C;
	Mon, 21 Sep 2026 09:46:49 +0000 (UTC)
Date: Mon, 21 Sep 2026 05:46:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, David Gow
 <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, Shuvam Pandey
 <shuvampandey1@gmail.com>, nikitash.mariiaw@gmail.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 5/9] seq_buf: Add seq_buf_strlen()
Message-ID: <20260921054647.3895bbb8@fedora>
In-Reply-To: <20260919002714.4060307-5-kees@kernel.org>
References: <20260919002658.stay.929-kees@kernel.org>
	<20260919002714.4060307-5-kees@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rjp184kr1thiqj9oja9w7maf7ifpz1i9
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 79BB46000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/wV+xy5oM/Yc19hz0L8UJwSIOf8eJGKII=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=hn41DI64BsSqbK+yXrYMlFcl7stInT1IdTJz73ayXrE=; b=nCOKXCAWEcIlGMHR8y4sxxY5B5enhzOruMrLNyYCDEa/zLwBfmSzmNtT90/YRi8hDy+JDwAYz+9/8BFbpM0fWzM4qWaFs3BZA/DczfewkHeFMVJkt+zC8UaLnRk934xV/Yu+JnxFuA6xYza5KR3WlQthVrC8bq3N/G36MI4voCU=
X-HE-Tag: 1789984009-41735
X-HE-Meta: U2FsdGVkX1+Q1gHPMV9MLHov25WHz+30ZbsaOySM58BDX39LOagkVjapGbw+eoiq4YV4TIwNW/oOPbbuIIm9K7u/IauLtXmGhN85++Mvj7fOCJkQXYNyYd1tKqvEvrusAWK06rbmcuhyLMzU6XdVyuHmE4CedJF/ARDu8k95doxwCTnI9MYv7gMWrnwmBqErXb7errnPKWm54ctla58GW9FrSMBz8hSpGqgDjQWa9gsGBnTVA+aRJIXs2Jr/8dCHDN5xNbr/e7cG1Ij0wW62ec7b41ifSuRsvkhMz8mwXBTfzuGZIkffTaRRB7UowzpjGTbCMauwGzI6kLsBXOPGoHPg/M7PCXp3bYTv7CahljlnMppFfHInbNH7+aoSBT/NtU+nuxct8WoPHFi8gXXqin8deJrwD/VB0So5QIl+GkfFZcOvPPmCrjec4XKCoTIQj5l3IveEToWHHFb0w85gbSBiUodLNHUIk8yu5gJ1KSDIHSPYinzspmPDRHzMocibvL0HE8SfcD0sQrmV947zvJGB1tk2Q07e9VNso7AE5XCIJyT8cFq34HBIEmfHsDylKQKrRyHXBNqabxJHaV6Rw2fxhmWHx4eIvz7fH7ghgeNtvcYAzHTfTFdVUNJh2Ac0G7uB6BTUdp0mYCyUY4MlwJh99fyXyUTr55v0oGlfb/dovII1eUfcahaSeOeaeQ+jaCUitxm6bhY=

On Fri, 18 Sep 2026 17:27:03 -0700
Kees Cook <kees@kernel.org> wrote:

> Several strlcat() call sites being converted to seq_buf need behavior
> seq_buf doesn't currently provide. The return from seq_buf_used() is
> not the length of the string in a seq_buf. Once the buffer is full or
> has overflowed it returns the buffer size, which counts the byte that
> seq_buf_str() replaces with the NUL, so a caller that needs the string
> and its length has to call seq_buf_str() and then walk the string with
> strlen().
> 
> Move the termination out of seq_buf_str() into a helper that returns
> where it put the NUL, and add seq_buf_strlen(), which terminates the
> buffer in the same way and returns that offset.
> 

Let's make a appropriate function to terminate the string in the
seq_buf and not have it be an internal helper function (This has been
on my todo list for some time).


> Add tests comparing seq_buf_strlen() against strlen() of seq_buf_str()
> for empty, appended, truncated, exactly full, and overflowed buffers,
> and checking that seq_buf_strlen() alone terminates a full buffer.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.
> 
> Assisted-by: LLM
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David Gow <david@davidgow.net>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Shuvam Pandey <shuvampandey1@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  include/linux/seq_buf.h   |  57 +++++++++++++++++--
>  lib/tests/seq_buf_kunit.c | 114 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 166 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 0c0a0db04b09..7f025c7a68be 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -89,6 +89,27 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
>  	return min(s->len, s->size);
>  }
>  
> +/*
> + * NUL-terminate the buffer in @s: directly after the data when there is
> + * room for it, otherwise in the last byte of the buffer. @s->size must not
> + * be zero.
> + *
> + * Returns: the offset of the NUL.
> + */
> +static inline size_t __seq_buf_terminate(struct seq_buf *s)
> +{
> +	size_t end;
> +
> +	if (seq_buf_buffer_left(s))
> +		end = s->len;
> +	else
> +		end = s->size - 1;
> +
> +	s->buffer[end] = 0;
> +
> +	return end;
> +}

That is, make this a separate patch to introduce a
"seq_buf_terminate()" function as there's several places in the kernel
that could replace seq_buf_str() with it.

Thanks,

-- Steve
