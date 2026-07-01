Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C739F188
	for <linux-hardening@vger.kernel.org>; Wed,  1 Jul 2026 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939858; cv=pass; b=ejOJqHZP9QdLVlaINbPKlEwtZItBeWxhcv4Y/pipkCPG4MUkGmGJGPJkxil56TsBQsUR/OaGTzCVwC2gv9MAUtHEzN8bIVsurMIhJbySxLFSkso/t70YVkcpbRaVomNtm6kZIJhNsW0cgV4N/x42nhnZwI319qYokT/fZNw2Uqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939858; c=relaxed/simple;
	bh=rR5HBFUwb/Ups8Der57g1c7NeltLRB6F9+2cWJIFNJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBUSPixgPRnliE2FGntnD+ns3OBAXoo1flneNydsk+B+7VJeJyAtvUAFSV79ayTL9Qh5fxMEjoHJPBazLs72Yke1TrKP+Npr/b4yIVHel7v3znjfWCjCkrDhHWRuHSVIvPIDb5QXNoP65fxFJ26+BPTcHOFDNZQCvGJn/CQyLDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Rp0XK2oo; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Rp0XK2oo"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8471013fac2so742132b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 01 Jul 2026 14:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782939856; cv=none;
        d=google.com; s=arc-20260327;
        b=nBS0mY0iSYG/zSG2SXWLAl93URIa68ZpjQ+c3nqV89w6xUgFvvLPDT6ILaTdSxtXFL
         +s1Uim1u08YnKIhUG5GDQPCsyEKfgctO9/W4RgK36glexu+qbw2Evsc6MwYRc+9GODsS
         08gogreNAHtJabtmD/xN2ih4qrOPDmM9UYhYanTgtcWZYgaiN5eotpFQFzKccmaXC9CR
         OyjLwf4KugUScVGqFiTL9G+TWI5d+1A7sbkUzp7ivlOQmzyG8xP1+vvec8J9atJwKxKu
         f93yq4DEFx8kdC1ZRJ6vLWMfTxh/8zkMY+p5Fk2hV8tjYxAJZ/5URGgnO7yex29pFQq9
         nfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AmBD3e0VwHH4KYIDN04EYLgthhtXxV8uVfVmhOBd4PI=;
        fh=hwok+UoKhb0a7E4lILdLI+W5LFCHCzSNODnJBva7XJU=;
        b=gN901Z7OW69PvYapceqYtpoSJ7VB67b9g7dPEHAcPIxIKaEjvpdL8zubkkoxdYWXgc
         FyzFpWAUVI/a0bAIf3FDzZtHAm9TPLnRJKVg9N23uqIHoBdFURpdL4bqZ8ehCX65RxV9
         C9M2P1TghmakD1lniV8EQGCBY965RtQ06yOvLgHyWlLUF3AvD2ydM/OlKOpTEwTJWhuE
         fZz9uv/SJjNgM/W+YlHzt5afn+N6ZtJYkj+uQ8i7j4dBIqmyxe6TjIKUry0MxbzbeNLg
         +oNSoYt6qF4ji7OGl70X2Qs7xMBE6aOOGdhXWW6oFzUz1iMCEtKlWB3J5hWNjl1uRsBs
         5Y0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782939856; x=1783544656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmBD3e0VwHH4KYIDN04EYLgthhtXxV8uVfVmhOBd4PI=;
        b=Rp0XK2ooYN3g5QCN5658fNQBd7aPbiuAl4LNTbJn6u2uCTiPyTnrjBTAUT4joq7JMw
         c4fHwVr5eR0fsDWCIeQuXyCkpMhbBctOa7nJz8COpWLbPPl9S2T9Pa+20eYJlz9Tevjp
         wf1uoNz4EwHkAtuj39ybzMLNfawc4PWkPWCgILxyIYH4IaFNJ0gpluD6zTdIf84TYq09
         mVqMTNhAx1ipfQHZVEPMJkGritwqdG+NxIQSSq0J4uPECWqqxhIwhkSm4T927zbinsKn
         bkLsDETUCq34RrSl3SK3Mn5SV1tqqG6kAAOz7My09qMdi/uCHslzl5fRieE94dJqwVVF
         P9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782939856; x=1783544656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmBD3e0VwHH4KYIDN04EYLgthhtXxV8uVfVmhOBd4PI=;
        b=BFnby3DCeeyTCeerryUI8XKfE84AlskOBorT8wX01m4Etdkp9b0hZhVXBEUHss/t89
         gHLdhMaxvRPXL0qs23XgpZhZjLMsbfV7tU8U48IjLEgc1rWO8ei88w6PHXNXqZmC7O1F
         7WkN0CXN+o1nJbUw5u+XBlrnKtAIhnhC0oUONmX+gyPhVG1k2o0qauQoOOG/KmbL0vaA
         FUOUeIvXecxrjiWoOT8u3eYV1AwZAjQY26rz3NX34Ef1is4gUHS4iUe2DWOovqO0Qsqi
         ciSxeEVFSiI2Zc8RAUtsvl8MSyv22KUZAuY3G1xzx0Jj73O708PGrizhGsYUNJpLYOd7
         Fmfg==
X-Forwarded-Encrypted: i=1; AFNElJ9PlJKnLfr3ZqKMt8g47W1qNgwK2EzzIkqfMEdJQ//SFVrQ+Zku7tiOI2mWZ1NDd4pUe+/BSoa9qEd/w08hPEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3z8Hj9DRjK3zz2tHcVrvnJUHAviAGgBYQjF1yl1Kn9FCInJx
	UGrfDYhv3LZTMeFeQD/KJ9IsMXy2TSC819gYTNfA/k0xqgEYq7WV3mBJ2z5WJdSRdqiGPQqdfgR
	inCKPc7FVt2LKcPMHUjOKO0MdsJvfrV/hF9dmWQ8s
X-Gm-Gg: AfdE7cmQQph8ARAbTuNLJEQ1yt0GJa2Dj0K2tV0BzmAr7aT0g8OPZj4aHgOIBeJH88N
	PAwzFSTSVUrryZvujfRND2BbZuQXl+x1JEy0z927qD3m330vtK2nVuONLMc34JsIlu6FJMIJni/
	hL+vughs4hUCZYg5z6jYuSNTepMkFbKL+4g07PTMR3SglD3VQ2FgMKYugXhTBIy6ozU4HFNneV2
	6fbQbGpRGDgqDiQJpctw5Z5D86sD8kDO2Hm0kLh2Bf/LY1RqKEoW6MSFzF9QTno5qO8oKEMbsL1
	iF0VDwJrryWfH/PMOEP7I4F6IZYs
X-Received: by 2002:a05:6a21:710b:b0:3b7:d9d6:9fc9 with SMTP id
 adf61e73a8af0-3bfed1c395emr3728441637.2.1782939856218; Wed, 01 Jul 2026
 14:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629214712.1198680-1-xmei5@asu.edu> <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <20260701072747.GN48970@noisy.programming.kicks-ass.net> <20260701074834.GI49529@noisy.programming.kicks-ass.net>
 <8730D74D-6395-4FF4-B9F9-06AFABBF8CDE@zytor.com> <20260701083108.GD751831@noisy.programming.kicks-ass.net>
In-Reply-To: <20260701083108.GD751831@noisy.programming.kicks-ass.net>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 1 Jul 2026 14:04:05 -0700
X-Gm-Features: AVVi8CetI33T_TotONqV4BWPgVS7t_F3quW7jHmlRejSYi3vrx3QyATtMUR_36A
Message-ID: <CAPpSM+SzqLSPt2q0KhkzB-WvphXGmby99QBJL7v_nq4kJGAYFA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 1:31=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Jul 01, 2026 at 12:58:12AM -0700, H. Peter Anvin wrote:
> > On July 1, 2026 12:48:34 AM PDT, Peter Zijlstra <peterz@infradead.org> =
wrote:
> > >On Wed, Jul 01, 2026 at 09:27:47AM +0200, Peter Zijlstra wrote:
> > >> On Mon, Jun 29, 2026 at 03:29:50PM -0700, Dave Hansen wrote:
> > >>
> > >> > But, really, if ENTER is so evil and nobody uses it, shouldn't we =
just
> > >> > have an MSR bit somewhere to tell the CPU to #UD for it rather tha=
n
> > >> > playing these stack games?
> > >>
> > >> For supervisor mode only, I suppose. We can't ever get rid of usersp=
ace
> > >> ENTER because legacy I suppose. But we can make sure the kernel is
> > >> clean.
> > >>
> > >> So yeah, having a knob to make supervisor-ENTER trap would be useful=
 I
> > >> suppose.
> > >
> > >x86_64-defconfig builds clean with the below :-)
> > >
> > >
> > >diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/=
decode.c
> > >index 1b387d5a195b..9e53db863203 100644
> > >--- a/tools/objtool/arch/x86/decode.c
> > >+++ b/tools/objtool/arch/x86/decode.c
> > >@@ -642,6 +642,10 @@ int arch_decode_instruction(struct objtool_file *=
file, const struct section *sec
> > >
> > >             break;
> > >
> > >+    case 0xc8:
> > >+            WARN("ENTER instruction at %s:%lx", sec->name, offset);
> > >+            break;
> > >+
> > >     case 0xc9:
> > >             /*
> > >              * leave
> >
> > The problem is that it being a single byte long it can appear in the mi=
ddle of another instruction.
>
> I understand; this was in response to Dave's suggestion to make
> (supervisor) ENTER #UD, in which case we'd have to ensure no legit
> ENTERs exist.

Peter's explanation is correct: this technique makes CFH->ACE easier.

I think both ways can mitigate it, but I would like to hear your
(maintainers') idea of which one we should proceed:

1. supervisor-ENTER-#UD + Peter's objtool check. Cleanest for ENTER,
but it needs a new bit from Intel/AMD, so future CPUs only.
2. Kill the landing zone with a 0x11-page guard area.

Thanks,
Xiang
