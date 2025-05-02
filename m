Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1E25F98B
	for <linux-hardening@vger.kernel.org>; Fri,  2 May 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203902; cv=none; b=NKXbXWZGd0u+XC+89vsjkVyFfEIyUtn47N4CDzaSbmhxOSc+PVgIG/lLOshG7d9zrDc6RMaLB3iZctMDYv/47ro5e98JMbKVev/sv252QiieuminircIl3jI3Q9G1tWRb4fjItsoXZJOtrZ7C785uE3s/GmnyCk2PXvWHzlds3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203902; c=relaxed/simple;
	bh=XsE7SiV+aikMHOLaaXZ7a8kPrkm9AwB5yoxuMKmx1sQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gbc4ILc5kf5+d5IbDgMhb0kO41YYLQj9z0cXeNh9nxYOH/NyCWyZ1VSFg401vQsq6VGx25HC4CvjQmKzN5cR1DxUD7NooZ9q9ejwmvupDoa0dxgcECq1s6+qH5v4sdJXJvslgPco4/dREE/iYMtJJMjHVnbXEsOXhR/Zc7USVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGx84i8k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGx84i8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746203899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14Itu0wJcqKS8hAd7pT4xJxMeQ8wSKPFd/cQcnRkK64=;
	b=LGx84i8kY2T9BL6D2VoQo0QYzwa8M4yyYSExh5iRfV1rsE9uHChD1roDYYFdHGuht9riKZ
	FJki0wdvR/faRBACcD4WqchHsYNYUdBGWw4kBA0OsOyX6cp/Q+nkC2V7b+WTbYh56R4nx6
	Sn/M2Z4wR1fVH9HhG206Wl/DlMtHpXY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-4u_645a0Mnu9ewXF0nqo2Q-1; Fri, 02 May 2025 12:38:17 -0400
X-MC-Unique: 4u_645a0Mnu9ewXF0nqo2Q-1
X-Mimecast-MFC-AGG-ID: 4u_645a0Mnu9ewXF0nqo2Q_1746203897
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso9363535e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 02 May 2025 09:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746203897; x=1746808697;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14Itu0wJcqKS8hAd7pT4xJxMeQ8wSKPFd/cQcnRkK64=;
        b=IhJ71DvkUjYz8VsrwD+Kxz9uHcchxHtJmFei0ADGTIb995bvR9G/NSSAOjVMqyXIx/
         Hg52SpAAzpPCw6MrOV6NsbPuKgNOmKavEJq4XZvyE9KlJaMCNdg7lIGAcmnxUvDkNvUO
         y/kWu1No0IWhf+ZmUwZdYqfxY0LqjLmw2blnaw5OO1MiJArMXU6iI0PH1LEu9RtoyeiU
         4ucMOVvrNNlelpR56VO21LReXpSOXET7O855cJfXbCFWFbB8VPIw63ZUbS97tPZM6dKW
         /nNpDldcCmAYwfCYKUEgem32ccqwRlZF+MFz+GLPa5D6ikZUdvbeMaYuVZf1JoqTXHDh
         IhQw==
X-Forwarded-Encrypted: i=1; AJvYcCU5sVpayUC4bxIlkjqz2xDLx1mHQcEEOCMboDiDveTw/isBzD90BohuP5EHuwMPODVPOfdrGrqhmvP9ioyOLI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mwSxW740womQGb2d9jd6cBwKlIVzv2V4TsG88zzXT5rQJ/so
	2N4qPlpOatJO96nopgzxO+qG8Y4W1TNflza2MWCNsA3dk2mVOQPruCdHld8RRjzLjen199mDaHG
	+SQkhmFUKp4UvG905MDZNLtrB/H15Tqqpcisy4LyrSZ5fMIDSKAb24WVhPnFdZ28Nfw==
X-Gm-Gg: ASbGncuwAWkRaWHZxd2IlCN/FwBD0K8tWwORvDQBgQ40/YaW0LsscM4eMs2/JLGUrJM
	Eq6MtTMkFE95Vol0aIQ68T1Uad2JKNH1+rUwHvGnaEJbAwU2NtWAONwtUADyFfGnDSY4tTIDBf0
	f0K6cblHqGbwbivAXm2XLdj6tHCQUHQU+gSYqjPF85OaX4Ku2Zd5XL8G1fnHZd7/0D9VEaIse0D
	3Kxa8gNOrDpI5o4DpdU6SFsrRt1veYgBNaHwnZmBsIU4oUPlKb9jjCfGxOt53faCa2SpAuwsQQy
	Iw1JRsRX2+w4DVd6lzAEBoeAnKgCH9Ne0Y0msFN1nEjzILTw
X-Received: by 2002:a05:600c:528f:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-441bb852744mr33829185e9.5.1746203896739;
        Fri, 02 May 2025 09:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMHXR/p+bYllCeFUiu3mvj1rpI7ZOiyLrHoitDd00Nmz4qAV27N+1EVZD+X61FQi8x3pEBZA==
X-Received: by 2002:a05:600c:528f:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-441bb852744mr33828185e9.5.1746203896267;
        Fri, 02 May 2025 09:38:16 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2001:861:43c1:5950:3e51:b684:9982:d4a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28732sm94362125e9.37.2025.05.02.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:38:15 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, Juri Lelli
 <juri.lelli@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>, Nicolas
 Saenz Julienne <nsaenz@amazon.com>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Juergen Gross <jgross@suse.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Naveen N
 Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Rong Xu
 <xur@google.com>, Rafael Aquini <aquini@redhat.com>, Song Liu
 <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Brian Gerst <brgerst@gmail.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Vishal Annapurve <vannapurve@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>, Tiezhu
 Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v5 00/25] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <34535b8c-35c8-4a7f-8363-f5a9c5a69023@intel.com>
References: <20250429113242.998312-1-vschneid@redhat.com>
 <fefcd1a6-f146-4f3c-b28b-f907e7346ddd@intel.com>
 <20250430132047.01d48647@gandalf.local.home>
 <019f6713-cfbd-466b-8fb5-dcd982cf8644@intel.com>
 <20250430154228.1d6306b4@gandalf.local.home>
 <a6b3a331-1ff3-4490-b300-a62b3c21578d@intel.com>
 <xhsmhr0179w1i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <34535b8c-35c8-4a7f-8363-f5a9c5a69023@intel.com>
Date: Fri, 02 May 2025 18:38:12 +0200
Message-ID: <xhsmho6wb9de3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sGb2d84Qbrckffn9zEU3outRd0mOCRr8mCAxcS0TLmQ_1746203897
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 02/05/25 06:53, Dave Hansen wrote:
> On 5/2/25 02:55, Valentin Schneider wrote:
>> My gripe with that was having two separate mechanisms
>> - super early entry around SWITCH_TO_KERNEL_CR3)
>> - later entry at context tracking
>
> What do you mean by "later entry"?
>

I meant the point at which the deferred operation is run in the current
patches, i.e. ct_kernel_enter() - kernel entry from the PoV of context
tracking.

> All of the paths to enter the kernel from userspace have some
> SWITCH_TO_KERNEL_CR3 variant. If they didn't, the userspace that they
> entered from could have attacked the kernel with Meltdown.
>
> I'm theorizing that if this is _just_ about avoiding TLB flush IPIs that
> you can get away with a single mechanism.

So right now there would indeed be the TLB flush IPIs, but also the
text_poke() ones (sync_core() after patching text).

These are the two NOHZ-breaking IPIs that show up on my HP box, and that I
also got reports for from folks using NOHZ_FULL + CPU isolation in
production, mostly on SPR "edge enhanced" type of systems.

There's been some other sources of IPIs that have been fixed with an ad-hoc
solution - disable the mechanism for NOHZ_FULL CPUs or do it differently
such that an IPI isn't required, e.g.

  https://lore.kernel.org/lkml/ZJtBrybavtb1x45V@tpad/

While I don't expect the list to grow much, it's unfortunately not just the
TLB flush IPIs.

