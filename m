Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DFB339B32
	for <linux-hardening@vger.kernel.org>; Mon,  5 Jan 2026 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622120; cv=none; b=keY2Iirk1r2P3394/4d1eMiMyiDKPicQjZoIzd3eJg6OuvmY7fc0bJ3DwdH8tpsvJOaD6vMdKx9HtcHXbpTV+x1jIaYeVqMyPSXvZH9+x6gUBDk2j29oCVh5lPNZVOtpVI8zZEeIpV1Gtzi+1ZGgrxSkE9F764Q8kGt5kLsIOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622120; c=relaxed/simple;
	bh=r3I6M7kWHIbwx8pg9jWTMfz8fscetYU9L971EGe7OZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8bJ516jrxkvBj9YQGoGkdbfeSsSZyB78MbP3n1TQZPZc4/0X1TYSUedOJ0Tl1Z9Wm6TY7Q8ad5I3w7f5BthueEvBYCviSKe/jAtXwwVf6E+vogAvHWHV1NhHT4MDqXYg6C7O7m58e7xwVbZrhGqrk/DSdWciqtplO1i7E/NIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=H9+hkPjh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="H9+hkPjh"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so6752263f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Jan 2026 06:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767622109; x=1768226909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=H9+hkPjhAyTEos4JbC3SAHaK4U1jFi/jCKRwkG3H3+42Ugy69WLCmKacOeNmxPOKw0
         Ix+pwpDSjEpf1yAwNXdsT20c7NqUd5oHunNPqzsePlSzps5WYOiSx5uiCtjGUY1TIUPv
         t3T9IoS8ShGcJgfzjL2u6Q1kdVMwGv1f8pIgH0DMcox24h5IEYh+Atzg4WxOTvniWzK+
         G51sNEh08yMuuRlk8CmnRljUjsg5kNffJGszJhny8HWJRogQSvnCbU6DTnjhLeuxTHmy
         I4XskcK1GoHISE8qrTfNJmMx/D+rH0FMktQJVeTsE0D2xA7ox80+XRiyZ3oSBGef62e1
         HWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622109; x=1768226909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=fGwmQwZY4nDas6cjh0l0F6uRhcrzScDmxPlsjWWzVyQpesbL+eKAcmLKg5S1SW62GV
         Pfd8SmJSNeEIJmubQ3LBQpu+0syfb2Z04F622f6AFugFzAwMkY3xrzRS4inFSGqtXjbW
         nPSb3qgTx3naxNqjtNtNdLHc7fi11sf5ZRwMMWzuea/nlxR/348D1g/aVsXRvJ/9+U3Y
         6G1l/t8L8o6iOaT5SBW7LihGCol9yeC+dxKgxeOzZA0prss7G9VyAcGhrayHQgrzLbe/
         NKgZelV+psy3d8D1Lad2wdo3QLZ+00Oyulh4o1dO73idv+Ry2dGOplC/heEGPR/GlxDS
         OrZw==
X-Forwarded-Encrypted: i=1; AJvYcCUu9YlRdasm9I8FkiaG9PNmffC8BtzKy1sF3jrxa7ZsGOJDRrRdAK/+TDtPxeINmiZ+B8qZv/lfdBWhizkfTUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2LJSmeePcrdddH1K/gH9lo7fOAXutDweLwQOUoBwx2XyCbIC
	i2JqtUav/cmAWOQL5vgZISCQWcqALcLZ22gqorIyveV+a2U/4j7FDsVtrBqOYoiQV0s=
X-Gm-Gg: AY/fxX7rstIzJG9t7c2tRU70jHv/1PZtBGylVKbwpinQe3kymUsFZAtE1lZWDnS57/l
	LGM6csKLxYz0BrOMULl95RXI8NMyqbz1UzdFzoVgyOUDdVOXRxfqtlR9jHJoHfgiuaeZQ8EUuaS
	eu+2ooWUHgZjbRw8I6e4Tt793t5rQnyCPjGutz+9IFnsHuiFanjjkRA1fw+TTh79/aOGEjTN77q
	m0/Bx4SRiEpI/1lj6BK/zp89nvWN6RmEfqdrzGNuon7ARNlMA5W9AQ0briLd45uMjKAZpJnB+Jl
	pUKGgdrO+CIr6VNUaD+sWnnfAuaV6pn3kmDUS6yb8Tto26QFmXONARsKon8A8+OOwRTJyCq2Ldu
	zpTxXCqBm8MPvdrDNQzKKRfARsgtQMJjOikeQxvjfxUgRA1iAsLyQi1nJZAcG63WnhKvPYerYr+
	68fRkmzzE8FSk1kcYs0BS3yw+D+X251/iH5HaZGiLUHpN2lmhMbw/mS5P2vM80Op5VSevOuPdNA
	tcSCAZn1BMIaOb5zOGcP3cHwj5RRyDVW30I93Any5cmeBL79NnsdQcEkSYl6CXMRAvgd0Mz
X-Google-Smtp-Source: AGHT+IFtm/KgnS/DHXZ241C9Tii09D9IuHplpok3aN88rFmOsLWOymloQBuensoLNVO5jV8TaARwoQ==
X-Received: by 2002:a5d:4842:0:b0:432:84ee:186d with SMTP id ffacd0b85a97d-43284ee2de1mr31846134f8f.62.1767622109438;
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm100250524f8f.3.2026.01.05.06.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Date: Mon, 5 Jan 2026 14:08:26 +0000
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
Message-ID: <aVvF2hivCm0vIlfE@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVuz_hpbrk8oSCVC@aspen.lan>

On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> Hi Marcos
>
> On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza wrote:
> > The parts 1 and 2 can be found here [1] and here[2].
> >
> > The changes proposed in this part 3 are mostly to clarify the usage of
> > the interfaces for NBCON, and use the printk helpers more broadly.
> > Besides it, it also introduces a new way to register consoles
> > and drop thes the CON_ENABLED flag. It seems too much, but in reality
> > the changes are not complex, and as the title says, it's basically a
> > cleanup without changing the functional changes.
>
> I ran this patchset through the kgdb test suite and I'm afraid it is
> reporting functional changes.
>
> Specifically the earlycon support for kdb has regressed (FWIW the
> problem bisects down to the final patch in the series where CON_ENABLED
> is removed).
>
> Reproduction on x86-64 KVM outside of the test suite should be easy:
>
>     make defconfig
>     scripts/config \
>         --enable DEBUG_INFO \
> 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> 	--enable DEBUG_FS \
> 	--enable KALLSYMS_ALL \
> 	--enable MAGIC_SYSRQ \
> 	--enable KGDB \
> 	--enable KGDB_TESTS \
> 	--enable KGDB_KDB \
> 	--enable KDB_KEYBOARD \
> 	--enable LKDTM \
> 	--enable SECURITY_LOCKDOWN_LSM
>     make olddefconfig
>     make -j$(nproc)
>     qemu-system-x86_64 \
>         -m 1G -smp 2 -nographic \
> 	-kernel arch/x86/boot/bzImage \
> 	-append "console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"

Actually I realized there was a simpler reproduction (hinted at by the
missing "printk: legacy bootconsole [uart8250] enabled" in the regressed
case). It looks like the earlycon simply doesn't work and that means the
reproduction doesn't require anything related to kgdb at all. Simply:

    make defconfig
    make -j$(nproc)
    qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel arch/x86/boot/bzImage \
        -append "earlycon=uart8250,io,0x3f8"

With the part 3 patchset applied I get no output from the earlycon
(without the patch set I get the early boot messages which, as expected,
stop when tty0 comes up).


Daniel.
