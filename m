Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5DC1CEAC7;
	Thu, 10 Oct 2024 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591333; cv=none; b=jUr7hmxez/b3j8nqBumM4dSSWy3LC5ZWBgphHVnWWJFa1PgGvgmqF6vDoQJkx5poKCSB9rALRTYEn8xKYchHreckHg2P/71U8cPOgh8v5PIVhiUO6nYii+RG0TFDrXUz/bCP5NC8C9571BCw1ksQRqz5rI5SSuukD8RVwCnsoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591333; c=relaxed/simple;
	bh=ovbXemj+qcoLWFkFIzpI5wSr88+vOHJTOZcshL8GFfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMnSuRuGjV70UDv+RByh1mXR7W1z+QNW/qFuNJQmM801rioQs7Grv5nmdwdZBmhQQX6BlSMbermD4RBUqaQ8Fl5RGGctnQwaOtOrS6/SaCf8/i4+eVK0tj2xqVt4Nug6ShsQ+sKCaFxA8Jud1nf6dC3PveJnlRZ4vtH+HE4Kl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNlsx5Ra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNlsx5Ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91426C4CEC5;
	Thu, 10 Oct 2024 20:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591332;
	bh=ovbXemj+qcoLWFkFIzpI5wSr88+vOHJTOZcshL8GFfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNlsx5RaDzZzVvzzt4OAoToR4GUvAjjtKaHSnjBikv7muW9bSh3Qh7VPd1TTQBCNd
	 wFYZC6ZTkjokBjqyEYMkEc6dsE2B8KXSKx9aPKEKWyI9V9BeGCCWGYy1ONqJyBkkgE
	 XDj4iCEY4u8jRhg5NcZrxJ2JKrcIv9HxXpsZhKMtV0fzFCBhPiuVWZnf/vEQoNki4G
	 gl+gPssb2wtfsNg8cIJmE1YQJheL05E4VcJ2fY39xP/CrW8t3d24cZ9Lp7Ea9uwUHI
	 GRcymBWpqxpJUb/qxsv3MNNXrlbgx1H7F33+bDSndzt7LK3dyi434GTYBxXJdAuHUL
	 hbyTKxs2xZOLw==
Date: Thu, 10 Oct 2024 13:15:30 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	nathan@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 3/5] objtool: Add support for annotated jump tables
Message-ID: <20241010201530.6kfvlcdplqhrqjbj@treble>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <20241010122801.1321976-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010122801.1321976-10-ardb+git@google.com>

On Thu, Oct 10, 2024 at 02:28:05PM +0200, Ard Biesheuvel wrote:
> +++ b/tools/objtool/arch/x86/special.c
> @@ -115,30 +115,51 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
>  	struct reloc  *text_reloc, *rodata_reloc;
>  	struct section *table_sec;
>  	unsigned long table_offset;
> +	struct symbol *sym;
>  
>  	/* look for a relocation which references .rodata */
>  	text_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
>  					      insn->offset, insn->len);

Hm, we can probably put insn_reloc() in check.h and use that here to
take advantage of its caching for the no_reloc case.

> +	switch (text_reloc->sym->type) {
> +	case STT_OBJECT:
> +		sym = text_reloc->sym;
> +		break;
> +	case  STT_SECTION:
	     ^
	     extra whitespace

-- 
Josh
