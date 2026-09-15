Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA543D4EC
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494976; cv=pass; b=elpvHopXPcSI3gvl12KpICOdEOrwQpzfMqADtDWy++ducG3zmN8YmDujKSL1HQmUoIbx0WPE+JCkJg0NaGqBC+RSc6J4uoQKVzO82lenGBi9m1K/4AqPLpkMCzavughUt1vita+152KUUm4vduDwPFyrcT1RuA3174TASVbFzuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494976; c=relaxed/simple;
	bh=P7a2zFFMvnl7AMMV9J8HoSFvOnO26MuCDolXpy7oTxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPqYqKuZKfgkmTosdfWQRTyVxe3BHPYZ1SbEojgFdQP73zFAQWvCjTI16FAMM7Q06aeOrYoBhZoWhx9HBVHLvUMnf/NM5z86F1NiYvFEAWjaNqI2heCwAYaXEQV1Lv6AL4M0vptj+s250q/p1ywMB2hR/xlJLO/m5D1SCnNpU5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6KqVcGU; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6KqVcGU"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48586861639so537855f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494973; cv=none;
        d=google.com; s=arc-20260327;
        b=l7De/FCiG2u0IeuWG+y3jDizJ+KIz4X//edbxfh2ITEQKI1IQIH9OzA2+grLOlO0M8
         Ei+5xZNwNnclQFfvfPA78NiG3glpbELmxTyzDoWqoY5kIvpYKpPrnL2M7b/Vc/vvF80h
         Gm3L+fcFbtqn5lVfw6OuJasfsvrJnF8r2nbm4Wo1VZS0RmKWlPZfF5lTo8cbkFjGOfyd
         f5TTglMHBR1l1IbDNhKeNUcCFAwKgkPw1GtWpPgEVaCTHkOo/UWVaWm/K7sOXANOCnm4
         ijWtYOoJ/b1tvLJ+FiVnE7kUonsL2kzuYT9aS9mPLS8iRwXvFqB4eihEovHhhlnBTlOv
         krOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GXjIVxCi/wI/JEAgJbDGbjdOXMojQ1soppHskXz6ugY=;
        fh=lvdEvU1Kiyzfh/r8zodOd0t2VDSfq+kg4x0a40KdAR8=;
        b=UfCfd7ZfCrGtt5W/J6+epXMhNTNgt7LYDxbEvbuZh+IhP/VaLdXW5XWdzqeohsiWXn
         sqqgQ5hWTYCI5FS+SIgs/m6o/MW0G2d6+NquRox2DjrgZllLX1w1s6+HuUOl9V5TybAy
         /bNcu74UxZGhHWI3q+AaRRHS4FXvteB1xmeqSb+wtAnssmOXC+KsXvWnUuwUwiDsUN0K
         rwRjyiThewlmM6yiBjIgS2UVo9C1ea3+qO+mjFLhvAXmm01o3ZHlfZ0qjen5YApuc1Xw
         80aA19IybrWCQznTSrMkiwGeUTQgAuTEYWYGScNpgre8KuEJgP02Dsq62P976fQ+OHtV
         o0Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494973; x=1790099773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GXjIVxCi/wI/JEAgJbDGbjdOXMojQ1soppHskXz6ugY=;
        b=a6KqVcGUw2fLFtF1Hm9cc5yrvLvRY7YxPEhLHNJIfcavwgt1rbW5yhhfaSMX9+BAED
         DGIeBSCgb1PlyB68lxCyUYa/zeD7s7Lo+A6Qmv93dYvmxfOjOqiT4T0+b7iIrlo89kl3
         YmXf3optvEP5cx8oa/c2vYZz/Cpd/9YBfStzMILEteq521PB7cv0n4n8ZyMgrCmgFcCE
         lMSUEJYprCL+/e4j6Ny2nYOmfUuoU2z79ZlpeYGa4QTjMUcNXGJrHFAK5pWg2+Dyb0Pk
         ebFFkqcbAhZKuXXO3iWlS5mmW4BKwKJfkzmb/CfloFnTWbyEEabpV3Xv4BxGONXxY8dZ
         5NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494973; x=1790099773;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GXjIVxCi/wI/JEAgJbDGbjdOXMojQ1soppHskXz6ugY=;
        b=a3AWOrNjHHrSaj7uL1hhMEvkehR0kQZXyUzi9F8hrf0H+tsiShnIEIs5eoHXjx2Bgh
         LJSpztI+F+ezLo6BTG8gtggee3JCqJ3wbHPKjJOIsLlMKRiDVAZFmPlRP3OpO+PII8A3
         aSj6iu0KsPOWzbS6mc3OlbYmL7Xaz1SM2kcN+wk2f/r7LnPLZirP9nDLdtV6FdevErrA
         +E2d7PGSibRxgxfvmGGllyBFWU0ty6xb6TpRZkaAuiy5vXoinu+wCrpbdZp0eHkfGxQ4
         5nVMqR6qLpqYQNMivkrQ+K3Hp8rK8sRHL+ZvlVYUM1GSJ3Osa4yWM6GmrGrPEtH5JfLy
         m8gg==
X-Forwarded-Encrypted: i=1; AKwUvBxSiGLelAYfqEKeoYp45m8GkpV00mozxXH8IuPr9DTnTvmi/mobrqEuTU4LQQMVmcj/FGTv/VCWKnaY2/DHURg=@vger.kernel.org
X-Gm-Message-State: AFuF++lbuzsR6rzGsvPLFSGoAP5NE8CXjbwapcspoecWlEjo/nZhEAny
	H8JA1bbl5OSsDQmBdxG5sIGyi8Y7Gk4DJ6PZE+ZIKfcGiu5TvlZsoumqu8dME/B18UXdeaCB+Ka
	xvkFny1LmwtQAPqE9tPa+ytQnICIjTlCd2todiGu9
X-Gm-Gg: AYBFou3WvHl76HklOv1rNF3YYXMZLU3FyAWlIa87r0m9gM24HhU7J/uyAEvdMcr57Ix
	k4Fjgc+ahE9qwAxtcHng0r+WGotFZRQEPe0hToI8hy5eWPsWHZ7+3Rxu7ttIi4swS0wFwsuzP1m
	h2Isla2qyYO/59neNkKFPEQtocP5FPZmAbXf8hsjp9YgnXlxtmPdxHXqe9UCu6CMStBcFMU7f2Y
	Q2pGGHFEAX5YnAeN5ZfJkRol63p0vRtxLJVu1On4MnxUW9Cs2FbMwRiruZDgb+JskNj1G9SdNRi
	qe4pLa5To5+EOOIOBuAT877ckCjflfn+OdmC0SxNLsgE9jvAsAVJB1aTDMkQXH6PJj/q9U/Ib+3
	Ccn2b8paHRdCLNGwvzqWC+ounWVwfUikluZmjDTRPftBvwk03FgvsYX94H1ftUFY3DE4=
X-Received: by 2002:adf:eec3:0:b0:487:13f:4968 with SMTP id
 ffacd0b85a97d-48705b5d792mr5756089f8f.11.1789494972051; Tue, 15 Sep 2026
 10:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
 <20260914-build-speedup-v2-14-39817ec5db23@kernel.org> <202609141056.6AE2C82E@keescook>
 <aqkZvtAKWYf9-1ZW@gremlin> <202609150943.000EC9277@keescook>
In-Reply-To: <202609150943.000EC9277@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 15 Sep 2026 10:56:01 -0700
X-Gm-Features: AcwNN1WPMMWK_d5_qt02ICUH5UNGl72dPPgrM0zv_mQxUiZh6yRKMNR6HBnx31I
Message-ID: <CAKwvOdms6QWc7RMW6hJb3qzgmpK+aw40C7b_h7eG161ie_Y8ZA@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] kbuild: batch module finalisation
To: Kees Cook <kees@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:49=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Sep 15, 2026 at 11:44:01AM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Sep 14, 2026 at 11:00:27AM -0700, Kees Cook wrote:
> > > On Mon, Sep 14, 2026 at 10:22:13AM +0100, Lorenzo Stoakes (ARM) wrote=
:
> > > > Module finalisation on allmodconfig builds consists of a large numb=
er of
> > > > very short-lived jobs, and the make job dispatcher cannot possibly =
dispatch
> > > > jobs fast enough.
> > >
> > > This "cannot possibly" sounds like a weird LLM language intensifier. =
I'd
> >
> > Again that's my writing actually, probably best to stop assuming LLM no=
w ;)
>
> Apologies; whatever the opposite of the Turing Test is, I have failed.
> :P The AIs are winning: humans are suspicious of each other now. :)

Is there a term for this yet?  Cylon paranoia?

--=20
Thanks,
~Nick Desaulniers
