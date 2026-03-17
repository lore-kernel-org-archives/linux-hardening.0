Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59137649B;
	Tue, 17 Mar 2026 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773858; cv=none; b=hffAnHFdNqG4wudloAKBL+x7SgCzsGVSlFSnD2/NdKoZaoG0cA2ElvbV7LeeQwiefs2nNQJ1yPyRPItNfadDg3vMCcMDtqc5TBn7rApfItZJM2h7Mwt973UVZD/kgWj2TWQZpbiiTKWD/Z+EVFRRD4brjnHaOGwCG6eZJ7M3UQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773858; c=relaxed/simple;
	bh=pwww5r/oyomEH98GG3wM7tmflXS5Us/dG8w1TjARVyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FY9LyccUv7/zPhJPjr/Bh8D9vwtASOwh8f5JOBDdCXZ5qDenKT6eKPOH1sAvjSQGUnTSvqzgCe9PjCWO+l2pxwNDszVYLwUdOj47kP4IjPEmePrEJJRhv2glYs04Xxxv/uRq1bkswXLIAJiOlH6Fh312dZagZSAgXo0H0eNBiTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyhG4kOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyhG4kOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEF1C4CEF7;
	Tue, 17 Mar 2026 18:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773773858;
	bh=pwww5r/oyomEH98GG3wM7tmflXS5Us/dG8w1TjARVyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AyhG4kOYhFjG1mwiOtFWyOThSQchNdUaZ4LKs4cFyzkHbsEm+ioR9PgJj+XgzaBnV
	 L9XTF/IKQadOzt6dqQvdXvUcGMsAbKQS2ijG9mzfGmGqOQIRvRLdrxlbjInAF5itZX
	 vD5uK0RStSNJNNPJEgfCuNsRmGemXEWaHIG/0De2uyPyZwCxassHNwNfX7/fl7zLPr
	 phto4P8Jhefx6dT8+A/JZKNPA5a3/JQZom9KiDoGpTiBKcaOWR9qykdE8/TECQSNfW
	 QYXJud7VGZQE2t2wnQz1r229Gw07gibSkO7dkuDnoG3SnikIuPPysNda40vUqrlHJH
	 hwOVXMku4QPcg==
Date: Tue, 17 Mar 2026 19:57:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Vincent Mailhol
 <mailhol@kernel.org>
Subject: Re: [PATCH v2 00/28] kernel-doc: use a C lexical tokenizer for
 transforms
Message-ID: <20260317195731.315660b5@foz.lan>
In-Reply-To: <87tsue9y7h.fsf@trenco.lwn.net>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
	<87tsue9y7h.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 11:12:50 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Sorry for respamming this one too quick. It ends that v1 had some
> > bugs causing it to fail on several cases. I opted to add extra
> > patches in the end. This way, it better integrates with kdoc_re.
> > As part of it, now c_lex will output file name when reporting
> > errors. With that regards, only more serious errors will raise
> > an exception. They are meant to indicate problems at kernel-doc
> > itself. Parsing errors are now using the same warning approach
> > as kdoc_parser.
> >
> > I also added a filter at Ctokenizer __str__() logic for the
> > string convertion to drop some weirdness whitespaces and uneeded
> > ";" characters at the output.
> >
> > Finally, v2 address the undefined behavior about private: comment
> > propagation.
> >
> > This patch series change how kdoc parser handles macro replacements.  
> 
> I do worry about adding another 2000 lines to kernel-doc, even if more than
> half of them are tests.  But hopefully it leads to a better and more
> maintainable system.

Net change due to the parser itself was ~650 lines of code, excluding
unittests.

Yet, at least for me, the code looks a lot better with:

        (CMatch("VIRTIO_DECLARE_FEATURES"), r"union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }"),
	...
        (CMatch("struct_group"), r"struct { \2+ };"),
        (CMatch("struct_group_attr"), r"struct { \3+ };"),
        (CMatch("struct_group_tagged"), r"struct { \3+ };"),
        (CMatch("__struct_group"), r"struct { \4+ };"),

and other similar stuff than with the previous approach with
very complex regular expressions and/or handing it on two
steps. IMO this should be a lot easier to maintain as well.

Also, the unittests will hopefully help to detect regressions(
and to test new stuff there without hidden bugs.

> We're starting to get late enough in the cycle that I'm a bit leery of
> applying this work for 7.1.  What was your thinking on timing?

There is something I want to change, but not sure if it will
be in time: get rid of the ugly code at:

	- rewrite_struct_members
	- create_parameter_list
	- split_struct_proto

I started doing some changes with that regards, but unlikely to
have time for 7.1.

I do have a pile of patches sitting here to be rebased.

Among them, there are unittests for KernelDoc class.
IMO, it is worth rebasing at least some of them in time for this
merge window. The ones with unittests are independent (or
eventually might require minimal changes). I'd like to have
at least those merged for 7.1.

Among them, there are several tests written by Randy with
regards to some parsing issues at kernel-doc. We should at
least merge the ones that already pass after the tokenizer ;-)


Thanks,
Mauro
