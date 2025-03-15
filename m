Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC5197A8B;
	Sat, 15 Mar 2025 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742072793; cv=none; b=YPvidTE4WKPq+AtIfZ8JHXwscgjKz6nS0O+RNqy6M1Gdd+G4FU++bw8Xv0XsuVI4j4eovREDbQEo2c/S0mgUy3dmMHPNSqFJkFYMpXxow3QThcta4MwESif2pperoiVtcuvPQf0rqh9G9urasBZCNZjTUBdXNiBZ39vrvFU57iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742072793; c=relaxed/simple;
	bh=FlVJ5imhiRn5VNO/DGLrnhEKpXT0naJJHp+CyhtqAnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxzGhn8nQKQ663hKCQxRSTwtOxx8mHkc0Srlg1VZoCwf9xEg3uPFhEkvhtVZgKnUrmC6d3I8EFvfrg0f4fwXikGooZsk8jAt8dU2yxqv9hODG1SwBELRpLLD/8G6G32IYhuzLjPOU14dFz+fwVjnPK2w48Ph0ANffVMqlzTjE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7OUHnKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7OUHnKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B742C4CEE5;
	Sat, 15 Mar 2025 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742072792;
	bh=FlVJ5imhiRn5VNO/DGLrnhEKpXT0naJJHp+CyhtqAnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7OUHnKiyKxWr0I5xGDO00+zloOUoQb89kqHTzRB/UHC9H4fwDtdAQrjnn6KRMZBi
	 NJ7nzhBNwcc3OK+0DZcl9bTt3PN4WRcYlXrEf9m4MPx+20B8QGr0vPtvn3fiJxACUt
	 o4iBTl6yuBFZYYcn3NkzCVAQd7bC4jVnOJ3GfpaoSWRmNukbz9iBdTUdIK8ZwIIqIW
	 FxgyYwmNYwG+P75RvFXpCZp8OnQQVCZiQsgd7nhjcKLa/k9kt87L5X+1UIR+L003MJ
	 AZNxCoUT97vK6iSUOSU0d/JYxe9dviOpL6UGaANvPg6YZ6JLTED3e1BP4+u6u4+TlK
	 RH0Q9AdZL2ThQ==
Date: Sat, 15 Mar 2025 14:06:29 -0700
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-hardening@vger.kernel.org, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/2] compiler_types: Introduce __flex_counter() and
 family
Message-ID: <202503151406.19A299AF@keescook>
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-1-kees@kernel.org>
 <CANiq72ki=h4YWBWpoTpZz6525Cdt38aFN0kFwW7dJNPcVi_m2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72ki=h4YWBWpoTpZz6525Cdt38aFN0kFwW7dJNPcVi_m2Q@mail.gmail.com>

On Sat, Mar 15, 2025 at 08:47:46PM +0100, Miguel Ojeda wrote:
> On Sat, Mar 15, 2025 at 4:15 AM Kees Cook <kees@kernel.org> wrote:
> >
> > + * clang: https://github.com/llvm/llvm-project/pull/102549
> 
> That is an unmerged PR -- should we link to the merged one?
> 
> Or, better, to the docs, since they seem to exist:
> 
>     https://clang.llvm.org/docs/LanguageExtensions.html#builtin-counted-by-ref

Ah! Perfect. I was looking under builtins and couldn't find it. :) I
will update the link.

-- 
Kees Cook
