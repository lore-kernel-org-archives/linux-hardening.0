Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974C3EDE51
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610365; cv=pass; b=oyKYGKslE7ZLXcedzJSh/0QM9VZFwZjW8bdg0fVBKAhHaG62NA2Nh9GxYig5PQKWo8hUxqIiaRthvvifLsVFgn4dpthwYJXlrHfX1fJ/0+Aj/GPsYJROrs0s9HD2aXepi6dP3Q/4Ex2roZmkVIEaBKkzViHuWmeIxk7JjoboC+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610365; c=relaxed/simple;
	bh=FxekXdw49YNubFgtAgWAVWa4vzXlzMd/1KjHaOwgz2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJEaDcG32AWQAAb0jApzX200RuLlxaE/u3esJRGLbOkcHCtyssQbDZIyWV8K5rso1he2SeZqhCZ5SSfjvjMbF9bPU4jK9Eta1CesbhlglccCSR6//OGe/jbyNSR9VEtsLGGHd7Fd3LzP8RvbplrJMzPVeARTJSg7f7lu/jT8PMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YeQ/ueQt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qk6qBvVD; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeQ/ueQt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qk6qBvVD"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CDgIiF680110
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 18:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FxekXdw49YNubFgtAgWAVWa4vzXlzMd/1KjHaOwgz2A=; b=YeQ/ueQtSdKZTj15
	VsiuFjmCWsw2ReDy2rJ6uk0MowJvr6s6GGZO/+HDXMgr1kILzsKOKw6X/f85f7RB
	paGW6jsEoURAInACe5FVOlAAJPw6onEB/VnBNFeVr6UQIofp2uS6qC+diUURwd7F
	9axQVvSghpSv9fyzn7h0pSPKID9egYOR7Qy9wyCt+TI53APdLwJUt12Myvvw9gyr
	gu/PnokAhe0IJsh12M8bzJRiWWEPCLIkv4oxX4cgr7evh+5ReWCuprOUfT1QkMaL
	8DmOw07p21y4dysfscUCrTZT/R8XMUQSX7k1Dcajrk6ifQJu5ZT9dXOyyhkXm6YM
	jxYY+A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avh6ka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 18:26:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so4300712eec.1
        for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 11:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778610361; cv=none;
        d=google.com; s=arc-20240605;
        b=ZBFLGQcyN6zryiUOhgCOYoDr+SvRfiyyKGIU9h6cegMKf1M5aYTTyOGkn2V8vvmbhU
         0TwR2yDcVEomRKmATafMM0TDeqEHkqk96GV22Zt8X/LKnwsrGnvgSMxemMn5sqiVtcMb
         23ZLUChFsvkjV/R2k7ythMAyR0O8cZbHbG+ZGTDCz/5JO33yvsRbvoYfQ5qH1RWgog1e
         gS0OKE30Zg9EWpbHk+Ykb85Rt/1hwDr+iXQ6b8jr9EolwNoxGcdYbYwhekamb8RWP2fT
         DmR6uFx6ZdYl38HMVvrmY8uwTAGpNiSjomdIYsA5yb9KGYW6ABfkWIK/xMDj9h3eprAa
         0eQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FxekXdw49YNubFgtAgWAVWa4vzXlzMd/1KjHaOwgz2A=;
        fh=NdQnZcBTR0Xhg3rlxJzp2AjLgRPruAvp/4eGICXzA10=;
        b=jrXs0i1Fh3hZBNQTfZ+uL/Oll9m0zHIHHVA8yvk5WVTiVIOy6OHvWrvw9px2BI7H0o
         78zXnDDwHE3JfK9DTcb9KNCD8idxW+Hynxu5f8wLonRiQEwNCb5gKE0MXD1On5ESIx3g
         qtk+KX3rXDLydlVY1StgsMGZX+ZjRL97ChMALY+EXWQn4CTt41cAHSzKSKwf/migml/z
         pEweqC2Z34e1ZJmr1HPxTN8Gp/sVLNjkD5B2f8Pzz/7BNx5TNwaWKiEhT0+IXt5mY/3u
         IrmMKMQbBv3jkDSrorQWtCUy4mjECF2cyfjxn9z56sO4Ig0TgRTBeOJ+26OQkPWOLafc
         cVsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778610361; x=1779215161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxekXdw49YNubFgtAgWAVWa4vzXlzMd/1KjHaOwgz2A=;
        b=Qk6qBvVDgDF+MzyKmROfatGT/UBDKuxvoM997WKxWtj7i2IycYW4IIOcAT9BP+VnHW
         HCS04nhrdKKmc9pGDQgwkV4eyGDPNiawodSxDZsKm05Y2BYJ1Kyi/GLIZkgfHYCFjVCm
         HMxdkxkDUYT5LqMibuXJcP2l/OVJX+9/aX1aoBj+E0kZ7+CdqgSNfR+GuXHemIJg3aPl
         /Lf/ugeDk8qrAMefKFPy4fNNQzGbhvZrmhgtTZROs7TmbO1AvojEBythgQ3MFCPWsB6U
         1be0n7zU5imAqhCkJY+m5ZfAmtERYLa2YcL1L2aMsUlYunIjqQJw0WloixjLq6rE4c9G
         iOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610361; x=1779215161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FxekXdw49YNubFgtAgWAVWa4vzXlzMd/1KjHaOwgz2A=;
        b=IrOVIfGh728T1WH3UIA6Kk6H+wHfbbIr0s21t0uw0wFgH+k7DQ4P9PQhqPAu2pqzRI
         BwYY5zy/TudBTDSzHXPVqIPv3qCuIh0rQ2Zk3jur/Phlq56+YStQxj3v7rTV0zp65hUZ
         tsScCET2XtSBnPChpYnMcXJ5tpFcyQ86KnScD0P9/pSXuaHIc7QLiBKVhUnx6g5zK4FD
         4KdFWUc1JOq3TMZBoi6WzUDcpohojf8vDRq0ZE8LFC7mE2NpH+dPrkfaWf4fbGXRw6W0
         /DG/vFwX8QnwoV4/+WFQIAUOZxcI7U6oJnRSzmzVAb3RgvZRzVaLAJGUnuzy8vL2uYvk
         4e9A==
X-Forwarded-Encrypted: i=1; AFNElJ/4WyNANNIb1kgScEsc1jPrFeOmWgN5phgxfaxrMsGBRWL4R9S6cE8iTENurrK305nU7N4LkuBoUsysWVC1MYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydz24MSu6wi0/f8SwKFA/gKlJWMcXHogzi4reqYkRwSWMRfK3L
	vjOCJtRHnritF1F2PbJoItIHTObaDG8aDdAPge88F6eoInf8/v9K2ElJhLeTZpYuHOmvXzy5v8e
	sJoAKYRy1pRKWzkouWNP47O1jRyRhH/nF5vimEKJQ4xcxX2uN2xuqe1N9wUq9ytvCdo5lUFpOU+
	uXFUZNH4vcMoOVDsNWlSP+97M47/7NjcAJ+k5flbFiihzryA==
X-Gm-Gg: Acq92OHJ3JeTFVlJ2cgQAy8iogeW2bVkpFtRwcZU+kz8dWJPHVs+wi8MQM51ieHoxgJ
	c2RXMq+K2g7EmXaZ8H3XbGSwNuT/HLdibE93wVuq3v5s9xXdD9ig4P4C8vHvSy+XqN2IjK6qlCo
	sNxoMQWIzQzorUoAikNgQrXJNVXIIS9qKpcwd9mgw/BVV1swjGVYvqs1AQ4Q2qkuWQQjqBuO0P0
	0s=
X-Received: by 2002:a05:7300:cd8d:b0:2c1:3f85:747 with SMTP id 5a478bee46e88-30119968f3cmr133931eec.21.1778610361542;
        Tue, 12 May 2026 11:26:01 -0700 (PDT)
X-Received: by 2002:a05:7300:cd8d:b0:2c1:3f85:747 with SMTP id
 5a478bee46e88-30119968f3cmr133893eec.21.1778610360944; Tue, 12 May 2026
 11:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511194847.faster.180-kees@kernel.org> <20260511194902.701280-1-kees@kernel.org>
 <62bf9b04fa4eaac6912a0ffd1c4a5114afb5df7d.camel@tugraz.at>
 <202605111337.62C81472F5@keescook> <e367e0ceadbaabcbdeed786db2cbc3c946e7d639.camel@tugraz.at>
 <20260512083525.GV3126523@noisy.programming.kicks-ass.net>
In-Reply-To: <20260512083525.GV3126523@noisy.programming.kicks-ass.net>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:25:49 -0700
X-Gm-Features: AVHnY4I-YHVtOTj26Irx4MdBYkr5L4f3DiqlAcjRIOaHJXfYOcOC2X2b2JpZiGk
Message-ID: <CALvbMcCahd80rBHR8T0oBQmHEqum85md5xfZJvJMFKrk6+rGiQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/7] typeinfo: Introduce KCFI typeinfo mangling API
To: Peter Zijlstra <peterz@infradead.org>
Cc: Martin Uecker <uecker@tugraz.at>, Kees Cook <kees@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, Joseph Myers <josmyers@redhat.com>,
        Richard Biener <rguenther@suse.de>, Jeff Law <jeffreyalaw@gmail.com>,
        Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        "Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
        "Constable, Scott D" <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: O-e8IMWF5cEj_eQOpQ2GGLGoTvTKyMYn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5MSBTYWx0ZWRfX2r15A05VvEa1
 DTnAuj3NsZCyWVNs92ZyZu7xVPdD5JYSJf+WVVeHXnt/g30JtSM+2Kwm4orTlRIrfY61inMVOB4
 SwbBmVhFokUzt5je8CdvRieasR8Q+JVf92Ek1pb0OBaaOCUJ+1wv7Fyu0jMTJ2IoQvdqzyXjn4c
 IYatdNMvcNivEtyaSaAN/4nIYQklhFnOwP/ICsN0/eqcY46pL4g9I1aXjalOnlMiysi4aoxR3+7
 dX2plznfnQEAkuDi3eYqWp1ThitD/9KwF0soNyVJ08O2TbehvS66xo59PWgikZZnoN21eTaUtdk
 /Bn2Kl36Qv35ZUbnPXHPjGIGX3KXmt6QbhvbAcBX8hNkLZIRjQuFgiD4FKKFuWFleWwn+UuWX1n
 nKzijntWNaE5sAoOXhzcKNVNCKLxvmHigit1e67uHIZvckeNF7fsaDHy0DFnLNlsPB44tS2bz8W
 VNX8NZHhO3MOmldW31w==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a0370ba cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=JfrnYn6hAAAA:8 a=4vo_P4VNRs7BisxJmU0A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: O-e8IMWF5cEj_eQOpQ2GGLGoTvTKyMYn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120191

On Tue, May 12, 2026 at 1:35=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, May 12, 2026 at 10:13:42AM +0200, Martin Uecker wrote:
> > Am Montag, dem 11.05.2026 um 13:41 -0700 schrieb Kees Cook:
> > > On Mon, May 11, 2026 at 10:08:06PM +0200, Martin Uecker wrote:
> > > > Am Montag, dem 11.05.2026 um 12:48 -0700 schrieb Kees Cook:
> > > > > To support the KCFI typeid and future type-based allocators, whic=
h need
> > > > > to convert unique types into unique 32-bit values, add a mangling=
 system
> > > > > based on the Itanium C++ mangling ABI, adapted for C types. Intro=
duce
> > > > > __builtin_typeinfo_hash for the hash, and __builtin_typeinfo_name=
 for
> > > > > testing and debugging (to see the human-readable mangling form). =
Add
> > > > > tests for typeinfo validation and error handling.
> > > > >
> > > > > This ABI needs to match what is used by LLVM Rust (which matches =
the Clang
> > > > > ABI) so that KCFI can work on mixed GCC with LLVM-Rust kernel bui=
lds.
> > > > > Instead of inventing a new ABI, all use the existing Itanium C++ =
mangling
> > > > > which matches KCFI's needs.
> > > > >
> > > > > An important aspect of the C++ typeinfo behavior that is retained=
 here
> > > > > is that typedefs are treated as pass-through except when the unde=
rlying
> > > > > type lacks a tag (i.e. anonymous struct, union, or enum). This pr=
ovides a
> > > > > distinction between those typedefs and typedefs used to provide _=
aliases_
> > > > > (u8, uint16_t).
> > > > >
> > > > > In the future, an additional "strict mode" builtin helper pair co=
uld
> > > > > also be added to follow strict ISO C type equivalency instead of =
the
> > > > > existing typeinfo used here, but that is out of scope for this pa=
tch.
> > > >
> > > > Note that ISO C would require *less* strict rules, so the current
> > > > mangling would reject compliant code.
> > > >
> > > > These ABI issues were recently discussed also on the rust side.
> > > >
> > > > I now worry that it might actually be a mistake to enshrine
> > > > the wrong rules into the ABI, creating language interoperability
> > > > issues which might then plague us for years.
> > >
> > > Well, this matches what we've already created (and have been using fo=
r
> > > years) on the Clang side. I'm happy to rename this to whatever you wa=
nt
> > > to avoid confusion, but I don't really want to change the rules of th=
is
> > > ABI. I'd rather get it working as-is, and then if we want to make
> > > mangling changes, do that simultaneously between GCC and Clang.
> > >
> > > And this is totally do-able, e.g. I've already created the transition
> > > path on the Clang side for changing the hashing algo. For KCFI, we do=
n't
> > > need to worry about cross-ABI-version compatibility: the kernel is bu=
ilt
> > > as one binary, effectively. We just need to worry about GCC/Clang
> > > compatibilities given the Rust side of things.
> >
> > I think with the generic names (__builtin_typeinfo_hash) users would
> > start to use this for all kinds of things (because it is useful more
> > genrally!) and then run quickly into trouble.
> >
> > So I think one should either have less generic names, or probably bette=
r,
> > some kind of ABI argument. An ideally, we would then provide a
> > standard-compliant and future-proof mode out-of-the-box (I can help
> > with this). If the kernel then opts into a stricter mode this would
> > not be problematic.
>
> From the kernel PoV, GCC has been lagging behind horribly on this, and
> the sooner this gets merged the better. If Kees were to rename these
> intrinsics to __builtin_kcfi_*(), to make them really specific and free
> up the namespace for the more generic one that should be good enough,
> no?

But the GCC PoV is that this was merged into LLVM without taking into
account C correctly is a bigger issue. Really LLVM should have fixed
this up years ago but didn't.
Yes this has been raised to the LLVM community as being broken but it
seems like it has been dismissed. Linux community has been dismissing
this issue since it has been raised too.
My suggestion would be to name these builtins as
__builtin_linux_abi_kcfi_* to signify this was a mistake in the linux
ABI.

Thanks,
Andrea
