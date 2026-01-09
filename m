Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9D28DB54
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 05:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937754; cv=none; b=KGokipSe/nLbz1+rj8dtAQltbV6ZHNWKH0U/kq0UFx73CzyCpB6eeq9vBcxn4S2Dr6q3sozQ6ZJWB9IEs+hTU7FBksUarzDUO4EqQRJYJiJ3KceqbCe233NF+lvlqTXRXvq3yzs1kroRo+mCT2r1gyCFb9PROO0OIn+HK3rgjTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937754; c=relaxed/simple;
	bh=TDfJ2zEOvDXkLSxeUXXuXtMAPtcoxETGoYpbHbNHYII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ua9yVaXbF+S77duAdTBwWDbxK0dFbENbmdb1XdV5Olbz9ZFh8rFRbX/WUN8nMHOnkXsd/z1rqMgbtxLqDa5z9eNi/hZrDbq26lhrI0u8ZjpcoaJMZOPqUYLSRTIwJC4S9wLQITknmkCubLYTZUavR6A2iJyaeQKaO8kHC6JI6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ke2OKWdc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VSKTUGk/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ke2OKWdc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VSKTUGk/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608NpxqF3727729
	for <linux-hardening@vger.kernel.org>; Fri, 9 Jan 2026 05:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TDfJ2zEOvDXkLSxeUXXuXtMAPtcoxETGoYpbHbNHYII=; b=ke2OKWdcDePJeYzH
	rQ6tx9a5ZryiBMEttH0GSL94Odq1iA6amlZatHd8+2kWOSuzPq82p/EZR+IObXiU
	j4rnxlItlWcU294hdeBElcF/Y4UvcoqmYmu2NEtJhWvpbxF1NFkj5AnTV6+3eV+I
	LGNaQN09i9MdaqdICXfkLVR4tAHF/+6UVuU5uJLqNH05WhZj5OGYnBcLE48fhBTH
	vOQ+3osx4zb8I7qOSzh8hh5iXSXr1k3PxgVnG1bF/PYeFWZvIv5d/B/D10WxLVkv
	aCQ7KYOpnsUxXtcFwa6ZdaiDFmF2aBJI5eFVm1U9yDMsNBvPQnyImxXvm9gDCyq5
	18iV4A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjpmkgt4q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 05:49:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ae51ce0642so3211692eec.0
        for <linux-hardening@vger.kernel.org>; Thu, 08 Jan 2026 21:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767937751; x=1768542551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDfJ2zEOvDXkLSxeUXXuXtMAPtcoxETGoYpbHbNHYII=;
        b=VSKTUGk/H2p0SFhKtJfDuUEDDqjMMZOuBYuWtLarXaxwyNSbd76cJBECspqH6wqcg3
         g8emtWPtAt/Vaw7yMMOgD69AFNJiTNM/rW/ZjqVAhls2i7V6a4/LqgCojh7fDwSGtQ6K
         k94SzQkaWERamdOwZ2GQdeH9RAb0+3G3keJBe2ClJKHUIsS5+nmBpDSuQriTc5NLYix6
         tuLlTikeGf7WodXjETOlzaaxrLcOzgm5ciuxn8MdJw1k0l92fTvsEdMn0+2zuKHFUGjl
         tiKV3WbhDMB13L4TQwfSXbnOvG2f1yUm7HXhiXokhHugomX5JYimRAEyiec4DxJ+wmHO
         IyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767937751; x=1768542551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TDfJ2zEOvDXkLSxeUXXuXtMAPtcoxETGoYpbHbNHYII=;
        b=YBa8X/6fdiEjOgKyaU1HTQMLsaO5n1BPHs6VJSJRMxh/Al4Htn4zTDULBK2946pSxP
         SR9ZwoUoewqUQz16YonDITwbIh2Z272ExneLqJ/JvyXdTV2f/1GqRLY9/Cv+R7z1aCYd
         x0v+8kxwrvF5IYd6c7bxlrgKVwbKTD4UrPs2r/2hvEVo/ciZmKF1n788iPbyZfVf8n23
         tRdFC8Bv9RXlA5aCHJq+lXw0I+47iXLtacRdaGYlDjUkMAYIgTOcPT5gJyrZdKDrWrP5
         c9MvT3rjAk4muBXGZpgYb0lwlGTg8q3WrbmrbXAd7lSpksm+/E9Ob5ZQYA5hGaZiYrr3
         R58g==
X-Forwarded-Encrypted: i=1; AJvYcCWXeZFDD2Ig4WGDgwYxECP0TdpB+TKZ6FjQaiJfJ/sG3FbXhZsKkrEefSW9luiwrgC2LXCF8covVO7Hb5UlAw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+P1y09lpLenJe20oXq9hP85M0ZFt28Ty8sx5AzhyYKbjhsu4
	yTNPCwuqWxKXXfSSvP0r5vHLHqPK6EYMOsPWoK9pxWerIFqn9XSWxpYNt2YI7o+Nl6Ci3XY140/
	I1AO3AZdaNfOpXpFFL0y9Py990mQCB1qdeqQvgQ2sIE078VFBU2wa+bzK7lhMEQHslPvOnx1JD2
	79t/p9OVrWqhGM5aBCMb7p7yKYtvXQXpyxr6DJisRuBHB9BQ==
X-Gm-Gg: AY/fxX7WmvrsGHmTQc5Bmq1VxIfEX8QIlHLTU7W5Fm6BK2r4PP6RDMrwIsTVgwwIUf7
	SHTVDQfe0kyaeH08Z6vfC2ZuPiGWrFepVMPnZ4QlxpyumMo7MgoNFfvE+L68c3l+/voPfKo5gkT
	XYnLnIzL6GmkanLgVv4n2tM0Kl6xvEk25nehh8Z738d1cYyFdikuqwPHw4Bfv3fTQ=
X-Received: by 2002:a05:7301:4e09:b0:2b0:6a03:e6aa with SMTP id 5a478bee46e88-2b17d31c2fcmr6976274eec.23.1767937750772;
        Thu, 08 Jan 2026 21:49:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw8GZep3rAISvch3IywcwuITfEYCOXoh76q7UcF0R9k01L6P2++21hvsZaSms6Yq3/V5mdIDJMLRFn5CwpTAQ=
X-Received: by 2002:a05:7301:4e09:b0:2b0:6a03:e6aa with SMTP id
 5a478bee46e88-2b17d31c2fcmr6976255eec.23.1767937750280; Thu, 08 Jan 2026
 21:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210022025.harder.803-kees@kernel.org> <CALvbMcACT19UHPJme0w1rStX5XEJwNWdAMTuJ=cERkY38+EMQg@mail.gmail.com>
 <269C524E-2FDB-4156-98FE-548993666B03@kernel.org>
In-Reply-To: <269C524E-2FDB-4156-98FE-548993666B03@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 21:48:58 -0800
X-Gm-Features: AZwV_QhhBV88c4RxKD7yV4Rpn3hdr7odxCFOtDJ8yxWsVCNJucAZl_D4RMIxoW0
Message-ID: <CALvbMcCi8SZs415AE8WYFiijh6K0HYixqz68Nbios=BvuB_jsg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
        Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
        Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
        Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
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
X-Authority-Analysis: v=2.4 cv=YNiSCBGx c=1 sm=1 tr=0 ts=696096d7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CCpqsmhAAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DYZlSXkcSxBOwVr2rocA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: Y_FXeTdtq6CugAueCfCAmIrzBLYSSpGS
X-Proofpoint-ORIG-GUID: Y_FXeTdtq6CugAueCfCAmIrzBLYSSpGS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAzNyBTYWx0ZWRfX6cVXmK7dzD2k
 4FNa5JRtP5LlzCjBNrZBJErDamOEuIKLXSXqhWF/iJFUsmvLFrRVE8we+UUHoLHTDBiHfDWJigK
 gwBEguVgdhKnxa7YH1EGe9pR6dJVcnD/+uhyntcthrx04oiD02B6aQ+6AXjjWM+AX2fDKkynI3J
 /7lIzH/VI024/XbVFaOaAijsarLYVhxhZ63IEt3AbMwyAHz3tAN27K7It1l/xJUfvggzh3fFrnY
 lxJefok5lxZc42F2ZfJrwK+xxkQpszkFbRNMIDmA959mJSGuhMFjr+7hNiQnfpHOXwukqNjo9+O
 i/hdGBQIMM7j7D+WUnr7kd5Ebc0UTFlFU347kF37oNo8tAjS+WVLH6L2yuZzImdpM+61S/Z//ND
 HQ7PuYiiu9i1R5thNCvqRbPv5p1n401tLH9rySUCSpmyxz/DzhfdpXdlfu4JU2BvjaZVxAhZ6Ez
 2bbBPDnQ8vgKBJ1OS6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090037

On Thu, Jan 1, 2026 at 7:42=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On January 1, 2026 2:42:59 PM PST, Andrew Pinski <andrew.pinski@oss.qualc=
omm.com> wrote:
> >On Tue, Dec 9, 2025 at 6:22=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
> >>
> >> Hi,
> >>
> >> This series implements[1][2] the Linux Kernel Control Flow Integrity
> >> ABI, which provides a function prototype based forward edge control fl=
ow
> >> integrity protection by instrumenting every indirect call to check for
> >> a hash value before the target function address. If the hash at the ca=
ll
> >> site and the hash at the target do not match, execution will trap.
> >>
> >> I'm hoping we can land front- and middle-end and do architectures as
> >> they also pass review. What do folks think? I'd really like to get thi=
s
> >> in a position where more people can test with GCC snapshots, etc.
> >
> >So looking back into the other implementation that was submitted a few
> >years back (https://patchwork.sourceware.org/project/gcc/patch/202303250=
81117.93245-3-ashimida.1990@gmail.com/),
> >a regnote (REG_CALL_CFI_TYPEID) was used instead of the wrapping with
> >kfci rtl.
> >I get the feeling a regnote would be better as there is less for the
> >backend to deal with including new patterns.
> >What do others think?
>
> I started there and it created way too many problems that I had to contin=
uously hack around. Switching to RTL solved all of it. (See v1 and v2 of th=
is series where that was how it was implemented.)

Ok, thanks for confirming that. I will try to give v10 a full review
by the end of next week. But since GCC is starting stage 4 on Monday
and I think it is too late to add this feature so this might be the
first thing to be pushed once GCC 17 stage 1 starts (mid to late March
depending on how fast regressions are fixed).

Thanks,
Andrew

>
> -Kees
>
>
> --
> Kees Cook
