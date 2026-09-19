Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116DE2F851
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 04:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789791739; cv=none; b=IOICBBo//WEvY33bzFgJcrl7ndtCspWVn2i8wBiBuH6fQWkXGO4+1VUErdDDt8NrugzTok7wf7bEtPevuUZdcrp137RZtuIKqT78LRd+9Lv5uwzifvUzCx5oRWInKfEmQ7s9hf/kcaETr8+ouxE5WykZ6BfeQmYaUSwZcQFZe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789791739; c=relaxed/simple;
	bh=GNjjIWWiBopuVODMhda7imNeyX4x8WR63s9hd281YuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeIUTMNfPGBW3JRKQ9zAdKpiXnZlqWum2Yo+6IptY6am4Kyulhm9sRQcYkgAdvxRcSyMORCIbCnyyGmTc3iVKXXheau5ly12oGo6AA+aiBWAEOWgfYII51CMvTg66F4+k0cy8xmWKDIUoprKlh2cxdKvrsFGUY37mXLoaO8mZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxf0cmII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxf0cmII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5201F000FF;
	Sat, 19 Sep 2026 04:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789791737;
	bh=+DXNb7cpUTcyz7gxA662LqYoHG1KHR87RYfAwqWm1YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gxf0cmII0sKtJiWnATJKDmfTCNOmyhQr5+iRSl4Xpx0QflIbj33FcJSly7BhIk3KC
	 qDA2C/n7pUjt8R86JlWMbbJ2RN1qMfqCLgtBn/6QfTIYAuz/7j7aron/8vXE4Vizhy
	 FYA04fI+5NDLg4WoZRXUcuQAoZVQwvQmB06SbGLsBNDG11TFsl+zCxxLqbWLlYqKKc
	 klgHghnFc7JelGk3MfoeIH56bJ1ECh/CXVjCX3ixgHCmiQpmCqm+F1wS5IAw7APFVr
	 o3f9mEOdxMOSxlzwRJpIrP5OmztuNvRR9e0xvxA+LKRf3DGg8hEbm7qZDjvUMSj4Zn
	 E3TuCdBaBTASA==
Date: Fri, 18 Sep 2026 21:22:17 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
	Richard Biener <richard.guenther@gmail.com>,
	Siddhesh Poyarekar <siddhesh@gotplt.org>, gcc-patches@gcc.gnu.org,
	Martin Uecker <uecker@tugraz.at>, josmyers@redhat.com,
	Bill Wendling <morbo@google.com>, linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2] tree-object-size: Fix type-1 size for FAM subobjects
 under -fstrict-flex-arrays=3 [PR126975]
Message-ID: <202609182117.7AFD5B1@keescook>
References: <apomrLZp1ee3NnBF@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apomrLZp1ee3NnBF@kspp>

On Thu, Sep 03, 2026 at 08:02:20PM -0600, Gustavo A. R. Silva wrote:
> For a pointer to a subobject whose record/union type ends in a flexible-array
> member (directly, or through a trailing nested struct), addr_object_size()
> walked up to the enclosing object (v = TREE_OPERAND (v, 0)) instead of
> measuring the referenced subobject.  __builtin_object_size() and
> __builtin_dynamic_object_size() type 1 therefore returned the whole-object
> size, collapsing type 1 onto type 0 and losing the distinction between
> &p->inner and p.  FORTIFY_SOURCE relies on the type-1 distinction, so this
> weakens its bounds checks.

Looking at the PR:

struct flex {
  size_t count;
  char fam[] __attribute__((counted_by(count)));
};                    /* sizeof(struct flex) == 8  */

struct outer {
  int hdr;
  struct flex inner;
};                    /* sizeof(struct outer) == 16 */

int main (void)
{
  struct outer *p = __builtin_malloc (sizeof (*p) + 48); /* 64-byte object */

  /* This is a bug. */
  expect(__builtin_object_size (&p->inner, 1), sizeof(p->inner));
  expect(__builtin_dynamic_object_size (&p->inner, 1), sizeof(p->inner));
...
}

Before:

WAT: __builtin_object_size (&p->inner, 1) == 56 (expected 8)
WAT: __builtin_dynamic_object_size (&p->inner, 1) == 56 (expected 8)

After:

ok:  __builtin_object_size (&p->inner, 1) == 8
ok:  __builtin_dynamic_object_size (&p->inner, 1) == 8


This makes sense to me, the dynamic size of "fam" is ambiguous between
being 0 or 48 (from the "alloc_size" attribute), so type 1 chooses the
smaller.

I would, however, expect the use of counted_by to change it. For
example, if it were this:

struct flex {
  size_t count;
  char fam[] __attribute__((counted_by(count)));
};
...
  struct outer *p = __builtin_malloc (sizeof (*p) + 48); /* 64-byte object */
  p->inner.count = 48;

I would expect the results to be:

ok:  __builtin_object_size (&p->inner, 1) == 8		/* compile-time size */
ok:  __builtin_dynamic_object_size (&p->inner, 1) == 56 /* run-time size */

As the known size of p->inner is everything contained by "inner" and
that now includes the 48 bytes of "fam".

-Kees

-- 
Kees Cook
