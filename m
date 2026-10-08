Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567424BAA0E;
	Thu,  8 Oct 2026 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470619; cv=none; b=kkDsnKbSF+gH9I2ZF7PD89doGYfzHa01aZdLH7bHsFh4nhZ4EmxbcMBLwesZbYRjuF9oUZenzZcCN5F7vIeot7OYQO6jJGH9Lum5hYJwkJ6qzILWFc41TgJEuSgve57lmPXSML4Sgs0N82fGkc+8aIB4RH6s4UFzZgFHRqZbNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470619; c=relaxed/simple;
	bh=yde/+5LcQoOeRRuVFg6M0zfcbx+JRpuc+eBL1JOnXGg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LEyFS4fa5rXOGFdBXG6yU9swFo7fyd7+3/C1P9pl3g4AjHe7k95aUOKN0RGC8CI6i/ZNwPFGfSB0DBGmmaWU07x5gLWD+5WAuLkOCgAbRc0pl3j/1Xz4TMAghlO8RGT9f+JHO840FCAlMB0nT3gQ4MhH+E8iEALwPYQpFhjs3vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLsNZwMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLsNZwMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D551F000FF;
	Thu,  8 Oct 2026 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470615;
	bh=7uOTQ1zSN0z7Rn1oQH6H1RzY+ERxySKobdm9Rl2nHfU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dLsNZwMFyBCESvGYOGDWC1D0sKe7bhjMtm0c6DdB+oUOqt+ztaLSTtWPvMEyomDvU
	 cgIDG2YVX/gJTChizcuSpI4PkVmajlwXfIDJN+QXmYD5+us8RCmfVYtKpMuFS1kYNo
	 R3Z6tkDMxKs2Qp0WLLM9PDWFDJQeyAzUAy615Am0nkkBSzN2bCUBboFqLEMeNZ/nMB
	 ZLvKSjY3n8jGh3GTQgiq30WJ/y/6KqTgB40YqGJpSTdSjyWlWAmsRjhQjGe+uWoywO
	 3ccaKfAmC/dg5/Wt0hLillcrmXHs6gdadUffnqS8lbYDkVhyw2pZlTqabKR3XOQz4i
	 X4XA9mEvUb6qw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id F00E1198003A;
	Thu,  8 Oct 2026 10:43:33 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Thu, 08 Oct 2026 10:43:33 -0400
X-ME-Sender: <xms:E6zHarU2u8vRSLjo8VAUSohrBwE9U3EBsC4RdR8buuSDAC8Ueb7alQ>
    <xme:E6zHaua8RzJIskHqMh0dfNFdIA345_M6dUUjASJO7FJyU739ne97ouM_Rh2u4Qu-x
    kthebfPSNQMVScOF_gD0p3ClaUiN8EE0mMK3kFALEjCI0bDUsbf7RM>
X-ME-Proxy-Cause: dmFkZTFLFdKRhLlrwTLld4Wy5+ue4G3ql742LJUzSxdwwyFPrUuXhuYXx1lwJPeWTickYH
    Tgv/MSlKKx6Td3p8bJv42iB4/T7U3vr3Trz7BwNIgpquWNijRyc23PKDK/qFoYIIj2gHwk
    t+LQ310KAqqtJTt8v8YqH8FPKmUuavezeULfNoLP7hIFXsiIk08mtpm14CGs23/9P31oxP
    V6iGIORVZ0TRkkY5nvgOQOvm52JfeAVU/w4szt5HvqUgvfGS6bM9pr7goD5IDia+VLYAmc
    PoXzIxjCPlIhYoT3y+SOkxZ+lwkTYWFGjDMOI/Wj3qrSOiaWu0E04B98xG+1LpMfCbpVAv
    wtzCrGkgg1C6vx8b5i95bsAM79pwvgW1RThVmddTf4HMRZuBFtRR2TeDp7lJ1OIK3Fmksm
    R1gsIXUGpyWQOgXqYsq4QnEJ1hvEmvMZ5KvPykRK6K5QnlWk87U+b+xu3HDpD4KV2+owAi
    0JgkqV/3kz+nkpOJercxkOAsziGL2cg7F5IRr2ygqMkiTYJW9n5K/wGHH++z796K82K6GF
    AOvUIUOhaHlOizyZObBe4uyf/3bcPQc8lw1QtV0n7DiiP/xk0qQdLAyrGEXDbtGz6yL9R2
    J2HijVcfCbKnqWwGCJsqLPMRI1Q+gz0atfEE8U8J/Ez0KhSds0cqn9bc6Duw
X-ME-Proxy: <xmx:FazHaq4iMK2edHhv9xCbhdzbexPdBVyTRyTKfVmH4gW1iZRhNiWdLg>
    <xmx:FazHaldVvQtgn-UHB0A9DZbvMxuJOIkaX5g_Rbx-6D1xqe9Q8INM5Q>
    <xmx:FazHaosWCH-96-sqVyADPPZ5vDl7Q__PpQOR-tbmE4J0WsdSbKXgIg>
    <xmx:FazHatlM1dcnPHi6PwjSaAX5COxKNGjw3ulIPy7S-Kpklaf1DX8i4g>
    <xmx:FazHajS8gViJBAb-_b8-7IXtTmBwzzew1Xm3_ccNenXJilkFDF28Dhie>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C0189F80096; Thu,  8 Oct 2026 10:43:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 16:43:11 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Kees Cook" <kees@kernel.org>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-efi@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Message-Id: <31318d3b-1738-49d2-8017-d4ebf98aa22f@app.fastmail.com>
In-Reply-To: <20261006204210.i.137-kees@kernel.org>
References: <20261006204210.i.137-kees@kernel.org>
Subject: Re: [PATCH v1 0/3] efi/libstub: Build the x86 stub from KBUILD_CFLAGS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, 6 Oct 2026, at 22:42, Kees Cook wrote:
> Hi!
>
> The x86 EFI stub builds from its own short list of compiler flags instead
> of KBUILD_CFLAGS, so options added kernel-wide reach it only when someone
> remembers to add them there too (e.g. for -fms-extensions). Swap it
> around to remove unwanted options instead, as we do for all the other
> architectures.
>
> This will let Clang's -fexperimental-late-parse-attributes reach the
> stub build so that __counted_by() will get parsed without error[1].
>
> Thanks!
>
> -Kees
>
> Link: https://lore.kernel.org/all/202610060642.7C4125F@keescook [1]
>
> Kees Cook (3):
>   efi/libstub: Declare the x86 stub's assembly entry points
>   efi/libstub: Build the x86 stub from KBUILD_CFLAGS
>   efi/libstub: Disable kernel stack erasing in the common flags
>

Thanks. I've queued this up but with a tweak applied to patch #1,
as it broke the GCC i386 build due to the fact that 'asmlinkage'
evaluates to __attribute__((regparm(0))), and apparently, GCC
still thinks that differs from a function without the attribute,
even when it is the default. (Clang built fine)

