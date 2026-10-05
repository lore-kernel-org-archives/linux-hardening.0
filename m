Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998E47125A
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197645; cv=none; b=PGC0aBQI6OjJMk5narc0YaRrH2te/pqfZijvW9uDaaet8zf53xFvvVfW53jmxAewcWdrxJiqLfmuTOJMd2FfM/vXUvdy8LXuo2OsVa2O1UhhdtuF2Yb0y7OY64AMUwQXpuDJ11kg3drq/vKFbFohVevHZ8C9g1+yCdVnQIQYvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197645; c=relaxed/simple;
	bh=paPXWUYsnV7ykCsbiZzaQNLH27n/4AhlQ1LYPVddCFk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hKgjQrKD/8AEMsLNVKdc+zL/aEp/U+Qa9GwRMWFvqJr5CSzzlhE/liZbzyTXx7yojnnGOir7GMJHo12cXuFhMpVjVOYeMg97u81jqvPMlyUAwOXX6L+HPCdHZ0Xmdqp/UND3n7Obh2fOX+ZpWJgCTFjMYFFJxRsrKVKlVje8FrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKTT4Ynj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKTT4Ynj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35731F00898;
	Mon,  5 Oct 2026 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197643;
	bh=X9RFb/buyI8n2HPvTUKM+p0nQi/e6u6dw5s7YNwYpLc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=hKTT4YnjfZafPj+ObvqjmrunS+uFiUV135chM3/vA4scqWvWKearR9W41Mp4TtR+4
	 +1E0dNGv50O2KZss1Ma0Gv9qk8hrmYhiIZ0j6HcYlxGmygvGAIdHiFshJ1+zd+dtL9
	 HLN0lSDj/Qvptb3zAMrXFFkl7NHykX/5wxL/mn3/MNVxqsw+t82r7vxRv9tZvjihC/
	 bYzsTjIMd/o9Ox5O2Ak2CiKGyfsx/vv1d9sGs1AMUIFluaNuNZsI+zOWvJuVn1jLPi
	 F435tAIhPrpgfJ7fjVnLp48laYoPb/84SZdm4SAvlaoH6aYUrgPZnuHPeeGCmVk3Fc
	 3PoQTxAnFg8EA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id CA6AA1980047;
	Mon,  5 Oct 2026 06:54:00 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Mon, 05 Oct 2026 06:54:00 -0400
X-ME-Sender: <xms:xoHDavkTYBY79n2X673zo853Qa_bdqs7aTHhEnQTyy8DTNK3pReLHQ>
    <xme:xoHDatoK9QuqOVeSVVV_do1ckRhU4Tn8FUPYbUpPhsokqaHUAstFoye7nJgUZhope
    aW8ws6ZFKCAXQWFZ8TJTapm6ZvJTgExi1RkbyQoLkVx6hYM2W2k3kY>
X-ME-Proxy-Cause: dmFkZTGLdks8gB5Qx52BxQMp2/Yz0QHw5YjDPkSdp5TVhyLY6N1QLaTIp3WlWwACde0uTa
    BW/cgz4w3Ngk+7Dz590jcvc/Jlsa8+h8dlnnRkMjcj9dHpnhfjYs0Pe9lGJzr2bi6xuEEx
    ug7LDOpWoA17Q+yMpPx9AjIn53uNCUdtNogGRkAScebNJG1rGch4dmbUmpheHwaZ1+RA8s
    r2dayGEuj6i0XAOQh/7+s7xTGHzks1ootpmN8phOQ4gusqHwJqyy4YSOR8g7SMUTiVlbqa
    UJ2iDm6MN4R9tpj+pjQpGao33nGpLApaJG3edt4wmWkRXoV9AbA9Wkm3kAAoIQlKvmpGp7
    HMds26gPzwLhslCAvmDcGPGD/pyAWDiP9WPANbErSY1951zw/fEy7rD5Lb5V5jy+qeAN/9
    OfJVzSPLLIUUeA0hjttWMZFhqTS0cf1uMpNBzj0+4TQ2Oo6VDWD5euJpdo5AlDdqOvecKw
    0N2yUin/mAyewFOHpQNYcJA9cgI42Mfi4CQriNOR/ND+mJ+7eL8b5RcbCQYkiCyjDUYKYz
    3oHj8OHFybwR+PdDNcYqPMkdTqcjcbO0RV1W6j5/gvwaPTMnQL7skNEbxf8Ly54W/kZEZB
    KizkWF9JaM+o1ZvI3qnn0RcZiSS84ziaGIX13aJR02vvfJxSb1v+XMhaVFQg
X-ME-Proxy: <xmx:yIHDahXmHc2v2zh3U__P_pVXnIVgy0G0vyT6sop-aS_k6GEEOr8ybw>
    <xmx:yIHDar_pAgthej9WeR11jtT4SIP7NbiEpzi6jwhDRRlSWBtHejTYxg>
    <xmx:yIHDajjAGRk55Ye8y4d22eyGrs2A6kvvRLN_tG7ikoOexV3zmYLsew>
    <xmx:yIHDavdLsLF-GNY4GTJQs6EjULKFqtzoG0hkQ0ais2TLhZtj53AewA>
    <xmx:yIHDakJHL9oVYivuwruHtD9uYFTsiQ-n8o7PpMsNHfRVC0wmn0WUjtZk>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3A33AF80086; Mon,  5 Oct 2026 06:53:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 12:53:36 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Bill Wendling" <morbo@google.com>, "Kees Cook" <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Mark Brown" <broonie@kernel.org>,
 "Marco Elver" <elver@google.com>, alan.maguire@oracle.com,
 namjain@linux.microsoft.com, "Peter Zijlstra" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <ea6e022d-e04b-42e7-b526-ac96559b3633@app.fastmail.com>
In-Reply-To: <20261005102518.2400984-1-morbo@google.com>
References: <20261005102518.2400984-1-morbo@google.com>
Subject: Re: [PATCH] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Bill,

On Mon, 5 Oct 2026, at 12:25, Bill Wendling wrote:
> Code that runs outside the kernel proper, such as the EFI stub, gets
> nothing out of the counted_by annotations: the bounds checks they feed
> (FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.
>
> The annotations can also break the build. A __counted_by_ptr() that
> names a member declared after the pointer needs Clang's
> '-fexperimental-late-parse-attributes', which the top-level Makefile
> adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and does
> not get that flag, so it fails as soon as such a struct is pulled in
> through a common header.
>
> Overriding the macros from a Makefile doesn't work:
> 'compiler_types.h' is pulled in with '-include', which is processed
> after all -D/-U options, so it re-establishes the definitions. Follow
> the '__NO_FORTIFY' precedent instead: let a build define
> '__NO_COUNTED_BY' or '__NO_COUNTED_BY_PTR' to turn the corresponding
> annotation into a no-op.  The two are kept separate but parallel so they
> can be folded together once all supported compilers handle
> '__counted_by' on pointers.
>

I'd prefer a single macro here - if there is ever a case where we need to
turn off one but not the other, we can revisit.

Otherwise, this looks good to me - thanks.
