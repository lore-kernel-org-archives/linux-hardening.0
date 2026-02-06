Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A93090CB
	for <linux-hardening@vger.kernel.org>; Fri,  6 Feb 2026 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365118; cv=pass; b=fSBXB6gy8rwh08GY+cMwbfq1FtD6Y9o1Xqz/z6lDErBnXuTBLJDhsUBus/Hb7vBAMLaFiSlfIlHY0ec2naDOI0JsBmXnWmjsSDO3IDOEZ/BhskYKM7vWdpaI+dCI/Yo/JWI/ia8ioEm4jC+yp6Dl7C/e4k/ohA1DbssgBXIwaTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365118; c=relaxed/simple;
	bh=h0JTNamxN83tifiMzSCGhpsjTofjXMgH4X2O7johJQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLo83hGRtB18aV/fNBSoyTI3rP2DF/wwG45bWxKdez5XZL0c/tLVwU74K0DJpHLEz47t6YvB1MWv9hhd1GwF4PsmnAt2R882WreeXna0rscI2w6zuT477KlFx7vS9riMWo748iA+k7WFH4mXmXtvhS2ZaleG7vR7MeDTRDPSaj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ildAMzro; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AETtPwY5; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ildAMzro";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AETtPwY5"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6160xcgH2058295
	for <linux-hardening@vger.kernel.org>; Fri, 6 Feb 2026 08:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kWLfR2iq4Uky6Kq1I5l8o1nz5cqJ4IFTg8zi44mevOI=; b=ildAMzro+khEYzGq
	sMFyaBRbTeWYD7kxLhdwxyGrLqMf4TlMjUsOFWd6dfedMS/2MXuXVnQzfEXkFVb/
	GFQG6RqB+NAp3zL5jgROucszfWR6ucbdr0QyzRSwfaJCmtTEm2trXYE/S3hiZj+d
	t+azOBdDfFkrpPHtw7uk6sYeOf8P5COwi3+cVVsHuK2otvq+BLoGs6dra4s2Y44H
	C3hA9OE9KsT4a/pkCjLIycPOSUh1Qk2SD4YpePkW/QDfN4Fc5ug5s0AbMiyeTLl9
	mFtZUEA9Q+0dWEUPP881Y/7U5hKMJm1cY+DmnkOMcE9cOWjVQC90ERvBITJ+ix9y
	02Niuw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4x8bjutq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Feb 2026 08:05:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b708fa4093so2933699eec.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Feb 2026 00:05:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770365117; cv=none;
        d=google.com; s=arc-20240605;
        b=cK4YxaZlhtAz3DrzJI35FQyCAGdOEkT0XYd0N/blW4BeUlXi7Ll5mM/d0sboiT43B9
         W2VYk73+GRX0OR7izZqC8HyDxcftsmy6zkmeZ4IMGMMmFpoqDpkhm3LDpftZLCM/CFmh
         VP7siUOp6Bpg/VtuDlHM3+KP+5D33amBNsAvhWirFV5kDspBwsdpfUsW5tRjm2okzy7s
         62KCa0rLi/zPwUC1u+6aQKAIGASrXsWAq6ZknzQYR4VHiOt/kIQm4UVv5CJgkbQ5BC/e
         w8zX8bc3dAzJhPeAk17YDc8QgR8SBy4sNfhH1szAaYxPx8pARtPkjiPz6PMLY0TI84Wd
         /aZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kWLfR2iq4Uky6Kq1I5l8o1nz5cqJ4IFTg8zi44mevOI=;
        fh=W3qcPzUw1Y9MVhsdttD3h/fL14/66GiSqjQeB2NcrM8=;
        b=IgLYlczNIOrriSa+p88k4P/N0M4xwiYfnoHg19WlyEMp5FgGhNUX+xn0ZZzJVCaVmV
         hwIsjR/aBQcUFqUdmYZhjPrCjVSh70ibuElOoH3sup2ImH+5Ov96+eSLEMTjgSZ8K1Ea
         xJ6vhy9j2vL3+y59J5ENjuzVZpP55++SP30VKAC2atx0RX1qstY2Y4nQTWtrpwrIcPKX
         HCg6Zn1tXnoDJa76j1i22ar25rly5CcCjJg8h1L/50Yss2mlPLd5IboTdDlIDduOkeqt
         qGSKfodlb1R8UzCa6Dsvuqfuax4Krv32JV/5RIKQM9ig6kj7NtIfOBM0hpDRhtvm1ibm
         BipA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770365117; x=1770969917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWLfR2iq4Uky6Kq1I5l8o1nz5cqJ4IFTg8zi44mevOI=;
        b=AETtPwY53dn1xi8/p4g2Tt6gMHNrGyLDbq9Bf80bHo8/smhw2ii0zFETbdIrLtV0E7
         aNhqwdE7VRhuHIXjDgbERiF1Xu3435Vbb4y2F5fBGI4v1fCDqC/aC0aEWC43CZmI+drp
         VbdJJUFYLDvtJwyZbYAA7aKc3MIuknTLPsAHEVLxlR9jlHBIHwbpNfiJMnCx9ZahM/Fs
         CAdvjGQApJDiLkR7cJzVdSNz+emSQwR6GJDsKZHkRMBwwMIzGZM85Usid53Xlm4TLeSH
         QIu/J1h6fVXB2gXL7C1lw68id5ifVUEVz7hzXxCYWuv/OG8lsPaJYYiRIv/Izfp/uzB+
         +/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770365117; x=1770969917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kWLfR2iq4Uky6Kq1I5l8o1nz5cqJ4IFTg8zi44mevOI=;
        b=FbLp/E01X16FeTefLlMaQXZRbPoEuvZhRAMyejoCVMUmeqgrK8PkWXSRe9CiiSgvvU
         to8dDVlscchovjmjoAxL1JFRvEn2yUy1sDGXKJNvSJwf5maBE5HR0nNBonDaSggdpxwv
         nn22hMRqbn0CCitC8sZ2ZQK1wHDqxNBUR1mpFElzgCp6WuSWfg7gFxKZP9rcnu0vB9mv
         UHoQhILhO4I6PDxLeQC+jqC5j3K/ZKJG0jKV1VYYfTTbus+Q61eu5OKqRrtZbEEAYsoM
         bVHnAf76thPMHV8qUC2Sxhmfj7tluBdVDpbXrJHRp2fYuc19Abz1/eDE1BzjJ8/MDbx9
         XHwA==
X-Forwarded-Encrypted: i=1; AJvYcCXHOSHfAoA6iaHD79h4CxGMMUOBuuV4CsJ8OODuwU8lvr29TjroxWPl6d9+P34rC5xWbUKN1yWT1xL8Tt8KL7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFehEZkw+Y9ePLUV+lpvKOOjZQUywoOxBmaBc2FtPIGW5TDJyZ
	vC8l5qfIo0NEY83ZEm7aCtOpp/6UMNitGQZLd7IaF5iILSWM24XtRX03t4Agy7u905MJXQIslPU
	XmhF89XA/GWKxjsFszPpwlAZ6OCESVB1jEv6zwoYBbaeQX/6tOfG8RC12WtRK+mvlD1U+2b4L+8
	exRzmXGL8mOIfVuNGPxwjznWOW8eJKNO90qHjAgEHMhoz25w==
X-Gm-Gg: AZuq6aLmdB9+n1DfqlE0tJm/qcdYv9XEYOMn5XYPMzd4dZ/29+1v+wnVb0jvMXRps+O
	KL+OtOYaloZhCzmK/2Jc8o5RJUDVVWRvUy7bp2hxRkUcUbYHqjtM0AIwvwlvoS7rZCqb5S6OQO7
	yBueltKZ3n0+bqeP0qEo4IXfc6AfQ8QkZge/CGbHS8VBGvQwcfm9ZUEkXO5vZeRk4=
X-Received: by 2002:a05:7301:2b87:b0:2b8:261a:fbdf with SMTP id 5a478bee46e88-2b856b5775cmr903558eec.39.1770365116829;
        Fri, 06 Feb 2026 00:05:16 -0800 (PST)
X-Received: by 2002:a05:7301:2b87:b0:2b8:261a:fbdf with SMTP id
 5a478bee46e88-2b856b5775cmr903544eec.39.1770365116202; Fri, 06 Feb 2026
 00:05:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904174325.it.487-kees@kernel.org>
In-Reply-To: <20250904174325.it.487-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Fri, 6 Feb 2026 00:05:04 -0800
X-Gm-Features: AZwV_Qjb2Rc_0b_gzX0QExAsryiv4D5h6ZmTxT2uraUZgpzUPLSlmf2S9rKs038
Message-ID: <CALvbMcAMWW1ewkszu9nYEaY0iA=CsUh+JFm1pzpnkXvzp9dP5Q@mail.gmail.com>
Subject: Re: [PATCH v4] Fix sanitizer attribute infrastructure to use standard
 TREE_LIST format [PR113264]
To: Kees Cook <kees@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>,
        Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>,
        Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GaoaXAXL c=1 sm=1 tr=0 ts=6985a0bd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8
 a=gAw2J8AAsyoxXY8NRG4A:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: inmurJJiIhBRDhO4vPRmHyDgkqPBZ8II
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA1MCBTYWx0ZWRfX5lXCEaa1tmNX
 d630dC28R6W/Ox4W/Xe/Bv0LQAK+qXNZ7zsn0QQPRC6UioHCCeapSqfYuJ4o3liRdE2ykVlxaFr
 FtT/Huk3iO4pUtCCkixPAiELQm74VhOJfaDWPRwxBY3Bc9Oks8SqC5H3NoeT89lNQtRGwxlG+Su
 a4vMHVvN3d7R2fuQuVl5knpsmtR7m88/tWd7MaERLpbSu24jU3G/4PokRw+fJ+Ftt9Zy6swvdty
 cJhtQFbuPOgFBLLKPZ2Qrm7v4aUkEgn9fhM/H8+sBYUWBGV+cIDFnYyI7Z7ZwuwDM0qwqD1/I40
 fghzkuGCmbNEosM5sY+dir//FgZ7r5xprcUg6PHBl142TGUbBLe4r9Me1pgHwS+2iUxPIxi8yKI
 PDRblFKZgvmgAROVfTksvGpZqykHNA8N0ONGEZz/pwMdAf/CkjoOktAImVgEweuvQEKBCtJspD3
 QCl58dF7KWPSYgsvO7A==
X-Proofpoint-GUID: inmurJJiIhBRDhO4vPRmHyDgkqPBZ8II
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_02,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060050

On Thu, Sep 4, 2025 at 10:43=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> The __attribute__((__copy__)) functionality was crashing when copying
> sanitizer-related attributes because these attributes violated the standa=
rd
> GCC attribute infrastructure by storing INTEGER_CST values directly inste=
ad
> of wrapping them in TREE_LIST like all other attributes.

I am going to review this over the weekend. I see it was not reviewed yet.

>
> Wrap sanitizer attributes INTEGER_CST values in TREE_LIST structures
> to follow the same pattern as other attributes. This eliminates the
> copy_list() crashes when copying sanitizer attributes:
>
> test.c:4:1: internal compiler error: tree check: expected tree that conta=
ins =E2=80=98common=E2=80=99 structure, have =E2=80=98integer_cst=E2=80=99 =
in copy_list, at tree.cc:1427
>     4 | __attribute__((__copy__(__tanh)));
>       | ^~~~~~~~~~~~~
> 0x859d06 tree_contains_struct_check_failed(tree_node const*, tree_node_st=
ructure_enum, char const*, int, char const*)
>         ../../gcc/gcc/tree.cc:9126
> 0x860f78 contains_struct_check(tree_node*, tree_node_structure_enum, char=
 const*, int, char const*)
>         ../../gcc/gcc/tree.h:3748
> 0x860f78 copy_list(tree_node*)
>         ../../gcc/gcc/tree.cc:1427
> 0xa755a5 handle_copy_attribute
>         ../../gcc/gcc/c-family/c-attribs.cc:3077
>
> gcc/c-family/ChangeLog:
>
>         PR c/113264
>         * c-attribs.cc (add_no_sanitize_value): Store INTEGER_CST values
>         wrapped in TREE_LIST following standard attribute conventions.
>         (handle_no_sanitize_attribute): Handle both original string
>         arguments and copied INTEGER_CST values from TREE_LIST format.
>
> gcc/ChangeLog:
>
>         PR c/113264
>         * asan.h (sanitize_flags_p): Extract sanitizer flags from
>         TREE_LIST wrapper instead of directly from INTEGER_CST.
>
> gcc/d/ChangeLog:
>
>         PR c/113264
>         * d-attribs.cc (d_handle_no_sanitize_attribute): Store INTEGER_CS=
T
>         values wrapped in TREE_LIST following standard conventions.
>
> gcc/testsuite/ChangeLog:
>
>         PR c/113264
>         * gcc.dg/pr113264.c: New test.
>         * gcc.dg/pr113264-asan-no-instrumentation.c: New test validating
>         that copied sanitizer attributes prevent ASAN instrumentation.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Indu Bhagat <indu.bhagat@oracle.com>
> Cc: Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>
> Cc: Qing Zhao <qing.zhao@oracle.com>
> Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> ---
>  gcc/asan.h                                    |   8 +-
>  .../gcc.dg/pr113264-asan-no-instrumentation.c |  60 ++++++++++
>  gcc/testsuite/gcc.dg/pr113264.c               | 107 ++++++++++++++++++
>  gcc/c-family/c-attribs.cc                     |  49 +++++---
>  gcc/d/d-attribs.cc                            |  17 ++-
>  5 files changed, 221 insertions(+), 20 deletions(-)
>  create mode 100644 gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation=
.c
>  create mode 100644 gcc/testsuite/gcc.dg/pr113264.c
>
> diff --git a/gcc/asan.h b/gcc/asan.h
> index a24562f67a29..f5dc3d7ceb8d 100644
> --- a/gcc/asan.h
> +++ b/gcc/asan.h
> @@ -253,7 +253,13 @@ sanitize_flags_p (sanitize_code_type flag,
>      {
>        tree value =3D lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (f=
n));
>        if (value)
> -       result_flags &=3D ~tree_to_uhwi (TREE_VALUE (value));
> +       {
> +         /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> +         tree attr_args =3D TREE_VALUE (value);
> +         gcc_assert (attr_args && TREE_CODE (attr_args) =3D=3D TREE_LIST=
);
> +         sanitize_code_type no_sanitize_flags =3D tree_to_sanitize_code_=
type (TREE_VALUE (attr_args));
> +         result_flags &=3D ~no_sanitize_flags;
> +       }
>      }
>
>    return result_flags;
> diff --git a/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c b/gc=
c/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
> new file mode 100644
> index 000000000000..812c67c33086
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
> @@ -0,0 +1,60 @@
> +/* PR c/113264 - __attribute__((copy)) crashes with sanitizer attributes
> +   Test that copied no_sanitize_address attributes prevent ALL ASAN inst=
rumentation.
> +   This file should have NO ASAN calls since all functions have the attr=
ibute.
> +   { dg-do compile }
> +   { dg-options "-fsanitize=3Daddress" }
> +   { dg-skip-if "no address sanitizer" { no_fsanitize_address } } */
> +
> +/* Original function with no_sanitize_address */
> +__attribute__((no_sanitize_address))
> +int original (int *p, int *q)
> +{
> +  *p =3D 42;
> +  return *q;
> +}
> +
> +/* Copy the attribute - should also have no_sanitize_address */
> +__typeof(original) copy1 __attribute__((__copy__(original)));
> +int copy1 (int *p, int *q)
> +{
> +  *p =3D 43;
> +  return *q;
> +}
> +
> +/* Another copy - should also have no_sanitize_address */
> +__typeof(original) copy2 __attribute__((__copy__(original)));
> +int copy2 (int *p, int *q)
> +{
> +  *p =3D 44;
> +  return *q;
> +}
> +
> +/* Copy from a copy - should still have no_sanitize_address */
> +__typeof(copy1) copy_of_copy __attribute__((__copy__(copy1)));
> +int copy_of_copy (int *p, int *q)
> +{
> +  *p =3D 45;
> +  return *q;
> +}
> +
> +int separate_decl (void);
> +__attribute__((noinline)) int separate_decl (void);
> +
> +__attribute__((__copy__(separate_decl), no_sanitize_address))
> +int copy_and_annotated_alias (int *p, int *q)
> +{
> +  *p =3D 42;
> +  return *q;
> +}
> +
> +__attribute__((__copy__(separate_decl), no_sanitize("address")))
> +int copy_and_annotated_string (int *p, int *q)
> +{
> +  *p =3D 42;
> +  return *q;
> +}
> +
> +/* Since ALL functions have no_sanitize_address (either directly or copi=
ed),
> +   there should be NO ASAN instrumentation calls in the entire file. */
> +/* { dg-final { scan-assembler-not "__asan_report_store" } } */
> +/* { dg-final { scan-assembler-not "__asan_report_load" } } */
> diff --git a/gcc/testsuite/gcc.dg/pr113264.c b/gcc/testsuite/gcc.dg/pr113=
264.c
> new file mode 100644
> index 000000000000..2a49965e26fd
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/pr113264.c
> @@ -0,0 +1,107 @@
> +/* PR c/113264 - __attribute__((copy)) crashes with sanitizer attributes
> +   Test that the copy attribute correctly handles sanitizer attributes
> +   which store their arguments as INTEGER_CST values rather than TREE_LI=
ST.
> +   { dg-do compile }
> +   { dg-options "-O2" } */
> +
> +/* Test copying no_sanitize_address attribute.  */
> +__attribute__((no_sanitize_address)) void f1 (void);
> +__typeof(f1) f1_copy __attribute__((__copy__(f1)));
> +
> +/* Test copying no_sanitize_thread attribute.  */
> +__attribute__((no_sanitize_thread)) void f2 (void);
> +__typeof(f2) f2_copy __attribute__((__copy__(f2)));
> +
> +/* Test copying no_sanitize_undefined attribute.  */
> +__attribute__((no_sanitize_undefined)) void f3 (void);
> +__typeof(f3) f3_copy __attribute__((__copy__(f3)));
> +
> +/* Test copying no_sanitize_coverage attribute.  */
> +__attribute__((no_sanitize_coverage)) void f4 (void);
> +__typeof(f4) f4_copy __attribute__((__copy__(f4)));
> +
> +/* Test copying no_sanitize attribute with string arguments.  */
> +__attribute__((no_sanitize("address"))) void f5 (void);
> +__typeof(f5) f5_copy __attribute__((__copy__(f5)));
> +
> +__attribute__((no_sanitize("thread"))) void f6 (void);
> +__typeof(f6) f6_copy __attribute__((__copy__(f6)));
> +
> +__attribute__((no_sanitize("undefined"))) void f7 (void);
> +__typeof(f7) f7_copy __attribute__((__copy__(f7)));
> +
> +/* Test copying multiple sanitizer flags.  */
> +__attribute__((no_sanitize("address", "thread"))) void f8 (void);
> +__typeof(f8) f8_copy __attribute__((__copy__(f8)));
> +
> +/* Test the original bug report case.  This may trigger a warning
> +   about conflicting with a built-in function name.  */
> +__attribute__((no_sanitize_address)) void h (void);
> +__typeof(h) tanhf64 __attribute__((__copy__(h)));
> +/* { dg-warning "conflicting types for built-in function" "" { target *-=
*-* } .-1 } */
> +
> +/* Test copying from a function pointer variable - this should trigger a=
 warning.  */
> +__attribute__((no_sanitize_address)) void f9 (void);
> +void (*f9_ptr)(void) =3D f9; /* { dg-message "symbol 'f9_ptr' referenced=
" } */
> +__typeof(f9) f9_ptr_copy __attribute__((__copy__(*f9_ptr))); /* { dg-war=
ning "'copy' attribute ignored" } */
> +
> +/* Test with actual function definitions to ensure attributes are proper=
ly applied.  */
> +__attribute__((no_sanitize_address))
> +void actual_func (int *p)
> +{
> +  *p =3D 100;
> +}
> +
> +__typeof(actual_func) actual_func_copy __attribute__((__copy__(actual_fu=
nc)));
> +
> +void actual_func_copy (int *p)
> +{
> +  *p =3D 200;
> +}
> +
> +/* Test copying sanitizer attributes along with other attributes.  */
> +__attribute__((no_sanitize_address, noinline, cold))
> +void multi_attr (void);
> +
> +__typeof(multi_attr) multi_attr_copy __attribute__((__copy__(multi_attr)=
));
> +
> +/* Verify that the copy attribute works with function declarations that
> +   have sanitizer attributes applied via separate declarations.  */
> +void separate_decl (void);
> +__attribute__((no_sanitize_address)) void separate_decl (void);
> +__typeof(separate_decl) separate_decl_copy __attribute__((__copy__(separ=
ate_decl)));
> +
> +/* Test combining copy attribute with additional no_sanitize attributes.
> +   The copied function should have both the original no_sanitize_address
> +   and the new no_sanitize flags.  */
> +__attribute__((no_sanitize_address))
> +int combined_original (int *p, int *q)
> +{
> +  *p =3D 42;
> +  return *q;
> +}
> +
> +/* Copy the no_sanitize_address attribute and add no_sanitize for alignm=
ent.  */
> +__typeof(combined_original) combined_copy1 __attribute__((__copy__(combi=
ned_original), no_sanitize("alignment")));
> +
> +/* Test with multiple no_sanitize attributes on original.  */
> +__attribute__((no_sanitize("address", "undefined")))
> +int combined_original2 (int *p, int *q)
> +{
> +  *p =3D 44;
> +  return *q;
> +}
> +
> +/* Copy existing sanitizer attributes and add more.  */
> +__typeof(combined_original2) combined_copy2 __attribute__((__copy__(comb=
ined_original2), no_sanitize("alignment")));
> +
> +/* Test with no_sanitize_undefined on original.  */
> +__attribute__((no_sanitize_undefined))
> +int combined_original3 (int *p, int *q)
> +{
> +  *p =3D 46;
> +  return *q;
> +}
> +
> +/* Copy and add no_sanitize_address - combining different sanitizer attr=
ibutes.  */
> +__typeof(combined_original3) combined_copy3 __attribute__((__copy__(comb=
ined_original3), no_sanitize_address));
> diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
> index 1e3a94ed9493..e629601579ef 100644
> --- a/gcc/c-family/c-attribs.cc
> +++ b/gcc/c-family/c-attribs.cc
> @@ -1425,20 +1425,27 @@ add_no_sanitize_value (tree node, sanitize_code_t=
ype flags)
>    tree attr =3D lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (node))=
;
>    if (attr)
>      {
> -      sanitize_code_type old_value =3D
> -       tree_to_sanitize_code_type (TREE_VALUE (attr));
> +      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> +      tree attr_args =3D TREE_VALUE (attr);
> +      gcc_assert (attr_args && TREE_CODE (attr_args) =3D=3D TREE_LIST);
> +      sanitize_code_type old_value =3D tree_to_sanitize_code_type (TREE_=
VALUE (attr_args));
> +
>        flags |=3D old_value;
>
>        if (flags =3D=3D old_value)
>         return;
>
> -      TREE_VALUE (attr) =3D build_int_cst (uint64_type_node, flags);
> +      tree new_value =3D build_tree_list (NULL_TREE,
> +                                       build_int_cst (uint64_type_node, =
flags));
> +      TREE_VALUE (attr) =3D new_value;
>      }
>    else
> -    DECL_ATTRIBUTES (node)
> -      =3D tree_cons (get_identifier ("no_sanitize"),
> -                  build_int_cst (uint64_type_node, flags),
> -                  DECL_ATTRIBUTES (node));
> +    {
> +      tree attr_value =3D build_tree_list (NULL_TREE,
> +                                        build_int_cst (uint64_type_node,=
 flags));
> +      DECL_ATTRIBUTES (node) =3D tree_cons (get_identifier ("no_sanitize=
"), attr_value,
> +                                         DECL_ATTRIBUTES (node));
> +    }
>  }
>
>  /* Handle a "no_sanitize" attribute; arguments as in
> @@ -1456,17 +1463,29 @@ handle_no_sanitize_attribute (tree *node, tree na=
me, tree args, int,
>        return NULL_TREE;
>      }
>
> -  for (; args; args =3D TREE_CHAIN (args))
> +  /* Handle both original string arguments and copied attributes that
> +     have already been processed into INTEGER_CST wrapped in TREE_LIST. =
 */
> +  if (args && TREE_CODE (args) =3D=3D TREE_LIST
> +      && TREE_VALUE (args) && TREE_CODE (TREE_VALUE (args)) =3D=3D INTEG=
ER_CST)
>      {
> -      tree id =3D TREE_VALUE (args);
> -      if (TREE_CODE (id) !=3D STRING_CST)
> +      /* This is a copied attribute with the flags already processed.  *=
/
> +      flags =3D tree_to_sanitize_code_type (TREE_VALUE (args));
> +    }
> +  else
> +    {
> +      /* Process original string arguments.  */
> +      for (; args; args =3D TREE_CHAIN (args))
>         {
> -         error ("%qE argument not a string", name);
> -         return NULL_TREE;
> -       }
> +         tree id =3D TREE_VALUE (args);
> +         if (TREE_CODE (id) !=3D STRING_CST)
> +           {
> +             error ("%qE argument not a string", name);
> +             return NULL_TREE;
> +           }
>
> -      char *string =3D ASTRDUP (TREE_STRING_POINTER (id));
> -      flags |=3D parse_no_sanitize_attribute (string);
> +         char *string =3D ASTRDUP (TREE_STRING_POINTER (id));
> +         flags |=3D parse_no_sanitize_attribute (string);
> +       }
>      }
>
>    add_no_sanitize_value (*node, flags);
> diff --git a/gcc/d/d-attribs.cc b/gcc/d/d-attribs.cc
> index 53aea5e2e904..342702b05acb 100644
> --- a/gcc/d/d-attribs.cc
> +++ b/gcc/d/d-attribs.cc
> @@ -1424,17 +1424,26 @@ d_handle_no_sanitize_attribute (tree *node, tree =
name, tree args, int,
>       merge existing flags if no_sanitize was previously handled.  */
>    if (tree attr =3D lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (*n=
ode)))
>      {
> -      sanitize_code_type old_value =3D
> -       tree_to_sanitize_code_type (TREE_VALUE (attr));
> +      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> +      tree attr_args =3D TREE_VALUE (attr);
> +      gcc_assert (attr_args && TREE_CODE (attr_args) =3D=3D TREE_LIST);
> +      sanitize_code_type old_value =3D tree_to_sanitize_code_type (TREE_=
VALUE (attr_args));
> +
>        flags |=3D old_value;
>
>        if (flags !=3D old_value)
> -       TREE_VALUE (attr) =3D build_int_cst (d_ulong_type, flags);
> +       {
> +         tree new_value =3D build_tree_list (NULL_TREE,
> +                                            build_int_cst (d_ulong_type,=
 flags));
> +         TREE_VALUE (attr) =3D new_value;
> +       }
>      }
>    else
>      {
> +      tree attr_value =3D build_tree_list (NULL_TREE,
> +                                         build_int_cst (d_ulong_type, fl=
ags));
>        DECL_ATTRIBUTES (*node) =3D tree_cons (get_identifier ("no_sanitiz=
e"),
> -                                          build_int_cst (d_ulong_type, f=
lags),
> +                                          attr_value,
>                                            DECL_ATTRIBUTES (*node));
>      }
>
> --
> 2.34.1
>
