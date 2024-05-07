Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D73D0BD;
	Tue,  7 May 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052242; cv=none; b=I+u4j2ovYGYykBO8ak6+fm0582S+CyKWiAmS/TAMXbowV/jMu4CRhZdjgYmKpSKsizgsz9Ik13rpOJk2Ou2Dits29nRWZzAfOSvWbQoKkRlKNkzdW1109jDrUTh5FdsOk6W45bwg5yonclfI3Qevo6HAB73rl+xZm0ZbVduTgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052242; c=relaxed/simple;
	bh=wwRDMK2MTHyfmFutWwVpB0wuAlNULl9BsyJ4npcXu/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF57CQ3nyyAI18P5cAWbvbQTnBNC9oxuYqKsIRoQslhJqQzbZHY+CKZWUvElRXT2Gk9gYER0Wt2Yf2ch2rOr9KtR6FsDtgsh37SbUFtLIERP2J+mJvu37/XfCyH2P+kwU9ppAzRo5PJBUOGCTs/SuNt0O5XSQFKhccaxFdYIeNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELeABIZq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELeABIZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A14C4AF63;
	Tue,  7 May 2024 03:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715052242;
	bh=wwRDMK2MTHyfmFutWwVpB0wuAlNULl9BsyJ4npcXu/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELeABIZqtUy5w2w+CIgX5YOv+COx2TwYQUIsI3SescFNSB292IcSt+SPewSdMlnfn
	 Ikq5cZJzk3eQFXGpXj6LHOickkuBaI6J1/GsVYxxrRnBInOlmk+XOTWyazhYZLmeiF
	 b32PBXwe/tMzdiS5zviboUxiBHYzgIwfhzuuhDjqpd1PqzgNVgaMQN7LepaZypY6Cq
	 I5QB8ZlGHhdaCiVzggV33hdBFqgxxx/6/oe1kmWeTNipIiRPbYYhDjwpBq98j/EHu0
	 EeWKQWw1/wW5/0uLj3YIcLigubjqTFJYoc+iuj3QZK7mU0YdhqPwQ8qT9w61FHADpq
	 jMYKPMQQ6Crcg==
Date: Mon, 6 May 2024 20:24:00 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] objtool: Report section name in
 elf_init_reloc_text_sym() warning
Message-ID: <20240507032400.gxorrjm3q7mg5cac@treble>
References: <20240506155537.it.760-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506155537.it.760-kees@kernel.org>

On Mon, May 06, 2024 at 08:55:54AM -0700, Kees Cook wrote:
> While tracking down issues with LKDTM's .rodata "function", I found
> the warning from elf_init_reloc_text_sym() to be unhelpful because it
> wasn't clear which calling path it was coming from. Report the sec->name
> and rephrase the warning a bit. Additionally check for NULL sym->name,
> which may happen.

Hm, as far as I know sym->name shouldn't ever be NULL.

Though, looking at this code again I'm realizing that 'sym' could be
NULL because it refers to the symbol for the function's *section* rather
than for the function itself.  And sometimes the toolchain doesn't
generate symbols for some sections, if they're not referenced anywhere.
(Note the code immediately below your patch actually makes a section
symbol if it doesn't exist.)

But also, this warning doesn't even need the section's symbol.  It can
just get the name from the section directly (insn_sec->name).  And it
would probably also be useful to print the offset (insn_off), like
".rodata+0x1234".

Though, even better, we have an offstr() helper which can pretty-print
the name of the function or variable, if one exists at that address.

tl;dr, does the following work?

		WARN("%s: unexpected reference to non-executable '%s'",
		     sec->name, offstr(insn_sec, insn_off));

-- 
Josh
