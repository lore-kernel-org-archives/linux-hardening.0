Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86422C2374
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 00:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161735; cv=pass; b=l8qo3oanfoLNKx7SIlTk7qrvUM7OSmjVlmymJVHPOWIJ04ROhSFqmhvjEwhxGiYiQDrEs8XWaPgnL4iyi348gM+rGC+RfEyzT0a5hY4+mSDYEtXo6Hdj8LB5RZKQHk3Xq7q3y6CgS9mlIahRSv7GLkVbeuUPIixvgZAXqP0QPw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161735; c=relaxed/simple;
	bh=p7oYvsWkr6KDYE7GA1BMWS6fKC3kSA8MSURnQSVDHz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLvzlQyLjX8M3rKL6zme1C8RbKjV2qMhoCUZapCa4FULgWGiw+QZyWWlkEAIsSQ0zeIOJp/1ScfEKQiEclyR3yEW7HC5OZ85a/sByWajnS7M5Zo6h19BOgpVR0vDQsQgl6BpC+uCpf5slkOY0bK+Q0YEhMHWzrbRKCqZu8sP+kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jfDSpru+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OtlxexcS; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jfDSpru+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OtlxexcS"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKPR8V596054
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 00:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iH4uPdqVq8rVulMDBykJ3eHtUEh/TtFI42XsF3m+j8Y=; b=jfDSpru+A9HeiBbl
	6xXPZ+RP9eyQ1tfR7y43A09DWWDeoDYjLzwkAQrFyeKU+dtGMEXz24uofACQvBjd
	o4Qy8x/qDMwe0kzvL9xhK2vhaAXcc3FDi22Ncf0/IeuxpiPl6q2G29sJeS42o0sI
	4i3HC4nDiSNfYRA5V6JBnqiBEtFHvUIefcOlXaszZd3z3TGMAMqNFvwA88s5Cg4t
	crcuZWkK+dZZWMoiC7r24Mq78rW1hImD8dvLVHQfY4cFJ3ykTtWGqzmwUvH3X7c0
	yR+XdCpjcBSYCenpW7VlnwK2uPppQiRm89HFnysVomBm3dDK30LmXhuHenjvatHj
	clv3zQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7q637fc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 00:28:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c890bac374eso14976309a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 17:28:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784161731; cv=none;
        d=google.com; s=arc-20260327;
        b=JPkOfPjXa0ecZsoXd63+uBE9bZxrcd80inLZKplRHyzMZ3m14/E24v6ZGjbtoCsk5a
         +x3xb7VDgn5xLdNMUZ4XZpAH0YbdAg8rSeOE5IdRR2H98FgrP2b5WFNMi2hdfDgfOQVs
         0vX3FDcZaj5D6LBHJhsGy0k6T1wz2gGwFqzZU3TNSRYTQL7LSbWG6pazL+J2LvqOEBbr
         4hj1exEMypIUbc3z8Q3a9F8a4sAPRBs56RK6linGHJQr2vth7aQ3QYM1ZZ2lxmTf6okd
         TkqkXdToN48pd2sy2sUQA8LlpbjpGygq2SGRfbavjB327gNbPWLCENhLamg/IWj5VQE4
         mXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iH4uPdqVq8rVulMDBykJ3eHtUEh/TtFI42XsF3m+j8Y=;
        fh=TOovm1FATfPo1fq9kmmV6Am8x1BF61aGZml433RWJfc=;
        b=QEm4BciBUziFoXOzbClnnRJtm8DHT7mXBMdwLpjPgTgpGl5po3bsEwG1+GO3499IM8
         IE8nMJiuzH6xnmzftfxOzlng6qwxMzxoEWdZyM0amDulWJ5fXjzrb/K+abVZDSslRr0+
         rUlaiKvM7l/nvcrtf7+rWDto74VfklHYuP107Xa+om/ZhoP3Pw/nScDlBSR8xh+pqctz
         DJEsjsdkoMANk+xAhweVt3c6bA/K7iucWlvQtXdQ4Ak2b8mwXVzlnQbyFJuDRk5E1c+5
         MCAWgAHqh36FDh1kZlrCkovK081GCOKqtZ8Eq/I4huEjM4uazbvvQGucKm6PnrGTofeY
         hkiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784161731; x=1784766531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iH4uPdqVq8rVulMDBykJ3eHtUEh/TtFI42XsF3m+j8Y=;
        b=OtlxexcSCuckBgebgtbC2G6wxNeEXSNXrU3FdTsq6mONHEFHELhL1aYmctGOwzKojy
         cGiiBJaAPPZ2LvYRg9chmRTJaXy0smud70sITyy1vGxGOBPMZCUnvuvIX9GZ5xToktge
         IoHUXxJ3hszEYwRFXBBI9n2sYReKZUY84sNuiJYcAGjQHvcdgDY+DqCFzz1opPbe3nN6
         rUER5BxGwrRg6yR78m2abq75Iv9ZPyNG8py5w4wtP2QYToWB1wFsg4Ro9hapKeOICBht
         B672+wDJEGc8ZC2TpyhW0iDYPOjrEiI0+5+0yx/2J8NOcOBu2zrBIQI6MBLITIhlpAf5
         iMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784161731; x=1784766531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iH4uPdqVq8rVulMDBykJ3eHtUEh/TtFI42XsF3m+j8Y=;
        b=sbOK3zRaiI4ly/PYoNFCJc6ExVMS4o9/oU9wsFNlq3oOZgXBr4BJb8ELR7pMqR1+2/
         zse8JUYuGShijG03lIKZ7k0sO+4F3eI6G5yBfvnteO6VxHIYfWwNzcXElow1lLM45pca
         jBqBMpHCtdBqByS4KHj375JOcOFZM8dOqCAsRorZ05FyzxTlMn2wJcaYHUucCgd9d6iF
         6ZMlfcrCeBD38fJU3ZU1sCouUhr7duvxlaHjnxDvYX/rSm/Iusov2yrvQOyVwPze9L66
         F6XWd5uKa6AmfdMtpkh7OgPmqREQ+32kiAyaUA+dsLGdThxW8SIUCowIJLWeFNcz6R0j
         kzBA==
X-Forwarded-Encrypted: i=1; AHgh+RqwL/KgUDGiX8A5LCK187D8hg++6bqL9Vto27ui8kVnmSDSyJpWDvKfQGeRMelj8VVXHTYcmw91X0epop58Nn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLoEt8rLuuk5eLfd5C7lxAlfCX1F+mPQePVKMz61eAEO/mX4H
	z12r2ht6OYuLPyHA+uAe3wt3gPlCM6vPa0YrZPP67Q+m5x4UUGt5rhAv2/knX1mJtX1DmvmTzW1
	KQltSDcEYbO8p4vW5zeDzT8Ch6fRvobGtWgJ4ckhlWf1esQkVgGk1LV3BYGXSh70Y9YnOLyxwvu
	ZGb9BltQqVf9OyfQZ06pouB/UpqUg5B0xYKFDeadL2rVFhjg==
X-Gm-Gg: AfdE7cmu64AE2H6YhNHcwww3d1bispvmK46vmvkpYN2e7Ld5UaBvt8oWXpMXF3eMSas
	5+lbwHteQ7sWYsE++5GgiVpI29pzLzJxYVEjB9blaWu3Mz5Xl+wFyMj96Ysjxq9vjISjvD8+XbY
	XrM+nyt2PTljGlPwOoJG1FLQYo3ibjUj7nhf7WvD+rAedAHiDra788fw==
X-Received: by 2002:a05:6300:2209:b0:3c3:856e:dccd with SMTP id adf61e73a8af0-3c3856ef46emr1828181637.23.1784161731520;
        Wed, 15 Jul 2026 17:28:51 -0700 (PDT)
X-Received: by 2002:a05:6300:2209:b0:3c3:856e:dccd with SMTP id
 adf61e73a8af0-3c3856ef46emr1828152637.23.1784161731058; Wed, 15 Jul 2026
 17:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618204530.work.910-kees@kernel.org> <20260618204539.824446-1-kees@kernel.org>
 <CALvbMcCiQ1b0KDrJHS-irGMWNEk5oWaWs31KQor2ZHPSVewQ=A@mail.gmail.com>
 <202607151151.AB5F1BD0@keescook> <202607151636.1AA31A76@keescook>
In-Reply-To: <202607151636.1AA31A76@keescook>
From: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 17:28:39 -0700
X-Gm-Features: AUfX_mx-vzIQGkDspGcLLV6k_nHOvLnFvBblxZv4iWG7UJvONPylYm4yGt7ayd8
Message-ID: <CALvbMcB9iEc8vp4WahmOZK-w1WZjmDDp3-U0ui61PqLZox0D=Q@mail.gmail.com>
Subject: Re: [PATCH v13 1/7] kcfi: Introduce KCFI typeinfo mangling API
To: Kees Cook <kees@kernel.org>
Cc: Jeffrey Law <jefflaw@qti.qualcomm.com>, Joseph Myers <josmyers@redhat.com>,
        Richard Biener <rguenther@suse.de>, Jeff Law <jeffreyalaw@gmail.com>,
        Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
        Martin Uecker <uecker@tugraz.at>,
        Peter Zijlstra <peterz@infradead.org>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwMSBTYWx0ZWRfX6NYAdpM5R++0
 srzQ9LAKMxUfNFaz6caDNhw1hzzDEMq0Dlk3xbjBPoLjMSATsnjsTigld/4UbUwXCNSkNEHRFKg
 gU0zFX3TF1eq+PfpF3DKTddN7Do/ozs=
X-Proofpoint-ORIG-GUID: UdniOpiaejDLJkOiPvMDiOivGQ1AK1dS
X-Proofpoint-GUID: UdniOpiaejDLJkOiPvMDiOivGQ1AK1dS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwMSBTYWx0ZWRfX2t9gtsF1g2Hc
 h6mJe/om7NwiWOLIFweAQ0Um4fUfmezTt+zcqlRwsDPQ0AyUMePkTkYRv44Gmu8dtuJafY48Giy
 lDYEaHXLv8yzW7XFxwVp+EhKUWTA6z8cnAEikWtz2fOCLga/hTJVhQrkXLHNWv8tYF2LQUkB9ow
 sbNiagJv5E22qgQLEeMxJaf1PaP8SV8yIFoua2aqh0bmTVtJw/QnU3osInl9w7TLqIZ90S0c11i
 Vl8WPYosVz7DG64P9F7T18liadKX6LlbXLVUOAZUrJugEhAS1XZPKc7050g0VnuoQVuug5LT3IS
 DdxlgvYrr+mwgG6xQPzLg29VxXMigRv4UM7Nr0gfFbxFagH1FwlkaYrr5Bt86wwOHjH0jmBBNea
 5Z9tbYup6DhWzGMgnFEF8OXf5QZ9hPSszFVoTptR68iye5SgVWf9I2MXPmDAYsb34PFJJWMWybn
 pOEJFM7PpgrsQNzvLqw==
X-Authority-Analysis: v=2.4 cv=BajoFLt2 c=1 sm=1 tr=0 ts=6a5825c4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=F2Gao3xRpLiPCcqKhvEA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160001

On Wed, Jul 15, 2026 at 5:07=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Jul 15, 2026 at 12:06:17PM -0700, Kees Cook wrote:
> > On Sat, Jun 27, 2026 at 03:00:42PM -0700, Andrea Pinski wrote:
> > > On Thu, Jun 18, 2026 at 1:45=E2=80=AFPM Kees Cook <kees@kernel.org> w=
rote:
> > > > [...]
> > > > +
> > > > +    printf("\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> > > > +    printf("Passed: %d Failed: %d (%d total tests)\n", pass, fail,=
 pass + fail);
> > > > +    return fail;
> > > > +}
> > >
> > > It would be a good idea to add a random generated testing here. See
> > > testsuite/objc.dg/gnu-encoding and testsuite/gcc.dg/compat for
> > > examples.
> >
> > Okay, thanks for the pointer; I'll see what I can come up with. I
> > generally dislike random testing since they may appear to be "flaky"
> > when they trip, but I'll give it a shot.
>
> I don't see anything we can do valuably here. There's no round-trip
> parsing going on (there's no independent oracle). For the existing
> mangling tests, I have hard-coded all the expected strings/hashes. I have
> gone through the TYPE enums, though, and added a few other missed types
> for the mangler. But I built a python-based fuzzer anyway, just to see if
> I could find any other combinatorial ICEs, in case I missed some mixture,
> and I could only crash the ToT GCC frontend. :P It's okay in 16.1?
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D126284

What about Adding something like gcc/testsuite/gcc.dg/compat/ where
you compile with 1 or 2 compilers? to make sure you can call the
function indirectly with the check?
Or is there some extra code that is needed to support that?
That is you compile one side with say clang and the other side with
GCC and you try to invoke the functions indirectly?

Note python right now is optional; adding it for this testsuite seems
too heavy weight plus there is already a decent fuzzier as part of
gcc/testsuite/gcc.dg/compat/compat.exp anyways.  That has decent
options to make sure you get the same output each time unless you set
a flag and such.


Thanks,
Andrea

>
> -Kees
>
> --
> Kees Cook
