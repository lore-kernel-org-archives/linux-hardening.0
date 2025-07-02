Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C1239E90;
	Wed,  2 Jul 2025 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490768; cv=none; b=owHh+ooPEzA1BrgUct7MoLT3QSfK1v9k8+Ehfuw8V5OKnKTMyo4u+Xs1Rllh6aYMB35NJRXZRYyEArGuexpOXWMgZhzYDSUs0OvnOa9uODt2Tie7iWzPrdWFBGytjlRe55pJv5J9/F+BgMH/xGS5PKoJjfCh/CNwke4chm4ivRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490768; c=relaxed/simple;
	bh=PBybrmdPM7zrM8eU16XV6OIXKt3aecbUtvMDihivU7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewMB3nLa9td1R7871lhwaOE5MZkpl0m9wPKazVuVnditKC8Lt2GnjUk3+y77HlJPnc3mjC65gNEbj5mk7foWqvXvgX41kS3gXKpRbScRzla1AbTY8B7NFgLlzj6PxkNOoySdwzjfum07uriMVw4tWD8vBVNcPyx5iOpO3SwhjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIU0waRN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIU0waRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7CEC4CEE7;
	Wed,  2 Jul 2025 21:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751490767;
	bh=PBybrmdPM7zrM8eU16XV6OIXKt3aecbUtvMDihivU7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LIU0waRNiIeiPXwSighbehOZkYRBLyQQz/OS6cgrq0YpfDjcMuVKWmq2bSTD6tu66
	 kA6tVC+6djnuqyN0Lj0rL334tlOcAB5r72iewYougOw/bzfu4Lx/nY304Jz7tSU9oj
	 YaZfI4cthW4dLYj6wxLpbY/zI4K2yg/TiSQZboapPql9zxnqEGN1mz064iyzVaNgQ5
	 YCS5r4KAwPVcGYmVSWrFN3Qqt7S9sHNgZfMNujLorofqE5HLZLHhNyEACZ2DGB4YlV
	 w2gaNvdq1Snnwvrp7VO0eBCfOzN3B/iNQ8FhHlELE4LfNlkPoioqXa82k5CnizIR5a
	 Gd7+4ywf7/owA==
Date: Wed, 2 Jul 2025 14:12:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>,
	Jannik =?iso-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] kunit/fortify: Add back "volatile" for sizeof() constants
Message-ID: <20250702211243.GA327934@ax162>
References: <20250628234034.work.800-kees@kernel.org>
 <CAG48ez0n1E0iuOxPe=jq4MuuP3w2wMSNixmfNmBbB89jyJBSbA@mail.gmail.com>
 <202507010926.1650356E@keescook>
 <CAGG=3QWVM9tTRoGws0X+Jq+m7Fte2JeQC+jUL=EZ5hqGzSY6hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QWVM9tTRoGws0X+Jq+m7Fte2JeQC+jUL=EZ5hqGzSY6hg@mail.gmail.com>

On Tue, Jul 01, 2025 at 10:38:36AM -0700, Bill Wendling wrote:
> On Tue, Jul 1, 2025 at 9:27 AM Kees Cook <kees@kernel.org> wrote:
> > I have not had the time to minimize it, no.

I can try to extract this into a minimal reproducer next week if nothing
major crops up over the long weekend.

> OPTIMIZER_HIDE_VAR doesn't have a 'volatile' on it. Could that be it?

I tested

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 6f04a1d8c720..eab208a9a6f4 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -160,7 +160,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #ifndef OPTIMIZER_HIDE_VAR
 /* Make the optimizer believe the variable can be manipulated arbitrarily. */
 #define OPTIMIZER_HIDE_VAR(var)						\
-	__asm__ ("" : "=r" (var) : "0" (var))
+	__asm__ volatile("" : "=r" (var) : "0" (var))
 #endif
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)

but that did not resolve the error.

Cheers,
Nathan
