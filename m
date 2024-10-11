Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C5195B1A;
	Fri, 11 Oct 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662708; cv=none; b=iC83OUT7zq+NRz9uv/zkT51DL955lGjy8SBqO2WhEgvv55RqaU6psdLBTsV4+/41CKxt3KfrdozlXx11UKMonSedacwvsOVhcjpRuSmk8iqRewjPJbwUcPn65Z3LZ+NHNYmSZrI4s8n2CWgf1oAvTurGbVOysk3mgu88Y4mdWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662708; c=relaxed/simple;
	bh=KAR4BEOjc8S3UnqnaT/nQ8JqG6AHk684wzyCsII0eUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKGsrI4PuEoCubw2zoNG9EEvEH7hBxzVNXapyHi2hB6uu7xhuQDWFjXWkLGKxFilHNnL7W83/Yacs2lIDSdGGHh1KHxkiaeggWP8ebG+JI3/HRxZt69kjjUfFa98kK/Ev6+WrfClAyzYsUU4mHOBkD0D2qkZMPlb9dSjkBA6QNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laOl9Jxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laOl9Jxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E147C4CEC3;
	Fri, 11 Oct 2024 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662707;
	bh=KAR4BEOjc8S3UnqnaT/nQ8JqG6AHk684wzyCsII0eUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=laOl9Jxj4ylDNtuTketukbhUC64aV3z8pTUcEUXKWxtv3h3sJrs9fw34GlhVz4rFW
	 qV/iYBJkjcDdPEdTnA+TLpqJQM5i+WyZsqRi8BblSfyhHFETHVRwW7dpMUJ5IOOdDe
	 vb7uWlySP6CB1cTTiLzq+fNKl9vpANpNyQ3Y6uUVuWcm/yRSY+dK+2XQE3xenDY1Tb
	 OrC5XC6S2xy593a+E4rZTCyCYpaWkZTgBLwJSkocjICvsb5SvWupZgK5MQL1/U03rH
	 Jji7YmMqt8U4ePuSl5cFomWjA7suWXiNZFDgm0HtyfCgiMPjRMqV+XYacC5Dho7ciY
	 uNfSQm4Bt1jCA==
Date: Fri, 11 Oct 2024 09:04:45 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, keescook@chromium.org,
	linux-hardening@vger.kernel.org, nathan@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 5/5] crypto: x86/crc32c - Tweak jump table to validate
 objtool logic
Message-ID: <20241011160445.7clmhtgywqmkuh4u@treble>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <20241010122801.1321976-12-ardb+git@google.com>
 <20241010203401.45ds362dpx52ne5z@treble>
 <CAMj1kXF_-wSM-rmxS5C_cG-srdUgzKQsSGxp54pZ4pMhXeNsfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXF_-wSM-rmxS5C_cG-srdUgzKQsSGxp54pZ4pMhXeNsfg@mail.gmail.com>

On Fri, Oct 11, 2024 at 08:32:33AM +0200, Ard Biesheuvel wrote:
> On Thu, 10 Oct 2024 at 22:34, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Thu, Oct 10, 2024 at 02:28:07PM +0200, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Tweak the jump table so
> > > - the address is taken far way from its use
> > > - its offset from the start of .rodata is != 0x0
> > > - its type is STT_OBJECT and its size is set to the size of the actual
> > >   table
> > > - the indirect jump is annotated with a R_X86_64_NONE relocation
> > >   pointing to the jump table
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > This needs more "why", I assume the goals are to add the annotations +
> > confuse objtool if it doesn't read them properly?
> >
> 
> As presented, this is just a vehicle to test the other changes in the
> series. That is why I split it off from the previous one.
> 
> Whether or not we want this code in the tree is up for debate, but I
> guess it could be useful as a canary for objtool, given that most
> configs now disable jump tables entirely.

The annotations are definitely needed since that's the future of jump
table handling.

The rest of the changes aren't worth the effort IMO.  In general we
don't compromise code quality to make objtool happy.

And "unit test for deprecated jump table detection" is even less of a
justification than would be something like "objtool can't otherwise
follow the code".

-- 
Josh
