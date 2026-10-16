Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606349BB4A;
	Fri, 16 Oct 2026 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175315; cv=none; b=PvUz5vzOWi9xSxnyHZld+C3QZ32fZ0aLJiWUgTvPnz8lznK4QXb/Sdg/zFFio7FHfdC69VM7f6JNBE8rqUmeJvQqjFGGK/rj7Zx08mA7Ry9dycf1p0Z7NLYhKDIVTR2uLWiqpnjAnl+ef4gUC21EiBELj6qWCXOMHCU1CGUWRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175315; c=relaxed/simple;
	bh=Mqx8SLErC81i9Jrh1XJnXDa92rtYyK0u0D9xlfJd++I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNyDwz6YhM/6B0Qw7+tr9/IabOh6cw6UneZZlDxULSjarTp++91sTMuEWYspb05e8yg0C/2/Fg3Qv8ZgEp428l5X/s+VDlkb6M41kNPV/+J2eHr5K1Pjmwg3cV+f2h7xScPf564eTO+0LfWIFktq8VG5hQk5770FaHBkmS0ZZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=jYLgL8SF; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="jYLgL8SF"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id AD25DC055A;
	Fri, 16 Oct 2026 18:28:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 87B303D;
	Fri, 16 Oct 2026 18:28:29 +0000 (UTC)
Date: Fri, 16 Oct 2026 14:28:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Gow <david@davidgow.net>, Petr Mladek
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Shuvam
 Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 01/12] seq_buf: Do not print an empty line from an
 overflowed seq_buf_do_printk()
Message-ID: <20261016142828.1b045e94@gandalf.local.home>
In-Reply-To: <20261005155708.1471260-1-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-1-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: yrmkyinkdm55emektfq3wyq59whg9fgy
X-Rspamd-Queue-Id: 87B303D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18U1Qqs6jdePvgGBKKJ1UBg7QFpPLyoieo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=vcbJi8BR2eKqQ2Jsf9h5NMGUHIFXwODcHon8O1b9PlI=; b=jYLgL8SFkxvGxHRIGXTmDr3iNXp+0eabPQuERXdkgE+p5UlMMokcIGHpz1a63U484advAvU4E5ul1OJA7rFaNJETqAItPCAVYty5Mg4AvgE4DP3XJKm2WW9NTSyBFTxJMgdyuGRXcJLzGIAHvA3SfLk00VreTMFsRBHMMn90Iac=
X-HE-Tag: 1792175309-687389
X-HE-Meta: U2FsdGVkX1+1J8xwDjPLYdsLp4sUTnNJUBeH15PUfy7XOeb5S8k+T5AxFQ6r5/uoKkJMTcUlNNUFnfo7KUZjHTtmsUo/Gr4V3c3Jltpk82f7YZTu/tGkW7NU/c0iUMDzT1b76h6X97FfzZJyNX0dGzTwMPHQK089nqPLN+ihtyqpqwz3HtFisiiLHyTaNOFJqwkvDw2kPa7uUbxvcBaAqoRtgbwlRQmv2Mj5GAygrth0NNhjH0lqy5TWigJBHoIAD6kObEnNzhzMiNK2Ps6i3xFHfSjvOOCp8sLQe8l3yF/OI6Q4aweN8XIHWacvBIgAvEyxEwZkyZjk+p0WdXw6owPnhyHyYqYPMuSoiQCDbTGf7ZgcfvmV5jGMOPnucmIYQhyjfR0+ECyC1cjsRxqgqQ==

On Mon,  5 Oct 2026 08:56:51 -0700
Kees Cook <kees@kernel.org> wrote:

> seq_buf_do_printk() prints a buffer line by line, then prints whatever
> follows the last newline. When a string has overflowed at exactly a
> newline, an empty line is printed since the pointer hasn't reached the
> overflow mark of the seq_buf. Switch to just check if the string is
> already empty and only print if not.
> 
> The only caller is the memory cgroup OOM report, so this could only ever
> add a blank line to a report whose statistics already did not fit.
> 
> Add a test that registers a console to count the records that
> seq_buf_do_printk() emits. It counts the records carrying the test's
> marker, and the records holding nothing but a line feed that arrive
> after one, so that unrelated kernel messages do not disturb it. Both
> states that reach the flaw are covered: exactly full, and overflowed.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0.
> 
> Fixes: 96928d9032a7c ("seq_buf: Add seq_buf_do_printk() helper")
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Steven Rostedt <rosted@goodmis.org>

-- Steve
