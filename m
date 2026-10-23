Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792768606;
	b=zF5g6qGJCN+F0VsAg611Cccpd0GBN61HS/P4Ax/K2i1MwSsoNp+CZ9nTVJWjlXk5lb/m
	 d6ev1U9D+ZiXn1uT6QDFsbG85VophpK7TqGF5v8gRY16hcbN9UhFR8ovPGexxSs5POUP3
	 +ZYpgkdR9Gt5tgvUO8t5SJ07blvG5vKqzHDjO/Kchdex/9RqIxshCxyFMpF9VZzFh3xDD
	 2A7NlvZYdYZAEd6R5nIsTuloK7TGx9CJt0fMkPe4WcUBgBrzaV0JNEf7CtobNS9EQPEbw
	 3S5JYSPWoKf+I4ja/a+6TnF2BvgsbK728XaAMCoY1gsCWGuFBbLzbn7cxrTvtM8k6Tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768606;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ntGLFzlDvuBFajhsf5fvpyP7EbCcLO7E8qSpRPn8wxs=;
	b=fTBq3YnsXqPkL99tuwYHIdZPA4kulVBh8G1QN/FH7KAPJg8EO2dv757OErh3SnvTycop
	 daK8kmSUtdl+3V5mmpF+cypOYOLs+/P7WCDtRrCMZUCEU23C2iNRqCq0w4UH1XZ3P1jbi
	 ggfFn8hZij01sUiHPXDCjzBbMxjojmy7zVxoz3quGlPa4+XeqnY983F2PhzLIF3An1oIh
	 Qw70oNUwGr9WoFU19Zi+ejVUheKNmKYa+vs3Tqm13D/XnQFPB5zg36YpzaXibry1KWExA
	 GY2ID+aiNW+GEupn5m2BXSIlT0Ftpyl+YOdkDq4/U8JzLhoKulSsi/knkNFFg79VA8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RuZfbKXK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="L/3gk0HD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB6606A31B
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BB6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RuZfbKXK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L/3gk0HD
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6IAQ3557697
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ntGLFzlDvuBFajhsf5fvpyP7EbCcLO7E8qSpRPn8wxs=; b=RuZfbKXKE7ctzwuv
	czGvcZJqzCy2XCLn0xdke+X9ts8FAcun4WTZQCudkdJKnb3xdFnvARNiR8w9By3I
	NwA5f19bmPM0F4/1N8NdyKMtmcsewJn8V8CTbPlcN5jFBP0GZaF5wiyzsdocXvUS
	xcjmTXDeIeiuipdkZxzWk07LUQizJOAFh6S/jElNl3n7/mp18BKLuVQ1wp+bgk9l
	+FcF1qB2p+MZRT0ltDw0JQzJxLrzFY3qx4BmkwskNY9DfkKwOgNAhobCbeqgzD3C
	K4wGWwxI6rnBtUmB7j1FsuYzVYhAGBUyEOeSjKp4k/YEspItviojK8felV6wchif
	2pd1KQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjc9xx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:16:44 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-55bf11583d9so763677b6e.1
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 08:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792768604; cv=none;
        d=google.com; s=arc-20260327;
        b=EXQXwbx+fsV/nngxe0yKGD3NvMu0FNwRvrk4qxBUM3WyYLHuYOmODEEJ/0/joYn1u7
         2iNN7O/rX4isbqWNZLX711U/lL48tS88Sbm++RgVPcGDrNW7VIwIlyVxF0d5a1SIkpnk
         SuBz2WCdJ9DaVaoQJWRPOS07SbOc76+hemlZl7kIspkN5+lr2EIrWweyXH1ufsDjZ8AI
         pGBhzeJCEZNZCUWHIMikL4rG79qcFJJwomu6yYzhMxzbMXp+tPlsyvNAVEduiRhMayXR
         BX7SCj8Rueavdw3TLRuDkNbcAgNF8wLfZbKj/dvxQVL1/y2LADFkldTvaHf/c5vNLRla
         0vRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntGLFzlDvuBFajhsf5fvpyP7EbCcLO7E8qSpRPn8wxs=;
        fh=IcpSbgZPQTKAbdplgeBD2SeskwCQ272eusENxH0GNzk=;
        b=WD59bdUvtCj1GOeo4et5EiYzG+uYXryGL218UQV5KSvzw8/glyxJx1NTU3GDtWmKH5
         0vMfhxL/CbQ/J9j8wBwuhrvLWIhX8mRb2goZTotWe4FR54Ntl/u6f4Oacrp00TR2dh2g
         SGBj099+3wk9w/laO1f/U4cJDUCfX8vvEl3kKuPkPT4xijGqyGZxTyw93Ph8dGfRiaSi
         NsFgKhTnFFekCXyWu8YvfhGJIdcN79eLbZyBYI+yqoM/N+HmUtVkJLj8ls+iNUz8XNbU
         25cJPkusfxDbWLbwUUj5qSfQ4Q4JcS51/5CIKQ4ckeUdr9uQO7E4XuIiTYy0jbF2JClp
         cT/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792768604; x=1793373404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ntGLFzlDvuBFajhsf5fvpyP7EbCcLO7E8qSpRPn8wxs=;
        b=L/3gk0HD6tLj0ZMPDOtdsa+nHmVehU9lqltl0YMtrsiCyjkNKDAUGtTK7TidLO0J13
         4Glq+DZlulePmP8lbSje8FLFth+Kflvb102fMF+2QL3K2UPB+heJ5IyelRUFwQ2oUnrW
         zczr4NRYMDe97XpWM3OG1uJLgQmKpeub3DBya9SLloYZ5t7oOYQomwu1QIsOHjiJh+xP
         L9sybaznrBAP7jvBIa0J80WfrHJ44b0U2l3t2lkDLCXFClMMbgKX3dNDXCytRG2+SVqG
         JwFEjOMn8DLU96XThSZW6bfSylys1yjMUXUNePQ8vSeFzbRPbF2gNDeiiMAEf3fn1EyU
         IQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768604; x=1793373404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntGLFzlDvuBFajhsf5fvpyP7EbCcLO7E8qSpRPn8wxs=;
        b=sXJWcS/l/UX2ywGf1rieAcW8DfO/Q0QG1USnsFxiBzdpf4Nbf0f8hHLI4LXi7+LK4M
         MioMtaLXARalwkANpEObYKptAR+IGXoyL68Ok1RNUXehP1/A4YW1Rk4foLkZurTfaRDL
         afUXjPLWCsSEsoqup+6YZxcRSnodrFRyhXDtNV0iyncN8j2jN2qDu+nmyf3j2/l6r1Tm
         OWFLirW/q/3OXByPffzvV8ZccYTrhmK0aDzj3vUdAXFTiJkH8fiUPPCYQovfMLw7VFNa
         Z4YaSPUbWnm/81VnVCAw45oPf/ZpiKJwdRR/Q9Fup2AITc/0k5NudyBVYe3I5SfhJHyh
         ZZPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwt2Q7iPPF8SNNQPbgZ/JCgd3BF+wwbMZKnymdyNi3dwtGpmh6YcNlld32xTXyzpDgCIoJg9sJobhgv2Y9Roe8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJi71d5LMioXq69UsSsn1TUhg74A//wcMAvziZJNFuLMuDYPBO8
	A9pxOmz+ST01Fa4oqmYoQWU7+ZA7C1stGEW53aXfBGgLKpzWMr2uFmJUzSDiyvCszUoYB9+a6jW
	RR9suLDcRL12MxUy6xab7CTIhQVm5YRNMQ8W/euA9WmJrIS8vjwo1CWgAE22lgnfCv9ByFH1R5L
	239Nju4o76iUSkh96/s04u13NdrVAgjBfdRXwLqEYS5p9Ayg==
X-Gm-Gg: AYBFou0/bk2NWiCso05Tbn6yyK1/Wg+kSPGlk72rvBUxrQD1MiPTjNiApwPbfZfs7J1
	lUnSJ/ygnbim/OEjPPZw9sIJ6MjAhapvoreDPJBvP/wLJHEbpWT6O8i1lLWJu7SD4cW6CgY3mIz
	N+wXd7OM136Gl4uacnXm86tqf8HM4BHjPI6R4gofPgxIBT12Q9Ab7PtI0DkJLhsZQFlCuPFnBzw
	jPC9XIkgNkS20zHVmTBWfAoQWvM97XLfhAjOMGsnvmrEb/55IVRoL+gQsWqPbAZdVgSc/SHoGQ=
X-Received: by 2002:a05:6808:6f86:b0:4b8:4703:db91 with SMTP id 5614622812f47-557eb47d075mr3061858b6e.26.1792768603825;
        Fri, 23 Oct 2026 08:16:43 -0700 (PDT)
X-Received: by 2002:a05:6808:6f86:b0:4b8:4703:db91 with SMTP id
 5614622812f47-557eb47d075mr3061832b6e.26.1792768603405; Fri, 23 Oct 2026
 08:16:43 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com> <20261023-camss-isp-ope-v11-3-0c2937195298@oss.qualcomm.com>
In-Reply-To: <20261023-camss-isp-ope-v11-3-0c2937195298@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:16:29 +0200
X-Gm-Features: AclHuK_gI7FsS6nJkI8EHAiWfGIfmG-kFFxZK8IqQe2rUZA0KJsBBIIrHA95LyY
Message-ID: <CAFEp6-04RVyYG1M18Dh6Z3J7MycTb-WdMkHxyyVPfyiHVK0z3Q@mail.gmail.com>
Subject: Re: [PATCH v11 3/9] dt-bindings: media: qcom,qcm2290-camss-ope:
 Document shikra compatible
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Xctm4iPSVfa3zkV38-GFErDs0koB4B-9
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb7a5c cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=43rrA-HyjK99Vs58VTYA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX2I1Hjxij3+Kw
 JRfOj1Dj6Tv6+r52SabwSUYRNpyTzOEFZ98mePAnPueqnGJnbEj7te3MgULjOuFdlc8wx+VP6Bl
 G0v8KTYh/OyIWwo8qo5FYXvmRuvhvqk=
X-Proofpoint-ORIG-GUID: Xctm4iPSVfa3zkV38-GFErDs0koB4B-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX7IFtZrmVYztr
 oGLJoTM6Po+lIl0QGs6opmtgcLQMfaUmN16WuRwfc7zrulq09STjJwJ3k9/cG2WUTWeUAG3TZLj
 Q7fyBhnRoNXFa3MAMS3VkJr25ADY0Vwc5C9ApBI3oXfGgvwvapJznJV77OKRnVIMdxBsJ/I5bZ7
 OLk0BI+B37Yz1zd+1gWBo5gbYB87IwtzM6xVeL4hpYWboAW7G9rYGmfcdbLVkEvD+SNc7YSDlXy
 XBrj8W41vCk363ZE+9Hnr3P49TzkzTPdY/ii+MmLuFlDpAHPtPKLGoQ47IIZQH6f1NStEGbxmHI
 UFIzCYamdHc8BmAUKX1J6oB5T4Im5IeudHq3vEc2GogBE7qpXr5rsWa4Ik4lz3nmdS+BqNcFxbO
 Y5rzMfVgFMiLWWE0fi3Rh3fDdnMVU2S6PH+KSfOjewXR8Txb7cQX0awA6XujaYD7DBB3+JAK3pC
 uoiWvu0aiQ+GR5Wkdow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230059

On Fri, Oct 23, 2026 at 5:09=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
>
> Shikra uses the same Offline Processing Engine hardware as QCM2290,
> add qcom,shikra-camss-ope compatible string with qcom,qcm2290-camss-ope
> as the fallback.
>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Note that I missed the trailer update step and therefore did not carry
over Krzysztof's previous tag.
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

> ---
>  Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml | 6 =
+++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-o=
pe.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.ya=
ml
> index f9c31bc88e94b028c241060bbd8e56e0bdc49af5..3359581bfb13e918bb4efb3bc=
41749e60d772ef4 100644
> --- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
> @@ -19,7 +19,11 @@ description:
>
>  properties:
>    compatible:
> -    const: qcom,qcm2290-camss-ope
> +    oneOf:
> +      - items:
> +          - const: qcom,shikra-camss-ope
> +          - const: qcom,qcm2290-camss-ope
> +      - const: qcom,qcm2290-camss-ope
>
>    reg:
>      maxItems: 6
>
> --
> 2.34.1
>
