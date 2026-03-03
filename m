Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8037269F;
	Tue,  3 Mar 2026 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576329; cv=none; b=iyp/V3dbf5U2jf3pn9h2KcfCBYs1aCtEaHjGGzhKdKxxYPTv3qsWps/sD5NBVryboQdTntIdPL1kBb02RH4DIxEQqI9vIl2ooqd2LpP19fYwLBUwwU8RQZ9RIvmvMXHjKNlCbgrLPQ+7Fd1kvhtZJLN1hxzKJLrTcpH8EQ/2jdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576329; c=relaxed/simple;
	bh=t8ybpGAdNihDZQ9kZ3/Q1qm+ufzQOMPCxFRbUnfMLvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/1W2IHzD4/1GmGQkobCS5hqT1KH+8TOhZQMnNr1oGEmMWChb15kRJEH793WYaXSCD0WfTT4ICy93BErGZi64WycQys0l/ypsIj7oD0QoKuTP71o5tfjVX2UzgN6MZ9qjM932akewYP7X0mHhYzXMnz8DeC39pjLn4rcXjYUGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIFyxr1H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIFyxr1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4439C116C6;
	Tue,  3 Mar 2026 22:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772576329;
	bh=t8ybpGAdNihDZQ9kZ3/Q1qm+ufzQOMPCxFRbUnfMLvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIFyxr1HQSSPJhQ/1Vn1H1V0G1NerSvlK14HOUsE5AwW/CoUiOK8RAMdrG4nlYZEQ
	 vC6WDgkAuVLZHiBI1b+Yw3ucxtNLYCwSb0LGFJjsrqKV+Kr/kjRofNMZvKhM5g5RQ1
	 t7+boolw8gsRLzoKfLSlrKyIFM+sW56u1E3Gyq57IQh0TPhLkqE80UbCMa9uYdVl5r
	 EUdR1DOBbQ+YHdOqaiWf57ROcDEdXXN3VZ7wvDyBg9Rl3bzCpPd4y15sbwxf/1ftaV
	 OEsvf5CCcAERWWacUxH/n/67qYHYQVXcUbnD8bYaOeNNPNVUfDsjrNDj8LaDuIBZYH
	 +36Y20lMmt46g==
Date: Tue, 3 Mar 2026 23:18:43 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 08/18] docs: kdoc_parser: fix parser to support
 multi-word types
Message-ID: <20260303231843.040f41d0@foz.lan>
In-Reply-To: <87cy1kacfc.fsf@trenco.lwn.net>
References: <cover.1772469446.git.mchehab+huawei@kernel.org>
	<544c73a9e670b6fef1828bf4f2ba0de7d29d8675.1772469446.git.mchehab+huawei@kernel.org>
	<87jyvsbyvb.fsf@trenco.lwn.net>
	<20260303211951.0e2b7faf@foz.lan>
	<87cy1kacfc.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Mar 2026 13:24:55 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Heh, if we start using a code like the tokenizer I'm experimenting
> > here:
> >
> > 	https://lore.kernel.org/linux-doc/20260303155310.5235b367@localhost/
> >
> > we could probably get rid of regexes in the future, using instead
> > a loop that would be picking "ID" tokens, e.g. basically we would
> > have something similar to this completely untested code snippet:  
> 
> ...which has some appeal, but I will confess to being leery of another
> massive kernel-doc thrash; it would be nice if things settled for a bit.

Yeah, I feel your pain. The idea is not to simply rewrite the entire
kernel-doc. Just to use it at the places that have known hard to solve
bugs.

> One can always dream :)

The thing is that there are some issues at kernel-doc that can only be
solved with a better parser, and a plain regex logic won't fix, even
with really complex expressions.

I'm not talking about variable handling like on this specific patch.
For it, the current pure regex approach works fine, at least for the 
cases we already mapped.

However, kernel-doc, even after this series, do a crap job on
several places:

1. Macros used to build structs and function prototypes.

   During the conversion I wrote a half-baked NestedMatch class to be 
   able of properly handling struct_group*(), which is the best
   example of the involved complexity. It works, but it requires parsing
   the code twice.

   Also, It probably will fail with nested struct_group;

2. Nested structs.

   Current logic just transform them on an un-nested struct-like
   pseudo-code to re-use the structs regex-based parser;

3. Nested struct identifiers handling.

   Spec says that if one has:

	struct {
		struct {
			int foo;
		} a;
	} b;

   kernel-doc should document "foo"  as "a.foo", but this is not
   always the case, due to bugs at the parser. So, on some places,
   you need to use "foo"; on others, "a.foo".

4. Public/private handling.

   Code almost works, but when it finds a unmatched private inside
   a nested struct, it will can hide close brackets. This prevents
   fixing (2).

5. Comments strip.

   Code kinda works if you don't touch it, but when trying to solve
   the previous issues, I ended discovering some hidden problems
   related to the way it does.

   (That's basically when I ended opting to try a different approach:
   too much changes to try to live with a plain regex approach,
   plus all stuff needed for NestedMatch to do a better job)

6. Proper whitespace and alignment at the output.

   The current way we parse things mean that little changes end
   mangling with whitespaces, line breaks and/or indentation.

   Perhaps we could use some token-based formatter for man pages
   to properly handle open/close brackets.

   For rst output, we're relying at the C domain to handle it for
   us. Still, perhaps a tokenizer-based approach can just add a
   single whitespace everywhere, which would help us to check
   before/after differences on kernel-doc changes.

I attempted fixing this at the /38 patch series and afterwards
(good news that that we have 18 less patches after you merged
this one), but my current pending patch pile has stlll +40 patches
to address issues and add unit tests.

Among them, I have changes:

- adding support for "\1", "\2", "\3"... group matches at
  NestedMatch sub. It works. The code itself is small, but
  very complex;

- writing a different logic to address comment stripping;

- write a logic to pick struct IDs on nested cases that will
  be using an approach similar to NestedMatch.

- some of those new logic are recursive, which makes them 
  more complex to be understood and tested.

Such approach works, but, as Jani pointed, this ends adding lots
of complexity, and the main reason is that we're acquainted to
use regexes - or perhaps too afraid to handle it on a different
way. Also, they ended introducing extra bugs.

I had to confess that I also a little reticent on trying to use
a tokenizer, as I was afraid that this would require extra libraries 
to have something similar to what flex/bison would be doing. Then,
I realized that perhaps the already internal libraries might just
have what we needed. So, after some research, looking at:

	https://docs.python.org/3/library/re.html#writing-a-tokenizer

and doing some (so far simple) tests, I'm starting to think about
modifying my pending patches to use a code similar to it.

Note that, at this point, I didn't try yet to use the tokenizer,
so for now this is still mostly a brainstorm.

I intend to try to use the tokenizer to handle comments e.g. touching 
the logic at trim_private_members() and see how it behaves. This is
self-contained, checking the results would likely be easy, and I don't
expect big surprises.

Depending on such tests, I may try to modify NestedMatch and my patches
using it to use the same approach.

So, if all ends well, the changes will so far be confined to the code
used by dump_struct().

Let's see.

Thanks,
Mauro
