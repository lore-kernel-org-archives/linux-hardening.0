Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679618;
	b=A3rr+QBBS1S+85qt9tCatDCh2TJv4gHt1pEo3fS8WOrdnFD7/BZjlxFFZoJhzAMIEEn/
	 HVGBlBAA+GL0HXCg9XvyXC61KDco5mn1UGOxR8m5/vOqYGgB9oV2XgDYiR9jKslgXInGq
	 UPFSUCw+5a8I6OFXY6jOYiLkeKVl/nuTyFXp7QpOLVaH0T8veebbCn+EzUI7OfNUpaS1c
	 jIYF4t2ReJR1+++iKGR0fT/FKP3/3Fs+sIZdZ07koRAqnQX5NqOUvqY6T3whqu3QNgGMc
	 D8UZfAvidetyujSMDiAIhy6xfhVTyRkzY6E7c7S6SmrUMyodI++LHvCxmt4QiDAkVDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
	b=qPZ8JfZVVXf3wirSQriBbs5V9vvSVn8Pvh8LlWwtjynS4y0o5Q23mPf5xyS+blkLrq7W
	 GQ6SLRitGNCSS5vBWJQu8nyZuMLkp3TpyIBVy02IYvgET0sTNRmu+FkfqUN5ktQtZbze9
	 xOXiLT325Z5JrwdCUmGclRFMrZOF4eW0GN5ATGT6WVC20fEWKoRnlFZH2tCnInVRHZmdX
	 qQ1ioIWahgLit3/qro3Xyd3ZpgP4IWz2Nbb51vHYSGxjh8P+ubBroX9b/jRj12HdVmkA6
	 yb0AMq0vERhP0Jy5pcFWZPV/diH/a6A+Hq9ZBq5zgaLObEzz+gjHtAc6X+VFnEXYHNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PRAZE+RY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF64606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 14:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF64606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PRAZE+RY
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66fbdb0a5a7so315408d50.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 07:33:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792679617; cv=none;
        d=google.com; s=arc-20260327;
        b=c2+HQkBLCYLzQun06kOx97bkaF700kFfyytMO8cXRGea7Dbzy5wjaxXl3Sm6vjlrpm
         pNRyCTImD/PNjbFIRK3q0NSK8tTy6ibrln9CestXC6VWuPNleL8NoQw8yR4KtPPm3hVM
         kBRZkBqIs4AtQKg4D+9ldY1hlj3pddayDHy9AOa0q1fL+ju5YbyAtJJbW27aeP/Qs9z9
         tuuxfHhy9bJ2GD7z7aD+/5yfpn/sq4xTJ8U01Oo3pX9Pqx5lD+hofKPjRqfIaH0dm24L
         1MElWJowZP34l5EmthF4BOwafWiHR01JAJ2JIcWcrf5UDn/iTb7OrlxaJUvPp9ifiWBN
         7yAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
        fh=tDONmAR1XpAXMUI8UoR9p47wvO19xoufsVDNi2lZuyM=;
        b=NYbSOU3vzHOSCTDGU44WH+muA4Sf5GZ1yKWAVeLySTS2LQP2RoTW8Lf/t3fiFzxl/a
         Dcr9rsuKuVF3AltGbTByuBuRlakpTekVdNCoFoor8toK7YtR0t9/f+On5LmJlfukvofQ
         h4jwPWshYgdjnb2FQUmUh4uIFeH+FxONJkF+IRDUn42SwaVTuiOKyNpcMFB4SwqpjPMH
         FaOMpC2g1huJPj5eslpKHXCaGn0knkZX5fwaCP0F5r4teIVHjXVomAa+5AUEHqxBZBTO
         fWJ3TDMPasc5BaUiiCdVPLn317FY7FR8vpHoWMErQjQiH3Kdy1h8tNwgUwwBJ6L6kY4d
         VRvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679617; x=1793284417; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
        b=PRAZE+RYa/Hi/i7xszdGfO18YYUcERJGPuFa0TwZR0t/KCrkPe/l8S2bcMOAWdZjqn
         hDDsdq5ywxDCW1BdnWmT1Vx22odyBbS51VQ8aTxh7sVxlPj39MtKsFf9kaDZRZt6I+VS
         Awo2q4mT5v2dp3Hr8ECD5NRpuvxWXUlDcw+V0hlIOsJyWgEZj3HdmYJzoUsq1EaOzM3Y
         GnFKT0Gabxv9cGavL7y7NU3KcEKv/Ze//jDMDIzwAsmpPiE0Y8yEZRy4JpdbLEC6egvy
         0OB1FVsaeSIl/Y8D7dEWMAKxf5Thjt+K5PGVV7iuV7wyIYxknzWorZgiLk16hIoN5wAO
         u2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679617; x=1793284417;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
        b=gAF2eg1UTNdW3PUb1MDaYwsaSqAqZ1FeocbdzKj+LWY5Nkq7xMaPREhSvd2BCiNv3g
         ZqH5Cq0+zhumpae4ydwqZyIqNaxsl7L+/JbedEno5a39wldhrxRHKn0qcM93bWf1Wwjh
         3CMDP72jpGOf0wcED48/xND9jSPGe3dehzKDKp4wA1vYOj7RJPGjpSrWcm4B/RjD3zxX
         rmLgC80pa7tzAn0wsW929aWzF40g/LApxM2NRDkPvnNEUWS7RoX36Bsl9o1aJEBFPBxM
         IaYNGkzaBvZVYqCFkBl2crFGFL1DDgiFh8r8dhwJB5E63u+BjsXB3DBvCGGTM5U4hRhg
         qobQ==
X-Forwarded-Encrypted: i=1; AKwUvBxt+LTY7HIz3kCOOu8lutELNQBxEQhqgjK3qcZXE915royePbWm79iRFKPZS5GwIetIv6umCCsrM84QMIcDpHw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8PdhkOTqy7S+k8t7u7PWyHUh0yJZAbWX/mU7wEdLmQn/6uM7y
	WQ8zM6xZLcNUrH1L+peXuKZkvy8u3mEHNHV4LzFC5LGaA88l/uCRgwV2DAFoJNYpANuPgWt9xsL
	GgYyoOrxfkr6s6HLjGGXVPsArX2/Wfqs=
X-Gm-Gg: AYBFou2m9t10rjhI7fCGafl3qXBLhNPFHl8P17aJeEmYhTLrs4arDWymhDAvUVmwPsg
	BmIgKvh+ZX+hMav0ketnagthp3Z6k/RsC5qEQvO0afx12IVSmcfYSmi1KAI3wjVKHLakpW7YK7G
	CxjTq3IAQtZ2W71F0g2Psb1eLIdpIIRGEhezj8lPsXYTfgG8umMgAkkXqf8qfdbOIyLJ2ry4RRw
	0QFAnvlBaXCE0lU4iKPLRA53wW9rxZvNq8L47XH5xQAMv50ANBkNYtW5DkYbxzGZAkb5QQTdAg3
	Xp4ljP5dy9dvVOMNXbXMjN5rJTaNLaKczeqGOB607f+/37I/Ru/PNMwWoMy69eprez2YABJbzOn
	3ZwQUg8w+Ev+xR9AS4+MaAFObacV717YfPUQ=
X-Received: by 2002:a05:690e:4504:20b0:679:9e25:316c with SMTP id
 956f58d0204a3-67a0e4f7118mr3858513d50.5.1792679616649; Thu, 22 Oct 2026
 07:33:36 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 22 Oct 2026 07:33:35 -0700
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 22 Oct 2026 07:33:35 -0700
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261022021820.1789083-1-odys.yuan@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
 <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com> <20261022021820.1789083-1-odys.yuan@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 07:33:35 -0700
X-Gm-Features: AclHuK9KZnLcDmcb3UzjebEw_JXnOgl4qhgoWZHIOId6L7KU5VJDln5TqsxLBMU
Message-ID: <CAPAsAGyA=WG=z6a==N3O6oan6WVmZS-VrxEA7SrxRQs5d+Dsfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"

Qiliang Yuan <odys.yuan@gmail.com> writes:

> On Tue, 20 Oct 2026 12:58:54 -0400, Andrey Ryabinin wrote:
>>> +	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
>>
>> Why it's open-coded ?
>
> For the same reason as read_word_at_a_time(): commit ece69af2ede1
> ("rwonce: handle KCSAN like KASAN in read_word_at_a_time()") open-coded
> it "to avoid having to pull the entire instrumented.h header into
> rwonce.h". I kept the six asm/word-at-a-time.h headers to the same two
> small headers, kasan-checks.h and kcsan-checks.h, rather than pulling in
> instrumented.h with linux/bug.h and kmsan-checks.h.
>

That concern is specific to rwonce.h being included from very low-level header
like compiler.h It doesn't cary over to word-at-a-time.h

> Thanks,
> Qiliang
