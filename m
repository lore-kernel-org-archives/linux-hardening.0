Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855702877CB;
	Wed, 25 Feb 2026 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004813; cv=none; b=VqlhGp9b7rqr1VlmKUNjJ8nNbYSZdw8CT+Qe6Upkd64UV6ED8M/Iy4usp+u7ghufKbOpkY1kIv7KzymZlphe8T14WWxtXWa3CHFgsi+WVg0Z1gNcCEfV+GsLmbxEEOQ5hZfBmw+9qM2F2xRYuRbGdtyLJF5WA4FcPIu2qFq6/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004813; c=relaxed/simple;
	bh=hnzpbKoQk/zosIhCAu9Cx/mjFh2R7stlR/nxdxvXWMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8+2h5FKIEKR05YtZOQHhhHCEUsr9vRt/GdfLkj/wXEzU2E1O4Lie1iAlYOPzFeej12qAJUIRzA7n/eb4odhWPqI4PIv0/uBOslc49JT5xcXUxcwEtI/oUohIyN0Du2J9KZJjj1bSMCrWkyyzW8WIRpgy4zlR5fdM5wbaD6q3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGLNwuMC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGLNwuMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDD7C116D0;
	Wed, 25 Feb 2026 07:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772004813;
	bh=hnzpbKoQk/zosIhCAu9Cx/mjFh2R7stlR/nxdxvXWMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGLNwuMCXzfAcdL4bigS+t8lXNpNx7Xte7XvuhuqogKTzLOk+wCf6CE8lsKE7wzue
	 Y7n/N6bliRtWmvz9iwPxw4Jn1O3dH7wEu6jBDMH2gIOgkcyNFsl15CC/Szalz7sA7e
	 0EoVn6aVHBgPgQd/vbnwP0E0F+MpCY5d4BgfdCxlb8Gim77Yck9bdIKsHYcFM5D/oS
	 jevMuZoCQh+Zj66GtJvcMHCqNCwFyzIoV0E0+4+ITBQ1eDYzdyc6OnGAmTb1AX9Lwj
	 BraEfc/bmMwMrNTA5x0WmBmsJBOOfFxaoPPkyNL5Jw+WAMbGG3V74zds5Q292g1yLF
	 I8kCWdLBTCMaw==
Date: Tue, 24 Feb 2026 23:33:32 -0800
From: Kees Cook <kees@kernel.org>
To: Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Build error in next-20260223 gcc-plugins/latent_entropy_plugin.so
Message-ID: <202602242333.24E5CB214@keescook>
References: <4051116.1771996801@turing-police>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4051116.1771996801@turing-police>

On Wed, Feb 25, 2026 at 12:20:01AM -0500, Valdis Klētnieks wrote:
> Building next-20260223 dies an early death:
> 
>   HOSTLD  arch/x86/tools/relocs
>   HOSTCC  arch/x86/tools/vdso2c
>   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> In file included from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> scripts/gcc-plugins/gcc-common.h: In function 'void debug_tree(const_tree)':
> scripts/gcc-plugins/gcc-common.h:417:20: error: 'CONST_CAST_TREE' was not declared in this scope; did you mean 'CONST_CAST_EXPR'?
>   417 |         debug_tree(CONST_CAST_TREE(t));
>       |                    ^~~~~~~~~~~~~~~
>       |                    CONST_CAST_EXPR
> scripts/gcc-plugins/gcc-common.h: In function 'void debug_gimple_stmt(const_gimple_ptr)':
> scripts/gcc-plugins/gcc-common.h:312:47: error: expected primary-expression before ',' token
>   312 | #define CONST_CAST_GIMPLE(X) CONST_CAST(gimple, (X))
>       |                                               ^
> scripts/gcc-plugins/gcc-common.h:422:27: note: in expansion of macro 'CONST_CAST_GIMPLE'
>   422 |         debug_gimple_stmt(CONST_CAST_GIMPLE(s));
>       |                           ^~~~~~~~~~~~~~~~~
> scripts/gcc-plugins/gcc-common.h:312:30: error: 'CONST_CAST' was not declared in this scope; did you mean 'CONST_INT'?
>   312 | #define CONST_CAST_GIMPLE(X) CONST_CAST(gimple, (X))
>       |                              ^~~~~~~~~~
> scripts/gcc-plugins/gcc-common.h:422:27: note: in expansion of macro 'CONST_CAST_GIMPLE'
>   422 |         debug_gimple_stmt(CONST_CAST_GIMPLE(s));
>       |                           ^~~~~~~~~~~~~~~~~
> make[3]: *** [scripts/gcc-plugins/Makefile:54: scripts/gcc-plugins/latent_entropy_plugin.so] Error 1
> make[2]: *** [scripts/Makefile.build:546: scripts/gcc-plugins] Error 2
> make[1]: *** [/usr/src/linux-next/Makefile:1316: scripts] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> 'git blame' isn't showing any recent changes..
> 
> next-20260109 built OK.   Any ideas before I start bisecting in more detail?
> 
> ????????

Which GCC version?

-- 
Kees Cook
