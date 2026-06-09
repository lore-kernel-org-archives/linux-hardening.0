Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D63F8EC5
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002084; cv=none; b=Nbz3jmLHo+Py3ZYuUZzB3kv+dznh7Zw9LA/s2z5fxh0Iote1WIADtKytrrLvTLQ+MKGC49+g/teq1SS7tMWIPriGOyyeaF7zdxop2X+nnKigA31UkfvJ3NTqkXoGLumyo0kUCRSI703oOakIqt8J5cX8gwVpf5Bgb7ad18Bnr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002084; c=relaxed/simple;
	bh=/fmIzCVQFlRc9hqGthcJ8jz++uNYfhPm1KVVgsySGU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOjxHzOInIu/wDKbTN++l9R0SgJJT9LbyXfWy0EZCFRfuUxyVWmXdRylHtaZvhNJBtFCtZfNABtlZpGkpWFkZsGtn5J8i8OK/NZMAzNE8So06BBl+/NtFV5Mzs9jB5fli78qVCHbq0c9el39Xona9DzuF01osIB/LWoiGO8Hoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eKbtvGn6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F2jdDNEF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKbtvGn6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F2jdDNEF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vQMV1867945
	for <linux-hardening@vger.kernel.org>; Tue, 9 Jun 2026 10:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UuGTO67RmC+ivHQmIuRBVduc
	tswyL1nN6TdGwGzdo4M=; b=eKbtvGn6qNyrvxqiCmTZMXlJ+rFa7CuUFK0NL4os
	78YNrHKvvop++uK7mOW3XHHZpMa/QMvAgHccTGcbXACwFieFvq9bVgxEYcoVe9tb
	V9TCroc3Z30CN+o255C5/iGmPvFK96F7GbMydqxRTqwISA2+XMCPHM2GZ+8auQjc
	KqM8ngDELKAm453BtdgGmpQFfb38EMJkuXf+QfkQ2Ae9FefmkwghFwIJzmUesyM2
	yiTWI7GVfFE2QUHwCLvlcw/PcWT1/b618aeSlmTwPH/PlvsZ2n1CYILKLKyQJy0a
	69hHna6jnxsMDJ+iFbs8hOpxSq++Pdqid1EfOxjyqFoNQg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdees3cd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 10:48:02 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-59bf1a43cd9so12148499e0c.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781002081; x=1781606881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UuGTO67RmC+ivHQmIuRBVductswyL1nN6TdGwGzdo4M=;
        b=F2jdDNEFOwz+c0lelpAlFXXoaL/yMReJ+gnKYw0IgO9sIH0MJY3kY4yQi1/qsLvfQK
         bkJljo4xKAJP4eBjU/5FQyxyvPtQ9DS/lWZsZdCvUcWVff3Wo3hTt4/uw+rTmsTEgsLE
         8+uI768vXUDj0IID64IeMq/vCp6BSWVisAiG51N347oN0iEzIXgtg+B7BqgDKi1WD3D9
         P1CgOxHyXQVrMAYaSJyDnfpHVP4xzHjMQU/On065vHj4kmgL2mEcsBnGH3lCm9sApSs4
         UJWs5ezkCo1Mj/i/uuexA/8tC25PEqF6T9U76iYP9oaGq0aCt3NmkoH+n4OIVLH0gcku
         397Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002081; x=1781606881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuGTO67RmC+ivHQmIuRBVductswyL1nN6TdGwGzdo4M=;
        b=nwuUlJr8SpIUu9Ji72e/aPWxFCjVT4nZuKXrToGLPZMy4BMw3f51vp3VNl5XpRVeKf
         VYj6+8BkkcEpegjsXzLfXnN9cSk2xmWd0cK+SbFdtYilFIR7zbcnMwWxvnzThzOyrCJp
         PdiP+wtba9Gewmo9Tv4qRWIaXM+BJVE5JaRkTL9o+hMeQ0CIfdzdG0Gd5aQTx/ggJPQA
         BR0OyL06qarMRLbxIYblrXjcvOP57gEuU8buJWcPIosb5UvtHfnWvw1R7IERCQRiVqAC
         JjGyASu4QnxePWDE2Y/HzTrSJ+/yHYsCipiCO995K+dTsFij6PdeUPvUVDH8yafaupU2
         KB7A==
X-Forwarded-Encrypted: i=1; AFNElJ9HvnZzJzwxk6i+w7a+SKqcVQLRggds3b9VEPcXtKoDGu6+HCXkzeqK4yZ6gJeSkAlH/TvCG6J5peboanseLZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylWvkZOAaVRmoiiGdyHathM0S69BJgTU3Y/E2zzNgRQS7aanJ/
	gijZPbTwiNYDRVX4XnS9WKQO2w2HHPAPFMPGV5D46wi7bBWIbjqk3g6dPodHK1zKogjRBZ2iYjR
	GtXDHrNVSoaTQOcVTyPi7RT1L9bRQz2AWjyRJuwEBUMSy99OCTb58yTdynLrGVs+SZMNYdW8=
X-Gm-Gg: Acq92OGNP/E8ZBgv7E+nsFqYH2FpJGnOnhtXB7wcKSCd+4vbMzl+gXgjv4xNncvn0Nw
	0nNoVp1xXAF3f6Ngx5P+e/SI35GnunGzyh9cN3aeHGytOVeZUZjfvkKxoN3ys0G6jo22j6IixqT
	N74qN8oXB7gyYHKv0H7zdonM4vT3R8P1Qq4oE5VstbsPQBYXQcqM4zDdBTa6L/CMNd3xUQvrZj3
	VZFK0XZL72c8q8zFSCxpaxd+pD/TkB03dGx0cMVVLf2o7gZIEzTctmL3Tsb2TJD81y9XZ0ZsWhu
	qMQN0VQvXQI9l+P7kAVKcPj7KUzfLi9RNsOjW+FiEuRWe5Zr4H+g6LzIVgPPI1KYdYdckpMqDRW
	W4iOqMjHWT5AgxwnBCJDKgPxmRLEfjAhD442KLtRXMQiD+bnjjU1/pzFTleTq6TjPf2qPMhvd0p
	HJzRIqll6bMwNiCd1LaqL/UMPuK9jFCyQPnPmsIvz0G+aAcA==
X-Received: by 2002:a67:eb47:0:b0:6cc:8a90:9f88 with SMTP id ada2fe7eead31-70037cb32b6mr5316812137.16.1781002081422;
        Tue, 09 Jun 2026 03:48:01 -0700 (PDT)
X-Received: by 2002:a67:eb47:0:b0:6cc:8a90:9f88 with SMTP id ada2fe7eead31-70037cb32b6mr5316797137.16.1781002080993;
        Tue, 09 Jun 2026 03:48:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b99c11csm4466142e87.78.2026.06.09.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:47:59 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:47:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
Message-ID: <ujf53zya6hes3hkddhsmgu4wyabodnyg3zdwarxmcsoy6p5h3c@ild34ppiyvre>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H+DrBeYi c=1 sm=1 tr=0 ts=6a27ef62 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=3uhaW4yOT-U-B5mjbOMA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwMSBTYWx0ZWRfX95nWJ6u7RkjB
 QzQrlyRHEcmHnC9udEiVydX7zT7zZhpK5wl6jTu5546ed7kCGPd+cWX52yuEpc0vpt+lFP/el8g
 q+Cw11/JPw67hUAledhSc8PNB/B64/N5ERvw1LFQ89vKNOeyCEW9g2UmteFwez8zoNhxcZC6e9+
 lsw0F/u/jSnL4m4nf5F1ahjNVlXr0+Yft6fPK6mAapC7CYgM4VdIKsL+vWwQ+tZU+VyE0P29PIA
 UIlf9damz7yOHfC7I+SABYdA8Ewvv9bzJuM4ell4nba5DnLZBRFDw6XIO80+DUwvl/S4rzVi6kQ
 LVlf+7buMpAHGOEkkbYS7GVWtLUqTlGNIGA19TXvZLZI74zI6vNRKr35+TD7amjOm0npJeT2Pbc
 p0F+xBWtkX9+1SiWv6gbIyYq+P/FMu63RtS1jbBfHW2gk/dHWWcJT2u25oJ0lS3RtICtXlZC7WU
 54NdQutAoO3bImZNBKg==
X-Proofpoint-ORIG-GUID: kauMUxt3zJYanhlkO-cOVw0s1K7-Lsr0
X-Proofpoint-GUID: kauMUxt3zJYanhlkO-cOVw0s1K7-Lsr0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090101

On Tue, Jun 09, 2026 at 03:52:56PM +0530, Gaurav Kohli wrote:
> Document Qualcomm PAS remoteproc thermal mitigation properties used for
> QMI-based throttling.
> 
> Add:
> - #cooling-cells (2 or 3)
> - tmd-names (thermal mitigation device names)

Describe _why_ you are performing these changes. For example. why do we
need to handle two different cases for the #cooling-cells?

> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/remoteproc/qcom,pas-common.yaml    | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> index 4607b459131b..0d07a0750762 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> @@ -79,6 +79,20 @@ properties:
>        channels and devices related to the ADSP.
>      unevaluatedProperties: false
>  
> +  '#cooling-cells':
> +    description:
> +      Number of cooling cells; 2 for min/max cooling state and 3 when
> +      selecting a thermal mitigation device index.
> +    enum: [2, 3]
> +
> +  tmd-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      Names of the thermal mitigation devices available in remote processor
> +      subsystem.
> +    minItems: 1
> +    maxItems: 5

Missing example with these properties.

> +
>    glink-edge:
>      $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>      description:
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
