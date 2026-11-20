Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174709;
	b=fZExLqtFcPHi7YteBg8IPg3uw85s9wryR4EGb0NsNgwmGJs/snGAtzTiJlVCY8Rry/RJ
	 N9VoDSykXaQrUwakT9DnYWNJhf/EGzisC7kjCpOtq9qNiodcsuzGqsjmsDRyXNy9u+1Uh
	 zi0uwf5pBMxu4U2EeyidOCnHIhYjaTyi0Idb2iQ4eOmq71yGoIdLcIQWxT1i+gYOldGWD
	 5WfllkNzmugKSve1OIxvwvWd9It1YhycTrCDQo+EaEGHr6nGnaQX/XxmEZOre9pKZhpY2
	 CgQnht6XXlbW9b+WM8Fk63EjPBT9NHDtXXwWxLF7DGgnhVdWzFZN2XaoMU+cmenblow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RXY63Zo5uvZhPFI98Q/TScgGLzf2IyKlYtsZMNa3YBs=;
	b=U578tbjJtj9/4N7fQEOYa6vRhW/fZsEDWCKOnMMbBlalDFp8o5YxuH0/N56NuLXSou8M
	 5uXZ3uZJBaAgAj6gTlacI9VrnKb36duVUz73tP723h3ZGJWDwt8hruZcAbPg2nKb65laU
	 VX1gzhhilj0pPQiHEPcwzxZkGtxjbGDssDGwQ8YxH416mxyK+9+1R454Cqlg/XqBSmmzv
	 67Ef8NJydU4aHa08tpiUMBGDrSvVhhccsid8qb1RTKSZLcc2KCZgCDlGlk9jGoYC6uerP
	 CkuN8m0r+FezdqYpeKRtIcRJJzqjCc76SqMlGdBDHaUcx0l9bIyuzbElF32oFROQxSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ndmq/QHu";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8C606A33B
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 11:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18B8C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ndmq/QHu
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-497614c95f0so483324f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795174707; x=1795779507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RXY63Zo5uvZhPFI98Q/TScgGLzf2IyKlYtsZMNa3YBs=;
        b=ndmq/QHuoRBguIFOggKUs+Sda5GQg1fiH1RA9eEH9T57jYVFZoFNsvmwVdrVqbrSSP
         /Np4fGfEiynF37xan6NwwLXOdGIBUp0o+dr3PLXqYFAGK1HxaA6MpIdCT5G5vW9153QZ
         hfAJo8NG3VH7YlZx9Hopf66bfQHtgFAFLFcDVH2qXGtf+mmnpLcNRURNpY3ZK6en4ed6
         J9PZys+UILNabCIsX6e/5FM9DStyEt8Hoxkder3nPUMb344q/WR9+AsxYbktonX0qHY0
         Xr94sHBh/tMqNzpZJTMP1oasdbKFeP/vOPnkXOga7AnMB5g6ZZZ9W9esiPCLF1ebynsD
         ZLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795174707; x=1795779507;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RXY63Zo5uvZhPFI98Q/TScgGLzf2IyKlYtsZMNa3YBs=;
        b=czdKhZmPsiuY2b9AoX+Esj+Qr5RIyRxUK5MRhXecl7qzGcVuinJNAKVCd7udqPgVJ6
         cKvhErtZ6e/gNbYK+hDqBy2FGqzja3yOKT7Kx7xgIfekd7IRu2w+7bjRcm12qbRjS+3c
         m+NelPAuQFv21o2nK7hZgZO07hraNyHohMC6JhkVwi0yYG1ilI2q5N8cP454FYwABl/o
         1Uj+EVu3jyMWW4JtlraX/yGIUVhhbDFBeBwZnv2/X54LxQGpKYWQTt0uqFlMVdcV28sN
         lhVf9OpEJRb/jyrFsfMMy0Wc5lXUNZKQS3Gh1MYVM/e49dtPOTNEELJ3MxpAWYO2jePe
         ssLA==
X-Forwarded-Encrypted: i=1; AL+hErEUedY6aoWT5Uzq7u2BEYVLDwOSKSVc6UnDgiR1Toa63tp/E+VP3yzv6FLaALO0Pi9uiINUxnWO6TruRH8/VjI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6B+L06I1OCrKjI1A5rjKM8JZSH/s0nxwLPZ4+1ZHfFO5TE/SG
	2msK1/RDjIHz9/bAmue34L8ZV5d0Dvk48B165PXtVP2bQp3ENv8MP8z0
X-Gm-Gg: AZFdTZetoKiz0FzZ44BQwTqeMdmtU4iutpt8LhSfHHPfd9pDBCMqsvG60BKTpSfZV99
	qtGcMp9gQCBJ35unZfsAUubWEccbBqGH9gQIA3rA5ixpgay2uiPRipzKUMATtgyKams0i3fyJSi
	bCxIRUmWgBCME0R9e57LcUUzrxwIh/nO1J41KE9VSUFd8kz+UxZIxzYDnp9KKd41mBhWCVao1PI
	iVo3eleJXS//g2HVXu7HvOJ74pYSAlqcVp/94BnHT/j6TluPFIQ+VCyBKHA7x33RLsN8knz1S6h
	rSk+Qmwe/vbHaPOg4TycTXT4FPP1VytEMXrLwr0agMzF5ThjdhKAvHmxg6qIe8YBa8B2+9zaMXG
	PkjqLnssPfMoDMYMLWVhpXl8OOGC1sAw4o+NRh+tVy5ADkPb8Uc1dbTr67rLSRniKCfikIPSuM2
	o/+AGuvKnj/g0SRsRgI8Ri9jfdf1+Myxt+7Y+AteGjRnX/5F6Fc74d1V64J45TA68cQf2hK8/Kf
	Fws1Y0uAeWkCmscwORR2iSQbg2YiafLl++Hm7FgjU2GyDKVt1QxhfZLiH/eKwSmXLRe5YBS7dxe
	/FUOExaB7AC5HHypqyEr3aZsBmHzyPcgUn2XsODCOqeJiVJAgn1SEtMvPFtbsUC1Hg==
X-Received: by 2002:a05:6000:47ca:b0:4a8:9702:6cbe with SMTP id ffacd0b85a97d-4abb2dda46bmr3489036f8f.27.1795174707260;
        Fri, 20 Nov 2026 03:38:27 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm5347378f8f.2.2026.11.20.03.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:38:26 -0800 (PST)
Date: Fri, 20 Nov 2026 11:38:25 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Usama Arif <usama.arif@linux.dev>, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
 hpa@zytor.com, gustavoars@kernel.org, ardb@kernel.org, hca@linux.ibm.com,
 nathan@kernel.org, morbo@google.com, justinstitt@google.com,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, rkeilty@meta.com, atish.patra@linux.dev,
 dgreid@meta.com
Subject: Re: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack
 fills
Message-ID: <20261120113825.234bee1c@pumpkin>
In-Reply-To: <CAKwvOdnzNU_xtLeb4vXSFe3DLN9QmdNSSReUmQahsLX+1pZxCw@mail.gmail.com>
References: <20261119213147.1094488-1-usama.arif@linux.dev>
	<20261119213147.1094488-3-usama.arif@linux.dev>
	<CAKwvOdnzNU_xtLeb4vXSFe3DLN9QmdNSSReUmQahsLX+1pZxCw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Nov 2026 14:28:04 -0800
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Nov 19, 2026 at 1:32=E2=80=AFPM Usama Arif <usama.arif@linux.dev>=
 wrote:
> >
> > With KSTACK_ERASE, every return to user space poisons the part of the
> > task stack that was used since the previous return. The generic
> > __stackleak_poison() does that one word per loop iteration, so a syscall
> > that went 1-2 KiB deep pays for 128-256 separate stores. On Meta hosts
> > running many small VMs, stackleak_erase() accounts for about 1.5% of
> > non-idle host kernel cycles.
> >
> > Override __stackleak_poison() on x86-64, as s390 already does, through
> > the hook added by commit 491a78663e03 ("stackleak: allow to specify arch
> > specific stackleak poison function"). Fill spans larger than 512 bytes
> > with REP STOSQ and keep the word loop for shorter ones, where the fixed
> > startup cost of REP STOSQ does not pay off. REP STOSQ starts to win at
> > about 300-400 bytes on Zen 5c and Cooper Lake, so on both no span gets
> > slower.
> >
> > The fill is inline asm, so the noinstr function still makes no calls.
> > memset64() would be the same instruction, but it is only static inline,
> > and with KMSAN it is an out-of-line function.
> >
> > In a Zen 5c KVM guest, stackleak_erase() got about 35% cheaper per retu=
rn
> > to user space (71 ns to 46 ns, scan included) over a futex, epoll, proc=
fs
> > and Unix socket syscall mix. Same-vCPU futex wake/wait and Unix socket
> > sendmsg()/recvmsg() ping-pong round trips got 5-8% faster.
> >
> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > ---
> >  arch/x86/include/asm/processor.h | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/pr=
ocessor.h
> > index 77488ff5eb8c7c..049231d484ad0e 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -580,6 +580,31 @@ static __always_inline bool on_thread_stack(void)
> >                                current_stack_pointer) < THREAD_SIZE;
> >  }
> >
> > +#ifdef CONFIG_X86_64
> > +#define __stackleak_poison __stackleak_poison
> > +static __always_inline void __stackleak_poison(unsigned long erase_low,
> > +                                              unsigned long erase_high,
> > +                                              unsigned long poison)
> > +{
> > +       unsigned long count;
> > +
> > +       /* Short spans do not amortize the startup cost of REP STOSQ. */
> > +       if (erase_high <=3D erase_low + 512) {
> > +               while (erase_low < erase_high) {
> > +                       *(unsigned long *)erase_low =3D poison;
> > +                       erase_low +=3D sizeof(unsigned long);
> > +               }
> > +               return;

gcc 13 onwards makes a meal of that - https://godbolt.org/z/KPP4h8xz6
It does manage to unroll the loop once - which is good because the intel
cpu (I've got) won't execute a 'one clock loop' (the zen5 will); but the
setup code is horrid.
But I also think some of the more recent cpu can execute more than
one write per clock.
If you unroll the loop 4 times it may run a lot faster.
Perhaps:
	long count =3D (erase_high - erase_low) / sizeof(unsigned long);
	if (count <=3D 64) {
		while ((count -=3D 4) >=3D 0) {
			*(unsigned long *)erase_low =3D poison;
			*(unsigned long *)(erase_low + 8) =3D poison;
			*(unsigned long *)(erase_low + 16) =3D poison;
			*(unsigned long *)(erase_low + 24) =3D poison;
			erase_low +=3D 32;
		}
		if (count & 2) {
			*(unsigned long *)erase_low =3D poison;
			*(unsigned long *)(erase_low + 8) =3D poison;
			erase_low +=3D 16;
		}
		if (count & 1)
			*(unsigned long *)erase_low =3D poison;
	} else {
		...
	}

Except that gcc makes a mess of it again.
I don't think the 'erase_low +=3D 32' is going to execute at the
same time as the last (two probably) writes so costs a clock.
So it may need to be asm.

> > +       }
> > +
> > +       count =3D (erase_high - erase_low) / sizeof(unsigned long);
> > +       asm volatile("rep stosq"
> > +                    : "+D" (erase_low), "+c" (count)
> > +                    : "a" (poison)
> > +                    : "memory"); =20
>=20
> Surely this isn't the only place using `rep stosq` in the tree, right?
> It's not, see memset64 in arch/x86/include/asm/string_64.h.

Which seems to have very few users.
memset_p() and memset_l() have almost no users.

David

>=20
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_PARAVIRT_XXL
> >  #include <asm/paravirt.h>
> >  #else
> > --
> > 2.53.1-Meta
> > =20
>=20
>=20

