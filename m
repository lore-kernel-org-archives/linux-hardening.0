Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9F1C5D4A;
	Mon, 13 Jan 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786811; cv=none; b=A/Q+5Rkr8/fUF8qp8Qxr1mjerlCU+JysX5z3Ona3GBNDEcum5BQCYECeZKAB2oyonAzxSWm/KcARnXAhegFT8jXC8/of0YNhjz5cwu0AuGrVXKUNBGAtTQzowcv2K01uVB2GuIYa+HjnPUzIR+/KFnxa3onsHrWImQz9FM5QPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786811; c=relaxed/simple;
	bh=Mx6hn++/37XT2gruLR0LOoZQ+kj57EhwZHsGi5LtbqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h8hnMchJGDHJE/fl1+1tIxY0jdjcPblINOborSZGDnOI8qZiMI+VB6S/tmXo1jCHeavzVEHsIk3kMIQ4FLF41qKv+eYGluola6krlcpmYfOlvDcllb7kSNFj8e6Ior9IMlpN0OY6+UhK2MzN7skpYJ6bfgwoNXzmkwMTXMhlfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGS4AhXh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/wpjJ0y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGS4AhXh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/wpjJ0y"
Date: Mon, 13 Jan 2025 17:46:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736786807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lmkTv2F3YtryxuTjvaLgqBsHnoCorW/G484+aYsLZvg=;
	b=aGS4AhXhYlqI8dzYyPeJEgdBYK1P9TmFIIcL+l7ubmrByjGMQ02rVXpi6tR2jcb8k9Q8n1
	h5cxj9Pih9o+PSqxkUyZOZggpgXiQF4ZvoV/SgNkAT85KcoCEm8tW1zxJGna17cqiSVcH7
	JrvDsRbdkUWkubyCYQdxbLl497R2QSPyCEf2MOADJIdYfgZ/+2G8+lkH0T8uAkGsKfQE93
	KfjH9BTPRsYlNCzP1d6+Qd4e49OB3yb+lSM++Only4mxlD9XfUI3EAEEqqnPN0ksKymoAf
	2KBttUZqnY7msRDmpmJXgxifleWa+wAtFHQMPoAA7lUApqWLxP5p/t4VkI0N/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736786807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lmkTv2F3YtryxuTjvaLgqBsHnoCorW/G484+aYsLZvg=;
	b=W/wpjJ0yB+HMqBB4v3hAt1XIJjAwccRzjcVkT8XtAJh2N9Li0EjN1MlxXpIgWKM2rjE8L5
	Q2xu7PatH+rqflBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [DISCUSSION] vsprintf: the current state of restricted pointers (%pK)
Message-ID: <20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everybody,

as you know, leaking raw kernel pointers to the user is problematic as
they can be used to break KASLR.
Therefore back in 2011 the %pK format specifier was added [0], printing
certain pointers zeroed out or raw depending on the usage context.
Then in 2017 even the default %p format was changed to hash the pointers [1].

Both mechanisms are similar in their intention but have different,
cross-interacting effects and configuration knobs.
The end result is not always obvious. For example:
* "no_hash_pointers" does not work for %pK if kernel.kptr_restrict>=1
* If kernel.kptr_restrict=1, "restricted" pointers are effectively
  less restricted than "normal" pointers.
* For other values of kernel.kptr_restrict %p and %pK have the same
  security properties, but still different string representations.

Additionally the current usage of %pK is incorrect in many cases.
As %pK relies on the current task context for its permission check, it
was only ever meant to be used from procfs/sysfs/debugfs handlers [2].
In reality many callers use it through printk(), leaking addresses
into dmesg. While restricted_pointer() tries to detect some of such
situations at runtime, this check is not and can not be always complete.

File handlers which could use %pK correctly today, often use
kallsyms_show_value() instead. This is similar, but checks explicitly
against the credentials from an opened file instead of the implicit task
credentials. This behavior was the goal for %pK all along [3].

Is it time to inspect the users of %pK and migrate them to either
%p/%px, kallsyms_show_value() or some similar new API?
Then alias %pK to %p, maybe removing it at some point.


A different, but slightly related issue occurs with PREEMPT_RT.
Calling printk("%pK") while holding a raw spinlock will trigger an
invalid wait context and latency spikes if an LSM using sleeping
spinlocks is enabled.
As printk() should be callable from any context this is an issue.
Removing the implicit group check would also avoid this.


Thanks,
Thomas


[0] 455cd5ab305c ("kptr_restrict for hiding kernel pointers from unprivileged users"),
[1] ad67b74d2469 ("printk: hash addresses printed with %p")
[2] Documentation/core-api/printk-formats.rst:
	This modifier is *only* intended when producing content of a file read by
	userspace from e.g. procfs or sysfs, not for dmesg. Please refer to the
	section about %p above for discussion about how to manage hashing pointers
	in printk().
[3] Documentation/admin-guide/sysctl/kernel.rst:
	"The correct long-term solution is to do the permission checks at open() time."
[4] https://lore.kernel.org/lkml/20241217142032.55793-1-acarmina@redhat.com/
