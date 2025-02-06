Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FC22257E;
	Thu,  6 Feb 2025 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877676; cv=none; b=ntKod5qmZ/TZfgL/BAx4t3R9lXzLRj4ttnx0zkIJF9k5up5VlTM7yqEuvFHkffETizRcTyYrhfqLdxfNVT2a49BnRFbJ7UScaNOXfLRMFiekiYFjLgJx3/QdlfuwHEywWrnv/fXhyufQt0HDLXkRv6bNKJbshiJYwMIGYee88AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877676; c=relaxed/simple;
	bh=BU8/9ZrZRphAqMAbRakEUnZqvXDTNsJBwDy4oWe2YyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0FnUM+2S+dUIMEQkKcl2oNtr/ywtKWUi4Uo8l5G8FHmht4rSuQTuI61PYTiBtjd8AYvVohKwVMFtCaaC9D5RoVs7I98PBKvAYyAjc1C1x9xHrR5DBO+4tggzoIemErlzRXOkBUJUOpqcT6f73tbn6gKPCYfTz4hOn8IhLzk0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfUue+5l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfUue+5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8248CC4CEDD;
	Thu,  6 Feb 2025 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738877675;
	bh=BU8/9ZrZRphAqMAbRakEUnZqvXDTNsJBwDy4oWe2YyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfUue+5ld7dZBKCSCZ7h7h13CQoXymaPelp6hxSfzICo7frrhc3GSRGUvMww6jdY/
	 sWEtGdXoqbNIpdSY8YoIaS2YQdKiwDxtGpT5UQ9RXa+a79MgwriJBLXqWyR44Xncsf
	 HxFkKyTtRYzqIucK6mQQQ4rocBgog1h3D9xsHF4ZcjL2m0p2scYeU4QxMi9W272Pxo
	 c7eyLTrW0E/UsUh421NQ4FkDfqt5/JNjEkf/xF8RyZBSe6op6qdzNcc239J2szAg5j
	 BatSDCqcmR0VhIxn9q5sMC70gAJ9WkF5kcCmM4MzMMk+XD07WyegBJSRegrkGSG3An
	 m++GifmP/c2dQ==
Date: Thu, 6 Feb 2025 13:34:35 -0800
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
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
Message-ID: <202502061333.302D4EA68@keescook>
References: <20250206175216.work.225-kees@kernel.org>
 <20250206181133.3450635-2-kees@kernel.org>
 <20250206195658.79231973@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206195658.79231973@pumpkin>

On Thu, Feb 06, 2025 at 07:56:58PM +0000, David Laight wrote:
> On Thu,  6 Feb 2025 10:11:29 -0800
> Kees Cook <kees@kernel.org> wrote:
> 
> > In preparation for adding stricter type checking to the str/mem*()
> > helpers, provide a way to check that a variable is a character array
> > via __must_be_char_array().
> > 
> ...
> > +#define __is_char_array(a)	(__is_array(a) && sizeof((a)[0]) == 1)
> > +#define __must_be_char_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_char_array(a), \
> > +							"must be byte array")
> 
> If you are only checking the size, perhaps __is_byte_array() would
> be a better name.
> (You've even used 'byte' in the error message.)

Yeah, fair point. I went and forth on naming. Fixed for v2.

-- 
Kees Cook
