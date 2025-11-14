Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22EE33C538;
	Fri, 14 Nov 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132246; cv=none; b=pKBqXhbJ9CULtvv4LgiCuebW3v1oDqxyIAgpqlsdbc1sxeJihOHIAbIZm2DwITE2PK8RTGMYLdJaKIEBfwDbsOHJtiKn03pT5FKhWeQXRZStIcFyK/IASpM86EG0WXm6fPKbHgPHZRUhrIr0KVEWFHKvcNvcQyIoODEqD3M0GeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132246; c=relaxed/simple;
	bh=Bt1GnjAoXNH05xMi/+VUkv7n+IsXaD0CXwC3wYBbOkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU1IyuPdHJcLmvjgMNvnGxfd1OX75Bdiqo2s8FqLbRCvr36eQSAo6L3RN0ugdqU5y5Fo1aLD+j9kH/9XlXDC6QUSG1I6WN/A3EmdChd0Gih4UOLdlwWTF62q8b/hbEbDz7pxztTfYbP4q9M3qy6Uk4DHcg50/pf718GLf9LuGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 152F61603C1;
	Fri, 14 Nov 2025 14:57:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 3FD2F18;
	Fri, 14 Nov 2025 14:57:16 +0000 (UTC)
Date: Fri, 14 Nov 2025 09:57:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
Message-ID: <20251114095734.42b51e6c@gandalf.local.home>
In-Reply-To: <20251114085332.396aff85@gandalf.local.home>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
	<20251114084346.6469edc0@gandalf.local.home>
	<20251114085332.396aff85@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3FD2F18
X-Stat-Signature: royjy4yotbo9k9ocxdfo99pkz34itrrb
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19gOPEewzaFQ1x1gerH0c2WoHuqz/2Msus=
X-HE-Tag: 1763132236-316361
X-HE-Meta: U2FsdGVkX1/+qCq3PS/RiZcDF13w+Zx+2YSYngqYX5Y45RSJMZHqY9oOfHt7CFq7UaE5MbWON7z2Gcq1AguhONswjrDBxKMojzJGUd0PmMs+bL09uyKDZE54XYsFTBWtQqK+8OuFecvHKPN31s9KO/YYIoUx9n1VgNpR1p1nuOTpFuGZ5FaYbbDELYQ0kcd+hx1F2Fbcun1/tULl/4wzWxUoP/SJxnDuAaeCSGsrD8mcDcPcH8TAGoUvfIUw0U0UsFzLzqJEcJIXPaK5ZthIw1+AM5T29Kq2GxNmeQi1gMyYvtAkwK7KhhA4o7ch6cpf2sMYMn7W5JtaKds0sLm9I4KKam+yu6LonXN998RFtRNN4YhVcMe+W+X0+naFxfbA

On Fri, 14 Nov 2025 08:53:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -2,10 +2,14 @@
>  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> =20
> +/* Make the cache fit in a 4K page */
> +#define UNWIND_MAX_ENTRIES					\
> +	((SZ_4K - offset_of(struct unwind_cache, entries)) / sizeof(long))
> +
>  struct unwind_cache {
>  	unsigned long		unwind_completed;
>  	unsigned int		nr_entries;
> -	unsigned long		entries[];
> +	unsigned long		entries[UNWIND_MAX_ENTRIES];
>  };
> =20

Nope, this fails with:

/work/git/test-linux.git/include/linux/stddef.h:16:33: error: invalid use o=
f undefined type =E2=80=98struct unwind_cache=E2=80=99
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                 ^~~~~~~~~~~~~~~~~~
/work/git/test-linux.git/include/linux/unwind_deferred_types.h:9:19: note: =
in expansion of macro =E2=80=98offsetof=E2=80=99
    9 |         ((SZ_4K - offsetof(struct unwind_cache, entries)) / sizeof(=
long))
      |                   ^~~~~~~~
/work/git/test-linux.git/include/linux/unwind_deferred_types.h:14:41: note:=
 in expansion of macro =E2=80=98UNWIND_MAX_ENTRIES=E2=80=99
   14 |         unsigned long           entries[UNWIND_MAX_ENTRIES];
      |                                         ^~~~~~~~~~~~~~~~~~

-- Steve
