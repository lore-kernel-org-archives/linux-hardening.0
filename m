Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A13246335
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120859; cv=none; b=f2q8py/tDDbKdOBsb0QDnYbPFkHqsMxHAdnVZ4Sz5XUw7Yfi36k2ZWkvsx4Yzcb0TiGndDtt9J0Bwil7/kKZgmmUN/eD53wJ8JgLySHp+H3AmHO4WaxyykF4eFz3cZFUzRiglzBOW0wUYYA2ahdt3KsbqfMQqSFydzQpS70y2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120859; c=relaxed/simple;
	bh=n1lZSkzZwx941+aliTejNiKm2h6Und41E6LxYVI8Eno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL+Q0SYXVTz8+bbIjzi5AIfvi/Hi3efKmPtL3IHOV7Mh5UvBM55M4YBM0uPJeUSwwCB7AED7pX8RkskzLfdQRl2JZzsH9rNAdI20ev2YX+42zvwDHkwp0gQxkpvAykQpbkyvxWp84F6GmXwLLoxl7ESlxMFu2WijptOiWeDlt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAMPfb+C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAMPfb+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24924C4CEE5;
	Tue,  4 Mar 2025 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741120859;
	bh=n1lZSkzZwx941+aliTejNiKm2h6Und41E6LxYVI8Eno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAMPfb+CunOPrf4Hy4FicBmmP7jeL7ECKZ5gJQftf8m3VZtJel23Jk9uBMgrejFud
	 a8D0DhZMBKsOwk2XheQlS4OXpNDdiQ8kLTcDQi9ZLY+41uAkUVu7xv73aNdJhgBYXO
	 4/Ui14q70B+mRhmcDjH+vhL/dmzEndqqEVkiErTkSkvIgrFRWEGbv+4WAH04DteiBH
	 SwbMwz4lrDMxvlpvEm9Y4O3m6uV5rYqB86Au/sf9wEb9PwJDreIFrZ9tzh3Qfk46nQ
	 zSsNIPlepnpPIgu9lileq3laJUj1zbqoHxnIoBWqI0OVG8OmbT90zcj2DLLz/MsbWp
	 QTN6evatRchcA==
Date: Tue, 4 Mar 2025 12:40:57 -0800
From: Kees Cook <kees@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/10] lib/string_choices: Add new helpers
Message-ID: <202503041222.6A4843E77E@keescook>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>

On Tue, Mar 04, 2025 at 02:12:41AM +0000, Kuninori Morimoto wrote:
> I would like to use string_choices helper to cleanup the code, but it is
> missing some of well used string pair in kernel. This patch-set adds it.
> 
> Step1
> 	Add new helpers (This patch-set)
> Step2
> 	Each driver/framework use new helper

The Coccinelle rules are very easy to write. For example:

@str_input_output@
expression E;
@@

-       (E ? "input" : "output")
+       str_input_output(E)

@str_output_input@
expression E;
@@

-       (E ? "output" : "input")
+       str_output_input(E)

Then running those will generate the treewide patches. I wrote and ran
al of these, and the results for me were:

str_in_out.patch:              66 files changed, 130 insertions(+), 136 deletions(-)
str_tx_rx.patch:               33 files changed, 48 insertions(+), 53 deletions(-)
str_input_output.patch:        17 files changed, 27 insertions(+), 29 deletions(-)
str_enabling_disabling.patch:  16 files changed, 25 insertions(+), 25 deletions(-)
str_Y_N.patch:                 13 files changed, 98 insertions(+), 89 deletions(-)
str_kernel_user.patch:          7 files changed, 8 insertions(+), 7 deletions(-)
str_level_edge.patch:           5 files changed, 6 insertions(+), 6 deletions(-)
str_to_from.patch:              3 files changed, 4 insertions(+), 4 deletions(-)
str_pass_fail.patch:            2 files changed, 2 insertions(+), 2 deletions(-)
str_attach_detach.patch:        1 file changed, 4 insertions(+), 4 deletions(-)

So, IMO, the first 5 are clear winners. The others are probably fine,
but pass/fail and attach/detach are really not used much.

> One concern is that it adds "pass/fail", but we can find many similar
> strings, like below. I have choiced "pass/fail" and use it on all cases
> in my local branch (You can see some of them in [SAMPLE].
> I need your opinion
> 
> 	passed     / failed
> 	succeed    / failed
> 	success    / failed
> 	successful / failed
> 	succeeded  / failed
> 	worked     / failed

As Andy said, don't change any existing strings into something else.
However, of the above 6 styles, I'd say find the most common and do
those conversions.

>  244 files changed, 604 insertions(+), 602 deletions(-)

I only saw:

 161 files changed, 352 insertions(+), 355 deletions(-)

You have a lot in arch/ that I don't have, and when I spot-checked those
files, I don't see what from this series you were converted? Perhaps you
were doing more than those from this series (like "write"/"read")?

-Kees

-- 
Kees Cook
