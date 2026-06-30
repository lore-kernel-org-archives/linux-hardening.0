Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F62C029D
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782585; cv=pass; b=XpEdbjioZhQm2OTER9r3nVyqDd35i0C6AcERUbYyxvsGd2fwjXzUo7ieLU4vYbraHoVQUkX6NgzdPpCBXCdXIh91BrSFz3fMEy7sa8Osw0nTUhlN+jeUJG0Q3RiKHwSquiPh3KIIkxgUhWc8TeSp0o2Cif4JvcqosiiUvTahp2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782585; c=relaxed/simple;
	bh=3mJfRZYUuuihM6LVzR7jlhUxtHuYi9//80+qlG/kJg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uS1Ta7287Kz1cB1+LKS4sWRzF48/t4RzE3ISH5hNYBoZ3Aa6tdknIhtFdkXr5rFRH/Z0IKg012RFXzRrroJidIc7x8lhYai9hKU4/OOUQBq2Om4wERalwI0YiNX5YVtpCEQkLLoam41Xth7jDHG2khzWQ7ylrwoH92w51o9hJcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Zc52rtZG; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Zc52rtZG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c821a50615so19774055ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 18:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782782575; cv=none;
        d=google.com; s=arc-20260327;
        b=ojUfUAmnJZgYpBKO/egx/ZmB9UU+kcnRfLB0K6LiX6A/RWqmGA2Tb7deo8OSyJp1ka
         IqTGLIfSNLdefRs57gqYrCOGXurccFuJ+6XSbpsf/C1/k2TC5Zct/8QqZSfDw0F9UyqU
         HkepkgBTn8sNsh31KUFV/fVyUVzbJsqapeuiOqBzMOwz8/kwuATApPYTuUIsxbrq3xsj
         gL/r7R6+EaUB8eLmpA4nBiupxJEdzgkYk8OToXWiImBV4xhuJEfA4qjIwyyf5Ijyppy+
         jxFiDs5wdWCeibEdx3aeBZ4uOmwuyWQ/rCzvh7e+Qsy4XNdIpXtQJoB8quyp72w38mrl
         V7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3mJfRZYUuuihM6LVzR7jlhUxtHuYi9//80+qlG/kJg8=;
        fh=hWgjinnXkkP027NFtNGQSRVe4HYpnzXJ5uBrlwG4UHQ=;
        b=KFHyHNIPmmXXcWgeNi2OCV8svKvNS9nBmXJDg47GfWO2u95KMY8JBAGPBItmyCZnqw
         u5TI6KVGj4D7vHSXyFCkDYeQ85K996dkaJcDJLVDK7KoIUNBOL2u4AYGMH2ruRiH7fUj
         vokKr1F4Hh3ILx4IMOyd4tkeoNO4EyCgwa5vzLDFAg6p0HacZFQjQpngRaYbGAGzPxe3
         mh6FkLjwgGJAwaebrcVwQjxWFEZNBNl6PFKh0zOERvaNe1a2pC+SohF0RewN9hh2nk6M
         vo0hN0Y8GQuxr7V8hfaV4wqyMqVsoWjCrW75hFf9Eh4A0H3gl97oH5+Stie61/uq3S/u
         EN2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782782575; x=1783387375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mJfRZYUuuihM6LVzR7jlhUxtHuYi9//80+qlG/kJg8=;
        b=Zc52rtZGG/m2FbhKzugSlY8h1OwUugeU7VyzeWGM8qzoCjLCb+T6gNwL3KewpXgD59
         sCtm2v7WvyLZhvct6O5KokwZ4JOWEmN1uW3AUAIJoDYspdL+lQZWvcuNVCtrSGBV9xh8
         yM5DgypdHqKd122/bjWXGkzU7fNupgzNCSR7hvIAXKSFcrE5RN5RyCc0QK618QOOhObs
         6z/DaVs1b6LUU6RQNMrpoC0kTpIpHgx2yQLRxuAi9Kb9x5p6P0PcOE50bMCKCEr7knEU
         SumTuvUsLi9Ck5Mfn1NtFtAxjhnJrSdRr/ZIt6ag4UOfjmE7NqczeCGQVnraObTbmpl/
         HItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782782575; x=1783387375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mJfRZYUuuihM6LVzR7jlhUxtHuYi9//80+qlG/kJg8=;
        b=bKv1Mwk1FKymwQFjleNfP4TD3wArjjyG5Ma6D/tAjSaepWBuEeNRZYvrW/AvjmcwQr
         ROfMxjPN7dPUCwhy9ZS8e8qlRkKnKxi55nOCLDnBMM5BZkbNEbJTwxpqaX35/dU/Fh14
         f02KG40xxQh8JlEEbjSjIyyVrR5znMN5NluZ8nwnFD72ofShastYjQCl40hACm5nnuoa
         qIHyZ7KUphpK97M2TJ7szV/0mCae1s7Y6jYpy1JHiEs9i322vigR6B2lA3iYsutlp5Ef
         B/NqNBR7IXB42lGgBe8dyoh3N6kYc/fmJdT23Fk8P/f3m3O/8+S4mdbGWhLuH7i0VfmE
         gVDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcxwwEwY7kS+xKRgL+PmUikPI/P/F8EZtcKuaf7Yl7hyFkV00sszzGJVeWLAcwgPEDZbIQt5hWE7M7qH5ryRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBVV47RZTdbMIogBuFHYmUpKTY6k7nG27OZfhdGWgGlggwpVE
	cC0US/vvm1RCbsL0zqwBC5P7trgHBcdnO/tAUOuaM4vJ2HtjVt74B/9Ld+NXr9TyAI7CiJHrkUX
	MMejwnae6d7megkW+JhX4i5c/hc0derO5rSmrZmwI
X-Gm-Gg: AfdE7cnTAfc29UGKkEncaR9a+PRDjD3s58xT9JK+mz42P/89vMSo7iSFOshk/LLc7uq
	BQRjqY8zbBXqWLtm4LMKnAog/mfRUuxKq6jyaJdJunS8Kyj9fXmy+nVzYbK+F67wuJX6eJYNxGb
	RD0gexweGeSkwCLLbmD38YerjRr1DsDTKA6bWq4MmjVmQPDWPiu3pKOh/z0DJBMM34onQ1imeDo
	u0HCAYSTIXaUTMaCf8CyA4nMHSXzxW7D5aqjKIWwDzqjRTclNX/lRptj7jpdCqx1g9hanF6/DTJ
	e1/V6GytvmSv6Cf0KCnDSeMAmVba3SiH+dJLcAc9
X-Received: by 2002:a17:902:e788:b0:2c7:f12d:5d37 with SMTP id
 d9443c01a7336-2ca2d564f4cmr12503945ad.17.1782782575601; Mon, 29 Jun 2026
 18:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629214712.1198680-1-xmei5@asu.edu> <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com> <4e96acf4-25e7-4f30-8455-f9b3f49062be@intel.com>
In-Reply-To: <4e96acf4-25e7-4f30-8455-f9b3f49062be@intel.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 29 Jun 2026 18:22:44 -0700
X-Gm-Features: AVVi8CdJuTsl6a0UUGxPVPkpf9hXXLqmOnUrxku44YqGlDUi1EXbNbnfzfkvjS4
Message-ID: <CAPpSM+RhcW=xciX50W3G+2mUVNkmLfL1-BScPN_2TekMbzYVcg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, 
	Ruoyu Wang <fishw@asu.edu>, Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:37=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 6/29/26 16:28, Xiang Mei wrote:
> >>> That is more than enough to step off the current stack, across the
> >>> one-page guard, and into the adjacent sprayed pages. When those pages
> >>> contain a return sled feeding a ROP chain, reaching any ENTER gadget
> >>> (opcode 0xc8, abundant as both intended and unintended gadgets) turns=
 a
> >>> control-flow hijack into full ROP execution without any register cont=
rol
> >>> at the hijack site, making it a one-gadget-style primitive that
> >>> significantly eases exploitation. The pivot happens after the control
> >>> transfer, so it is not constrained by CFI (kCFI/FineIBT).
> >> This all sounds super theoretical.
> >>
> >> I don't think we should mess with any of this without there being some
> >> sign that this is an actual, practical juicy exploit target.
> >>
> > Yes, I am sorry to reuse some incorrect comments I copied from v1.
> > I'll remove the CFI-related content since we assume we already have
> > control flow hijacking.
>
> I think you missed the main point: this all sounds *SUPER* theoretical.
> In other words, no real attacker would ever need to use ENTER like. Only
> make-believe attackers in imaginary academic papers. Those imagined
> attackers' only goal is to help mint PhD's.
>
> Upstream, we're concerned with practical attacks, not theoretical ones.
>
> You've done virtually nothing here to show that this is a practical
> attack that someone might use in the real world, outside of the
> PhD-minting industry.
>
> Please don't even try to send a v3 without addressing this.
This is a demo exploiting CVE-2026-31419 with this technique:
https://github.com/google/security-research/pull/397

I have no comment on your PhD-minting story. Let's keep this issue
free from personal stuff.
I would like to demo you that this technique is practical. Please tell
me what you need to prove that this bug is practical.


Thanks,
Xiang
