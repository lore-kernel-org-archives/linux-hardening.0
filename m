Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F393290BA;
	Sun, 20 Sep 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875615; cv=none; b=odfVkvuCrDR+679XczkPvRp7YD8HOFLto2M7tgDXNo+Cm6FDKs3W3rT2nCikAskdPX383I7ZBX2rbRiLpabR4iiRWvONG+lS4yiu2n5AHadHDvx3rtjiIpKEqVyM7QXRO8+gd6luF9s9blXKIN5CO98UNZ/aiJFPGKQTpkuATzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875615; c=relaxed/simple;
	bh=qwQk9vtqP0VEut62xsZiVVfIbhewJRdN+j4R/s+JLp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu/7TKlzQZLu1YOSIRQ46yizlkhJK0l+Z4baqzrbAbXwqVhVP9YfoERzKJ87laX3xUVedjJJCNuxDJmDxdG6Lvi2d7yse9XcbS3wX2kAlYHLmbaWpR8IZaNecRmGPStRkwGTVapLQrlNPBHiWm5zOHoF+ui2Fd08YfH5/yYflrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4RRHl9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4RRHl9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3878C1F000FF;
	Sun, 20 Sep 2026 03:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789875614;
	bh=L8A0Eu4Tzsml4qtZgCltb1eRTxyA/6ITE9mC3679vTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S4RRHl9SI1RgcnsjFgXzDPcD60W0VLRt9fnQ9fDZR0Ui2b89B8Ua9GHXwHXrE3B6p
	 0ugCHbRUE3XTObO9Tpt2rqq5qsI9wBk6kDYOaQYgY0tdhyKrBwdODse33bfKiQPr4T
	 yAi34aOOdhIgNNFVYFYf5uuj7VmR8q7XtgBF8tCVkHJ1ae4DfwMSivOsNGb96n+HgD
	 jiryUoHQ1Zz8cC9PJ1g44z9aYgqMD+sM74XcKX58WC4uEq6hh2kn7hafyiCcHACLs6
	 W7+7zaG22aofq7p8ngm9+xGv1NkGq6u2fGXeXRfSoiKJ+RjFfGKpg5o/fb0324AaE0
	 ieE7TUCmaBJJg==
Date: Sat, 19 Sep 2026 20:40:13 -0700
From: Kees Cook <kees@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Jones <andrew.jones@linux.dev>, linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Nauman Sabir <officialnaumansabir@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Matthew Maurer <mmaurer@google.com>,
	Graham Roff <grahamr@qti.qualcomm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, Gary Guo <gary@garyguo.net>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	conor.dooley@microchip.com
Subject: Re: [PATCH 1/3] kconfig: Add "def_string", "def_int" and "def_hex"
Message-ID: <202609191431.C3BCBCD@keescook>
References: <20260919005923.i.879-kees@kernel.org>
 <20260919005929.4077729-1-kees@kernel.org>
 <cdebaad4-00c2-4b80-b688-0f5a723d6009@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdebaad4-00c2-4b80-b688-0f5a723d6009@gmail.com>

On Sat, Sep 19, 2026 at 04:34:54PM +0100, Julian Braha wrote:
> On 9/19/26 01:59, Kees Cook wrote:
> [...]
> the X condition here only applies to the value of y, but not to the type
> declaration of bool. Besides hurting readability, I can imagine a user
> making a mistake by attempting something like this:
> 
>   def_bool 'y' if X
>   def_tristate 'y' if !X
> 
> thinking that they're making the type conditional. Of course, the
> interpreter warns if this is attempted, so you won't actually find any
> of these in the tree.

Yeah, _this_ case is warned on, so no real issue there.

> The second problem, is that since the order of defaults matters and
> conditions can shadow each other, def_<type> makes it harder for users
> to get defaults right. In the past, I've seen several config options
> with bugged defaults due to 'default' + 'def_<type>' [2][3][4].

This is the one I, too, got worried about. From your example:

 config GUEST_STATE_BUFFER_TEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	prompt "Enable Guest State Buffer unit tests"
 	depends on KUNIT
 	depends on KVM_BOOK3S_HV_POSSIBLE
-	default KUNIT_ALL_TESTS
 	help

Is there a way to detect this state? (I assume as a follow-up; it's a
general problem.)

> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Tested-by: Julian Braha <julianbraha@gmail.com>
> Reviewed-by: Julian Braha <julianbraha@gmail.com>

Thanks!

-- 
Kees Cook
