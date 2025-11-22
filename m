Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88424239085
	for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763782132; cv=none; b=KG6k1un5jc1GIcHqA5sNLNVKTOqrkItp8z3EM8i19e5JaOBZKxpmArru0ceaitEJA9j7waDc5CWB6I9YzDLFRzFCeGt5q3UHrWze5Dh97SsQGKykrZSEJxX2SDz5PvghdT4d636JQA+vGbqez0fPSXypkKEBRmrjY6u1Cna2mHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763782132; c=relaxed/simple;
	bh=RKOUPvNT629am2AJR2sFXlcmEGZLMedDgZvG6937Py4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FECZidPhBT/kQdkGUVUtc++0J4yiecvRsRLh2is4as207TW3oU5+RUsv8a1UIoOeKNHbWl9a47gl1YxJSXvwc+yHpzf4UfOwOqCD2SLYG+aI1ssQymAVajnYBR1zaqTNl/472gPgBb/zfRSWi6RX+AXYk2w4XcwHgfW+AQuXZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J2bK1Wmh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jp7pWuK4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J2bK1Wmh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jp7pWuK4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AM2Y1J71396507
	for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 03:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AhQmqoxXwYY4ZpAXGeBUmORij/dXYpJqsKDtoxmilEM=; b=J2bK1WmhI7b4O8OB
	CKIVEcK1FZN8o6hDOZ7tJm1vW1pZaZucW8sN5jWGvdFVM7MxHH+6l/r/zX297/3m
	YhxXLgQuxH1loKkGkd4uiNuY0DqzL8rKjt+qmrDeaR0j+a1TAQ8PC8pkjalP+8CF
	tRN5Ux9zyxHHRLn5HzejLzuF+Qvupl2GzZb6pj02c8Y3c79di2iDHYgqLXaq0VzM
	Zbb2ATSE+1HuJRNe9wsP0KVbnanK1Ki2WC0z7zo1PBL2ufUrmsaWzh74ineVDd4B
	pLBSU8wVrHkAliBphcUEZzuDR7RVrXJ9qq3UOo95RC07ky4ONwkwJY+HWVmYjiY+
	1PYyow==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak4gfg2hv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 03:28:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso7643222a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 19:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763782128; x=1764386928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhQmqoxXwYY4ZpAXGeBUmORij/dXYpJqsKDtoxmilEM=;
        b=Jp7pWuK4cRijlnTY9IqTY/ifTVf2Cbm9ufbqrKrefjDPs+kMq6/Io4+Nymh8jNro6/
         5CdcjVvzJ2fHtGlXYERETOZh80n1mzWQ2SXK0Y4nbyIyaUZj3ICv1D70ThjSLH+USPF1
         PPaejs5NE0i8ejJocM4vhbvF/ZPi/cOKUgyPx8qYChJ5M0HCIxqz6FpTotP9I3g4xL+l
         UXGfF+tDBF4ffnUOi96z9ycGRMNRO4OErpLn356071DE83f4sVT8xq553HWWbOdyd4wW
         ZZ2V1xKSikPkKgPswBsrXkdSab4ra9CnS8zWU2mup7LP9gBtA6zB0mLj6DpWGrBaZhfh
         2aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763782128; x=1764386928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhQmqoxXwYY4ZpAXGeBUmORij/dXYpJqsKDtoxmilEM=;
        b=speRxCe0ls3B58RcYOeLDAr/6mmjLJClePg79vgdWG0OeAb90RU9kGOUIfh33i1ivB
         qoOMcI0NFH0PpSCzCqufS5sM84DjrsZk6ejogKN+WPisjGxhZOQVanaPuACYEFKBVgae
         ojgRpv6s7vUDZusFmRaBGN3sX6BcUYCdsKOkZQ3Mg+AvZVv0F7Ht8JBFAnHuHtttFh27
         2vf6mFuGldFc+82w7pa0i8q+p7YX7rQuK2vjKlSAORzxnzbqnyEhpxLKez7NSeuGM5El
         1R3yppfOiYW7HnDW14dXd5Yun1xwpE4i9HEy/p7cJBh03xfcS3QqotV71EfiKDaa3Yip
         uq0g==
X-Forwarded-Encrypted: i=1; AJvYcCWkfW6V7XkeyHexbFlXkVv4OCbcFpfVOWfhRj2PAsKNpmgj7ybxxNg+4E9Jlg7VJOz7V7+nc5cbTM0AS68Go+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6RW5msbq3TojNQtLi4qm19/yZli7sO/l/TmrB0AnT8jSe4B+
	jwUetYnVc7xSJQ9gsqczRrkZBuNivjNaLK2tnRmVWO1mOlocklauhNJoKgxgGM6ir8CDC4aXy81
	cGtrJKDvR90kE/7L0gSIGRPOoeHEc1iiDW+vfFhi/7O8i171crQSaxUP8ZvM3aOjgw6oqL56lv4
	Ow9IjU/ymkDdzvBCX9ngOjWV8JQZv6rZdPjBM53QlVl6SloHKbomPAx2VQ
X-Gm-Gg: ASbGncvlffBP8yEETzWLEUflk884QEBuVd6uUNbHskhPYgEo3PX0mneGhwjpVzRaR/v
	aQ5z6oz+6gvu8IyviwxquU0dniWfSg5994q+/pzWJLjtAgWacNz5ZI5Oxj51Zb8o5LC9ePdMukH
	UMS7BlGivQLRUC5zm30vpdUFZDU8JC7JGtnUkxUzvf61fMjDg8M6y9D9B5N+hKFDmO
X-Received: by 2002:a05:7301:2424:b0:2a4:4bce:309c with SMTP id 5a478bee46e88-2a71927d3c3mr2046165eec.22.1763782128008;
        Fri, 21 Nov 2025 19:28:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwyr75Yd85HcwMxu7AFrzg7+2Hppb7castmrCUbEScDHdu0JyPWb1Ez+5QkIhUWwgWVWUN9iFDI4dXdNsZXRg=
X-Received: by 2002:a05:7301:2424:b0:2a4:4bce:309c with SMTP id
 5a478bee46e88-2a71927d3c3mr2046155eec.22.1763782127447; Fri, 21 Nov 2025
 19:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121182426.work.116-kees@kernel.org> <CALvbMcDEc_C23TvGp9wpWkKvePM=sJ-3u0oQ4y45_SG9S6cn6w@mail.gmail.com>
In-Reply-To: <CALvbMcDEc_C23TvGp9wpWkKvePM=sJ-3u0oQ4y45_SG9S6cn6w@mail.gmail.com>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 19:28:36 -0800
X-Gm-Features: AWmQ_bnr385UvOb5wp7sfNcl7n4qA8JQNELfwzvR7JzfDfEAZekrO8PVn_-vgLI
Message-ID: <CALvbMcAPE5eJTCutV6CCdj7V53e-zon4Mj3Qnw9xwd6cF80HxA@mail.gmail.com>
Subject: Re: [PATCH] aarch64: Extract aarch64_indirect_branch_asm for sibcall codegen
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyNSBTYWx0ZWRfXyqwmaxVnkrAW
 iRpKlKzkai9AxxTWGSbfW3EKVKp/hbjpb+kzRLMxaqP/SXwa8bSQw2yCUccOoL4WETB2U+RlmDn
 VPDWWX2R//IFN9wQVhBn3Mi9m4WwT0mGgK5FfyhLKHCakGGH038VUe11WWzycyDlrz3p+58w8Bq
 DEV+RzT0vkgNEj+pkTnYYM2wytsGu8BVQaEo3ljF0MyQycr2SLsBTYbxzqNzMG3hv7qwuKoudtm
 kEen+t0emhTZa2NXb1lKuj1EOF/zsXFyJsgyGY2dtiB6Eps4cSo20T2INM8aFKJ7tozkzKtFNcp
 LXvlN78vRk+q6es7qSOY5mepbZD/GEqSPpzQZ8SkmUGNpn5F+ymswROGPE1A1LH/qHhCuCl10OC
 VLqC8yGJ0tP085FsDLGDzOwpkOl1Ew==
X-Proofpoint-ORIG-GUID: nAkxnI8n5d58Yg-Hv0avekVXHOZHavWn
X-Proofpoint-GUID: nAkxnI8n5d58Yg-Hv0avekVXHOZHavWn
X-Authority-Analysis: v=2.4 cv=b9a/I9Gx c=1 sm=1 tr=0 ts=69212df1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=srfSj426rKA4V-l2Q18A:9 a=QEXdDO2ut3YA:10 a=4y_uBq_lAH0A:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-22_01,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511220025

On Fri, Nov 21, 2025 at 10:39=E2=80=AFAM Andrew Pinski
<andrew.pinski@oss.qualcomm.com> wrote:
>
> On Fri, Nov 21, 2025 at 10:24=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:
> >
> > Extract indirect branch assembly generation into a new function
> > aarch64_indirect_branch_asm, paralleling the existing
> > aarch64_indirect_call_asm function.  Replace the open-coded versions in
> > the sibcall patterns (*sibcall_insn and *sibcall_value_insn) so there
> > is a common helper for indirect branches where things like SLS mitigati=
on
> > need to be handled.
> >
> > gcc/ChangeLog:
> >
> >         * config/aarch64/aarch64-protos.h (aarch64_indirect_branch_asm)=
:
> >         Declare.
> >         * config/aarch64/aarch64.cc (aarch64_indirect_branch_asm): New
> >         function to generate indirect branch with SLS barrier.
> >         * config/aarch64/aarch64.md (*sibcall_insn): Use
> >         aarch64_indirect_branch_asm.
> >         (*sibcall_value_insn): Likewise.
>
> This is ok (will push it later today for you since you don't have
> write access) with one minor change ...

Pushed now with the minor change:
https://gcc.gnu.org/pipermail/gcc-cvs/2025-November/445384.html

Thanks again,
Andrew

>
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  gcc/config/aarch64/aarch64-protos.h |  1 +
> >  gcc/config/aarch64/aarch64.md       | 10 ++--------
> >  gcc/config/aarch64/aarch64.cc       | 12 ++++++++++++
> >  3 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/a=
arch64-protos.h
> > index a9e407ba340e..50623c3bed2e 100644
> > --- a/gcc/config/aarch64/aarch64-protos.h
> > +++ b/gcc/config/aarch64/aarch64-protos.h
> > @@ -1272,6 +1272,7 @@ tree aarch64_resolve_overloaded_builtin_general (=
location_t, tree, void *);
> >
> >  const char *aarch64_sls_barrier (int);
> >  const char *aarch64_indirect_call_asm (rtx);
> > +const char *aarch64_indirect_branch_asm (rtx);
>
> `extern` should be in the front. Like what is done below for the other
> ones (and not like the ones above; I will fix that separately).
>
> Thanks again for separating this out from the KCFI patch.
>
> Thanks,
> Andrew
>
> >  extern bool aarch64_harden_sls_retbr_p (void);
> >  extern bool aarch64_harden_sls_blr_p (void);
> >
> > diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64=
.md
> > index 855df791bae7..de6b1d0ed06b 100644
> > --- a/gcc/config/aarch64/aarch64.md
> > +++ b/gcc/config/aarch64/aarch64.md
> > @@ -1581,10 +1581,7 @@
> >    "SIBLING_CALL_P (insn)"
> >    {
> >      if (which_alternative =3D=3D 0)
> > -      {
> > -       output_asm_insn ("br\\t%0", operands);
> > -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> > -      }
> > +      return aarch64_indirect_branch_asm (operands[0]);
> >      return "b\\t%c0";
> >    }
> >    [(set_attr "type" "branch, branch")
> > @@ -1601,10 +1598,7 @@
> >    "SIBLING_CALL_P (insn)"
> >    {
> >      if (which_alternative =3D=3D 0)
> > -      {
> > -       output_asm_insn ("br\\t%1", operands);
> > -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> > -      }
> > +      return aarch64_indirect_branch_asm (operands[1]);
> >      return "b\\t%c1";
> >    }
> >    [(set_attr "type" "branch, branch")
> > diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64=
.cc
> > index 6dfdaa4fb9b0..89097e237728 100644
> > --- a/gcc/config/aarch64/aarch64.cc
> > +++ b/gcc/config/aarch64/aarch64.cc
> > @@ -30822,6 +30822,18 @@ aarch64_indirect_call_asm (rtx addr)
> >    return "";
> >  }
> >
> > +/* Generate assembly for AArch64 indirect branch instruction.  ADDR is=
 the
> > +   target address register.  Returns any additional barrier instructio=
ns
> > +   needed for SLS (Straight Line Speculation) mitigation.  */
> > +
> > +const char *
> > +aarch64_indirect_branch_asm (rtx addr)
> > +{
> > +  gcc_assert (REG_P (addr));
> > +  output_asm_insn ("br\t%0", &addr);
> > +  return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> > +}
> > +
> >  /* Emit the assembly instruction to load the thread pointer into DEST.
> >     Select between different tpidr_elN registers depending on -mtp=3D s=
etting.  */
> >
> > --
> > 2.34.1
> >
