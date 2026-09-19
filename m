Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A283BED0C;
	Sat, 19 Sep 2026 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781119; cv=none; b=sjI8JFPHhw4TlXaQFIAALTyZuliLLuKDusb6tvOZR0ccsGTa8Skcw7Q3q+5+C9mot08UDeZI9RD1A9N5aRIqwkSZIjGnB0/QhK6/hZrs5zvWoUXRWpP3jrP74obiOiNyoM+/uKoWWZzpnMvaKeiUz2HYKBslb1Up4Ksm5WzeVO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781119; c=relaxed/simple;
	bh=sW8LAabRtMi7YjGwCMGPwg2ShjK5jkGqa8EGtT86epM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJzeJOPP/Zp7LgTq+HKT2XIR96Rmrb/LQQXrBOP98WcSgTwSqnZcQAw/HlZK70bgkMnK2J3QPOvNO43bxI6snYFVwQo19exRZ6DnEe0KefFPYtdljbxE8LcjTnZ4JgqDXLlbdvUiPlnpqAJnYBFT9OjMfE3wtw02p8bI2ykbF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEf2Ol6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEf2Ol6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C7E1F00898;
	Sat, 19 Sep 2026 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781116;
	bh=AbYCY2WgHSC4hbcqAXOJT5LHiyRzS/vszkU3nmsXVuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NEf2Ol6L07Mcxykp28FXba/Qsk6fnNBABrt5KBs4PLBujFi1qoyjHH6moLgkGLgCZ
	 kq2VtnXwqe8a58OxYDP65yxW33W7XKtOLEA4tQgfoPkfRD7/cIdlF2304aAZDd2lu7
	 Qpr6mYBdukg4aA+hRd0wu4hoCbV0cuMgOTpJIO5QBiXec19zXAIrAZZA9k2eWs9SaA
	 WWESZVTp0gFpKyCzI0pdnMAaYjj3WBa1ErwoW+iZXVKmXKwRxHWGgZqQawJH9nLggv
	 nI9TgH2pKYDrFYcDROemk4l5pcsLBnqLJZmiI+xTmKjUYNvDi7dJC3JHYWfmzHeF65
	 O7T9f2mJIFUCg==
Date: Fri, 18 Sep 2026 18:25:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Nauman Sabir <officialnaumansabir@gmail.com>,
	Tejun Heo <tj@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Matthew Maurer <mmaurer@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	Graham Roff <grahamr@qti.qualcomm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, Gary Guo <gary@garyguo.net>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kconfig: Introduce cc-option-str
Message-ID: <20260919012508.GA3573999@ax162>
References: <20260919005923.i.879-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919005923.i.879-kees@kernel.org>

On Fri, Sep 18, 2026 at 05:59:24PM -0700, Kees Cook wrote:
> Hi,
> 
> While reviewing the recent build speedup series[1], it became clear
> that we needed a general solution in kconfig to avoid repeating detected
> toolchain options. Implement cc-option-str and ld-option-str, and while
> at it, create "def_string" and friends to match "def_bool".
> 
> -Kees
> 
> [1] https://lore.kernel.org/all/20260918054058.GA384222@ax162/
> 
> Kees Cook (3):
>   kconfig: Add "def_string", "def_int" and "def_hex"
>   kconfig: Replace "cc-option-bit" with "cc-option-str"
>   kconfig: Add "ld-option-str"

Thanks, exactly what I had in mind. This seems reasonable to me and
passes my basic testing. I will let folks chime in for a few days then
apply this to kbuild-next so that Lorenzo can use it as part of the
speed up series.

-- 
Cheers,
Nathan
