Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D119750B;
	Fri, 11 Oct 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662217; cv=none; b=jZcdMZxFO2SgxV23rY/5mxeru7Yt9Q/3Gee1CwtTKp0D5OidhEoSUv7GUP2z2aJi6o5npLKsMhSLgJPhNoIrOIk/UQW/mZe0f1EPSz57VsHTGn2FvVTHyfPa+AuQnqO3QtBNtmPwjrnRcBlNpkMr3QPkfDS+CjqFIofwsZby5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662217; c=relaxed/simple;
	bh=Fn9ptgM41qALcSRg8TUBAG6/+e/ro51xfKybLhnLgGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmNJ3d59u8TN7Ivv6pamLNvMf95qlAziYEjUlAw6G1FoRnj2l6Lp+fkZ5qoPWGw6aMC47UL5jxV9s1o3loahpEz9uGdkpomdrWfmHW01ERusSMarn0XOnPRr1e44ZDFqlMJzYZgMMZgxFbfY+17rlZ5/CYNf9PbWTrEABXjU/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrPbIslR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrPbIslR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D75C4CEC3;
	Fri, 11 Oct 2024 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662216;
	bh=Fn9ptgM41qALcSRg8TUBAG6/+e/ro51xfKybLhnLgGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrPbIslRRF1t1B8nHBSGGOnXms+uD6Njx16YyPyoizdBuFuirO4+3x2Ko/CKE5/oP
	 XSt3XbqGPviX7kIcbmswAJs5Vy8DWnA2oXuKb67WJ+TW0QiVheVGMO7PtWO0blo7JG
	 utdBGsK63bteE4zTfjoKlpY9T/M2aGHNVXRQjnA3K/bB1NCl+EUwfniE9oOVYSLiVQ
	 gP3RkhV3542objfdIDtOAwdE2xhAeN76wwU7kUlCLS1o5ARLFkLza2a9EHF9sAseXk
	 KS+q49B8iHJyPpVkAwcNqYMtxrqjH/+pL5flmTPXqb+i7CwViZFI77OI+CQUsyap/E
	 vQOf0SnJ944vw==
Date: Fri, 11 Oct 2024 08:56:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, keescook@chromium.org,
	linux-hardening@vger.kernel.org, nathan@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 3/5] objtool: Add support for annotated jump tables
Message-ID: <20241011155634.se7xifgne6z5mqmx@treble>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <20241010122801.1321976-10-ardb+git@google.com>
 <20241010201530.6kfvlcdplqhrqjbj@treble>
 <CAMj1kXG1K2ka+ygUbRNwGvwFFMuOSXxawpHfCPmZjYSY2weDpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG1K2ka+ygUbRNwGvwFFMuOSXxawpHfCPmZjYSY2weDpA@mail.gmail.com>

On Fri, Oct 11, 2024 at 08:29:48AM +0200, Ard Biesheuvel wrote:
> On Thu, 10 Oct 2024 at 22:15, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Thu, Oct 10, 2024 at 02:28:05PM +0200, Ard Biesheuvel wrote:
> > > +++ b/tools/objtool/arch/x86/special.c
> > > @@ -115,30 +115,51 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
> > >       struct reloc  *text_reloc, *rodata_reloc;
> > >       struct section *table_sec;
> > >       unsigned long table_offset;
> > > +     struct symbol *sym;
> > >
> > >       /* look for a relocation which references .rodata */
> > >       text_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
> > >                                             insn->offset, insn->len);
> >
> > Hm, we can probably put insn_reloc() in check.h and use that here to
> > take advantage of its caching for the no_reloc case.
> >
> 
> insn_reloc() filters out R_*_NONE relocations, for the reasons pointed
> out in the commit log.

True, unless this becomes the fallback code for the generic "no
annotations" case as I suggested elsewhere.

Regardless we should be sure to write and read insn->no_reloc where we
can to minimize duplicate reloc lookups.

-- 
Josh
