Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959E1CF2A8;
	Thu, 10 Oct 2024 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589933; cv=none; b=P3Wa1Y7K9HNIU82He1am57RFUJVqp/xCdUizxBVA/+p5nF508ZiE5GdBnxN0xrynTCfB1XGi41GuldHSXfhrgDzKP9R7IBnkPzFv+9r0nMrrxYS4eEK/jaSkUP9M2RjacAEv63u5V5C/rmJYToIGDmldZUwOsc4tSodJOwOb8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589933; c=relaxed/simple;
	bh=4PcPSnVpQIAzuHLA5cB0arAiAYZDpuk3RRZJZU+n8+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwGgwYahTXLSToQmZYv9ay+/+ypwXyPxCGtYhiuNQAw8p8zL5327RmouGZAXaY9Anjw4ApxTDvbnCVHNKTDzt33FuR1qHYzs270DULHHc3DwD4y7ex/wmJpVBr+3NhWhZRAhY+dFjOKtOx9e84FQj9LeymGvLaxNe5inJz9BtGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSFCUWI+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSFCUWI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD793C4CECC;
	Thu, 10 Oct 2024 19:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728589933;
	bh=4PcPSnVpQIAzuHLA5cB0arAiAYZDpuk3RRZJZU+n8+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSFCUWI+MdFcSN3r/7YfKB6VNMbt0lYSJIPOz9eXkpo6v1/8cjn1/GRntzZ/JH08c
	 A3Nur2bM20wNuLTlf3ICoNtbFzWGGSY/X0/6g0K6HVT/zcwdLrYQPCoKW8HBFtZaVo
	 OepEv3EBsJfq/acl5v4+F/Rz2jvCpZLZB8zcpuB6PTEY+RqZooM3EicuThe240zB0W
	 udHht+k41/slouJxu45H4xI3sZb2FV5dRs2tiyzfw5m/aYHlUnbTprx/0YpqoxtPfD
	 VpC28ZpWMlXYfbXVKbvQA/wf9tJ4g7md5fm8KHYuRDz8u7maB1yoRIp4gLhqO/y/I3
	 Ye6I7NjeQMiTw==
Date: Thu, 10 Oct 2024 12:52:11 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	nathan@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 2/5] objtool: Allow arch code to discover jump table
 size
Message-ID: <20241010195211.n22geblzb4ogxqcz@treble>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <20241010122801.1321976-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010122801.1321976-9-ardb+git@google.com>

On Thu, Oct 10, 2024 at 02:28:04PM +0200, Ard Biesheuvel wrote:
> @@ -2222,7 +2234,6 @@ static void mark_func_jump_tables(struct objtool_file *file,
>  				    struct symbol *func)
>  {
>  	struct instruction *insn, *last = NULL;
> -	struct reloc *reloc;
>  
>  	func_for_each_insn(file, func, insn) {
>  		if (!last)
> @@ -2245,9 +2256,7 @@ static void mark_func_jump_tables(struct objtool_file *file,
>  		if (insn->type != INSN_JUMP_DYNAMIC)
>  			continue;
>  
> -		reloc = find_jump_table(file, func, insn);
> -		if (reloc)
> -			insn->_jump_table = reloc;
> +		find_jump_table(file, func, insn);

Can we detect the annotation here, and if it exists, pivot to a separate
generic implementation which skips all the arch-specific code and hacks?

That way we could keep the "ugly" separate, and also have all arches
supported by default.

-- 
Josh
