Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05F340A67
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161290; cv=none; b=cFWZ+6Rr6dmIT7KbwdQyziBEmf5kcY24ScFltHeFJGFFAy/P9qr1U6dZt8BGIRokGS0uT/CsRjvzS23KG0iF7g727UK1M//ezvFCK1RZPyv4pmpWHyVNru5hgR5ikjiA/I0SR0S6AlQkbYLaFV9fdi790ygREQOwagcR91xg/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161290; c=relaxed/simple;
	bh=n2flnsOP6tMIokfu/Ue1qbIgObGDT96bf3e66PfUAA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kF+6UbGvd110NoSyrTL3vcgm2SRXLfc4dA/234R6VO9ZphG7gctzYTQSGuUTqTAMHsVA99gmoPjZQdVGluufbJRaOT+3cK2CaMD+8S8fqNtxgWktOjBAg567RIASBtUSY8J8upjEAcuPWCX6uujhHObgUMmwG2A2KVfwjN09GkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J8/HodVc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J8/HodVc"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIemtH018576
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 19:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D4XuMm18uNUoCufJPsFj4THVYW5+szh20hQC2Ji35cA=; b=J8/HodVcrXJPZfpR
	qV/Cwis5xIu/t8RKP5i4dhzOypNyNFj3m/gID1VwSW05qnVqPmgmaLArkFVovWlV
	cMYIBdLVUvoBraC/S39ZuH9cPYAkiHlnnERVKP54upo9R/3iNu4MP3JFzqjuy9lP
	DeNDFFurFvuner6tOuyrdTiMIXZXmapY+RqXnhRUJmSNwGoABukJ5wP44rjMq6Ua
	/vN66Z4/riaXaAIUjsrNXi3ADecDJfZ/ZuzzkhdQ0BvydcLeV+WEZNWwLH9Aov2n
	YN4hbhw5r8nWOupX3FQkxfHnTLgc+n0+wGISbijcAqNwYyRrglJCHhaeOAu7nEcc
	DlH6Xg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pp3tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 19:28:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-27356178876so50064735ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 12:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761161285; x=1761766085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4XuMm18uNUoCufJPsFj4THVYW5+szh20hQC2Ji35cA=;
        b=MURnpHqPfwiagb1fAICtYsZQ/j8kdThLEFLDe0QKhV8AepvtEghvsIUvJvRc9yJjwA
         LRNV7uC917ZSqugL/zNeUvVLMAI6X6PSByYL2qOGDbg75J0Infe0bKHZu1IBzyamek4N
         bPKJIRynBvVgoNBBxbY3Pzx6xFZQY6cwK68RdNNQ+EsmuHg2ywZZ/dNtuNv+YSfAYrOh
         d5Wt40A6hjQR4NED8MLYCWQn3F6m+pSElI6sN8CeWxIxXA58x0Qr8+M5wpFUUNXAySzx
         8OrNjzNBOhpUbXgvB/HGo6ZQ3WE8+FUmk/jtVX8TCVpenOi2XqCZ0H/RKmqgq9xeSXQ0
         dkdg==
X-Forwarded-Encrypted: i=1; AJvYcCUaYgfIwdZGGuWYSKytHXICOWMxb7OaJTe+eNHdkFjNcpCKGmnvbetQK6Y8LS9kTZmCH4of5pNvdOuz+knKtyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZvgBGVzKM6ZsgWRcctogeJU7CPLl+zH2Z1g1o1nG7zVXjq5g
	PQ3v0Z3G3/4xMtBqPiHEXDjGrg2p0Ph4oWOTzmsZVUmiqJz6bcHSmt1LFqRNUvUB2HBP60rFtm8
	M39nk1fYo/57QUQ28sOM4s4oBtNmIN4Q/3qz5fqmoj1OKD96CjKspf4mKBhsyQEoIw4j5X16/73
	7pIUpqZuxWOnQ5Az8sLVoThKDtYTQiG8N2vXTu/Wc0vZ6I3w==
X-Gm-Gg: ASbGncueXmRsI+Zn1ktXJFcTafy1OcUJfwZkDQNQmxd6dBymVZW5FIUZnTrvj39c5eP
	YBscPWXNgpxt+ThGVxIWQ3mE0361rjJUS6Qppbr6UH8KbM13MvqDDyQ1PxL7egNFRIHPlArL5AO
	dp5a5g8jWXSu/ZzYg5ByouMv/tQrbi1mhg5WIxbxT+D5dKRMs5JAEzvg==
X-Received: by 2002:a17:903:2381:b0:266:cb8c:523 with SMTP id d9443c01a7336-290cc9be17amr260195475ad.48.1761161285496;
        Wed, 22 Oct 2025 12:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQA6RP8Ed2o32lvgFT1HpzRIUzAQfMJIGMBdRxcLjnIUhvxZElld7lrlO3BJsAPqLOVEbj8ZnslIQmjmUzZO0=
X-Received: by 2002:a17:903:2381:b0:266:cb8c:523 with SMTP id
 d9443c01a7336-290cc9be17amr260195215ad.48.1761161285077; Wed, 22 Oct 2025
 12:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022181345.do.256-kees@kernel.org> <20251022182243.72085-5-kees@kernel.org>
 <CALvbMcA-MwhBd4y0+im5+xw8_sw3ut68fudwLoY6-nX5gmh0WA@mail.gmail.com> <202510221216.EA5EBB1@keescook>
In-Reply-To: <202510221216.EA5EBB1@keescook>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 12:27:53 -0700
X-Gm-Features: AS18NWAAWBWClVcoB0QhMFFtvWZVqaXp6QrUKiimzBEB-U55PH6GlYQIauxezgQ
Message-ID: <CALvbMcAjVAW-YxLE+qcFLNXVKy0neDop0b1bi=_YfB=8JqBNDA@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] aarch64: Add AArch64 Kernel Control Flow Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
        Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
        Richard Biener <rguenther@suse.de>, Joseph Myers <josmyers@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>,
        Jan Hubicka <hubicka@ucw.cz>,
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX+5Dm5VsTKXAk
 kDV2KqIddXrpw+reFo2pwEDgjaM9bjcqoc6pE/VrNAQX5Km+jSc5Sp/vAapy0Nkvi7nMg1lr/Lh
 WwJkWOdvLIMZ5DJ1ktC/iojUaMpGhPln9RxZ4D9iuL3ymThzeUkOGfIiyAtkms9Euh7lVT6a93d
 wpnOMa0V06oxuiZZnHn60u4Rxan/y9qn0zZPDJYhA6DXlDIJNSupCjZQiFbACNMNhEM7vFO3MY1
 LfYX1GAYdZ8J8e1pkPKHxzvq8+1K5Lt+vside1srVsZxq9T8GEODPyAI4vhA9Og1BB5YWZA+GYn
 vxEikcl3trXMV3Gz1HgSag06TAY9oOorM+GN5gUsuXeP58L+XgjTvP4uDfzw+NY7OJ88LKsvD4A
 wbyidX3r98cak+IO8ntwp1Z64Yf3Rg==
X-Proofpoint-GUID: -V6JwO9-u_1GV_D0Qu5OMfRYhrRCb7vS
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f93046 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=GZVJJ3D10nlMcia4nQ4A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: -V6JwO9-u_1GV_D0Qu5OMfRYhrRCb7vS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On Wed, Oct 22, 2025 at 12:21=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 22, 2025 at 12:14:32PM -0700, Andrew Pinski wrote:
> > On Wed, Oct 22, 2025 at 11:27=E2=80=AFAM Kees Cook <kees@kernel.org> wr=
ote:
> > >
> > > Implement AArch64-specific KCFI backend.
> > >
> > > - Trap debugging through ESR (Exception Syndrome Register) encoding
> > >   in BRK instruction immediate values.
> > >
> > > - Scratch register allocation using w16/w17 (x16/x17) following
> > >   AArch64 procedure call standard for intra-procedure-call registers,
> > >   which already makes x16/x17 available through existing clobbers.
> > >
> > > - Incompatible with -ffixed-x16 or -ffixed-x17.
> >
> > Can you explain why?
> > The documentation for `-ffixed-` says this:
> > ```
> > -ffixed-reg
> > Treat the register named reg as a fixed register; generated code
> > should never refer to it (except perhaps as a stack pointer, frame
> > pointer or in some other fixed role).
> > ```
> > In this case it is a `in some other fixed role`. Or is the problem you
> > are using the allocator to figure out which is free?
> > In the case of indirect tail calls, x17/x16 is always used for the
> > pointer (since r9-5291-g901e66e03e1cd8).
> > Which is the register class TAILCALL_ADDR_REGS.
> > I think it is compatible with doing -ffixed-x17 (or -ffixed-x16)
> > because it is a "fixed role" at this point.
> > Though If both are supplied GCC will fall over anyways (will file a
> > bug about that in a few minutes).
>
> This was done based on feedback from the riscv patch in v2:
> https://lore.kernel.org/linux-hardening/dbf9a593-e19d-4f53-96d0-d067868f4=
0b5@gmail.com/
>
> Jeff's interpretation of -ffixed-reg seemed to imply "GCC should not touc=
h
> this register", which seemed sensible to me from the perspective of the
> "generated code should never refer to it" bit. How that interacts with
> the "except perhaps as ... some other fixed role" is totally unclear to
> me.
>
> Shall I drop all of the -ffixed-reg logic for all backends?

I cannot comment on other targets; they might still want it. For
aarch64, it does not make sense to check x16/x17 being fixed when
using KFCI. For aarch64, I suspect the check will be a generic check
that is not connected to KFCI for the reasons why I mentioned about.

Thanks,
Andrew

>
> -Kees
>
> --
> Kees Cook
