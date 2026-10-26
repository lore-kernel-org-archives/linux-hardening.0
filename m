Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025287;
	b=ZHCtvbWs8uhhW8d8hLKxgP3NudKUZs9fyfqZELzTo5mqM4nwGxWdE4+KZpDoonqetYAa
	 cxwMI+5OwkF7P9Svg2vICqAozoEgfmNm1ftmc0YEiUXVnj+YvPkTKZ7DlOqtnihBhZxXW
	 ZPh37XqvvRedhSWl1vu7UwBZRKkqaNCxv3C+w9fIFILCUbCvVHfMXQcFkylQegLgmhP4O
	 tuzUPzjJQDPMWFsLMrJOOLaqV54jXSiVVlbirAlHLHc/30R7MV9IZQDnJOBDj9zv+hbzD
	 ij/WrsIe633MkxuGNwP/tzI3kFPAidpGj2FJ3eiYS4Cb+hKqIXt10dAiVCMvzlTxAuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025287;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pJz0q/j+a/Ss/3BCRCnhr/q+DN+SscbUuCywmDGVV1U=;
	b=viSFUBYbGQURlHyGjBrsVGW28kFRCTD1VELMCkFSFKOgAkNCZvijS2//izhP8/NEhesN
	 U44KQWzsM+jPIRLhfCh3hD95LfMnwvdcPiUw/5ID+mAXsoioUEwbNJYORHcGrPBDKlPXw
	 H0FF94Lbkivl9VnTGuMQVf2x1Z3GvJwncUm7rlzr6UH4Ys2fVYVLMH0oLzlf06mu5ZnDC
	 cZs35DV3c8A9OadBBBZRke2mCZs+YFRYE4JxL0hM4GgxPfmKW8TOgKmjaOAoIfB/DwRSn
	 h6Bdhl460DzaVW4OewffefG0YoLtnuWK5xvjXNCukra9Dbu0sJz+DKVhcwlM5PahiTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M6OOEvqt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IIwekA51;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D11606A31B
	for <linux-hardening@vger.kernel.org>; Mon, 26 Oct 2026 14:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60D11606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M6OOEvqt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IIwekA51
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAt9w53049897
	for <linux-hardening@vger.kernel.org>; Mon, 26 Oct 2026 14:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pJz0q/j+a/Ss/3BCRCnhr/q+DN+SscbUuCywmDGVV1U=; b=M6OOEvqt6/cOKucb
	Q5OZwST7lwdGWa0CSwaN9mN3wvTl4izer2/55/0Yxz5XAKBB5yBCOXNb39Z/7Q0e
	Shrps8jXSHZ+7swMbp5qt6OSKKGfg5x7OErAi+hO33NTjwcmKfBvrA9BWE1NeA3T
	4WfViqkG2Wd1IU2zk9xVpVFVcYuu/waF9Zrij3BRqS9rSqU0cxSG5Pgc/xdyg4iB
	eaflTv65SmyOjzkhMl4SuTkIJVc2Jft3XJFXdyrNnrPmFSoZFAnNgQhg6TqbO89L
	N+196sbu32KAvWsTrDFHvkLRxeARlTe5X6RTiA/ogPIb91kRH93+xhkZe/xp795N
	Uz4tSg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvddaktt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 26 Oct 2026 14:34:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93caf7856ffso734055885a.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Oct 2026 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793025280; x=1793630080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJz0q/j+a/Ss/3BCRCnhr/q+DN+SscbUuCywmDGVV1U=;
        b=IIwekA51XcYa1+QvoNklFdWCHCbwv/GmjLj3fpRPChYgpz0DwpQ4YdKACmOc9V8DXJ
         9Qc3d9aW5iPABXEldKyA+D5o3BfdqQYwAiWylv1andKBUN2rS3//ezB4q9V0PAUoAn/e
         0HzVv4A+/qDEOALDJFjRbWKTX+E5aWsOoslOCuiGeAgroReaocpheHHPLcIyOLXHLyKA
         Pwc4yVJ1BPJZ1xAWnE/FK7jB6yAQGiDabuRbtPi1K/WjED1uDvMRmC0p0j2VDZ9BgOLl
         gUADqkr6ylDYXllwRdkLtR3M2UfEa3DMLYoFwgS2upkLtRoYyzwa3xEGmYUro9JTuRyr
         H4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025280; x=1793630080;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJz0q/j+a/Ss/3BCRCnhr/q+DN+SscbUuCywmDGVV1U=;
        b=LnHCUA+62l+t21oG9TLBh2otpnPQ9o3vM7dMNFxKTdk1qEv9qH9/idTC4RPnfJ0J9b
         dMmZp8rkfzoGxT/FQj6H8ttZWufe877/sHQ1WwRfYN0aCZkUUwZvULhfwgxmMtjcxhlx
         2N1dMpijJh/I0bVhaVhBvaCaxAFpd0MzCTpaaqPFpAk776yMxazEHTAruGbGd9YnweYm
         998gxHdsLyFPUmi9HrlEjhAdHHofNF3aYfIxW7VOb73NG4mCY7QFNh8SFx9wUhR4BV44
         TrIMNu/4XtR2C5fHS2ZlN/WBTDOpv4kYFOynyXAmiuvbWnoIa7TnX5tAuBi2LdpXshdT
         wzRA==
X-Forwarded-Encrypted: i=1; AKwUvByVANEr/EhWRwc1KCR+Vu9et0q9TMaDfe441gf96bQmNRh7A+MbJttdwkYG/Knbzqz+ocTumkCZ55wNiX1RgEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaahawTfO/GJApJW17fJZd1C/1kSU4VnI0xsbJmS30Rnt6+jQV
	61cnTd2QIfZxNB8f/gJSvJPR4iARjNCViYDWm3NTI3IbqyUlzsJd2BCnVxGcEHSzhEKp6w0pMmv
	lagEdlaV39LAPQJqZ74cdeEC4+FZefGLi+YCaPTbT7dmJPGI43PPxS0eXGZfOKkw5h3HObmU=
X-Gm-Gg: AYBFou3v78tPQkzXMX1QEKtiVBH5VY3fDPR7LBsAu2xm5T9AzfG1QOYVqfd1HUUxkNm
	VYtIoyF9w2oh00CSirFF3RI3QcEzSQFZgHe6hoXsu8fpvFHCpghIAwviRPTE64hRmSrzeLdVmDR
	L1RAvr7M1uaIXikvwCDe6aoHEEPdtPo/o0sMfEm2PL4IoECzVl7V1Ndq5HoRBhG5WTEjsFPBf7M
	5FII+EAp/HbaAwAEKubVvkI8oAdESMFZR1APArs80vdwCeCgYw9eE4wjvPVhsxXNvAxrBQpAjyI
	6bnm0bQ5rFkYkC0G6zs0q1CZs8pfl0ngDAry9n1v37otaGlhXH/wWXntcBWfxGhWr3rkS8MScsQ
	yqyWvxFI8r6Xd+0NImww=
X-Received: by 2002:a05:620a:f06:b0:93f:3978:481a with SMTP id af79cd13be357-940ef90a7a2mr997538485a.51.1793025279553;
        Mon, 26 Oct 2026 07:34:39 -0700 (PDT)
X-Received: by 2002:a05:620a:f06:b0:93f:3978:481a with SMTP id af79cd13be357-940ef90a7a2mr997532885a.51.1793025279058;
        Mon, 26 Oct 2026 07:34:39 -0700 (PDT)
Received: from [10.40.99.45] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b445984207sm3552132a12.22.2026.10.26.07.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 07:34:37 -0700 (PDT)
Message-ID: <bbed82ed-97aa-4b12-a8ce-a4f21ed60595@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 15:34:35 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH v11 1/9] media: qcom: camss: Add V4L2 meta format for
 CAMSS ISP parameters
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
 <20261023-camss-isp-ope-v11-1-0c2937195298@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20261023-camss-isp-ope-v11-1-0c2937195298@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qPzoiNYfsGcUst--cH0GIxurXbVDO-_x
X-Proofpoint-GUID: qPzoiNYfsGcUst--cH0GIxurXbVDO-_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NyBTYWx0ZWRfX4/62lKvuTQbm
 8L8nGqk7tUOnAzbTRopmeWe0zBnMbv7UryftNjkmQVLzBkqRTBokcKjJR43gzvjVX25H6SJJf8J
 rgFnpijxZRubZ04JwL+F21exudfvO4v0CreQhwfPpbzwO6fLIy3goy5Zp5op9G1997pl0Hmr2a+
 lG6zpoVIjkOk48kRYLVTuHYI9pRKaYkanmvSHXg0yFZfJUKg1OUJDAnZcs8R6nATK5++kGdqPLW
 7Q+OpU92ah/IFiq5kCmENELkz1pnT56yZBh9BoIvRCFbJpzsavAccRWbaZAgsUU27CUq6EJxRpl
 mD7DjlSgIjKnWQwLYK/aQak1KyeOfZn2YHp4BPqcZId3x4PohJjrg4Rde3TYY58HNkukvEp1Q5a
 MVa6UZll4RWYg5/OKR4VK3MzjhN0wxjvb49jYDAa8zUQ5KWxBMg61S26+q7eu7i+xyGNOj39p++
 JyPjp5cohUPK29mNuJg==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf6500 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=cfCy20KhcoV1EizUSHcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NyBTYWx0ZWRfX14J/31kqDKHd
 WwU9qUnEFZ+xRrt1Dl962Zm515/DP324T81MlzzTNbDQGtAGDcDzXuam8naAqxEpuLrIJuFsMUx
 ZTvbilrdbxeks63fqVRQo11SVHBWKlk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260057

Hi,

On 23-Oct-26 5:09 PM, Loic Poulain wrote:
> Add a V4L2 meta format code (V4L2_META_FMT_QCOM_ISP_PARAMS) for the
> Qualcomm CAMSS ISP parameter buffer. This format is used by the params
> video node exposed by CAMSS offline ISP drivers (e.g. OPE) to carry
> ISP tuning data such as white balance, color correction and chroma
> enhancement settings.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans


> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
>  include/uapi/linux/videodev2.h       | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 17ba1ae707355a134047de646f61fcc2d1512d4c..cef1593c1835070f7b34a8b8c860738fb77f533a 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1471,6 +1471,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
>  	case V4L2_META_FMT_MALI_C55_PARAMS:	descr = "ARM Mali-C55 ISP Parameters"; break;
>  	case V4L2_META_FMT_MALI_C55_STATS:	descr = "ARM Mali-C55 ISP 3A Statistics"; break;
> +	case V4L2_META_FMT_QCOM_ISP_PARAMS:	descr = "Qualcomm CAMSS ISP Parameters"; break;
>  	case V4L2_META_FMT_RPPX1_PARAMS:	descr = "Dreamchip RPP-X1 ISP Parameters"; break;
>  	case V4L2_META_FMT_RPPX1_STATS:	descr = "Dreamchip RPP-X1 ISP Statistics"; break;
>  	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 5373dba640fae3d19247ab1c74ba336e05dc0fe0..70208a9443d8ade569f130e2fc3d6beebab6b636 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -893,6 +893,9 @@ struct v4l2_pix_format {
>  #define V4L2_META_FMT_RPPX1_PARAMS	v4l2_fourcc('D', 'R', '1', 'P') /* Dreamchip RPP-X1 Parameters */
>  #define V4L2_META_FMT_RPPX1_STATS	v4l2_fourcc('D', 'R', '1', 'S') /* Dreamchip RPP-X1 Statistics */
>  
> +/* Vendor specific - used for Qualcomm CAMSS ISP */
> +#define V4L2_META_FMT_QCOM_ISP_PARAMS	v4l2_fourcc('Q', 'C', 'I', 'P') /* Qualcomm CAMSS ISP Parameters */
> +
>  #ifdef __KERNEL__
>  /*
>   * Line-based metadata formats. Remember to update v4l_fill_fmtdesc() when
> 

