Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E41CBEAB;
	Thu, 10 Oct 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592579; cv=none; b=Su8th4pe80Pt6o4bfZh+CNH+W5rfi77jTizrQXl0Uvg509Nu9XLXDnR/izP1CuzsfV+oyVCN8oqxw2SMpTxhBJHLVDexIvoN98NkhgHqTltx5i1n8A3BAVFRvbifQ+kDQoMP37vjZ4KvK6MJ3NmD/OHVGPGZkORRo5IBE9D8eH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592579; c=relaxed/simple;
	bh=sdA8aU3qMJHXuA4j+Zh5kdQvXBoT7eGPim3lJix5Dqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5vS3ttvhnI3j5dMsg8GPmT9zGVvxDYHmzsSE3dgJaeCBst9xVpcvCfxksfNx77aqLlLj5RBxGS/7Uq35rydCRIxkHf+lujHMaQrtwKMBIAcQqlHaPNbLWhrzYRi9TpixSZJP/8cSSuoqPfEkKZ2r5VMyYxaaJP0yULrvcKmaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGpZKrHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGpZKrHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB80C4CEC5;
	Thu, 10 Oct 2024 20:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728592579;
	bh=sdA8aU3qMJHXuA4j+Zh5kdQvXBoT7eGPim3lJix5Dqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGpZKrHFtkTrucYKaQAlDV0dOKdOnWkfFsDVKrvjA2joluqe40jfrfzrth1hfwkz5
	 X7VqRJ6li6uRnjn3mxS3TKkYj/z2T5PL2x7it2bmlyW9jkWTdrKmFqR6/XLXR3uoWp
	 QN5zQUXsaB2d6iC5b46MfvcHvc8Hjujzdbw8jwSfR7m1OSESVnzxK8iAKRaNX/LSaP
	 xtK9jnPmvohm/Gau03MZY7BWir2aqvBn4VnWDpY5xSwZ6UwLIZ1C9zLRUpHTYoFc0c
	 BxUnSIu/sdkrfpp7lQTXLCTF7BeAxEg0jzTnLTbWjywEz41AkjJWTWAh0Qqr4KhixP
	 a2dorIMaOfNSw==
Date: Thu, 10 Oct 2024 13:36:17 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, keescook@chromium.org,
	linux-hardening@vger.kernel.org, nathan@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 0/5] Improve objtool jump table handling
Message-ID: <20241010203617.mlz76o5mxhyq6lxr@treble>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <CAMj1kXE_ZQG0B5fTTxQUWB5wUQPYVgP3TE5Z4ouEXZtyhs=CQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXE_ZQG0B5fTTxQUWB5wUQPYVgP3TE5Z4ouEXZtyhs=CQQ@mail.gmail.com>

On Thu, Oct 10, 2024 at 07:50:17PM +0200, Ard Biesheuvel wrote:
> On Thu, 10 Oct 2024 at 14:28, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Jump table handling has faded into the background a little due to the
> > fact that jump tables are [currently] disabled when enabling retpoline
> > mitigations and/or IBT on x86.
> >
> > However, this is likely to come back and bite us later, so it still
> > needs to be addressed. Given the difficulty in identifying jump tables
> > from .rodata references and indirect jump instructions that often have
> > no obvious correlation, it would be better to do this in the compiler.
> >
> > This series implements [on the objtool side] the suggestion made at GNU
> > Cauldron this year to annotate the indirect jump with a R_X86_64_NONE
> > relocation that refers to the jump table, and ensure that it is covered
> > by a STT_OBJECT symbol whose size accurately reflects the size of the
> > jump table.
> >
> 
> For the adventurous, I have a branch [0] that implements the first
> part of this in Clang.
> 
> Getting the jump table emitted as a STT_OBJECT with a proper size
> shouldn't be too hard either, but I'll look into that later.
> 
> 
> [0] https://github.com/ardbiesheuvel/llvm-project/tree/jump-table-annotations

That was fast!  This is good stuff, thank you for working on this.

-- 
Josh
