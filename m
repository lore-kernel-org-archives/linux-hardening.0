Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84E271A94;
	Thu, 15 Oct 2026 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041539; cv=none; b=EktNflyMmjbrY/SLzI47z4fIYeMANm5Y5al1rTYaOzpW5DBI3K0Y50jmYaJ1trkFwBd15nuw4hqY01lscJXTvYO/piazc/v+jWMH2oG7THLEaOrzNB+3DBz1MU41yU2+fEsyAvQuqs8G7H7jTeQ3K4b2dQ+QaTxvqK1LOiTrhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041539; c=relaxed/simple;
	bh=ymWE+nEaUpdY7svPzGIY0fesccjJQWkcBebf3MzLR7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOh1K55OdjdMWWOwksB6mx+3zqwpriHiwFR8QUdT/ixvc98rkvxSaNqPiuBBqM3MzYXd0rBAaaoqmWxy2d3aU2njPF0/pTGvb9r6wG8viKtr0sgJQc1ZRL/j8XpuXUgA0Edq77+M3yfFMOsISy5KIUdseCcIc6VBJSHkLGVNFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y7mJAQHH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y7mJAQHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2829B1F000C4;
	Thu, 15 Oct 2026 05:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792041537;
	bh=yzkuiALK4hBeasChiOfNDXHmHKuEkzeg8AJfPU9FbHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=y7mJAQHH1w4rPUzSKg/P6IAjiSpHrN+LYncNMwm7kiU/RDdZGdEYophOOakLKQ2oI
	 rZg0T1CHHqTRO1hjiOR5CBzitQ4AGonI5ygyLEPSJYvicthcxoB2RSbNfVz+UW1XqD
	 lGW3rffCSZcDFLb9hUGTrn9Tg5ruEWV8JMODorAI=
Date: Thu, 15 Oct 2026 07:18:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Ian Rogers <irogers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	llvm@lists.linux.dev, linux-doc@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] Compiler Attributes: Add
 __require_explicit_initialization macro
Message-ID: <2026101547-silica-ferris-1389@gregkh>
References: <20261014225811.i.852-kees@kernel.org>
 <20261014225818.3457479-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014225818.3457479-1-kees@kernel.org>

On Wed, Oct 14, 2026 at 03:58:15PM -0700, Kees Cook wrote:
> From: Ian Rogers <irogers@google.com>
> 
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to indicate that a field must be initialized explicitly by the
> user when the object is constructed. When an aggregate initializer or
> uninitialized variable omits an annotated field, Clang emits a
> -Wuninitialized-explicit-init warning (enabled by default).
> 
> Add the __require_explicit_initialization macro to
> include/linux/compiler_attributes.h (which is included by
> include/linux/compiler_types.h and include/linux/compiler.h) so kernel
> structs with error-prone initialization (such as mandatory callbacks or
> cleanup handlers) can enforce explicit initialization at compile time,
> as discussed at the Linux Plumbers Conference.
> 
> Also teach Sphinx (Documentation/conf.py), kernel-doc
> (tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
> attribute macro.
> 
> Link: https://lpc.events/event/20/contributions/2392/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
