Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72A158A2B
	for <linux-hardening@vger.kernel.org>; Tue,  9 Apr 2024 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701390; cv=none; b=RJykT0zLl0z7mxBhSm1s5gSamZzaH7Xx2hr9J4HryLRZwMigOEhBeuIiW4j9qaVKeWwQXzBBAqBAb7GsGxG6On93GaZmumtYk92AatMdPeg2UnnsYBdtPN9teFP353tnmWomfkIMLqa55EP0INBUGqi5TOgc803k5wIEIvxlbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701390; c=relaxed/simple;
	bh=U2T9uSO2X9eVessJTcSakrE4SOfzMzUscqjMKZuPccw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdQCFnSL3uZ1M3h4TLijguxD97Mm+oSo4kmV//Lvw9TFsvsLlR5CjdaG6G4258xyfkuIcvZzejdinIOnTlOa3OLHT2Qpp4HL5f/rXiMXNRNgmn5X80yB2Wg0JWM7+KGowlh2IYsqfZqNuqwu5RupRDWx5roeiqlpvXl5kX6/pfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cs6Oqy7u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cs6Oqy7u"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e403dd3995so16083435ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 09 Apr 2024 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712701388; x=1713306188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuLQgIPqrOGCGrvwUhSgQ0Doo+WUpy3yKdb+8HV/Ppw=;
        b=Cs6Oqy7uJf0NDNKhxQR03bhhvkNjbZfuExooaoJoUDT8uONq9W7bXRFizcE4ZO/JMg
         Oqbv3Qcy3p8tQ8o6Erko94a6dU73v4ITXXPCidqIO6X5o4yarmPGaIB1nnBDSxFVXwaD
         ALdA/7YvLt5ialjN1aAL+xpRYwtbvNRSajgJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712701388; x=1713306188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuLQgIPqrOGCGrvwUhSgQ0Doo+WUpy3yKdb+8HV/Ppw=;
        b=xQo/QKi4eyPcuAjL0u7R4ChvNzf2TMHc+I67Z4dEuoCmm73cfDQ0js6nevxCyiQbNy
         uy7lKswOmiorIrKWxuVAdkCbSHpzkVV0o7hZn1gzQhwY0vxObmUVV52EJ3glIgl9CzWg
         LjYEqttkAQ2KDnGqT5gEkQ4hUgh8oyJq/cm/uzIoMyslF5pCLxHhAv+gqpNQUfoachY4
         592enUnqArwPEADMDw9fMK+tO11/UcMBUxko3+flgOh2vXPaD1EZ9GmC7cjSk7h7R+Jw
         qARgK2djRqT59X388Iaps9/En0/oE1wBkJTmh67a0L4Jp+1wYY/P/7sHIGmWg+48baBs
         UVjA==
X-Forwarded-Encrypted: i=1; AJvYcCWv2RWD5Uwd6sTnNFdQy2Oyf+ZnFCJTJKTB1UIs0Yv9pIG6EJJCgiA1t8YYGGDpSPbUGGuqcSvAVz8hoDtJF4q5UT6bTlya8UfYyUvf18zb
X-Gm-Message-State: AOJu0YwXQU34bhdkJ8fMbDTd3tHw4wtZkp8qNvEnfD+JIuBwU08jg2/a
	7/mB/jkKQFgffWDv2g7/2mz5wUD/rS0cnQJMhN2hleXleHFOgKNMQRYHDM42Ww==
X-Google-Smtp-Source: AGHT+IGdZCQ6OZYRXUtTSII6tqnCYFblnnzuJzQ5H00+Zb9dJ8S3bAgG3vMV8MTsugbMJ44iIbnlug==
X-Received: by 2002:a17:903:1c7:b0:1e4:2b70:2f17 with SMTP id e7-20020a17090301c700b001e42b702f17mr1166729plh.52.1712701388466;
        Tue, 09 Apr 2024 15:23:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709026e0200b001e26d572f9esm1661164plk.242.2024.04.09.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 15:23:07 -0700 (PDT)
Date: Tue, 9 Apr 2024 15:23:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as
 memmap=nn*align:name
Message-ID: <202404091521.B63E85D@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409211351.075320273@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409211351.075320273@goodmis.org>

On Tue, Apr 09, 2024 at 05:02:55PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> In order to allow for requesting a memory region that can be used for
> things like pstore on multiple machines where the memory is not the same,
> add a new option to the memmap=nn$ kernel command line.
> 
> The memmap=nn$addr will reserve nn amount of memory at the physical
> address addr. To use this, one must know the physical memory layout and
> know where usable memory exists in the physical layout.
> 
> Add a '*' option that will assign memory by looking for a range that can
> fit the given size and alignment. It will start at the high addresses, and
> then work its way down.
> 
> The format is:  memmap=nn*align:name
> 
> Where it will find nn amount of memory at the given alignment of align.
> The name field is to allow another subsystem to retrieve where the memory
> was found. For example:
> 
>   memmap=12M*4096:oops ramoops.mem_name=oops
> 
> Where ramoops.mem_name will tell ramoops that memory was reserved for it
> via the wildcard '*' option and it can find it by calling:
> 
>   if (memmap_named("oops", &start, &size)) {
> 	// start holds the start address and size holds the size given
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/x86/kernel/e820.c | 91 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mm.h     |  2 +
>  mm/memory.c            |  7 ++++
>  3 files changed, 100 insertions(+)

Do we need to involve e820 at all? I think it might be possible to just
have pstore call request_mem_region() very early? Or does KASLR make
that unstable?

-- 
Kees Cook
