Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD41F37D1;
	Thu,  6 Feb 2025 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877197; cv=none; b=hgkXY9tShbmdDzoFB0rFfibQc2jG4sBup+uHq1kBLzEVMDKWJKz6rJBEthS5XCv9IUeJdpYdJO+Rv4tinU/aEiRfAKJRwnYPE/ukWS2KLmc1jjuq41wf0S6IsNyIXZD+z7gLU+nTJMy7nokrDDXwI6AYZCLkr64eA+MPpqX+Rnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877197; c=relaxed/simple;
	bh=fk8HWppYeTcs835mEAIuFxA8Yt14dn1JcVFbYpsrbw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4o9LQGfeFSnNnScBmXhFcWxDGu87amSXp919s4UfdJYOOHxLUkQPwsopLwMrn7tI+JGPf854+ow8iDUyufrUTeQ3o8TXmIoc/EZR/KjjL3lvOKy7Aln6exvNax7oLhfg5F8o0mFdOF9b+fv/ntZqe29tWxfeRgBjKAqifr/NVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4F7iywp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4F7iywp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FD4C4CEDD;
	Thu,  6 Feb 2025 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738877197;
	bh=fk8HWppYeTcs835mEAIuFxA8Yt14dn1JcVFbYpsrbw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4F7iywp1bj8uqZOY6ETW16C7F5xCIMqC5Ir3Ix8vzUImOf/GqalSZh+lGU/GIZK3
	 vfhpZccwIlGypMVDTOpvtzdzaNzNrk3f3r2s752w3nh+jTjUY+bNgm0ymIZs2gxWum
	 HPK8kiL0HCssjVIzwSHot8KPdYAs9N145KEdvsIO7FivZ5dAtiCalcu88D9RwAFMlj
	 W3pvMgnxdxhN3XAeEZyol66rdkcs+ktU3CJAAQ14jpPZIWmX7rEPW5kfkp7Lou16YB
	 DIRHxzx+aCpdetMObcBQiuhbNmmmfu4WuXDqdKCQBKbr5BGGz9NDgv5ahFOgJMcFPH
	 rG1DjkH+7CbkA==
Date: Thu, 6 Feb 2025 13:26:36 -0800
From: Kees Cook <kees@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andy Shevchenko <andy@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] compiler.h: Introduce __must_be_char_array()
Message-ID: <202502061325.16B973132@keescook>
References: <20250206175216.work.225-kees@kernel.org>
 <20250206181133.3450635-2-kees@kernel.org>
 <wsa57yhzrz6wryqq2bjepfhyteqn5jnnsvf5scthkxz5yrayxh@q74gtz55o7dz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wsa57yhzrz6wryqq2bjepfhyteqn5jnnsvf5scthkxz5yrayxh@q74gtz55o7dz>

On Thu, Feb 06, 2025 at 03:50:47PM -0500, Kent Overstreet wrote:
> On Thu, Feb 06, 2025 at 10:11:29AM -0800, Kees Cook wrote:
> > In preparation for adding stricter type checking to the str/mem*()
> > helpers, provide a way to check that a variable is a character array
> > via __must_be_char_array().
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Suggested-by? :)

Sure, I'll add that. I did it for the ARRAY_SIZE() and forgot which
pieces came from where when I split up the patches. :)

-- 
Kees Cook
