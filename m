Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA44A2046
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471807; cv=none; b=KL+6eq0Q/VuB1XEZ5LLqBtRhLdekA9ELOJBBk6jVA/Q3WmxDBlUfIJPojqaR0o9IRoVqZYb7fFytTn6jYH9hwaHXTKmPUycEfy7KkQQ4+gyHqVWXQPykQnZXn1KJlEdvCw/8iSUXFs+BAdCFUEsela8BlEAXcUSLuF3eaJxeMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471807; c=relaxed/simple;
	bh=APKTuDGLjMsk92bnnkXJ0rRlkzi8IPJqTj2KURSVBU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkqhMaeAaQKwX0FFw5xTC0peybIA/6iP7gcCGZt2rUusA295R+zLvhgvXafjxYZMtZQ7jxhaNOKLogVRFraP8UOsQbwpnz+AuZE5K0BAPg1ITBk9rU/Y3bNAn3sziTeKKuTD0OyOG7BRdH0YjuC6hjqKfpwEh7birG/vCxT4ZAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfmW0HZG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfmW0HZG"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495437bb891so5802065e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789471803; x=1790076603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dGOErKOPioTgO3v0/s/JdPfHHqPEsYrQAaTIvwRdmxw=;
        b=QfmW0HZGIofUmjnkWGL2TIVkFUxUuxZhOFjQCkuHPy/WVprMzaImb5IXvjMXS/wCGL
         uT++ASkA8Nzq8SsnOaIO0UueO+47EwRvo5F5Q2iv3015O88zbQeDLcIPKzLSIcrifmLG
         RVNd4ny1+Cy+QmrUym6h9ZUTtl8MXydeYJyp4q1FqUlyFJQXlfCStv7fqRBhRq+m6drU
         2MOKbXWfrGw4Cn3wFCJXObY+cq2LnTd2bB/lN0FlToSkrHYz2p1ue1fBhw1OzHr5z4oA
         4tpDK1zE80uk+drClpQQOLiuwshUO/kVmbzbC0pFA/whcZ8lOZHZwDWrcDKDnhhs+UpU
         /o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789471803; x=1790076603;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dGOErKOPioTgO3v0/s/JdPfHHqPEsYrQAaTIvwRdmxw=;
        b=j2hGbAn9xJroNN94YTujeCnuvLdTZXby6mDOeovhAPyF6fRR4G7cqS3RLqSPipb06L
         Az7Xga8R4b3ouyGWgkVYnlJ7pSydEY1//FrYN6oUCE2v1T3cXsDykl8AC7pB4XoJ+TNJ
         3I2UCqRY3sf++byJ/g88Ff1a//aru3WxAUUfb58pPiCrQq38FYaDP4Fyon/z7eYER8eV
         0CO7Dy+ws4lyHisJn7Tjfs52E/S9EkmGPglcORpLmvOnY/gIUk1Civk8A40jd3dK3DQT
         5zkgHp7KeKL+Ap4QjFqEK2+TZUN1Az6Da7mT0oH5QeJxrK74ZC8bnSEJbtX/12JvCT4J
         iSHg==
X-Forwarded-Encrypted: i=1; AKwUvBy3S6zVWAcp7PIYdRWJoEes0zNx19Ff8oVpXk+Kh1rtsSy2PnQ42s5WKaQ4wBZC+Pbka49MH1pcWvfRCkvw8qc=@vger.kernel.org
X-Gm-Message-State: AFuF++l3KxvUxaBderUlUsJXbxA3AooIfhUqn89QoRGUIAuwFUv7K9Hx
	YReeZpE8qlLx0Tbfu3rn9p1XBNRWR1dSUhuSmVehz4ykygFTGaWCftB/
X-Gm-Gg: AYBFou0dn9+ISpyCJD8dlXvMVU+noYST1I5noFhEotwf+r8G2qOMKD5JOHJj2oBRrH3
	Cm08hEi5bHD1pnw09fu4QUGe/hQNLYFQN3yWLowWcRFZQmyQyS9j7hC6DTQIehodUjpNS9X5IfE
	Uvk91U2Xe8xv6W9KQtVVfeG2GLnYZ+eensYP3n8Copg2vCI81H/0SyTUzVaRauLdu6hernJV8p5
	nV/b7n3imV7uGUgPgY7cocqYQ8qm3cshp/NrbqZU6Ki1IE2ZOWXj3aYBWDtov23aOJKMCEbB5Qs
	3Q+oSVIwK1Y10isdbZCv/YM43IjhiQ3s4hcs7G46WJ9N3WadPnaGOoiu9pfE21VPzN5N/sGeQJo
	zoIlFtKfKsEqwIB62Yc53xsm9//v4rPx3LCwdTf0ZOUEx3Lorw07LtaWZsjUyUpiXuRKdAA3eRL
	CsINeLfQLuM+TSksvIXUGeTkqYyrpMZWBCmgWblTP6IaZXADsAChS77Z61eVXzNxF5fnFICID0+
	VYwv6xXBUOZPeftGLuBxdAcgnKuOIWz6TDi
X-Received: by 2002:a05:600c:33a1:b0:49d:28b1:260d with SMTP id 5b1f17b1804b1-49e7d74ce16mr30558965e9.12.1789471802734;
        Tue, 15 Sep 2026 04:30:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32d3c7sm31448164f8f.10.2026.09.15.04.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:30:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:29:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Alexey
 Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 17/21] objtool: decode instructions and resolve
 branch targets in parallel
Message-ID: <20260915122959.2348bf90@pumpkin>
In-Reply-To: <aqkR9Xqu-0Tem1zm@gremlin>
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
	<20260914-build-speedup-v2-17-39817ec5db23@kernel.org>
	<202609141112.F8983EE9C@keescook>
	<aqkR9Xqu-0Tem1zm@gremlin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 11:09:25 +0100
"Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> > > +static unsigned int decode_threads(unsigned long text_size)
> > > +{
> > > +	const long nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> > > +
> > > +	if (text_size < DECODE_THREADED_MIN_TEXT || nr_cpus < 2)
> > > +		return 1;

The text_size check ought to be before the sysconf() call.

> > > +
> > > +	return min_t(unsigned int, nr_cpus, DECODE_MAX_THREADS);

Why min_t() -  you might as well make nr_cpus 'unsigned int'.

> > > +}  
> >
> > No, anything using _SC_NPROCESSORS_ONLN internally is wrong, whether its
> > pigz or objtool.  
> 
> Why? We shouldn't cap a 4 CPU box to 4 CPUs?

You almost certainly don't want to use more...
(Unless they end up waiting for disk)

> 
> The idea is that the empirically obtained 16 core limit should naturally be
> capped to the number of CPUs.

The 'empirical' limit is very likely to be system dependant.
There might also be situations where you don't want the build to run as fast
as possible because the system is performing other workloads.
(Not to mention if you have had to add tracing to find a bug.)

> 
> I guess in a world where make hands jobs off this could be dropped, though,
> if the complexity there seems worthwhile.

You need to pull tokens out of the make pipe :-)

David

