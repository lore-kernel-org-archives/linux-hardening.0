Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187143DA5A
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993854; cv=pass; b=Wko8YNgZeWhd1x5CRdyDM/D7/tbLaKOKHyMyG+03+LtCYUNQ83RBSqF4+XIvNjRm7gNpXuPrnJpmv8HnDv0ZWvjJVZJOKqCR0JxulWym2j5B6z5dSwS70oEz80+jFzaT2hwnj+fJuNN/4e1QsxisCdBGhPWk8qBWVnbLh2AE+G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993854; c=relaxed/simple;
	bh=wV2XHf4d1mRiH6xWNqUuoF9pM1xd5tcDK3VA/1dQDZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUJsg19P7u1nXqXxJKfxCHrdXB6v5BeC7qr4MecJ0n9a4fwpcXvPGs/Xo4sdK4CIeXcJgEX9mY0+1wXdgjcawS+Imci+hrtMQ8sWe9GtHXYKWZxcisPM1/GJzNvocsOG1z5ZRfs+KxDcw695n8yr/al18mMG1shnv+vnUHumTyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULwZTnZw; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULwZTnZw"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-951c5ac6253so1888522241.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 14:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774993852; cv=none;
        d=google.com; s=arc-20240605;
        b=TiKo6anDEKbv1Lt5JlfUkppRW/w6evXeuI2FuaLocYNF0oqeVbTz4xWE25jSCOqsu0
         JRg1za2vxzCnrxBsDtx2uxLzb7q6RTHhM8edPGY7KwyBa1Sc7tsz6/FaiN9un6ChkSgQ
         11Mye2Tivr8c38jwEfD2QmsJOdX/UkbmTBuVqQnjW+90VQrCT+CKUxdgIEXWP0ysfYHE
         KKuIZyiwkm/mc6ISo/vZi1TtvCpWhQyaTU4wwDngrbqOTFAU5CtFSrQXCBr9AW8YwNpe
         Y0LJJFo/C6+6bI/r2TfWp+9Y84kwl8TearK8NhM7BAMzv3r8JXGzkxKFGJhd5u3oxSJE
         AkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvGGAAIkJYXYlK2HRa+mui/7ZxP8IFY7+ERdHeXnYJQ=;
        fh=cO1pxv5L28BXB+3KB6QLW/V1Y1zYzM8W8dteUMdawGQ=;
        b=WPfIKoRQpxTgRwbs5zFKLSH+z+oSaoc8O5LBCP/VcXppB67DWjykLKolmpoN+l+L6R
         3JHV3uFmNS4GVncehbhS5NG3fP35zDusXO3sbO6GJmtCYS+LeGKoVoIRrE/FrHMRUH3G
         Giv2yrcR3qgIIpMYm/41ikjv+y7aUDqR6CDtL3UGfcl1VAyuScblQXlePrzw2zZqbUvl
         1iGuh/yOImYvBAU5Oy8eOwt8yjsj3Efo4L9ahryirCclX4b/Yd0THtBtLLxTT0vb+uPT
         H0vtQHFb8GgHR31C0tfItcUEoWsJksT6+Ef+MFXYyJdOebonupqoLrqpNhU7Q6beNLld
         tPCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774993852; x=1775598652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvGGAAIkJYXYlK2HRa+mui/7ZxP8IFY7+ERdHeXnYJQ=;
        b=ULwZTnZwYpEALX6nYfAZF+FT/TisjHVclbRPF18BSgBSej64+DQ91M+9Bw8kEootcv
         EKnB/kCkqPVag1udxVN1dXVt3PDmt4LlyctpUdpZ+bzfGwWhNXD+qpjSpHVGEx+udmZr
         kYVX5FPfL8GKwkLr9fkbk/kzF/HsXC4zkbqgGHIcxAACsr5r3Iqx7rWTGBG/8UjKtk2N
         9jTv0A6N8cCJSO0KuHhQq+Dg1fWk89vvnYBYn0Z61TOxGDqO7yLfnuHVTDg7/2zdzoLs
         cn6+piLytbtRb9XiHAUBz1RK14sB1/tWNHV+luKZRT7PuPzSG0jv0/dnYNDSef1+8aJD
         b+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774993852; x=1775598652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvGGAAIkJYXYlK2HRa+mui/7ZxP8IFY7+ERdHeXnYJQ=;
        b=dltrQT1FDBIRqTvq88TzAqz7P+gEWqcMOYxlhLc36hgV2mRSHQQ0rfY9qDCsa/qug3
         MNkey60kaJGlHL5i2ih2Ut6LGdtnTkv6roFXS+XU0Vivq4bO6mNidrNSdh+poB/PGf/Q
         Lk9wxfgqrZQRNGSLHJjqRtwcDAalaxShOO+27LrlQ5p4u59chhEaX5TWrYJdta6cCWFy
         H/M0qQsA8ynIlrAjSRiki81wLnwr3+Lo/ygC3p+6P/zjhn3MTaAjMIVCQgDNo3WY3Nj3
         xOLfuoeOQHH07TJYe1WYmCJYlT3C5J3ox6SUWrlSDt87cas39jhy4dCtTcqvgHiu8Xjl
         T1sw==
X-Forwarded-Encrypted: i=1; AJvYcCXT75CGlqR9ZPMG1regs3026/vLhH2qyuoF/k0t+sDKkpaBDpAwMD/ei9yDXoJJmloJKeVLzbDAHDEZnfg35SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8GdEZtWfecKC7AKiPaY9EtuG2gexARVwdysXgVm6uYRy14ge
	kXvUB9hS83prRCm7A3mTxUh2BKAtCwWmHoSSB9rHzvRssJXEOdD07Og1H1sQPbSCuRguN2UNSni
	XcDXBgVzQkFdxUCfC35n58KYt32KXlaqq/OwF54ut
X-Gm-Gg: ATEYQzz0exLHQTP4NPWjDK9XzQPHD34ltDMkHw8wQjXJywZnVvF66hIm6TK9cjSa1K7
	UzbJJQ9Fz0heZQf5NIcbTyYgNXO9+LuklfD3lRtJfLSsTy1LvPM1gTDn+okXJfu9Y3iEAqBANv4
	XcK8pMIRzPO/ifuze4J5z1kgSUpd2ZZHFvHY0AjNhLwl8/xFIQuynm4y4FGFc8bRUF1rSmerdlW
	P10CipCQOZmwa887A+4umRQyD/5391M+ID8vxQc8SJKlti2oKnyZUErE8NYPwL8bRHZr0yXubMV
	dIGHH+A=
X-Received: by 2002:a05:6102:2920:b0:5f5:40ab:2d65 with SMTP id
 ada2fe7eead31-60567fb080emr381935137.22.1774993851331; Tue, 31 Mar 2026
 14:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <202603311253.95C54588E@keescook> <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
 <202603311321.4EE9FEA@keescook> <CAHk-=wj9pWsgsbrLDOk7ipKnHbz3JvuqsmQ3DhGg-OKgKS9DUA@mail.gmail.com>
In-Reply-To: <CAHk-=wj9pWsgsbrLDOk7ipKnHbz3JvuqsmQ3DhGg-OKgKS9DUA@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 31 Mar 2026 14:50:39 -0700
X-Gm-Features: AQROBzCZD3X4CkUD9sEd-qirDA1mrMa-OH7YNrOM0p4tLkqwVMQeCLGoKwyIRLE
Message-ID: <CAFhGd8rE+ggYghcwUphSRc2ftQMaX7LbKKPwQZzsw43bg9VVmA@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mark Rutland <mark.rutland@arm.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Finn Thain <fthain@linux-m68k.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	llvm@lists.linux.dev, Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nsc@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 31, 2026 at 2:05=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 31 Mar 2026 at 13:31, Kees Cook <kees@kernel.org> wrote:
> >
> > (Isn't this just an implicit "try"?)
>
> Yes. And I think that's ok.
>
> I think try/catch is broken for a few reasons, but the fact that catch
> and try are tied together so closely is the main one. You can't "try"
> inside a scope without having the "catch" inside the same scope.
>
> So then the solution is to just move the try to the outermost layer,
> and I think that's pretty much what everybody does.
>
> But at that point, why not just move it *all* the way out, and make it
> implicit and invisible?

How do we feel about type-defined labels? We can specify sane default
handlers where we define the types:

        typedef int __attribute__((overflow_behavior(trap, __handle_me)));

... and define specialized handlers later on

int func()
{
        ...
        u8 __attribute__((overflow_behavior(trap, __BOOOOM))) product =3D 5=
;
        ...
        product =3D a * b; // if store is truncated, goto __overflow
        ...
        return product;

__BOOOOM:
        pr_info("%u\n", product); // shows "5"
        return -1;
}

We would then probably want a kernel shorthand to avoid long type definitio=
ns.

        #define __TRAP(handler) __attribute__((overflow_behavior(trap,
handler)))


At least this way the label is always defined somewhere in-source
rather than by a magic -fhandle-my-overflow-at=3D__overflow


>
> Which is kind of exactly what your suggestion is all about, and that's
> why I like it so much.
>
> It *literally* fixes try/catch. It makes the only really valid usage
> model just work better.
>
> (There are other reasons I dislike try/catch too, the whole
> "exceptions across function boundaries" being another one that your
> model avoids).
>
>                 Linus

Justin
