Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9E4BA1FD
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494471; cv=pass; b=JcYVc9jGVW3OopnLDnnBzUgKq9jCfLHRtNpSRfh4CsG8S2zMjRLPebuGmQU7m3QV0bVK2xXdWbWjNnfqZ9VPeSsmJPXtAHuQOdb3ZyLApMl1fEw0U6GmunvUgifDqIso/Q0Ciu/gQXAlqDmV7sWvgIFYVs72y8rtisSs9NSnw7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494471; c=relaxed/simple;
	bh=u6Gw0oEc8G0Na/fDm4B5c157a2l4J+0QxPZsDNbgEew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPg0kU9J7/1n9C52HOlQeAt7+X+D8yQzeg6EtdezMq2VmqVYyFJErHhfS+l9g6LVzfNGqwCx0HPSzMfQjPveiFOrtluWJN3vy0YYKptrkXOJCH1RGVxoe3dURB9eBLgGw7HGWpdqzXrElgkjCqy6Yjl7KtKo+tRZXWFC+hZHDa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC4kCaqf; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC4kCaqf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso5417485e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494466; cv=none;
        d=google.com; s=arc-20260327;
        b=e7JZX8bq42zYhVz47CVOAgy7HI0c+G8TozFQhaSNGUWkf7405m94H3sz5PxcDjIlzZ
         YTLubHMmFb7+s3ZplgChxqfmo0mpECgIrVvUjF1sX2JA8WQ7fmExTGGxMW5hwLucSxe0
         2FTfYMIMvMADxkRqlE51OxellPp1sYSZkl7LLM8vSmeh0e9uoqkoF5e+DqiRPU+lAcEI
         XMergkydntskGknSrTC8+BTtRSK3Mu98qM5GAQ6yfAbFhsN3/wYjAzo+Tq13Z11I+JMW
         CPI447iESr+9N9beR8ofhKf8K5wNzSm9LO4n6mkMByEENfNBSmsYhEnfkyM3up6RMgPY
         Rvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u6Gw0oEc8G0Na/fDm4B5c157a2l4J+0QxPZsDNbgEew=;
        fh=A4TJAJU3pbqzxbGtznFBjw2SRvxNM8vADqP4kcCIGbY=;
        b=cKOgL5bMGa5gjkJFeVx0saSURpFaYfngIKFjEJMx0drw2hFVzra/NsyI6SRrQe+1RN
         tvqO/0+/sV689M6EZtgQ0HJvSE5zZPczFB/mMPLSYG3jg96VjY9qdHUgwHSahuBCxsS2
         qQD4TbP+2xgTvMMWfQgfi39GC0zBo8l0ibGFUybTmpK6W4uADijjbC2dMM2DahhJRGSV
         gPCpKex40pcfF6F+2KSEtrHv3LvK+bKFlmK2kqDtnYS9KUBiGZe+xt+TgRWKGsNbKIlt
         HYL58nU+AFOXakA93K3Zq/9TiQ24VLZDwaN4GY77AF0Aus+/e8zg6nhgiJZYASiCNRBj
         hgMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494466; x=1790099266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6Gw0oEc8G0Na/fDm4B5c157a2l4J+0QxPZsDNbgEew=;
        b=SC4kCaqfVVRGG5CrPQH/SMlPkiIKeXl83D4UvgxjX69ghdnUrnuUqyHeshbHL7v3XU
         MciOzn7JIO9Y1K03tB70Y1eRi39OTU0IszyivUgKVlYAdjxNulv95mjqsR7bnCS8ldRX
         YSkgn4Qvd+FzLDnfI6RWmHgFd8RnJXjiw60CDK6CC3yZbf/T8tyHxKswzKVlpOU1Ifet
         cSas4HSNTNnIrGPq963ZUw9VRnXemCoxAdUi0BmmOeCPgGp1gPpG/dMliWtjlfDpuzkU
         U0Cp5g/97Q5+jtIPfWjlZAOjJDWvnugaRoFqaKUBCzD/GTkVXI9Yfcz6X/9gSZBRg0Ir
         vneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494466; x=1790099266;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6Gw0oEc8G0Na/fDm4B5c157a2l4J+0QxPZsDNbgEew=;
        b=x79WU9PC2rStsxHFlcR/Wn02aHUFkUloc99vLoOAuwJImmhKkvo+Qjjispe/3qGv+M
         4t61H4Mba5UZl8NwOpcLU315Nhv58C561DzPZprGDMABpFZtP1bzkskiaGzuiLfbFAeT
         PnxJ0JDteDd73ZrPgBoLIHDoPPCF+WbIuRpzxvadrn0ZBSvGjsQ4Ku+SeZ77rt8cUgai
         xhayb9jqRFij5tzYUkHx3swW8kC8tzKen+tWnYDavO4OUHPrsIH01BwQ1uWoxhFxfT/Y
         HQMZV+ne2XdfJUPIyQODYoiasvNSJ/AitJWlqr0B4uJm51Sfm/Z3FZklhEhzxqTHGrUT
         tigA==
X-Forwarded-Encrypted: i=1; AKwUvByLZGylRZ/1WRPrKTrBwxVdL9umEzz85eEoqB+SK/kJYCMxmGXm2DRV3KO4KPiYW7zl0/ObMbuQPtDSP+YNs/M=@vger.kernel.org
X-Gm-Message-State: AFuF++kYLBNGTx+ASgg72AJPSjv3mv9mzlvv3TRF65jE4B7M12d+2/eX
	RNG2a//39zvJAzgkKepp23vsColLyBBlvoJxX1hUvV7iSxdi8ihiUnFD/10wUNSy8YdTeSrcM48
	n3rSo+XKIKGMC6HUHZ/p8C4vwVPx5+FyX+HtgHHyS
X-Gm-Gg: AYBFou3uMSdYexal3GdbYAvwHINe/w5wNcDkktcmElFQYfjvRPwpD953nlCxTW/Xscf
	qBP++Yje8wyi95a6Cgqczvh5xdKuckuX/pw1WoMdaX2uR5D8N36UvQEtJmiyx6ACGeRLvzy/cPB
	3zYKnVLzr0MFEtfWonpPi63S9CMIZ7G2i46gIC44Mes5jiCp4S9yxLzsQlyKA5qK1SfU2lgM8XW
	dLN0cZ/uL5n0lJrTGEuWa2XlZKkpY0roUmDepEJVUccoQgfSrYfyeBaojZwFvUviy7RpN2xXuvu
	o0BEZtagUEFkisO0YY6M2x2ISN5rU8+l+DJPXjoi8D3X8y+UwD+68ewTZ74bEB3PX6rrH8YfxrS
	/ODy6kJRarVvmyXmsKjXR8JuS9QC4VjW7n9NHd+XUci9P5sNj2SPifXdawTH4yDUsew4=
X-Received: by 2002:a05:600d:84ca:10b0:49c:ff66:7d88 with SMTP id
 5b1f17b1804b1-49e7d725e6fmr51370615e9.7.1789494465544; Tue, 15 Sep 2026
 10:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
 <20260914-build-speedup-v2-21-39817ec5db23@kernel.org> <202609140844.FA7E848A@keescook>
 <aqk9gakQhxToLnDI@gremlin> <202609150955.A51C9F7A20@keescook>
In-Reply-To: <202609150955.A51C9F7A20@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 15 Sep 2026 10:47:34 -0700
X-Gm-Features: AcwNN1U4CY7rpoxX3OGd9mqCs-kE5osRcDbnjG2lLmWDcf89pyFwGTPPrVzl7qI
Message-ID: <CAKwvOdmgeyqivO4pVa=30XDWpXvdRzBR8f13rfuPzDx=LJ1Tsw@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] kbuild: use pigz for gzip compression if available
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

On Tue, Sep 15, 2026 at 10:31=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Sep 15, 2026 at 03:30:43PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Sep 14, 2026 at 09:39:07AM -0700, Kees Cook wrote:
> > > However, parallelism needs to be set. We can't let it eat all CPUs: i=
t
> > > needs to respect the -j make option (and make its CPU reservation kno=
wn
> > > to "make"), which we already have a solution for in
> > > scripts/jobserver-exec.
> >
> > The only place where it's invoked is vmlinux.bin at the end of the seri=
al
> > tail, where all the tokens would be free anyway.
> >
> > So I don't think it really buys anything at all?
>
> There are 2 things I'm thinking about:
>
> a)
> My main concern is the lack of respecting the -j make argument. In my
> mind, this is a blocker, because it means a build will now _always_ spin
> up max CPUs (not what -j has limited it to), and for CIs, shared compute
> systems, or whatever, this violates the requested parallelism level. For
> example, if I'm doing a long-running Coccinelle replacement in one tree
> (which uses half the CPUs), any builds I launch I'm asking for the other
> half of my CPUs to be used so they don't thrash my cache.
>
> This is the kind of "why are all the CPUs spinning up?" question I
> helped track down with commit 51e46c7a4007 ("docs, parallelism: Rearrange
> how jobserver reservations are made") forever ago.

Parse -j from MAKEFLAGS (https://stackoverflow.com/a/76517886),
forward it to pigz?

--=20
Thanks,
~Nick Desaulniers
