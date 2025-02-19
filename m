Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4EB1F5434
	for <linux-hardening@vger.kernel.org>; Wed, 19 Feb 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977989; cv=none; b=ktcRO6KWYXlESEYu4QTszYbi9RFpKZ6jMbmNmoFIg81uJoHOFf4ybkDWgSQuvWK/bjJvoixquAXPvEgCTme1MizKzgHsR9ZQ3WPah/DLz/JY43eBaMD/TlZdv595j9F4adnhZuatSuQHM/ZwnDILR8WBtqe2zvFFuhgas5wVQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977989; c=relaxed/simple;
	bh=YEDFkhBYjRhP5Z93Fy/FXNH8qcO0tYdixMhBiEsACWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERSmJ+lB583A6mMspK40mrkHw7sIFcsCVEzhKlrT0JgUY6jvdtMv6B32MkbAnF12ARjdtOG3YdLRJE77KYhILm/XA2UzAe6azxKPkN4O0X/z3Hsik5iqyo/Gk+RHlVEnO/boSvg4qeDAZGiQOP5kOrHnTDTFrssS+JK8Zd+unLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GW9GPyek; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GW9GPyek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739977986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEDFkhBYjRhP5Z93Fy/FXNH8qcO0tYdixMhBiEsACWQ=;
	b=GW9GPyekQTHonsiuL57zD47+u+pvv3Zl7lMu41Z4O6mg0ReVmlHevyBl3eQBcru2N3jwZu
	k9R27JRRiNS53QWSMhSBaGNB9Ms8uh7mZTmLrVdVRZfz0VvxIJoPta3YcWzLr6/O0bp4GK
	9E3HzKLwpohKweKhoeD8s1HfvoR3VBA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-vy4FT2CZPC-USO9p0MWmqg-1; Wed, 19 Feb 2025 10:13:05 -0500
X-MC-Unique: vy4FT2CZPC-USO9p0MWmqg-1
X-Mimecast-MFC-AGG-ID: vy4FT2CZPC-USO9p0MWmqg_1739977984
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c747c72so34917435e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Feb 2025 07:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977984; x=1740582784;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEDFkhBYjRhP5Z93Fy/FXNH8qcO0tYdixMhBiEsACWQ=;
        b=CwEKJFJmBQXoeeZiug3lVnDf5deqhbEvPuzCku2Ydx2AwXDtQV9rkhqpMj0GFxKg6o
         1Ny5yvmZUeWv8RV0rI8WxcwH/18Wj3FZSnpGKvs5TwS1T/VXq4k9CQAnqeBVrv/WHN+H
         73B7pUKWRxtzT2SU2AWl51d1b8DFHYEfZZ+H+AtyUP67WVJcJ13Py6bCId4aai0gGhTr
         22kr3gjd0T8esHl1PcCQluC1TtWRei6s9i0FmttoLbn1uiSoabm5W1smE+EuHqbJj7LR
         lItk7Od22ixgcbUDspvwT7gVbXjKmVwhdeIm58k/i0Bb5up+z8n7EA3aTuxxkftSpMuU
         0TKw==
X-Forwarded-Encrypted: i=1; AJvYcCWTJPowFDAtTKjw7uXsJyNThOHNCfSWCLvc3ipSo3Fw9T6UZWQfAfS5HkZEEJiUmaA3u6K5opGahH5NwRpSZQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxss5awKZrDyl4k3b0qyI1nQD3o2N8blPz1Amn4JSvObS3AwT/U
	gBD9CnwLBcUwiKD9aM2cECMks1XbKoEvJRigKfn1WBYF7uGSG5b7AvQiRwhsmkQWlB5Y5Nqfy9A
	eG0QmxE0anfoihDcZ+A37m8AholWBTr11DIIf/mszqfumCluOGHpqEXqGZRyCT+TZ0Q==
X-Gm-Gg: ASbGncsmBlfwJazVSNSHrYUORxdR6rbla4JV4Cbs1GMfQx6/9FlEVhu0D3urBt0SLe6
	yviv5QWseBOVBSkU8LpRbdUq1riraEcP2PdVh2MDLPePeM2SI5TdG4WEvCLC02ZA//iP1xKUpF6
	UK0fOIEBAWfKlKI3Q5YOx2kO/JknfVK8mo/PMmaVa+LGBK/l5sGupaT56LxiscJsSyowfuc8qq9
	2KYm2zZYi6NKtK+tQw387XiG+mA080PoPuo0q3wWJmnrERKk0od8Kgycbe0HguOGOL7JFGaAE/L
	F26l7rJdlpCmBxUM3JKCxoLKxf9L1oli7U2fhVxCGJtJ14S4NCbuif8UnxCHbLs5nQ==
X-Received: by 2002:a05:600c:3d0b:b0:439:88bb:d02d with SMTP id 5b1f17b1804b1-43988bbd322mr97619205e9.2.1739977984080;
        Wed, 19 Feb 2025 07:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqXB0SvUjV4zwF8A6smqwc0vRSLTkn6r2mJurV/wBBuDlOIkQeOJi/olfCVvoVfIVGXKI8cw==
X-Received: by 2002:a05:600c:3d0b:b0:439:88bb:d02d with SMTP id 5b1f17b1804b1-43988bbd322mr97618455e9.2.1739977983617;
        Wed, 19 Feb 2025 07:13:03 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439858ec5fasm88121225e9.29.2025.02.19.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:13:02 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, Jann Horn <jannh@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <d0450bc8-6585-49ca-9cad-49e65934bd5c@intel.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
 <xhsmh34gkk3ls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <352317e3-c7dc-43b4-b4cb-9644489318d0@intel.com>
 <xhsmhjz9mj2qo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d0450bc8-6585-49ca-9cad-49e65934bd5c@intel.com>
Date: Wed, 19 Feb 2025 16:13:00 +0100
Message-ID: <xhsmhh64qhssj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6bAYbuaTH7smYkohVT7KBhi2bTRtj49ctBntWWpDNkc_1739977984
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 18/02/25 16:39, Dave Hansen wrote:
> On 2/18/25 14:40, Valentin Schneider wrote:
>>> In practice, it's mostly limited like that.
>>>
>>> Architecturally, there are no promises from the CPU. It is within its
>>> rights to cache anything from the page tables at any time. If it's in
>>> the CR3 tree, it's fair game.
>>>
>> So what if the VMEMMAP range *isn't* in the CR3 tree when a CPU is
>> executing in userspace?
>>
>> AIUI that's the case with kPTI - the remaining kernel pages should mostly
>> be .entry.text and cpu_entry_area, at least for x86.
>
> Having part of VMEMMAP not in the CR3 tree should be harmless while
> running userspace. VMEMMAP is a purely software structure; the hardware
> doesn't do implicit supervisor accesses to it. It's also not needed in
> super early entry.
>
> Maybe I missed part of the discussion though. Is VMEMMAP your only
> concern? I would have guessed that the more generic vmalloc()
> functionality would be harder to pin down.

Urgh, that'll teach me to send emails that late - I did indeed mean the
vmalloc() range, not at all VMEMMAP. IIUC *neither* are present in the user
kPTI page table and AFAICT the page table swap is done before the actual vmap'd
stack (CONFIG_VMAP_STACK=y) gets used.

