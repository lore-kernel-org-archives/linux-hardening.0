Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6A33290B
	for <linux-hardening@vger.kernel.org>; Mon,  5 Jan 2026 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617542; cv=none; b=ct/EM/0T5mZtbo916r4uxElt2YqRm9m3vq/wTuHhEYhDfrJZ3boqIUOwyHd6t9SKHYhJ4BkXeSxNCOLcsi2RLKFL8BJkMC61nn+vomPiov5JtVatJ4A0oSlEtBLAicyibWaAtDCKV0Iy9N0gkPhmutKhLxM1H5rNSWCThZ9j8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617542; c=relaxed/simple;
	bh=N0gZejhpVIK3qi+zXOjdBby6xn4BUij6Dyqnfq1/VnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns6Yl6VxJbwn7ucnnO1AkRmPGi+u7vG7UK6t+OGyrNg0FrYvbGHp9knEU1r4sIE4ihPFEZVuMCp/SFVIPuZYfD+AuKViGgi+MphBVlbAgCNkCLHyDf5bioe18xxOgUAn9+23xUSQ6pjF1PgGD1N1Z8H/fNKz4U4KWeKU6KHrSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=3Z0uC/UH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="3Z0uC/UH"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so5718988f8f.1
        for <linux-hardening@vger.kernel.org>; Mon, 05 Jan 2026 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767617538; x=1768222338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIfhp3vJVBySXs5/naEXyaaROJC4kEOY5dOC0TJhcN0=;
        b=3Z0uC/UHBVnzel8Jnhuk8T+cAwex0RTJSiYOheeNpc3vdOwwLJMBAffc5eAvD4KGOL
         LGK2+inyZLpmTytw/dcj5wps4yJKiNGEqtTVmqt9haYtMuPWkkHivDr4xtyJ+ttb12Ha
         rfZIWsPp4QYm17CPeymLbjcbS/AZMWvvB9y7ETcw6Pu0WL/DsaXiFxKww8/ccyrmPsvG
         86rI/h3UvSFHPf/e2t8new9Nx/gn7C/thk5LZPTN1SdjtNmTmXmoCRCPK4zABE3WLbII
         W7/0IjShWCirFI6WjQkTMAfwwZfi/GWyYgc7Buz1QSuu2YWxJSaD/AzfupN0+wO6jMeA
         jaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617538; x=1768222338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIfhp3vJVBySXs5/naEXyaaROJC4kEOY5dOC0TJhcN0=;
        b=Twnz6+lCeft4Wo9+zwEyFuf0qG6JpToyFIyPpUlMRiFSHDYb/PU0BkmeGZ6DfEy+vN
         6HRkxMbIXTWfktkvIf7QsQQb6bcCnOycKQwkffwgkByuSNUSSpZuNDmeLscKPyv7jw/b
         eNo4cnXcwdJXm3XoOCJRCcoMm9t3Y32JwL/F59qxaM4r5FRsjDep9En7+S4fkuPiwllU
         QP7H0C1iyTgJcYOos6q6J8wmfzDng7QivUz/cTTTMmHUdyb3wSh/qBfNYzyI8zWbptkj
         7aUIqLesMpMhx9RgcIXWwO4QNwSjCC9re5aFc3mfnCbzTD2vEju4XzBqSHe0Oi5Hz4A7
         16nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwYTua5tYUWoDzaw1YBW/bWFXjnZoeHhCjAEK1CJc54ARcWjg8A5tDI3PhbAXzDWHyuf7w/9sD5ZKREvXifJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0R6jQd25VeiqYGssXn68B2nCcnwZX226YmRXyvcQLHbcPI+iI
	OPtRZ4u1zAtPMOWGbLF2kpFuuyzdFnFbJhYm0fc8uXvA2gTn02tEJRrcsuKAKWtPQVg=
X-Gm-Gg: AY/fxX4YYe0nBYocdtzaU5EPFMJoU421tiR65c1L/Sz9AZqVrhO4xuJluK4V6K6pdtg
	bQHJJ8DNjZULKVECav6TMT6RO6vADqVlJm8fb3ub+tGCwTZxCq+IdyX7qmTK1AcE29wws/dA/es
	qbu29SWa4HYXu+GjVOLd9RVn6To/jxABdwyQ3fT3cTdPLmbDJM6OuVQYDnJi5w1jyCtXa025Nbm
	xjjJc2YhStkoLDkdBrH/ktTV9uqUinWOfj8v+NZg5JMJEBsA8mY/QAifRbSLHqr31Dij23xKMOn
	2IvNwUaSr/EUNd7bLOjHHMjOBLPfT2ygKUnrnMUcxSiRvQrx+EDGIDac3O2V+aGJQezUMMIOHe5
	wIldiUF+kODQL8yt1GYaIMnV2JXIWaebWh7qmymxKdpo1GshXz7QcGNPq5YHlBGGW0Wtk8k0xAD
	xkpYMk/xJScyP+/hIHf+xSdWqwXyVj4bWDO+/JRMKHrUdNDbL8K8Iwdf2wAtqzYwDuN82ah88c4
	FV66jPYCiMrE56ftM6kfbjc4U9HJU/kRDepc5V8ZTOX9fmilcViXnf701fj2HNhdEy1U1NAsb3M
	KgZ+Jt4=
X-Google-Smtp-Source: AGHT+IE4Mz004OZ0As7rWOFq5sPjHYJ4N8Pzam8+bOUXJdXGQOskOlJaecSDta7VRdPfx5XGGjwohQ==
X-Received: by 2002:a05:6000:1844:b0:432:8504:b8a9 with SMTP id ffacd0b85a97d-4328504b8e1mr37753933f8f.62.1767617537725;
        Mon, 05 Jan 2026 04:52:17 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm100029761f8f.5.2026.01.05.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:52:17 -0800 (PST)
Date: Mon, 5 Jan 2026 12:52:14 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/19] printk cleanup - part 3
Message-ID: <aVuz_hpbrk8oSCVC@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>

Hi Marcos

On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza wrote:
> The parts 1 and 2 can be found here [1] and here[2].
>
> The changes proposed in this part 3 are mostly to clarify the usage of
> the interfaces for NBCON, and use the printk helpers more broadly.
> Besides it, it also introduces a new way to register consoles
> and drop thes the CON_ENABLED flag. It seems too much, but in reality
> the changes are not complex, and as the title says, it's basically a
> cleanup without changing the functional changes.

I ran this patchset through the kgdb test suite and I'm afraid it is
reporting functional changes.

Specifically the earlycon support for kdb has regressed (FWIW the
problem bisects down to the final patch in the series where CON_ENABLED
is removed).

Reproduction on x86-64 KVM outside of the test suite should be easy:

    make defconfig
    scripts/config \
        --enable DEBUG_INFO \
	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
	--enable DEBUG_FS \
	--enable KALLSYMS_ALL \
	--enable MAGIC_SYSRQ \
	--enable KGDB \
	--enable KGDB_TESTS \
	--enable KGDB_KDB \
	--enable KDB_KEYBOARD \
	--enable LKDTM \
	--enable SECURITY_LOCKDOWN_LSM
    make olddefconfig
    make -j$(nproc)
    qemu-system-x86_64 \
        -m 1G -smp 2 -nographic \
	-kernel arch/x86/boot/bzImage \
	-append "console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"

In a successful test the kdb prompt will appear after only a few lines
of output:
~~~
[    0.000000] Linux version 6.19.0-rc4-00020-g4b7f3b144021 (drt@wychelm) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #2 SMP PREEMPT_DYNAMIC Mon Jan 6
[    0.000000] Command line: console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] earlycon: uart8250 at I/O port 0x3f8 (options '')
[    0.000000] printk: legacy bootconsole [uart8250] enabled
[    0.000000] kgdboc: Going to register kgdb with earlycon 'uart'
[    0.000000] KGDB: Registered I/O driver kgdboc_earlycon
[    0.000000] KGDB: Waiting for connection from remote gdb...

Entering kdb (current=0x0000000000000000, pid 0) on processor 0 due to NonMaskable Interrupt @ 0xffffffff9101491f
[0]kdb>
~~~

After this patchset is applied the earlycon triggers do not work
correctly and we get:
~~~
[    0.000000] Linux version 6.19.0-rc4-00019-g882df99205ba (drt@wychelm) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #3 SMP PREEMPT_DYNAMIC Mon Jan 6
[    0.000000] Command line: console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] earlycon: uart8250 at I/O port 0x3f8 (options '')
[    0.000000] kgdboc: No suitable earlycon yet, will try later
...
~~~


Daniel.
