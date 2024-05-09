Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499131A2C35;
	Thu,  9 May 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277272; cv=none; b=lF/FEjSrvfX9VnTOCaRsmx8T9M9v2RSex30R1DF573mJJIFcmE0rt5DPKcIEWcF1NXDIAbTBjquI0aeCTmHFfmAmOsHXtM2IDajE7jOkVmD411ak8GSvrcpF/9I4jcfFg6/E/g4txeqT43Hkb9rtUWJPBEqFL/uXGz6kV2zwRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277272; c=relaxed/simple;
	bh=+bcJRbV4GT1PA6vhESJmH/6HNcsCAh4o5jrInzigEjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwYT9zxNLXZI1DRi+JTgnJAqnaBvw7g0+xMsvqGDwogQemk/LY/FE6MHs4R/pXqXF0dlo64AZM/DkX1tCz3pkElVZpgOFd4tkcTPXU4OLnSeEbtN1CezGlIv8OPuykenN7bCc0FKvmOUTGhQUoonL9tmj+VXuBUZmSoBXoHS6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SoOzZCic; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SoOzZCic"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=od3CEJrhje5agF/aqQd6TctGDFUrEkaEPS1ndedOerw=; b=SoOzZCicszp7wfFaYTZ73pqT4b
	B/kbl5+6HK5VMkd/ulc83gBc8GGY3ZzioOR9NDem1mogYcfBzTE+2hBHekJtUgPZ1TYsdnQwsDMZv
	5V6HBevZQHt2dTW8MEM5jrmkvy++Ujxb6SS0TDep+m+xUZHu+XnQiLr6ndWXAQfdY3EU4ZpHiYf9K
	LeKTqq4hp2rKFLI09XDzmbc7PSCV8FiP2SsS7fVJAfesEadKI1RkFEWrh1IoIDYn7L925Bmxvx4GU
	TT60rXqDwO4KZgkUKJDEDysdTCFguOnxzIlImaSo9mkjuVvtkhySG7F7Prh9s0FNMsrDIQK5TYm7h
	Dr0PHwtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s57yD-001QjS-37;
	Thu, 09 May 2024 17:54:18 +0000
Date: Thu, 9 May 2024 18:54:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240509175417.GR2118490@ZenIV>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook>
 <20240509140854.GF3620298@mit.edu>
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 09, 2024 at 08:38:28AM -0700, Linus Torvalds wrote:

> Going the other way is similar:
> 
>         all_bits = low_bits + ((u64) high_bits << 16) << 16);
> 
> and again, the compiler will recognize this idiom and do the right
> thing (and if 'all_bits' is only 32-bit, the compiler will optimize
> the high bit noise away).

Umm...  That would make sense if it was
	all_bits = low_bits + ((T) high_bits << 16) << 16);
with possibly 32bit T.  But the way you wrote that (with u64) it's
pointless - u64 _can_ be shifted by 32 just fine.
