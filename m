Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259B374183
	for <linux-hardening@vger.kernel.org>; Wed,  1 Apr 2026 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045024; cv=none; b=qD7f2w+dMfAjM7koSZZODxgl2xxjtsg9oUtOK23/A4JwZDP9K3wOj9i+96WbViJiAkYYpMIGNtWBEeJlnwkBeT+XCARlbjdnahYZPq3mIn2iMI86grokbv+e9RW5kkU/XEmBcdeV7VCyaeXg6EacspfYdCjbXbLj6Bawg0bGVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045024; c=relaxed/simple;
	bh=hCs3gNjx+jcXSRozFFYMPzrJYE5HyYdfubfGLgAk+s8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JD7+MRd6VmSeOATFr+CyZjVA89R0rpnhvdYVt2MjduDT+lDHoTSSpaL6wGJfPHiuAYU7KPsKa+f2mNxPi+b5s3R6JSfOsBYZmqIvcbDP71n8SbQu1I/uoo3dam4h5mvKTkqr9SCAkrJUF3BFFhuCjF1N9swFb0tNh8IV8IfpkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz3yXk85; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz3yXk85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A99C116C6;
	Wed,  1 Apr 2026 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775045024;
	bh=hCs3gNjx+jcXSRozFFYMPzrJYE5HyYdfubfGLgAk+s8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Zz3yXk85z+ao70V4KUJhdaAwcRYYpiW9NcE9wlBqutL0QtAJm3hh92OBa+hjnmUCD
	 W33ZYpHndN8R8lRTjhMdD3xNvBNHE5ceMkHknh6OHWirwXmQl3QKvsGfhqQg9V1msl
	 NKq0SYnU3zvDHeO2JrXVbzvpLnHqdLiZ6g5fMeF9fa7iHwJ5tnyiX4c+AITPo9it7d
	 RRCwXHv+uoVkx4aiGa3bsYbFyTbA9hLQHhSdfqOVeFlj0LXsZ6dVGLSmg1usXIi6jS
	 S/VCNy0QgVsKftYl80SQvrv6yAfP2EnTD2w0d6Gc8dSvCoNUrauoqpOkjCpzS4PlVP
	 2HGdl52tBqHYA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D03F0F40076;
	Wed,  1 Apr 2026 08:03:42 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 01 Apr 2026 08:03:42 -0400
X-ME-Sender: <xms:ngnNaZew9n3oO_T4gpuqodYV61O69qIRzRfLBeCIEaN1KRV2QYJnnw>
    <xme:ngnNaSCuc91kCAbgI70eyCaXE_QbgaHCOfakieo6F9ywNFNV6jOWHaotycb16GkAh
    42wWGKbt2zJQgRSRJsH1nJPeoIa2dxHi-iAXJTZJPBta7m7KuGp_bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcuuehi
    vghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeekvdffkefhgfegveekfedtieffhfelgeetiedvieffhfekfeeikeetueegteet
    teenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppehkvg
    hrnhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsegrnh
    gurhhoihgurdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghr
    mhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprh
    gtphhtthhopegrrhgusgdoghhithesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghm
    lhhlrghmrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehsrghmihhtohhlvhgrnh
    gvnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgvrghnjhgtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopeifihhllhhmtghvihgtkhgvrhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:ngnNaTdtZD2b1koNUV8Sso6dxU7WASN8T8ZQKnEKWy16A48-MCCG7Q>
    <xmx:ngnNaWvNgzi93JclnfMD8cfwbZADrUNsoVnr8wNhlTxgcTxnaf-4NA>
    <xmx:ngnNafKLFkHFXeR4eiYn9Y3cFtSrsgzgmr2nEgL6HIWtTv-VMgGjTQ>
    <xmx:ngnNaaZP5J6-abYSW4yZILL-NTXEX21-zhaeF3zQOW53q6QXOq2vPQ>
    <xmx:ngnNaSlVTVhxco218T8XnSqITbDl0WyHDNlq_QeUfEIvG1Q_h87FX3W_>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AC5C8700065; Wed,  1 Apr 2026 08:03:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Anx-CxvWeZ1g
Date: Wed, 01 Apr 2026 14:03:22 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Will Deacon" <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 "Ard Biesheuvel" <ardb+git@google.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>
Cc: kernel-team@android.com, linux-hardening@vger.kernel.org,
 "Mark Rutland" <mark.rutland@arm.com>, "Carlos Llamas" <cmllamas@google.com>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Sean Christopherson" <seanjc@google.com>, "Kees Cook" <kees@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Will McVicker" <willmcvicker@google.com>
Message-Id: <2b0b9c69-650c-46bb-8579-4af85c17b8ab@app.fastmail.com>
In-Reply-To: <177503506493.2514486.12265333685036392947.b4-ty@kernel.org>
References: <20260331110422.301901-2-ardb+git@google.com>
 <177503506493.2514486.12265333685036392947.b4-ty@kernel.org>
Subject: Re: [PATCH v8] arm64: Use static call trampolines when kCFI is enabled
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Wed, 1 Apr 2026, at 12:03, Will Deacon wrote:
> On Tue, 31 Mar 2026 13:04:23 +0200, Ard Biesheuvel wrote:
>> Implement arm64 support for the 'unoptimized' static call variety, which
>> routes all calls through a trampoline that performs a tail call to the
>> chosen function, and wire it up for use when kCFI is enabled. This works
>> around an issue with kCFI and generic static calls, where the prototypes
>> of default handlers such as __static_call_nop() and __static_call_ret0()
>> don't match the expected prototype of the call site, resulting in kCFI
>> false positives [0].
>> 
>> [...]
>
> Applied to arm64 (for-next/fixes), thanks!
>
> [1/1] arm64: Use static call trampolines when kCFI is enabled
>       https://git.kernel.org/arm64/c/e70c2335f889
>

Thanks,

I just spotted that the function name gets stringified twice inadvertently.

E.g., the assembler may see

.quad "__static_call_return0"

rather than the intended

.quad __static_call_return0

The assembler does not seem to care, and still emits an ABS64 relocation against the correct symbol, but it is definitely unintentional.

I can send a follow-up fix if you prefer, or you could just tweak the patch in place:

--- a/arch/arm64/include/asm/static_call.h
+++ b/arch/arm64/include/asm/static_call.h
@@ -16,7 +16,7 @@
            "   .popsection                                     \n" \
            "   .pushsection .rodata, \"a\"                     \n" \
            "   .align  3                                       \n" \
-           "1: .quad   " #target "                             \n" \
+           "1: .quad   " target "                              \n" \
            "   .popsection                                     \n")
 

