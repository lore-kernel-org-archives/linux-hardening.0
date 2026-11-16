Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855415;
	b=r1YOdkhyVrYssWQW86cR5Sm4pc1HNUDdHI6nTE2Y6l7M2XHtGx3irHgvbATcnIiucUg7
	 nL4pQFovuCneqzhxHzkJ+h7esdmlCLDq5UYUdZoIGKUuqkrqS+UH7lYRsfgBJA7oc69nz
	 3r1gUe8k9gE2kGvZ7Fd7GsWB2mXadjbks1E4ZqYjqkheoje08vtFCMkL6/Nw/uJPCAurM
	 bdQr6RD6jw44iyFjipaA6grGAm7SYu+cZj1yG22jIAphN6cVEkuRZZ9j53ceHiK6HtttI
	 +LNPzY1NVVUz14SttSeP6MlxQ/FzGaTk7RicsVtIR+O9EzikJz4s31fteB0RcCrUR7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855415;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=djbnv2cFO7ZIYTtp00ab8uSb76b4hRORaQxuM0jP+GM=;
	b=u5ocggyjkZeWWq5qhBLIXSmP2wWx7jdo5+F8KMPNfWfBuaviZAsQBWfWalETh/tDgamk
	 rKojd8dkI6ANhNSsz9xqSRu1SIHoeRJPArv+3FieRYxV/h3helveJDZ2t41+7QgitQcEP
	 zUl7QjF9qB8JytSDLKDFjCFgsjhVwLzVrbKy/5k+OhB6sFBBL/hCyR6hjU2XFmYvA7iSO
	 5ogRqoH68EAsL9RD1zg34tjjcjzLtAU+f1gn8NcrUF2++9ErgkusiS4FgTB4qR+u9HxQE
	 fWU806xv5JUPyGoPueWH6obOnyMR5SDJDPFUcdHpR0i26g4f/SlxjurVZaHnFPKfJpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi+WAglL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80697606A322;
	Mon, 16 Nov 2026 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi+WAglL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2B71F000C9;
	Mon, 16 Nov 2026 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855415;
	bh=djbnv2cFO7ZIYTtp00ab8uSb76b4hRORaQxuM0jP+GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hi+WAglLp8APvIhFLgmsqQCYPUVbBQ9gM+XT3Y4zPUwgK+ModW7XH4I536UmfTpdz
	 VjeZRYx7KZBjg71JJ8BaZ3cE8nHpSvEd6XATmPooNOohz2hHrFdQ801DfolcTS104a
	 zMQznwyWWDPbyodysaCQ8JfwDSWSh+tVdQqkmTRkpaoTaOoo19MFg8JK+b/48bnYm1
	 3jJlCwiIT3uJ/9kuHXoipmwKlTP6B/tomF7e/5/OnclWWmlzGjcmIzUZppaLCjR7EF
	 pQc4hPEBp/yHfRVGPCdO68BaMMqqZH8RUyYSftCI3bCoYtN6aIbj3cjxK3iVOsZY7O
	 ZFwybEPhIrFIQ==
Date: Mon, 16 Nov 2026 11:56:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] seq_buf: always inline seq_buf_terminate() and the
 helpers around it
Message-ID: <20261116185651.GB1036192@ax162>
References: <20261116022004.2373108-1-sashal@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116022004.2373108-1-sashal@kernel.org>

On Sun, Nov 15, 2026 at 09:20:04PM -0500, Sasha Levin wrote:
> Commit 7b8cd26b6aab8 ("seq_buf: Mark a seq_buf overflowed when terminating
> it loses a byte") made __seq_buf_terminate() bigger, and clang no longer
> inlines seq_buf_terminate() into its two callers in
> kernel/trace/trace_events.c. Both pass bootup_event_seq, which is
> __initdata, so the out-of-line copy sits in .text with that address in it
> and modpost warns:
> 
>   WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_terminate+0x12 (section: .text) -> bootup_event_seq (section: .init.data)
> 
> Both callers are __init, so nothing uses the buffer after it is freed.
> But the warning shows up in allmodconfig builds, and it is an error with
> CONFIG_SECTION_MISMATCH_WARN_ONLY=n.
> 
> Always inlining only seq_buf_terminate() and __seq_buf_terminate() moves
> the problem: clang then leaves seq_buf_set_overflow() out of line with the
> same address in it. So mark every inline helper that trace_events.c
> reaches with bootup_event_seq __always_inline: seq_buf_terminate(),
> __seq_buf_terminate(), seq_buf_set_overflow(), seq_buf_buffer_left(),
> seq_buf_has_overflowed() and seq_buf_used().
> 
> Fixes: 7b8cd26b6aab8 ("seq_buf: Mark a seq_buf overflowed when terminating it loses a byte")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202611110802.zPIiPSnJ-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202611120138.Fwm5Ljmj-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202611122226.vTBpAmtr-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202611122323.IvGv8FYK-lkp@intel.com/
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

-- 
Cheers,
Nathan
