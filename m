Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274622F8EA4;
	Sat,  4 Jul 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783153706; cv=none; b=KFr9It3+t3VVwZHDwLzJ0g8yQFe0fExWBo76omH8iio3p3UCRgU3wFNhvSr81JcV1W2/AObKUN8uxlh3Blo9Jc2nOG+yjsLQL8Jlnqy50c2Cxb7wIK0rygR2keocKiWqC0pO9m+epxnAiXm0KjY+GMPRWtat95DnBGfbD6J5P4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783153706; c=relaxed/simple;
	bh=kiOjEEIye7RStbdfnVGOpKI3c/OoGSoOQfjCsPn13qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX5HcFrCjoo1nzUMrZN5kre6CjqtsvH0MWMmv8sc6l8Sl5g+rikkkmKCEYRPqXNvw2hwXHYakSRTnBXixBSNCjrYdzUJvygusuvnyd7iVo9sb64EPTj4lugEnL0EXG13LF0xrhOyXsHRmTqD4PVqDxI5i0SmR5PVUXuyH3nPgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 51C6F1EA5F5; Sat,  4 Jul 2026 16:28:17 +0800 (AWST)
X-Spam-Level: 
Received: from [IPV6:2001:8003:8810:ea00::9c4] (unknown [IPv6:2001:8003:8810:ea00::9c4])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 1B2A61E90AB;
	Sat,  4 Jul 2026 16:28:15 +0800 (AWST)
Message-ID: <3378cb25-a409-4834-8edb-3274270844c5@davidgow.net>
Date: Sat, 4 Jul 2026 16:28:12 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: string-stream: Replace strlcat() with strscpy()
 and seq_buf
To: Ian Bridges <icb@fastmail.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <akenPvVk1xr_-480@dev>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <akenPvVk1xr_-480@dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/07/2026 à 8:12 PM, Ian Bridges a écrit :
> In preparation for removing the strlcat() API[1], replace its uses in
> string-stream.
> 
> string_stream_vadd() appends at most a single newline into space that
> was explicitly reserved when the fragment was sized, so a bounded copy
> at the end of the string is enough. The return value of strscpy()
> keeps the length accounting unchanged. string_stream_get_string()
> concatenates a variable number of fragments into a buffer sized to
> hold them all, which is what seq_buf is for.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
> Truncation semantics differ between the two APIs. On overflow,
> strlcat() keeps whatever prefix of the fragment fits, while
> seq_buf_puts() drops any fragment that does not fit whole. Neither
> path is reachable here. string_stream_get_string() sizes the buffer
> to hold all fragments exactly. The newline lands in a byte that
> string_stream_vadd() reserved when it sized the fragment.
> 
> The patch was tested as follows:
>  - The string-stream KUnit suite passes all 12 tests before and after
>    the change. The full lib/kunit KUnit config (95 tests) also shows
>    identical results before and after.
>  - An x86_64 build of lib/kunit/string-stream.o at W=1 produces no
>    warnings.
>  - A userspace comparison of the old and new construction ran
>    with different fragment lengths for the newline append and with
>    randomized fragment lists for the concatenation loop. All outputs
>    were identical.
> 


Thanks very much (and thanks for testing it so thoroughly!)

As much as I find the need for all of the pointer/length arithmetic with
strscpy here a little less clear than strlcat, it's definitely not worth
the extra loop over the string, so I'm happy with the change.

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>  lib/kunit/string-stream.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 0d8f1b30559b..51ba40ebf19f 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -9,6 +9,7 @@
>  #include <kunit/static_stub.h>
>  #include <kunit/test.h>
>  #include <linux/list.h>
> +#include <linux/seq_buf.h>
>  #include <linux/slab.h>
>  
>  #include "string-stream.h"
> @@ -74,7 +75,8 @@ int string_stream_vadd(struct string_stream *stream,
>  
>  		/* Append newline if necessary. */
>  		if (frag_container->fragment[result_len - 1] != '\n')
> -			result_len = strlcat(frag_container->fragment, "\n", buf_len);
> +			result_len += strscpy(frag_container->fragment + result_len,
> +					      "\n", buf_len - result_len);
>  	} else {
>  		result_len = vsnprintf(frag_container->fragment, buf_len, fmt, args);
>  	}
> @@ -118,15 +120,18 @@ char *string_stream_get_string(struct string_stream *stream)
>  {
>  	struct string_stream_fragment *frag_container;
>  	size_t buf_len = stream->length + 1; /* +1 for null byte. */
> +	struct seq_buf sb;
>  	char *buf;
>  
>  	buf = kzalloc(buf_len, stream->gfp);
>  	if (!buf)
>  		return NULL;
>  
> +	seq_buf_init(&sb, buf, buf_len);
> +
>  	spin_lock(&stream->lock);
>  	list_for_each_entry(frag_container, &stream->fragments, node)
> -		strlcat(buf, frag_container->fragment, buf_len);
> +		seq_buf_puts(&sb, frag_container->fragment);
>  	spin_unlock(&stream->lock);
>  
>  	return buf;

