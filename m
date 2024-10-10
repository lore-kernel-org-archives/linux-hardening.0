Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D41CBEAB;
	Thu, 10 Oct 2024 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592443; cv=none; b=Y+3TeYIBUp6n8o8ez99eKUtit6MTaLhrBcn2s/WV5HsquqsTCchT4K39LC63UrDOJU1PNKMIkMgz39udmtRFPP5eUokNnJmkHe8odOEWdF7TSS1Y0s4QVp4cjiTOiXJHeT/01+mWBzLd1p7iKwPoUHBjQ+FE/roH07wtZbDd9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592443; c=relaxed/simple;
	bh=YKZj/XTEQO6/ExapwB6E61thnS2N1ToVPwf4sDQ08PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmWLhrJ9sZEULNUqrBVF9GJh5i9gN2+5JbGQo2Z6yOeZsu5Yy2vHVVlus0HZuMWkME/VrN/DzBjwnI5cJFCugKCAkXZsBdYguk5rVpKN/LYTMSaiwkHcdN0B3gQvS0QwhlX8/cxy71EsoXlGEMyffqnpRxMMP2KEb38Abfs8p9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZlPvTIh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZlPvTIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8AFC4CEC5;
	Thu, 10 Oct 2024 20:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728592443;
	bh=YKZj/XTEQO6/ExapwB6E61thnS2N1ToVPwf4sDQ08PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZlPvTIhyqc+fXAUZICy/X/w2oe70HN42HsHd2MHL2csiZL8TtKP8e96QVq/gZCYq
	 uRmqKpGHpmzBrCwc+EKngcQVaWocI6qTBk1C3P9PDaqloImSuW9lCy162oQPSxApWz
	 mK7e4/YCF4hvzlJ0B1Wz7oCFM6b078UZfuvCyJX+LpzSRN9w4Ek7C+ZtG4qmdmnwW5
	 kmYXovtN5byVqHh7oz0LzJTqCb37b2VJ75pAyKva4MGVy5J8QGffvSFgsavDsR84dn
	 vW9HED2Q8UgVHViMHbEKtkVTkAAdVmafO7fVqv1jVqHo/8GTtYKjcXMLD2XasFGaXt
	 n95ssK0oN4rUw==
Date: Thu, 10 Oct 2024 13:34:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	nathan@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 5/5] crypto: x86/crc32c - Tweak jump table to validate
 objtool logic
Message-ID: <20241010203401.45ds362dpx52ne5z@treble>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <20241010122801.1321976-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010122801.1321976-12-ardb+git@google.com>

On Thu, Oct 10, 2024 at 02:28:07PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Tweak the jump table so
> - the address is taken far way from its use
> - its offset from the start of .rodata is != 0x0
> - its type is STT_OBJECT and its size is set to the size of the actual
>   table
> - the indirect jump is annotated with a R_X86_64_NONE relocation
>   pointing to the jump table
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

This needs more "why", I assume the goals are to add the annotations +
confuse objtool if it doesn't read them properly?

-- 
Josh
