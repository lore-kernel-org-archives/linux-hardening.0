Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BE1FE463
	for <linux-hardening@vger.kernel.org>; Wed, 19 Feb 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981905; cv=none; b=Bx7NH4nW73vye1JGxHnO2JcWBCLGqSg5OstZXUlighsiOg/2os+rzmMi2ZoV0B5nSs1vqQb4TtAvr9y6AJQRYwMxcavHLCOzCKYvj4CUDSkvCIYKyaOS2Zuv7YW7RLjn/EZ6WxE7c/778KnEWSmpVP1/285ZzT8zVYflNzGHrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981905; c=relaxed/simple;
	bh=/+vVVMJTXnY0V8Ji7GQili3vpyK+jYVcqRgGTJ9UsZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tOE+50pZLYZLbxjg3GL3WKVN5eHrqYhZ0w973ZYkWROJAu7NVvFeruv5vg/DgHlTIyIUxdeJn8BXHG+DtJEjHxFaFCqUAgGBIe+d/8Oi3yecEi89EQKp0i3CIDUWllY+uCRoMdIGfq43wgLBx+5NhLxeluwg/12CPAsyyP1YzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhlsMIoc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhlsMIoc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739981902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+vVVMJTXnY0V8Ji7GQili3vpyK+jYVcqRgGTJ9UsZo=;
	b=ZhlsMIocp/cJ06u5GP0r60IFUL2aS3+UIBUmK3REyDawooZqOmWwcwOPVlu2nCR+708hYp
	wjej4+EH3RzssvbOViASUU42VH1645AG6hHNHEkJnIEGjZayuW+qI89gmWNGJ8cDZ7LWq2
	HasTBC69y/iNAN1NYF2tjgRLU0wKEtk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-hsBrk-wUO3WYnMreFrrw8A-1; Wed, 19 Feb 2025 11:18:20 -0500
X-MC-Unique: hsBrk-wUO3WYnMreFrrw8A-1
X-Mimecast-MFC-AGG-ID: hsBrk-wUO3WYnMreFrrw8A_1739981899
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso58176315e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Feb 2025 08:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981899; x=1740586699;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b38N2G5pI18KXCo6dYoQ0A/4T04VhxVdQ6rNeU31Ph8=;
        b=YDGzaM7CwOv9+3KOnTodtbqk2vSdkhLOqhlorRa5TokpecnJSjuQ8ter8sycRP1ZLC
         xBiUd3CbMtKpXxp+O9/vYwaOEfqqtSzADZY9Cs8/1X+SyivyD9R9rXKHksLny+z3vr5L
         Dv0VjGTgRqlehQiaCsopONv3ke+K+1Yoyu30yeCmQrvcXCBSXv9MJFg52xO5HK2OF3Rb
         Nxr/z0s7dEnxmgmcE47+cA7WIHkYOQeal+ebKaofaQEdCqJV+Fueko/iGMHKC7PAh4rV
         NOzbOoqQkUMCARwQZsmfHul7u3SmxIM85QcLCG3c+wBVZpCuN3noqvQ3EERgi2M7qyN1
         ipbg==
X-Forwarded-Encrypted: i=1; AJvYcCWX+5SceVmuQCHDROR3q2lEmsDhEq22Z8L4WA06iDBdC8JKEkl2MQFKcFaGYOI81NkNmeYoHByPAGrCBaheZho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxV+zgFB9RDAjDGpSYB3vvde1+Lhzrg/ZMPLbigfg4TYNa1uh
	CplRG2h6X0KqwUPA6rqzITLmwo/76tBH1KiZkqCgM5k/SZbBPaU7o9O+3+WeW7dRMEjV0b/jnai
	sx9k0gY3yF+SLf5FTWZQS0IXdhMaCJyXjg7dZMDjYckIBDKKeQlH88e2QNGd9Z3t69Q==
X-Gm-Gg: ASbGncu1QONrx1b1Dj2IpCugxoBjRD1+mLNDM89VZcesDTiNBwP7xdvZ3P+cCDDNNnN
	1rdWARL7Gp0OPNGUFkY5gPj/awQoItXfrXyHf7HZ/N2z3glKGQhSw+nuJj9pq1PmMxl7c17fI+I
	yU3gE3GBwir4LOIl9i3owLsQsj9fDlfT735LQfer3l1KkcdNTCXlE8PoAKuNp84Lfw+iHEaEC9U
	EWgUND0jhy88UrUPE+qXJmi8oRuDx6twWb5fu4EYf73pDgup/GxmlnMJh/VGKogRCczV0NV+4/1
	qM1lz2JJMx9YzhnCItZbM79l0ze8BcecMsj6wdGugNvJd8JjYlwazSpaCT2x4a38NA==
X-Received: by 2002:a05:600c:5246:b0:439:9d75:9e92 with SMTP id 5b1f17b1804b1-4399d75b257mr27951075e9.28.1739981899364;
        Wed, 19 Feb 2025 08:18:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrgaKWzB18Ksr+NPSQeT1o3+i2kAVUfh7lIILUz6n7wULpVTIiD8VAP1UIlBXohEkgY6+FYQ==
X-Received: by 2002:a05:600c:5246:b0:439:9d75:9e92 with SMTP id 5b1f17b1804b1-4399d75b257mr27950675e9.28.1739981898863;
        Wed, 19 Feb 2025 08:18:18 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2591570esm18461449f8f.59.2025.02.19.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:18:17 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, rcu@vger.kernel.org,
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
In-Reply-To: <20250219145302.GA480110@joelnvbox>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmhzfjpfkky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250219145302.GA480110@joelnvbox>
Date: Wed, 19 Feb 2025 17:18:14 +0100
Message-ID: <xhsmhecztj4c9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4rQyZMWgeJlYhkT46IcZNHb26ohQvg_kCngTA0NkSU8_1739981899
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/02/25 10:05, Joel Fernandes wrote:
> On Fri, Jan 17, 2025 at 05:53:33PM +0100, Valentin Schneider wrote:
>> On 17/01/25 16:52, Jann Horn wrote:
>> > On Fri, Jan 17, 2025 at 4:25=E2=80=AFPM Valentin Schneider <vschneid@r=
edhat.com> wrote:
>> >> On 14/01/25 19:16, Jann Horn wrote:
>> >> > On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschnei=
d@redhat.com> wrote:
>> >> >> vunmap()'s issued from housekeeping CPUs are a relatively common s=
ource of
>> >> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
>> >> >> flush_tlb_kernel_range() IPIs.
>> >> >>
>> >> >> Given that CPUs executing in userspace do not access data in the v=
malloc
>> >> >> range, these IPIs could be deferred until their next kernel entry.
>> >> >>
>> >> >> Deferral vs early entry danger zone
>> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >>
>> >> >> This requires a guarantee that nothing in the vmalloc range can be=
 vunmap'd
>> >> >> and then accessed in early entry code.
>> >> >
>> >> > In other words, it needs a guarantee that no vmalloc allocations th=
at
>> >> > have been created in the vmalloc region while the CPU was idle can
>> >> > then be accessed during early entry, right?
>> >>
>> >> I'm not sure if that would be a problem (not an mm expert, please do
>> >> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
>> >> deferred anyway.
>> >
>> > flush_cache_vmap() is about stuff like flushing data caches on
>> > architectures with virtually indexed caches; that doesn't do TLB
>> > maintenance. When you look for its definition on x86 or arm64, you'll
>> > see that they use the generic implementation which is simply an empty
>> > inline function.
>> >
>> >> So after vmapping something, I wouldn't expect isolated CPUs to have
>> >> invalid TLB entries for the newly vmapped page.
>> >>
>> >> However, upon vunmap'ing something, the TLB flush is deferred, and th=
us
>> >> stale TLB entries can and will remain on isolated CPUs, up until they
>> >> execute the deferred flush themselves (IOW for the entire duration of=
 the
>> >> "danger zone").
>> >>
>> >> Does that make sense?
>> >
>> > The design idea wrt TLB flushes in the vmap code is that you don't do
>> > TLB flushes when you unmap stuff or when you map stuff, because doing
>> > TLB flushes across the entire system on every vmap/vunmap would be a
>> > bit costly; instead you just do batched TLB flushes in between, in
>> > __purge_vmap_area_lazy().
>> >
>> > In other words, the basic idea is that you can keep calling vmap() and
>> > vunmap() a bunch of times without ever doing TLB flushes until you run
>> > out of virtual memory in the vmap region; then you do one big TLB
>> > flush, and afterwards you can reuse the free virtual address space for
>> > new allocations again.
>> >
>> > So if you "defer" that batched TLB flush for CPUs that are not
>> > currently running in the kernel, I think the consequence is that those
>> > CPUs may end up with incoherent TLB state after a reallocation of the
>> > virtual address space.
>> >
>>
>> Ah, gotcha, thank you for laying this out! In which case yes, any vmallo=
c
>> that occurred while an isolated CPU was NOHZ-FULL can be an issue if sai=
d
>> CPU accesses it during early entry;
>
> So the issue is:
>
> CPU1: unmappes vmalloc page X which was previously mapped to physical pag=
e
> P1.
>
> CPU2: does a whole bunch of vmalloc and vfree eventually crossing some la=
zy
> threshold and sending out IPIs. It then goes ahead and does an allocation
> that maps the same virtual page X to physical page P2.
>
> CPU3 is isolated and executes some early entry code before receving said =
IPIs
> which are supposedly deferred by Valentin's patches.
>
> It does not receive the IPI becuase it is deferred, thus access by early
> entry code to page X on this CPU results in a UAF access to P1.
>
> Is that the issue?
>

Pretty much so yeah. That is, *if* there such a vmalloc'd address access in
early entry code - testing says it's not the case, but I haven't found a
way to instrumentally verify this.

