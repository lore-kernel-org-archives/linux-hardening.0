Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07363158DC4
	for <linux-hardening@vger.kernel.org>; Tue,  9 Apr 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705833; cv=none; b=ZsfkHxeCKJImIBo70DtQER0Q1TEf0E5NrurhZAAxBBNVmk5800mDq+rsgFeJNNtrLE3c7Ufs2txdmdlj1tAgihPlW49WKhZN/yZ2ttZ3RrmlgBobtE7/gZGQ+QxZS9M4qJ4WYQltIMLmEudUGnC25wmiFR2V5teGMaXCXsH3qCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705833; c=relaxed/simple;
	bh=5IWHRqqI3seHjc0H8avvGZOeJtWf+yYAE01YKdMRMjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/hVCPJzxP6uheOKu8cU6Og6ODf/VvGGzdLqytiO5DbOG6aZbgJpV+Welr3FGAsxyBrE5lt9LnHVL2OT5DZMkIjlKmrI7teQpG1pEJ5sOOvbi1JDGm5QYYJ5On9S8cSjhQ8uHbaCXPuvVbANLCD/d/sxYUTAKgCfnRNpG9IufOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZJ+RrgOK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZJ+RrgOK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2232e30f4so54534995ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 09 Apr 2024 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712705831; x=1713310631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3GBllj8XS/Lgw7EDpDRRfiZJH4dQ/8JO1yJUn0SBBo=;
        b=ZJ+RrgOKjpOz9xlBHcWvU73KNORXrOrMjwh4nPUz3JCkOgWGnPN88mBWsC7QFTCz2h
         JDa2g/M33Sx1YvD0C9qx/TOVi5dSKjxD0QfJKrKazgY/j0LEkJKwggviFDiWxOJK1vjt
         dQe0ZoRzVidNxlDGSZGCMBHEO3gs9g2yfNgH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712705831; x=1713310631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3GBllj8XS/Lgw7EDpDRRfiZJH4dQ/8JO1yJUn0SBBo=;
        b=ctrE5qVPN5awaQ2ZoYztMa4iX7r4/3T2ON+kqffOUK9wYFiBbhXGHSGbhxatiF3FFD
         KZGy4SE21d7iQBKmhra2BP/dG4nngvEOgNqnGj9peTBdyc6ocS7x+1txfGof8BrU5mqr
         OKIDIAA0E5RZszR2Y6+pvC7JNIEACcf48W2iupCgJUnfy0sKYZ6pXF2ev1+Q9vNzQ86n
         NMzwCsQqVIqsxfSsyDT152/AmIe0J4oOVjARnHeIcBktQwSbggpGwYRW7McXghEjzMoE
         03kFqIuIC/6bxphcdSS3/ydoXM8ArdxGL217E45lvvklucvO7bZBBromQnYv1DQLovts
         p7nA==
X-Forwarded-Encrypted: i=1; AJvYcCUWBbrFVa/fyOoMeRX2U96RgJr2oM/QT4C/tQCnHfs6fTXzQcLe7fnLLgkhD8L2XAhn0a4DwaT08gZdvHs8XCM84LcEDqiTdtzm76aDvXdt
X-Gm-Message-State: AOJu0YwFgB9JS6T1CV7m/1IYOKeVmhp/BYMjDcZdLlzlW3zo2GxP6gGE
	HJCHfL/94QY+CY1PTKWIJU16m73N9suxvara+DX1As4KRzZ8tRpeQXktutZLEw==
X-Google-Smtp-Source: AGHT+IFGdPZEzpneRh+zF6NNUt7U7MwmMmltzsSaPxDXzFgDYjGM/3hI5oS+TZohMG0Jhx7lVLFtgw==
X-Received: by 2002:a17:902:9303:b0:1e0:a3dd:82df with SMTP id bc3-20020a170902930300b001e0a3dd82dfmr1075461plb.38.1712705831382;
        Tue, 09 Apr 2024 16:37:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kn12-20020a170903078c00b001e0c91d448fsm9479230plb.112.2024.04.09.16.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 16:37:10 -0700 (PDT)
Date: Tue, 9 Apr 2024 16:37:10 -0700
From: Kees Cook <keescook@chromium.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>,
	"wklin@google.com" <wklin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <202404091628.BEC1FAC8@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409172358.34ea19f0@gandalf.local.home>
 <202404091519.B7B2221@keescook>
 <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Apr 09, 2024 at 10:25:33PM +0000, Luck, Tony wrote:
> >> I forgot to mention that this makes it trivial for any machine that doesn't
> >> clear memory on soft-reboot, to enable console ramoops (to have access to
> >> the last boot dmesg without needing serial).
> >> 
> >> I tested this on a couple of my test boxes and on QEMU, and it works rather
> >> well.
> >
> > I've long wanted a "stable for this machine and kernel" memory region
> > like this for pstore. It would make testing much easier.
> 
> Which systems does this work on? I'd assume that servers (and anything
> else with ECC memory) would nuke contents while resetting ECC to clean
> state.

Do ECC servers wipe their RAM by default? I know that if you build with
CONFIG_RESET_ATTACK_MITIGATION=y on an EFI system that supports the
MemoryOverwriteRequestControl EFI variable you'll get a RAM wipe...

-- 
Kees Cook
