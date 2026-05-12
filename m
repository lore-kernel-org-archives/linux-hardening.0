Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134001A267;
	Tue, 12 May 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590599; cv=none; b=ZoiA0zjihEURHcUGLHJL8kDoPhk+EiiaYWp5i6WbQq/b+Ihsb/Oml6u6L6VH1OEYxqjJ00m6vMxnVoQNmlG+eNghCkwTt9QdvVVTudN+BQVBjAQtBZkuPDoCjOKbLL0Yxzc21UmY1hpik9itVsXPekKfe1PcmWdcZLerkL3ld68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590599; c=relaxed/simple;
	bh=Wh+lZzPFifVjKQxtwMnmuUW6xrspawFbZuPQ2q0YSpg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UHzsbnaL0G7upbPeTsZe7W/x7qe+VB0jLUFJsTr2e/1dRGBu1dz4E47rLf1lgjaIzR7q5XiaazEu6Xrggi+wX1o5xe57/OnWIw2wSgpdJ2B0+c6GvqOKj8EyWzBIE1w4pRYTJPk2fTklc0CLtH8YOJuMh7YeD90zlEpDMrpJkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmKf42NY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmKf42NY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E623C2BCF5;
	Tue, 12 May 2026 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778590598;
	bh=Wh+lZzPFifVjKQxtwMnmuUW6xrspawFbZuPQ2q0YSpg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DmKf42NY0WWRlCkkNzExpTYBmIQ9HR2Doig1JCAiM4ihoFWAuc3Y+jenpQBYH9ouN
	 CL0jpI7Lnp9A0611CRZs1ZZIT5Vghp2ksNxoDzCBv0nzMfFX7zITspw9YKuNE0TLMY
	 gk6sU3nlffh4023Q1JioJOXjMlVoSsyxtYFE9Eb7V+9U5Z/EK6yqeyD6Xnk9ydaUaA
	 yqTCM6RLXromyApfdUkRviOmb+DSeynH8dazyjF6aXYfHYeEd7p49AUIWJmTN86qNc
	 33LuNGnkfvhy2kDKUU0yPz3OVRwxECsq66+VBx7Q8JOm9vjK3uWKpu1g7z9o3ZDuwz
	 w2CfjG6Uv46IQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 83F93F4007B;
	Tue, 12 May 2026 08:56:37 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-01.internal (MEProxy); Tue, 12 May 2026 08:56:37 -0400
X-ME-Sender: <xms:hSMDahjr8fBgo0X2A2B8pbiCglvSsihFvMy8aFmE9oRvch_oaIh0mg>
    <xme:hSMDag1951UAdP4pjap-AlawMUnIDjVlal4tByB7vjVGOV7cJkeYwt8-wXc4lc_JO
    RNfZDYr-iMFO9ZUB0Ip3zzKeIp63vMsMYZ5dPYKJ3MJn_WRlGxvIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefvdejhfelgeefffejgfeivdejvddvleevffeuffduhfeivedvudevveet
    ffejheenucffohhmrghinheprhgvlhdrrhhonecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppehkvghrnh
    gvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohepudejpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhshhhumhgrnhdrkhhhrghnughurg
    hlsegrrhhmrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghr
    mhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprh
    gtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomhdprhgtphhtthhopegr
    rhgusgdoghhithesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrnhhnhhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtoheplhhiiihprhhutghkrgesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepshgvthhhjhgvnhhkihhnshesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepuggrvhhiugeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hSMDasgmoBdlr5QNfHwUEzI8JmBqWi4-fEZBraqA5kxJ3519fRwUDQ>
    <xmx:hSMDahX96c-lKMxhuUioA8VjgSniJeeFqXTtHKY1vCxuWJ9iBg0Gkg>
    <xmx:hSMDaltCU_8JA2q7fkHE0P2all3FAwUxdl43M7L2CMlgOMCyq8Ilqg>
    <xmx:hSMDaqbBOePMI5ZHODv8aZWZyeiCX99S5zw_gaQs9q_LHhkN8TFMAQ>
    <xmx:hSMDau4zfN_MC61dB4OvUNbnNDrGEzRZ8v3fCbfFfIis_ErU-AQ-YiyI>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5FD6EC4006E; Tue, 12 May 2026 08:56:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 May 2026 14:56:16 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Jann Horn" <jannh@google.com>
Cc: "Ard Biesheuvel" <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Will Deacon" <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
Message-Id: <fb5749bb-bc87-4f0b-9ec9-8a1eb7ded3b5@app.fastmail.com>
In-Reply-To: 
 <CAG48ez2xJwJDgxSH0u2G==9dOQJQxQ7WsQfU14O1H5hEWic1eA@mail.gmail.com>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com>
 <CAG48ez1DJ88a0pBCE-Q0VXyDuJgng8zdunb38g4b4JPU88exww@mail.gmail.com>
 <31252c1d-a98d-4635-ab61-ce5b649e256f@app.fastmail.com>
 <CAG48ez2xJwJDgxSH0u2G==9dOQJQxQ7WsQfU14O1H5hEWic1eA@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026, at 16:40, Jann Horn wrote:
> On Mon, May 11, 2026 at 10:59=E2=80=AFAM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
>> I think we should simply do something along the lines of the below,
>> considering that the size of a data object tends to correlate with
>> its minimum alignment.
>>
>> I do find it rather puzzling that the compiler emits empty_zero_page
>> *after* zero_page_pfn - ideally, we'd combine the below with
>> -fdata-sections so that the linker sees all individual objects, but
>> I suspect that would create some problems elsewhere.
>>
>>
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -452,7 +452,7 @@
>>  #define RO_AFTER_INIT_DATA                                   \
>>         . =3D ALIGN(8);                                         \
>>         __start_ro_after_init =3D .;                            \
>> -       *(.data..ro_after_init)                               \
>> +       *(SORT_BY_ALIGNMENT(.data..ro_after_init))            \
>
> Oh, neat, I didn't realize that's possible. That seems like a nicer
> approach...

Neat but rather ineffective, unfortunately. (I don't see a size
difference with the arm64 defconfig kernel)

Given that empty_zero_page only ever gets its address taken, we
might just move it into the linker script if that requires tweaking
anyway. We can just place it at the start of .rodata, which is
already page aligned on most architectures (and will become page
aligned unless EMPTY_ZERO_PAGE is #define'd by the arch linker
script to something else)


--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -472,6 +472,17 @@
 #endif
 #endif
=20
+#ifndef EMPTY_ZERO_PAGE
+#ifndef __HAVE_COLOR_ZERO_PAGE
+#define EMPTY_ZERO_PAGE                                        \
+       . =3D ALIGN(PAGE_SIZE);                                   \
+       empty_zero_page =3D .;                                    \
+       . +=3D PAGE_SIZE;
+#else
+#define EMPTY_ZERO_PAGE
+#endif
+#endif
+
 /*
  * Read only Data
  */
@@ -479,6 +490,7 @@
        . =3D ALIGN((align));                                     \
        .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {   \
                __start_rodata =3D .;                             \
+               EMPTY_ZERO_PAGE                                 \
                *(.rodata) *(.rodata.*) *(.data.rel.ro*)        \
                SCHED_DATA                                      \

