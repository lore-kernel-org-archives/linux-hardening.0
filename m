Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891D3537CE;
	Tue,  3 Mar 2026 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569196; cv=none; b=lQFOpsd7fV1EedPIFs3clds3hC52iMdTlG+/2MGKuQ0BvjHqTOUeqmGtCasDChEYPhx9vB7x8LINM3hg44mmPcKmWV/mafsISzgaEMtLZ3yEo4w6yWWhHXC7PXl9D+s6bvw1pUo0UdqHOVwJCjRRAK95DSyx52Phxi7Nab0i2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569196; c=relaxed/simple;
	bh=81Iwy/s0JgkEL8ACXm/QGN3oCBxcu54YRQDMjGYtQ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sie+Vv/2trJXYvjIUWLhIhInA6zm6D2xAcHwpsfzk7uhqfJs1jkRDN/ieTzdn9LlQ8bwJVen76RvVjQIxAmIMM4Fe0IRqbEsGiXma2ET5iA0AmMAlE6hf8zTvZgIQbceDPRUJANHLlhPlAi1Z5cU4h8SUS64ltnpIvVqjLDwPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geoHmaBD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geoHmaBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70B2C116C6;
	Tue,  3 Mar 2026 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772569196;
	bh=81Iwy/s0JgkEL8ACXm/QGN3oCBxcu54YRQDMjGYtQ8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=geoHmaBDRuEHzS5k9iUPrQbOVo4N30Uc6RcPYnszlk4DJ+WRlYcg/C5v6iNPI8PPD
	 ZofO+bD5xswoL02OoUb/vYd17XJMjHQWfHqO0oq+ogzpjfxlvrWwgfThcAKI7DtN13
	 EkrK9Dl3oaqvZRFWcuOeM8TXKJoTR5aHxlTTd7Rr83oelNYUGrPh7B2okp6cl4oLhw
	 iE6LoUavDlcdKV0siVth4Hh6ZsFveV17cjssMMYnV1TCOOb1lju8nSakVUmtoli3ee
	 bz+F5zYnLcoJWvj77YF9xT7v8MJiFIefVRqI9KsE9oWY3y/erdNb5ugysZOSxSsYsK
	 aUlXNRvq0C0LA==
Date: Tue, 3 Mar 2026 21:19:51 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH 08/18] docs: kdoc_parser: fix parser to support
 multi-word types
Message-ID: <20260303211951.0e2b7faf@foz.lan>
In-Reply-To: <87jyvsbyvb.fsf@trenco.lwn.net>
References: <cover.1772469446.git.mchehab+huawei@kernel.org>
	<544c73a9e670b6fef1828bf4f2ba0de7d29d8675.1772469446.git.mchehab+huawei@kernel.org>
	<87jyvsbyvb.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Mar 2026 10:34:48 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > The regular expression currently expects a single word for the
> > type, but it may be something like  "struct foo".
> >
> > Add support for it.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > ---
> >  tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
> > index 39ff27d421eb..22a820d33dc8 100644
> > --- a/tools/lib/python/kdoc/kdoc_parser.py
> > +++ b/tools/lib/python/kdoc/kdoc_parser.py
> > @@ -1018,14 +1018,14 @@ class KernelDoc:
> >  
> >          default_val = None
> >  
> > -        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
> > +        r= KernRe(OPTIONAL_VAR_ATTR + r"\s*[\w_\s]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")  
> 
> Just for future reference...I *really* think that the code is improved
> by breaking up and commenting gnarly regexes like this.  They are really
> unreadable in this form.  (And yes, I know the code has been full of
> these forever, but we can always try to make it better :)

Heh, you're right: this could be better.

> Anyway, just grumbling.

Heh, if we start using a code like the tokenizer I'm experimenting
here:

	https://lore.kernel.org/linux-doc/20260303155310.5235b367@localhost/

we could probably get rid of regexes in the future, using instead
a loop that would be picking "ID" tokens, e.g. basically we would
have something similar to this completely untested code snippet:

	self.tokenizer = CTokenizer()

	...

	ids = []
	get_default = False

	while kind, value in self.tokenizer(proto):
		if kind == "ID":
			ids.append(value)

		if kind == "OP" and value == "=":
			get_default = True
			break

	if get_default:
		while kind, value in self.tokenizer(proto):
			if kind in ["CHAR", "STRING", "NUMBER"]:
				default_val = value
				break

	declaration_name = ids[-1]
	

Thanks,
Mauro
