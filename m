Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB0395ADD
	for <linux-hardening@vger.kernel.org>; Thu,  8 Oct 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471079; cv=none; b=q1Sp3P28YzmoBTUGdU+w/fPy+1cE3p2KZJLyPx3E8VoXccMgJXyug3WSVPgf0ig/2MGXy/+TgmocamUHDoT5uuqLAnvXTZvWZSjd3Zj1gydG9BUl/SgKqWsDCfhRYaQym8820rVb4+mENOOA5NSAKvUifj8ncomwEO9X56paI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471079; c=relaxed/simple;
	bh=/w8cbwanP0nIcqOL79rBcldHJgis7MtD0k3+J2z/aqs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fH7k8qg9hzjFqwMy8dzAev6rVb0sTqzYFr6NfzQNSUbZ+MpurBXvasAOKRPaoqH2lMdKsbHmWRFg5FgXFPLotSa94eGshNzPDLiav9p206XLCsrNM5fJS9nopBty0mozwaYk8l3d+U0LX8dgiQY3f+9rEEz9yluHmd5JUKwaGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMb9i/2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMb9i/2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0651F00898;
	Thu,  8 Oct 2026 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791471071;
	bh=IhFcqtXgP/Y/UDaKG+nHrekmILKWKzC7a4dx1PkpfJU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DMb9i/2z+0sEQpb7Aacyn27ruBAB/RlXFB2pryyt0Lpi+EeBhwasq9FvUyuPoLxKw
	 slBMHNX5axGI8P0R5wWx4VxsMlX2JgIOZ8NYygs7zTElIXQEFKcBMvH2H/YMFlfcnV
	 JkdAi/fCcmMdpi8InxGnL7NkJhh3nUj3fjrjWm9/ro4JE4k0TjjCZ7aHhwOYUdy2TZ
	 II12PzEmN1EdJyEGO7WulFW6KPoU6r4jPyBeOIZBw4PeDGhXgNao7TdHqBIjG+ELAx
	 DHRVgvwwfIz88P4bZ99ttkGL6us6ZArTQ52gBS6wA7e/lJMbOZ94c8WIbhmlK+Wafs
	 Ajv0soHDqxhog==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id D85F9198003A;
	Thu,  8 Oct 2026 10:51:08 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Thu, 08 Oct 2026 10:51:08 -0400
X-ME-Sender: <xms:2q3HalnKwR5pNQq-r23YlN9LxuDfVddBhFR2i6yqp2jbgetolKfOkA>
    <xme:2q3Harrx6cesMcnsgGqz-8g5EcrGtdLodFVEeNBBi2ZpGxxS3oxq5hu-tyqxjo0KI
    21usMXYN7IikiedDMOYQ7mXbJywNgpFq4rzvhd6nYjz7hcXyWxrw5Q>
X-ME-Proxy-Cause: dmFkZTFhdrcZHg/HUt1BCIUXvyAVZcyOUtgS/v5r46GNwjIzMsueqgvDArJGGnoJPsjKYu
    KtBK1FKXl9NOyCna4BmbbnlElOHgC75s8BrwSk19flngtfhkPOqildsO+aqVEf02QeZ3v5
    8r4mAWXwsJJjP34oMfyLYjVZKu5PHZVpglg1kSdnvb3jHaLlQfolKzajeiEEalcL/RxpSr
    isebveRA+WPQQ9Zm9ZatVj2Xdfe9+XPgeFg5V5tIr8HalLFUSdF2xjsN8dXI2brEpTlikb
    HzlqeiErj8+Wv4og/pPIewaQApSVasgc5JFLVyURbb5pXe7UUHjusQhBTFU6SWBu1vXMMq
    lijkn1fUjxzz6h8deCjndrpZHQ3R/eJvj0gNrC3ZNrLB2/FlC3uZ4gsDM2mJIhdOXieOpv
    Cu5UThoBLLf/+FXJCwxUDjZs15EmRP7CdH/X5ahhBRJyte9xtD1N0B3hdmm7+m8CNDoV6F
    ivtI+/wa8Upf7Sjrt7xArYvLx1wf+GS5HUWOWm2J52QHkkE9N3KtLf1KfOhaw8Wml5pN+N
    8KfbvlR8sTh4u1Qbd1oBmgYtUc042gVC0u8+e4d6GPJbkf/l4i+Z+gYPns+T1AxjTXrQvR
    nVmq6BtvS9GB9s89To6OrmsyePzZBMvySKtaMvd6TkbRohj9DgG9fU7x6ttw
X-ME-Proxy: <xmx:3K3Hap9Nh2YniFF2-DZhjWqId3toMRgk7Bfut1yB9kTdqP8aABNPUA>
    <xmx:3K3HapiGs1SbxXk_fvuDA31aWT7r8gFzxFrXN5Jln2tE1A7u1xJdJQ>
    <xmx:3K3HatcC5Fp31Za97CHWbCmCK3I-uq6WWR4_9gsamRDWNT1lcQvJMg>
    <xmx:3K3HaqJkATLrRd78hdvGimkghrRs-CUyAKR-I88v3qoXNQSmKDoEGw>
    <xmx:3K3HainYAwAkwfpfMI_5vaQCk0OSxEJsl7N0IGXVau9GJPgR6ZKURajY>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4455FF8008E; Thu,  8 Oct 2026 10:51:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 16:50:44 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Nathan Chancellor" <nathan@kernel.org>,
 "Bill Wendling" <morbo@google.com>
Cc: "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Mark Brown" <broonie@kernel.org>,
 "Marco Elver" <elver@google.com>, alan.maguire@oracle.com,
 namjain@linux.microsoft.com, "Peter Zijlstra" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <bc2e2ae7-02e7-4148-8ad2-ab3c1af3dd7a@app.fastmail.com>
In-Reply-To: <20261007093641.GA1527653@ax162>
References: <20261005102518.2400984-1-morbo@google.com>
 <20261006094358.2948476-1-morbo@google.com> <202610060642.7C4125F@keescook>
 <20261007090915.GA1504630@ax162>
 <CAGG=3QXPAa-i4r3Vv6-q25A6EvsxGb5RDLn02z1=a5zo7W-7Vw@mail.gmail.com>
 <20261007093641.GA1527653@ax162>
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, 7 Oct 2026, at 11:36, Nathan Chancellor wrote:
> On Wed, Oct 07, 2026 at 02:32:45AM -0700, Bill Wendling wrote:
>> Ard,
>> 
>> What's the reason why x86 doesn't need the KBUILD_CFLAGS flags? Is
>> there something that breaks things?
>
> I think it is mostly historical. See Kees's series to address it:
>
>   https://lore.kernel.org/20261006204210.i.137-kees@kernel.org/
>

I've queued that up now in the EFI tree.

Do we still need this patch then?

