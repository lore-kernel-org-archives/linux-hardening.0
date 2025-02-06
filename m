Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED923959B;
	Thu,  6 Feb 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738869183; cv=none; b=dPVMNYzbUc9ydERiusbJY7YzsCpNuxvBitMfyoVAoSwV0OOqkG5PTijdD8N2ogyU1rsyw99UpX2yxwUAQh1qZliXGqOl62/k+k1SZ8+W/cOXGUMM71RQiFFJmRpJWtElonIKdep+AUSCbeMIwKCipBYmNhltDhNxTvmsyfsIH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738869183; c=relaxed/simple;
	bh=hhRBRUdqB9PgcJ8rttKlgxiZynWfr8f5RE3RGCNNA6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx9RNrvJNG+ktQsNWhN9YaqJnyFCQ5V0QFMWD3ZPnZ3J89Yi1W7tTp6JtlxMgLK+x9s8eO8PxS0E7H6kFRL3xCMxZkD8JQItlIKPeHsJ2G8mGxLnHEkVJrwXUKcCBTzaXWMjUNfrw99Xk/shsTjZOWxIDuqjL2bMACnnzLjyX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: c1DecBebRBa+bmgdE8hdJA==
X-CSE-MsgGUID: r8OMDaBCQkSvgWFfUE9FOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39189146"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="39189146"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:13:02 -0800
X-CSE-ConnectionGUID: 0Ysy79jQQiyrMYzoIz0tog==
X-CSE-MsgGUID: UFpXcEGvS6um270/TAk51A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148519631"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:12:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1tg7J0-00000008pGD-24HP;
	Thu, 06 Feb 2025 21:12:54 +0200
Date: Thu, 6 Feb 2025 21:12:54 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/3] string.h: Use ARRAY_SIZE() for
 memtostr*()/strtomem*()
Message-ID: <Z6UJtt2QNNAjSE_w@smile.fi.intel.com>
References: <20250206175216.work.225-kees@kernel.org>
 <CAHp75Vf=84tWvv57Kj5A5bLenQSkC5yDHTHy-u0iK1_U87nvBw@mail.gmail.com>
 <CANiq72kGUOgP60SaEwiBcgsDJnjdvJZ1VJtyf3a_+sQJjiffng@mail.gmail.com>
 <CAHp75Veo-C3A+XVr1RuFumoULWNOugN+CFE65d1T5o+TZSmw-g@mail.gmail.com>
 <202502061050.EC48F506B1@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202502061050.EC48F506B1@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 06, 2025 at 10:52:18AM -0800, Kees Cook wrote:
> On Thu, Feb 06, 2025 at 08:45:41PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 6, 2025 at 8:44 PM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > On Thu, Feb 6, 2025 at 7:42 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > >
> > > > What's the minimum Clang version we build kernel with? 12?
> > >
> > > 13.0.1 for most architectures according to `scripts/min-tool-version.sh`.
> > 
> > Okay, does it mean 13 has no such a bug?
> 
> It probably did, but Clang 13 didn't support compile-time error messages
> (added in 14). Regardless, this fixes it there and makes the API more
> robust.
> 
> > Otherwise the commit message and other comments might be clearer...
> 
> How should I rephrase things? I mention the bug and when it was fixed
> in patch 3:
> 
>   ...
>   benefit of working around a bug in Clang (fixed[1] in 15+) that got
>   ...

Ah, the version is mentioned only in cover letter. So, the patch's commit
message seems good to me.

-- 
With Best Regards,
Andy Shevchenko


