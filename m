Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370B31F984;
	Mon, 12 Oct 2026 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781301; cv=none; b=DjeRnamMRPHDrTuyIia9ynLb9dubjItpB2WgdUqEHG2/3vrkDw09AsHMfG4UlSLbN+sr8yDOk7hx8YVudvKqMKxVdscCY0Uz82CvmmirfU8YesFMy3lWp0Yc4dteEmM2VvQS7HsIDtko0lPi5MLXaLFJtEBh9kLEqKAAmeJZhOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781301; c=relaxed/simple;
	bh=P2V6OYVGOm19mMOBP6huSevFwW0x+XnqnWNiq2jBc0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7jO5hsO8+ClNffUARu2GTXu+IrcFV3vuEfkierOkhLsKLhpxItL212l6ns++Z3L3szjM2UZcKBcUPnUGzL656EROVnNnLNYyUYdipyQqdwx3jmkQ3iOKKTPsthciLSaj9iEe3GEGTrccbXo61l8coSPRybJV9mIxghc/JbRQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+zRNY+V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+zRNY+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91B11F0089B;
	Mon, 12 Oct 2026 05:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791781299;
	bh=GvXeU1FpwRVSbdTdJ/hdSUawHa245vliMRzvYSrPHZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g+zRNY+V/b7hSm19zWhlsRx+MWTLhnMBeDgZdW0Voj8niBfMFn61p8dEEXP3l8T5c
	 sv6wuIiWXiF/McwJ7zOJXddkQAYIs5QXzBJEm1WC1rdkjlIYXj5/ZLG8MU4saOPSjw
	 aE6i9EGdSRHBBqYl7z5I2YTBVN+pE+9kgPtaq1nm4pRadmz5Ey8hSmMUXY726U362q
	 3s2PyZHsUxP0Ft2SSHmbPNhfVUKIxdZ63GyFLY6//sl6PQN6ydB7+L2Do51UVuAK9O
	 UC+0CwiYiqmggGWtsGqSiHa4S+aH0+SZs1DESmpsVFp7d7p9iYD+wMMpgmeRmboOvW
	 q7ImBhlHCScgA==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>,
	Kees Cook <kees@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ian Bridges <icb@fastmail.org>,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ira Weiny <iweiny@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 00/12] seq_buf: Add seq_buf_strlen()
Date: Sun, 11 Oct 2026 22:00:45 -0700
Message-ID: <179178124413.1284057.2168341749556875841.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005155653.late.426-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 05 Oct 2026 08:56:50 -0700, Kees Cook wrote:
> While working on seq_buf conversions[1], we found there was a need for
> seq_buf_strlen() (since calling strlen(seq_buf_str()) would be a waste
> of time: seq_buf already knows the length), seq_buf_init_append() (to
> start a seq_buf from an existing string buffer), and seq_buf_terminate()
> (as there are many callers using seq_buf_str() just for its termination
> side-effect). And while implementing that, we found a bunch of other
> related things that needed fixing. This is that ever-growing series,
> with tests for each fix.
> 
> [...]

Applied to for-next/hardening.

[01/12] seq_buf: Do not print an empty line from an overflowed seq_buf_do_printk()
        https://git.kernel.org/kees/c/a09fb764832d
[02/12] seq_buf: Do not pop from an overflowed seq_buf
        https://git.kernel.org/kees/c/b7e688b5635a
[03/12] scsi: lpfc: Print rx monitor records straight into the seq_buf
        https://git.kernel.org/kees/c/cc9d25b45119
[04/12] seq_buf: Copy what fits when seq_buf_puts() and seq_buf_putmem() overflow
        https://git.kernel.org/kees/c/505a4aeea2c9
[05/12] seq_buf: Clear what a writer did not claim when a seq_buf overflows
        https://git.kernel.org/kees/c/ea5666e56723
[06/12] seq_buf: Add seq_buf_strlen()
        https://git.kernel.org/kees/c/8d1478bfd63b
[07/12] seq_buf: Add seq_buf_terminate()
        https://git.kernel.org/kees/c/88c652df02cc
[08/12] bpf: Remove dead newline stripping from format_disasm_line()
        https://git.kernel.org/kees/c/c8cd1725d259
[09/12] seq_buf: Add seq_buf_init_append()
        https://git.kernel.org/kees/c/61ef3f1490f8
[10/12] powerpc/papr_scm: Return the string length from the sysfs show functions
        https://git.kernel.org/kees/c/63ae65caa98a
[11/12] nvdimm: ndtest: Return the string length from flags_show()
        https://git.kernel.org/kees/c/9ac219976ecf
[12/12] docs: core-api: Document the seq_buf API
        https://git.kernel.org/kees/c/e3f8dfafd7d6

Take care,

-- 
Kees Cook

