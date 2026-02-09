Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B52FB630
	for <linux-hardening@vger.kernel.org>; Mon,  9 Feb 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625697; cv=pass; b=rs9HDMMp5DPY2myH7Dfmp/Uc/5VjUM4IMVsWnuzfDQL5bisjXvBc0mW4XSFsR2rV5D7gb8mOxN55p4JUDHbEGOpLlXwq2mL4u7bj5fdgLAqOZSAfaC9Q5hjEYjmeZ1lJsve6UWRqURwjA3eIAxjuCpQFHgVtn+UpWdLZUDNVZOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625697; c=relaxed/simple;
	bh=dLhcF0wiyQH4Ljohwhbo04zAv5PrdZlQC4SCAaggrYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6IK5Eio1xUN3VpZDsscvxAn7AGUNHnAelDHy12wAxKJerYHf6cvvmiLgCh0cmsyC9lW2qgft6JFbK+gtvd9VJMJDsH4EyBkYTuEgwgPWRHnlRriDhzv24P890bOgiCIbwNtk2p88/PXkTxacIvjKiy0NSci/UU3LSAIyvGzztU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J9MfiRCI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eMpzq8cm; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9MfiRCI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eMpzq8cm"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6194wa1n1476771
	for <linux-hardening@vger.kernel.org>; Mon, 9 Feb 2026 08:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	siHl/4iJ814NreiFjSPDr1aGMhejTXOquL5Nq6+RJPM=; b=J9MfiRCIWUilvpaA
	rQm8J/WtyATevnlOBExG1sBhtLM8NXgGZzI2vJ81nddd0HY22gX87LDgfY5+WQWi
	Qhsf3Agp3Nn2dwoC7lS+Lue1LXK1rpOXGe3ilxCGQGz5rhmZTkQwew1ZgniJ7axI
	zrk5R6AE+js/BWwhN4HT/WHOdvW2Cpbo74gPOUsE+nuIiyKPOmC9Bbsfstlg68Jy
	YJJJKVDG8BUz1ISMbgKOI7ybCSYbR0M8jntFKGaVbipDSDFTZ2lKuOcNq2bPV1V5
	JsuDvgvKdESqeVpCWVlLGNksEY9hzB9S6CkiPfO5gObVGguMUk1fKujEqORSSyHt
	QWCRfg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c64hnkted-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 09 Feb 2026 08:28:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba73b692b8so140871eec.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Feb 2026 00:28:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770625695; cv=none;
        d=google.com; s=arc-20240605;
        b=eEr9yVmbAphOIo2KkpJCKo997CJ2cSXX9uECebY3YbFCSg8Eh031TNVxzL5wzJFskH
         9/f2sUpNgqw6b5MphzwxXKEvTDOEoJixiL8FowPdo5y+jTiKOL08v7PQXtdHVXlTBjJj
         OLSe4FEBuBbAtIrPEpe629M+iDGwzMYbe5ncdBAdftvpbJkNrq10zItazRjjSgd2KQSz
         aLnyAP4zw03mZE2qbQCfSrXHWRLWaxdBhVpx3Aa3ZnVWiIBFnbaKtm46w6kaXS5/KU9U
         szJxUCF9iY4lolfomvYjHniVXQObBJHW8AFvv9aE4WT9dBpwR38vKqZ08GNoXjnJSMQ4
         r8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=siHl/4iJ814NreiFjSPDr1aGMhejTXOquL5Nq6+RJPM=;
        fh=Urr9uVuM7+WhTa+5k4tqsvK9l+/WLNeh+zwDWHDKtD0=;
        b=ahljqhbb2kkX7e79jhCK4kgicqjsqtl+VuGwDcisP+fielfaCunT2NHlN1MI5a87Z2
         y/qSq9yR8V5Z8A5xyGQdnCuJQhIP9QBXCPMyrXGgtSisxQaPRWnI78idGxl1opSrUsZ8
         QEjfmK08kCBJjHH6BCWlO/1B6xxlApIr4nna3hNx2+DB10nyuEniYU6/C8UZx8rNZUl7
         sjtB3AKdd4ZCXKXbmJiT8uHZRrIxeU1y7Mk+LNniYzfHW6dX743OIhEZ0ANIe8IkWKv0
         axu0R0qVRdF8EKx478x7oQyz1IOTsXTRqt9XiLejMX8Kt2dnMBd4oVEuIw0A6KPM8BZW
         fxYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770625695; x=1771230495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siHl/4iJ814NreiFjSPDr1aGMhejTXOquL5Nq6+RJPM=;
        b=eMpzq8cmahO6kAfwAlMf1flixxJiSHnbwsh6DICiYu9gxSPsV/KsS8aTpPhT587tqy
         D7Z7EKh0kbCWt9oVEf4bdV9pG5TJcxhfGykH1uv9OqIDYPythg91HJJE28Jfc3tSOS80
         /7ff8ebBgoPvfXxpM3VHqbBPlJmiOjoQm2w1UcA3R2eTNrWnBmGUUMx/AtYkE8yNS/qZ
         px1SrkbaLmJUsyRsfowQ5d94H6JfOsGmTfhwDeTLJhx06y2rGYxci6uLqSOQ0YzvJWqa
         WJerq9dE3/lCWqAl7XI0brRi0j+9IzMXTn7oOCwrYJ0j6cwO41ts8J/Ao0mTtdrZRKrI
         eatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770625695; x=1771230495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=siHl/4iJ814NreiFjSPDr1aGMhejTXOquL5Nq6+RJPM=;
        b=aLpEAcT1PZ9AnZVqMUWZEOTFDG15kCpKUM4BCTUO3o17mU9YCnG8bhp214QkOCg4TD
         dtHfHg/eJOI5ExwJHEi6W14e/tnW0yB+0j02POh8snKId7MTthTIIJCb1+FzVmbTveKW
         T4IL2r+IaNEnmhTxXTsX3KCi25OcvAUMUPPvVRvTGtDS5klTTF917hhDyTWLFjZoD5l/
         0ZOHfrw5jM0QoTAKNJTToKjK+LWFQfEeRiB1wO3fLQIpAhoumJ7Y2qwoZ0J9Gc9GNO9m
         6E9xAUrCW/vPeMkeqVMVmEsbVFib64w4qcTa3A/3Kb68XngshwePX0gaJYK/4vgKVCZk
         9/DA==
X-Forwarded-Encrypted: i=1; AJvYcCUfjZBKGFz9SiX4S/oCq5+6knXvmQKchZNDFVz5Zl2na/ik9tH2UuecFB2OR0v1UUoscExggyR9NvUR1Vd1tr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQaya0cJYrmskpTlZbfhEPqSIVS0r413RP8H+LX7e1Ausu6EGC
	wUTFR1eqD8ManlwIG8afBMxseegfhtm7q2oOnUuuZwaNNvx+eB99NtOY467PVj1sCY9mHJN5oig
	/t+CPJ724jiFmqheZ9e0Yvzq+05WLOR1olG7wu8Dn+NcAmHKaiu3xFFLkzXy7w53wa2Lb65EhvU
	iRp12gpDT8wQPRXz5mvrquBuMh/XGla80WlMdDGYQ9OomGzg==
X-Gm-Gg: AZuq6aKx2LVxtSRvEIhChxP4lhwkMBX68FPUlGakz3oOsTJ/i/cyNpyVyrc6in2hAXr
	MSmTeQHsKh6qaAvv8ErMWs0T2qP2DwCNZDWylpx2OY6mWOl1Ju1g/aYG/Wwq7hrMVdoVxsMgwAQ
	RqUsmTdAKWejdOSXW11mV1NDUnWhmOfUxfoLZabA0t1onxRTAtHg0c+sSTtVLPkwmu4lwiV8s1Z
	as9
X-Received: by 2002:a05:693c:2298:b0:2b8:3b47:8951 with SMTP id 5a478bee46e88-2b845b58bfcmr5189908eec.1.1770625695396;
        Mon, 09 Feb 2026 00:28:15 -0800 (PST)
X-Received: by 2002:a05:693c:2298:b0:2b8:3b47:8951 with SMTP id
 5a478bee46e88-2b845b58bfcmr5189900eec.1.1770625694812; Mon, 09 Feb 2026
 00:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904174325.it.487-kees@kernel.org>
In-Reply-To: <20250904174325.it.487-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 00:28:03 -0800
X-Gm-Features: AZwV_QhTfFWedtbv9w1Mra2FQC1lWeeLNBhq10FTr11fHXWbt_QknY18WD4Scrs
Message-ID: <CALvbMcB=DGBizanckW_YJdRYBbG4=2TsLi30yp5CacR00UGPGQ@mail.gmail.com>
Subject: Re: [PATCH v4] Fix sanitizer attribute infrastructure to use standard
 TREE_LIST format [PR113264]
To: Kees Cook <kees@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>,
        Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>,
        Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: rNIsZ5B3_DHcHbSIsQY-JX6zoJGzNzAo
X-Proofpoint-ORIG-GUID: rNIsZ5B3_DHcHbSIsQY-JX6zoJGzNzAo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA2OSBTYWx0ZWRfX6WsqMmTzhThH
 QAGmVmu+E2Zp3RrjRBiweooSWQdLuWrbhEhJTDY4Z/ht8XhvEnvFoT8Z8Ov7YS9e2a3oZHZgk5x
 aFZTldTXvhrZcVUoyXz0fLC/rRlZCcapHtDB9nK+Qmf1Bl6AAoodG/YAh3W2ewagUaMA4AZIUWI
 sSqW9d3+VoLTG2YiN1Bmk8ipG3BVQV/3PO8bFXRCQrMZwsL3LZ4a+iv5b9pHwgE14GksgtkNjuU
 fMttM+nPh6EdO/LmOwNL8/1X017LJVuPcbFUW/B3RMJFUrcToxLMqpjIYGZzFXSp3BtByYL5UIF
 nEYWCQg5S6071Nmh6NU0PQc1xWr2PkdqZsmPVdXhdCEgn4cm62t0GvLZcbC1cTCpTLYu5tjOQ5F
 HeeK3OreCaM0gt5teDW+ogCPUElr91aj3O0jLvQwWs40iGKMy0MJHfJNuwO6toi2oMpZQcEXkPg
 iDaAuSZNzKmFokSp2UQ==
X-Authority-Analysis: v=2.4 cv=SNlPlevH c=1 sm=1 tr=0 ts=69899aa0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8
 a=zRetiblGEnhvEZwHOGkA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090069

On Thu, Sep 4, 2025 at 10:43=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> The __attribute__((__copy__)) functionality was crashing when copying
> sanitizer-related attributes because these attributes violated the standa=
rd
> GCC attribute infrastructure by storing INTEGER_CST values directly inste=
ad
> of wrapping them in TREE_LIST like all other attributes.
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


I am not a fan of the wrapping because it increases the memory usage
slightly but it is required since the rest of the attributes code
requires TREE_LIST here.

So Ok.  I will do final testing either Monday or Tuesday and push it after =
that.

Thanks,
Andrew

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
