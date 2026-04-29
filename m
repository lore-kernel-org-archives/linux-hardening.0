Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B459282F08
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777438460; cv=none; b=EkAwOxUbISK1up8kemlrrsnH4CP3pjtQoIJIR+SuapI6gB7XaW++wstGWfe8vK+mBvxyN/chG/7CKeB8IHL7sr7vCtykFiwWjP1fDVhWS7TdIkSEDeVq56MdZh6/5mJMxb6QEL74htGeX4MboBEbjukZ1W411lAAtYE0AMSIcDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777438460; c=relaxed/simple;
	bh=5K6UxPFYn2KoIPnnjVPaST+asVrN3X9xuoGWglV7T64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in2wmqRHaIiORmKGPmDmhC0ISN7rZSL9sCskkNIzBFyzaTqTSXW+ltaTHvp9qVWwFH23772JKRgT5O5gRtuZjtNeTvFe1dxyUtaVVUv1hmjdq0/fBp2HB7Sub1z33eICQLsLR6juo3/OLhgFek+xSLJn/i6esvhvSl674b/O8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QDEK4rrU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HLrjyEBu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QDEK4rrU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HLrjyEBu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2uEcD831092
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 04:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HjP24Ug9r/GHXosW899GMKTKymLMpRxhQMylkjBjEOI=; b=QDEK4rrUwdfX1y9J
	Bmw2sVvfzEHUr+0OaXaIebd5IqhvoJz6Mz98vRsclO8ovGdJNykHszblE0l7zFZC
	VQy53keg9J685pbzUKxmXQz2PBZtKYBpl5WhYBi1f0wdVhNdVaB/JKzQPonnVcd/
	kU+Wp3BIxR2fxkdFRoUwCO4dx6zyROKr0bHYrNQaa9r5HixEAQVi+1KpmmGRd4DO
	1lRTg14A+iQjw77N1zgxuslhZo0OEx6CIh6h9r+m9y/3bTrD1o3FN9I3zhUhSu+S
	795KYs6uLzwix4bFeaWgyuM6cKV7Ff5dXfKpqjlNIBn7XFysydgXvRbM2Vaxg6OA
	CU66uQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0wqa3jq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 04:54:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76c2bb3149so236525a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777438458; x=1778043258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjP24Ug9r/GHXosW899GMKTKymLMpRxhQMylkjBjEOI=;
        b=HLrjyEBu5Qhmw2hctVAGf0RA11rAOSVmXghq8zxElH3C9YjdVPxBZf/7kcpHS5xIS5
         +1YyUVPUuosmN1V/lLSqbZBNZipQQUpYOQszQJrcLjj+PmdSSN38wdEuRkwrTovTMPAH
         rbjKgdICp1TAh6mp4nzADvJ+FJRmKy/rreJK4dvxqMnpef4/ALD00wz4cqdaK9lFt9uG
         fXSGE0llmy/6Sn3Y+X5q6kECUFH+jq2qxYp8XrVB5ut1CoZC675ePyDiTQliRAgqiOZ3
         LxpSMnp/um9ta4GUsjhEeHDwJFnZJTZoXx9vuTGVpCkCyb/CYWiPwYvXt1jzjyVQH6qa
         lunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777438458; x=1778043258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjP24Ug9r/GHXosW899GMKTKymLMpRxhQMylkjBjEOI=;
        b=J54yBPRmCHZScGlqt1e+sR2sQXkPMAL4LYH/F09rzhRMI04cuw8JMwmRl9uOjEsXOg
         fFh+EzIWtfPAn9NyEr6lCjva2EAYK0mvolIiLqHUoMLChuZ+MdzJmpUOGX96dP+CWI70
         M8adYePrwLeoHmurfvOPKUohEuDNUwC+uWBbZ/5JTE42ClvYjjGfqjjqYnzAxB0Bl8eX
         yyf8JAPdsjUcTa6v2mtjbs6vOY6e+8WKaDri0TikNeRllZymQClMu32iph1RzyfBUE5h
         BQSSTpBFq0bKPSyRGWXtzrxW/dCIMsen3FHrUqvKHM0yAr2gBebiO4sCyp4Erk83ZpkW
         QzMg==
X-Forwarded-Encrypted: i=1; AFNElJ/z9NC6QDOv2grDURG2akwlaYT0XfY1QbF+O75Z2+uwKpbJEZlzoDfgJT+6qzDZGc8S3RVCcHc/XrbShjCUfOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ZWtxw57FdWO6vEauc3hRrnp3n+9dCRns9RyV/KK99jEmf7Pt
	AIW9FbPbcIWXk2rO6ROrt1Fm2+xIuygfPsB/SgHD9i/vIjs+CtEg1JxoHB9v0aTjo+lBv+HMYRp
	BVlu9iNJ4EMelFPL6CpFEeLOmN4C4fy6lTdEiOFaXlhtpDuMC316Mn35snMxgzhcYB077PiQ=
X-Gm-Gg: AeBDietYZVL6UgOIJlsnMMS5gcA6cXiK3rqDtpx1FXCZQB5DK2tVJbD7zXV464X1PD1
	YV8ZnAlC5SoG9o59bDIi0DP1St+m4rUl8YetwCUMrreDIqzNwhDBIp19RBYhCLBSXHiVi5abyfy
	zWEJKak+aPF9j5NmnnlP88J0SQAVwW+Wl8A1fz/8COWdIzBq3GkqJDf1jrYdDwFWGTLdD0I+vzW
	1GEYXC5ZjVDRortHVJcA+F/AtTJ2g3uE5S2azs2rjyC4jIrSyJ9CB3QnLsbenmxwX3GFH4mDCR6
	HiOeZtwjhPKET2ntwuD/LoMNDwv6re07/J7HErFzu+SFobxzgYgex7Hh8+fnbl+m5JJxP1ixeJc
	OPPuEnl/dHPxeEFf7eUZPGeTdDg/mEHpVxGkqMjGtvx4HpPO2leh8co03YBveLajUdjUlJ7sL
X-Received: by 2002:a05:6a21:e081:b0:3a2:e8f1:b862 with SMTP id adf61e73a8af0-3a3b393ee12mr1255819637.23.1777438458225;
        Tue, 28 Apr 2026 21:54:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:e081:b0:3a2:e8f1:b862 with SMTP id adf61e73a8af0-3a3b393ee12mr1255801637.23.1777438457725;
        Tue, 28 Apr 2026 21:54:17 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd606662bsm679084a12.8.2026.04.28.21.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 21:54:17 -0700 (PDT)
Message-ID: <535dddaf-0275-4f16-b221-a593ff6f7611@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 10:24:12 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 ath-next] wifi: ath11k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260428205017.26288-1-rosenp@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260428205017.26288-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KujyG1IfYwUajmB0HnCcuWjGljvdg_l9
X-Proofpoint-ORIG-GUID: KujyG1IfYwUajmB0HnCcuWjGljvdg_l9
X-Authority-Analysis: v=2.4 cv=BfDoFLt2 c=1 sm=1 tr=0 ts=69f18efa cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA0MyBTYWx0ZWRfX5rXXON3S70H/
 jLgVepjJAA4y25Tsze2wJ5A/qqHQJVHCVlfYaj058oUaUrH25uRzNHJ1dKj1+BWKESon5WAkFKG
 puPWqBfKhbofdeluSzraCM/jzHQVjFqKXjc42TDOngDkzdUyjD31yPfrmkJp+j0ehDtp5cemfX8
 Hwx4YiubohmIwhX7WBIqhXMH6K/OFAebCZI/pPtXWDHQBrgK0c0vR1calWaz3xDzE+VRDL3kfDy
 nXkwp2CDDjHK3OwxwXYA+/MGWpEFeNZ9QyWCgqpm52dIyZdi/JdCeVv5lg06GChi57KMKiAHGK6
 aHj6bnfCvivdprX5idh+R+RHwy56BwyoRZrPsbWjVVwBI7yl5xux7DzVka9r9HaLWW5muGtU5cX
 YBt8ovnRtAfltRCXPlSSpXpb4+Y67K5tGnUIfv/IUf5Dw/5NR8jWkbo7LmKBC0MTfz82ltmKqsQ
 reXv0vQa1oHQqmBkPMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290043

On 4/29/2026 2:20 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
